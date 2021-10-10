#!/bin/sh
###############################################################################
# OUX, Inc.                                                        2014‒10‒21 #
# on ‟Gentoo Linux 13.0” “x86_64”                                     ©overcq #
###############################################################################
# workplace¦‘unix’ utility¦system management
# Udostępnia zawartość dowolnego pliku tekstowego w systemie plików— do edytora graficznego użytkownika.
###############################################################################
# Wypisuje nazwę pliku tymczasowego, w którym jest zawartość pliku do edycji. ten plik należy otworzyć w edytorze graficznym: zapis pliku w takim edytorze spowoduje aktualizację oryginalnego. By zakończyć edycję, trzeba usunąć [plik tymczasowy]“.lock”.
###############################################################################
umask 77
E_ocq_S_file="$1"
[ -f "$E_ocq_S_file" ] \
  && file -- "$E_ocq_S_file" | grep -qwe text \
  || exit 1
E_ocq_S_tmp="$( mktemp )"
#==============================================================================
if trap 'rm -f -- "$E_ocq_S_tmp"' EXIT \
  && cp -- "$E_ocq_S_file" "$E_ocq_S_tmp" \
  && chgrp wheel "$E_ocq_S_tmp" \
  && chmod g=rw "$E_ocq_S_tmp" \
  && trap - EXIT ;\
then
    d $(dirname "$0" )/user-edit-1.sh $SUDO_UID "$E_ocq_S_file" "$E_ocq_S_tmp" \
      && printf '%s\n' "$E_ocq_S_tmp"
fi
###############################################################################
