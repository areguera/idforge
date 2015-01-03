SHELL=/bin/sh

all:
	echo "Nothing to do. Try executing 'make install' instead."

build:
	#
	# Automation scripts
	#
	sed -i -r 's,(SCRIPT_MODULE_VERSION=).+$$,\1"'${VERSION}'",' Scripts/Libexec/${NAME}/hello.sh
	#
	# Documentation manuals
	#
	tcar prepare Scripts/Manuals --config
	LANG=en_US.UTF-8 tcar render Scripts/Manuals/manuals.conf;
	if ( ls Scripts/Manuals/Locales/??_?? > /dev/null 2>&1 );then \
		for LOCALE in $$(ls Scripts/Manuals/Locales); do \
			[[ $${LOCALE} == 'en_US' ]] && continue; \
				LANG=$${LOCALE}.UTF-8 tcar render Scripts/Manuals/manuals.conf; \
		done; \
	fi
	#
	# Locale messages for automation scripts
	#
	for PO in $$(find Scripts/Locales -name '*.po');do \
		LOCALE=$$(basename $$(dirname $${PO})); \
		MO_DIR=Scripts/Locales/$${LOCALE}; \
		MO_NAME=$$(basename $${PO} | sed -r 's,\.po$$,.mo,'); \
		MO=$${MO_DIR}/$${MO_NAME}; \
		mkdir -p $${MO_DIR}; \
		msgfmt -c -o $${MO} $${PO}; \
	done;

install:
	#
	# Automation scripts
	#
	mkdir -p ${DESTDIR}/usr/share
	cp -r -p Scripts/Libexec/${NAME} ${DESTDIR}/usr/libexec
	#
	# Documentation manuals
	#
	mkdir -p ${DESTDIR}/usr/share/man
	cp -p -r Scripts/Manuals/Final/* ${DESTDIR}/usr/share/man
	#
	# Locale messages for automation scripts
	#
	mkdir -p ${DESTDIR}/usr/share/locale
	for MO in $$(find Scripts/Locales -name '*.mo');do \
		LOCALE=$$(basename $$(dirname $${MO})); \
		MO_DIR=${DESTDIR}/usr/share/locale/$${LOCALE}/LC_MESSAGES; \
		mkdir -p $${MO_DIR}; \
		cp -p $${MO} $${MO_DIR}; \
	done;

test:
	#
	# Quality assurance tests (command-line)
	#
	SYSTEM_BINDIR=${DESTDIR}/usr/bin \
	SYSTEM_SHAREDIR=${DESTDIR}/usr/share \
	SYSTEM_MANDIR=${DESTDIR}/usr/share/man \
	SYSTEM_LOCALEDIR=${DESTDIR}/usr/share/locale \
	SYSTEM_ETCDIR=${DESTDIR}/etc \
	SYSTEM_LIBEXECDIR=${DESTDIR}/usr/libexec \
	SCRIPT_LIBRARY=/usr/libexec/idforge \
	qatest /usr/bin/idforge $$(echo ${NAME} | cut -d- -f3) && \
	qatest /usr/bin/idforge --debug $$(echo ${NAME} | cut -d- -f3);

clean:
	rm -r $$(find . -type d -name 'Final')
