# Setup
## Environment Setup Guide
Before using this repo, make sure you’ve completed the [environment setup guide](https://github.com/UofT-DSI/onboarding/blob/main/environment_setup/README.md), which installs the core tools you’ll need for this module, such as:

- Git  
- Git Bash (for Windows)  
- Visual Studio Code  

## DB Browser for SQLite
Additionally, make sure to install DB Browser for SQLite. 
This setup only needs to be done **once**.

Install "DB Browser for SQLite" for your appropriate OS:

[👉 You can find it here 👈](https://sqlitebrowser.org/dl//)

DB Browser for SQLite will install both the SQLite language and the browser software automatically.

These installs should generally be easy. Reach out for assistance if you are encountering issues.
A couple of notes below:

### For Windows:
It's likely you have admin permissions, so it will be easier if you install the standard installer (most of you will want the 64-bit version) rather than the zip (portable) version.

When installing, there is no need to add the SQLCipher shortcut.
Please leave the rest of the defaults (e.g. install the modules like math, will be automatically chosen), and just click through the prompts.

If you have issues, best solution seems to be to try the normal install first, then try the zip version, and if it fails try one of the nightly builds instead by selecting the DB.Browser.for.SQLite-win64.zip: https://sqlitebrowser.org/dl/#nightly-builds

If you select the zip version, place the extract somewhere convenient, like your desktop. 

### For Mac:
I've installed by both traditional dmg and homebrew options. It's probably easier to use the dmg, but you're welcome to do homebrew if you're used to doing things that way. I've tested on a few different OS versions and they all seem to go smoothly.

If you have issues, try one of the nightly builds: https://sqlitebrowser.org/dl/#nightly-builds

## For live coding:
- Please download the *FarmersMarket.db from* our GitHub repo:
    - [👉 You can find it here 👈](https://github.com/UofT-DSI/sql/blob/main/05_src/sql/farmersmarket.db)
- Open it in SQLite with the "Open Database" button and navigate to wherever you have saved it

For questions or issues, please contact the SQL Module learning support team or email: courses.dsi@utoronto.ca.
