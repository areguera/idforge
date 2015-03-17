SHELL=/bin/sh

all:
	echo "Nothing to do. Try executing 'make install' instead."

build:
	make build -f Library/Messages/Makefile
	make build -f Library/Manuals/Makefile

install:
	#
	# Automation scripts
	#
	mkdir -p ${DESTDIR}/usr/bin
	mkdir -p ${DESTDIR}/usr/libexec/${NAME}
	cp -p ${NAME}.sh ${DESTDIR}/usr/bin/${NAME}
	cp -p Library/${NAME}*.sh ${DESTDIR}/usr/libexec/${NAME}
	cp -p -r Library/Modules ${DESTDIR}/usr/libexec/${NAME}
	#
	# Documentation manuals
	#
	mkdir -p ${DESTDIR}/usr/share/man
	make install -f Library/Manuals/Makefile
	#
	# Locale messages for automation scripts
	#
	mkdir -p ${DESTDIR}/usr/share/locale
	make install -f Library/Messages/Makefile

test:
	for DIR in $$( ls -d Library/QaTests/* );do \
		IDFORGE_LIBRARY=${DESTDIR}/usr/libexec/${NAME} ${DESTDIR}/usr/bin/${NAME} qatest $${DIR}; \
	done;
