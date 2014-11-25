Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1416910641.2605.1.camel@gmail.com>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Tue, 25 Nov 2014 11:17:21 +0100
In-Reply-To: <1416874968.1632.13.camel@gmail.com>
References: <1416347918.9920.10.camel@gmail.com>
 <546DA710.2040802@hundeboll.net> <1416476912.2747.5.camel@gmail.com>
 <546DC214.6050908@hundeboll.net> <1416486149.2747.9.camel@gmail.com>
 <546DE067.8070807@hundeboll.net> <1416688754.2696.3.camel@gmail.com>
 <5472EB56.8000700@hundeboll.net> <1416825873.2678.2.camel@gmail.com>
 <1416831279.2678.10.camel@gmail.com> <1416863721.1632.3.camel@gmail.com>
 <1416867973.1632.9.camel@gmail.com> <1416874968.1632.13.camel@gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha1";
 protocol="application/pgp-signature"; 
 boundary="=-d2KbbBiRZbyTKExdXl42"
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


--=-d2KbbBiRZbyTKExdXl42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Martin, hi all.

Should I keep on reporting? Meanwhile I'm running out of space for the
vmcore dumps. Is it me, is it the kernel or is it Batman-adv? What
should I do? Should I bother the kernel hackers?

This bug happened 44 minutes after changing gw client to gw server.

Best regards

Philipp

________________________
Freifunk Rheinland e. V.
=E2=80=93 Funkzelle Wuppertal =E2=80=93



  SYSTEM MAP: /boot/System.map                                        =20
DEBUG KERNEL: /usr/src/linux-3.17.3-gentoo/vmlinux (3.17.3-gentoo)
    DUMPFILE: vmcore_20141125105708
        CPUS: 1
        DATE: Thu Jan  1 01:00:00 1970
      UPTIME: 10:23:00
LOAD AVERAGE: 0.25, 0.19, 0.35
       TASKS: 149
    NODENAME: wolke
     RELEASE: 3.17.3-gentoo
     VERSION: #1 SMP Wed Nov 19 15:42:49 CET 2014
     MACHINE: x86_64  (2593 Mhz)
      MEMORY: 511.6 MB
       PANIC: "kernel BUG at net/core/skbuff.c:100!"
         PID: 2058
     COMMAND: "fastd"
        TASK: ffff88001a3b91a0  [THREAD_INFO: ffff880006c04000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 2058   TASK: ffff88001a3b91a0  CPU: 0   COMMAND: "fastd"
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
    RAX: 000000000000008b  RBX: ffff88001a3a7100  RCX: 0000000000000092
    RDX: 0000000000000033  RSI: 0000000000000246  RDI: 0000000000000246
    RBP: ffff88001fc03d18   R8: 0000000000000000   R9: 0000000000000000
    R10: ffffffff81a6b240  R11: 0000000000000000  R12: 0000000000000564
    R13: ffff88001fc03da0  R14: ffff880019e92b00  R15: ffff88000d8a7862
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
#18 [ffff880006c07d10] do_softirq_own_stack at ffffffff8180e99c
    [exception RIP: tun_get_user+1043]
    RIP: ffffffffa00098e3  RSP: 0000000000000001  RFLAGS: 7fff00000586
    RAX: ffffffff8163bca4  RBX: ffff880006c07d58  RCX: ffff880006cd4780
    RDX: 0000000000000000  RSI: ffff880006cd4780  RDI: 0000000000000586
    RBP: ffffffff8163b9d4   R8: ffff880006c07d88   R9: ffff880006cd4780
    R10: ffff880006cd4780  R11: ffffffff81053065  R12: ffff880006c07d58
    R13: 0000000000000586  R14: ffff880019e92300  R15: 0000000000000000
    ORIG_RAX: ffff880006c07e38  CS: 7fff4304a270  SS: 0000
bt: WARNING: possibly bogus exception frame
#19 [ffff880006c07e40] tun_chr_aio_write at ffffffffa0009e0b [tun]
#20 [ffff880006c07e70] do_sync_write at ffffffff8115fdb5
#21 [ffff880006c07f00] vfs_write at ffffffff81160ada
#22 [ffff880006c07f40] sys_write at ffffffff81160fea
#23 [ffff880006c07f80] system_call_fastpath at ffffffff8180ce69
    RIP: 00007f8cb870b37d  RSP: 00007fff4304a3b8  RFLAGS: 00000202
    RAX: 0000000000000001  RBX: ffffffff8180ce69  RCX: 00000000000005b0
    RDX: 0000000000000586  RSI: 000000000127ff70  RDI: 0000000000000009
    RBP: 0000000000000586   R8: 00007f8cb86f4400   R9: 00007fff430499b8
    R10: 00007fff4304a0ff  R11: 0000000000000293  R12: 0000000001274fa8
    R13: 0000000000000001  R14: 000000000127ff60  R15: 00000000012636e0
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
[    0.002398] ACPI: Core revision 20140724
[    0.003751] ACPI: All ACPI Tables successfully acquired
[    0.004321] Security Framework initialized
[    0.004680] SELinux:  Initializing.
[    0.005011] SELinux:  Starting in permissive mode
[    0.005045] Dentry cache hash table entries: 65536 (order: 7, 524288 byt=
es)
[    0.005728] Inode-cache hash table entries: 32768 (order: 6, 262144 byte=
s)
[    0.006136] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.006555] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 by=
tes)
[    0.007242] Initializing cgroup subsys freezer
[    0.008004] mce: CPU supports 10 MCE banks
[    0.008406] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
               Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.027152] Freeing SMP alternatives memory: 28K (ffffffff81fee000 - fff=
fffff81ff5000)
[    0.031911] ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D=
-1
[    0.032002] smpboot: CPU0: Intel Westmere E56xx/L56xx/X56xx (Nehalem-C) =
(fam: 06, model: 2c, stepping: 01)
[    0.034000] APIC calibration not consistent with PM-Timer: 101ms instead=
 of 100ms
