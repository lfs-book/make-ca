all:
	chmod 755 make-ca.sh help2man
	./help2man -N ./make-ca.sh -o make-ca.sh.1

install:
	/usr/bin/install -vdm755 $(DESTDIR)/usr/sbin
	/usr/bin/install -vdm755 $(DESTDIR)/usr/share/man/man1
	install -vm755 make-ca.sh $(DESTDIR)/usr/sbin
	install -vm644 make-ca.sh.1 $(DESTDIR)/usr/share/man/man1

.PHONY: all install

