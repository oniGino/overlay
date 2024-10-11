
EAPI=8

APPIMAGE_BIN="VictronConnect-x86_64-v${PV}.AppImage"

inherit desktop xdg-utils

DESCRIPTION="VictronConnect Application AppImage"
HOMEPAGE="https://www.victronenergy.com/support-and-downloads/software"
SRC_URI="https://www.victronenergy.com/upload/software/${APPIMAGE_BIN}"

RESTRICT="mirror strip"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-qt/qtbase[widgets,gui,network,icu]
	dev-qt/qtdeclarative:6
	dev-qt/qtconnectivity:6[bluetooth]
	dev-qt/qtcharts:6[qml]
	dev-qt/qtserialport:6
	dev-qt/qt5compat[qml]
	app-arch/bzip2
	app-arch/brotli
	sys-apps/dbus
	sys-libs/libomp
"

src_unpack() {
        local EXTRACT_DIR="squashfs-root"
        local EXTRACT_DEST="${P}"

        cp "${DISTDIR}/${APPIMAGE_BIN}" "${WORKDIR}"

        chmod +x "${APPIMAGE_BIN}" \
                || die "Failed to add execute permissions to bundle"

        "${WORKDIR}/${APPIMAGE_BIN}" --appimage-extract >/dev/null 2>/dev/null \
                || die "Failed to extract AppImage bundle"

        mv "${EXTRACT_DIR}" "${EXTRACT_DEST}" \
                || die "Failed to move AppImage bundle to destination"
}

src_install() {
        doicon VictronConnect.png
        domenu VictronConnect.desktop

        exeinto /opt/${PN}
		doexe bin/VictronConnect
		dolib.so lib/libve*.so*
		dosym /opt/${PN}/VictronConnect usr/bin/VictronConnect
}

pkg_postinst() {
        xdg_desktop_database_update
}