[    0.034000] APIC delta adjusted to PM-Timer: 6250163 (6375026)
[    0.034000] Performance Events: unsupported p6 CPU model 44 no PMU drive=
r, software events only.
[    0.034320] x86: Booted up 1 node, 1 CPUs
[    0.034635] smpboot: Total of 1 processors activated (5187.49 BogoMIPS)
[    0.035384] devtmpfs: initialized
[    0.036195] RTC time: 23:31:12, date: 11/24/14
[    0.036665] NET: Registered protocol family 16
[    0.037225] cpuidle: using governor ladder
[    0.037563] cpuidle: using governor menu
[    0.038040] ACPI: bus type PCI registered
[    0.038496] PCI: Using configuration type 1 for base access
[    0.041486] kworker/u2:0 (15) used greatest stack depth: 14664 bytes lef=
t
[    0.042191] kworker/u2:0 (20) used greatest stack depth: 13912 bytes lef=
t
[    0.042610] ACPI: Added _OSI(Module Device)
[    0.042928] ACPI: Added _OSI(Processor Device)
[    0.043005] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.043329] ACPI: Added _OSI(Processor Aggregator Device)
[    0.045318] ACPI: Interpreter enabled
[    0.045643] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S1_] (20140724/hwxface-580)
[    0.046284] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [=
\_S2_] (20140724/hwxface-580)
[    0.047067] ACPI: (supports S0 S3 S4 S5)
[    0.047431] ACPI: Using IOAPIC for interrupt routing
[    0.047781] PCI: Ignoring host bridge windows from ACPI; if necessary, u=
se "pci=3Duse_crs" and report a bug
[    0.050765] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.051016] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MS=
I]
[    0.051389] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.051762] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7] (ign=
ored)
[    0.051763] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff] (ign=
ored)
[    0.051765] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bff=
ff] (ignored)
[    0.051766] acpi PNP0A03:00: host bridge window [mem 0xe0000000-0xfebfff=
ff] (ignored)
[    0.051768] PCI: root bus 00: using default resources
[    0.051770] acpi PNP0A03:00: fail to add MMCONFIG information, can't acc=
ess extended PCI configuration space under this bridge.
[    0.052052] PCI host bridge to bus 0000:00
[    0.052371] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.053010] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.053369] pci_bus 0000:00: root bus resource [mem 0x00000000-0xfffffff=
fff]
[    0.054069] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.054390] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.054861] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.056465] pci 0000:00:01.1: reg 0x20: [io  0xc0a0-0xc0af]
[    0.057026] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x=
01f7]
[    0.057442] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.057799] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x=
0177]
[    0.058003] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.058491] pci 0000:00:01.2: [8086:7020] type 00 class 0x0c0300
[    0.060298] pci 0000:00:01.2: reg 0x20: [io  0xc040-0xc05f]
[    0.061094] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.061410] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX=
4 ACPI
[    0.061983] pci 0000:00:01.3: quirk: [io  0xb100-0xb10f] claimed by PIIX=
4 SMB
[    0.062241] pci 0000:00:02.0: [1013:00b8] type 00 class 0x030000
[    0.064036] pci 0000:00:02.0: reg 0x10: [mem 0xfc000000-0xfdffffff pref]
[    0.066031] pci 0000:00:02.0: reg 0x14: [mem 0xfebf0000-0xfebf0fff]
[    0.076064] pci 0000:00:02.0: reg 0x30: [mem 0xfebd0000-0xfebdffff pref]
[    0.077425] pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
[    0.078007] pci 0000:00:03.0: reg 0x10: [io  0xc060-0xc07f]
[    0.078583] pci 0000:00:03.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    0.081331] pci 0000:00:03.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.082213] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[    0.084006] pci 0000:00:04.0: reg 0x10: [io  0xc000-0xc03f]
[    0.086004] pci 0000:00:04.0: reg 0x14: [mem 0xfebf2000-0xfebf2fff]
[    0.090583] pci 0000:00:05.0: [1af4:1002] type 00 class 0x00ff00
[    0.091029] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc09f]
[    0.093694] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.094487] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.095171] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.096438] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.097378] ACPI: PCI Interrupt Link [LNKS] (IRQs 9) *0, disabled.
[    0.099279] ACPI: Enabled 16 GPEs in block 00 to 0F
[    0.100066] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.100409] vgaarb: device added: PCI:0000:00:02.0,decodes=3Dio+mem,owns=
=3Dio+mem,locks=3Dnone
[    0.101006] vgaarb: loaded
[    0.101289] vgaarb: bridge control possible 0000:00:02.0
[    0.102258] SCSI subsystem initialized
[    0.102784] libata version 3.00 loaded.
[    0.102881] ACPI: bus type USB registered
[    0.103089] usbcore: registered new interface driver usbfs
[    0.103447] usbcore: registered new interface driver hub
[    0.104055] usbcore: registered new device driver usb
[    0.104442] pps_core: LinuxPPS API ver. 1 registered
[    0.104778] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo =
Giometti <giometti@linux.it>
[    0.105029] PTP clock support registered
[    0.105492] Advanced Linux Sound Architecture Driver Initialized.
[    0.106018] PCI: Using ACPI for IRQ routing
[    0.106335] PCI: pci_cache_line_size set to 64 bytes
[    0.106477] e820: reserve RAM buffer [mem 0x0009dc00-0x0009ffff]
[    0.106481] e820: reserve RAM buffer [mem 0x1fffe000-0x1fffffff]
[    0.107116] NetLabel: Initializing
[    0.107421] NetLabel:  domain hash size =3D 128
[    0.107734] NetLabel:  protocols =3D UNLABELED CIPSOv4
[    0.108034] NetLabel:  unlabeled traffic allowed by default
[    0.108530] cfg80211: Calling CRDA to update world regulatory domain
[    0.110200] HPET: 3 timers in total, 0 timers will be used for per-cpu t=
imer
[    0.110608] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.111303] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.116055] Switched to clocksource kvm-clock
[    0.124288] pnp: PnP ACPI init
[    0.124734] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.124796] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.124848] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.124882] pnp 00:03: [dma 2]
[    0.124901] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.124998] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.125211] pnp: PnP ACPI: found 5 devices
[    0.133974] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.133977] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffffff]
[    0.134029] NET: Registered protocol family 2
[    0.134796] TCP established hash table entries: 4096 (order: 3, 32768 by=
tes)
[    0.135269] TCP bind hash table entries: 4096 (order: 4, 65536 bytes)
[    0.135800] TCP: Hash tables configured (established 4096 bind 4096)
[    0.136301] TCP: reno registered
[    0.136637] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.137044] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.137659] NET: Registered protocol family 1
[    0.138209] RPC: Registered named UNIX socket transport module.
[    0.138622] RPC: Registered udp transport module.
[    0.138977] RPC: Registered tcp transport module.
[    0.139372] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.139844] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.140230] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.140595] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.141416] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.142292] pci 0000:00:02.0: Video device with shadowed ROM
[    0.142342] PCI: CLS 0 bytes, default 64
[    0.142619] microcode: CPU0 sig=3D0x206c1, pf=3D0x1, revision=3D0x1
[    0.143237] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.f=
snet.co.uk>, Peter Oruba
[    0.144440] Scanning for low memory corruption every 60 seconds
[    0.145176] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.145593] audit: initializing netlink subsys (disabled)
[    0.146031] audit: type=3D2000 audit(1416871875.448:1): initialized
[    0.146850] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.149375] VFS: Disk quotas dquot_6.5.2
[    0.149771] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.150727] NFS: Registering the id_resolver key type
[    0.151096] Key type id_resolver registered
[    0.151409] Key type id_legacy registered
[    0.151814] 9p: Installing v9fs 9p2000 file system support
[    0.152265] msgmni has been set to 845
[    0.152748] SELinux:  Registering netfilter hooks
[    0.153579] Block layer SCSI generic (bsg) driver version 0.4 loaded (ma=
jor 251)
[    0.154190] io scheduler noop registered
[    0.154538] io scheduler deadline registered
[    0.154918] io scheduler cfq registered (default)
[    0.155364] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.155785] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.177702] 00:04: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) =
is a 16550A
[    0.179250] Non-volatile memory driver v1.3
[    0.179571] Linux agpgart interface v0.103
[    0.180115] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/inpu=
t/input0
[    0.180669] ACPI: Power Button [PWRF]
[    0.181527] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
[    0.183449] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[    0.184006] [drm] Initialized drm 1.1.0 20060810
[    0.185229] loop: module loaded
[    0.185708] virtio-pci 0000:00:04.0: irq 24 for MSI/MSI-X
[    0.185726] virtio-pci 0000:00:04.0: irq 25 for MSI/MSI-X
[    0.328773]  vda: vda1 vda2
[    0.330879] ata_piix 0000:00:01.1: version 2.13
[    0.331497] scsi host0: ata_piix
[    0.331996] scsi host1: ata_piix
[    0.332344] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0a0 irq 1=
4
[    0.332770] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0a8 irq 1=
5
[    0.333446] virtio-pci 0000:00:03.0: irq 26 for MSI/MSI-X
[    0.333463] virtio-pci 0000:00:03.0: irq 27 for MSI/MSI-X
[    0.333478] virtio-pci 0000:00:03.0: irq 28 for MSI/MSI-X
[    0.406083] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
[    0.406452] e100: Copyright(c) 1999-2006 Intel Corporation
[    0.406812] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-=
NAPI
[    0.407201] e1000: Copyright (c) 1999-2006 Intel Corporation.
[    0.407643] sky2: driver version 1.30
[    0.408139] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.408501] ehci-pci: EHCI PCI platform driver
[    0.408878] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.409261] ohci-pci: OHCI PCI platform driver
[    0.409598] uhci_hcd: USB Universal Host Controller Interface driver
[    0.410282] uhci_hcd 0000:00:01.2: UHCI Host Controller
[    0.410694] uhci_hcd 0000:00:01.2: new USB bus registered, assigned bus =
number 1
[    0.411474] uhci_hcd 0000:00:01.2: irq 11, io base 0x0000c040
[    0.412025] usb usb1: New USB device found, idVendor=3D1d6b, idProduct=
=3D0001
[    0.412552] usb usb1: New USB device strings: Mfr=3D3, Product=3D2, Seri=
alNumber=3D1
[    0.413114] usb usb1: Product: UHCI Host Controller
[    0.413450] usb usb1: Manufacturer: Linux 3.17.3-gentoo uhci_hcd
[    0.413797] usb usb1: SerialNumber: 0000:00:01.2
[    0.414279] hub 1-0:1.0: USB hub found
[    0.419053] hub 1-0:1.0: 2 ports detected
[    0.419865] usbcore: registered new interface driver usblp
[    0.420254] usbcore: registered new interface driver usb-storage
[    0.420670] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x6=
0,0x64 irq 1,12
[    0.421891] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.422244] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.422663] mousedev: PS/2 mouse device common for all mice
[    0.423329] input: AT Translated Set 2 keyboard as /devices/platform/i80=
42/serio0/input/input1
[    0.425456] rtc_cmos 00:00: RTC can wake from S4
[    0.426047] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    0.426499] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram, hpet =
irqs
[    0.426994] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised:=
 dm-devel@redhat.com
