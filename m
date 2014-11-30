Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1417377875.8367.65.camel@katze>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sun, 30 Nov 2014 21:04:35 +0100
In-Reply-To: <1417371082.8367.44.camel@katze>
References: <1416938767-29156-1-git-send-email-sven@narfation.org>
 <5474CCF8.9030008@hundeboll.net> <1417343787.5442.20.camel@katze>
 <1417346458.6337.9.camel@katze> <547B0D0D.200@hundeboll.net>
 <1417354504.8367.14.camel@katze> <547B1E34.3020207@hundeboll.net>
 <1417356477.8367.20.camel@katze> <1417367062.8367.33.camel@katze>
 <1417371082.8367.44.camel@katze>
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
To: b.a.t.m.a.n@lists.open-mesh.org

Hi Martin, hi Sven, hi all

this is my last report for now. I disable the gw mode and with that I
disable the gateway for my community until you find the cure for this
bug or a solution that prevents the VM from crash.

I'm waiting for some patches to test and glad to help you making
Batman-adv better.

Best regards, good luck and happy hacking

Philipp

________________________
Freifunk Rheinland e. V.
– Funkzelle Wuppertal –


# crash 1
 batadv_frag_merge_packets: i: 1, size: 1380, entry->seqno: 6144, entry->size: 6638, entry->total_size: 34816
   skb->len: 84, skb->tailroom: 522, pkt->pkt_type: 64, pkt->version: 15, pkt->no: 0, pkt->seqno: 53427, pkt->total_size: 16338
   skb->len: 1400, skb->tailroom: 250, pkt->pkt_type: 65, pkt->version: 15, pkt->no: 0, pkt->seqno: 56866, pkt->total_size: 1464

# crash 2
 batadv_frag_merge_packets: i: 1, size: 1380, entry->seqno: 16640, entry->size: 3512, entry->total_size: 34816
   skb->len: 84, skb->tailroom: 522, pkt->pkt_type: 64, pkt->version: 15, pkt->no: 0, pkt->seqno: 33848, pkt->total_size: 14578
   skb->len: 1400, skb->tailroom: 250, pkt->pkt_type: 65, pkt->version: 15, pkt->no: 0, pkt->seqno: 56874, pkt->total_size: 1464
 batadv_frag_merge_packets: i: 1, size: 1380, entry->seqno: 16384, entry->size: 3512, entry->total_size: 34816
   skb->len: 84, skb->tailroom: 522, pkt->pkt_type: 64, pkt->version: 15, pkt->no: 0, pkt->seqno: 33848, pkt->total_size: 14578
   skb->len: 1400, skb->tailroom: 250, pkt->pkt_type: 65, pkt->version: 15, pkt->no: 0, pkt->seqno: 56875, pkt->total_size: 1464

# crash 3
 batadv_frag_merge_packets: i: 1, size: 1380, entry->seqno: 47872, entry->size: 5511, entry->total_size: 34816
   skb->len: 84, skb->tailroom: 522, pkt->pkt_type: 64, pkt->version: 15, pkt->no: 0, pkt->seqno: 8302, pkt->total_size: 39971
   skb->len: 1400, skb->tailroom: 250, pkt->pkt_type: 65, pkt->version: 15, pkt->no: 0, pkt->seqno: 56880, pkt->total_size: 1464

# crash 4 (this crash)
 batadv_frag_merge_packets: i: 1, size: 1380, entry->seqno: 29440, entry->size: 6664, entry->total_size: 34816
   skb->len: 84, skb->tailroom: 522, pkt->pkt_type: 64, pkt->version: 15, pkt->no: 0, pkt->seqno: 53427, pkt->total_size: 16338
   skb->len: 1400, skb->tailroom: 250, pkt->pkt_type: 65, pkt->version: 15, pkt->no: 0, pkt->seqno: 56883, pkt->total_size: 1464


      KERNEL: /usr/src/linux-3.17.4-gentoo/vmlinux
    DUMPFILE: vmcore_20141130204653
        CPUS: 1
        DATE: Thu Jan  1 01:00:00 1970
      UPTIME: 01:06:18
