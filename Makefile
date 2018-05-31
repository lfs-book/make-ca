MANDIR=/usr/share/man
SBINDIR=/usr/sbin


all:
	chmod 755 make-ca help2man

man: all
	./help2man -s 8 -N ./make-ca -i include.h2m -o make-ca.8

clean: clean_man
	chmod 0644 help2man
	chmod 0644 make-ca

clean_man:
	rm -f make-ca.8

install: all
	/usr/bin/install -vdm755 $(DESTDIR)$(SBINDIR)
	install -vm755 make-ca $(DESTDIR)$(SBINDIR)

install_man: all man
	/usr/bin/install -vdm755 $(DESTDIR)$(MANDIR)/man8
	install -vm644 make-ca.8 $(DESTDIR)$(MANDIR)/man8

install_systemd: all install
	if test "$(shell ps -p 1 --no-header | cut -d " " -f 15)" == "systemd"; then \
	    install -vdm755 $(DESTDIR)/etc/systemd/system; \
	    install -vm644 systemd/* $(DESTDIR)/etc/systemd/system; \
	fi

uninstall:
	rm -f $(DESTDIR)$(SBINDIR)/make-ca

uninstall_man:
	rm -f $(DESTDIR)$(MANDIR)/man8/make-ca.8

.PHONY: all install

