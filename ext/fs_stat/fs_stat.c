#include <sys/statvfs.h>
#include "ruby.h"

#if defined(__GNUC__) && !defined(__clang__) && !defined(__INTEL_COMPILER)
	#pragma GCC optimize ("O3")
	#pragma GCC diagnostic warning "-Wall"
#elif defined(__clang__)
	#pragma clang optimize on
	#pragma clang diagnostic warning "-Wall"
#elif defined(__INTEL_COMPILER)
	#pragma intel optimization_level 3
#endif

static VALUE statfs(VALUE obj, VALUE dir) {
	struct statvfs buf ;
	char *d = StringValuePtr(dir) ;
	VALUE hash = rb_hash_new() ;

	if(statvfs(d, &buf) < 0) return hash ;

	rb_hash_aset(hash, ID2SYM(rb_intern("block_size")), INT2FIX(buf.f_bsize)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("fragment_size")), INT2NUM(buf.f_frsize)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("blocks")), INT2NUM(buf.f_blocks)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("block_free")), INT2NUM(buf.f_bfree)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("block_avail_unpriv")), INT2NUM(buf.f_bavail)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("inodes")), INT2NUM(buf.f_files)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("free_inodes")), INT2NUM(buf.f_ffree)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("filesystem_id")), INT2NUM(buf.f_fsid)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("mount_flags")), INT2NUM(buf.f_flag)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("max_filename_length")), INT2NUM(buf.f_namemax)) ;

	return hash ;
}

void Init_fs_stat() {
	VALUE _linux_stat = rb_define_module("LinuxStat") ;
	VALUE fs = rb_define_module_under(_linux_stat, "FS") ;
	rb_define_module_function(fs, "stat", statfs, 1) ;
}
