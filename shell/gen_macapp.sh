#! /bin/sh
#
# gen_macapp.sh
# Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
#
# Distributed under terms of the MIT license.
#

CLI=$(realpath $1)
[[ ! -x ${CLI} ]] && chmod +x "${CLI}";

APPNAME=${2:-$(basename "${CLI}" '.sh')};
APP="/Applications/${APPNAME}.app";
DIR="${APP}/Contents/MacOS";

if [ -a "${APP}" ]; then
	echo "${APP} already exists :(";
	exit 1;
fi;

mkdir -p "${DIR}";

APP_EXEC=${DIR}/${APPNAME}
# ln -Fs "${CLI}" "${APP_EXEC}";
cp "${CLI}" "${APP_EXEC}";

echo "${APP}";
