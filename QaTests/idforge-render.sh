#!/bin/bash
######################################################################
# 
#   qatest configuration file for idforge-lib-render scripts.
#
######################################################################

#======================================================================
# Command-line
#======================================================================
qatest_runCommand ${@} render
qatest_runCommand ${@} render --help
qatest_runCommand ${@} render --version
qatest_runCommand ${@} render --description
qatest_runCommand ${@} --debug render --description

#======================================================================
# Test document rendition in different locales
#======================================================================
LANG=es_ES.UTF-8; qatest_runCommand ${@} ${QATEST_UNIT_DIR}/qat00002.conf
LANG=en_US.UTF-8; qatest_runCommand ${@} ${QATEST_UNIT_DIR}/qat00002.conf

#======================================================================
# Test document rendition using content filtering in debugging mode
#======================================================================
qatest_runCommand ${@} --filter="qat00002-1" --debug render ${QATEST_UNIT_DIR}/qat00002.conf

#======================================================================
# Test document rendition and related configuration options
#======================================================================
qatest_runCommand ${@} ${QATEST_UNIT_DIR}/qat00003.conf
qatest_runCommand ${@} ${QATEST_UNIT_DIR}/qat00004.conf
qatest_runCommand ${@} ${QATEST_UNIT_DIR}/qat00005.conf

#======================================================================
# Test image rendition and related configuration options
#======================================================================
qatest_runCommand ${@} ${QATEST_UNIT_DIR}/qat00006.conf
