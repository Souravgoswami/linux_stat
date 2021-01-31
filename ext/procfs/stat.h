VALUE ps_state(VALUE obj, VALUE pid) {
	char _path[22] ;
	sprintf(_path, "/proc/%lu/stat", FIX2UINT(pid)) ;

	FILE *f = fopen(_path, "r") ;
	if (!f) return rb_str_new_cstr("") ;

	char _s[1] ;

	char status = fscanf(f, "%*s (%*16[^)]) %s", _s) ;
	fclose(f) ;

	if (status != 1) return rb_str_new_cstr("") ;
	return rb_str_new_cstr(_s) ;
}

VALUE ps_stat(VALUE obj, VALUE pid) {
	char _path[22] ;
	sprintf(_path, "/proc/%lu/stat", FIX2UINT(pid)) ;
	FILE *f = fopen(_path, "r") ;

	if (!f) return rb_str_new_cstr("") ;

	unsigned int chunk = 64 ;

	char status = fscanf(f, "%*s (%*16[^)]) ") ;
	if (status != 0) return rb_str_new_cstr("") ;

	unsigned int n = 0, cur = chunk ;
	char *s = malloc(chunk) ;
	char c ;

	while((c = fgetc(f)) != EOF) {
		if (n > cur) {
			cur += chunk ;
			s = realloc(s, cur) ;
			if (cur > 2048) break ;
		}

		s[n++] = c ;
	}
	fclose(f) ;

	if (n > 0) {
		s[n - 1] = '\0' ;
	} else {
		s[0] = '\0' ;
	}

	VALUE ret = rb_str_new_cstr(s) ;
	free(s) ;

	return ret ;
}