[    0.427656] hidraw: raw HID events driver (C) Jiri Kosina
[    0.428222] usbcore: registered new interface driver usbhid
[    0.428564] usbhid: USB HID core driver
[    0.429172] Netfilter messages via NETLINK v0.30.
[    0.429517] nf_conntrack version 0.5.0 (3380 buckets, 13520 max)
[    0.430045] ctnetlink v0.93: registering with nfnetlink.
[    0.430485] ip_tables: (C) 2000-2006 Netfilter Core Team
[    0.430846] TCP: cubic registered
[    0.431278] Initializing XFRM netlink socket
[    0.431726] NET: Registered protocol family 10
[    0.432393] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    0.432783] sit: IPv6 over IPv4 tunneling driver
[    0.433277] NET: Registered protocol family 17
[    0.433632] 9pnet: Installing 9P2000 support
[    0.433974] Key type dns_resolver registered
[    0.434570] registered taskstats version 1
[    0.435247]   Magic number: 6:753:555
[    0.435607] console [netcon0] enabled
[    0.435921] netconsole: network logging started
[    0.436343] PM: Hibernation image not present or could not be loaded.
[    0.436346] ALSA device list:
[    0.436658]   No soundcards found.
[    0.526525] ata2.01: NODEV after polling detection
[    0.526799] ata2.00: ATAPI: QEMU DVD-ROM, 1.1.2, max UDMA/100
[    0.527680] ata2.00: configured for MWDMA2
[    0.528512] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     1.=
1. PQ: 0 ANSI: 5
[    0.539497] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    0.540080] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.540584] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    0.540869] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    0.721091] usb 1-1: new full-speed USB device number 2 using uhci_hcd
[    1.010027] usb 1-1: New USB device found, idVendor=3D0627, idProduct=3D=
0001
[    1.010488] usb 1-1: New USB device strings: Mfr=3D1, Product=3D3, Seria=
lNumber=3D5
[    1.010922] usb 1-1: Product: QEMU USB Tablet
[    1.011335] usb 1-1: Manufacturer: QEMU 1.1.2
[    1.011703] usb 1-1: SerialNumber: 42
[    1.025854] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/=
i8042/serio1/input/input3
[    1.030611] input: QEMU 1.1.2 QEMU USB Tablet as /devices/pci0000:00/000=
0:00:01.2/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input4
[    1.031462] hid-generic 0003:0627:0001.0001: input,hidraw0: USB HID v0.0=
1 Pointer [QEMU 1.1.2 QEMU USB Tablet] on usb-0000:00:01.2-1/input0
[    1.032473] md: Skipping autodetection of RAID arrays. (raid=3Dautodetec=
t will force)
[    1.144085] tsc: Refined TSC clocksource calibration: 2593.620 MHz
[    1.233818] kjournald starting.  Commit interval 5 seconds
[    1.234229] EXT3-fs (vda1): mounted filesystem with ordered data mode
[    1.234611] VFS: Mounted root (ext3 filesystem) readonly on device 253:1=
.
[    1.247665] devtmpfs: mounted
[    1.248951] Freeing unused kernel memory: 1108K (ffffffff81ed9000 - ffff=
ffff81fee000)
[    1.249698] Write protecting the kernel read-only data: 14336k
[    1.255459] Freeing unused kernel memory: 1964K (ffff880001815000 - ffff=
880001a00000)
[    1.259167] Freeing unused kernel memory: 1412K (ffff880001c9f000 - ffff=
880001e00000)
[    8.571405] init-early.sh (884) used greatest stack depth: 11992 bytes l=
eft
[   36.577174] systemd-udevd[1057]: starting version 216
[   38.041743] random: systemd-udevd urandom read with 39 bits of entropy a=
vailable
[   47.096362] EXT3-fs (vda1): using internal journal
[   47.640896] Adding 1571836k swap on /dev/vda2.  Priority:-1 extents:1 ac=
ross:1571836k=20
[   78.490697] device eth0 entered promiscuous mode
[   83.505336] vnstatd (1925) used greatest stack depth: 11960 bytes left
[  104.815490] random: nonblocking pool is initialized
[  413.636050] tun: Universal TUN/TAP device driver, 1.6
[  413.636053] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[  416.404415] batman_adv: B.A.T.M.A.N. advanced 2014.4.0 (compatibility ve=
rsion 15) loaded
[  416.883606] batman_adv: bat0: Adding interface: fastd0
[  416.883628] batman_adv: bat0: The MTU of interface fastd0 is too small (=
1426) to handle the transport of batman-adv packets. Packets going over thi=
s interface will be fragmented on layer2 which could impact the performance=
. Setting the MTU to 1560 would solve the problem.
[  416.883632] batman_adv: bat0: Interface activated: fastd0
[  416.884747] batman_adv: bat0: orig_interval: Changing from: 1000 to: 500=
0
[  416.886336] batman_adv: bat0: bridge_loop_avoidance: Changing from: disa=
bled to: enabled
[  416.887079] batman_adv: bat0: Changing gw mode from: off to: client
[  457.100304] ipip: IPv4 over IPv4 tunneling driver
[ 2165.176351] ldconfig (20423) used greatest stack depth: 11784 bytes left
[ 2546.656064] kworker/dying (114) used greatest stack depth: 11752 bytes l=
eft
[ 2847.713111] kworker/dying (16437) used greatest stack depth: 11704 bytes=
 left
