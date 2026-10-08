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

There to parts of this project:

1. `OOBE.reg`: Fork from `ionuttbara/windows-defender-remover` as my own baseline.
2. `FuckDefender.exe`: Use `DISM` remove defender suit packages. Works with win10 only.

## Typical

1. Run with Administrator, Press Enter
2. Apply OOBE.reg
3. reboot

## More usage

### List packages

list all package in your system  
```FuckDefender.exe /l```

### Search and Remove

Args are name search with contains  
```FuckDefender.exe [name-1] [name-2] [name-3] ...```

# Changelog

## 1.0.0

- Use `dism` instead `pkgmgr`
- Remove `Win32Security`
- Remove offline mode
- Remove dry run mode
- Remove backup mode
- Remove Herobrine

# How it work

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
