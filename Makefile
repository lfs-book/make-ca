MANDIR=/usr/share/man
SBINDIR=/usr/sbin

all:
	chmod 755 make-ca help2man
	./help2man -N ./make-ca -o make-ca.1

install:
	/usr/bin/install -vdm755 $(DESTDIR)$(SBINDIR)
	/usr/bin/install -vdm755 $(DESTDIR)$(MANDIR)/man1
	install -vm755 make-ca $(DESTDIR)$(SBINDIR)
	install -vm644 make-ca.1 $(DESTDIR)$(MANDIR)/man1

.PHONY: all install

