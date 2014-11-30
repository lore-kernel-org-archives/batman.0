Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1417356477.8367.20.camel@katze>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sun, 30 Nov 2014 15:07:57 +0100
In-Reply-To: <547B1E34.3020207@hundeboll.net>
References: <1416938767-29156-1-git-send-email-sven@narfation.org>
 <5474CCF8.9030008@hundeboll.net> <1417343787.5442.20.camel@katze>
 <1417346458.6337.9.camel@katze> <547B0D0D.200@hundeboll.net>
 <1417354504.8367.14.camel@katze> <547B1E34.3020207@hundeboll.net>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Check size information when
 reassembling fragments
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
To: Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@hundeboll.net>
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Martin, hi all

we have output :-) this was fast. But the VM crashes anyway. Now I
disable ntop …

I hope, we’ll get the bug soon. Only a dead bug is a good bug. ;-)

Best regards

Philipp

________________________
Freifunk Rheinland e. V.
– Funkzelle Wuppertal –


      KERNEL: /usr/src/linux-3.17.4-gentoo/vmlinux
    DUMPFILE: vmcore_20141130145543
        CPUS: 1
        DATE: Thu Jan  1 01:00:00 1970
      UPTIME: 00:35:02
LOAD AVERAGE: 0.44, 0.28, 0.18
       TASKS: 139
    NODENAME: wolke
     RELEASE: 3.17.4-gentoo
     VERSION: #1 SMP Tue Nov 25 12:37:10 CET 2014
     MACHINE: x86_64  (2593 Mhz)
      MEMORY: 511.6 MB
       PANIC: ""
         PID: 1748
     COMMAND: "ntop"
        TASK: ffff880019d04f50  [THREAD_INFO: ffff880019ce8000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 1748   TASK: ffff880019d04f50  CPU: 0   COMMAND: "ntop"
 #0 [ffff88001fc03740] machine_kexec at ffffffff8103ab9e
 #1 [ffff88001fc037a0] crash_kexec at ffffffff810bfa23
 #2 [ffff88001fc03870] oops_end at ffffffff810060f8
 #3 [ffff88001fc038a0] die at ffffffff81006593
 #4 [ffff88001fc038d0] do_general_protection at ffffffff8100341a
 #5 [ffff88001fc03900] general_protection at ffffffff81620388
    [exception RIP: __kmalloc_node_track_caller+237]
    RIP: ffffffff8115c24d  RSP: ffff88001fc039b8  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff880019ee1f00  RCX: 0000000000053faa
    RDX: 0000000000053fa9  RSI: 0000000000000000  RDI: 0000000000015900
    RBP: ffff88001fc039f8   R8: ffff88001fc15900   R9: ffff880005b09400
    R10: 313134310d17592b  R11: ffff88001974b5a0  R12: ffff88001f001400
    R13: 00000000000007c0  R14: 00000000ffffffff  R15: 0000000000010220
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0000
 #6 [ffff88001fc03a00] __kmalloc_reserve at ffffffff81464387
 #7 [ffff88001fc03a50] pskb_expand_head at ffffffff81465af7
 #8 [ffff88001fc03aa0] __pskb_pull_tail at ffffffff81466207
 #9 [ffff88001fc03af0] dev_hard_start_xmit at ffffffff814762c2
#10 [ffff88001fc03b50] __dev_queue_xmit at ffffffff81476798
#11 [ffff88001fc03ba0] dev_queue_xmit at ffffffff8147696b
#12 [ffff88001fc03bb0] ip_finish_output at ffffffff814c4608
#13 [ffff88001fc03c10] ip_output at ffffffff814c5128
#14 [ffff88001fc03c40] ip_forward_finish at ffffffff814c0d41
#15 [ffff88001fc03c60] ip_forward at ffffffff814c10fe
#16 [ffff88001fc03ca0] ip_rcv_finish at ffffffff814bef2c
#17 [ffff88001fc03cd0] ip_rcv at ffffffff814bf86c
#18 [ffff88001fc03d10] __netif_receive_skb_core at ffffffff81474152
#19 [ffff88001fc03d80] __netif_receive_skb at ffffffff81474691
#20 [ffff88001fc03da0] netif_receive_skb_internal at ffffffff81474878
#21 [ffff88001fc03dd0] napi_gro_complete at ffffffff814749dc
#22 [ffff88001fc03e00] napi_gro_flush at ffffffff81474d72
#23 [ffff88001fc03e30] napi_complete at ffffffff81474dc2
#24 [ffff88001fc03e50] gro_cell_poll at ffffffff81507e26
#25 [ffff88001fc03ea0] net_rx_action at ffffffff81474f31
#26 [ffff88001fc03f00] __do_softirq at ffffffff81052e28
#27 [ffff88001fc03f60] irq_exit at ffffffff81053205
#28 [ffff88001fc03f70] do_IRQ at ffffffff810046f2
--- <IRQ stack> ---
#29 [ffff880019cebf58] ret_from_intr at ffffffff8161f26d
    RIP: 00007f2ece2ff922  RSP: 00007f2eae7ac600  RFLAGS: 00000202
    RAX: 00007f2ea4137f20  RBX: ffffffff8161e769  RCX: 000000000014bd49
    RDX: 00007f2ea415df50  RSI: 0000000000000001  RDI: 0000000000820f00
    RBP: 000000000000a43a   R8: 000000000000008f   R9: 00007f2eae7acbee
    R10: 0000000000000000  R11: 0000000000000011  R12: 000000000012f3cc
    R13: 00007f2eae7ac9e0  R14: 0000000000049fc7  R15: 00000000547b1e28
    ORIG_RAX: ffffffffffffff8e  CS: 0033  SS: 002b
crash> log
[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Initializing cgroup subsys cpuacct
[    0.000000] Linux version 3.17.4-gentoo (root@wolke) (gcc version 4.7.3 (Gentoo 4.7.3-r1 p1.4, pie-0.5.5) ) #1 SMP Tue Nov 25 12:37:10 CET 2014
[    0.000000] Command line: root=/dev/vda1 raid=noautodetect crashkernel=64M
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dbff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009dc00-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000f0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000001fffdfff] usable
[    0.000000] BIOS-e820: [mem 0x000000001fffe000-0x000000001fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000feffc000-0x00000000feffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fffc0000-0x00000000ffffffff] reserved
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] SMBIOS 2.4 present.
[    0.000000] DMI: Bochs Bochs, BIOS Bochs 01/01/2007
[    0.000000] Hypervisor detected: KVM
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] e820: last_pfn = 0x1fffe max_arch_pfn = 0x400000000
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
[    0.000000] found SMP MP-table at [mem 0x000fdaf0-0x000fdaff] mapped at [ffff8800000fdaf0]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000097000] 97000 size 24576
[    0.000000] init_memory_mapping: [mem 0x00000000-0x000fffff]
[    0.000000]  [mem 0x00000000-0x000fffff] page 4k
[    0.000000] BRK [0x01cae000, 0x01caefff] PGTABLE
[    0.000000] BRK [0x01caf000, 0x01caffff] PGTABLE
[    0.000000] BRK [0x01cb0000, 0x01cb0fff] PGTABLE
[    0.000000] init_memory_mapping: [mem 0x1fc00000-0x1fdfffff]
[    0.000000]  [mem 0x1fc00000-0x1fdfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x1c000000-0x1fbfffff]
[    0.000000]  [mem 0x1c000000-0x1fbfffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x00100000-0x1bffffff]
[    0.000000]  [mem 0x00100000-0x001fffff] page 4k
[    0.000000]  [mem 0x00200000-0x1bffffff] page 2M
[    0.000000] init_memory_mapping: [mem 0x1fe00000-0x1fffdfff]
[    0.000000]  [mem 0x1fe00000-0x1fffdfff] page 4k
[    0.000000] BRK [0x01cb1000, 0x01cb1fff] PGTABLE
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000FD990 000014 (v00 BOCHS )
[    0.000000] ACPI: RSDT 0x000000001FFFE5B0 000038 (v01 BOCHS  BXPCRSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: FACP 0x000000001FFFFF80 000074 (v01 BOCHS  BXPCFACP 00000001 BXPC 00000001)
[    0.000000] ACPI: DSDT 0x000000001FFFE5F0 001121 (v01 BXPC   BXDSDT   00000001 INTL 20100528)
[    0.000000] ACPI: FACS 0x000000001FFFFF40 000040
[    0.000000] ACPI: SSDT 0x000000001FFFFEA0 00009E (v01 BOCHS  BXPCSSDT 00000001 BXPC 00000001)
[    0.000000] ACPI: APIC 0x000000001FFFFDB0 000078 (v01 BOCHS  BXPCAPIC 00000001 BXPC 00000001)
[    0.000000] ACPI: HPET 0x000000001FFFFD70 000038 (v01 BOCHS  BXPCHPET 00000001 BXPC 00000001)
[    0.000000] ACPI: SSDT 0x000000001FFFF720 000644 (v01 BXPC   BXSSDTPC 00000001 INTL 20100528)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] No NUMA configuration found
[    0.000000] Faking a node at [mem 0x0000000000000000-0x000000001fffdfff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x1fffdfff]
[    0.000000]   NODE_DATA [mem 0x1fffa000-0x1fffdfff]
[    0.000000] Reserving 64MB of memory at 432MB for crashkernel (System RAM: 511MB)
[    0.000000] kvm-clock: Using msrs 4b564d01 and 4b564d00
[    0.000000] kvm-clock: cpu 0, msr 0:1fff9001, primary cpu clock
[    0.000000]  [ffffea0000000000-ffffea00007fffff] PMD -> [ffff88001a800000-ffff88001affffff] on node 0
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
[    0.000000] IOAPIC[0]: apic_id 1, version 17, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 5 global_irq 5 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 10 global_irq 10 high level)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 11 global_irq 11 high level)
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
[    0.000000] setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:1 nr_node_ids:1
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88001fc00000 s79744 r8192 d22656 u2097152
[    0.000000] pcpu-alloc: s79744 r8192 d22656 u2097152 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] KVM setup async PF for cpu 0
[    0.000000] kvm-stealtime: cpu 0, msr 1fc0cf80
[    0.000000] Built 1 zonelists in Node order, mobility grouping on.  Total pages: 128901
[    0.000000] Policy zone: DMA32
[    0.000000] Kernel command line: root=/dev/vda1 raid=noautodetect crashkernel=64M
[    0.000000] PID hash table entries: 2048 (order: 2, 16384 bytes)
[    0.000000] Calgary: detecting Calgary via BIOS EBDA area
[    0.000000] Calgary: Unable to locate Rio Grande table in EBDA - bailing!
[    0.000000] Memory: 436880K/523880K available (6283K kernel code, 773K rwdata, 1992K rodata, 1060K init, 872K bss, 87000K reserved)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
[    0.000000] NR_IRQS:4352 nr_irqs:256 0
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Detected 2593.748 MHz processor
[    0.002000] Calibrating delay loop (skipped) preset value.. 5187.49 BogoMIPS (lpj=2593748)
[    0.002004] pid_max: default: 32768 minimum: 301
[    0.002389] ACPI: Core revision 20140724
[    0.003748] ACPI: All ACPI Tables successfully acquired
[    0.004334] Security Framework initialized
[    0.004698] SELinux:  Initializing.
[    0.005009] SELinux:  Starting in permissive mode
[    0.005041] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.005735] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.006141] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.006581] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.007284] Initializing cgroup subsys freezer
[    0.008015] mce: CPU supports 10 MCE banks
[    0.008487] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
               Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.022578] Freeing SMP alternatives memory: 24K (ffffffff81bcc000 - ffffffff81bd2000)
