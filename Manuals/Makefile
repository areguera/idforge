SHELL=/bin/sh

all:
	echo "Nothing to do. Try executing 'make build' instead."

build:
	if [ -z ${DESTDIR} ];then exit 1;fi
	if [ ! -d ${DESTDIR} ];then mkdir ${DESTDIR};fi
	LANG=en_US.UTF-8 IDFORGE_LIBRARY=Library ./idforge.sh render Manuals/idforge.conf;
	if ( ls Manuals/Locales/??_?? > /dev/null 2>&1 );then \
		for LOCALE in $$(ls Manuals/Locales); do \
			[[ $${LOCALE} == 'en_US' ]] && continue; \
				LANG=$${LOCALE}.UTF-8 IDFORGE_LIBRARY=Library ./idforge.sh render Manuals/idforge.conf; \
		done; \
	fi
	MANVOLNUMS=$$(ls Manuals/*.?.asciidoc | awk -F'.' '{print $$2}' | sort | uniq); \
	for MANVOLNUM in $$MANVOLNUMS;do \
		mkdir -p ${DESTDIR}/usr/share/man/man$${MANVOLNUM}; \
		if ( ls Manuals/Locales/??_?? > /dev/null 2>&1 );then \
			for LOCALE in $$(ls Manuals/Locales); do \
				[[ $${LOCALE} == 'en_US' ]] && continue; \
				mkdir -p ${DESTDIR}/usr/share/man/$${LOCALE}/man$${MANVOLNUM}; \
			done; \
		fi; \
	done

install:
	if [ -z ${DESTDIR} ];then exit 1;fi
	if [ ! -d ${DESTDIR} ];then mkdir ${DESTDIR};fi
	MANVOLNUMS=$$(ls Manuals/*.?.asciidoc -1 | awk -F'.' '{print $$2}' | sort | uniq); \
	for MANVOLNUM in $$MANVOLNUMS;do \
		install -p Manuals/Final/en_US/*.$${MANVOLNUM}.gz ${DESTDIR}/usr/share/man/$${LOCALE}/man$${MANVOLNUM}; \
		if ( ls Manuals/Locales/??_?? > /dev/null 2>&1 );then \
			for LOCALE in $$(ls Manuals/Locales); do \
				[[ $${LOCALE} == 'en_US' ]] && continue; \
				install -p Manuals/Final/$${LOCALE}/*.$${MANVOLNUM}.gz ${DESTDIR}/usr/share/man/$${LOCALE}/man$${MANVOLNUM}; \
			done; \
		fi; \
	done
