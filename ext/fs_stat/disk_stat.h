static VALUE getDiskStats (VALUE obj, VALUE path) {
	FILE *file = fopen("/proc/diskstats", "r");
	if(!file) return rb_ary_new();

	char lines[120];
	unsigned long long read, write;
	char *p = StringValuePtr(path);

	while (fgets(lines, sizeof(lines) - 1, file)) {
		if (sscanf(lines, "%*s %*s %119s %*s %*s %llu %*s %*s %*s %llu", lines, &read, &write) == 3) {
			if(strcmp(lines, p) == 0) {
				fclose(file);

				return rb_ary_new_from_args(
					2,
					ULL2NUM(read),
					ULL2NUM(write)
				);
			}
		} else {
			return rb_ary_new();
		}
	}

	fclose(file);
	return rb_ary_new();
}
