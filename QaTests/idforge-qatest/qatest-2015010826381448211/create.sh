#!/bin/bash

[[ -n ${1} ]] && idforge_setParentDir ${1}

echo ${LANG} > ${1}
