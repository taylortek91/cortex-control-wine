# Community package for running Neural DSP Cortex Control on Arch-based Linux.
# The Cortex Control installer itself is NOT redistributed; the user downloads
# it from Neural DSP and installs it into a per-user Wine prefix.
pkgname=cortex-control-wine-bin
pkgver=11.0
pkgrel=2
pkgdesc='Cortex Control launcher with patched Wine for Arch Linux'
arch=('x86_64')
url='https://neuraldsp.com/cortex-control'
license=('LGPL-2.1-or-later' 'MIT')
options=('!strip')
depends=(
  'alsa-lib'
  'curl'
  'fontconfig'
  'freetype2'
  'giflib'
  'gnutls'
  'libjpeg-turbo'
  'libpng'
  'libpulse'
  'libxcomposite'
  'libxcursor'
  'libxi'
  'libxinerama'
  'libxrandr'
  'vulkan-icd-loader'
)
makedepends=('zstd')
install='cortex-control-wine-bin.install'
source=(
  "wine-d2d1-${pkgver}-x86_64.tar.zst::https://github.com/mklnln/wine-d2d1-dcomp/releases/download/v${pkgver}/wine-d2d1-${pkgver}-x86_64.tar.zst"
  'cortex-control'
  'cortex-control-setup'
  'cortex-control-wine.desktop'
  '70-cortex-control.rules'
  'README.md'
  'LICENSE'
)
sha256sums=(
  '909e283e1e087a93e196defffd2a67120ab2df6ea4edd7f6f45b97528bf8646b'
  'd4b05fca22e46528429d5a5d29fd0100fc20bc7170cb18b2de005c0654b40596'
  'a16cceb1916a3c081679e5b81244c76ce8c6f39d78e9d1fb5e191ce7cb101495'
  'e77047ba70ef10e4c29eb22f67a39ce0ff183defd25d79159aab36db305440c2'
  '1c44f565c92676e56b9fcdbdd32bc60d065ee2d6364b06bc5740d7b0a80bd455'
  '3e8a2d8334dfa1ad070822440f977fbd897a1b233a55713de6b86d409cef8089'
  'b85c038eb1b49bbe5987ec9e9dc433ecd056f11e96b17d1b2b24358fb7957dfe'
)

package() {
  install -d "$pkgdir/opt"
  cp -a "$srcdir/wine-d2d1" "$pkgdir/opt/wine-d2d1"

  install -Dm755 "$srcdir/cortex-control" \
    "$pkgdir/usr/bin/cortex-control"
  install -Dm755 "$srcdir/cortex-control-setup" \
    "$pkgdir/usr/bin/cortex-control-setup"
  install -Dm644 "$srcdir/cortex-control-wine.desktop" \
    "$pkgdir/usr/share/applications/cortex-control-wine.desktop"
  install -Dm644 "$srcdir/70-cortex-control.rules" \
    "$pkgdir/usr/lib/udev/rules.d/70-cortex-control.rules"
  install -Dm644 "$srcdir/README.md" \
    "$pkgdir/usr/share/doc/$pkgname/README.md"
  install -Dm644 "$srcdir/LICENSE" \
    "$pkgdir/usr/share/licenses/$pkgname/LICENSE"
}
