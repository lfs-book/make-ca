MANDIR=/usr/share/man
SBINDIR=/usr/sbin

all:
	chmod 755 make-ca help2man
	./help2man -s 8 -N ./make-ca -i include.h2m -o make-ca.8

install: all
	/usr/bin/install -vdm755 $(DESTDIR)$(SBINDIR)
	/usr/bin/install -vdm755 $(DESTDIR)$(MANDIR)/man8
	install -vm755 make-ca $(DESTDIR)$(SBINDIR)
	install -vm644 make-ca.8 $(DESTDIR)$(MANDIR)/man8

.PHONY: all install