[ 4562.065973] nf_conntrack: automatic helper assignment is deprecated and =
it will be removed soon. Use the iptables CT target to attach helpers inste=
ad.
[ 6440.928104] kworker/dying (9625) used greatest stack depth: 11688 bytes =
left
[34735.321142] batman_adv: bat0: Changing gw mode from: client to: server
[34735.321164] batman_adv: bat0: Changing gateway bandwidth from: '10.0/2.0=
 MBit' to: '100.0/100.0 MBit'
[37380.212097] skbuff: skb_over_panic: text:ffffffffa001be32 len:1439 put:1=
380 head:ffff88000d2d9c00 data:ffff88000d2d9c62 tail:0x601 end:0x2c0 dev:fa=
std0
[37380.212566] ------------[ cut here ]------------
[37380.212713] kernel BUG at net/core/skbuff.c:100!
[37380.212870] invalid opcode: 0000 [#1] SMP=20
[37380.213017] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipi=
p batman_adv libcrc32c tun crc32c_intel
[37380.213017] CPU: 0 PID: 2058 Comm: fastd Not tainted 3.17.3-gentoo #1
[37380.213017] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[37380.213017] task: ffff88001a3b91a0 ti: ffff880006c04000 task.ti: ffff880=
006c04000
[37380.213017] RIP: 0010:[<ffffffff81806a38>]  [<ffffffff81806a38>] skb_pan=
ic+0x5e/0x60
[37380.213017] RSP: 0018:ffff88001fc03cf8  EFLAGS: 00010296
[37380.213017] RAX: 000000000000008b RBX: ffff88001a3a7100 RCX: 00000000000=
00092
[37380.213017] RDX: 0000000000000033 RSI: 0000000000000246 RDI: 00000000000=
00246
[37380.213017] RBP: ffff88001fc03d18 R08: 0000000000000000 R09: 00000000000=
00000
[37380.213017] R10: ffffffff81a6b240 R11: 0000000000000000 R12: 00000000000=
00564
[37380.213017] R13: ffff88001fc03da0 R14: ffff880019e92b00 R15: ffff88000d8=
a7862
[37380.213017] FS:  00007f8cb93b6700(0000) GS:ffff88001fc00000(0000) knlGS:=
0000000000000000
[37380.213017] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[37380.213017] CR2: 00000000015fe000 CR3: 00000000176cf000 CR4: 00000000000=
006f0
[37380.213017] Stack:
[37380.213017]  ffff88000d2d9c62 0000000000000601 00000000000002c0 ffff8800=
06cd4000
[37380.213017]  ffff88001fc03d28 ffffffff8162c921 ffff88001fc03d88 ffffffff=
a001be32
[37380.213017]  ffff88000377e508 ffff88000d8a784e ffff88001fc12a80 ffff8800=
1a3a7100
[37380.213017] Call Trace:
[37380.213017]  <IRQ>=20
[37380.213017]=20
[37380.213017]  [<ffffffff8162c921>] skb_put+0x41/0x50
[37380.213017]  [<ffffffffa001be32>] batadv_frag_skb_buffer+0x272/0x470 [ba=
tman_adv]
[37380.213017]  [<ffffffffa0026283>] batadv_recv_frag_packet+0x183/0x200 [b=
atman_adv]
[37380.213017]  [<ffffffffa001ff15>] batadv_batman_skb_recv+0xd5/0x110 [bat=
man_adv]
[37380.213017]  [<ffffffff8107579d>] ? default_wake_function+0xd/0x10
[37380.213017]  [<ffffffff8163c752>] __netif_receive_skb_core+0x222/0x740
[37380.213017]  [<ffffffff81072695>] ? check_preempt_curr+0x85/0xa0
[37380.213017]  [<ffffffff8163cc91>] __netif_receive_skb+0x21/0x70
[37380.213017]  [<ffffffff8163cd7e>] process_backlog+0x9e/0x170
[37380.213017]  [<ffffffff8163d531>] net_rx_action+0x141/0x240
[37380.213017]  [<ffffffff81052e28>] __do_softirq+0xe8/0x280
[37380.213017]  [<ffffffff8180e99c>] do_softirq_own_stack+0x1c/0x30
[37380.213017]  <EOI>=20
[37380.213017]=20
[37380.213017]  [<ffffffff81053065>] do_softirq+0x55/0x60
[37380.213017]  [<ffffffff8163bca4>] netif_rx_ni+0x34/0x70
[37380.213017]  [<ffffffffa00098e3>] tun_get_user+0x413/0x840 [tun]
[37380.213017]  [<ffffffffa0009e0b>] tun_chr_aio_write+0x7b/0xa0 [tun]
[37380.213017]  [<ffffffff8115fdb5>] do_sync_write+0x55/0x90
[37380.213017]  [<ffffffff81160ada>] vfs_write+0xba/0x1f0
[37380.213017]  [<ffffffff81160fea>] SyS_write+0x4a/0xa0
[37380.213017]  [<ffffffff8180ce69>] system_call_fastpath+0x16/0x1b
[37380.213017] Code: 00 00 48 89 44 24 10 8b 87 c0 00 00 00 48 89 44 24 08 =
48 8b 87 d0 00 00 00 48 c7 c7 c0 cc c3 81 48 89 04 24 31 c0 e8 ca 97 ff ff =
<0f> 0b 55 48 89 f8 48 8b 57 30 48 89 e5 48 8b 0f 5d 80 e5 80 48=20
[37380.213017] RIP  [<ffffffff81806a38>] skb_panic+0x5e/0x60
[37380.213017]  RSP <ffff88001fc03cf8>


--=-d2KbbBiRZbyTKExdXl42
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJUdFc4AAoJENpWdD1eHU4JfoIQAJHQRtIjsOYBb69YOepKhUOy
VHyOkaXJSN2u0mhFF6II+Be6b4w6skSZM34tx21ZpF8TnPaofeAchp0e9qp3DQaa
Z9bhl3uHuuR8F3tzbMBHBRTMdEJSk+arleclK/S7jj9JMOWbJoQcCfs+dhbvQvuB
cRj+jkhDRaG5RIOwvLuh23v9rQ1hrNMBYLvfaomkArIgmap/+LKTTbHDft+IA+1S
4/Uz3CXxB2XZ0WYKmDBdZSoMu9izjW3T5REx8qi0cMc7vg+bxWyLLLF/o/dJbUce
u1gTvFD4ie7MFa0jt74ohYACnh90Ce/DBnCbRf/RqIht2GbdOs0WEZQmcKWPYlqZ
VMxGqNueEB7kLcrHZIsnY+FKZLCGOQka8mK9SSMkzY6jM4fGTK2PtnefSQgHERBq
OedQ8OBvgkdc+ylVva9u42Ne0aqDXKqx5D3e3AzMEl3CzgI1VeW7f5YLYQF5aQv5
4XcUYXRaocPnHBVD/48KAUSZblQINnyhJEGGBd9yWjmRAKftIyu3H3tAVuAh3qRZ
4Gdhm3cIhSK3tQtOaTcLWCSs4ZMMID5LjDxcO9dSPMnWufapPNOkSYTjwSzeoX6v
UmBqHrXs7C+T6W/piBlDqMu6a+YCDRnW4E+lfTpkKgWAi3SzjdICmQcG4quZnNIk
hobThUyULcNZUy6157kD
=Dp4E
-----END PGP SIGNATURE-----

--=-d2KbbBiRZbyTKExdXl42--

