reg load HKLM\OFFLINE_SYSTEM "C:\Windows\System32\config\system"
reg load HKLM\OFFLINE_SOFTWARE "C:\Windows\System32\config\software"
reg load HKLM\OFFLINE_CURRENT_USER "C:\Users\netuser\NTUSER.DAT"

:: CurrentControlSet = ?
:: reg query "HKLM\OFFLINE_SYSTEM\Select"

:: ======================================================================================================================
:: Windows Update

reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AUOptions" /t REG_DWORD /d 2 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoRebootWithLoggedOnUsers" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "AlwaysAutoRebootAtScheduledTime" /t REG_DWORD /d 0 /f

:: Microsoft Malicious Software Removal Tool

reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\MRT" /v "DontOfferThroughWUAU" /t REG_DWORD /d 1 /f

:: ======================================================================================================================
:: script/Remove_Defender/Disable Mitigation.reg

:: VERY DANGEROUS SECTION

:: [HKLM\OFFLINE_SOFTWARE\Microsoft\WindowsMitigation]
:: "UserPreference"=dword:00000002
:: In-kernel Mitigations

:: [HKLM\OFFLINE_SYSTEM\ControlSet001\Control\Session Manager\kernel]
:: "MitigationAuditOptions"=hex:00,00,00,00,00,00,20,22,00,00,00,00,00,00,00,20,00,00,00,00,00,00,00,00
:: "MitigationOptions"=hex:00,22,22,20,22,20,22,22,20,00,00,00,00,20,00,20,00,00,00,00,00,00,00,00
:: "KernelSEHOPEnabled"=dword:00000000

:: Services Mitigations

:: [HKLM\OFFLINE_SYSTEM\ControlSet001\Control\SCMConfig]
:: "EnableSvchostMitigationPolicy"=hex(b):00,00,00,00,00,00,00,00

:: Remove Defender's Tamper Protection
:: [HKLM\OFFLINE_SOFTWARE\Microsoft\Windows Defender\Features]
:: "MpPlatformKillbitsFromEngine"=hex:00,00,00,00,00,00,00,00
:: "TamperProtectionSource"=dword:00000000
:: "MpCapability"=hex:00,00,00,00,00,00,00,00
:: "TamperProtection"=dword:00000000

:: [HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows\System]
:: "RunAsPPL"=dword:00000000

:: [HKLM\OFFLINE_SYSTEM\ControlSet001\Control\Lsa]
:: "LsaConfigFlags"=dword:00000000
:: "RunAsPPL"=dword:00000000
:: "RunAsPPLBoot"=dword:00000000
:: "LmCompatibilityLevel"=-

:: [HKLM\OFFLINE_SYSTEM\ControlSet001\Control\CI\Config]
:: "VulnerableDriverBlocklistEnable"=dword:00000000

:: ======================================================================================================================
:: script/Remove_Defender/Disable SmartScreen.reg

:: Disable SmartScreen for Microsoft Edge

reg add "HKLM\OFFLINE_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v "EnabledV9" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\PhishingFilter" /v "PreventOverride" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_CURRENT_USER\Software\Microsoft\Edge" /v "SmartScreenEnabled" /t REG_DWORD /d 0 /f

:: HKLM\OFFLINE_SYSTEM\ControlSet001\Control\CI\Policy

reg add "HKLM\OFFLINE_CURRENT_USER\Software\Microsoft\Edge\SmartScreenEnabled" /ve /t REG_DWORD /d 0 /f

:: Disable SmartScreen in File Explorer and Windows Shell

reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "off" /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f
reg delete "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows\System" /v "ShellSmartScreenLevel" /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Browser\AllowSmartScreen" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\SmartScreen\EnableSmartScreenInShell" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\SmartScreen\EnableAppInstallControl" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\SmartScreen\PreventOverrideForFilesInShell" /v "value" /t REG_DWORD /d 0 /f

:: Disable SmartScreen for Microsoft Store Apps

reg add "HKLM\OFFLINE_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AppHost" /v "PreventOverride" /t REG_DWORD /d 0 /f

:: Configure App Install Control

reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControlEnabled" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\SmartScreen" /v "ConfigureAppInstallControl" /t REG_SZ /d "Anywhere" /f

:: ======================================================================================================================
:: script/Remove_Defender/DisableAntivirusProtection.reg

:: disabling Antivirus

reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender" /v "AllowFastServiceStartup" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableLocalAdminMerge" /t REG_DWORD /d 1 /f

:: disable overwriting real time protection settings

reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableOnAccessProtection" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideRealtimeScanDirection" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableIOAVProtection" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableBehaviorMonitoring" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableIntrusionPreventionSystem" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableRealtimeMonitoring" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "RealtimeScanDirection" /t REG_DWORD /d 2 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableInformationProtectionControl" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIntrusionPreventionSystem" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRawWriteNotification" /t REG_DWORD /d 1 /f

reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowBehaviorMonitoring" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\WOW6432Node\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "DisableBlockAtFirstSeen" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Microsoft Antimalware\SpyNet" /v "SpyNetReporting" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Microsoft Antimalware\SpyNet" /v "LocalSettingOverrideSpyNetReporting" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\RemovalTools\MpGears" /v "HeartbeatTrackingIndex" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\RemovalTools\MpGears" /v "SpyNetReportingLocation" /t REG_SZ /d "0" /f

:: ======================================================================================================================

:: script/Remove_Defender/DisableDefenderPolicies.reg

:: Enforce Disabling of Windows Defender Antivirus Policy

reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowIOAVProtection" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender" /v "PUAProtection" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender" /v "ServiceKeepAlive" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender" /v "AllowFastServiceStartup" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableLocalAdminMerge" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender" /v "RandomizeScheduleTaskTimes" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowArchiveScanning" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowBehaviorMonitoring" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowCloudProtection" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowEmailScanning" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowFullScanOnMappedNetworkDrives" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowFullScanRemovableDriveScanning" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowIntrusionPreventionSystem" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowOnAccessProtection" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowRealtimeMonitoring" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowScanningNetworkFiles" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowScriptScanning" /v "value" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AllowUserUIAccess" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\AvgCPULoadFactor" /v "value" /t REG_DWORD /d 50 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\CheckForSignaturesBeforeRunningScan" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\CloudBlockLevel" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\CloudExtendedTimeout" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\DaysToRetainCleanedMalware" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\DisableCatchupFullScan" /v "value" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\DisableCatchupQuickScan" /v "value" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\EnableControlledFolderAccess" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\EnableLowCPUPriority" /v "value" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\EnableNetworkProtection" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\PUAProtection" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\RealTimeScanDirection" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\ScanParameter" /v "value" /t REG_DWORD /d 2 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\ScheduleScanDay" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\ScheduleScanTime" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\SignatureUpdateInterval" /v "value" /t REG_DWORD /d 24 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\Defender\SubmitSamplesConsent" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Exclusions" /v "DisableAutoExclusions" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /v "MpEnablePus" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /v "MpCloudBlockLevel" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /v "MpBafsExtendedTimeout" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\MpEngine" /v "EnableFileHashComputation" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\NIS\Consumers\IPS" /v "ThrottleDetectionEventsRate" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\NIS\Consumers\IPS" /v "DisableSignatureRetirement" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\NIS\Consumers\IPS" /v "DisableProtocolRecognition" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Policy Manager" /v "DisableScanningNetworkFiles" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableBehaviorMonitoring" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableOnAccessProtection" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableScanOnRealtimeEnable" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIOAVProtection" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableOnAccessProtection" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideRealtimeScanDirection" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableIOAVProtection" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableBehaviorMonitoring" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableIntrusionPreventionSystem" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "LocalSettingOverrideDisableRealtimeMonitoring" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "RealtimeScanDirection" /t REG_DWORD /d 2 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "IOAVMaxSize" /t REG_DWORD /d 1298 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableInformationProtectionControl" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableIntrusionPreventionSystem" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRawWriteNotification" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "LowCpuPriority" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableRestorePoint" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableArchiveScanning" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableScanningNetworkFiles" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupFullScan" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableCatchupQuickScan" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableEmailScanning" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableHeuristics" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Scan" /v "DisableReparsePointScanning" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "SignatureDisableNotification" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "RealtimeSignatureDelivery" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "ForceUpdateFromMU" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScheduledSignatureUpdateOnBattery" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "UpdateOnStartUp" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "SignatureUpdateCatchupInterval" /t REG_DWORD /d 2 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableUpdateOnStartupWithoutEngine" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "ScheduleTime" /t REG_DWORD /d 5184 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScanOnUpdate" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "DisableBlockAtFirstSeen" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "LocalSettingOverrideSpynetReporting" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SpynetReporting" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Spynet" /v "SubmitSamplesConsent" /t REG_DWORD /d 2 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\UX Configuration" /v "SuppressRebootNotification" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Controlled Folder Access" /v "EnableControlledFolderAccess" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Windows Defender Exploit Guard\Network Protection" /v "EnableNetworkProtection" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\WOW6432Node\Policies\Microsoft\Windows Defender" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Microsoft Antimalware" /v "ServiceKeepAlive" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Microsoft Antimalware" /v "AllowFastServiceStartup" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Microsoft Antimalware" /v "DisableRoutinelyTakingAction" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Microsoft Antimalware" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Microsoft Antimalware" /v "DisableAntiVirus" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Microsoft Antimalware\SpyNet" /v "SpyNetReporting" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Microsoft Antimalware\SpyNet" /v "LocalSettingOverrideSpyNetReporting" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableEnhancedNotifications" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "DisableGenericRePorts" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "WppTracingLevel" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Reporting" /v "WppTracingComponents" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SYSTEM\ControlSet001\Control\CI\Policy" /v "VerifiedAndReputablePolicyState" /t REG_DWORD /d 0 /f

