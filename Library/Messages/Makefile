SHELL=/bin/sh

all:
	echo "Nothing to do. Try executing 'make build' instead."

build:
	for LOCALE in $$(ls Library/Messages/Locales); do \
		LANG=$${LOCALE}.UTF-8 IDFORGE_LIBRARY=Library ./idforge.sh locale Library/Messages/idforge.conf; \
	done
	
install:
	for LOCALE in $$(ls Library/Messages/Locales); do \
		mkdir -p ${DESTDIR}/usr/share/locale/$${LOCALE}/LC_MESSAGES; \
		install -p Library/Messages/Final/$${LOCALE}/*.mo ${DESTDIR}/usr/share/locale/$${LOCALE}/LC_MESSAGES; \
	done;
