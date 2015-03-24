SHELL=/bin/sh

all:
	echo "Nothing to do. Try executing 'make build' instead."

build:
	for LOCALE in $$(ls Library/Manuals/Locales); do \
		LANG=$${LOCALE} IDFORGE_MODELS=$${PWD}/Library/Manuals IDFORGE_LIBRARY=$${PWD}/Library ./idforge.sh render Library/Manuals/idforge.conf; \
	done

install:
	MANVOLNUMS=$$(ls Library/Manuals/*.?.asciidoc | awk -F'.' '{print $$2}' | sort | uniq); \
	for MANVOLNUM in $$MANVOLNUMS;do \
		mkdir -p ${DESTDIR}/usr/share/man/man$${MANVOLNUM}; \
		for LOCALE in $$(ls Library/Manuals/Locales); do \
			if [[ $${LOCALE} == 'en' ]];then \
				install -p Library/Manuals/Final/$${LOCALE}/*.$${MANVOLNUM}.gz ${DESTDIR}/usr/share/man/man$${MANVOLNUM}; \
				continue; \
			fi; \
			mkdir -p ${DESTDIR}/usr/share/man/$${LOCALE}/man$${MANVOLNUM}; \
			install -p Library/Manuals/Final/$${LOCALE}/*.$${MANVOLNUM}.gz ${DESTDIR}/usr/share/man/$${LOCALE}/man$${MANVOLNUM}; \
		done; \
	done
