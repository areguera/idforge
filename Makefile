SHELL=/bin/sh

all:
	echo "Nothing to do. Try executing 'make install' instead."

build:
	#
	# Automation scripts
	#
	sed -i -r 's,(IDFORGE_VERSION=).+,\1"'${VERSION}'",' Scripts/${NAME}.sh
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
	mkdir -p ${DESTDIR}/usr/bin
	mkdir -p ${DESTDIR}/usr/libexec/${NAME}
	cp -p -r Scripts/${NAME}.sh ${DESTDIR}/usr/bin/${NAME}
	cp -p -r Scripts/Libexec/${NAME} ${DESTDIR}/usr/libexec
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
	# Quality assurance tests
	#
	IDFORGE_BINDIR=${DESTDIR}/usr/bin \
	IDFORGE_SHAREDIR=${DESTDIR}/usr/share \
	IDFORGE_MANDIR=${DESTDIR}/usr/share/man \
	IDFORGE_LOCALEDIR=${DESTDIR}/usr/share/locale \
	IDFORGE_ETCDIR=${DESTDIR}/etc \
	IDFORGE_LIBEXECDIR=${DESTDIR}/usr/libexec \
	qatest ${DESTDIR}/usr/bin/idforge
