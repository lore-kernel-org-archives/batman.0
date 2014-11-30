Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1417343787.5442.20.camel@katze>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sun, 30 Nov 2014 11:36:27 +0100
In-Reply-To: <5474CCF8.9030008@hundeboll.net>
References: <1416938767-29156-1-git-send-email-sven@narfation.org>
 <5474CCF8.9030008@hundeboll.net>
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

I thought after 6 days with 3.17.4 without your patch the crashes had
been solved with the new kernel. But the server crashed again yesterday.
So I implement your patch. 

Am Dienstag, den 25.11.2014, 19:39 +0100 schrieb Martin Hundebøll:
> Philipp:
> Can you please test this patch, and report back if it fixes your crash?

Patching was not trivial because the lines have changed. I did this
manually. I hope, I did it right. So now, after 10 h, there has been a
crash. I suggest, you tell me how to extract the bogus packages from the
vmcore dump so you can test them in the lab by yourselves. You also can
send me links with simple instructions to study to complete this task
because I do not know what to do.

Best regards

Philipp

________________________
Freifunk Rheinland e. V.
– Funkzelle Wuppertal –


#############################################################
diff -u fragmentation.c.ori fragmentation.c
--- fragmentation.c.ori	2014-11-25 10:04:40.000000000 +0100
+++ fragmentation.c	2014-11-29 23:57:33.000000000 +0100
@@ -162,6 +162,7 @@
 		hlist_add_head(&frag_entry_new->list, &chain->head);
 		chain->size = skb->len - hdr_size;
 		chain->timestamp = jiffies;
+		chain->total_size = ntohs(frag_packet->total_size);
 		ret = true;
 		goto out;
 	}
