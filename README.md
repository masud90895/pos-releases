# ☕ Brewhaus POS — Download & Installation Guide

Welcome to the official release repository for **Brewhaus POS**. Find the latest releases for Windows and macOS under the **[Releases Tab](https://github.com/masud90895/pos-releases/releases)**.

---

## 💻 Windows Installation Guide

1. Go to **[Releases](https://github.com/masud90895/pos-releases/releases)** and download the latest `.exe` or `.msi` file (e.g. `Brewhaus.POS_0.1.16_x64-setup.exe`).
2. Double-click the downloaded file to run the installer.
3. If Windows SmartScreen appears (`Windows protected your PC`):
   - Click **More info**
   - Click **Run anyway**
4. The application will launch automatically and place a desktop shortcut.

---

## 🍏 macOS Installation Guide

1. Go to **[Releases](https://github.com/masud90895/pos-releases/releases)** and download the `.dmg` or `.tar.gz` file for Mac.
2. Open the `.dmg` file and **drag "Brewhaus POS" into your Applications folder**.
3. **Important (macOS Security Warning Fix)**:
   Because of macOS Gatekeeper security, Apple may display:
   > *"Brewhaus POS is damaged and can’t be opened"* or *"App from an unidentified developer"*.

### 🔧 How to Fix macOS Permission (Choose Option A or B):

#### Option A: Terminal Command (Fastest & Easiest)
1. Open **Terminal** on your Mac (Press `Cmd + Space`, type `Terminal`, press `Enter`).
2. Copy and paste the following command, then press `Enter`:
   ```bash
   xattr -cr "/Applications/Brewhaus POS.app"
   ```
3. Open **Brewhaus POS** from your Applications folder or Launchpad!

---

#### Option B: Using Fix_Mac_Permission.command
Because macOS also restricts scripts downloaded from the web, follow these steps to run the script:

1. Download **`Fix_Mac_Permission.command`** from this repository.
2. **Right-click (or Control + Click)** on `Fix_Mac_Permission.command` and select **Open**.
3. A popup will ask: *"macOS cannot verify the developer. Are you sure you want to open it?"* ➔ Click **Open**.
   - *(If blocked, go to **System Settings ➔ Privacy & Security**, scroll down, and click **Open Anyway**)*.
4. The script will clear all quarantine flags and output: `✔ Success! The permission has been fixed.`
5. Open **Brewhaus POS** from your Applications folder!

---

## 🖨️ Printer driver

Setting up a receipt or label printer on a Mac needs the Xprinter driver, which is not
bundled with macOS. The driver and the full setup steps are here:
**[Printer driver for macOS](PRINTER-DRIVER.md)**.

---

## 🔄 Automatic Updates
The desktop app automatically checks for new updates on launch. You can also manually check for updates anytime inside the app by clicking **Version (x.x.x) • Check Update** at the bottom of the admin sidebar.
