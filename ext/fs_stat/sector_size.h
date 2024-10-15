static VALUE getSectorSize(VALUE obj, VALUE path) {
	char *dev = StringValuePtr(path) ;

	unsigned int fd = open(dev, O_RDONLY | O_NONBLOCK) ;
	if(fd < 0) return Qnil ;

	unsigned int sSize = 0 ;
	short status = ioctl(fd, BLKSSZGET, &sSize) ;
	close(fd) ;
	if(status < 0)  return Qnil ;

	return UINT2NUM(sSize) ;
}
