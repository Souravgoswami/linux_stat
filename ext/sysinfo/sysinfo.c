#include <sys/sysinfo.h>
#include "ruby.h"

static VALUE totalram(VALUE obj) {
	struct sysinfo info;
	char status = sysinfo(&info);
	if (status < 0) return Qnil;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.totalram);
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit);
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit);
}

static VALUE freeram(VALUE obj) {
	struct sysinfo info;
	char status = sysinfo(&info);
	if (status < 0) return Qnil;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.freeram);
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit);
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit);
}

static VALUE sharedram(VALUE obj) {
	struct sysinfo info;
	char status = sysinfo(&info);
	if (status < 0) return Qnil;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.sharedram);
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit);
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit);
}

static VALUE bufferram(VALUE obj) {
	struct sysinfo info;
	char status = sysinfo(&info);
	if (status < 0) return Qnil;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.bufferram);
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit);
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit);
}

static VALUE totalswap(VALUE obj) {
	struct sysinfo info;
	char status = sysinfo(&info);
	if (status < 0) return Qnil;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.totalswap);
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit);
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit);
}

static VALUE freeswap(VALUE obj) {
	struct sysinfo info;
	char status = sysinfo(&info);
	if (status < 0) return Qnil;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.freeswap);
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit);
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit);
}

static VALUE totalhigh(VALUE obj) {
	struct sysinfo info;
	char status = sysinfo(&info);
	if (status < 0) return Qnil;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.totalhigh);
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit);
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit);
}

static VALUE freehigh(VALUE obj) {
	struct sysinfo info;
	char status = sysinfo(&info);
	if (status < 0) return Qnil;

	VALUE _rb_v = ULL2NUM((unsigned long long) info.freehigh);
	VALUE _rb_mem_unit = ULL2NUM((unsigned long long) info.mem_unit);
	return rb_funcallv_public(_rb_v, rb_intern("*"), 1, &_rb_mem_unit);
}

static VALUE uptime(VALUE obj) {
	struct sysinfo info;
	char status = sysinfo(&info);
	if (status < 0) return Qnil;

	unsigned long long v = info.uptime;
	return ULL2NUM((unsigned long long) v);
}

static VALUE loads(VALUE obj) {
	struct sysinfo info;
	char status = sysinfo(&info);
	if(status < 0) return rb_ary_new();

	double scale = 1.0 / (double) (1 << SI_LOAD_SHIFT);
	return rb_ary_new_from_args(
		3,
		rb_float_new(info.loads[0] * scale),
		rb_float_new(info.loads[1] * scale),
		rb_float_new(info.loads[2] * scale)
	);
}

// Some people may need this function, just keep it to not make unnecessary calls
static VALUE sysinfoStat(VALUE obj) {
	struct sysinfo info;
	char status = sysinfo(&info);
	VALUE hash = rb_hash_new();
	if (status < 0) return hash;

	unsigned long long mem_unit = info.mem_unit;
	VALUE _rb_mem_unit = ULL2NUM(mem_unit);

	unsigned long long _totalram = info.totalram;
	unsigned long long _freeram = info.freeram;
	unsigned long long _sharedram = info.sharedram;
	unsigned long long _bufferram = info.bufferram;
	unsigned long long _totalswap = info.totalswap;
	unsigned long long _freeswap = info.freeswap;
	unsigned long long _totalhigh = info.totalhigh;
	unsigned long long _freehigh = info.freehigh;
	unsigned long long _uptime = info.uptime;

	double scale = 1.0 / (double)(1 << SI_LOAD_SHIFT);
	VALUE loads = rb_ary_new_from_args(3,
		rb_float_new(info.loads[0] * scale),
		rb_float_new(info.loads[1] * scale),
		rb_float_new(info.loads[2] * scale)
	);

	VALUE mul = rb_intern("*");

	rb_hash_aset(hash, ID2SYM(rb_intern("totalram")), rb_funcallv_public(ULL2NUM(_totalram), mul, 1, &_rb_mem_unit));
	rb_hash_aset(hash, ID2SYM(rb_intern("freeram")), rb_funcallv_public(ULL2NUM(_freeram), mul, 1, &_rb_mem_unit));
	rb_hash_aset(hash, ID2SYM(rb_intern("sharedram")), rb_funcallv_public(ULL2NUM(_sharedram), mul, 1, &_rb_mem_unit));
	rb_hash_aset(hash, ID2SYM(rb_intern("bufferram")), rb_funcallv_public(ULL2NUM(_bufferram), mul, 1, &_rb_mem_unit));
	rb_hash_aset(hash, ID2SYM(rb_intern("totalswap")), rb_funcallv_public(ULL2NUM(_totalswap), mul, 1, &_rb_mem_unit));
	rb_hash_aset(hash, ID2SYM(rb_intern("freeswap")), rb_funcallv_public(ULL2NUM(_freeswap), mul, 1, &_rb_mem_unit));
	rb_hash_aset(hash, ID2SYM(rb_intern("totalhigh")), rb_funcallv_public(ULL2NUM(_totalhigh), mul, 1, &_rb_mem_unit));
	rb_hash_aset(hash, ID2SYM(rb_intern("freehigh")), rb_funcallv_public(ULL2NUM(_freehigh), mul, 1, &_rb_mem_unit));
	rb_hash_aset(hash, ID2SYM(rb_intern("uptime")), rb_funcallv_public(ULL2NUM(_uptime), mul, 1, &_rb_mem_unit));

	rb_hash_aset(hash, ID2SYM(rb_intern("loads")), loads);

	return hash;
}

void Init_sysinfo() {
	VALUE _linux_stat = rb_define_module("LinuxStat");
	VALUE _sysinfo = rb_define_module_under(_linux_stat, "Sysinfo");

	rb_define_module_function(_sysinfo, "totalram", totalram, 0);
	rb_define_module_function(_sysinfo, "freeram", freeram, 0);
	rb_define_module_function(_sysinfo, "sharedram", sharedram, 0);
	rb_define_module_function(_sysinfo, "bufferram", bufferram, 0);
	rb_define_module_function(_sysinfo, "totalswap", totalswap, 0);
	rb_define_module_function(_sysinfo, "freeswap", freeswap, 0);
	rb_define_module_function(_sysinfo, "totalhigh", totalhigh, 0);
	rb_define_module_function(_sysinfo, "freehigh", freehigh, 0);
	rb_define_module_function(_sysinfo, "uptime", uptime, 0);
	rb_define_module_function(_sysinfo, "loads", loads, 0);
	rb_define_module_function(_sysinfo, "stat", sysinfoStat, 0);
}