:: ======================================================================================================================
:: script/Remove_Defender/DisableDefenderandSecurityCenterNotifications.reg

:: Disable Windows Defender Security Center Notifications

reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\WindowsDefenderSecurityCenter\DisableEnhancedNotifications" /v "value" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\WindowsDefenderSecurityCenter\DisableNotifications" /v "value" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\WindowsDefenderSecurityCenter\HideWindowsSecurityNotificationAreaControl" /v "value" /t REG_DWORD /d 1 /f

:: Disable Windows Security Center Notifications

reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Security Center" /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\Security Center" /v "FirstRunDisabled" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\Security Center" /v "AntiVirusOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\Security Center" /v "FirewallOverride" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableEnhancedNotifications" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender Security Center\Notifications" /v "DisableNotifications" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Notifications\Settings\Windows.SystemToast.SecurityAndMaintenance" /v "Enabled" /t REG_DWORD /d 0 /f

:: ======================================================================================================================
:: script/Remove_Defender/RemovalofWindowsDefenderAntivirus.reg

reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{2781761E-28E0-4109-99FE-B9D127C57AFE}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{195B4D07-3DE2-4744-BBF2-D90121AE785B}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{361290c0-cb1b-49ae-9f3e-ba1cbe5dab35}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{45F2C32F-ED16-4C94-8493-D72EF93A051B}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{6CED0DAA-4CDE-49C9-BA3A-AE163DC3D7AF}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{8a696d12-576b-422e-9712-01b9dd84b446}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{8C9C0DB7-2CBA-40F1-AFE0-C55740DD91A0}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{A2D75874-6750-4931-94C1-C99D3BC9D0C7}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{A7C452EF-8E9F-42EB-9F2B-245613CA0DC9}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{DACA056E-216A-4FD1-84A6-C306A017ECEC}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{E3C9166D-1D39-4D4E-A45D-BC7BE9B00578}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{F6976CF5-68A8-436C-975A-40BE53616D59}" /f

reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{2781761E-28E0-4109-99FE-B9D127C57AFE}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{195B4D07-3DE2-4744-BBF2-D90121AE785B}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{361290c0-cb1b-49ae-9f3e-ba1cbe5dab35}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{45F2C32F-ED16-4C94-8493-D72EF93A051B}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{6CED0DAA-4CDE-49C9-BA3A-AE163DC3D7AF}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{8a696d12-576b-422e-9712-01b9dd84b446}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{8C9C0DB7-2CBA-40F1-AFE0-C55740DD91A0}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{A2D75874-6750-4931-94C1-C99D3BC9D0C7}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{A7C452EF-8E9F-42EB-9F2B-245613CA0DC9}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{DACA056E-216A-4FD1-84A6-C306A017ECEC}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{E3C9166D-1D39-4D4E-A45D-BC7BE9B00578}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{F6976CF5-68A8-436C-975A-40BE53616D59}" /f

:: Defender Loggers

reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Control\WMI\Autologger\DefenderAuditLogger" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Control\WMI\Autologger\DefenderApiLogger" /f

:: ======================================================================================================================
:: script/Remove_Defender/RemoveDefenderTasks.reg

reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{0ACC9108-2000-46C0-8407-5FD9F89521E8}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{1D77BCC8-1D07-42D0-8C89-3A98674DFB6F}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{4A9233DB-A7D3-45D6-B476-8C7D8DF73EB5}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows NT\CurrentVersion\Schedule\TaskCache\Tasks\{B05F34EE-83F2-413D-BC1D-7D5BD6E98300}" /f

