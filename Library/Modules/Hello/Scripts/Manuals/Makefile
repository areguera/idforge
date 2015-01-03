all:
	for LOCALE in ??_??;do \
		if [[ $${LOCALE} == 'en_US' ]];then \
			SOURCE=''; \
		else \
			SOURCE="$${LOCALE}/"; \
		fi; \
		for SECTION in {1..8};do \
			if ( ls $${LOCALE}/*.$${SECTION}.gz > /dev/null 2>&1 );then \
				mkdir -p $${SOURCE}man$${SECTION};\
				mv $${LOCALE}/*.$${SECTION}.gz $${SOURCE}man$${SECTION}/;\
			fi; \
		done; \
		if [[ $${LOCALE} == 'en_US' ]];then \
			rm -r $${LOCALE}; \
		fi; \
	done;
	[[ -f Makefile ]] && rm Makefile
