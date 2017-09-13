.PHONY: all install
all: install
install:
	$(INSTALL) -C -m 700 er "$${HOME}/bin/" \
	&& gksu ' \
		$(INSTALL) -C -o root -g root -m 700 user_edit.sh user_edit.1.sh "$${HOME}/system/bin/" \
	'
