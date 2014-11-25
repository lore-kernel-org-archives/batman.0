Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1416874968.1632.13.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Tue, 25 Nov 2014 01:22:48 +0100
In-Reply-To: <1416867973.1632.9.camel@gmail.com>
References: <1416347918.9920.10.camel@gmail.com>
 <546DA710.2040802@hundeboll.net> <1416476912.2747.5.camel@gmail.com>
 <546DC214.6050908@hundeboll.net> <1416486149.2747.9.camel@gmail.com>
 <546DE067.8070807@hundeboll.net> <1416688754.2696.3.camel@gmail.com>
 <5472EB56.8000700@hundeboll.net> <1416825873.2678.2.camel@gmail.com>
 <1416831279.2678.10.camel@gmail.com> <1416863721.1632.3.camel@gmail.com>
 <1416867973.1632.9.camel@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-eUQ27fnIuCX1rZ/O/qi9"
Mime-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] kernel BUG at net/core/skbuff.c:100
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--=-eUQ27fnIuCX1rZ/O/qi9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin, hi all

The next crash with 3.17.3 =E2=80=93 I=E2=80=99m kind of speechless. The he=
avy Load is
due to compiling with nice -n 19.

I set the gw mode to client. I need sleep. 3.17.4 compiles =E2=80=A6

Kind regards

Philipp

________________________
Freifunk Rheinland e. V.
=E2=80=93 Funkzelle Wuppertal =E2=80=93


  SYSTEM MAP: /boot/System.map                                        =20
DEBUG KERNEL: /usr/src/linux-3.17.3-gentoo/vmlinux (3.17.3-gentoo)
    DUMPFILE: vmcore_20141125003014
        CPUS: 1
        DATE: Thu Jan  1 01:00:00 1970
      UPTIME: 00:39:55
LOAD AVERAGE: 1.59, 1.56, 1.23
       TASKS: 152
    NODENAME: wolke
     RELEASE: 3.17.3-gentoo
     VERSION: #1 SMP Wed Nov 19 15:42:49 CET 2014
     MACHINE: x86_64  (2593 Mhz)
      MEMORY: 511.6 MB
       PANIC: "kernel BUG at net/core/skbuff.c:100!"
         PID: 2036
     COMMAND: "fastd"
        TASK: ffff880019cef290  [THREAD_INFO: ffff88001768c000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 2036   TASK: ffff880019cef290  CPU: 0   COMMAND: "fastd"
 #0 [ffff88001fc03980] machine_kexec at ffffffff8103aace
 #1 [ffff88001fc039e0] crash_kexec at ffffffff810bfa43
 #2 [ffff88001fc03ab0] oops_end at ffffffff810060f8
 #3 [ffff88001fc03ae0] die at ffffffff81006593
 #4 [ffff88001fc03b10] do_trap at ffffffff81002ef2
 #5 [ffff88001fc03b70] do_error_trap at ffffffff8100305d
 #6 [ffff88001fc03c30] do_invalid_op at ffffffff81003a7b
 #7 [ffff88001fc03c40] invalid_op at ffffffff8180e79e
    [exception RIP: skb_panic+94]
    RIP: ffffffff81806a38  RSP: ffff88001fc03cf8  RFLAGS: 00010296
    RAX: 000000000000008b  RBX: ffff88001a2bbd20  RCX: 0000000000000092
    RDX: 00000000000000c2  RSI: 0000000000000246  RDI: 0000000000000246
    RBP: ffff88001fc03d18   R8: 0000000000000000   R9: 0000000000000000
    R10: ffffffff81a6b240  R11: 0000000000000000  R12: 0000000000000564
    R13: ffff88001fc03da0  R14: ffff88000f877000  R15: ffff880002c56862
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ffff88001fc03d20] skb_put at ffffffff8162c921
 #9 [ffff88001fc03d30] batadv_frag_skb_buffer at ffffffffa001be32 [batman_a=
