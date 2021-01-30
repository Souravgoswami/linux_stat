VALUE uptime_f(VALUE obj) {
	FILE *f = fopen("/proc/uptime", "r") ;
	if (!f) return Qnil ;

	double up_f ;
	if (fscanf(f, "%lf", &up_f) != 1) return Qnil ;
	fclose(f) ;

	return DBL2NUM(up_f) ;
}
