# Clean OOBE aka. Fuck Defender

**Make the fucking Windows not that fucking stupid**

> DO NOT TOUCHING MY FUCKING FILES  
> DO NOT AUTO RESTART MY FUCKING COMPUTER  
> AND DONT FUCKING ASK ME THE FUCKING FILE IS SUSPECT AS YOUR FUCKING MOM

---

# Very Important disclaimer

**This project is directly steal from [ionuttbara/windows-defender-remover](https://github.com/ionuttbara/windows-defender-remover)**

**This project is basically steal from [shiitake/win6x_registry_tweak](https://github.com/shiitake/win6x_registry_tweak)**


--- 

# Usage

There are two parts of this project

1. `OOBE.reg`: Fork from `ionuttbara/windows-defender-remover` as my own baseline.
2. `FuckDefender.exe`: Use `DISM` remove defender suit packages. Works with win10 only.

**You don't have to use both tool.**

## OOBE

| name                       | usage                                                                    |
|----------------------------|--------------------------------------------------------------------------|
| `OOBE.reg`                 | Apply for online system, Need disable tamper protect manually.           |
| `OOBE-tamper.reg`          | Apply with `WinNTSetup` when fresh install, Auto disable tamper protect. |
| `OOBE-install.bat`         | Batch former of `OOBE.reg`, Execute gpudate at end.                      |
| `OOBE-offline.bat`         | Apply in offline mode with WePE                                          |
| `disable-auto-restart.bat` | Disable WUAU and MRT, Batch former, Execute gpudate at end.              |
| `disable-auto-restart.reg` | Disable WUAU and MRT, Registy former, Need manually reboot or gpupdate.  |

## FuckDefender

| name                                       | usage                                   |
|--------------------------------------------|-----------------------------------------|
| `fuckdefender.exe`                         | Use `Windows-Defender` as name1         |
| `fuckdefender.exe /l`                      | List all installed package              |
| `fuckdefender.exe [name1] [name2] [nameN]` | Search names (contains) and remove them |

## Extra Step for Windows 11

> Because windows 11 is pure stupid fucking shit. So it's very very very very very very very very very very very unstable.

As example as Windows 10. When you turn off tamper protect, Apply `OOBE.reg` or execute `FuckDefender.exe` will success, Natural as breath.

But for Windows 11 will deny access. You have to boot into PE modify hive offline by `reg load`. So

1. Use `WinNTSetup` tweak feature apply `OOBE-tamper.reg` before SysPrep, Before any permission interference (This is stable).
2. Use `OOBE-offline.bat` to modify in offline mode. Because HKCR HKCU is virtual view, The offline mode may cause wired result.

# Changelog

## 2.0.0

- Fork `ionuttbara/windows-defender-remover` as `OOBE.reg`
- Add `OOBE-offline.reg` variant for `WinNTSetup` import
- Add `OOBE-offline.bat` variant for WePE offline processing

## 1.0.0

- Use `dism` instead `pkgmgr`
- Remove `Win32Security`
- Remove offline mode
- Remove dry run mode
- Remove backup mode
- Remove Herobrine
