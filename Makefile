CONFIGNAME=jpougadv
DESTDIR=
PACKAGE=ovm-template-config-$(CONFIGNAME)
VERSION=1.0

help:
	@echo 'Commonly used make targets:'
	@echo '  install    - install program'
	@echo '  dist       - create a source tarball'
	@echo '  rpm        - build RPM packages'
	@echo '  clean      - remove files created by other targets'

dist: clean
	mkdir $(PACKAGE)-$(VERSION)
	tar -cSp --to-stdout --exclude .svn --exclude .hg --exclude .hgignore \
	--exclude $(PACKAGE)-$(VERSION) * | tar -x -C $(PACKAGE)-$(VERSION)
	tar -czSpf $(PACKAGE)-$(VERSION).tar.gz $(PACKAGE)-$(VERSION)
	rm -rf $(PACKAGE)-$(VERSION)

install:
	install -D $(CONFIGNAME) $(DESTDIR)/etc/template.d/scripts/$(CONFIGNAME)

rpm: dist
	rpmbuild -ta $(PACKAGE)-$(VERSION).tar.gz

clean:
	rm -fr $(PACKAGE)-$(VERSION)
	find . -name '*.py[cdo]' -exec rm -f '{}' ';'
	rm -f *.tar.gz

.PHONY: dist install rpm clean
