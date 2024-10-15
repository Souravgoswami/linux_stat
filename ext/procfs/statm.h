#define PAGESIZE sysconf(_SC_PAGESIZE)

static VALUE statm(VALUE obj, VALUE pid) {
	VALUE hash = rb_hash_new() ;

	int _pid = FIX2INT(pid) ;
	if (_pid < 0) return hash ;

	char _path[22] ;
	sprintf(_path, "/proc/%d/statm", _pid) ;

	FILE *f = fopen(_path, "r") ;
	if (!f) return hash ;

	unsigned int _virtual, resident, shared ;
	char status = fscanf(f, "%u %u %u", &_virtual, &resident, &shared) ;
	fclose(f) ;

	if (status != 3) return hash ;

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

static VALUE statm_virtual(VALUE obj, VALUE pid) {
	int _pid = FIX2INT(pid) ;
	if (_pid < 0) return Qnil ;

	char _path[22] ;
	sprintf(_path, "/proc/%d/statm", _pid) ;

	FILE *f = fopen(_path, "r") ;
	if (!f) return Qnil ;

	unsigned int _virtual ;
	char status = fscanf(f, "%u", &_virtual) ;
	fclose(f) ;

	if (status != 1) return Qnil ;
	return UINT2NUM(_virtual * PAGESIZE) ;
}

static VALUE statm_resident(VALUE obj, VALUE pid) {
	int _pid = FIX2INT(pid) ;
	if (_pid < 0) return Qnil ;

	char _path[22] ;
	sprintf(_path, "/proc/%d/statm", _pid) ;

	FILE *f = fopen(_path, "r") ;
	if (!f) return Qnil ;

	unsigned int resident ;
	char status = fscanf(f, "%*u %u", &resident) ;
	fclose(f) ;

	if (status != 1) return Qnil ;
	return UINT2NUM(resident * PAGESIZE) ;
}

static VALUE statm_shared(VALUE obj, VALUE pid) {
	int _pid = FIX2INT(pid) ;
	if (_pid < 0) return Qnil ;

	char _path[22] ;
	sprintf(_path, "/proc/%d/statm", _pid) ;

	FILE *f = fopen(_path, "r") ;
	if (!f) return Qnil ;

	unsigned int shared ;
	char status = fscanf(f, "%*u %*u %u", &shared) ;
	fclose(f) ;

	if (status != 1) return Qnil ;
	return UINT2NUM(shared * PAGESIZE) ;
}

static VALUE statm_memory(VALUE obj, VALUE pid) {
	int _pid = FIX2INT(pid) ;
	if (_pid < 0) return Qnil ;

	char _path[22] ;
	sprintf(_path, "/proc/%d/statm", _pid) ;

	FILE *f = fopen(_path, "r") ;
	if (!f) return Qnil ;

	unsigned int resident, shared ;
	char status = fscanf(f, "%*u %u %u", &resident, &shared) ;
	fclose(f) ;

	if (status != 2) return Qnil ;

	unsigned int v = (resident - shared) * PAGESIZE ;
	return UINT2NUM(v) ;
}