dv]
#10 [ffff88001fc03d90] batadv_recv_frag_packet at ffffffffa0026283 [batman_=
adv]
#11 [ffff88001fc03dd0] batadv_batman_skb_recv at ffffffffa001ff15 [batman_a=
dv]
#12 [ffff88001fc03e10] __netif_receive_skb_core at ffffffff8163c752
#13 [ffff88001fc03e80] __netif_receive_skb at ffffffff8163cc91
#14 [ffff88001fc03ea0] process_backlog at ffffffff8163cd7e
#15 [ffff88001fc03ef0] net_rx_action at ffffffff8163d531
#16 [ffff88001fc03f50] __do_softirq at ffffffff81052e28
#17 [ffff88001fc03fb0] do_softirq_own_stack at ffffffff8180e99c
--- <IRQ stack> ---
#18 [ffff88001768fd10] do_softirq_own_stack at ffffffff8180e99c
    [exception RIP: tun_get_user+1043]
    RIP: ffffffffa00098e3  RSP: 0000000000000001  RFLAGS: ff880000000586
    RAX: ffffffff8163bca4  RBX: ffff88001768fd58  RCX: ffff880017638780
    RDX: 0000000000000000  RSI: ffff880017638780  RDI: 0000000000000586
    RBP: ffffffff8163b9d4   R8: ffff88001768fd88   R9: ffff880017638780
    R10: ffff880017638780  R11: ffffffff81053065  R12: ffff88001768fd58
    R13: 0000000000000586  R14: ffff88001770f700  R15: 0000000000000000
    ORIG_RAX: ffff88001768fe38  CS: ffffea00005dbef0  SS: 0000
