# AP Calculus project: complete pre-revision backup

This snapshot preserves all 1,032 project files exactly as they were before the Units 1-5 and 7-10 HTML revisions requested on 2026-10-18. It includes the original PDFs/images, source notes, handouts, offline assets, generators and temporary project files. No project content is omitted.

## Restore

1. Download this repository with **Code > Download ZIP**, then extract it.
2. Run `restore-backup.ps1` in PowerShell from the extracted folder.
3. The script verifies each of the 18 binary archive parts, combines them, verifies the full ZIP, extracts it, and checks all 1,032 restored files against their SHA-256 hashes.

The restored project is created in `restored-project/AP-Calculus-AB-BC/`. Original PDFs remain under their original filenames in this snapshot. `BACKUP-SNAPSHOT.json` records every original path, size and checksum.

The archive is split losslessly into 4 MiB parts to fit the transfer interface. The parts together are one complete ZIP archive; they are not separate partial project versions.
