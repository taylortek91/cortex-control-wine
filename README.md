# Cortex Control on Arch/CachyOS with patched Wine

Unofficial Arch packaging for running Neural DSP Cortex Control using a
Wine 11.0 build with Direct2D/DirectComposition patches. The package keeps the
patched Wine tree under `/opt/wine-d2d1`; it does not replace the system Wine.

This setup was verified on CachyOS x86_64 with a Quad Cortex on CorOS 4.1.1
and Cortex Control 4.1.0. The QC's USB-HID interface was accessible through
Wine, and the patched Wine rendered Cortex Control's Grid. The patch is
unofficial and future Wine, Cortex Control, or CorOS updates may need retesting.

## Support this project

If this package is useful, consider supporting its maintenance:

<a href="https://www.buymeacoffee.com/tlrtek"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me a Coffee" width="160"></a>

## Build and install

Install the usual Arch build tools (`base-devel`), then build this directory:

```sh
makepkg -si
```

The package is a binary package for the patched Wine release. Its upstream
archive is checksum-pinned in `PKGBUILD`. It also installs narrowly matched
udev rules granting the active local user access to the Quad Cortex or Quad
Cortex mini HID device. The rule runs before systemd's seat ACL rule, and the
package triggers matching connected devices when installed or upgraded.

## Install Cortex Control

The proprietary Cortex Control installer is **not** bundled or redistributed.
Download the Windows installer from [Neural DSP Downloads](https://neuraldsp.com/downloads),
then run:

```sh
cortex-control-setup ~/Downloads/'Cortex Control v4.1.0.exe'
```

The setup command creates a dedicated Wine prefix under
`~/.local/share/cortex-control-wine/prefix`, installs Microsoft's WebView2
runtime into that prefix, and launches the installer you downloaded. Complete
its normal setup dialogs. To start the app later:

```sh
cortex-control
```

The prefix can be relocated by setting `CORTEX_CONTROL_PREFIX` for both
commands. `CORTEX_CONTROL_WINE_ROOT` can override the default
`/opt/wine-d2d1` install location for testing. Do not run Cortex Control as
root. Close the official app before opening another QC control client.

The launcher works around Cortex Control's false offline state under Wine. The
app runs `powershell.exe` with `Get-NetAdapter` to check connectivity, but
Wine's built-in PowerShell is a stub. The launcher checks
`https://cloud.neuraldsp.com/` once with `curl`, then supplies that online/offline
result through a small `powershell.bat` shim added only to this app's Wine
`WINEPATH`. It does not modify the prefix's PowerShell or bypass account login.

## Uninstall

Run the uninstaller from a terminal after closing Cortex Control:

```sh
cortex-control-uninstall
```

The default `--package-only` mode removes the Arch package and preserves the
Wine prefix. Use `--app-only` to run Cortex Control's registered MSI uninstaller
while keeping the package and prefix; back up important data first. Use
`--purge-prefix` to remove both the package and the entire prefix; this deletes
settings, backups, WebView2, and any other Windows apps in that prefix, and
requires typing `PURGE` to confirm.

## Notes

- The HID permission rules match only Neural DSP USB IDs `152a:880a` (Quad
  Cortex) and `152a:892f` (Quad Cortex mini); they do not grant access to
  arbitrary USB devices. `TAG+="uaccess"` requires an active local logind
  session.
- The QC may report a USB-HID output write stall (`EPIPE`/`Broken pipe`) even
  when it accepted the report. That is known device behavior; the app should
  continue receiving replies.
- This package is not affiliated with Neural DSP. Neural DSP, Cortex Control,
  and Quad Cortex are their owners' trademarks.
- Upstream Wine patch/package source: [mklnln/wine-d2d1-dcomp](https://github.com/mklnln/wine-d2d1-dcomp),
  based on [giang17/wine](https://github.com/giang17/wine/tree/d2d1-dcomp-11.0).