bt: WARNING: possibly bogus exception frame
#19 [ffff88001768fe40] tun_chr_aio_write at ffffffffa0009e0b [tun]
#20 [ffff88001768fe70] do_sync_write at ffffffff8115fdb5
#21 [ffff88001768ff00] vfs_write at ffffffff81160ada
#22 [ffff88001768ff40] sys_write at ffffffff81160fea
#23 [ffff88001768ff80] system_call_fastpath at ffffffff8180ce69
    RIP: 00007f0c818c037d  RSP: 00007fff6da33dc0  RFLAGS: 00010206
    RAX: 0000000000000001  RBX: ffffffff8180ce69  RCX: 0000000000000000
    RDX: 0000000000000586  RSI: 0000000000c74300  RDI: 0000000000000009
    RBP: 0000000000000586   R8: 00007f0c818a9400   R9: 00007fff6da34508
    R10: 00007fff6da34c4f  R11: 0000000000000293  R12: 0000000000c7dee8
    R13: 0000000000000001  R14: 0000000000c742f0  R15: 0000000000c616e0
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
crash> log
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.17.3-gentoo (root@wolke) (gcc version 4.7.3 =
(Gentoo 4.7.3-r1 p1.4, pie-0.5.5) ) #1 SMP Wed Nov 19 15:42:49 CET 2014
[    0.000000] Command line: root=3D/dev/vda1 raid=3Dnoautodetect crashkern=
el=3D64M
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dbff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000000009dc00-0x000000000009ffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffdfff] usabl=
e
[    0.000000] BIOS-e820: [mem 0x000000001fffe000-0x000000001fffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reser=
ved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reser=
ved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Bochs Bochs, BIOS Bochs 01/01/2007
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> rese=
rved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn =3D 0x1fffe max_arch_pfn =3D 0x400000000
[    0.000000] MTRR default type: write-back
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 00E0000000 mask FFE0000000 uncachable
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x70406, new 0x7010600070106
[    0.000000] found SMP MP-table at [mem 0x000fdaf0-0x000fdaff] mapped at =
[ffff8800000fdaf0]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 2457=
6
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x020d7000, 0x020d7fff] PGTABLE
[    0.000000] BRK [0x020d8000, 0x020d8fff] PGTABLE
[    0.000000] BRK [0x020d9000, 0x020d9fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x1fc00000-0x1fdfffff]
[    0.000000]  [mem 0x1fc00000-0x1fdfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x1c000000-0x1fbfffff]
[    0.000000]  [mem 0x1c000000-0x1fbfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x1bffffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x1bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x1fe00000-0x1fffdfff]
[    0.000000]  [mem 0x1fe00000-0x1fffdfff] page 4k
[    0.000000] BRK [0x020da000, 0x020dafff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FD990 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x000000001FFFE5B0 000038 (v01 BOCHS  BXPCRSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x000000001FFFFF80 000074 (v01 BOCHS  BXPCFACP 00=
000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x000000001FFFE5F0 001121 (v01 BXPC   BXDSDT   00=
000001 INTL 20100528)
[    0.000000] ACPI: FACS 0x000000001FFFFF40 000040
[    0.000000] ACPI: SSDT 0x000000001FFFFEA0 00009E (v01 BOCHS  BXPCSSDT 00=
000001 BXPC 00000001)
[    0.000000] ACPI: APIC 0x000000001FFFFDB0 000078 (v01 BOCHS  BXPCAPIC 00=
000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x000000001FFFFD70 000038 (v01 BOCHS  BXPCHPET 00=
000001 BXPC 00000001)
[    0.000000] ACPI: SSDT 0x000000001FFFF720 000644 (v01 BXPC   BXSSDTPC 00=
000001 INTL 20100528)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000001fffdfff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x1fffdfff]
[    0.000000]   NODE_DATA [mem 0x1fffa000-0x1fffdfff]
[    0.000000] Reserving 64MB of memory at 432MB for crashkernel (System RA=
M: 511MB)
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:1fff9001, primary cpu clock
[    0.000000]  [ffffea0000000000-ffffea00007fffff] PMD -> [ffff88001a80000=
0-ffff88001affffff] on node 0
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00001000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   empty
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00001000-0x0009cfff]
[    0.000000]   node   0: [mem 0x00100000-0x1fffdfff]
[    0.000000] On node 0 totalpages: 130970
[    0.000000]   DMA zone: 64 pages used for memmap
[    0.000000]   DMA zone: 21 pages reserved
[    0.000000]   DMA zone: 3996 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 1984 pages used for memmap
[    0.000000]   DMA32 zone: 126974 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0xb008
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0xff] dfl dfl lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x01] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-=
23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level=
)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level=
)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ5 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] ACPI: IRQ10 used by override.
[    0.000000] ACPI: IRQ11 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.000000] smpboot: Allowing 1 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x0009d000-0x0009dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x0009e000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000effff]
[    0.000000] PM: Registered nosave memory: [mem 0x000f0000-0x000fffff]
[    0.000000] e820: [mem 0x20000000-0xfeffbfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on KVM
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1 nr_=
node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88001fc00000 s79744 r8192=
 d22656 u2097152
[    0.000000] pcpu-alloc: s79744 r8192 d22656 u2097152 alloc=3D1*2097152
[    0.000000] pcpu-alloc: [0] 0=20
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 1fc0cf80
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Tota=
l pages: 128901
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=3D/dev/vda1 raid=3Dnoautodetect cr=
ashkernel=3D64M
[    0.000000] PID hash table entries: 2048 (order: 2, 16384 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing=
!
[    0.000000] Memory: 432620K/523880K available (8263K kernel code, 863K r=
wdata, 2684K rodata, 1108K init, 896K bss, 91260K reserved)
[    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1, N=
odes=3D1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=3D64 to nr_cpu_ids=3D1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=
=3D1
[    0.000000] NR_IRQS:4352 nr_irqs:256 0
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Detected 2593.748 MHz processor
[    0.002000] Calibrating delay loop (skipped) preset value.. 5187.49 Bogo=
MIPS (lpj=3D2593748)
[    0.002005] pid_max: default: 32768 minimum: 301
[    0.002393] ACPI: Core revision 20140724
[    0.003739] ACPI: All ACPI Tables successfully acquired
[    0.004441] Security Framework initialized
[    0.004809] SELinux:  Initializing.
[    0.005011] SELinux:  Starting in permissive mode
[    0.005045] Dentry cache hash table entries: 65536 (order: 7, 524288 byt=
es)
[    0.005748] Inode-cache hash table entries: 32768 (order: 6, 262144 byte=
s)
[    0.006135] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.006549] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 by=
tes)
[    0.007238] Initializing cgroup subsys freezer
[    0.008079] mce: CPU supports 10 MCE banks
[    0.008491] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
               Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.026277] Freeing SMP alternatives memory: 28K (ffffffff81fee000 - fff=
fffff81ff5000)
[    0.030669] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.031002] smpboot: CPU0: Intel Westmere E56xx/L56xx/X56xx (Nehalem-C) =
(fam: 06, model: 2c, stepping: 01)
[    0.032000] Performance Events: unsupported p6 CPU model 44 no PMU drive=
r, software events only.
[    0.032522] x86: Booted up 1 node, 1 CPUs
[    0.033004] smpboot: Total of 1 processors activated (5187.49 BogoMIPS)
[    0.034267] devtmpfs: initialized
[    0.035367] RTC time: 22:47:53, date: 11/24/14
[    0.036009] NET: Registered protocol family 16
[    0.036494] cpuidle: using governor ladder
[    0.036809] cpuidle: using governor menu
[    0.037085] ACPI: bus type PCI registered
[    0.037498] PCI: Using configuration type 1 for base access
[    0.040447] kworker/u2:0 (15) used greatest stack depth: 14664 bytes lef=
t
[    0.041100] ACPI: Added _OSI(Module Device)
[    0.041421] ACPI: Added _OSI(Processor Device)
[    0.041738] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.042004] ACPI: Added _OSI(Processor Aggregator Device)
[    0.043755] ACPI: Interpreter enabled
[    0.044028] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S1_] (20140724/hwxface-580)
[    0.045429] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S2_] (20140724/hwxface-580)
[    0.046332] ACPI: (supports S0 S3 S4 S5)
[    0.047005] ACPI: Using IOAPIC for interrupt routing
[    0.047459] PCI: Ignoring host bridge windows from ACPI; if necessary, u=
se "pci=3Duse_crs" and report a bug
[    0.051042] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.051560] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I]
[    0.052048] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.052558] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7] (ign=
ored)
[    0.052560] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff] (ign=
ored)
[    0.052561] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bff=
ff] (ignored)
[    0.052563] acpi PNP0A03:00: host bridge window [mem 0xe0000000-0xfebfff=
ff] (ignored)
[    0.052565] PCI: root bus 00: using default resources
[    0.052567] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    0.053067] PCI host bridge to bus 0000:00
[    0.054046] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.054567] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.055045] pci_bus 0000:00: root bus resource [mem 0x00000000-0xfffffff=
fff]
[    0.055696] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.056486] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.057055] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.058611] pci 0000:00:01.1: reg 0x20: [io  0xc0a0-0xc0af]
[    0.059317] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    0.059691] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.060005] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    0.060435] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.061090] pci 0000:00:01.2: [8086:7020] type 00 class 0x0c0300
[    0.062641] pci 0000:00:01.2: reg 0x20: [io  0xc040-0xc05f]
[    0.063530] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.063845] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX=
4 ACPI
[    0.064015] pci 0000:00:01.3: quirk: [io  0xb100-0xb10f] claimed by PIIX=
4 SMB
[    0.065052] pci 0000:00:02.0: [1013:00b8] type 00 class 0x030000
[    0.068043] pci 0000:00:02.0: reg 0x10: [mem 0xfc000000-0xfdffffff pref]
[    0.070033] pci 0000:00:02.0: reg 0x14: [mem 0xfebf0000-0xfebf0fff]
[    0.080036] pci 0000:00:02.0: reg 0x30: [mem 0xfebd0000-0xfebdffff pref]
[    0.080592] pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
[    0.081298] pci 0000:00:03.0: reg 0x10: [io  0xc060-0xc07f]
[    0.081854] pci 0000:00:03.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    0.084556] pci 0000:00:03.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.085345] kworker/u2:0 (34) used greatest stack depth: 13912 bytes lef=
t
[    0.085919] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[    0.087004] pci 0000:00:04.0: reg 0x10: [io  0xc000-0xc03f]
[    0.088362] pci 0000:00:04.0: reg 0x14: [mem 0xfebf2000-0xfebf2fff]
[    0.093240] pci 0000:00:05.0: [1af4:1002] type 00 class 0x00ff00
[    0.093581] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc09f]
[    0.096168] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.096890] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.097607] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.098849] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.099661] ACPI: PCI Interrupt Link [LNKS] (IRQs 9) *0, disabled.
[    0.100837] ACPI: Enabled 16 GPEs in block 00 to 0F
[    0.101233] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.101579] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.102008] vgaarb: loaded
[    0.102294] vgaarb: bridge control possible 0000:00:02.0
[    0.103222] SCSI subsystem initialized
[    0.103651] libata version 3.00 loaded.
[    0.103733] ACPI: bus type USB registered
[    0.104067] usbcore: registered new interface driver usbfs
[    0.104428] usbcore: registered new interface driver hub
[    0.105034] usbcore: registered new device driver usb
[    0.105422] pps_core: LinuxPPS API ver. 1 registered
[    0.105750] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.106031] PTP clock support registered
[    0.106501] Advanced Linux Sound Architecture Driver Initialized.
[    0.107019] PCI: Using ACPI for IRQ routing
[    0.107355] PCI: pci_cache_line_size set to 64 bytes
[    0.107494] e820: reserve RAM buffer [mem 0x0009dc00-0x0009ffff]
[    0.107498] e820: reserve RAM buffer [mem 0x1fffe000-0x1fffffff]
[    0.108102] NetLabel: Initializing
[    0.108410] NetLabel:  domain hash size =3D 128
[    0.108723] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.109042] NetLabel:  unlabeled traffic allowed by default
[    0.109564] HPET: 3 timers in total, 0 timers will be used for per-cpu t=
imer
[    0.110074] cfg80211: Calling CRDA to update world regulatory domain
[    0.110453] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.111006] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.117055] Switched to clocksource kvm-clock
[    0.125189] pnp: PnP ACPI init
[    0.125621] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.125682] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.125735] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.125769] pnp 00:03: [dma 2]
[    0.125788] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.125910] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.126146] pnp: PnP ACPI: found 5 devices
[    0.131442] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.131445] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffffff]
[    0.131483] NET: Registered protocol family 2
[    0.132100] TCP established hash table entries: 4096 (order: 3, 32768 by=
tes)
[    0.132521] TCP bind hash table entries: 4096 (order: 4, 65536 bytes)
[    0.132938] TCP: Hash tables configured (established 4096 bind 4096)
[    0.133368] TCP: reno registered
[    0.133720] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.134082] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.134549] NET: Registered protocol family 1
[    0.135049] RPC: Registered named UNIX socket transport module.
[    0.135403] RPC: Registered udp transport module.
[    0.135741] RPC: Registered tcp transport module.
[    0.136078] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.136467] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.136873] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.137255] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.137921] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.138494] pci 0000:00:02.0: Video device with shadowed ROM
[    0.138526] PCI: CLS 0 bytes, default 64
[    0.138767] microcode: CPU0 sig=3D0x206c1, pf=3D0x1, revision=3D0x1
[    0.139253] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.f=
snet.co.uk>, Peter Oruba
[    0.139953] Scanning for low memory corruption every 60 seconds
[    0.140584] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.140974] audit: initializing netlink subsys (disabled)
[    0.141341] audit: type=3D2000 audit(1416869274.989:1): initialized
[    0.141994] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.144191] VFS: Disk quotas dquot_6.5.2
[    0.144556] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.145385] NFS: Registering the id_resolver key type
[    0.145735] Key type id_resolver registered
[    0.146065] Key type id_legacy registered
[    0.146434] 9p: Installing v9fs 9p2000 file system support
[    0.146815] msgmni has been set to 845
[    0.147387] SELinux:  Registering netfilter hooks
[    0.148606] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    0.149235] io scheduler noop registered
[    0.149547] io scheduler deadline registered
[    0.149914] io scheduler cfq registered (default)
[    0.150339] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.150732] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.172665] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    0.174119] Non-volatile memory driver v1.3
[    0.174447] Linux agpgart interface v0.103
[    0.174952] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[    0.175554] ACPI: Power Button [PWRF]
[    0.176437] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
[    0.178508] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[    0.178967] [drm] Initialized drm 1.1.0 20060810
[    0.179974] loop: module loaded
[    0.180479] virtio-pci 0000:00:04.0: irq 24 for MSI/MSI-X
[    0.180496] virtio-pci 0000:00:04.0: irq 25 for MSI/MSI-X
[    0.318792]  vda: vda1 vda2
[    0.320428] ata_piix 0000:00:01.1: version 2.13
[    0.320912] scsi host0: ata_piix
[    0.321367] scsi host1: ata_piix
[    0.321710] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0a0 irq 1=
4
[    0.322092] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0a8 irq 1=
5
[    0.322749] virtio-pci 0000:00:03.0: irq 26 for MSI/MSI-X
[    0.322766] virtio-pci 0000:00:03.0: irq 27 for MSI/MSI-X
[    0.322781] virtio-pci 0000:00:03.0: irq 28 for MSI/MSI-X
[    0.441106] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    0.441475] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.441841] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-=
NAPI
[    0.442226] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.442639] sky2: driver version 1.30
[    0.443190] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.443558] ehci-pci: EHCI PCI platform driver
[    0.443920] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.444311] ohci-pci: OHCI PCI platform driver
[    0.444649] uhci_hcd: USB Universal Host Controller Interface driver
[    0.445262] uhci_hcd 0000:00:01.2: UHCI Host Controller
[    0.445657] uhci_hcd 0000:00:01.2: new USB bus registered, assigned bus =
number 1
[    0.446419] uhci_hcd 0000:00:01.2: irq 11, io base 0x0000c040
[    0.446851] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.447247] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.447792] usb usb1: Product: UHCI Host Controller
[    0.448127] usb usb1: Manufacturer: Linux 3.17.3-gentoo uhci_hcd
[    0.448476] usb usb1: SerialNumber: 0000:00:01.2
[    0.448926] hub 1-0:1.0: USB hub found
[    0.449263] hub 1-0:1.0: 2 ports detected
[    0.449689] usbcore: registered new interface driver usblp
[    0.450122] usbcore: registered new interface driver usb-storage
[    0.450516] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    0.451720] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.452070] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.452483] mousedev: PS/2 mouse device common for all mice
[    0.453170] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    0.455416] rtc_cmos 00:00: RTC can wake from S4
[    0.455993] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    0.456467] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram, hpet =
irqs
[    0.456955] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised:=
 dm-devel@redhat.com
