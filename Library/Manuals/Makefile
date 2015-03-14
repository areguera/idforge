SHELL=/bin/sh

all:
	echo "Nothing to do. Try executing 'make build' instead."

update-po:
	for LOCALE in $$(ls Manuals/Locales); do \
		LANG=$${LOCALE} IDFORGE_LIBRARY=Library ./idforge.sh locale Manuals/idforge.conf; \
	done

build:
	for LOCALE in $$(ls Manuals/Locales); do \
		LANG=$${LOCALE} IDFORGE_LIBRARY=Library ./idforge.sh render Manuals/idforge.conf; \
	done

install:
	if [ -z ${DESTDIR} ];then exit 1;fi
	if [ ! -d ${DESTDIR} ];then mkdir ${DESTDIR};fi
	MANVOLNUMS=$$(ls Manuals/*.?.asciidoc | awk -F'.' '{print $$2}' | sort | uniq); \
	for MANVOLNUM in $$MANVOLNUMS;do \
		mkdir -p ${DESTDIR}/usr/share/man/man$${MANVOLNUM}; \
		for LOCALE in $$(ls Manuals/Locales); do \
			if [[ $${LOCALE} == 'en' ]];then \
				install -p Manuals/Final/$${LOCALE}/*.$${MANVOLNUM}.gz ${DESTDIR}/usr/share/man/man$${MANVOLNUM}; \
				continue; \
			fi; \
			mkdir -p ${DESTDIR}/usr/share/man/$${LOCALE}/man$${MANVOLNUM}; \
			install -p Manuals/Final/$${LOCALE}/*.$${MANVOLNUM}.gz ${DESTDIR}/usr/share/man/$${LOCALE}/man$${MANVOLNUM}; \
		done; \
	done
