MANDIR=/usr/share/man
SBINDIR=/usr/sbin
INIT=$(shell ps -p 1 --no-header | cut -d " " -f 15)


all:
	chmod 755 make-ca help2man
	./help2man -s 8 -N ./make-ca -i include.h2m -o make-ca.8

clean:
	rm -f make-ca.8
	chmod 0644 help2man
	chmod 0644 make-ca

install: all
	/usr/bin/install -vdm755 $(DESTDIR)$(SBINDIR)
	/usr/bin/install -vdm755 $(DESTDIR)$(MANDIR)/man8
	install -vm755 make-ca $(DESTDIR)$(SBINDIR)
	install -vm644 make-ca.8 $(DESTDIR)$(MANDIR)/man8
	if test "$(INIT)" == "systemd"; then \
	    install -vdm755 $(DESTDIR)/etc/systemd/system; \
	    install -vm644 systemd/* $(DESTDIR)/etc/systemd/system; \
	fi

uninstall:
	rm -f $(DESTDIR)$(SBINDIR)/make-ca
	rm -f $(DESTDIR)$(MANDIR)/man8/make-ca.8

.PHONY: all install