[    0.026794] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.027002] smpboot: CPU0: Intel Westmere E56xx/L56xx/X56xx (Nehalem-C) (fam: 06, model: 2c, stepping: 01)
[    0.028000] Performance Events: unsupported p6 CPU model 44 no PMU driver, software events only.
[    0.028428] x86: Booted up 1 node, 1 CPUs
[    0.028745] smpboot: Total of 1 processors activated (5187.49 BogoMIPS)
[    0.029420] devtmpfs: initialized
[    0.030297] RTC time: 13:04:50, date: 11/30/14
[    0.030759] NET: Registered protocol family 16
[    0.031184] cpuidle: using governor ladder
[    0.031504] cpuidle: using governor menu
[    0.031856] ACPI: bus type PCI registered
[    0.032116] PCI: Using configuration type 1 for base access
[    0.034624] kworker/u2:0 (14) used greatest stack depth: 14760 bytes left
[    0.035396] ACPI: Added _OSI(Module Device)
[    0.035723] ACPI: Added _OSI(Processor Device)
[    0.036004] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.036354] ACPI: Added _OSI(Processor Aggregator Device)
[    0.038182] ACPI: Interpreter enabled
[    0.038501] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20140724/hwxface-580)
[    0.039005] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20140724/hwxface-580)
[    0.039729] ACPI: (supports S0 S3 S4 S5)
[    0.040004] ACPI: Using IOAPIC for interrupt routing
[    0.040382] kworker/u2:0 (21) used greatest stack depth: 13912 bytes left
[    0.041029] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.044072] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.044467] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.044834] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.045016] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7] (ignored)
[    0.045018] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff] (ignored)
[    0.045020] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff] (ignored)
[    0.045021] acpi PNP0A03:00: host bridge window [mem 0xe0000000-0xfebfffff] (ignored)
[    0.045023] PCI: root bus 00: using default resources
[    0.045025] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.045725] PCI host bridge to bus 0000:00
[    0.046054] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.046396] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.047010] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffff]
[    0.047430] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.047786] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.048312] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.049921] pci 0000:00:01.1: reg 0x20: [io  0xc0a0-0xc0af]
[    0.050492] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.050876] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.051004] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.051371] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.052204] pci 0000:00:01.2: [8086:7020] type 00 class 0x0c0300
[    0.053793] pci 0000:00:01.2: reg 0x20: [io  0xc040-0xc05f]
[    0.054678] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.055022] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
[    0.055611] pci 0000:00:01.3: quirk: [io  0xb100-0xb10f] claimed by PIIX4 SMB
[    0.056264] pci 0000:00:02.0: [1013:00b8] type 00 class 0x030000
[    0.058038] pci 0000:00:02.0: reg 0x10: [mem 0xfc000000-0xfdffffff pref]
[    0.060038] pci 0000:00:02.0: reg 0x14: [mem 0xfebf0000-0xfebf0fff]
[    0.071041] pci 0000:00:02.0: reg 0x30: [mem 0xfebd0000-0xfebdffff pref]
[    0.071821] pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
[    0.072327] pci 0000:00:03.0: reg 0x10: [io  0xc060-0xc07f]
[    0.073004] pci 0000:00:03.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    0.077307] pci 0000:00:03.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.078181] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[    0.080004] pci 0000:00:04.0: reg 0x10: [io  0xc000-0xc03f]
[    0.081503] pci 0000:00:04.0: reg 0x14: [mem 0xfebf2000-0xfebf2fff]
[    0.087313] pci 0000:00:05.0: [1af4:1002] type 00 class 0x00ff00
[    0.087875] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc09f]
[    0.090732] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.091538] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.092086] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.093162] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.093876] ACPI: PCI Interrupt Link [LNKS] (IRQs 9) *0, disabled.
[    0.094882] ACPI: Enabled 16 GPEs in block 00 to 0F
[    0.095210] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.095553] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.096004] vgaarb: loaded
[    0.096300] vgaarb: bridge control possible 0000:00:02.0
[    0.097222] SCSI subsystem initialized
[    0.097647] libata version 3.00 loaded.
[    0.097678] ACPI: bus type USB registered
[    0.098066] usbcore: registered new interface driver usbfs
[    0.098430] usbcore: registered new interface driver hub
[    0.098816] usbcore: registered new device driver usb
[    0.099093] pps_core: LinuxPPS API ver. 1 registered
[    0.099430] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.100015] PTP clock support registered
[    0.100461] PCI: Using ACPI for IRQ routing
[    0.101013] PCI: pci_cache_line_size set to 64 bytes
[    0.101163] e820: reserve RAM buffer [mem 0x0009dc00-0x0009ffff]
[    0.101167] e820: reserve RAM buffer [mem 0x1fffe000-0x1fffffff]
[    0.101506] NetLabel: Initializing
[    0.101810] NetLabel:  domain hash size = 128
[    0.102002] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.102358] NetLabel:  unlabeled traffic allowed by default
[    0.103144] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.103531] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.104016] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.107030] cfg80211: Calling CRDA to update world regulatory domain
[    0.108105] Switched to clocksource kvm-clock
[    0.116396] pnp: PnP ACPI init
[    0.116861] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.116935] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.116987] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.117046] pnp 00:03: [dma 2]
[    0.117066] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.117178] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.117368] pnp: PnP ACPI: found 5 devices
[    0.122425] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.122428] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffffff]
[    0.122466] NET: Registered protocol family 2
[    0.123078] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.123472] TCP bind hash table entries: 4096 (order: 4, 65536 bytes)
[    0.123853] TCP: Hash tables configured (established 4096 bind 4096)
[    0.124289] TCP: reno registered
[    0.124589] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.124940] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.125474] NET: Registered protocol family 1
[    0.125819] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.126197] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.126556] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.127243] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.127807] pci 0000:00:02.0: Video device with shadowed ROM
[    0.127837] PCI: CLS 0 bytes, default 64
[    0.128110] microcode: CPU0 sig=0x206c1, pf=0x1, revision=0x1
[    0.128538] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.129258] Scanning for low memory corruption every 60 seconds
[    0.129870] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.130270] Initialise system trusted keyring
[    0.130606] audit: initializing netlink subsys (disabled)
[    0.130964] audit: type=2000 audit(1417352694.072:1): initialized
[    0.131689] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.134001] VFS: Disk quotas dquot_6.5.2
[    0.134392] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.135075] msgmni has been set to 853
[    0.135470] SELinux:  Registering netfilter hooks
[    0.136229] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.136800] io scheduler noop registered
[    0.137130] io scheduler deadline registered
[    0.137780] io scheduler cfq registered (default)
[    0.138211] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.138620] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.160508] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.161598] kworker/u2:0 (103) used greatest stack depth: 13824 bytes left
[    0.162655] Non-volatile memory driver v1.3
[    0.163132] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.163730] ACPI: Power Button [PWRF]
[    0.164598] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
[    0.167027] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[    0.168094] loop: module loaded
[    0.168516] virtio-pci 0000:00:04.0: irq 24 for MSI/MSI-X
[    0.168533] virtio-pci 0000:00:04.0: irq 25 for MSI/MSI-X
[    0.238788]  vda: vda1 vda2
[    0.241107] ata_piix 0000:00:01.1: version 2.13
[    0.242218] scsi host0: ata_piix
[    0.243355] scsi host1: ata_piix
[    0.244154] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0a0 irq 14
[    0.245106] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0a8 irq 15
[    0.246100] virtio-pci 0000:00:03.0: irq 26 for MSI/MSI-X
[    0.246117] virtio-pci 0000:00:03.0: irq 27 for MSI/MSI-X
[    0.246132] virtio-pci 0000:00:03.0: irq 28 for MSI/MSI-X
[    0.370758] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.371712] ehci-pci: EHCI PCI platform driver
[    0.372744] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.373847] ohci-pci: OHCI PCI platform driver
[    0.375816] uhci_hcd: USB Universal Host Controller Interface driver
[    0.377697] uhci_hcd 0000:00:01.2: UHCI Host Controller
[    0.378232] uhci_hcd 0000:00:01.2: new USB bus registered, assigned bus number 1
[    0.378893] uhci_hcd 0000:00:01.2: irq 11, io base 0x0000c040
[    0.379394] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    0.380633] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.381468] usb usb1: Product: UHCI Host Controller
[    0.382223] usb usb1: Manufacturer: Linux 3.17.4-gentoo uhci_hcd
[    0.382774] usb usb1: SerialNumber: 0000:00:01.2
[    0.383488] hub 1-0:1.0: USB hub found
[    0.383825] hub 1-0:1.0: 2 ports detected
[    0.384360] usbcore: registered new interface driver usblp
[    0.384753] usbcore: registered new interface driver usb-storage
[    0.385201] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.386394] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.386763] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.387457] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.388245] rtc_cmos 00:00: RTC can wake from S4
[    0.388833] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    0.389510] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram, hpet irqs
[    0.390051] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel@redhat.com
[    0.390691] hidraw: raw HID events driver (C) Jiri Kosina
[    0.391348] usbcore: registered new interface driver usbhid
[    0.391695] usbhid: USB HID core driver
[    0.392063] Netfilter messages via NETLINK v0.30.
[    0.392452] nf_conntrack version 0.5.0 (3413 buckets, 13652 max)
[    0.392925] ctnetlink v0.93: registering with nfnetlink.
[    0.393444] ip_tables: (C) 2000-2006 Netfilter Core Team
[    0.393810] TCP: cubic registered
[    0.394119] Initializing XFRM netlink socket
[    0.394615] NET: Registered protocol family 10
[    0.395307] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    0.395729] sit: IPv6 over IPv4 tunneling driver
[    0.396443] NET: Registered protocol family 17
[    0.396788] 9pnet: Installing 9P2000 support
[    0.397189] Key type dns_resolver registered
[    0.397777] Loading compiled-in X.509 certificates
[    0.398145] registered taskstats version 1
[    0.398744]   Magic number: 6:178:80
[    0.399122] console [netcon0] enabled
[    0.399430] netconsole: network logging started
[    0.399824] PM: Hibernation image not present or could not be loaded.
[    0.445438] ata2.01: NODEV after polling detection
[    0.445794] ata2.00: ATAPI: QEMU DVD-ROM, 1.1.2, max UDMA/100
[    0.446615] ata2.00: configured for MWDMA2
[    0.447433] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     1.1. PQ: 0 ANSI: 5
[    0.458485] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    0.458895] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.459389] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    0.459586] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    0.459992] md: Skipping autodetection of RAID arrays. (raid=autodetect will force)
[    0.476202] kjournald starting.  Commit interval 5 seconds
[    0.477309] EXT3-fs (vda1): mounted filesystem with ordered data mode
[    0.478236] VFS: Mounted root (ext3 filesystem) readonly on device 253:1.
[    0.514547] devtmpfs: mounted
[    0.515796] Freeing unused kernel memory: 1060K (ffffffff81ac3000 - ffffffff81bcc000)
[    0.516445] Write protecting the kernel read-only data: 10240k
[    0.521240] Freeing unused kernel memory: 1896K (ffff880001626000 - ffff880001800000)
[    0.522093] Freeing unused kernel memory: 56K (ffff8800019f2000 - ffff880001a00000)
[    0.686552] usb 1-1: new full-speed USB device number 2 using uhci_hcd
[    1.009378] usb 1-1: New USB device found, idVendor=0627, idProduct=0001
[    1.009803] usb 1-1: New USB device strings: Mfr=1, Product=3, SerialNumber=5
[    1.010202] usb 1-1: Product: QEMU USB Tablet
[    1.010548] usb 1-1: Manufacturer: QEMU 1.1.2
[    1.010916] usb 1-1: SerialNumber: 42
[    1.028402] input: QEMU 1.1.2 QEMU USB Tablet as /devices/pci0000:00/0000:00:01.2/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input3
[    1.029135] hid-generic 0003:0627:0001.0001: input,hidraw0: USB HID v0.01 Pointer [QEMU 1.1.2 QEMU USB Tablet] on usb-0000:00:01.2-1/input0
[    1.128081] tsc: Refined TSC clocksource calibration: 2593.620 MHz
[    2.373130] init-early.sh (723) used greatest stack depth: 11992 bytes left
[    6.295118] systemd-udevd[897]: starting version 216
[    6.556720] random: systemd-udevd urandom read with 12 bits of entropy available
[    7.733863] mousedev: PS/2 mouse device common for all mice
[    7.900399] Linux agpgart interface v0.103
[    8.372811] SSE version of gcm_enc/dec engaged.
[    8.375858] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input4
[    9.684805] EXT3-fs (vda1): using internal journal
[   10.007819] Adding 1571836k swap on /dev/vda2.  Priority:-1 extents:1 across:1571836k 
[   10.926006] chgrp (1134) used greatest stack depth: 11960 bytes left
[   23.419985] device eth0 entered promiscuous mode
[   24.077112] ntop (1719) used greatest stack depth: 11944 bytes left
[   24.724336] sshd (1746) used greatest stack depth: 11784 bytes left
[   68.409724] tun: Universal TUN/TAP device driver, 1.6
[   68.409728] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   69.467798] batman_adv: B.A.T.M.A.N. advanced 2014.3.0-44-g650251a-dirty (compatibility version 15) loaded
[   69.687485] batman_adv: bat0: Adding interface: fastd0
[   69.687490] batman_adv: bat0: The MTU of interface fastd0 is too small (1426) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1532 would solve the problem.
[   69.687499] batman_adv: bat0: Interface activated: fastd0
[   69.700188] batman_adv: bat0: orig_interval: Changing from: 1000 to: 5000
[   69.706917] batman_adv: bat0: bridge_loop_avoidance: Changing from: disabled to: enabled
[   69.712381] batman_adv: bat0: Changing gw mode from: off to: client
[   79.832661] random: nonblocking pool is initialized
[   84.632237] ipip: IPv4 over IPv4 tunneling driver
[  138.729131] batman_adv: bat0: Changing gw mode from: client to: server
[  138.729164] batman_adv: bat0: Changing gateway bandwidth from: '10.0/2.0 MBit' to: '90.0/90.0 MBit'
[ 1086.573206] nf_conntrack: automatic helper assignment is deprecated and it will be removed soon. Use the iptables CT target to attach helpers instead.
[ 2102.215674] batadv_frag_merge_packets: i: 1, size: 1380, entry->seqno: 6144, entry->size: 6638, entry->total_size: 34816
[ 2102.215679]   skb->len: 84, skb->tailroom: 522, pkt->pkt_type: 64, pkt->version: 15, pkt->no: 0, pkt->seqno: 53427, pkt->total_size: 16338
[ 2102.215681]   skb->len: 1400, skb->tailroom: 250, pkt->pkt_type: 65, pkt->version: 15, pkt->no: 0, pkt->seqno: 56866, pkt->total_size: 1464
[ 2102.233701] general protection fault: 0000 [#1] SMP 
[ 2102.233919] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipip batman_adv(O) libcrc32c tun crc32c_intel aesni_intel aes_x86_64 intel_agp glue_helper lrw intel_gtt agpgart gf128mul psmouse ablk_helper mousedev evdev cryptd
[ 2102.234264] CPU: 0 PID: 1748 Comm: ntop Tainted: G           O   3.17.4-gentoo #1
[ 2102.234264] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[ 2102.234264] task: ffff880019d04f50 ti: ffff880019ce8000 task.ti: ffff880019ce8000
[ 2102.234264] RIP: 0010:[<ffffffff8115c24d>]  [<ffffffff8115c24d>] __kmalloc_node_track_caller+0xed/0x1b0
[ 2102.234264] RSP: 0000:ffff88001fc039b8  EFLAGS: 00010246
[ 2102.234264] RAX: 0000000000000000 RBX: ffff880019ee1f00 RCX: 0000000000053faa
[ 2102.234264] RDX: 0000000000053fa9 RSI: 0000000000000000 RDI: 0000000000015900
[ 2102.234264] RBP: ffff88001fc039f8 R08: ffff88001fc15900 R09: ffff880005b09400
[ 2102.234264] R10: 313134310d17592b R11: ffff88001974b5a0 R12: ffff88001f001400
[ 2102.234264] R13: 00000000000007c0 R14: 00000000ffffffff R15: 0000000000010220
[ 2102.234264] FS:  00007f2eae7af700(0000) GS:ffff88001fc00000(0000) knlGS:0000000000000000
[ 2102.234264] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2102.234264] CR2: 0000000005cf7080 CR3: 000000001f26e000 CR4: 00000000000006f0
[ 2102.234264] Stack:
[ 2102.234264]  ffff8800195e9e40 ffffffff81465af7 ffff880019ee1400 ffff880019ee1f00
[ 2102.234264]  0000000000000000 0000000000000020 00000000000007c0 00000000ffffffff
[ 2102.234264]  ffff88001fc03a48 ffffffff81464387 0000000000000000 0000000000000000
[ 2102.234264] Call Trace:
[ 2102.234264]  <IRQ> 
[ 2102.234264] 
[ 2102.234264]  [<ffffffff81465af7>] ? pskb_expand_head+0x67/0x270
[ 2102.234264]  [<ffffffff81464387>] __kmalloc_reserve.isra.58+0x37/0xa0
[ 2102.234264]  [<ffffffff81465af7>] pskb_expand_head+0x67/0x270
[ 2102.234264]  [<ffffffff81466207>] __pskb_pull_tail+0x47/0x320
[ 2102.234264]  [<ffffffff814762c2>] dev_hard_start_xmit+0x3a2/0x580
[ 2102.234264]  [<ffffffff814c4000>] ? ip_finish_output2+0x300/0x300
[ 2102.234264]  [<ffffffff81476798>] __dev_queue_xmit+0x2f8/0x4b0
[ 2102.234264]  [<ffffffff8147696b>] dev_queue_xmit+0xb/0x10
[ 2102.234264]  [<ffffffff814c4608>] ip_finish_output+0x608/0x7f0
[ 2102.234264]  [<ffffffff814c5128>] ip_output+0x88/0x90
[ 2102.234264]  [<ffffffff814c0d41>] ip_forward_finish+0x61/0x80
[ 2102.234264]  [<ffffffff814c10fe>] ip_forward+0x39e/0x430
[ 2102.234264]  [<ffffffff814bef2c>] ip_rcv_finish+0x7c/0x320
[ 2102.234264]  [<ffffffff814bf86c>] ip_rcv+0x2dc/0x3f0
[ 2102.234264]  [<ffffffff81474152>] __netif_receive_skb_core+0x222/0x740
[ 2102.234264]  [<ffffffff81474691>] __netif_receive_skb+0x21/0x70
[ 2102.234264]  [<ffffffff81474878>] netif_receive_skb_internal+0x28/0x90
[ 2102.234264]  [<ffffffff814749dc>] napi_gro_complete+0x9c/0xd0
[ 2102.234264]  [<ffffffff81474d72>] napi_gro_flush+0x62/0x90
[ 2102.234264]  [<ffffffff81474dc2>] napi_complete+0x22/0x50
[ 2102.234264]  [<ffffffff81507e26>] gro_cell_poll+0x96/0xb0
[ 2102.234264]  [<ffffffff81474f31>] net_rx_action+0x141/0x240
[ 2102.234264]  [<ffffffff81052e28>] __do_softirq+0xe8/0x280
[ 2102.234264]  [<ffffffff81053205>] irq_exit+0x95/0xa0
[ 2102.234264]  [<ffffffff810046f2>] do_IRQ+0x62/0x110
[ 2102.234264]  [<ffffffff8161f26d>] common_interrupt+0x6d/0x6d
[ 2102.234264]  <EOI> 
[ 2102.234264] 
[ 2102.234264]  [<ffffffff8161e769>] ? system_call_fastpath+0x16/0x1b
[ 2102.234264] Code: 00 4c 89 d0 48 8b 5d d8 4c 8b 65 e0 4c 8b 6d e8 4c 8b 75 f0 4c 8b 7d f8 c9 c3 0f 1f 40 00 49 63 44 24 20 49 8b 3c 24 48 8d 4a 01 <49> 8b 1c 02 4c 89 d0 65 48 0f c7 0f 0f 94 c0 84 c0 0f 84 56 ff 
[ 2102.234264] RIP  [<ffffffff8115c24d>] __kmalloc_node_track_caller+0xed/0x1b0
[ 2102.234264]  RSP <ffff88001fc039b8>


