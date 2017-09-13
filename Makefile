.PHONY: all install
all: install
install:
	$(INSTALL) -m 700 er "$${HOME}/bin/" \
	&& gksu ' \
		$(INSTALL) -o root -g root -m 700 user_edit.sh user_edit.1.sh "$${HOME}/system/bin/" \
	'
