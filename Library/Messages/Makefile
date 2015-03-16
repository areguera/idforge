SHELL=/bin/sh

all:
	echo "Nothing to do. Try executing 'make build' instead."

build:
	for LOCALE in $$(ls Library/Messages/Locales); do \
		LANG=$${LOCALE} IDFORGE_LIBRARY=Library ./idforge.sh locale Library/Messages/idforge.conf; \
	done
	
install: build
	if [ -z ${DESTDIR} ];then exit 1;fi
	if [ ! -d ${DESTDIR} ];then mkdir ${DESTDIR};fi
	for LOCALE in $$(ls Library/Messages/Locales); do \
		mkdir -p ${DESTDIR}/usr/share/locale/$${LOCALE}/LC_MESSAGES; \
		install -p Library/Messages/Locales/$${LOCALE}/*.mo ${DESTDIR}/usr/share/locale/$${LOCALE}/LC_MESSAGES; \
		rm Library/Messages/Locales/$${LOCALE}/*.mo; \
	done;
