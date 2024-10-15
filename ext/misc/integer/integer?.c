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

#include <limits.h>
#include "ruby.h"

VALUE isNumber(VALUE obj, VALUE val) {
	// Expecting a String as input, return Qnil for any other type
	if (!RB_TYPE_P(val, T_STRING))
		return Qnil;

	char *str = StringValuePtr(val);
	size_t len = RSTRING_LEN(val);

	// If the string is empty, return false
	if (len == 0) return Qfalse;

	size_t i = 0;
	char ch = str[0];

	// If the string starts with '-', skip it but ensure there are digits after it
	if (ch == '-') {
		i = 1;
		if (i == len) return Qfalse;
	}

	// Iterate through each character to check if it's a digit
	for (; i < len; i++) {
		ch = str[i];

		if (ch < '0' || ch > '9') {
			return Qfalse;
		}
	}

	return Qtrue;
}

void Init_integer() {
	VALUE linuxStat = rb_define_module("LinuxStat");
	VALUE misc = rb_define_module_under(linuxStat, "Misc");

	rb_define_module_function(misc, "integer?", isNumber, 1);
}
