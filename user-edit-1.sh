#!/bin/sh
###############################################################################
# OUX, Inc.                                                        2014‒10‒21 #
# on ‟Gentoo Linux 13.0” “x86_64”                                     ©overcq #
###############################################################################
# workplace¦‘unix’ utility¦system management
# Procedura wewnętrzna.
###############################################################################
umask 77
E_ocq_S_for_user=$1
E_ocq_S_file="$2"
E_ocq_S_tmp="$3"
#==============================================================================
trap 'rm -f -- "$E_ocq_S_tmp" "${E_ocq_S_tmp}.lock"' EXIT
touch "${E_ocq_S_tmp}.lock" \
  && \
  { ( E_ocq_S_cp_pid= ;\
      while inotifywait -qq -e close_write -- "$E_ocq_S_tmp"; do \
          if [ -n "$E_ocq_S_cp_pid" ]; then \
              while [ -n "$( ps | sed -e 's`^ *\([0-9][0-9]*\).*`\1`' | grep -Fxe "$E_ocq_S_cp_pid" )" ]; do \
                  sleep 1 ;\
              done ;\
          fi ;\
          cp -- "$E_ocq_S_tmp" "$E_ocq_S_file" & \
          E_ocq_S_cp_pid=$! ;\
      done \
  ) & } \
  && chown ${E_ocq_S_for_user}:${E_ocq_S_for_user} "${E_ocq_S_tmp}.lock" \
  && nice -n 1 inotifywait -qq -e delete_self -- "${E_ocq_S_tmp}.lock"
###############################################################################