:: ======================================================================================================================
:: script/Remove_Defender/RemoveServices.reg

:: Remove Defender and Windows Security Services

reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\MsSecCore" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\wscsvc" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\WdNisDrv" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\WdNisSvc" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\WdFilter" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\WdBoot" /f

reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SgrmAgent" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SgrmBroker" /f

reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\WinDefend" /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender Security Center\App and Browser protection" /v "DisallowExploitProtectionOverride" /t REG_DWORD /d 1 /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\MsSecFlt" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\MsSecWfp" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\whesvc" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\WindowsRuntime\Server\WebThreatDefSvc" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\webthreatdefsvc" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\webthreatdefusersvc" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost\WebThreatDefense" /f

reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\PlutonHsp2" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\PlutonHeci" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\Hsp" /f

:: ======================================================================================================================
:: script/Remove_Defender/RemoveShellAssociation.reg

reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\WinDefend" /f
reg delete "HKLM\OFFLINE_CURRENT_USER\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\windowsdefender" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\AppUserModelId\Windows.Defender" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\AppUserModelId\Microsoft.Windows.Defender" /f

reg delete "HKLM\OFFLINE_SOFTWARE\Classes\AppX9kvz3rdv8t7twanaezbwfcdgrbg3bck0" /f
reg delete "HKLM\OFFLINE_CURRENT_USER\Software\Classes\AppX9kvz3rdv8t7twanaezbwfcdgrbg3bck0" /f

reg delete "HKLM\OFFLINE_SOFTWARE\Classes\Folder\shell\WindowsDefender"
reg delete "HKLM\OFFLINE_CURRENT_USER\Software\Classes\Folder\shell\WindowsDefender"

reg delete "HKLM\OFFLINE_SOFTWARE\Classes\Local Settings\MrtCache\C:%%5CWindows%%5CSystemApps%%5CMicrosoft.Windows.AppRep.ChxApp_cw5n1h2txyewy%%5Cresources.pri" /f
reg delete "HKLM\OFFLINE_CURRENT_USER\Software\Classes\Local Settings\MrtCache\C:%%5CWindows%%5CSystemApps%%5CMicrosoft.Windows.AppRep.ChxApp_cw5n1h2txyewy%%5Cresources.pri" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WindowsDefender" /f
reg delete "HKLM\OFFLINE_CURRENT_USER\Software\Classes\WindowsDefender" /f

reg delete "HKLM\OFFLINE_CURRENT_USER\Software\Classes\AppX9kvz3rdv8t7twanaezbwfcdgrbg3bck0" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WindowsDefender" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Control\Ubpm" /v "CriticalMaintenance_DefenderCleanup" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Control\Ubpm" /v "CriticalMaintenance_DefenderVerification" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices\Static\System" /v "WindowsDefender-1" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices\Static\System" /v "WindowsDefender-2" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices\Static\System" /v "WindowsDefender-3" /f

:: ======================================================================================================================
:: script/Remove_Defender/RemoveSignatureUpdates.reg

:: this file disables Signature Updates in Windows Defender

reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "SignatureDisableNotification" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "RealtimeSignatureDelivery" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "ForceUpdateFromMU" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScheduledSignatureUpdateOnBattery" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "UpdateOnStartUp" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "SignatureUpdateCatchupInterval" /t REG_DWORD /d 2 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableUpdateOnStartupWithoutEngine" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "ScheduleTime" /t REG_DWORD /d 5184 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows Defender\Signature Updates" /v "DisableScanOnUpdate" /t REG_DWORD /d 1 /f

:: ======================================================================================================================
:: script/Remove_Defender/RemoveStartupEntries.reg

:: Remove Defender's Startup Entries

reg delete "HKLM\OFFLINE_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Windows Defender" /f
reg delete "HKLM\OFFLINE_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "Windows Defender" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StartupApproved\Run" /v "SecurityHealth" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "WindowsDefender" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "SecurityHealth" /f

:: ======================================================================================================================
:: script/Remove_Defender/RemoveWindowsWebThreat.reg

reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{E48B2549-D510-4A76-8A5F-FC126A6215F0}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{E48B2549-D510-4A76-8A5F-FC126A6215F0}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Microsoft.OneCore.WebThreatDefense.Service.UserSessionServiceManager" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Microsoft.OneCore.WebThreatDefense.ThreatExperienceManager.ThreatExperienceManager" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Microsoft.OneCore.WebThreatDefense.ThreatResponseEngine.ThreatDecisionEngine" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\WindowsRuntime\ActivatableClassId\Microsoft.OneCore.WebThreatDefense.Configuration.WTDUserSettings" /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\WebThreatDefense\AuditMode" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\WebThreatDefense\NotifyUnsafeOrReusedPassword" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\WebThreatDefense\ServiceEnabled" /v "value" /t REG_DWORD /d 0 /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\webthreatdefsvc" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\webthreatdefusersvc" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost\WebThreatDefense" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost" /v "WebThreatDefense" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices\Static\System" /v "WebThreatDefSvc_Allow_In" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices\Static\System" /v "WebThreatDefSvc_Allow_Out" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices\Static\System" /v "WebThreatDefSvc_Block_In" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices\Static\System" /v "WebThreatDefSvc_Block_Out" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices\Configurable\System" /v "{2A5FE97D-01A4-4A9C-8241-BB3755B65EE0}" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices\Configurable\System" /v "72e33e44-dc4c-40c5-a688-a77b6e988c69" /f
reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices\Configurable\System" /v "b23879b5-1ef3-45b7-8933-554a4303d2f3" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows NT\CurrentVersion\Svchost" /v "WebThreatDefense" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\WebThreatDefense" /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\WebThreatDefense\AuditMode" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\WebThreatDefense\NotifyUnsafeOrReusedPassword" /v "value" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\PolicyManager\default\WebThreatDefense\ServiceEnabled" /v "value" /t REG_DWORD /d 0 /f
reg delete "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows\WTDS" /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows\WTDS\Components" /v "NotifyPasswordReuse" /t REG_DWORD /d 0 /f
reg add "HKLM\OFFLINE_SOFTWARE\Policies\Microsoft\Windows\WTDS\Components" /v "NotifyMalicious" /t REG_DWORD /d 0 /f

:: ======================================================================================================================

:: script/Remove_Defender/RemoverofDefenderContextMenu.reg

reg delete "HKLM\OFFLINE_SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ShellServiceObjects\{900c0763-5cad-4a34-bc1f-40cd513679d5}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ShellServiceObjects\{900c0763-5cad-4a34-bc1f-40cd513679d5}" /f

:: Remove "Scan with Defender" Context Menu

reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows Defender" /f

reg delete "HKLM\OFFLINE_SOFTWARE\Classes\Folder\shell\WindowsDefender" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\DesktopBackground\Shell\WindowsSecurity" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\Folder\shell\WindowsDefender\Command" /f

reg delete "HKLM\OFFLINE_CURRENT_USER\Software\Classes\Folder\shell\WindowsDefender" /f
reg delete "HKLM\OFFLINE_CURRENT_USER\Software\Classes\DesktopBackground\Shell\WindowsSecurity" /f
reg delete "HKLM\OFFLINE_CURRENT_USER\Software\Classes\Folder\shell\WindowsDefender\Command" /f

:: ======================================================================================================================
:: script/Remove_Defender/WindowsSettingsPageVisibility.reg

reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "SettingsPageVisibility" /t REG_SZ /d "hide:windowsdefender;" /f

:: ======================================================================================================================
:: script/Remove_SecurityComp/Remove_SecurityComp.reg

:: removes data and kills Security Health Service App

reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows Security Health" /f
reg delete "HKLM\OFFLINE_CURRENT_USER\Software\Microsoft\Windows Security Health" /f
reg add "HKLM\OFFLINE_CURRENT_USER\Software\Microsoft\Windows Security Health\State" /v "Disabled" /t REG_DWORD /d 1 /f
reg add "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows Security Health\Platform" /v "Registered" /t REG_DWORD /d 0 /f

:: removal of Security Center from Action Center

reg delete "HKLM\OFFLINE_SOFTWARE\Classes\CLSID\{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Classes\WOW6432Node\CLSID\{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\WOW6432Node\Classes\CLSID\{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}" /f
reg delete "HKLM\OFFLINE_SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer\ControlPanel\NameSpace\{BB64F8A7-BEE7-4E1A-AB8D-7D8273F7FDB6}" /f

:: Remove Windows Security Health Service

reg delete "HKLM\OFFLINE_SYSTEM\ControlSet001\Services\SecurityHealthService" /f

:: ======================================================================================================================

reg unload HKLM\OFFLINE_SYSTEM
reg unload HKLM\OFFLINE_SOFTWARE
reg unload HKLM\OFFLINE_CURRENT_USER

pause
