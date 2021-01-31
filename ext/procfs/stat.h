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
	VALUE ary = rb_ary_new() ;

	FILE *f = fopen(_path, "r") ;

	if (!f)
		return ary ;

	unsigned int buf_size = 1000 ;

	char s[buf_size] ;
	char status = fscanf(f, "%*s (%*16[^)]) %*s ") ;

	if (status != 0)
		return ary ;

	if(fgets(s, buf_size, f) == NULL)
		return ary ;

	char *token = strtok(s, " ") ;
	unsigned long long converted_int ;

	while (token != NULL) {
		converted_int = strtoull(token, NULL, 10) ;
		rb_ary_push(ary, ULL2NUM(converted_int)) ;

		token = strtok(NULL, " ") ;
	}

	return ary ;
}
