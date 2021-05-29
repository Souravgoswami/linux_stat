#include <sys/statvfs.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <linux/fs.h>
#include <unistd.h>

#include "ruby.h"
#include "sector_size.h"
#include "disk_stat.h"

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

	rb_hash_aset(hash, ID2SYM(rb_intern("block_size")), INT2FIX((unsigned int)buf.f_bsize)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("fragment_size")), ULL2NUM((unsigned long long)buf.f_frsize)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("blocks")), ULL2NUM((unsigned long long)buf.f_blocks)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("block_free")), ULL2NUM((unsigned long long)buf.f_bfree)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("block_avail_unpriv")), ULL2NUM((unsigned long long)buf.f_bavail)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("inodes")), ULL2NUM((unsigned long long)buf.f_files)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("free_inodes")), ULL2NUM((unsigned long long)buf.f_ffree)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("filesystem_id")), ULL2NUM((unsigned long long)buf.f_fsid)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("mount_flags")), ULL2NUM((unsigned long long)buf.f_flag)) ;
	rb_hash_aset(hash, ID2SYM(rb_intern("max_filename_length")), ULL2NUM((unsigned long long)buf.f_namemax)) ;

	return hash ;
}

void Init_fs_stat() {
	VALUE _linux_stat = rb_define_module("LinuxStat") ;
	VALUE fs = rb_define_module_under(_linux_stat, "FS") ;
	rb_define_module_function(fs, "stat", statfs, 1) ;
	rb_define_module_function(fs, "sectors", getSectorSize, 1) ;
	rb_define_module_function(fs, "total_io", getDiskStats, 1) ;
}
