# FuckDefender

**这个项目基本是从 [这里](https://github.com/shiitake/win6x_registry_tweak) 偷的**

## 介绍

- 使用 `dism` 替换掉了 `pkgmgr`
- 移除了 `Win32Security`, 经测试在Win10 21H1不需要这个依赖也可以执行
- 移除离线模式
- 移除备份功能
- 移除跳过删除
- 除了卸载包把所有功能都删了
- 移除 Herobrine

## 用法

### 直接双击

直接双击 (**个屁，需要右键管理员运行**)  
默认无参数情况下会以`Windows-Defender`为搜索字，并删除。

### 以参数为名

参数会直接作为名字搜索，并删除
```FuckDefender.exe [name-1] [name-2] [name-3] ...```

### 列出所有包

使用唯一参数`/l`，列出系统中所有的包  
```FuckDefender.exe /l```

## 工作原理

直接使用

```
dism /online /remove-package /package-name:Oh-MaMaMiYa
```

会得到一个错误5, 访问拒绝. 从我刚刚偷过来的代码研究得出，如果你先删掉这个玩意

```
HKLM\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\Oh-MaMaMiYa\Owner
```

这时候你就可以用`dism`或`pkgmgr`干掉他
