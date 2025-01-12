---
title: SQLite Setup
---

## Setup Instructions:
Install "DB Browser for SQLite" for your appropriate OS:
[https://sqlitebrowser.org/dl/](https://sqlitebrowser.org/dl/)

DB Browser for SQLite will install both the SQLite language and the browser software automatically.

These installs should generally be easy. Reach out for assistance if you are encountering issues.
A couple of notes below:

### For Windows:
It's likely you have admin permissions, so it will be easier if you install the standard installer (most of you will want the 64-bit version) rather than the zip (portable) version.

When installing,
there is no need to add the SQLCipher shortcut.
![1c93eac7318b3ffff089224eca088892.png](./db_browser_for_sqlite_setup.png)
Please leave the rest of the defaults (e.g. install the modules like math, will be automatically chosen), and just click through the prompts.

If you have issues, best solution seems to be to try the normal install first, then try the zip version, and if it fails try one of the nightly builds instead by selecting the DB.Browser.for.SQLite-win64.zip: [https://sqlitebrowser.org/dl/#nightly-builds](https://sqlitebrowser.org/dl/#nightly-builds)

If you select the zip version, place the extract somewhere convenient, like your desktop.


### For Mac:
I've installed both the traditional dmg and the homebrew way. It's probably easier to use the dmg, but you're welcome to do homebrew if you're used to doing things those way. I've tested on a few different OS versions and they all seem to go smoothly.

If you have issues, try one of the nightly builds: [https://sqlitebrowser.org/dl/#nightly-builds](https://sqlitebrowser.org/dl/#nightly-builds)
