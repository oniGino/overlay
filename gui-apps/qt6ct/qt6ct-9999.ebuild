# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Qt6 Configuration Tool (for DE/WM without Qt integration) - with KDE Color Support"
HOMEPAGE="https://www.opencode.net/trialuser/qt6ct"
if [ ${PV} == 9999 ]; then
	inherit git-r3
	EGIT_REPO_URI="https://www.github.com/oniGino/qt6ct.git"
else
	SRC_URI="https://www.opencode.net/trialuser/qt6ct/-/archive/${PV}/${P}.tar.bz2"
fi

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64"

# uses Qt private APIs wrt :=
DEPEND="
	dev-qt/qtbase:6=[gui,widgets]
	dev-qt/qtdeclarative:6
	kde-frameworks/kconfig:6
	kde-frameworks/kcolorscheme:6
	kde-frameworks/kiconthemes:6
	kde-frameworks/qqc2-desktop-style:6
"
RDEPEND="
	${DEPEND}
	dev-qt/qtsvg:6
"
BDEPEND="
	dev-qt/qtbase:6
	dev-qt/qttools:6[linguist]
"

pkg_postinst() {
	if [[ ! ${REPLACING_VERSIONS} ]]; then
		elog "Note need to export QT_QPA_PLATFORMTHEME=qt6ct in the used environment"
		elog "for theming to take effect (not done automatically, may want to set in"
		elog "the HOME's shell initialization scripts, or use /etc/env.d followed by"
		elog "running env-update then re-login)."
		elog
		elog "If also using x11-misc/qt5ct, =qt5ct is alternatively recognized so it"
		elog "can be activated for both Qt5 and Qt6 at once."
		elog
		elog "Try disabling if experience startup crashes for some applications,"
		elog "may still be unstable (especially with newly released Qt versions)."
	fi
}
