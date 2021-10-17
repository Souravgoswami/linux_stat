/*
	Validates if a String is integer or not.

	Conditions:
		- The String can start with - (negative)
		- If the Argument is a BigInt or Integer, or anything else, return false
		- The String cannot have anything other than 0 to 9
		- The String can have leading zeroes and negative sign:
			Example 1: "-00999" which translates to Ruby's -999 (decimal)
			Example 2: "000999" translates to 999
		- If it fails to determine, it returns nil instead of false
		- It doesn't raise any error. Handing nil is enough to indicate that it failed.
*/

#if defined(__GNUC__) && !defined(__clang__) && !defined(__INTEL_COMPILER)
	#pragma GCC optimize ("O3")
	#pragma GCC diagnostic warning "-Wall"
#elif defined(__clang__)
	#pragma clang optimize on
	#pragma clang diagnostic warning "-Wall"
#elif defined(__INTEL_COMPILER)
	#pragma intel optimization_level 3
#endif

#include <limits.h>
#include "ruby.h"

VALUE isNumber(volatile VALUE obj, volatile VALUE val) {
	// But we don't expect anything other than String though as Argument.
	// Note that raising ArgumentError or any kind of Error shouldn't be done here
	// Otherwise Integer(n) is the best method in Ruby.
	if (!RB_TYPE_P(val, T_STRING))
		return Qnil ;

	char *str = StringValuePtr(val) ;
	char ch = str[0] ;

	// If the string is empty, return false
	if (!ch) return Qfalse ;

	unsigned char i = ch == '-' ? 1 : 0 ;
	if (!str[i]) return Qfalse ;

	unsigned char max = UCHAR_MAX ;

	# pragma GCC unroll 4
	while((ch = str[i++])) {
		if (ch < 48 || ch > 57)
			return Qfalse ;

		if (i == max)
			return Qnil ;
	}

	return Qtrue ;
}

void Init_integer() {
	VALUE linuxStat = rb_define_module("LinuxStat") ;
	VALUE misc = rb_define_module_under(linuxStat, "Misc") ;

	rb_define_module_function(misc, "integer?", isNumber, 1) ;
}
