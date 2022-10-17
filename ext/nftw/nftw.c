#define _GNU_SOURCE 1

#include <ftw.h>
#include <stdint.h>

#include "ruby.h"

VALUE LIST ;
intmax_t TOTAL_FILES ;

static int storeInfo(const char *fpath, const struct stat *sb, int tflag, struct FTW *ftwbuf) {
		VALUE hash = rb_hash_new() ;

		// Raw type flag
		 VALUE typeFlag = (tflag == FTW_D)   ? ID2SYM(rb_intern("FTW_D"))   : (tflag == FTW_DNR) ? ID2SYM(rb_intern("FTW_DNR")) :
											(tflag == FTW_DP)  ? ID2SYM(rb_intern("FTW_DP"))  : (tflag == FTW_F)   ? ID2SYM(rb_intern("FTW_F"))   :
											(tflag == FTW_NS)  ? ID2SYM(rb_intern("FTW_NS"))  : (tflag == FTW_SL)  ? ID2SYM(rb_intern("FTW_SL"))  :
											(tflag == FTW_SLN) ? ID2SYM(rb_intern("FTW_SLN")) : Qnil ;

		rb_hash_aset(
			hash,
			ID2SYM(rb_intern("type_flag")),
			typeFlag
		);

		// Depth
		rb_hash_aset(
			hash,
			ID2SYM(rb_intern("level")),
			INT2FIX(ftwbuf -> level)
		);

		// Size
		rb_hash_aset(
			hash,
			ID2SYM(rb_intern("st_size")),
			INT2FIX((intmax_t) sb->st_size)
		);

		// Path
		rb_hash_aset(
			hash,
			ID2SYM(rb_intern("file_path")),
			rb_str_new_cstr(fpath)
		);

		// Base
		rb_hash_aset(
			hash,
			ID2SYM(rb_intern("basename")),
			INT2FIX(ftwbuf->base)
		);

		// Path without base
		rb_hash_aset(
			hash,
			ID2SYM(rb_intern("base")),
			rb_str_new_cstr(fpath + ftwbuf->base)
		);

		rb_ary_push(LIST, hash) ;
		return 0 ;
}

static int storeFilesInfo(const char *fpath, const struct stat *sb, int tflag, struct FTW *ftwbuf) {
		if (!(tflag == FTW_F || tflag == FTW_SL || tflag == FTW_SLN))
			return 0 ;

		VALUE hash = rb_hash_new() ;

		// Raw type flag
		 VALUE typeFlag = (tflag == FTW_F)   ? ID2SYM(rb_intern("FTW_F"))   :
							(tflag == FTW_SL)  ? ID2SYM(rb_intern("FTW_SL"))  :
							(tflag == FTW_SLN) ? ID2SYM(rb_intern("FTW_SLN")) : Qnil ;

		rb_hash_aset(
			hash,
			ID2SYM(rb_intern("type_flag")),
			typeFlag
		);

		// Depth
		rb_hash_aset(
			hash,
			ID2SYM(rb_intern("level")),
			INT2FIX(ftwbuf -> level)
		);

		// Size
		rb_hash_aset(
			hash,
			ID2SYM(rb_intern("st_size")),
			INT2FIX((intmax_t) sb->st_size)
		);

		// Path
		rb_hash_aset(
			hash,
			ID2SYM(rb_intern("file_path")),
			rb_str_new_cstr(fpath)
		);

		// Base
		rb_hash_aset(
			hash,
			ID2SYM(rb_intern("basename")),
			INT2FIX(ftwbuf->base)
		);

		// Path without base
		rb_hash_aset(
			hash,
			ID2SYM(rb_intern("base")),
			rb_str_new_cstr(fpath + ftwbuf->base)
		);

		rb_ary_push(LIST, hash) ;
		return 0 ;
}

static int countChildren(const char *fpath, const struct stat *sb, int tflag, struct FTW *ftwbuf) {
		TOTAL_FILES++ ;
		return 0 ;
}

static int countFiles(const char *fpath, const struct stat *sb, int tflag, struct FTW *ftwbuf) {
		if(tflag == FTW_F || tflag == FTW_SL || tflag == FTW_SLN) TOTAL_FILES++ ;
		return 0 ;
}

static int countDirectories(const char *fpath, const struct stat *sb, int tflag, struct FTW *ftwbuf) {
		if(tflag == FTW_D || tflag == FTW_DNR) TOTAL_FILES++ ;
		return 0 ;
}

