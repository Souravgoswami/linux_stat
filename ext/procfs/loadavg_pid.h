VALUE last_pid(volatile VALUE obj) {
	FILE *f = fopen("/proc/loadavg", "r") ;
	if (!f) return Qnil ;

	unsigned long long _last_pid ;
	char status = fscanf(f, "%*f %*f %*f %*s %llu", &_last_pid) ;
	fclose(f) ;
	if (status != 1) return Qnil ;

	return ULL2NUM(_last_pid) ;
}
