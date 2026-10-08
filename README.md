# FuckDefender

**This project is basically steal from [This](https://github.com/shiitake/win6x_registry_tweak)**

## Description

- Use `dism` instead `pkgmgr`
- Remove `Win32Security`, Working fine in Win10 without it
- Remove offline mode
- Remove backup mode
- Remove skip delete mode
- Remove everything but only allow remove package named in args
- Remove Herobrine

## Usage

### Direct run

Just double click (**In fact you need `Right Click` And `Run with Administrator`**)  
It's will uninstall `Windows-Defender` at default args (Or no args).

### Search With Args

Args are name search with contains  
```FuckDefender.exe [name-1] [name-2] [name-3] ...```

### List All Package

With only one argument `/l` to list all package in your system  
```FuckDefender.exe /l```

--- 

# Make Windows not that fucking stupid

> DO NOT AUTO RESTART MY FUCKING COMPUTER

```batch
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AUOptions /t REG_DWORD /d 2 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoRebootWithLoggedOnUsers /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v AlwaysAutoRebootAtScheduledTime /t REG_DWORD /d 0 /f
reg add "HKLM\SOFTWARE\Policies\Microsoft\MRT" /v DontOfferThroughWUAU /t REG_DWORD /d 1 /f

gpupdate /force
```

---

## How it work

If you directly use

```
dism /online /remove-package /package-name:Oh-MaMaMiYa
```

You will got an error code 5, Access Denied. But depends what I learned (Steal in fact) Remove the sub folder (Called RegistryKey in Registry)
:

```
HKLM\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\Oh-MaMaMiYa\Owner
```

Then You can remove it by `dism` or `pkgmgr`
