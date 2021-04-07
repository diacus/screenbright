VERSION := 2021.04.0

PKG_ROOT := screenbright-$(VERSION)

PKG_DEB := $(PKG_ROOT)/DEBIAN
PKG_MAN := $(PKG_ROOT)/usr/share/man
PKG_BIN := $(PKG_ROOT)/usr/local/bin

default: debian-package

package-deb:
	@mkdir -p -m 755 $(PKG_DEB)
	install -m 600 MANIFEST -T $(PKG_DEB)/control

package-man: doc/screenbright.ronn
	@mkdir -p -m 755 $(PKG_MAN)/man1
	ronn -r doc/screenbright.ronn
	gzip doc/screenbright.1
	install -m 644 doc/screenbright.1.gz -T $(PKG_MAN)/man1/screenbright.1.gz

package-bin:
	@mkdir -p -m 755 $(PKG_BIN)
	install -m 555 src/screenbright.pl -T $(PKG_BIN)/screenbright

debian-package: package-deb package-man package-bin
	dpkg-deb --build screenbright-$(VERSION)
	$(RM) -r screenbright-$(VERSION)

clean:
	$(RM) -r screenbright-$(VERSION).deb $(PKG_ROOT)
	find doc -name '*.gz' -delete
