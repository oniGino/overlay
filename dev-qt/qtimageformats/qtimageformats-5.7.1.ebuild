# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit qt5-build

DESCRIPTION="Additional format plugins for the Qt image I/O system"

if [[ ${QT5_BUILD_TYPE} == release ]]; then
	KEYWORDS="amd64 ~arm ~hppa ~ppc64 ~x86"
fi

IUSE="jpeg2k mng webp tiff"

DEPEND="
	~dev-qt/qtcore-${PV}
	~dev-qt/qtgui-${PV}
	jpeg2k? ( media-libs/jasper:= )
	mng? ( media-libs/libmng:= )
	webp? ( media-libs/libwebp:= )
	tiff? ( media-libs/tiff:0 )
"
RDEPEND="${DEPEND}"
