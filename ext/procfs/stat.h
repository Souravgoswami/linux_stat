VALUE ps_state(VALUE obj, VALUE pid) {
	int _pid = FIX2INT(pid) ;
	if (_pid < 0) return rb_str_new_cstr("") ;

	char _path[22] ;
	sprintf(_path, "/proc/%d/stat", _pid) ;

	FILE *f = fopen(_path, "r") ;
	if (!f) return rb_str_new_cstr("") ;

	char _s[1] ;

	char status = fscanf(f, "%*llu (%*[^)]%*[)] %s", _s) ;
	fclose(f) ;

	if (status != 1) return rb_str_new_cstr("") ;
	return rb_str_new_cstr(_s) ;
}

VALUE ps_times(VALUE obj, VALUE pid) {
	int _pid = FIX2INT(pid) ;
	if (_pid < 0) return Qnil ;

	char _path[22] ;
	sprintf(_path, "/proc/%d/stat", _pid) ;

	FILE *f = fopen(_path, "r") ;
	if (!f) return Qnil ;

	unsigned long utime, stime ;

	char status = fscanf(f, "%*llu (%*[^)]%*[)] %*c %*d %*d %*d %*d %*d %*u %*lu %*lu %*lu %*lu %lu %lu", &utime, &stime) ;
	fclose(f) ;

	if (status != 2) return Qnil ;
	double total_time = (utime + stime) / (float)sysconf(_SC_CLK_TCK);

	return DBL2NUM(total_time) ;
}

VALUE ps_stat(VALUE obj, VALUE pid) {
	int _pid = FIX2INT(pid) ;
	if (_pid < 0) return rb_str_new_cstr("") ;

	char _path[22] ;
	sprintf(_path, "/proc/%d/stat", _pid) ;

	FILE *f = fopen(_path, "r") ;

	if (!f)
		return rb_ary_new() ;

	// ?? JEEZ !!
	// We need to do this because the datatypes are different
	// Can't make an array like Ruby out of String
	// This is hard to write and check, but tested, and works.
	//
	// For this struct,
	// follow https://man7.org/linux/man-pages/man5/proc.5.html
	int ppid, pgrp, session, tty_nr, tpgid ;
	unsigned flags ;
	long unsigned minflt, cminflt, majflt, cmajflt, utime, stime ;
	long cutime, cstime, priority, nice, num_threads, itrealvalue ;
	long long unsigned starttime ;
	long unsigned vsize ;
	long rss ;
	long unsigned rsslim, startcode, endcode, startstack, kstkesp, kstkeip ;
	long unsigned signal, blocked, sigignore, sigcatch, wchan, nswap, cnswap ;
	int exit_signal, processor ;
	unsigned rt_priority, policy ;
	long long unsigned delayacct_blkio_ticks ;
	long unsigned guest_time ;
	long cguest_time ;
	long unsigned start_data, end_data, start_brk, arg_start, arg_end ;
	long unsigned env_start, env_end ;
	int exit_code ;

	char status = fscanf(
		f, "%*llu (%*[^)]%*[)] %*c "
		"%d %d %d %d %d %u "
		"%lu %lu %lu %lu %lu %lu "
		"%ld %ld %ld %ld %ld %ld "
		"%llu %lu %ld %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu "
		"%d %d %u %u %llu %lu %ld %lu %lu %lu %lu %lu %lu %lu %d", &ppid, &pgrp,
		&session, &tty_nr, &tpgid, &flags, &minflt, &cminflt, &majflt, &cmajflt, &utime, &stime, &cutime,
		&cstime, &priority, &nice, &num_threads, &itrealvalue, &starttime, &vsize, &rss, &rsslim,
		&startcode, &endcode, &startstack, &kstkesp, &kstkeip, &signal, &blocked, &sigignore,
		&sigcatch, &wchan, &nswap, &cnswap, &exit_signal, &processor, &rt_priority, &policy,
		&delayacct_blkio_ticks, &guest_time, &cguest_time, &start_data, &end_data,
		&start_brk, &arg_start, &arg_end, &env_start, &env_end, &exit_code
	) ;

	fclose(f) ;

	if (status != 49)
		return rb_ary_new() ;

	return rb_ary_new_from_args(49,
	INT2NUM(ppid), INT2NUM(pgrp), INT2NUM(session), INT2NUM(tty_nr), INT2NUM(tpgid),
	UINT2NUM(flags),
	ULONG2NUM(minflt), ULONG2NUM(cminflt), ULONG2NUM(majflt), ULONG2NUM(cmajflt),
	ULONG2NUM(utime), ULONG2NUM(stime),
	LONG2NUM(cutime), LONG2NUM(cstime), LONG2NUM(priority),
	LONG2NUM(nice), LONG2NUM(num_threads), LONG2NUM(itrealvalue),
	ULL2NUM(starttime),
	ULONG2NUM(vsize),
	LONG2NUM(rss),
	ULONG2NUM(rsslim), ULONG2NUM(startcode), ULONG2NUM(endcode),
	ULONG2NUM(startstack), ULONG2NUM(kstkesp), ULONG2NUM(kstkeip),
	ULONG2NUM(signal), ULONG2NUM(blocked), ULONG2NUM(sigignore), ULONG2NUM(sigcatch),
	ULONG2NUM(wchan), ULONG2NUM(nswap), ULONG2NUM(cnswap),
	INT2NUM(exit_signal), INT2NUM(processor),
	UINT2NUM(rt_priority), UINT2NUM(policy),
	ULL2NUM(delayacct_blkio_ticks), ULONG2NUM(guest_time), LONG2NUM(cguest_time), ULONG2NUM(start_data),
	ULONG2NUM(end_data), ULONG2NUM(start_brk), ULONG2NUM(arg_start), ULONG2NUM(arg_end),
	ULONG2NUM(env_start), ULONG2NUM(env_end),
	INT2NUM(exit_code)
	) ;
}
