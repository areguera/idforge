SHELL=/bin/sh

all:
	echo "Nothing to do. Try executing 'make install' instead."

build:
	make build -f Library/Messages/Makefile
	make build -f Library/Manuals/Makefile

install:
	#
	# Automation scripts' command
	#
	mkdir -p ${DESTDIR}/usr/bin
	cp -p ${NAME}.sh ${DESTDIR}/usr/bin/${NAME}
	#
	# Automation scripts' library and modules
	#
	mkdir -p ${DESTDIR}/usr/libexec/${NAME}
	cp -p Library/${NAME}*.sh ${DESTDIR}/usr/libexec/${NAME}
	cp -p -r Library/Modules ${DESTDIR}/usr/libexec/${NAME}
	#
	# Automation scripts' documentation manuals
	#
	mkdir -p ${DESTDIR}/usr/share/man
	make install -f Library/Manuals/Makefile
	#
	# Automation scripts' localization messages
	#
	mkdir -p ${DESTDIR}/usr/share/locale
	make install -f Library/Messages/Makefile
	#
	# Common design models and configuration files
	#
	mkdir -p ${DESTDIR}/usr/share/${NAME}
	cp -r -p Models ${DESTDIR}/usr/share/${NAME}

test:
	#
	# Automation scripts' quality assurance tests
	#
	IDFORGE_LIBRARY=${DESTDIR}/usr/libexec/${NAME} \
	IDFORGE_MANUALS=${DESTDIR}/usr/share/man \
	TEXTDOMAINDIR=${DESTDIR}/usr/share/locale \
	${DESTDIR}/usr/bin/${NAME} qatest Library/QaTests