@@ -196,9 +197,11 @@
 
 out:
 	if (chain->size > batadv_frag_size_limit() ||
-	    ntohs(frag_packet->total_size) > batadv_frag_size_limit()) {
+	    chain->total_size != ntohs(frag_packet->total_size) ||
+	    chain->total_size > batadv_frag_size_limit()) {
 		/* Clear chain if total size of either the list or the packet
-		 * exceeds the maximum size of one merged packet.
+		 * exceeds the maximum size of one merged packet. Don't allow
+		 * packets to have different total_size.
 		 */
 		batadv_frag_clear_chain(&chain->head);
 		chain->size = 0;
diff -u types.h.ori types.h
--- types.h.ori	2014-11-29 23:51:40.000000000 +0100
+++ types.h	2014-11-30 00:02:21.000000000 +0100
@@ -140,6 +140,7 @@
 	unsigned long timestamp;
 	uint16_t seqno;
 	uint16_t size;
+	uint16_t total_size;
 };
 
 /**
#############################################################
      KERNEL: /usr/src/linux-3.17.4-gentoo/vmlinux
    DUMPFILE: vmcore_20141130104138
        CPUS: 1
        DATE: Thu Jan  1 01:00:00 1970
      UPTIME: 10:20:29
LOAD AVERAGE: 0.10, 0.15, 0.14
       TASKS: 122
    NODENAME: wolke
     RELEASE: 3.17.4-gentoo
     VERSION: #1 SMP Tue Nov 25 12:37:10 CET 2014
     MACHINE: x86_64  (2593 Mhz)
      MEMORY: 511.6 MB
       PANIC: "kernel BUG at net/core/skbuff.c:100!"
         PID: 1871
     COMMAND: "fastd"
        TASK: ffff88001a3fa340  [THREAD_INFO: ffff8800193c8000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 1871   TASK: ffff88001a3fa340  CPU: 0   COMMAND: "fastd"
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
    RAX: 000000000000008b  RBX: ffff88001a2af500  RCX: 0000000000000092
    RDX: 0000000000000070  RSI: 0000000000000246  RDI: 0000000000000246
    RBP: ffff88001fc03d18   R8: 0000000000000000   R9: 0000000000000000
    R10: ffffffff8184ad60  R11: 0000000000000000  R12: 0000000000000564
    R13: ffff88001fc03da0  R14: ffff88001a21f000  R15: ffff880013ab5062
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ffff88001fc03d20] skb_put at ffffffff81464321
 #9 [ffff88001fc03d30] batadv_frag_skb_buffer at ffffffffa00a8e52 [batman_adv]
#10 [ffff88001fc03d90] batadv_recv_frag_packet at ffffffffa00b32a3 [batman_adv]
#11 [ffff88001fc03dd0] batadv_batman_skb_recv at ffffffffa00acf35 [batman_adv]
#12 [ffff88001fc03e10] __netif_receive_skb_core at ffffffff81474152
#13 [ffff88001fc03e80] __netif_receive_skb at ffffffff81474691
#14 [ffff88001fc03ea0] process_backlog at ffffffff8147477e
#15 [ffff88001fc03ef0] net_rx_action at ffffffff81474f31
#16 [ffff88001fc03f50] __do_softirq at ffffffff81052e28
#17 [ffff88001fc03fb0] do_softirq_own_stack at ffffffff8162029c
--- <IRQ stack> ---
#18 [ffff8800193cbd10] do_softirq_own_stack at ffffffff8162029c
    [exception RIP: tun_get_user+1043]
    RIP: ffffffffa00968f3  RSP: 0000000000000001  RFLAGS: 7fff00000586
    RAX: ffffffff814736a4  RBX: ffff8800193cbd58  RCX: ffff88001a1f8780
    RDX: 0000000000000000  RSI: ffff88001a1f8780  RDI: 0000000000000586
    RBP: ffffffff814733d4   R8: ffff8800193cbd88   R9: ffff88001a1f8780
    R10: ffff88001a1f8780  R11: ffffffff81053065  R12: ffff8800193cbd58
    R13: 0000000000000586  R14: ffff880019ced900  R15: 0000000000000000
    ORIG_RAX: ffff8800193cbe38  CS: 7fff054d06e0  SS: 0000
bt: WARNING: possibly bogus exception frame
#19 [ffff8800193cbe40] tun_chr_aio_write at ffffffffa0096e1b [tun]
#20 [ffff8800193cbe70] do_sync_write at ffffffff811611a5
#21 [ffff8800193cbf00] vfs_write at ffffffff81161eca
#22 [ffff8800193cbf40] sys_write at ffffffff811623da
#23 [ffff8800193cbf80] system_call_fastpath at ffffffff8161e769
    RIP: 00007f24755b737d  RSP: 00007fff054d0398  RFLAGS: 00000212
    RAX: 0000000000000001  RBX: ffffffff8161e769  RCX: 00007f24755b78fd
    RDX: 0000000000000586  RSI: 0000000002416190  RDI: 0000000000000009
    RBP: 0000000000000586   R8: 00007f24755a0400   R9: 00007fff054cfe28
    R10: 00007fff054d056f  R11: 0000000000000293  R12: 0000000002421008
    R13: 0000000000000001  R14: 0000000002416180  R15: 0000000002404990
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
[    0.002383] ACPI: Core revision 20140724
[    0.003698] ACPI: All ACPI Tables successfully acquired
[    0.004047] Security Framework initialized
[    0.004420] SELinux:  Initializing.
[    0.005010] SELinux:  Starting in permissive mode
[    0.005043] Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.005776] Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
[    0.006135] Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.006553] Mountpoint-cache hash table entries: 1024 (order: 1, 8192 bytes)
[    0.007351] Initializing cgroup subsys freezer
[    0.008085] mce: CPU supports 10 MCE banks
[    0.008506] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
               Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.022632] Freeing SMP alternatives memory: 24K (ffffffff81bcc000 - ffffffff81bd2000)
[    0.026834] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.027003] smpboot: CPU0: Intel Westmere E56xx/L56xx/X56xx (Nehalem-C) (fam: 06, model: 2c, stepping: 01)
[    0.029000] Performance Events: unsupported p6 CPU model 44 no PMU driver, software events only.
[    0.029373] x86: Booted up 1 node, 1 CPUs
[    0.029729] smpboot: Total of 1 processors activated (5187.49 BogoMIPS)
[    0.030417] devtmpfs: initialized
[    0.031278] RTC time: 23:09:03, date: 11/29/14
[    0.031732] NET: Registered protocol family 16
[    0.032159] cpuidle: using governor ladder
[    0.032479] cpuidle: using governor menu
[    0.032828] ACPI: bus type PCI registered
[    0.033107] PCI: Using configuration type 1 for base access
[    0.035470] kworker/u2:0 (14) used greatest stack depth: 14664 bytes left
[    0.036107] ACPI: Added _OSI(Module Device)
[    0.036462] ACPI: Added _OSI(Processor Device)
[    0.036778] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.037004] ACPI: Added _OSI(Processor Aggregator Device)
[    0.038827] ACPI: Interpreter enabled
[    0.039008] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S1_] (20140724/hwxface-580)
[    0.040005] ACPI Exception: AE_NOT_FOUND, While evaluating Sleep State [\_S2_] (20140724/hwxface-580)
[    0.040742] ACPI: (supports S0 S3 S4 S5)
[    0.041005] ACPI: Using IOAPIC for interrupt routing
[    0.041473] kworker/u2:0 (21) used greatest stack depth: 13912 bytes left
[    0.042011] PCI: Ignoring host bridge windows from ACPI; if necessary, use "pci=use_crs" and report a bug
[    0.044775] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
[    0.045008] acpi PNP0A03:00: _OSC: OS supports [ASPM ClockPM Segments MSI]
[    0.045406] acpi PNP0A03:00: _OSC failed (AE_NOT_FOUND); disabling ASPM
[    0.045781] acpi PNP0A03:00: host bridge window [io  0x0000-0x0cf7] (ignored)
[    0.045783] acpi PNP0A03:00: host bridge window [io  0x0d00-0xffff] (ignored)
[    0.045785] acpi PNP0A03:00: host bridge window [mem 0x000a0000-0x000bffff] (ignored)
[    0.045786] acpi PNP0A03:00: host bridge window [mem 0xe0000000-0xfebfffff] (ignored)
[    0.045787] PCI: root bus 00: using default resources
[    0.045790] acpi PNP0A03:00: fail to add MMCONFIG information, can't access extended PCI configuration space under this bridge.
[    0.046083] PCI host bridge to bus 0000:00
[    0.047047] pci_bus 0000:00: root bus resource [bus 00-ff]
[    0.047392] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    0.047770] pci_bus 0000:00: root bus resource [mem 0x00000000-0xffffffffff]
[    0.048045] pci 0000:00:00.0: [8086:1237] type 00 class 0x060000
[    0.048378] pci 0000:00:01.0: [8086:7000] type 00 class 0x060100
[    0.049024] pci 0000:00:01.1: [8086:7010] type 00 class 0x010180
[    0.050616] pci 0000:00:01.1: reg 0x20: [io  0xc0a0-0xc0af]
[    0.051185] pci 0000:00:01.1: legacy IDE quirk: reg 0x10: [io  0x01f0-0x01f7]
[    0.051555] pci 0000:00:01.1: legacy IDE quirk: reg 0x14: [io  0x03f6]
[    0.052003] pci 0000:00:01.1: legacy IDE quirk: reg 0x18: [io  0x0170-0x0177]
[    0.052371] pci 0000:00:01.1: legacy IDE quirk: reg 0x1c: [io  0x0376]
[    0.052888] pci 0000:00:01.2: [8086:7020] type 00 class 0x0c0300
[    0.054478] pci 0000:00:01.2: reg 0x20: [io  0xc040-0xc05f]
[    0.055178] pci 0000:00:01.3: [8086:7113] type 00 class 0x068000
[    0.055496] pci 0000:00:01.3: quirk: [io  0xb000-0xb03f] claimed by PIIX4 ACPI
[    0.056018] pci 0000:00:01.3: quirk: [io  0xb100-0xb10f] claimed by PIIX4 SMB
[    0.056620] pci 0000:00:02.0: [1013:00b8] type 00 class 0x030000
[    0.058071] pci 0000:00:02.0: reg 0x10: [mem 0xfc000000-0xfdffffff pref]
[    0.060034] pci 0000:00:02.0: reg 0x14: [mem 0xfebf0000-0xfebf0fff]
[    0.070046] pci 0000:00:02.0: reg 0x30: [mem 0xfebd0000-0xfebdffff pref]
[    0.071793] pci 0000:00:03.0: [1af4:1000] type 00 class 0x020000
[    0.072324] pci 0000:00:03.0: reg 0x10: [io  0xc060-0xc07f]
[    0.073003] pci 0000:00:03.0: reg 0x14: [mem 0xfebf1000-0xfebf1fff]
[    0.075841] pci 0000:00:03.0: reg 0x30: [mem 0xfebe0000-0xfebeffff pref]
[    0.076488] pci 0000:00:04.0: [1af4:1001] type 00 class 0x010000
[    0.078004] pci 0000:00:04.0: reg 0x10: [io  0xc000-0xc03f]
[    0.080011] pci 0000:00:04.0: reg 0x14: [mem 0xfebf2000-0xfebf2fff]
[    0.084573] pci 0000:00:05.0: [1af4:1002] type 00 class 0x00ff00
[    0.084907] pci 0000:00:05.0: reg 0x10: [io  0xc080-0xc09f]
[    0.087506] ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
[    0.088574] ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
[    0.089318] ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
[    0.090149] ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
[    0.090879] ACPI: PCI Interrupt Link [LNKS] (IRQs 9) *0, disabled.
[    0.091854] ACPI: Enabled 16 GPEs in block 00 to 0F
[    0.092250] vgaarb: setting as boot device: PCI:0000:00:02.0
[    0.092593] vgaarb: device added: PCI:0000:00:02.0,decodes=io+mem,owns=io+mem,locks=none
[    0.093004] vgaarb: loaded
[    0.093287] vgaarb: bridge control possible 0000:00:02.0
[    0.094167] SCSI subsystem initialized
[    0.094577] libata version 3.00 loaded.
[    0.094608] ACPI: bus type USB registered
[    0.095060] usbcore: registered new interface driver usbfs
[    0.095417] usbcore: registered new interface driver hub
[    0.095799] usbcore: registered new device driver usb
[    0.096084] pps_core: LinuxPPS API ver. 1 registered
[    0.096465] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    0.097016] PTP clock support registered
[    0.097524] PCI: Using ACPI for IRQ routing
[    0.098014] PCI: pci_cache_line_size set to 64 bytes
[    0.098146] e820: reserve RAM buffer [mem 0x0009dc00-0x0009ffff]
[    0.098150] e820: reserve RAM buffer [mem 0x1fffe000-0x1fffffff]
[    0.098517] NetLabel: Initializing
[    0.098825] NetLabel:  domain hash size = 128
[    0.099002] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.099361] NetLabel:  unlabeled traffic allowed by default
[    0.100190] HPET: 3 timers in total, 0 timers will be used for per-cpu timer
[    0.100576] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0
[    0.101007] hpet0: 3 comparators, 64-bit 100.000000 MHz counter
[    0.105019] cfg80211: Calling CRDA to update world regulatory domain
[    0.106110] Switched to clocksource kvm-clock
[    0.114213] pnp: PnP ACPI init
[    0.114640] pnp 00:00: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.114703] pnp 00:01: Plug and Play ACPI device, IDs PNP0303 (active)
[    0.114746] pnp 00:02: Plug and Play ACPI device, IDs PNP0f13 (active)
[    0.114778] pnp 00:03: [dma 2]
[    0.114796] pnp 00:03: Plug and Play ACPI device, IDs PNP0700 (active)
[    0.114889] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (active)
[    0.115092] pnp: PnP ACPI: found 5 devices
[    0.120165] pci_bus 0000:00: resource 4 [io  0x0000-0xffff]
[    0.120168] pci_bus 0000:00: resource 5 [mem 0x00000000-0xffffffffff]
[    0.120203] NET: Registered protocol family 2
[    0.120761] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.121194] TCP bind hash table entries: 4096 (order: 4, 65536 bytes)
[    0.121574] TCP: Hash tables configured (established 4096 bind 4096)
[    0.122017] TCP: reno registered
[    0.122316] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.122667] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.123220] NET: Registered protocol family 1
[    0.123577] pci 0000:00:00.0: Limiting direct PCI/PCI transfers
[    0.123943] pci 0000:00:01.0: PIIX3: Enabling Passive Release
[    0.124320] pci 0000:00:01.0: Activating ISA DMA hang workarounds
[    0.124941] ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 11
[    0.125530] pci 0000:00:02.0: Video device with shadowed ROM
[    0.125570] PCI: CLS 0 bytes, default 64
[    0.125880] microcode: CPU0 sig=0x206c1, pf=0x1, revision=0x1
[    0.126301] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    0.127114] Scanning for low memory corruption every 60 seconds
[    0.127704] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.128092] Initialise system trusted keyring
[    0.128427] audit: initializing netlink subsys (disabled)
[    0.128784] audit: type=2000 audit(1417302546.973:1): initialized
[    0.129512] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.131683] VFS: Disk quotas dquot_6.5.2
[    0.132087] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.132721] msgmni has been set to 853
[    0.133137] SELinux:  Registering netfilter hooks
[    0.133865] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    0.134445] io scheduler noop registered
[    0.134751] io scheduler deadline registered
[    0.135173] io scheduler cfq registered (default)
[    0.135571] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    0.135960] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
[    0.158006] 00:04: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
[    0.159500] Non-volatile memory driver v1.3
[    0.159943] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
[    0.160516] ACPI: Power Button [PWRF]
[    0.161415] ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
[    0.163034] ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 10
[    0.164072] loop: module loaded
[    0.164501] virtio-pci 0000:00:04.0: irq 24 for MSI/MSI-X
[    0.164518] virtio-pci 0000:00:04.0: irq 25 for MSI/MSI-X
[    0.255068]  vda: vda1 vda2
[    0.257903] ata_piix 0000:00:01.1: version 2.13
[    0.258436] scsi host0: ata_piix
[    0.258907] scsi host1: ata_piix
[    0.259289] ata1: PATA max MWDMA2 cmd 0x1f0 ctl 0x3f6 bmdma 0xc0a0 irq 14
[    0.259655] ata2: PATA max MWDMA2 cmd 0x170 ctl 0x376 bmdma 0xc0a8 irq 15
[    0.260360] virtio-pci 0000:00:03.0: irq 26 for MSI/MSI-X
[    0.260377] virtio-pci 0000:00:03.0: irq 27 for MSI/MSI-X
[    0.260394] virtio-pci 0000:00:03.0: irq 28 for MSI/MSI-X
[    0.402360] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.402738] ehci-pci: EHCI PCI platform driver
[    0.403096] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.403457] ohci-pci: OHCI PCI platform driver
[    0.403791] uhci_hcd: USB Universal Host Controller Interface driver
[    0.404425] uhci_hcd 0000:00:01.2: UHCI Host Controller
[    0.404797] uhci_hcd 0000:00:01.2: new USB bus registered, assigned bus number 1
[    0.405484] uhci_hcd 0000:00:01.2: irq 11, io base 0x0000c040
[    0.405949] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    0.406573] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.407128] usb usb1: Product: UHCI Host Controller
[    0.407611] usb usb1: Manufacturer: Linux 3.17.4-gentoo uhci_hcd
[    0.407956] usb usb1: SerialNumber: 0000:00:01.2
[    0.408403] hub 1-0:1.0: USB hub found
[    0.408757] hub 1-0:1.0: 2 ports detected
[    0.409247] usbcore: registered new interface driver usblp
[    0.409619] usbcore: registered new interface driver usb-storage
[    0.410073] i8042: PNP: PS/2 Controller [PNP0303:KBD,PNP0f13:MOU] at 0x60,0x64 irq 1,12
[    0.411285] serio: i8042 KBD port at 0x60,0x64 irq 1
[    0.411619] serio: i8042 AUX port at 0x60,0x64 irq 12
[    0.412258] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input1
[    0.413051] rtc_cmos 00:00: RTC can wake from S4
[    0.413800] rtc_cmos 00:00: rtc core: registered rtc_cmos as rtc0
[    0.414522] rtc_cmos 00:00: alarms up to one day, 114 bytes nvram, hpet irqs
[    0.415079] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel@redhat.com
[    0.415743] hidraw: raw HID events driver (C) Jiri Kosina
[    0.416352] usbcore: registered new interface driver usbhid
[    0.416697] usbhid: USB HID core driver
[    0.417068] Netfilter messages via NETLINK v0.30.
[    0.417424] nf_conntrack version 0.5.0 (3413 buckets, 13652 max)
[    0.417868] ctnetlink v0.93: registering with nfnetlink.
[    0.418463] ip_tables: (C) 2000-2006 Netfilter Core Team
[    0.418827] TCP: cubic registered
[    0.419183] Initializing XFRM netlink socket
[    0.419646] NET: Registered protocol family 10
[    0.420324] ip6_tables: (C) 2000-2006 Netfilter Core Team
[    0.420729] sit: IPv6 over IPv4 tunneling driver
[    0.421209] NET: Registered protocol family 17
[    0.421558] 9pnet: Installing 9P2000 support
[    0.422034] Key type dns_resolver registered
[    0.422769] Loading compiled-in X.509 certificates
[    0.423175] registered taskstats version 1
[    0.423796]   Magic number: 6:269:202
[    0.424166] console [netcon0] enabled
[    0.424484] netconsole: network logging started
[    0.424870] PM: Hibernation image not present or could not be loaded.
[    0.477633] ata2.01: NODEV after polling detection
[    0.477972] ata2.00: ATAPI: QEMU DVD-ROM, 1.1.2, max UDMA/100
[    0.478779] ata2.00: configured for MWDMA2
[    0.479570] scsi 1:0:0:0: CD-ROM            QEMU     QEMU DVD-ROM     1.1. PQ: 0 ANSI: 5
[    0.490505] sr 1:0:0:0: [sr0] scsi3-mmc drive: 4x/4x cd/rw xa/form2 tray
[    0.490945] cdrom: Uniform CD-ROM driver Revision: 3.20
[    0.491432] sr 1:0:0:0: Attached scsi CD-ROM sr0
[    0.491601] sr 1:0:0:0: Attached scsi generic sg0 type 5
[    0.492054] md: Skipping autodetection of RAID arrays. (raid=autodetect will force)
[    0.520309] kjournald starting.  Commit interval 5 seconds
[    0.520713] EXT3-fs (vda1): mounted filesystem with ordered data mode
[    0.521165] VFS: Mounted root (ext3 filesystem) readonly on device 253:1.
[    0.556330] devtmpfs: mounted
[    0.558069] Freeing unused kernel memory: 1060K (ffffffff81ac3000 - ffffffff81bcc000)
[    0.558652] Write protecting the kernel read-only data: 10240k
[    0.564831] Freeing unused kernel memory: 1896K (ffff880001626000 - ffff880001800000)
[    0.565849] Freeing unused kernel memory: 56K (ffff8800019f2000 - ffff880001a00000)
[    0.711060] usb 1-1: new full-speed USB device number 2 using uhci_hcd
[    1.010042] usb 1-1: New USB device found, idVendor=0627, idProduct=0001
[    1.010780] usb 1-1: New USB device strings: Mfr=1, Product=3, SerialNumber=5
[    1.011631] usb 1-1: Product: QEMU USB Tablet
[    1.012384] usb 1-1: Manufacturer: QEMU 1.1.2
[    1.013057] usb 1-1: SerialNumber: 42
[    1.030995] input: QEMU 1.1.2 QEMU USB Tablet as /devices/pci0000:00/0000:00:01.2/usb1/1-1/1-1:1.0/0003:0627:0001.0001/input/input3
[    1.032364] hid-generic 0003:0627:0001.0001: input,hidraw0: USB HID v0.01 Pointer [QEMU 1.1.2 QEMU USB Tablet] on usb-0000:00:01.2-1/input0
[    1.128178] tsc: Refined TSC clocksource calibration: 2593.619 MHz
[    2.706793] init-early.sh (724) used greatest stack depth: 11992 bytes left
[    7.610322] systemd-udevd[898]: starting version 216
[    7.797686] random: systemd-udevd urandom read with 12 bits of entropy available
[    8.563683] mousedev: PS/2 mouse device common for all mice
[    8.706094] Linux agpgart interface v0.103
[    8.999343] SSE version of gcm_enc/dec engaged.
[    9.166104] input: ImExPS/2 Generic Explorer Mouse as /devices/platform/i8042/serio1/input/input4
[    9.989747] EXT3-fs (vda1): using internal journal
[   10.322662] Adding 1571836k swap on /dev/vda2.  Priority:-1 extents:1 across:1571836k 
[   23.164785] device eth0 entered promiscuous mode
[   76.190862] random: nonblocking pool is initialized
[  159.064477] tun: Universal TUN/TAP device driver, 1.6
[  159.064480] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[  159.460039] batman_adv: B.A.T.M.A.N. advanced 2014.4.0 (compatibility version 15) loaded
[  159.645923] batman_adv: bat0: Adding interface: fastd0
[  159.645927] batman_adv: bat0: The MTU of interface fastd0 is too small (1426) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
[  159.645935] batman_adv: bat0: Interface activated: fastd0
[  159.647721] batman_adv: bat0: orig_interval: Changing from: 1000 to: 5000
[  159.650350] batman_adv: bat0: bridge_loop_avoidance: Changing from: disabled to: enabled
[  159.651759] batman_adv: bat0: Changing gw mode from: off to: client
[  171.620775] ipip: IPv4 over IPv4 tunneling driver
[  400.876311] batman_adv: bat0: Changing gw mode from: client to: server
[  400.876333] batman_adv: bat0: Changing gateway bandwidth from: '10.0/2.0 MBit' to: '100.0/100.0 MBit'
[  421.579054] nf_conntrack: automatic helper assignment is deprecated and it will be removed soon. Use the iptables CT target to attach helpers instead.
[37229.508613] skbuff: skb_over_panic: text:ffffffffa00a8e52 len:1437 put:1380 head:ffff880014278000 data:ffff880014278062 tail:0x5ff end:0x2c0 dev:fastd0
[37229.508950] ------------[ cut here ]------------
[37229.509070] kernel BUG at net/core/skbuff.c:100!
[37229.509198] invalid opcode: 0000 [#1] SMP 
[37229.509310] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipip batman_adv libcrc32c tun crc32c_intel aesni_intel aes_x86_64 intel_agp intel_gtt glue_helper lrw gf128mul agpgart ablk_helper cryptd mousedev psmouse evdev
[37229.509553] CPU: 0 PID: 1871 Comm: fastd Not tainted 3.17.4-gentoo #1
[37229.509553] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[37229.509553] task: ffff88001a3fa340 ti: ffff8800193c8000 task.ti: ffff8800193c8000
[37229.509553] RIP: 0010:[<ffffffff81618ba3>]  [<ffffffff81618ba3>] skb_panic+0x5e/0x60
[37229.509553] RSP: 0018:ffff88001fc03cf8  EFLAGS: 00010296
[37229.509553] RAX: 000000000000008b RBX: ffff88001a2af500 RCX: 0000000000000092
[37229.509553] RDX: 0000000000000070 RSI: 0000000000000246 RDI: 0000000000000246
[37229.509553] RBP: ffff88001fc03d18 R08: 0000000000000000 R09: 0000000000000000
[37229.509553] R10: ffffffff8184ad60 R11: 0000000000000000 R12: 0000000000000564
[37229.509553] R13: ffff88001fc03da0 R14: ffff88001a21f000 R15: ffff880013ab5062
[37229.509553] FS:  00007f2476262700(0000) GS:ffff88001fc00000(0000) knlGS:0000000000000000
[37229.509553] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[37229.509553] CR2: 00007f712f5da5c3 CR3: 0000000019f14000 CR4: 00000000000006f0
[37229.509553] Stack:
[37229.509553]  ffff880014278062 00000000000005ff 00000000000002c0 ffff88001a1f8000
[37229.509553]  ffff88001fc03d28 ffffffff81464321 ffff88001fc03d88 ffffffffa00a8e52
[37229.509553]  ffff880013ab504e de0c880019ced900 000077ff80000000 ffff88001a2af500
[37229.509553] Call Trace:
[37229.509553]  <IRQ> 
[37229.509553] 
[37229.509553]  [<ffffffff81464321>] skb_put+0x41/0x50
[37229.509553]  [<ffffffffa00a8e52>] batadv_frag_skb_buffer+0x292/0x490 [batman_adv]
[37229.509553]  [<ffffffffa00b32a3>] batadv_recv_frag_packet+0x183/0x200 [batman_adv]
[37229.509553]  [<ffffffffa00acf35>] batadv_batman_skb_recv+0xd5/0x110 [batman_adv]
[37229.509553]  [<ffffffff81474152>] __netif_receive_skb_core+0x222/0x740
[37229.509553]  [<ffffffff81474691>] __netif_receive_skb+0x21/0x70
[37229.509553]  [<ffffffff8147477e>] process_backlog+0x9e/0x170
[37229.509553]  [<ffffffff81474f31>] net_rx_action+0x141/0x240
[37229.509553]  [<ffffffff81052e28>] __do_softirq+0xe8/0x280
[37229.509553]  [<ffffffff8162029c>] do_softirq_own_stack+0x1c/0x30
[37229.509553]  <EOI> 
[37229.509553] 
[37229.509553]  [<ffffffff81053065>] do_softirq+0x55/0x60
[37229.509553]  [<ffffffff814736a4>] netif_rx_ni+0x34/0x70
[37229.509553]  [<ffffffffa00968f3>] tun_get_user+0x413/0x840 [tun]
[37229.509553]  [<ffffffffa0096e1b>] tun_chr_aio_write+0x7b/0xa0 [tun]
[37229.509553]  [<ffffffff811611a5>] do_sync_write+0x55/0x90
[37229.509553]  [<ffffffff81161eca>] vfs_write+0xba/0x1f0
[37229.509553]  [<ffffffff811623da>] SyS_write+0x4a/0xa0
[37229.509553]  [<ffffffff8161e769>] system_call_fastpath+0x16/0x1b
[37229.509553] Code: 00 00 48 89 44 24 10 8b 87 c0 00 00 00 48 89 44 24 08 48 8b 87 d0 00 00 00 48 c7 c7 40 e8 99 81 48 89 04 24 31 c0 e8 5f b3 ff ff <0f> 0b 55 48 89 f8 48 8b 57 30 48 89 e5 48 8b 0f 5d 80 e5 80 48 
[37229.509553] RIP  [<ffffffff81618ba3>] skb_panic+0x5e/0x60
[37229.509553]  RSP <ffff88001fc03cf8>
crash> 

