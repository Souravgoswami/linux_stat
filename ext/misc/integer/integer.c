#include "ruby.h"

VALUE isNumber(volatile VALUE obj, volatile VALUE val) {
	// If the argument is T_FIXNUM or T_BIGNUM, they are of course, Integer
	// But we don't expect anything other than String though as Argument.
	// Note that raising ArgumentError or any kind of Error shouldn't be done here
	// Otherwise Integer(n) is the best method in Ruby.
	if (RB_TYPE_P(val, T_FIXNUM) || RB_TYPE_P(val, T_BIGNUM)) {
		return Qtrue ;
	} else if (!RB_TYPE_P(val, T_STRING)) {
		return Qnil ;
	}

	char *str = StringValuePtr(val) ;

	// If the string is empty, return false
	if (!str[0]) {
		return Qfalse ;
	}

	unsigned char i = 0 ;
	unsigned char max = UCHAR_MAX ;
	char ch ;

	while((ch = str[i++])) {
		if (ch < 48 || ch > 57) {
			return Qfalse ;
		}

		if (i == max) {
			return Qnil ;
		}
	}

	return Qtrue ;
}

void Init_integer() {
	VALUE linuxStat = rb_define_module("LinuxStat") ;
	VALUE misc = rb_define_module_under(linuxStat, "Misc") ;

	rb_define_module_function(misc, "integer?", isNumber, 1) ;
}
