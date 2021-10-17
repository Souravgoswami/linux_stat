#include "ruby.h"

VALUE isNumber(volatile VALUE obj, volatile VALUE val) {
	if (RB_TYPE_P(val, T_FIXNUM) || RB_TYPE_P(val, T_BIGNUM)) {
		return Qtrue ;
	} else if (!RB_TYPE_P(val, T_STRING)) {
		return Qnil ;
	}

	char *str = StringValuePtr(val) ;
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