LOAD AVERAGE: 0.27, 0.37, 0.35
       TASKS: 146
    NODENAME: wolke
     RELEASE: 3.17.4-gentoo
     VERSION: #1 SMP Tue Nov 25 12:37:10 CET 2014
     MACHINE: x86_64  (2593 Mhz)
      MEMORY: 511.6 MB
       PANIC: "Oops: 0002 [#1] SMP " (check log for details)
         PID: 0
     COMMAND: "swapper/0"
        TASK: ffffffff81a19480  [THREAD_INFO: ffffffff81a00000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 0      TASK: ffffffff81a19480  CPU: 0   COMMAND: "swapper/0"
 #0 [ffff88001fc03900] machine_kexec at ffffffff8103ab9e
 #1 [ffff88001fc03960] crash_kexec at ffffffff810bfa23
 #2 [ffff88001fc03a30] oops_end at ffffffff810060f8
 #3 [ffff88001fc03a60] no_context at ffffffff816133d9
 #4 [ffff88001fc03ac0] __bad_area_nosemaphore at ffffffff816135d2
 #5 [ffff88001fc03b10] bad_area_nosemaphore at ffffffff816135ff
 #6 [ffff88001fc03b20] __do_page_fault at ffffffff8104394e
 #7 [ffff88001fc03c30] trace_do_page_fault at ffffffff81043dc9
 #8 [ffff88001fc03c60] do_async_page_fault at ffffffff8103f2d0
 #9 [ffff88001fc03c80] async_page_fault at ffffffff81620418
    [exception RIP: __ipv6_get_lladdr+51]
    RIP: ffffffff81538603  RSP: ffff88001fc03d38  RFLAGS: 00010282
    RAX: 0000000000000000  RBX: ffff88001a249c00  RCX: ffffffffffffff20
    RDX: 0000000000000040  RSI: ffff88001fc03db8  RDI: ffff88001a249c08
    RBP: ffff88001fc03d38   R8: ffff880019ce1600   R9: 0000000000000010
    R10: ffff88000789c200  R11: 0000000000000004  R12: ffff88001a249d48
    R13: ffff88001fc03db8  R14: 0000000000000040  R15: ffff880019ce1600
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
#10 [ffff88001fc03d40] ipv6_get_lladdr at ffffffff81538687
#11 [ffff88001fc03d70] igmp6_send at ffffffff81552b62
#12 [ffff88001fc03e40] igmp6_timer_handler at ffffffff815532c4
#13 [ffff88001fc03e60] call_timer_fn at ffffffff810a06aa
#14 [ffff88001fc03ea0] run_timer_softirq at ffffffff810a1f06
#15 [ffff88001fc03f20] __do_softirq at ffffffff81052e28
#16 [ffff88001fc03f80] irq_exit at ffffffff81053205
#17 [ffff88001fc03f90] smp_apic_timer_interrupt at ffffffff810353a5
#18 [ffff88001fc03fb0] apic_timer_interrupt at ffffffff8161f5dd
--- <IRQ stack> ---
#19 [ffffffff81a03dc8] apic_timer_interrupt at ffffffff8161f5dd
    [exception RIP: native_safe_halt+6]
    RIP: ffffffff8103fb16  RSP: ffffffff81a03e78  RFLAGS: 00000246
    RAX: 0000000000000000  RBX: ffffffff81078438  RCX: 0000000000000000
    RDX: 00000000ffffffed  RSI: 0000000000000000  RDI: 0000000000000000
    RBP: ffffffff81a03e78   R8: 0000000000000000   R9: 0000000000000000
    R10: 0000000000000001  R11: 0000000000000000  R12: 0000000000000000
    R13: 00000000000134c0  R14: ffff88001fc134c0  R15: 00000000002cfe32
    ORIG_RAX: ffffffffffffff10  CS: 0010  SS: 0018
#20 [ffffffff81a03e80] default_idle at ffffffff8100c6ef
#21 [ffffffff81a03ea0] arch_cpu_idle at ffffffff8100cf9a
#22 [ffffffff81a03eb0] cpu_startup_entry at ffffffff81084614
#23 [ffffffff81a03f10] rest_init at ffffffff81610332
#24 [ffffffff81a03f20] start_kernel at ffffffff81ad8062
#25 [ffffffff81a03f70] x86_64_start_reservations at ffffffff81ad75cc
#26 [ffffffff81a03f80] x86_64_start_kernel at ffffffff81ad7714
crash> log
[…]
[  116.526414] tun: Universal TUN/TAP device driver, 1.6
[  116.526418] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[  117.741001] batman_adv: B.A.T.M.A.N. advanced 2014.3.0-44-g650251a-dirty (compatibility version 15) loaded
[  117.972571] batman_adv: bat0: Adding interface: fastd0
[  117.972575] batman_adv: bat0: The MTU of interface fastd0 is too small (1426) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1532 would solve the problem.
[  117.972585] batman_adv: bat0: Interface activated: fastd0
[  117.980597] batman_adv: bat0: orig_interval: Changing from: 1000 to: 5000
[  117.987731] batman_adv: bat0: bridge_loop_avoidance: Changing from: disabled to: enabled
[  117.992837] batman_adv: bat0: Changing gw mode from: off to: client
[  119.746177] ipip: IPv4 over IPv4 tunneling driver
[  125.701698] device eth0 entered promiscuous mode
[  394.683027] nf_conntrack: automatic helper assignment is deprecated and it will be removed soon. Use the iptables CT target to attach helpers instead.
[ 1124.325800] batman_adv: bat0: Changing gw mode from: client to: server
[ 1124.325820] batman_adv: bat0: Changing gateway bandwidth from: '10.0/2.0 MBit' to: '90.0/90.0 MBit'
[ 1370.029803] UDP: bad checksum. From _._._._:33784 to _._._._:1024 ulen 1392
[ 1370.029816] UDP: bad checksum. From _._._._:33784 to _._._._:1024 ulen 1392
[ 1370.029830] UDP: bad checksum. From _._._._:33784 to _._._._:1024 ulen 1392
[ 1373.090107] UDP: bad checksum. From _._._._:33784 to _._._._:1024 ulen 1392
[ 1379.088082] UDP: bad checksum. From _._._._:33784 to _._._._:1024 ulen 1392
[ 1391.091942] UDP: bad checksum. From _._._._:33784 to _._._._:1024 ulen 1392
[ 1414.590995] UDP: bad checksum. From _._._._:33784 to _._._._:1024 ulen 1392
[ 3972.942228] batadv_frag_merge_packets: i: 1, size: 1380, entry->seqno: 29440, entry->size: 6664, entry->total_size: 34816
[ 3972.942233]   skb->len: 84, skb->tailroom: 522, pkt->pkt_type: 64, pkt->version: 15, pkt->no: 0, pkt->seqno: 53427, pkt->total_size: 16338
[ 3972.942234]   skb->len: 1400, skb->tailroom: 250, pkt->pkt_type: 65, pkt->version: 15, pkt->no: 0, pkt->seqno: 56883, pkt->total_size: 1464
[ 3973.803619] BUG: unable to handle kernel NULL pointer dereference at           (null)
[ 3973.803853] IP: [<ffffffff8146ae3b>] __skb_recv_datagram+0x39b/0x4f0
[ 3973.804009] PGD 19e8b067 PUD 19e8c067 PMD 0 
[ 3973.804009] Oops: 0002 [#1] SMP 
[ 3973.804009] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipip batman_adv(O) libcrc32c tun crc32c_intel aesni_intel aes_x86_64 glue_helper intel_agp lrw gf128mul intel_gtt agpgart ablk_helper psmouse cryptd mousedev evdev
[ 3973.804009] CPU: 0 PID: 1817 Comm: fastd Tainted: G           O   3.17.4-gentoo #1
[ 3973.804009] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[ 3973.804009] task: ffff880019cc69c0 ti: ffff880019e9c000 task.ti: ffff880019e9c000
[ 3973.804009] RIP: 0010:[<ffffffff8146ae3b>]  [<ffffffff8146ae3b>] __skb_recv_datagram+0x39b/0x4f0
[ 3973.804009] RSP: 0018:ffff880019e9fad8  EFLAGS: 00010046
[ 3973.804009] RAX: 0000000000000282 RBX: ffff88001a087600 RCX: ffff880019d30810
[ 3973.804009] RDX: 0000000000000000 RSI: 0000000000000040 RDI: ffff880019d30824
[ 3973.804009] RBP: ffff880019e9fb98 R08: ffff880019e9fbf4 R09: 0000000000000000
[ 3973.804009] R10: 0000000000000000 R11: ffff880019cc69c0 R12: 0000000000000000
[ 3973.804009] R13: ffff880019d30780 R14: ffff880019d30810 R15: ffff880019e9fbec
[ 3973.804009] FS:  00007f2dc291e700(0000) GS:ffff88001fc00000(0000) knlGS:0000000000000000
[ 3973.804009] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3973.804009] CR2: 0000000000000000 CR3: 0000000019e8a000 CR4: 00000000000006f0
[ 3973.804009] Stack:
[ 3973.804009]  ffff880019e9fc18 ffffffff814ec033 ffff880019e9fb68 ffff880019e9fb60
[ 3973.804009]  ffff880019cc69c0 ffff880019e9ffd8 0000000000000000 ffff880019e9fbf4
[ 3973.804009]  ffff880019e9fb58 ffff880019e9fbf0 ffff880019d30824 0000004000000040
[ 3973.804009] Call Trace:
[ 3973.804009]  [<ffffffff814ec033>] ? udp_sendmsg+0x2d3/0x990
[ 3973.804009]  [<ffffffff814ecb89>] udp_recvmsg+0x149/0x440
[ 3973.804009]  [<ffffffff814f8126>] inet_recvmsg+0x66/0x80
[ 3973.804009]  [<ffffffff8145c2a8>] sock_recvmsg+0xa8/0xe0
[ 3973.804009]  [<ffffffff814ed0cf>] ? udp_poll+0x1f/0xa0
[ 3973.804009]  [<ffffffff8145ae5d>] ___sys_recvmsg+0x10d/0x2a0
[ 3973.804009]  [<ffffffff811a0eef>] ? ep_send_events_proc+0x9f/0x1b0
[ 3973.804009]  [<ffffffff811a0b19>] ? ep_scan_ready_list.isra.11+0x199/0x1c0
[ 3973.804009]  [<ffffffff811a0c36>] ? ep_poll+0xd6/0x2f0
[ 3973.804009]  [<ffffffff8107f0f3>] ? pick_next_task_fair+0x443/0x450
[ 3973.804009]  [<ffffffff81059bfa>] ? recalc_sigpending+0x1a/0x60
[ 3973.804009]  [<ffffffff8105a842>] ? __set_task_blocked+0x32/0x80
[ 3973.804009]  [<ffffffff8145d4c4>] __sys_recvmsg+0x44/0x80
[ 3973.804009]  [<ffffffff8145d50d>] SyS_recvmsg+0xd/0x20
[ 3973.804009]  [<ffffffff8161e769>] system_call_fastpath+0x16/0x1b
[ 3973.804009] Code: 9c 8c c1 ff e9 17 fd ff ff 41 83 ad a0 00 00 00 01 48 8b 0b 48 8b 53 08 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 89 51 08 <48> 89 0a e9 54 fd ff ff 41 f6 85 40 01 00 00 01 0f 85 9c 00 00 
[ 3973.804009] RIP  [<ffffffff8146ae3b>] __skb_recv_datagram+0x39b/0x4f0
[ 3973.804009]  RSP <ffff880019e9fad8>
[ 3973.804009] CR2: 0000000000000000
[ 3973.804009] ---[ end trace 77da04fc409d90f5 ]---
[ 3973.817696] batman_adv: bat0: Interface deactivated: fastd0
[ 3973.818280] batman_adv: bat0: Removing interface: fastd0
[ 3977.248946] BUG: unable to handle kernel NULL pointer dereference at           (null)
[ 3977.249013] IP: [<ffffffff8121ad30>] file_has_perm+0x40/0xa0
[ 3977.249013] PGD 0 
[ 3977.249013] Oops: 0000 [#2] SMP 
[ 3977.249013] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipip batman_adv(O) libcrc32c tun crc32c_intel aesni_intel aes_x86_64 glue_helper intel_agp lrw gf128mul intel_gtt agpgart ablk_helper psmouse cryptd mousedev evdev
[ 3977.249013] CPU: 0 PID: 3737 Comm: sudo Tainted: G      D    O   3.17.4-gentoo #1
[ 3977.249013] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[ 3977.249013] task: ffff880016083db0 ti: ffff88001a238000 task.ti: ffff88001a238000
[ 3977.249013] RIP: 0010:[<ffffffff8121ad30>]  [<ffffffff8121ad30>] file_has_perm+0x40/0xa0
[ 3977.249013] RSP: 0018:ffff88001a23beb8  EFLAGS: 00010286
[ 3977.249013] RAX: ffff880019c7a160 RBX: ffff880007840a80 RCX: 0000000000000000
[ 3977.249013] RDX: 0000000000000000 RSI: ffff880019cd1b00 RDI: 0000000000000001
[ 3977.249013] RBP: ffff88001a23bef8 R08: ffff880019cd1b00 R09: 00007fffdde64f40
[ 3977.249013] R10: 00007fffdde64e00 R11: 0000000000000297 R12: 0000000000000000
[ 3977.249013] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
[ 3977.249013] FS:  00007f6c1113b700(0000) GS:ffff88001fc00000(0000) knlGS:0000000000000000
[ 3977.249013] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 3977.249013] CR2: 0000000000000000 CR3: 0000000016127000 CR4: 00000000000006f0
[ 3977.249013] Stack:
[ 3977.249013]  0000000000000001 ffff88001a2a2b00 0000000000000000 ffffffff8105a842
[ 3977.249013]  0000000000000006 ffff880019cd1b00 ffff880019cd1b00 0000000000000003
[ 3977.249013]  ffff88001a23bf08 ffffffff8121ae2b ffff88001a23bf18 ffffffff81216981
[ 3977.249013] Call Trace:
[ 3977.249013]  [<ffffffff8105a842>] ? __set_task_blocked+0x32/0x80
[ 3977.249013]  [<ffffffff8121ae2b>] selinux_file_fcntl+0x3b/0x80
[ 3977.249013]  [<ffffffff81216981>] security_file_fcntl+0x11/0x20
[ 3977.249013]  [<ffffffff81172974>] SyS_fcntl+0x54/0x5d0
[ 3977.249013]  [<ffffffff8161e769>] system_call_fastpath+0x16/0x1b
[ 3977.249013] Code: 6d f8 48 8b 4e 10 41 89 d4 48 8b 47 70 48 8b 96 c8 00 00 00 4c 8b 6e 20 c6 45 c0 01 8b 78 04 48 89 4d c8 48 8b 4e 18 48 89 4d d0 <8b> 32 39 fe 74 17 4c 8d 45 c0 b9 01 00 00 00 ba 08 00 00 00 e8 
[ 3977.249013] RIP  [<ffffffff8121ad30>] file_has_perm+0x40/0xa0
[ 3977.249013]  RSP <ffff88001a23beb8>
[ 3977.249013] CR2: 0000000000000000
[ 3977.270130] ---[ end trace 77da04fc409d90f6 ]---
[ 3977.270576] VFS: Close: file count is 0
[ 3977.535388] VFS: Close: file count is 0
[ 3977.719221] VFS: Close: file count is 0
[ 3977.719595] VFS: Close: file count is 0
[ 3977.719911] VFS: Close: file count is 0
[ 3978.995070] BUG: unable to handle kernel paging request at ffffffffffffff4e
[ 3978.996026] IP: [<ffffffff81538603>] __ipv6_get_lladdr+0x33/0x70
[ 3978.996026] PGD 1a15067 PUD 1a17067 PMD 0 
[ 3978.996026] Oops: 0000 [#3] SMP 
[ 3978.996026] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipip batman_adv(O) libcrc32c tun crc32c_intel aesni_intel aes_x86_64 glue_helper intel_agp lrw gf128mul intel_gtt agpgart ablk_helper psmouse cryptd mousedev evdev
[ 3978.996026] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D    O   3.17.4-gentoo #1
[ 3978.996026] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[ 3978.996026] task: ffffffff81a19480 ti: ffffffff81a00000 task.ti: ffffffff81a00000
[ 3978.996026] RIP: 0010:[<ffffffff81538603>]  [<ffffffff81538603>] __ipv6_get_lladdr+0x33/0x70
[ 3978.996026] RSP: 0018:ffff88001fc03d38  EFLAGS: 00010282
[ 3978.996026] RAX: 0000000000000000 RBX: ffff88001a249c00 RCX: ffffffffffffff20
[ 3978.996026] RDX: 0000000000000040 RSI: ffff88001fc03db8 RDI: ffff88001a249c08
[ 3978.996026] RBP: ffff88001fc03d38 R08: ffff880019ce1600 R09: 0000000000000010
[ 3978.996026] R10: ffff88000789c200 R11: 0000000000000004 R12: ffff88001a249d48
[ 3978.996026] R13: ffff88001fc03db8 R14: 0000000000000040 R15: ffff880019ce1600
[ 3978.996026] FS:  0000000000000000(0000) GS:ffff88001fc00000(0000) knlGS:0000000000000000
[ 3978.996026] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 3978.996026] CR2: ffffffffffffff4e CR3: 0000000019c4d000 CR4: 00000000000006f0
[ 3978.996026] Stack:
[ 3978.996026]  ffff88001fc03d68 ffffffff81538687 ffff8800156b6100 ffff88001f26e000
[ 3978.996026]  ffff880019cf3740 ffffffff81a88080 ffff88001fc03e38 ffffffff81552b62
[ 3978.996026]  ffff88001fc03da8 ffffffff81078145 ffff88001fc03d98 ffff880019ce1600
[ 3978.996026] Call Trace:
[ 3978.996026]  <IRQ> 
[ 3978.996026] 
[ 3978.996026]  [<ffffffff81538687>] ipv6_get_lladdr+0x47/0x70
[ 3978.996026]  [<ffffffff81552b62>] igmp6_send+0x112/0x420
[ 3978.996026]  [<ffffffff81078145>] ? sched_clock_local+0x25/0xa0
[ 3978.996026]  [<ffffffff81077bc0>] ? __update_cpu_load+0xc0/0x110
[ 3978.996026]  [<ffffffff81553250>] ? igmp6_group_added+0x1c0/0x1c0
[ 3978.996026]  [<ffffffff815532c4>] igmp6_timer_handler+0x74/0x80
[ 3978.996026]  [<ffffffff810a06aa>] call_timer_fn+0x3a/0x100
[ 3978.996026]  [<ffffffff81553250>] ? igmp6_group_added+0x1c0/0x1c0
[ 3978.996026]  [<ffffffff810a1f06>] run_timer_softirq+0x206/0x2e0
[ 3978.996026]  [<ffffffff81052e28>] __do_softirq+0xe8/0x280
[ 3978.996026]  [<ffffffff81053205>] irq_exit+0x95/0xa0
[ 3978.996026]  [<ffffffff810353a5>] smp_apic_timer_interrupt+0x45/0x60
[ 3978.996026]  [<ffffffff8161f5dd>] apic_timer_interrupt+0x6d/0x80
[ 3978.996026]  <EOI> 
[ 3978.996026] 
[ 3978.996026]  [<ffffffff81078438>] ? sched_clock_cpu+0x98/0xd0
[ 3978.996026]  [<ffffffff8103fb16>] ? native_safe_halt+0x6/0x10
[ 3978.996026]  [<ffffffff8100c6ef>] default_idle+0x1f/0xb0
[ 3978.996026]  [<ffffffff8100cf9a>] arch_cpu_idle+0xa/0x10
[ 3978.996026]  [<ffffffff81084614>] cpu_startup_entry+0x284/0x330
[ 3978.996026]  [<ffffffff81610332>] rest_init+0x72/0x80
[ 3978.996026]  [<ffffffff81ad8062>] start_kernel+0x422/0x42f
[ 3978.996026]  [<ffffffff81ad7a2d>] ? set_init_arg+0x58/0x58
[ 3978.996026]  [<ffffffff81ad7117>] ? early_idt_handlers+0x117/0x120
[ 3978.996026]  [<ffffffff81ad75cc>] x86_64_start_reservations+0x2a/0x2c
[ 3978.996026]  [<ffffffff81ad7714>] x86_64_start_kernel+0x146/0x155
[ 3978.996026] Code: 08 48 89 e5 48 39 c7 48 8d 88 20 ff ff ff 75 1b eb 46 66 0f 1f 44 00 00 48 8b 81 e8 00 00 00 48 39 c7 48 8d 88 20 ff ff ff 74 2d <0f> b7 80 4e ff ff ff 66 83 f8 20 77 20 66 83 f8 20 75 da 85 51 
[ 3978.996026] RIP  [<ffffffff81538603>] __ipv6_get_lladdr+0x33/0x70
[ 3978.996026]  RSP <ffff88001fc03d38>
[ 3978.996026] CR2: ffffffffffffff4e

