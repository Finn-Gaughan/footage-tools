# Changelog

## 2.3.0 — 2026-11-24
- Old “Level dialogue” submenu retired on Finn's machine (`install.sh --replace-legacy`).
- Popup when leveled files or proxies already exist in the destination: Replace / Skip existing / Cancel.
  Replaces the “Overwrite existing proxies” checkbox.

## 2.2.0 — 2026-11-24
- Leveled files can carry their settings in the name, e.g. `clip.leveled_normal_denoise_-14LUFS.mp4`
  (on by default; `level-dialogue --name-tags`).
- Proxies are named after the (tagged) leveled file so they still link automatically.

## 2.1.0 — 2026-11-24
- Default proxy format is now ProRes 422 Proxy so proxies work in Resolve (incl. free on Linux),
  Premiere and Kdenlive. H.264 labelled as not readable by free Resolve on Linux.
- README: how to attach proxies in Resolve and Premiere.

## 2.0.0 — 2026-11-24
- New **Footage tools…** right-click window (PyQt6) replacing the four-entry submenu.
- Dialogue leveling can now write into a subfolder (`level-dialogue --outdir DIR`).
- New: editing proxies (H.264 all-intra, ProRes Proxy, DNxHR LB) in a `Proxy/` subfolder.
- Progress, cancel, remembered settings, “open output folder”.
- `install.sh` (symlink install; `--replace-legacy` to retire the old submenu).

## 1.0.0 — 2026-11-15
- Original `level-dialogue` script and “Level dialogue” Dolphin submenu
  (save as new / replace, with or without denoise).
