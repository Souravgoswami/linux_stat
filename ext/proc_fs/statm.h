#define PAGESIZE sysconf(_SC_PAGESIZE)

VALUE statm(VALUE obj, VALUE pid) {
	char _path[22] ;
	sprintf(_path, "/proc/%lu/statm", FIX2UINT(pid)) ;

	FILE *f = fopen(_path, "r") ;

	VALUE hash = rb_hash_new() ;

	if (!f) return hash ;

	unsigned int _virtual, resident, shared ;
	if (fscanf(f, "%u %u %u", &_virtual, &resident, &shared) != 3) return hash ;
	int pagesize = PAGESIZE ;

	_virtual *= pagesize ;
	resident *= pagesize ;
	shared *= pagesize ;

	unsigned int v = resident - shared ;

	rb_hash_aset(hash, ID2SYM(rb_intern("memory")), UINT2NUM(v)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("virtual_memory")), UINT2NUM(_virtual)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("resident_memory")), UINT2NUM(resident)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("shared_memory")), UINT2NUM(shared)) ;

	return hash ;
}

VALUE statm_virtual(VALUE obj, VALUE pid) {
	char _path[22] ;
	sprintf(_path, "/proc/%lu/statm", FIX2UINT(pid)) ;

	FILE *f = fopen(_path, "r") ;
	VALUE hash = rb_hash_new() ;

	if (!f) return hash ;
	unsigned int _virtual ;
	if (fscanf(f, "%u", &_virtual) != 1) return Qnil ;

	int pagesize = PAGESIZE ;
	return UINT2NUM(_virtual * pagesize) ;
}

VALUE statm_resident(VALUE obj, VALUE pid) {
	char _path[22] ;
	sprintf(_path, "/proc/%lu/statm", FIX2UINT(pid)) ;

	FILE *f = fopen(_path, "r") ;
	VALUE hash = rb_hash_new() ;

	if (!f) return hash ;
	unsigned int resident ;
	if (fscanf(f, "%*u %u", &resident) != 1) return Qnil ;

	int pagesize = PAGESIZE ;
	return UINT2NUM(resident * pagesize) ;
}

VALUE statm_shared(VALUE obj, VALUE pid) {
	char _path[22] ;
	sprintf(_path, "/proc/%lu/statm", FIX2UINT(pid)) ;

	FILE *f = fopen(_path, "r") ;
	VALUE hash = rb_hash_new() ;

	if (!f) return hash ;
	unsigned int shared ;
	if (fscanf(f, "%*u %*u %u", &shared) != 1) return Qnil ;

	int pagesize = PAGESIZE ;
	return UINT2NUM(shared * pagesize) ;
}

VALUE statm_memory(VALUE obj, VALUE pid) {
	char _path[22] ;
	sprintf(_path, "/proc/%lu/statm", FIX2UINT(pid)) ;

	FILE *f = fopen(_path, "r") ;

	if (!f) return Qnil ;

	unsigned int resident, shared ;
	if (fscanf(f, "%*u %u %u", &resident, &shared) != 2) return Qnil ;

	unsigned int v = (resident - shared) * PAGESIZE ;
	return UINT2NUM(v) ;
}
