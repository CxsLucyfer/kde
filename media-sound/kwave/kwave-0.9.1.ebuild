# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_HANDBOOK="forceoptional"
inherit kde5

DESCRIPTION="A sound editor that can edit many types of audio files"
HOMEPAGE="http://kwave.sourceforge.net/"
if [[ ${KDE_BUILD_TYPE} != live ]]; then
	SRC_URI="mirror://sourceforge/${PN}/${P}-1.tar.bz2"
fi

LICENSE="BSD GPL-2 LGPL-2
	handbook? ( FDL-1.2 )"
KEYWORDS="~amd64 ~x86"
IUSE="alsa flac mp3 +qtmedia opus oss pulseaudio vorbis"

COMMON_DEPEND="
	$(add_frameworks_dep kcompletion)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kcrash)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kinit)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kservice)
	$(add_frameworks_dep ktextwidgets)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtconcurrent)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
	media-libs/audiofile:=
	>=sci-libs/fftw-3
	media-libs/libsamplerate
	alsa? ( media-libs/alsa-lib )
	flac? ( media-libs/flac )
	mp3? (
		media-libs/id3lib
		media-libs/libmad
		|| ( media-sound/lame media-sound/toolame media-sound/twolame )
	)
	qtmedia? ( $(add_qt_dep qtmultimedia) )
	opus? (
		media-libs/libogg
		media-libs/opus
	)
	pulseaudio? ( media-sound/pulseaudio )
	vorbis? (
		media-libs/libogg
		media-libs/libvorbis
	)
"
DEPEND="${COMMON_DEPEND}
	$(add_kdeapps_dep poxml)
	|| ( media-gfx/imagemagick[png,svg] media-gfx/graphicsmagick[imagemagick,png,svg] )
"
RDEPEND="${COMMON_DEPEND}
	!media-sound/kwave:4
"

DOCS=( AUTHORS CHANGES README TODO )

src_configure() {
	local mycmakeargs=(
		-DDEBUG=$(usex debug)
		-DWITH_ALSA=$(usex alsa)
		-DWITH_DOC=$(usex handbook)
		-DWITH_FLAC=$(usex flac)
		-DWITH_MP3=$(usex mp3)
		-DWITH_OGG_VORBIS=$(usex vorbis)
		-DWITH_OGG_OPUS=$(usex opus)
		-DWITH_OSS=$(usex oss)
		-DWITH_PULSEAUDIO=$(usex pulseaudio)
		-DWITH_QT_AUDIO=$(usex qtmedia)
	)

	kde5_src_configure
}
