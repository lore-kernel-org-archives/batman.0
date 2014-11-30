Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1417367062.8367.33.camel@katze>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sun, 30 Nov 2014 18:04:22 +0100
In-Reply-To: <1417356477.8367.20.camel@katze>
References: <1416938767-29156-1-git-send-email-sven@narfation.org>
 <5474CCF8.9030008@hundeboll.net> <1417343787.5442.20.camel@katze>
 <1417346458.6337.9.camel@katze> <547B0D0D.200@hundeboll.net>
 <1417354504.8367.14.camel@katze> <547B1E34.3020207@hundeboll.net>
 <1417356477.8367.20.camel@katze>
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

Hi Martin, hi Sven, hi all

I couldn't help myself and started ntop after a while. Now I come to the
conclusion that ntop has nothing to do with the crash. I think the
machine simply crashes on the next task in the stack. (but really, I
don't know what I'm talking about)

I understand, that the patch is quick & dirty and can't protect the VM
from crash. But it's a big step forward identifying the cause of the bug
and that your patch provides us with some output.

Best regards an happy hacking

Philipp

________________________
Freifunk Rheinland e. V.
– Funkzelle Wuppertal –

      KERNEL: /usr/src/linux-3.17.4-gentoo/vmlinux
    DUMPFILE: vmcore_20141130174721
        CPUS: 1
        DATE: Thu Jan  1 01:00:00 1970
      UPTIME: 02:29:15
