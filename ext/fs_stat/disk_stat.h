static VALUE getDiskStats (volatile VALUE obj, volatile VALUE path) {
	FILE *file = fopen("/proc/diskstats", "r") ;
	if(!file) return rb_ary_new() ;

	char lines[120] ;
	unsigned long long read, write ;
	char *p = StringValuePtr(path) ;

	while(fgets(lines, 119, file)) {
		sscanf(lines, "%*s %*s %s %*s %*s %llu %*s %*s %*s %llu", lines, &read, &write) ;

		if(strcmp(lines, p) == 0) {
			fclose(file) ;

			return rb_ary_new_from_args(
				2,
				ULL2NUM(read),
				ULL2NUM(write)
			) ;
		}
	}

	fclose(file) ;
	return rb_ary_new() ;
}
