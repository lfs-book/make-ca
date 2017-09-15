MANDIR=/usr/share/man
SBINDIR=/usr/sbin

all:
	chmod 755 make-ca.sh help2man
	./help2man -N ./make-ca.sh -o make-ca.sh.1

install:
	/usr/bin/install -vdm755 $(DESTDIR)$(SBINDIR)
	/usr/bin/install -vdm755 $(DESTDIR)$(MANDIR)/man1
	install -vm755 make-ca.sh $(DESTDIR)$(SBINDIR)
	install -vm644 make-ca.sh.1 $(DESTDIR)$(MANDIR)/man1

.PHONY: all install

