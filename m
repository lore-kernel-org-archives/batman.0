Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1417346458.6337.9.camel@katze>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sun, 30 Nov 2014 12:20:58 +0100
In-Reply-To: <1417343787.5442.20.camel@katze>
References: <1416938767-29156-1-git-send-email-sven@narfation.org>
 <5474CCF8.9030008@hundeboll.net> <1417343787.5442.20.camel@katze>
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

Hi Sven, hi Martin, hi all

it’s me again. After 11 minutes in gw mode the VM crashes again. The
“attacker” is back. Its your chance for new patches ;-) I disable
fragmentation, lets see if it helps.

I think I might did a mistake. The kernel is compiled with gcc 4.7.3,
the patched module with 4.8.3. On the next crash I recompile the module.


Best regards

Philipp

________________________
Freifunk Rheinland e. V.
– Funkzelle Wuppertal –


  SYSTEM MAP: /boot/System.map                                         
DEBUG KERNEL: /usr/src/linux-3.17.4-gentoo/vmlinux (3.17.4-gentoo)
    DUMPFILE: vmcore_20141130115537
        CPUS: 1
        DATE: Thu Jan  1 01:00:00 1970
      UPTIME: 01:02:39
LOAD AVERAGE: 0.30, 0.22, 0.19
       TASKS: 134
    NODENAME: wolke
     RELEASE: 3.17.4-gentoo
     VERSION: #1 SMP Tue Nov 25 12:37:10 CET 2014
     MACHINE: x86_64  (2593 Mhz)
      MEMORY: 511.6 MB
       PANIC: "kernel BUG at net/core/skbuff.c:100!"
         PID: 1844
     COMMAND: "fastd"
        TASK: ffff88001a2eb4e0  [THREAD_INFO: ffff8800194c4000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 1844   TASK: ffff88001a2eb4e0  CPU: 0   COMMAND: "fastd"
 #0 [ffff88001fc03980] machine_kexec at ffffffff8103ab9e
 #1 [ffff88001fc039e0] crash_kexec at ffffffff810bfa23
 #2 [ffff88001fc03ab0] oops_end at ffffffff810060f8
 #3 [ffff88001fc03ae0] die at ffffffff81006593
 #4 [ffff88001fc03b10] do_trap at ffffffff81002ef2
 #5 [ffff88001fc03b70] do_error_trap at ffffffff8100305d
 #6 [ffff88001fc03c30] do_invalid_op at ffffffff81003a7b
 #7 [ffff88001fc03c40] invalid_op at ffffffff8162009e
    [exception RIP: skb_panic+94]
    RIP: ffffffff81618ba3  RSP: ffff88001fc03cf8  RFLAGS: 00010296
    RAX: 000000000000008b  RBX: ffff88001f2bfae0  RCX: 0000000000000092
    RDX: 0000000000000056  RSI: 0000000000000246  RDI: 0000000000000246
    RBP: ffff88001fc03d18   R8: 0000000000000000   R9: 0000000000000000
    R10: ffffffff8184ad60  R11: 0000000000000000  R12: 0000000000000564
    R13: ffff88001fc03da0  R14: ffff88001f29b100  R15: ffff880012f5f862
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ffff88001fc03d20] skb_put at ffffffff81464321
 #9 [ffff88001fc03d30] batadv_frag_skb_buffer at ffffffffa00afe52 [batman_adv]
#10 [ffff88001fc03d90] batadv_recv_frag_packet at ffffffffa00ba2a3 [batman_adv]
#11 [ffff88001fc03dd0] batadv_batman_skb_recv at ffffffffa00b3f35 [batman_adv]
#12 [ffff88001fc03e10] __netif_receive_skb_core at ffffffff81474152
#13 [ffff88001fc03e80] __netif_receive_skb at ffffffff81474691
#14 [ffff88001fc03ea0] process_backlog at ffffffff8147477e
#15 [ffff88001fc03ef0] net_rx_action at ffffffff81474f31
#16 [ffff88001fc03f50] __do_softirq at ffffffff81052e28
#17 [ffff88001fc03fb0] do_softirq_own_stack at ffffffff8162029c
--- <IRQ stack> ---
#18 [ffff8800194c7d10] do_softirq_own_stack at ffffffff8162029c
    [exception RIP: tun_get_user+1043]
    RIP: ffffffffa009d8f3  RSP: 0000000000000001  RFLAGS: 7fff00000586
    RAX: ffffffff814736a4  RBX: ffff8800194c7d58  RCX: ffff880019fec780
    RDX: 0000000000000000  RSI: ffff880019fec780  RDI: 0000000000000586
    RBP: ffffffff814733d4   R8: ffff8800194c7d88   R9: ffff880019fec780
    R10: ffff880019fec780  R11: ffffffff81053065  R12: ffff8800194c7d58
    R13: 0000000000000586  R14: ffff88001f29b400  R15: 0000000000000000
    ORIG_RAX: ffff8800194c7e38  CS: 7fff052c4f40  SS: 0000