[    0.457632] hidraw: raw HID events driver (C) Jiri Kosina
[    0.458241] usbcore: registered new interface driver usbhid
[    0.458590] usbhid: USB HID core driver
[    0.459182] Netfilter messages via NETLINK v0.30.
[    0.459528] nf_conntrack version 0.5.0 (3380 buckets, 13520 max)
[    0.459984] ctnetlink v0.93: registering with nfnetlink.
[    0.460442] ip_tables: (C) 2000-2006 Netfilter Core Team
[    0.460807] TCP: cubic registered
[    0.461176] Initializing XFRM netlink socket
[    0.461608] NET: Registered protocol family 10
[    0.462268] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    0.462660] sit: IPv6 over IPv4 tunneling driver
[    0.463146] NET: Registered protocol family 17
[    0.463533] 9pnet: Installing 9P2000 support
[    0.463904] Key type dns_resolver registered
[    0.464485] registered taskstats version 1
[    0.465119]   Magic number: 6:406:806
[    0.465470] console [netcon0] enabled
[    0.465777] netconsole: network logging started
[    0.466175] PM: Hibernation image not present or could not be loaded.
[    0.466178] ALSA device list:
[    0.466469]   No soundcards found.
[    0.511359] ata2.01: NODEV after polling detection
[    0.511632] ata2.00: ATAPI: QEMU DVD-ROM, 1.1.2, max UDMA/100
[    0.512499] ata2.00: configured for MWDMA2
[    0.513328] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     1.=
1. PQ: 0 ANSI: 5
[    0.524546] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    0.524926] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.525456] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    0.525739] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    0.751163] usb 1-1: new full-speed USB device number 2 using uhci_hcd
[    1.009894] usb 1-1: New USB device found, idVendor=3D0627, idProduct=3D=
0001
[    1.010342] usb 1-1: New USB device strings: Mfr=3D1, Product=3D3, Seria=
lNumber=3D5
[    1.010855] usb 1-1: Product: QEMU USB Tablet
[    1.011200] usb 1-1: Manufacturer: QEMU 1.1.2
[    1.011517] usb 1-1: SerialNumber: 42
[    1.028916] input: QEMU 1.1.2 QEMU USB Tablet as /devices/pci0000:00/000=
0:00:01.2/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input4
[    1.030642] hid-generic 0003:0627:0001.0001: input,hidraw0: USB HID v0.0=
1 Pointer [QEMU 1.1.2 QEMU USB Tablet] on usb-0000:00:01.2-1/input0
[    1.055863] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/=
i8042/serio1/input/input3
[    1.056697] md: Skipping autodetection of RAID arrays. (raid=3Dautodetec=
t will force)
[    1.140105] tsc: Refined TSC clocksource calibration: 2593.617 MHz
[    1.432843] kjournald starting.  Commit interval 5 seconds
[    1.433255] EXT3-fs (vda1): mounted filesystem with ordered data mode
[    1.433638] VFS: Mounted root (ext3 filesystem) readonly on device 253:1=
.
[    2.042735] devtmpfs: mounted
[    2.044053] Freeing unused kernel memory: 1108K (ffffffff81ed9000 - ffff=
ffff81fee000)
[    2.044626] Write protecting the kernel read-only data: 14336k
[    2.050512] Freeing unused kernel memory: 1964K (ffff880001815000 - ffff=
880001a00000)
[    2.054142] Freeing unused kernel memory: 1412K (ffff880001c9f000 - ffff=
880001e00000)
[   13.657617] init-early.sh (884) used greatest stack depth: 11992 bytes l=
eft
[   40.359139] systemd-udevd[1057]: starting version 216
[   42.700710] random: systemd-udevd urandom read with 39 bits of entropy a=
vailable
[   42.773688] udevadm (1065) used greatest stack depth: 11768 bytes left
[   51.386937] EXT3-fs (vda1): using internal journal
[   51.730108] Adding 1571836k swap on /dev/vda2.  Priority:-1 extents:1 ac=
ross:1571836k=20
[   88.213351] device eth0 entered promiscuous mode
[  100.706265] random: nonblocking pool is initialized
[  252.755504] tun: Universal TUN/TAP device driver, 1.6
[  252.755508] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[  254.300593] batman_adv: B.A.T.M.A.N. advanced 2014.4.0 (compatibility ve=
rsion 15) loaded
[  254.545508] batman_adv: bat0: Adding interface: fastd0
[  254.545516] batman_adv: bat0: The MTU of interface fastd0 is too small (=
1426) to handle the transport of batman-adv packets. Packets going over thi=
s interface will be fragmented on layer2 which could impact the performance=
. Setting the MTU to 1560 would solve the problem.
[  254.545521] batman_adv: bat0: Interface activated: fastd0
[  254.546593] batman_adv: bat0: orig_interval: Changing from: 1000 to: 500=
0
[  254.548281] batman_adv: bat0: bridge_loop_avoidance: Changing from: disa=
bled to: enabled
[  254.548999] batman_adv: bat0: Changing gw mode from: off to: client
[  311.447606] ipip: IPv4 over IPv4 tunneling driver
[  672.444097] batman_adv: bat0: Changing gw mode from: client to: server
[  672.444119] batman_adv: bat0: Changing gateway bandwidth from: '10.0/2.0=
 MBit' to: '100.0/100.0 MBit'
