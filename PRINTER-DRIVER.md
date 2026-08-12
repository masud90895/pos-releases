# 🖨️ Printer driver for macOS

The Xprinter driver for the receipt and label printers used with Brewhaus POS, kept here so
it can always be found.

**Why not just use the manufacturer's site?** Two reasons. It rotates versions, so the build
that works today may not be downloadable next month. And the version on the USB stick inside
the printer box is *newer* than the one the website offers — that newer one is what is
published here, and it is the build we have actually run in production.

| | This repo | xprintertech.com |
|---|---|---|
| Version | **3.13.37** | 3.13.36 |
| Printer models covered | 377 | 367 |
| Apple Silicon native | yes | yes |
| Source | USB stick in the printer box | Download page |

> **Windows users:** the printer's own USB stick has the Windows driver on it, and Windows
> normally finds these printers on its own. This page is only about Macs.

---

## 1. Download

Take the `.pkg` from the
[**xprinter-driver-v3.13.37**](https://github.com/masud90895/pos-releases/releases/tag/xprinter-driver-v3.13.37)
release. One file, about 850 KB.

## 2. Install it

Double-click the `.pkg`.

macOS will almost certainly refuse it the first time — it is not from the App Store. When it
does:

> **System Settings → Privacy & Security** → scroll down → **Open Anyway**

Then double-click the `.pkg` again and walk through the installer. No restart is needed.

## 3. Plug the printer in

USB cable, printer switched on.

The installer tries to add the first USB printer it finds by itself, so open
**System Settings → Printers & Scanners** and look — it may already be listed. If it is, skip
to step 5 and check the driver is right.

## 4. Add it by hand, if it did not appear

**Printers & Scanners → Add Printer, Scanner or Fax…** → **USB** tab → click the printer.

## 5. The step everything depends on

At the bottom of the Add window there is a **Use** (or **Driver**) dropdown.

> Do **not** accept whatever macOS picked. Open the dropdown, choose **Select Software…**,
> and find the exact model in the list.

| Printer | Choose |
|---|---|
| XP-350BM (label / barcode) | `XP-350BM` |
| POS-80 / XP-80 (receipt, 80 mm) | `XP-80` |
| Anything else | the model printed on the sticker under the printer |

Left to itself macOS picks *Generic PostScript*, which a thermal printer cannot read. The job
goes through, the queue says it printed, and the paper comes out blank. If that is what you
are seeing, this step is why.

## 6. Check it

Select the printer → **Options & Supplies… → Utility → Print Test Page**, or just print
anything.

---

## When it stops working

### The queue says "Paused", or the printer went quiet and never came back

macOS stops a queue after a failed job — out of paper, cable pulled, printer switched off —
and does not start it again on its own. Nothing is broken and nothing needs reinstalling:

```bash
lpstat -p                      # find the queue name
cupsenable  Printer_POS_80     # use your own queue name
cupsaccept  Printer_POS_80
```

### Paper comes out blank

Wrong driver. Go back to step 5 and pick the exact model.

### The printer does not appear in the USB list

Unplug and replug it, try a different cable, and check it is powered. Thermal printers are
fussy about unpowered USB hubs — plug it straight into the Mac.

### Check what a queue is actually using

```bash
lpstat -v                                            # how each queue connects
lpstat -p                                            # which are enabled
grep -m1 PCFileName /etc/cups/ppd/<queue-name>.ppd   # which driver
```

---

## What the installer puts on the machine

Worth knowing, because it does a little more than drop files.

| Path | What |
|---|---|
| `/Library/Printers/PPDs/Contents/Resources/XP-*.ppd` | 377 model descriptions |
| `/Library/Printers/Xprinter/bin/rastertosnail*-macarm64` | the six filters that turn a page into printer commands |
| `/usr/libexec/cups/filter/*-xprinter` | symlinks so CUPS can find the above |

It also:

- **adds a printer queue automatically** for the first USB printer it sees. Handy, but it is
  why you sometimes end up with a queue you did not create, or a second one named `…_2`.
- **adds a cron entry** running `mvimg.sh` every minute, which shuffles debug bitmaps from
  `/tmp` into `/var/log/prnlog`. Harmless, and safe to remove if you would rather not have
  it: `crontab -l | grep -v mvimg.sh | crontab -`

### Removing it

Delete the printers from **Printers & Scanners** first, or you will be left with queues
pointing at a driver that is no longer there.

```bash
sudo rm -rf /Library/Printers/Xprinter
sudo rm -f  /usr/libexec/cups/filter/*-xprinter
sudo rm -f  /Library/Printers/PPDs/Contents/Resources/XP-*.ppd
sudo pkgutil --forget net.xprinter.drv
crontab -l | grep -v mvimg.sh | crontab -
```

---

## Getting it from the manufacturer instead

If this repo is ever unavailable: <https://www.xprintertech.com/drivers-2.html>

There are several cards on that page. The one you want is **"Label printer (macOS)"** — click
its **Download** button. You get a numbered `.zip`; unzip it and the `.pkg` is inside.

Two things about that page catch people out:

- The card is called *Label printer*, but the package inside covers the receipt and bill
  printers too — `XP-80.ppd` is in there. There is no separate macOS download for those.
- Every other card is either the wrong operating system (Linux, Windows) or a different
  product line (A4/tattoo, XP-D451B).

It gives you 3.13.36, which is a version behind what is published here.

---

*Mirrored for our own installs. The driver is Xprinter's software, not ours — see
[xprintertech.com](https://www.xprintertech.com) for their terms and support.*
