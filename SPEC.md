# footage-tools — specification

Living document: what the tool should do. Update it whenever behaviour changes.

## Goal

One right-click entry in Dolphin for video/audio files that opens a window where the user picks
exactly what to do to the selected footage, then runs it with visible progress.

## Requirements

### Entry point
- Dolphin service menu “Footage tools…” on `video/*` and `audio/*`, top level of the context menu.
- Accepts any number of files, possibly from different folders. Non-files are ignored.

### Window
- Shows the selected files and their folder.
- Each operation is an independently tickable section; Run is disabled when nothing is ticked.
- Remembers the last settings, except “replace originals”, which must be re-chosen every time
  and always asks for confirmation.
- During a run: current step + file, per-file progress (busy indicator when unknown), overall
  progress, scrolling log, Cancel. Cancel stops ffmpeg and removes half-written files.
- At the end: summary, “Open output folder”, desktop notification if the window isn’t focused.

### Dialogue leveling
- Behaviour identical to the original `level-dialogue` script (see `bin/level-dialogue`):
  strength gentle/normal/strong, loudness target (default −14 LUFS), optional denoise.
- Video, subtitle and attachment streams are copied untouched; metadata, chapters and the
  original modification time are kept.
- Output: subfolder (default `Leveled/`, same filename) | beside (`NAME.leveled.EXT`) | replace
  (original to Trash).
- Files with no audio, or already named `*.leveled.*`, are skipped (not failures).

### Proxies
- Written to a subfolder (default `Proxy/`) next to the clip they belong to, named
  `<clip base name>.<proxy ext>`.
- The clip they belong to is the leveled output when leveling ran, otherwise the original.
- Must work in DaVinci Resolve (incl. free version on Linux), Premiere Pro and Kdenlive.
- Formats: ProRes 422 Proxy (10-bit 4:2:2, PCM) `.mov` — default; DNxHR LB (4:2:2, PCM) `.mov`;
  H.264 all-intra (yuv420p, CRF 23, AAC) `.mp4` — smallest, not usable in free Resolve on Linux.
- Frame rate and audio-track count/channels must match the source (Premiere attach requirement).
- Size by short side (540/720/1080) or fraction (½, ¼); never upscale; dimensions even.
- All audio tracks are kept so editors see the same track layout.
- Existing proxies are skipped unless “Overwrite existing proxies” is ticked.
- Audio-only files are skipped for proxies.

## Open questions / ideas
- Editor not fixed (Kdenlive, Resolve or Premiere), so defaults stay editor-neutral.
- Leveled `.mp4`/`.mov` files get AAC audio, which the free Resolve on Linux can't read. Option:
  write PCM audio (in `.mov`) for Resolve users.
- Hardware encoding (VAAPI on the Intel GPU) for faster H.264 proxies.
- Running several files in parallel.
- More operations: transcode to an edit-friendly mezzanine, extract audio, contact sheets.