[  698.298490] nf_conntrack: automatic helper assignment is deprecated and =
it will be removed soon. Use the iptables CT target to attach helpers inste=
ad.
[ 1184.606170] mkmap.sh (6307) used greatest stack depth: 11736 bytes left
[ 2395.269797] skbuff: skb_over_panic: text:ffffffffa001be32 len:1445 put:1=
380 head:ffff880017738c00 data:ffff880017738c62 tail:0x607 end:0x2c0 dev:fa=
std0
[ 2395.270151] ------------[ cut here ]------------
[ 2395.270257] kernel BUG at net/core/skbuff.c:100!
[ 2395.270352] invalid opcode: 0000 [#1] SMP=20
[ 2395.270453] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipi=
p batman_adv libcrc32c tun crc32c_intel
[ 2395.270738] CPU: 0 PID: 2036 Comm: fastd Not tainted 3.17.3-gentoo #1
[ 2395.270861] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[ 2395.270987] task: ffff880019cef290 ti: ffff88001768c000 task.ti: ffff880=
01768c000
[ 2395.271111] RIP: 0010:[<ffffffff81806a38>]  [<ffffffff81806a38>] skb_pan=
ic+0x5e/0x60
[ 2395.271111] RSP: 0018:ffff88001fc03cf8  EFLAGS: 00010296
[ 2395.271111] RAX: 000000000000008b RBX: ffff88001a2bbd20 RCX: 00000000000=
00092
[ 2395.271111] RDX: 00000000000000c2 RSI: 0000000000000246 RDI: 00000000000=
00246
[ 2395.271111] RBP: ffff88001fc03d18 R08: 0000000000000000 R09: 00000000000=
00000
[ 2395.271111] R10: ffffffff81a6b240 R11: 0000000000000000 R12: 00000000000=
00564
[ 2395.271111] R13: ffff88001fc03da0 R14: ffff88000f877000 R15: ffff880002c=
56862
[ 2395.271111] FS:  00007f0c8256c700(0000) GS:ffff88001fc00000(0000) knlGS:=
0000000000000000
[ 2395.271111] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2395.271111] CR2: 00007fff6da33ed0 CR3: 000000001766c000 CR4: 00000000000=
006f0
[ 2395.271111] Stack:
[ 2395.271111]  ffff880017738c62 0000000000000607 00000000000002c0 ffff8800=
17638000
[ 2395.271111]  ffff88001fc03d28 ffffffff8162c921 ffff88001fc03d88 ffffffff=
a001be32
[ 2395.271111]  ffff88001a3a89c8 ffff880002c5684e ffff88001fc03d68 ffff8800=
1a2bbd20
[ 2395.271111] Call Trace:
[ 2395.271111]  <IRQ>=20
[ 2395.271111]=20
[ 2395.271111]  [<ffffffff8162c921>] skb_put+0x41/0x50
[ 2395.271111]  [<ffffffffa001be32>] batadv_frag_skb_buffer+0x272/0x470 [ba=
tman_adv]
[ 2395.271111]  [<ffffffffa0026283>] batadv_recv_frag_packet+0x183/0x200 [b=
atman_adv]
[ 2395.271111]  [<ffffffffa001ff15>] batadv_batman_skb_recv+0xd5/0x110 [bat=
man_adv]
[ 2395.271111]  [<ffffffff812b0f76>] ? __blk_mq_complete_request+0x86/0x120
[ 2395.271111]  [<ffffffff8163c752>] __netif_receive_skb_core+0x222/0x740
[ 2395.271111]  [<ffffffff8146b13a>] ? virtblk_done+0xca/0xe0
[ 2395.271111]  [<ffffffff8163cc91>] __netif_receive_skb+0x21/0x70
[ 2395.271111]  [<ffffffff8163cd7e>] process_backlog+0x9e/0x170
[ 2395.271111]  [<ffffffff8163d531>] net_rx_action+0x141/0x240
[ 2395.271111]  [<ffffffff81052e28>] __do_softirq+0xe8/0x280
[ 2395.271111]  [<ffffffff8180e99c>] do_softirq_own_stack+0x1c/0x30
[ 2395.271111]  <EOI>=20
[ 2395.271111]=20
[ 2395.271111]  [<ffffffff81053065>] do_softirq+0x55/0x60
[ 2395.271111]  [<ffffffff8163bca4>] netif_rx_ni+0x34/0x70
[ 2395.271111]  [<ffffffffa00098e3>] tun_get_user+0x413/0x840 [tun]
[ 2395.271111]  [<ffffffffa0009e0b>] tun_chr_aio_write+0x7b/0xa0 [tun]
[ 2395.271111]  [<ffffffff8115fdb5>] do_sync_write+0x55/0x90
[ 2395.271111]  [<ffffffff81160ada>] vfs_write+0xba/0x1f0
[ 2395.271111]  [<ffffffff81160fea>] SyS_write+0x4a/0xa0
[ 2395.271111]  [<ffffffff8180ce69>] system_call_fastpath+0x16/0x1b
[ 2395.271111] Code: 00 00 48 89 44 24 10 8b 87 c0 00 00 00 48 89 44 24 08 =
48 8b 87 d0 00 00 00 48 c7 c7 c0 cc c3 81 48 89 04 24 31 c0 e8 ca 97 ff ff =
<0f> 0b 55 48 89 f8 48 8b 57 30 48 89 e5 48 8b 0f 5d 80 e5 80 48=20
[ 2395.271111] RIP  [<ffffffff81806a38>] skb_panic+0x5e/0x60
[ 2395.271111]  RSP <ffff88001fc03cf8>