bt: WARNING: possibly bogus exception frame
#19 [ffff8800194c7e40] tun_chr_aio_write at ffffffffa009de1b [tun]
#20 [ffff8800194c7e70] do_sync_write at ffffffff811611a5
#21 [ffff8800194c7f00] vfs_write at ffffffff81161eca
#22 [ffff8800194c7f40] sys_write at ffffffff811623da
#23 [ffff8800194c7f80] system_call_fastpath at ffffffff8161e769
    RIP: 00007f477624537d  RSP: 00007fff052c51c8  RFLAGS: 00010202
    RAX: 0000000000000001  RBX: ffffffff8161e769  RCX: 0000000000000084
    RDX: 0000000000000586  RSI: 00000000006ddbe0  RDI: 0000000000000009
    RBP: 0000000000000586   R8: 00007f477622e400   R9: 00007fff052c4688
    R10: 00007fff052c4dcf  R11: 0000000000000293  R12: 00000000006e8df8
    R13: 0000000000000001  R14: 00000000006ddbd0  R15: 00000000006cc990
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
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
[    0.002005] pid_max: default: 32768 minimum: 301
[    0.002385] ACPI: Core revision 20140724
[    0.003658] ACPI: All ACPI Tables successfully acquired
[    0.004041] Security Framework initialized
[    0.004406] SELinux:  Initializing.
[    0.004762] SELinux:  Starting in permissive mode
[    0.004794] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.005279] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.006137] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.006557] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.007250] Initializing cgroup subsys freezer
[    0.007698] mce: CPU supports 10 MCE banks
[    0.008047] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
               Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.023008] Freeing SMP alternatives memory: 24K (ffffffff81bcc000 - ffffffff81bd2000)
