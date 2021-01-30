VALUE last_pid(VALUE obj) {
	FILE *f = fopen("/proc/loadavg", "r") ;
	if (!f) return Qnil ;

	unsigned long long _last_pid ;
	if (fscanf(f, "%*f %*f %*f %*d/%*d %llu", &_last_pid) != 1) return Qnil ;
	fclose(f) ;

	return ULL2NUM(_last_pid) ;
}
