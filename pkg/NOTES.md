# Niri + DMS install notes (new laptop)

`pkglist.txt`/`pkglist-aur.txt` are curated for a niri+DankMaterialShell (DMS) desktop,
with GNOME and Hyprland residue from this machine's history removed. See git log on
this file's commit for the exact diff against the old GNOME+Hyprland list.

## Optional packages — add manually if you want them

Left out of `pkglist.txt` on purpose; none are required for niri+DMS, add back with
`sudo pacman -S <pkg>` if you miss the functionality:

- `simple-scan` — if you have a scanner.
- `file-roller` — GUI double-click archive extraction (CLI via `7zip`/yazi works without it).
- `network-manager-applet`, `blueman` — tray-style network/bluetooth UI. Try DMS's
  panel widgets first; these are only a fallback.
- `gvfs` (+ `gvfs-mtp` for phones, `gvfs-smb` for network shares, etc.) — GUI file
  manager integration (trash, MTP, SMB). Not needed for yazi-only; `sshfs` (kept)
  covers remote mounts.
- `geoip`, `geoip-database`, `geoip-database-extra` — were pulled in for
  `gnome-weather`'s location lookup; skip unless something else needs geolocation.

## Manual steps after `install.sh` (not package-installable)

1. **Polkit agent**: nothing starts one by default without GNOME. Add to
   `~/.config/niri/config.kdl`:
   ```
   spawn-at-startup "polkit-gnome-authentication-agent-1"
   ```
2. **DMS app launcher bind**: `~/.config/niri/dms/binds.kdl` ships with a placeholder
   `Mod+D` bound to `rofi -show window`, which is no longer installed. Replace it with
   DMS's own launcher IPC call — check `dms --help` or the DMS wiki for the exact
   `dms ipc call ...` invocation.
3. **greetd + dms-greeter**: write `/etc/greetd/config.toml` with `dms-greeter` as the
   greeter command, and keep `greetd-agreety` as a commented fallback line in case
   dms-greeter fails to start. Then `sudo systemctl enable greetd.service` (already in
   `services.txt`, but `install.sh` only enables services — it doesn't write this config
   file for you).
4. **Portals**: `xdg-desktop-portal-gnome` is dropped in favor of
   `xdg-desktop-portal-gtk`. Verify screen-share/file-picker portals work under niri
   after first login; DMS may also want its own portal config fragment at
   `~/.config/xdg-desktop-portal/niri-portals.conf`.
5. **Don't copy `~/.config/niri/dms/*.kdl` from the old machine** — let DMS regenerate
   these on first run on the new hardware (display names/resolutions will differ).
