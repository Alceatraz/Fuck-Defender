using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security.AccessControl;
using System.Security.Principal;
using Microsoft.Win32;

namespace FuckDefender
{
    public static class Program
    {
        public static void Main(string[] args) {

            switch (args.Length) {

                case 0:
                    Remove(new[] {"Windows-Defender"});
                    break;

                case 1:
                    if (args[0].Equals("/l")) {
                        foreach (var subKeyName in ListPackages()) {
                            Console.Out.WriteLine(subKeyName);
                        }
                        break;
                    }
                    else {
                        goto default;
                    }

                default:
                    Remove(args);
                    break;
            }
        }

        private static void Remove(string[] searchNames) {

            ArrayList pending = new();

            foreach (var packageName in ListPackages()) {
                foreach (var searchName in searchNames) {
                    if (packageName.Contains(searchName)) {
                        pending.Add(packageName);
                    }
                }
            }

            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.Out.WriteLine("Marked packages: {0}", pending.Count);
            Console.ResetColor();

            foreach (var packageName in pending) {
                Console.Out.WriteLine(packageName);
            }

            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.Out.WriteLine("Press Enter to uninstall");
            Console.ResetColor();

            Console.ReadLine();

            try {

                var currentUser = WindowsIdentity.GetCurrent().User ?? throw new InvalidOperationException("[FAILED] Get current user failed");
                var packagesRegistry = GetRegistry();

                Console.ForegroundColor = ConsoleColor.Cyan;
                Console.Out.WriteLine(">> Remove registry");
                Console.ResetColor();

                foreach (string packageName in pending) {

                    Console.Out.WriteLine(packageName);

                    var packageKey = packagesRegistry.OpenSubKey(packageName, RegistryKeyPermissionCheck.ReadWriteSubTree, RegistryRights.TakeOwnership | RegistryRights.ReadKey | RegistryRights.ReadPermissions) ?? throw new InvalidOperationException("[FAILED] Get Package Key failed " + packageName);

                    var packageKeySecurity = packageKey.GetAccessControl(AccessControlSections.Owner);
                    packageKeySecurity.SetOwner(currentUser);
                    packageKeySecurity.AddAccessRule(new RegistryAccessRule(currentUser, RegistryRights.FullControl, AccessControlType.Allow));
                    packageKey.SetAccessControl(packageKeySecurity);

                    var containsVisibility = packageKey.GetSubKeyNames().Any(packageSubKeyNames => packageSubKeyNames.Equals("Visibility"));

                    if (containsVisibility) {
                        packageKey.SetValue("Visibility", 0x00000001, RegistryValueKind.DWord);
                    }

                    var containsOwner = packageKey.GetSubKeyNames().Any(packageSubKeyNames => packageSubKeyNames.Equals("Owners"));

                    if (!containsOwner)
                        continue;

                    packageKey.DeleteSubKey("Owners");

                    packageKey.Close();
                }


                Console.ForegroundColor = ConsoleColor.Cyan;
                Console.Out.WriteLine(">> Uninstall package Phase 1");
                Console.ResetColor();
                foreach (string packageName in pending) {
                    Console.Out.WriteLine(packageName);
                    RemovePackage(packageName);
                }


                Console.ForegroundColor = ConsoleColor.Cyan;
                Console.Out.WriteLine(">> Uninstall package Phase 2");
                Console.ResetColor();
                foreach (string packageName in pending) {
                    Console.Out.WriteLine(packageName);
                    RemovePackage(packageName);
                }
            }
            catch (Exception exception) {
                Console.Out.WriteLine("[FAILED] Exception capture during uninstall");
                Console.Out.WriteLine(exception);
                return;
            }

            Console.ForegroundColor = ConsoleColor.Cyan;
            Console.Out.WriteLine("Marked package uninstalled");
            Console.ResetColor();

            Console.Out.WriteLine();

            Console.ForegroundColor = ConsoleColor.Yellow;
            Console.Out.WriteLine("Press Enter to exit");
            Console.ResetColor();

            Console.ReadLine();

            Console.Out.WriteLine();

        }


        private static RegistryKey GetRegistry() {
            return Registry.LocalMachine.OpenSubKey(@"Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\Packages\") ?? throw new InvalidOperationException("[FAILED] List registry failed");
        }

        private static IEnumerable<string> ListPackages() {
            return GetRegistry().GetSubKeyNames();
        }

        private static void RemovePackage(string packageName) {
            var process = new Process {
                StartInfo = {
                    FileName = "dism.exe",
                    Arguments = "/online /norestart /remove-package /packagename:" + packageName,
                    WindowStyle = ProcessWindowStyle.Hidden
                }
            };
            process.Start();
            process.WaitForExit();
        }
    }
}