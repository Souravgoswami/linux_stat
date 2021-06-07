VALUE uptime_f(volatile VALUE obj) {
	FILE *f = fopen("/proc/uptime", "r") ;
	if (!f) return Qnil ;

	double up_f ;
	char status = fscanf(f, "%lf", &up_f) ;
	fclose(f) ;

	if (status != 1) return Qnil ;

	return DBL2NUM(up_f) ;
}
