.PHONY: all install
all: install
install:
	install -C -m 700 er "$${HOME}/bin/" \
	&& gksu ' \
		install -C -o root -g root -m 700 user_edit.sh user_edit.1.sh "$${HOME}/system/bin/" \
	'
