#!/bin/sh
###############################################################################
# OUX, Inc.                                                        2014‒10‒21 #
# on ‟Gentoo Linux 13.0” “x86_64”                                     ©overcq #
###############################################################################
# workplace¦‘unix’ utility¦system management
# procedura wewnętrzna.
###############################################################################
umask 77
E_overcq_S_for_user=$1
E_overcq_S_file="$2"
E_overcq_S_tmp="$3"
#==============================================================================
trap 'rm -f -- "$E_overcq_S_tmp" "${E_overcq_S_tmp}.lock"' EXIT
touch "${E_overcq_S_tmp}.lock" \
  && \
  { ( E_overcq_S_cp_pid= ;\
      while inotifywait -qq -e close_write -- "$E_overcq_S_tmp"; do \
          if [ -n "$E_overcq_S_cp_pid" ]; then \
              while [ -n "$( ps | sed -e 's`^ *\([0-9][0-9]*\).*`\1`' | grep -Fxe "$E_overcq_S_cp_pid" )" ]; do \
                  sleep 1 ;\
              done ;\
          fi ;\
          cp -- "$E_overcq_S_tmp" "$E_overcq_S_file" & \
          E_overcq_S_cp_pid=$! ;\
      done \
  ) & } \
  && chown ${E_overcq_S_for_user}:${E_overcq_S_for_user} "${E_overcq_S_tmp}.lock" \
  && nice -n 1 inotifywait -qq -e delete_self -- "${E_overcq_S_tmp}.lock"
###############################################################################