--=-eUQ27fnIuCX1rZ/O/qi9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJUc8vfAAoJENpWdD1eHU4JitAP/iWJ6WCjU4kwf2nSyC7v5Hbi
gQ9baLA8AubmCE1A28id84cwILRPj1MLCebpHqH62lEOJcFgFH1xrbwTimsQ4A/C
baHtVVeQhpjIIQOTQ/cqPvnuOZ5BT7QXXY7TIzch7AFkdz3Zdu9NptIh6AW5Oqe/
lVgeurSTCJd8LpM51RoPp3gYH5zdWBa7OoCVLtpTf5NJEzIjSdo/EbEPDFb+t9qu
2K23/pGZlr4Zrd4JQk3mfP8rasi53MTeSEvB1Cl56OYi6c8yYgzPfR2fdwaPSQD+
Jmhl+fz3u0q5VKGWl6KGfeTbf9NC/7niVliEkQUdCTzcIO8436bGULW0L2njTk0K
OJM2VVR++Z2XaYVsJYbN3D3pKofyXcNibdnJF4uo7gNhcVW1ygZ7iuAyuUSZyx7E
226bnH5SPszNsA/I6DPG+xaeag4JvaK6EGw+FJ8M0toq30yo4hHE/RgqixjFojXq
lCvyojhr3ECLxZZ2oNAGK9WbwAKOJzG1ZHu2tfQTVaGCDnJVurrnuuM99XevTW8x
AvhUyKPfvkjQSKn0S8rPAgW8co566HjXVcwluPFb+scLQ+QZl8yCBk7f6UDTzLWD
d1QUEpJRHDEolii7cyuPhdQrCgv04jHcs1PW1nzEGPeMwplErqVogek0Lo5DQ2Wm
ZsDmMfZ5IVST4q+h9kck
=+JAR
-----END PGP SIGNATURE-----

--=-eUQ27fnIuCX1rZ/O/qi9--