LOAD AVERAGE: 0.17, 0.17, 0.15
       TASKS: 141
    NODENAME: wolke
     RELEASE: 3.17.4-gentoo
     VERSION: #1 SMP Tue Nov 25 12:37:10 CET 2014
     MACHINE: x86_64  (2593 Mhz)
      MEMORY: 511.6 MB
       PANIC: ""
         PID: 0
     COMMAND: "swapper/0"
        TASK: ffffffff81a19480  [THREAD_INFO: ffffffff81a00000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> bt
PID: 0      TASK: ffffffff81a19480  CPU: 0   COMMAND: "swapper/0"
 #0 [ffff88001fc034e0] machine_kexec at ffffffff8103ab9e
 #1 [ffff88001fc03540] crash_kexec at ffffffff810bfa23
 #2 [ffff88001fc03610] oops_end at ffffffff810060f8
 #3 [ffff88001fc03640] die at ffffffff81006593
 #4 [ffff88001fc03670] do_general_protection at ffffffff8100341a
 #5 [ffff88001fc036a0] general_protection at ffffffff81620388
    [exception RIP: __kmalloc_node_track_caller+237]
    RIP: ffffffff8115c24d  RSP: ffff88001fc03758  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff88001a2d2c00  RCX: 0000000000391dc8
    RDX: 0000000000391dc7  RSI: 0000000000000000  RDI: 0000000000015900
    RBP: ffff88001fc03798   R8: ffff88001fc15900   R9: ffffffff81466f1b
    R10: b713fedcfcf04441  R11: ffff88001a2d2200  R12: ffff88001f001400
    R13: 0000000000000740  R14: 00000000ffffffff  R15: 0000000000010220
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #6 [ffff88001fc037a0] __kmalloc_reserve at ffffffff81464387
 #7 [ffff88001fc037f0] __alloc_skb at ffffffff81466f48
 #8 [ffff88001fc03850] skb_segment at ffffffff81467e29
 #9 [ffff88001fc03970] tcp_gso_segment at ffffffff814e7e82
#10 [ffff88001fc039e0] inet_gso_segment at ffffffff814f7d57
#11 [ffff88001fc03a50] skb_mac_gso_segment at ffffffff81475d83
#12 [ffff88001fc03a90] __skb_gso_segment at ffffffff81475ebb
#13 [ffff88001fc03ab0] dev_hard_start_xmit at ffffffff814760a3
#14 [ffff88001fc03b10] __dev_queue_xmit at ffffffff81476798
#15 [ffff88001fc03b60] dev_queue_xmit at ffffffff8147696b
#16 [ffff88001fc03b70] ip_finish_output at ffffffff814c466b
#17 [ffff88001fc03bd0] ip_output at ffffffff814c5128
#18 [ffff88001fc03c00] ip_forward_finish at ffffffff814c0d41
#19 [ffff88001fc03c20] ip_forward at ffffffff814c10fe
#20 [ffff88001fc03c60] ip_rcv_finish at ffffffff814bef2c
#21 [ffff88001fc03c90] ip_rcv at ffffffff814bf86c
#22 [ffff88001fc03cd0] __netif_receive_skb_core at ffffffff81474152
#23 [ffff88001fc03d40] __netif_receive_skb at ffffffff81474691
#24 [ffff88001fc03d60] netif_receive_skb_internal at ffffffff81474878
#25 [ffff88001fc03d90] napi_gro_complete at ffffffff814749dc
#26 [ffff88001fc03dc0] dev_gro_receive at ffffffff81474c0f
#27 [ffff88001fc03e20] napi_gro_receive at ffffffff81475224
#28 [ffff88001fc03e50] gro_cell_poll at ffffffff81507e07
#29 [ffff88001fc03ea0] net_rx_action at ffffffff81474f31
#30 [ffff88001fc03f00] __do_softirq at ffffffff81052e28
#31 [ffff88001fc03f60] irq_exit at ffffffff81053205
#32 [ffff88001fc03f70] do_IRQ at ffffffff810046f2
--- <IRQ stack> ---
#33 [ffffffff81a03de8] ret_from_intr at ffffffff8161f26d
    [exception RIP: tick_nohz_idle_exit+291]
    RIP: ffffffff810b1923  RSP: ffffffff81a03e98  RFLAGS: 00000202
    RAX: ffff88001fc0d080  RBX: ffff88001fc0d4a0  RCX: 0000000000000020
    RDX: 0000000000000000  RSI: 0000000000000086  RDI: 0000000000000008
    RBP: ffffffff81a03ea8   R8: 00000000209d3188   R9: 0000000000000001
    R10: 0000000000000005  R11: 0000000000000004  R12: ffffffff810a33d7
    R13: ffffffff81a03e78  R14: 0000000000000086  R15: ffffffff81a03df8
    ORIG_RAX: ffffffffffffff8e  CS: 0010  SS: 0018
#34 [ffffffff81a03eb0] cpu_startup_entry at ffffffff810844c7
#35 [ffffffff81a03f10] rest_init at ffffffff81610332
#36 [ffffffff81a03f20] start_kernel at ffffffff81ad8062
#37 [ffffffff81a03f70] x86_64_start_reservations at ffffffff81ad75cc
#38 [ffffffff81a03f80] x86_64_start_kernel at ffffffff81ad7714
crash> log
[…]
[    6.765959] Adding 1571836k swap on /dev/vda2.  Priority:-1 extents:1 across:1571836k 
[   13.008359] named (1695) used greatest stack depth: 11784 bytes left
[   62.407977] tun: Universal TUN/TAP device driver, 1.6
[   62.407981] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   63.275215] batman_adv: B.A.T.M.A.N. advanced 2014.3.0-44-g650251a-dirty (compatibility version 15) loaded
[   63.541480] batman_adv: bat0: Adding interface: fastd0
[   63.541484] batman_adv: bat0: The MTU of interface fastd0 is too small (1426) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1532 would solve the problem.
[   63.541493] batman_adv: bat0: Interface activated: fastd0
[   63.553877] batman_adv: bat0: orig_interval: Changing from: 1000 to: 5000
[   63.561411] batman_adv: bat0: bridge_loop_avoidance: Changing from: disabled to: enabled
[   63.566465] batman_adv: bat0: Changing gw mode from: off to: client
[   65.511629] ipip: IPv4 over IPv4 tunneling driver
[   77.521583] random: nonblocking pool is initialized
[  103.144238] batman_adv: bat0: Changing gw mode from: client to: server
[  103.144300] batman_adv: bat0: Changing gateway bandwidth from: '10.0/2.0 MBit' to: '90.0/90.0 MBit'
[  345.305038] nf_conntrack: automatic helper assignment is deprecated and it will be removed soon. Use the iptables CT target to attach helpers instead.
[ 2998.421458] device eth0 entered promiscuous mode
[ 8955.565935] batadv_frag_merge_packets: i: 1, size: 1380, entry->seqno: 16640, entry->size: 3512, entry->total_size: 34816
[ 8955.565940]   skb->len: 84, skb->tailroom: 522, pkt->pkt_type: 64, pkt->version: 15, pkt->no: 0, pkt->seqno: 33848, pkt->total_size: 14578
[ 8955.565942]   skb->len: 1400, skb->tailroom: 250, pkt->pkt_type: 65, pkt->version: 15, pkt->no: 0, pkt->seqno: 56874, pkt->total_size: 1464
[ 8955.571490] batadv_frag_merge_packets: i: 1, size: 1380, entry->seqno: 16384, entry->size: 3512, entry->total_size: 34816
[ 8955.571498]   skb->len: 84, skb->tailroom: 522, pkt->pkt_type: 64, pkt->version: 15, pkt->no: 0, pkt->seqno: 33848, pkt->total_size: 14578
[ 8955.571500]   skb->len: 1400, skb->tailroom: 250, pkt->pkt_type: 65, pkt->version: 15, pkt->no: 0, pkt->seqno: 56875, pkt->total_size: 1464
[ 8955.614084] general protection fault: 0000 [#1] SMP 
[ 8955.614225] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipip batman_adv(O) libcrc32c tun crc32c_intel aesni_intel aes_x86_64 glue_helper intel_agp lrw gf128mul intel_gtt ablk_helper agpgart cryptd psmouse mousedev evdev
[ 8955.614822] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O   3.17.4-gentoo #1
[ 8955.614919] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[ 8955.614919] task: ffffffff81a19480 ti: ffffffff81a00000 task.ti: ffffffff81a00000
[ 8955.614919] RIP: 0010:[<ffffffff8115c24d>]  [<ffffffff8115c24d>] __kmalloc_node_track_caller+0xed/0x1b0
[ 8955.614919] RSP: 0018:ffff88001fc03758  EFLAGS: 00010246
[ 8955.614919] RAX: 0000000000000000 RBX: ffff88001a2d2c00 RCX: 0000000000391dc8
[ 8955.614919] RDX: 0000000000391dc7 RSI: 0000000000000000 RDI: 0000000000015900
[ 8955.614919] RBP: ffff88001fc03798 R08: ffff88001fc15900 R09: ffffffff81466f1b
[ 8955.614919] R10: b713fedcfcf04441 R11: ffff88001a2d2200 R12: ffff88001f001400
[ 8955.614919] R13: 0000000000000740 R14: 00000000ffffffff R15: 0000000000010220
[ 8955.614919] FS:  0000000000000000(0000) GS:ffff88001fc00000(0000) knlGS:0000000000000000
[ 8955.614919] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 8955.614919] CR2: 00007ff981305000 CR3: 0000000002201000 CR4: 00000000000006f0
[ 8955.614919] Stack:
[ 8955.614919]  ffff88001fc03768 ffffffff81466f48 ffff88001fc037a8 ffff88001a2d2c00
[ 8955.614919]  ffff88001fc03817 0000000000000020 0000000000000740 00000000ffffffff
[ 8955.614919]  ffff88001fc037e8 ffffffff81464387 0000000000000000 0000000000000000
[ 8955.614919] Call Trace:
[ 8955.614919]  <IRQ> 
[ 8955.614919] 
[ 8955.614919]  [<ffffffff81466f48>] ? __alloc_skb+0x88/0x2a0
[ 8955.614919]  [<ffffffff81464387>] __kmalloc_reserve.isra.58+0x37/0xa0
[ 8955.614919]  [<ffffffff81466f48>] __alloc_skb+0x88/0x2a0
[ 8955.614919]  [<ffffffff81467e29>] skb_segment+0x4b9/0x940
[ 8955.614919]  [<ffffffffa009cfa3>] ? tun_net_xmit+0x263/0x320 [tun]
[ 8955.614919]  [<ffffffff814e7e82>] tcp_gso_segment+0x122/0x4f0
[ 8955.614919]  [<ffffffff814f7d57>] inet_gso_segment+0x137/0x390
[ 8955.614919]  [<ffffffff81475d83>] skb_mac_gso_segment+0x93/0x170
[ 8955.614919]  [<ffffffff81475ebb>] __skb_gso_segment+0x5b/0xc0
[ 8955.614919]  [<ffffffff814760a3>] dev_hard_start_xmit+0x183/0x580
[ 8955.614919]  [<ffffffff814c4000>] ? ip_finish_output2+0x300/0x300
[ 8955.614919]  [<ffffffff81476798>] __dev_queue_xmit+0x2f8/0x4b0
[ 8955.614919]  [<ffffffff8147696b>] dev_queue_xmit+0xb/0x10
[ 8955.614919]  [<ffffffff814c466b>] ip_finish_output+0x66b/0x7f0
[ 8955.614919]  [<ffffffff814c5128>] ip_output+0x88/0x90
[ 8955.614919]  [<ffffffff814c0d41>] ip_forward_finish+0x61/0x80
[ 8955.614919]  [<ffffffff814c10fe>] ip_forward+0x39e/0x430
[ 8955.614919]  [<ffffffff814bef2c>] ip_rcv_finish+0x7c/0x320
[ 8955.614919]  [<ffffffff814bf86c>] ip_rcv+0x2dc/0x3f0
[ 8955.614919]  [<ffffffff81474152>] __netif_receive_skb_core+0x222/0x740
[ 8955.614919]  [<ffffffff81474691>] __netif_receive_skb+0x21/0x70
[ 8955.614919]  [<ffffffff81474878>] netif_receive_skb_internal+0x28/0x90
[ 8955.614919]  [<ffffffff814e7cee>] ? tcp4_gro_complete+0x6e/0x70
[ 8955.614919]  [<ffffffff814749dc>] napi_gro_complete+0x9c/0xd0
[ 8955.614919]  [<ffffffff81474c0f>] dev_gro_receive+0x1ff/0x300
[ 8955.614919]  [<ffffffff81475224>] napi_gro_receive+0x34/0x100
[ 8955.614919]  [<ffffffff81507e07>] gro_cell_poll+0x77/0xb0
[ 8955.614919]  [<ffffffff81474f31>] net_rx_action+0x141/0x240
[ 8955.614919]  [<ffffffff81052e28>] __do_softirq+0xe8/0x280
[ 8955.614919]  [<ffffffff81053205>] irq_exit+0x95/0xa0
[ 8955.614919]  [<ffffffff810046f2>] do_IRQ+0x62/0x110
[ 8955.614919]  [<ffffffff8161f26d>] common_interrupt+0x6d/0x6d
[ 8955.614919]  <EOI> 
[ 8955.614919] 
[ 8955.614919]  [<ffffffff810b1923>] ? tick_nohz_idle_exit+0x123/0x1a0
[ 8955.614919]  [<ffffffff810b196d>] ? tick_nohz_idle_exit+0x16d/0x1a0
[ 8955.614919]  [<ffffffff810844c7>] cpu_startup_entry+0x137/0x330
[ 8955.614919]  [<ffffffff81610332>] rest_init+0x72/0x80
[ 8955.614919]  [<ffffffff81ad8062>] start_kernel+0x422/0x42f
[ 8955.614919]  [<ffffffff81ad7a2d>] ? set_init_arg+0x58/0x58
[ 8955.614919]  [<ffffffff81ad7117>] ? early_idt_handlers+0x117/0x120
[ 8955.614919]  [<ffffffff81ad75cc>] x86_64_start_reservations+0x2a/0x2c
[ 8955.614919]  [<ffffffff81ad7714>] x86_64_start_kernel+0x146/0x155
[ 8955.614919] Code: 00 4c 89 d0 48 8b 5d d8 4c 8b 65 e0 4c 8b 6d e8 4c 8b 75 f0 4c 8b 7d f8 c9 c3 0f 1f 40 00 49 63 44 24 20 49 8b 3c 24 48 8d 4a 01 <49> 8b 1c 02 4c 89 d0 65 48 0f c7 0f 0f 94 c0 84 c0 0f 84 56 ff 
[ 8955.614919] RIP  [<ffffffff8115c24d>] __kmalloc_node_track_caller+0xed/0x1b0
[ 8955.614919]  RSP <ffff88001fc03758>