[    0.027000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.027003] smpboot: CPU0: Intel Westmere E56xx/L56xx/X56xx (Nehalem-C) (fam: 06, model: 2c, stepping: 01)
[    0.029000] Performance Events: unsupported p6 CPU model 44 no PMU driver, software events only.
[    0.029303] x86: Booted up 1 node, 1 CPUs
[    0.029620] smpboot: Total of 1 processors activated (5187.49 BogoMIPS)
[    0.030387] devtmpfs: initialized
[    0.031148] RTC time:  9:47:32, date: 11/30/14
[    0.031623] NET: Registered protocol family 16
[    0.032122] cpuidle: using governor ladder
[    0.032443] cpuidle: using governor menu
[    0.032796] ACPI: bus type PCI registered
[    0.033102] PCI: Using configuration type 1 for base access
[    0.035502] kworker/u2:0 (14) used greatest stack depth: 14664 bytes left
[    0.036118] ACPI: Added _OSI(Module Device)
[    0.036436] ACPI: Added _OSI(Processor Device)
[    0.036749] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.037004] ACPI: Added _OSI(Processor Aggregator Device)
[    0.038805] ACPI: Interpreter enabled
[    0.039007] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20140724/hwxface-580)
[    0.039760] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20140724/hwxface-580)
[    0.040597] ACPI: (supports S0 S3 S4 S5)
[    0.040905] ACPI: Using IOAPIC for interrupt routing
[    0.041060] kworker/u2:0 (21) used greatest stack depth: 13912 bytes left
[    0.041540] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.044640] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.045007] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.045381] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.045754] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7] (ignored)
[    0.045756] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff] (ignored)
[    0.045757] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff] (ignored)
[    0.045759] acpi PNP0A03:00: host bridge window [mem 0xe0000000-0xfebfffff] (ignored)
[    0.045760] PCI: root bus 00: using default resources
[    0.045762] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.046068] PCI host bridge to bus 0000:00
[    0.046385] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.047044] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.047401] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffff]
[    0.047806] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.048296] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.048731] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.050357] pci 0000:00:01.1: reg 0x20: [io  0xc0a0-0xc0af]
[    0.051025] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.051445] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.051803] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.052003] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.052531] pci 0000:00:01.2: [8086:7020] type 00 class 0x0c0300
[    0.054305] pci 0000:00:01.2: reg 0x20: [io  0xc040-0xc05f]
[    0.055127] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.055443] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
[    0.055996] pci 0000:00:01.3: quirk: [io  0xb100-0xb10f] claimed by PIIX4 SMB
[    0.056584] pci 0000:00:02.0: [1013:00b8] type 00 class 0x030000
[    0.060100] pci 0000:00:02.0: reg 0x10: [mem 0xfc000000-0xfdffffff pref]
[    0.063075] pci 0000:00:02.0: reg 0x14: [mem 0xfebf0000-0xfebf0fff]
[    0.077042] pci 0000:00:02.0: reg 0x30: [mem 0xfebd0000-0xfebdffff pref]
[    0.078282] pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
[    0.078904] pci 0000:00:03.0: reg 0x10: [io  0xc060-0xc07f]
[    0.079291] pci 0000:00:03.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    0.082289] pci 0000:00:03.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.082745] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[    0.085009] pci 0000:00:04.0: reg 0x10: [io  0xc000-0xc03f]
[    0.087009] pci 0000:00:04.0: reg 0x14: [mem 0xfebf2000-0xfebf2fff]
[    0.092431] pci 0000:00:05.0: [1af4:1002] type 00 class 0x00ff00
[    0.092768] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc09f]
[    0.095400] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.096089] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.096825] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.097618] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.098460] ACPI: PCI Interrupt Link [LNKS] (IRQs 9) *0, disabled.
[    0.099356] ACPI: Enabled 16 GPEs in block 00 to 0F
[    0.100242] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.100585] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.101006] vgaarb: loaded
[    0.101314] vgaarb: bridge control possible 0000:00:02.0
[    0.102030] SCSI subsystem initialized
[    0.102446] libata version 3.00 loaded.
[    0.102478] ACPI: bus type USB registered
[    0.102847] usbcore: registered new interface driver usbfs
[    0.103025] usbcore: registered new interface driver hub
[    0.103424] usbcore: registered new device driver usb
[    0.104014] pps_core: LinuxPPS API ver. 1 registered
[    0.104343] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.104929] PTP clock support registered
[    0.105120] PCI: Using ACPI for IRQ routing
[    0.105440] PCI: pci_cache_line_size set to 64 bytes
[    0.105570] e820: reserve RAM buffer [mem 0x0009dc00-0x0009ffff]
[    0.105574] e820: reserve RAM buffer [mem 0x1fffe000-0x1fffffff]
[    0.106185] NetLabel: Initializing
[    0.106489] NetLabel:  domain hash size = 128
[    0.106800] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.107033] NetLabel:  unlabeled traffic allowed by default
[    0.107510] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.108023] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.108577] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.115025] cfg80211: Calling CRDA to update world regulatory domain
[    0.115490] Switched to clocksource kvm-clock
[    0.123112] pnp: PnP ACPI init
[    0.123547] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.123612] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.123655] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.123686] pnp 00:03: [dma 2]
[    0.123720] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.123822] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.124050] pnp: PnP ACPI: found 5 devices
[    0.129076] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.129079] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffffff]
[    0.129125] NET: Registered protocol family 2
[    0.129716] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.130158] TCP bind hash table entries: 4096 (order: 4, 65536 bytes)
[    0.130540] TCP: Hash tables configured (established 4096 bind 4096)
[    0.130980] TCP: reno registered
[    0.131294] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.131646] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.132158] NET: Registered protocol family 1
[    0.132503] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.132859] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.133236] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.133841] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.134427] pci 0000:00:02.0: Video device with shadowed ROM
[    0.134458] PCI: CLS 0 bytes, default 64
[    0.134734] microcode: CPU0 sig=0x206c1, pf=0x1, revision=0x1
[    0.135150] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.135839] Scanning for low memory corruption every 60 seconds
[    0.136498] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.136876] Initialise system trusted keyring
[    0.137226] audit: initializing netlink subsys (disabled)
[    0.137585] audit: type=2000 audit(1417340856.464:1): initialized
[    0.138319] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.140523] VFS: Disk quotas dquot_6.5.2
[    0.140880] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.141526] msgmni has been set to 853
[    0.141928] SELinux:  Registering netfilter hooks
[    0.142670] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.143248] io scheduler noop registered
[    0.143556] io scheduler deadline registered
[    0.143922] io scheduler cfq registered (default)
[    0.144344] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.144737] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.166631] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.167640] kworker/u2:0 (102) used greatest stack depth: 13824 bytes left
[    0.168600] Non-volatile memory driver v1.3
[    0.169046] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.169603] ACPI: Power Button [PWRF]
[    0.170536] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
[    0.172877] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[    0.173922] loop: module loaded
[    0.174393] virtio-pci 0000:00:04.0: irq 24 for MSI/MSI-X
[    0.174410] virtio-pci 0000:00:04.0: irq 25 for MSI/MSI-X
[    0.269707]  vda: vda1 vda2
[    0.273105] ata_piix 0000:00:01.1: version 2.13
[    0.273796] scsi host0: ata_piix
[    0.274658] scsi host1: ata_piix
[    0.275272] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0a0 irq 14
[    0.275926] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0a8 irq 15
[    0.277315] virtio-pci 0000:00:03.0: irq 26 for MSI/MSI-X
[    0.277341] virtio-pci 0000:00:03.0: irq 27 for MSI/MSI-X
[    0.277365] virtio-pci 0000:00:03.0: irq 28 for MSI/MSI-X
[    0.391545] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.391943] ehci-pci: EHCI PCI platform driver
[    0.392349] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.392726] ohci-pci: OHCI PCI platform driver
[    0.393081] uhci_hcd: USB Universal Host Controller Interface driver
[    0.393662] uhci_hcd 0000:00:01.2: UHCI Host Controller
[    0.394114] uhci_hcd 0000:00:01.2: new USB bus registered, assigned bus number 1
[    0.394813] uhci_hcd 0000:00:01.2: irq 11, io base 0x0000c040
[    0.395294] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    0.395805] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.396395] usb usb1: Product: UHCI Host Controller
[    0.396757] usb usb1: Manufacturer: Linux 3.17.4-gentoo uhci_hcd
[    0.397119] usb usb1: SerialNumber: 0000:00:01.2
[    0.397574] hub 1-0:1.0: USB hub found
[    0.397934] hub 1-0:1.0: 2 ports detected
[    0.398432] usbcore: registered new interface driver usblp
[    0.398829] usbcore: registered new interface driver usb-storage
[    0.399263] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.400514] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.400888] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.401593] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.402438] rtc_cmos 00:00: RTC can wake from S4
[    0.403075] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    0.403543] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram, hpet irqs
[    0.404120] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel@redhat.com
[    0.404757] hidraw: raw HID events driver (C) Jiri Kosina
[    0.405355] usbcore: registered new interface driver usbhid
[    0.405711] usbhid: USB HID core driver
[    0.406083] Netfilter messages via NETLINK v0.30.
[    0.406460] nf_conntrack version 0.5.0 (3413 buckets, 13652 max)
[    0.406970] ctnetlink v0.93: registering with nfnetlink.
[    0.407466] ip_tables: (C) 2000-2006 Netfilter Core Team
[    0.407879] TCP: cubic registered
[    0.408205] Initializing XFRM netlink socket
[    0.408683] NET: Registered protocol family 10
[    0.409344] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    0.409754] sit: IPv6 over IPv4 tunneling driver
[    0.410210] NET: Registered protocol family 17
[    0.410586] 9pnet: Installing 9P2000 support
[    0.410975] Key type dns_resolver registered
[    0.411513] Loading compiled-in X.509 certificates
[    0.411878] registered taskstats version 1
[    0.412555]   Magic number: 6:475:779
[    0.412949] console [netcon0] enabled
[    0.413304] netconsole: network logging started
[    0.413712] PM: Hibernation image not present or could not be loaded.
[    0.466409] ata2.01: NODEV after polling detection
[    0.466688] ata2.00: ATAPI: QEMU DVD-ROM, 1.1.2, max UDMA/100
[    0.467499] ata2.00: configured for MWDMA2
[    0.468414] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     1.1. PQ: 0 ANSI: 5
[    0.479496] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    0.479869] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.480338] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    0.480504] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    0.480915] md: Skipping autodetection of RAID arrays. (raid=autodetect will force)
[    0.483102] kjournald starting.  Commit interval 5 seconds
[    0.483476] EXT3-fs (vda1): mounted filesystem with ordered data mode
[    0.484218] VFS: Mounted root (ext3 filesystem) readonly on device 253:1.
[    0.498907] devtmpfs: mounted
[    0.500261] Freeing unused kernel memory: 1060K (ffffffff81ac3000 - ffffffff81bcc000)
[    0.501218] Write protecting the kernel read-only data: 10240k
[    0.506982] Freeing unused kernel memory: 1896K (ffff880001626000 - ffff880001800000)
[    0.507745] Freeing unused kernel memory: 56K (ffff8800019f2000 - ffff880001a00000)
[    0.700126] usb 1-1: new full-speed USB device number 2 using uhci_hcd
[    1.009299] usb 1-1: New USB device found, idVendor=0627, idProduct=0001
[    1.009676] usb 1-1: New USB device strings: Mfr=1, Product=3, SerialNumber=5
[    1.010063] usb 1-1: Product: QEMU USB Tablet
[    1.010438] usb 1-1: Manufacturer: QEMU 1.1.2
[    1.010752] usb 1-1: SerialNumber: 42
[    1.027358] input: QEMU 1.1.2 QEMU USB Tablet as /devices/pci0000:00/0000:00:01.2/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input3
[    1.028412] hid-generic 0003:0627:0001.0001: input,hidraw0: USB HID v0.01 Pointer [QEMU 1.1.2 QEMU USB Tablet] on usb-0000:00:01.2-1/input0
[    1.136088] tsc: Refined TSC clocksource calibration: 2593.620 MHz
[    2.657635] init-early.sh (724) used greatest stack depth: 11992 bytes left
[    7.361256] systemd-udevd[898]: starting version 216
[    7.590448] random: systemd-udevd urandom read with 12 bits of entropy available
[    8.209705] mousedev: PS/2 mouse device common for all mice
[    8.371037] Linux agpgart interface v0.103
[    8.603751] SSE version of gcm_enc/dec engaged.
[    8.790935] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input4
[    9.371368] EXT3-fs (vda1): using internal journal
[    9.472116] Adding 1571836k swap on /dev/vda2.  Priority:-1 extents:1 across:1571836k 
[   17.458329] device eth0 entered promiscuous mode
[   88.105788] random: nonblocking pool is initialized
[  121.182185] tun: Universal TUN/TAP device driver, 1.6
[  121.182189] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[  121.690950] batman_adv: B.A.T.M.A.N. advanced 2014.4.0 (compatibility version 15) loaded
[  121.692541] batman_adv: bat0: Adding interface: fastd0
[  121.692544] batman_adv: bat0: The MTU of interface fastd0 is too small (1426) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
[  121.692551] batman_adv: bat0: Interface activated: fastd0
[  121.693433] batman_adv: bat0: orig_interval: Changing from: 1000 to: 5000
[  121.694870] batman_adv: bat0: bridge_loop_avoidance: Changing from: disabled to: enabled
[  121.695618] batman_adv: bat0: Changing gw mode from: off to: client
[  150.885842] ipip: IPv4 over IPv4 tunneling driver
[ 1364.020197] nf_conntrack: automatic helper assignment is deprecated and it will be removed soon. Use the iptables CT target to attach helpers instead.
[ 3042.769095] batman_adv: bat0: Changing gw mode from: client to: server
[ 3042.769127] batman_adv: bat0: Changing gateway bandwidth from: '10.0/2.0 MBit' to: '90.0/90.0 MBit'
[ 3759.633307] skbuff: skb_over_panic: text:ffffffffa00afe52 len:1464 put:1380 head:ffff880019ec8800 data:ffff880019ec8862 tail:0x61a end:0x2c0 dev:fastd0
[ 3759.633663] ------------[ cut here ]------------
[ 3759.633767] kernel BUG at net/core/skbuff.c:100!
[ 3759.633881] invalid opcode: 0000 [#1] SMP 
[ 3759.633983] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipip batman_adv libcrc32c tun crc32c_intel aesni_intel aes_x86_64 glue_helper intel_agp lrw gf128mul intel_gtt ablk_helper agpgart cryptd mousedev psmouse evdev
[ 3759.634203] CPU: 0 PID: 1844 Comm: fastd Not tainted 3.17.4-gentoo #1
[ 3759.634203] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[ 3759.634203] task: ffff88001a2eb4e0 ti: ffff8800194c4000 task.ti: ffff8800194c4000
[ 3759.634203] RIP: 0010:[<ffffffff81618ba3>]  [<ffffffff81618ba3>] skb_panic+0x5e/0x60
[ 3759.634203] RSP: 0018:ffff88001fc03cf8  EFLAGS: 00010296
[ 3759.634203] RAX: 000000000000008b RBX: ffff88001f2bfae0 RCX: 0000000000000092
[ 3759.634203] RDX: 0000000000000056 RSI: 0000000000000246 RDI: 0000000000000246
[ 3759.634203] RBP: ffff88001fc03d18 R08: 0000000000000000 R09: 0000000000000000
[ 3759.634203] R10: ffffffff8184ad60 R11: 0000000000000000 R12: 0000000000000564
[ 3759.634203] R13: ffff88001fc03da0 R14: ffff88001f29b100 R15: ffff880012f5f862
[ 3759.634203] FS:  00007f4776ef0700(0000) GS:ffff88001fc00000(0000) knlGS:0000000000000000
[ 3759.634203] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3759.634203] CR2: 00007f686a3675c2 CR3: 0000000000046000 CR4: 00000000000006f0
[ 3759.634203] Stack:
[ 3759.634203]  ffff880019ec8862 000000000000061a 00000000000002c0 ffff880019fec000
[ 3759.634203]  ffff88001fc03d28 ffffffff81464321 ffff88001fc03d88 ffffffffa00afe52
[ 3759.634203]  ffff880012f5f84e de1a88001f29bf00 000077ff80000000 ffff88001f2bfae0
[ 3759.634203] Call Trace:
[ 3759.634203]  <IRQ> 
[ 3759.634203] 
[ 3759.634203]  [<ffffffff81464321>] skb_put+0x41/0x50
[ 3759.634203]  [<ffffffffa00afe52>] batadv_frag_skb_buffer+0x292/0x490 [batman_adv]
[ 3759.634203]  [<ffffffffa00ba2a3>] batadv_recv_frag_packet+0x183/0x200 [batman_adv]
[ 3759.634203]  [<ffffffffa00b3f35>] batadv_batman_skb_recv+0xd5/0x110 [batman_adv]
[ 3759.634203]  [<ffffffff81474152>] __netif_receive_skb_core+0x222/0x740
[ 3759.634203]  [<ffffffff81474691>] __netif_receive_skb+0x21/0x70
[ 3759.634203]  [<ffffffff8147477e>] process_backlog+0x9e/0x170
[ 3759.634203]  [<ffffffff81474f31>] net_rx_action+0x141/0x240
[ 3759.634203]  [<ffffffff81052e28>] __do_softirq+0xe8/0x280
[ 3759.634203]  [<ffffffff8162029c>] do_softirq_own_stack+0x1c/0x30
[ 3759.634203]  <EOI> 
[ 3759.634203] 
[ 3759.634203]  [<ffffffff81053065>] do_softirq+0x55/0x60
[ 3759.634203]  [<ffffffff814736a4>] netif_rx_ni+0x34/0x70
[ 3759.634203]  [<ffffffffa009d8f3>] tun_get_user+0x413/0x840 [tun]
[ 3759.634203]  [<ffffffffa009de1b>] tun_chr_aio_write+0x7b/0xa0 [tun]
[ 3759.634203]  [<ffffffff811611a5>] do_sync_write+0x55/0x90
[ 3759.634203]  [<ffffffff81161eca>] vfs_write+0xba/0x1f0
[ 3759.634203]  [<ffffffff811623da>] SyS_write+0x4a/0xa0
[ 3759.634203]  [<ffffffff8161e769>] system_call_fastpath+0x16/0x1b
[ 3759.634203] Code: 00 00 48 89 44 24 10 8b 87 c0 00 00 00 48 89 44 24 08 48 8b 87 d0 00 00 00 48 c7 c7 40 e8 99 81 48 89 04 24 31 c0 e8 5f b3 ff ff <0f> 0b 55 48 89 f8 48 8b 57 30 48 89 e5 48 8b 0f 5d 80 e5 80 48 
[ 3759.634203] RIP  [<ffffffff81618ba3>] skb_panic+0x5e/0x60
[ 3759.634203]  RSP <ffff88001fc03cf8>