VALUE getChildrenCount(volatile VALUE obj, volatile VALUE rb_dir, volatile VALUE rb_flags) {
		TOTAL_FILES = 0 ;
		rb_ary_clear(LIST) ;

		int flags = FIX2INT(rb_flags);
		char *dir = StringValuePtr(rb_dir) ;
		VALUE returnValue = rb_hash_new() ;

		if (nftw(dir, countChildren, 20, flags) == -1) {
			rb_hash_aset(returnValue, ID2SYM(rb_intern("value")), ULL2NUM(TOTAL_FILES)) ;
			rb_hash_aset(returnValue, ID2SYM(rb_intern("error")), Qtrue) ;
		} else {
			rb_hash_aset(returnValue, ID2SYM(rb_intern("value")), ULL2NUM(TOTAL_FILES)) ;
			rb_hash_aset(returnValue, ID2SYM(rb_intern("error")), Qfalse) ;
		}

		return returnValue ;
}

VALUE getFilesCount(volatile VALUE obj, volatile VALUE rb_dir) {
		TOTAL_FILES = 0 ;

		int flags = FTW_PHYS ;
		#ifdef FTW_CONTINUE
			flags |= FTW_CONTINUE ;
		#endif

		char *dir = StringValuePtr(rb_dir) ;
		VALUE returnValue = rb_hash_new() ;

		if (nftw(dir, countFiles, 20, flags) == -1)
			return Qnil ;

		return ULL2NUM(TOTAL_FILES) ;
}

VALUE getDirectoriesCount(volatile VALUE obj, volatile VALUE rb_dir) {
		TOTAL_FILES = 0 ;

		char *dir = StringValuePtr(rb_dir) ;
		VALUE returnValue = rb_hash_new() ;

		int flags = FTW_PHYS ;
		#ifdef FTW_CONTINUE
			flags |= FTW_CONTINUE ;
		#endif

		if (nftw(dir, countDirectories, 20, flags) == -1)
			return Qnil ;

		return ULL2NUM(--TOTAL_FILES) ;
}

VALUE getStat(volatile VALUE obj, volatile VALUE rb_dir, volatile VALUE rb_flags) {
		rb_ary_clear(LIST) ;

		int flags = FIX2INT(rb_flags);
		char *dir = StringValuePtr(rb_dir) ;
		VALUE returnValue = rb_hash_new() ;

		if (nftw(dir, storeInfo, 20, flags) == -1) {
			rb_hash_aset(returnValue, ID2SYM(rb_intern("value")), LIST) ;
			rb_hash_aset(returnValue, ID2SYM(rb_intern("error")), Qtrue) ;
		} else {
			rb_hash_aset(returnValue, ID2SYM(rb_intern("value")), LIST) ;
			rb_hash_aset(returnValue, ID2SYM(rb_intern("error")), Qfalse) ;
		}

		return returnValue ;
}

VALUE getFilesStat(volatile VALUE obj, volatile VALUE rb_dir) {
		rb_ary_clear(LIST) ;

		int flags = FTW_PHYS ;
		#ifdef FTW_CONTINUE
			flags |= FTW_CONTINUE ;
		#endif

		char *dir = StringValuePtr(rb_dir) ;
		VALUE returnValue = rb_hash_new() ;

		if (nftw(dir, storeFilesInfo, 20, flags) == -1) {
			rb_hash_aset(returnValue, ID2SYM(rb_intern("value")), LIST) ;
			rb_hash_aset(returnValue, ID2SYM(rb_intern("error")), Qtrue) ;
		} else {
			rb_hash_aset(returnValue, ID2SYM(rb_intern("value")), LIST) ;
			rb_hash_aset(returnValue, ID2SYM(rb_intern("error")), Qfalse) ;
		}

		return returnValue ;
}

