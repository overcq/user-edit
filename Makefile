.PHONY: all install
all: install
install:
	install -c -m 700 er ~/bin/ \
	&& su -c ' \
		install -c -o root -g root -m 700 user_edit.sh user_edit.1.sh ~/system/bin/ \
	'