// Return all flags as hash
VALUE flags_hash(VALUE nftw) {
		VALUE all_flags = rb_hash_new() ;
		rb_ary_clear(LIST) ;

		// All Flags
		VALUE flags = rb_hash_new() ;
		#ifdef FTW_ACTIONRETVAL
			rb_hash_aset(flags, ID2SYM(rb_intern("FTW_ACTIONRETVAL")), INT2FIX(FTW_ACTIONRETVAL)) ;
		#endif

		rb_hash_aset(flags, ID2SYM(rb_intern("FTW_CHDIR")), INT2FIX(FTW_CHDIR)) ;
		rb_hash_aset(flags, ID2SYM(rb_intern("FTW_DEPTH")), INT2FIX(FTW_DEPTH)) ;
		rb_hash_aset(flags, ID2SYM(rb_intern("FTW_MOUNT")), INT2FIX(FTW_MOUNT)) ;
		rb_hash_aset(flags, ID2SYM(rb_intern("FTW_PHYS")), INT2FIX(FTW_PHYS)) ;
		rb_hash_aset(all_flags, ID2SYM(rb_intern("flags")), flags) ;

		// Actionretval Flags
		#ifdef FTW_ACTIONRETVAL
			VALUE actionretval_flags = rb_hash_new() ;
			rb_hash_aset(actionretval_flags, ID2SYM(rb_intern("FTW_CONTINUE")), INT2FIX(FTW_CONTINUE)) ;
			rb_hash_aset(actionretval_flags, ID2SYM(rb_intern("FTW_SKIP_SIBLINGS")), INT2FIX(FTW_SKIP_SIBLINGS)) ;
			rb_hash_aset(actionretval_flags, ID2SYM(rb_intern("FTW_SKIP_SUBTREE")), INT2FIX(FTW_SKIP_SUBTREE)) ;
			rb_hash_aset(actionretval_flags, ID2SYM(rb_intern("FTW_STOP")), INT2FIX(FTW_STOP)) ;
			rb_hash_aset(all_flags, ID2SYM(rb_intern("actionretval_flags")), actionretval_flags) ;
		#endif

		// Type Flags
		VALUE type_flags = rb_hash_new() ;
		rb_hash_aset(type_flags, ID2SYM(rb_intern("FTW_D")), INT2FIX(FTW_D)) ;
		rb_hash_aset(type_flags, ID2SYM(rb_intern("FTW_DNR")), INT2FIX(FTW_DNR)) ;
		rb_hash_aset(type_flags, ID2SYM(rb_intern("FTW_DP")), INT2FIX(FTW_DP)) ;
		rb_hash_aset(type_flags, ID2SYM(rb_intern("FTW_F")), INT2FIX(FTW_F)) ;
		rb_hash_aset(type_flags, ID2SYM(rb_intern("FTW_NS")), INT2FIX(FTW_NS)) ;
		rb_hash_aset(type_flags, ID2SYM(rb_intern("FTW_SL")), INT2FIX(FTW_SL)) ;
		rb_hash_aset(type_flags, ID2SYM(rb_intern("FTW_SLN")), INT2FIX(FTW_SLN)) ;
		rb_hash_aset(all_flags, ID2SYM(rb_intern("type_flags")), type_flags) ;

		return all_flags ;
}

void Init_nftw() {
		// Initialize globals
		LIST = rb_ary_new() ;
		rb_global_variable(&LIST) ;

		// Initialize main LinuxStat and NFTW modules
		VALUE _linux_stat = rb_define_module("LinuxStat") ;
		VALUE nftw = rb_define_module_under(_linux_stat, "NFTW");

		// Methods
		rb_define_module_function(nftw, "stat", getStat, 2) ;
		rb_define_module_function(nftw, "stat_files", getFilesStat, 1) ;
		rb_define_module_function(nftw, "count_children", getChildrenCount, 2) ;
		rb_define_module_function(nftw, "count_files", getFilesCount, 1) ;
		rb_define_module_function(nftw, "count_directories", getDirectoriesCount, 1) ;

		// Constants
		rb_define_const(nftw, "FLAGS", flags_hash(nftw)) ;

		// Flags
		#ifdef FTW_ACTIONRETVAL
			rb_define_const(nftw, "FTW_ACTIONRETVAL", INT2FIX(FTW_ACTIONRETVAL)) ;
		#endif
		rb_define_const(nftw, "FTW_CHDIR", INT2FIX(FTW_CHDIR)) ;
		rb_define_const(nftw, "FTW_DEPTH", INT2FIX(FTW_DEPTH)) ;
		rb_define_const(nftw, "FTW_MOUNT", INT2FIX(FTW_MOUNT)) ;
		rb_define_const(nftw, "FTW_PHYS", INT2FIX(FTW_PHYS)) ;

		// ActionRetval flags
		#ifdef FTW_ACTIONRETVAL
			rb_define_const(nftw, "FTW_CONTINUE", INT2FIX(FTW_CONTINUE)) ;
			rb_define_const(nftw, "FTW_SKIP_SIBLINGS", INT2FIX(FTW_SKIP_SIBLINGS)) ;
			rb_define_const(nftw, "FTW_SKIP_SUBTREE", INT2FIX(FTW_SKIP_SUBTREE)) ;
			rb_define_const(nftw, "FTW_STOP", INT2FIX(FTW_STOP)) ;
		#endif

		// typeflags
		rb_define_const(nftw, "FTW_D", INT2FIX(FTW_D)) ;
		rb_define_const(nftw, "FTW_DNR", INT2FIX(FTW_DNR)) ;
		rb_define_const(nftw, "FTW_DP", INT2FIX(FTW_DP)) ;
		rb_define_const(nftw, "FTW_F", INT2FIX(FTW_F)) ;
		rb_define_const(nftw, "FTW_NS", INT2FIX(FTW_NS)) ;
		rb_define_const(nftw, "FTW_SL", INT2FIX(FTW_SL)) ;
		rb_define_const(nftw, "FTW_SLN", INT2FIX(FTW_SLN)) ;
}
