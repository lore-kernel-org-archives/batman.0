Return-Path: <philipp.psurek@gmail.com>
Message-ID: <1417371082.8367.44.camel@katze>
From: Philipp Psurek <philipp.psurek@gmail.com>
Date: Sun, 30 Nov 2014 19:11:22 +0100
In-Reply-To: <1417367062.8367.33.camel@katze>
References: <1416938767-29156-1-git-send-email-sven@narfation.org>
 <5474CCF8.9030008@hundeboll.net> <1417343787.5442.20.camel@katze>
 <1417346458.6337.9.camel@katze> <547B0D0D.200@hundeboll.net>
 <1417354504.8367.14.camel@katze> <547B1E34.3020207@hundeboll.net>
 <1417356477.8367.20.camel@katze> <1417367062.8367.33.camel@katze>
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

it seems that vacation is over for our “attacker”. He’ll not let me
sleep tonight …

here is the summary of last batadv_frag_merge_packets messages:

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

# crash 3 (this crash)
 batadv_frag_merge_packets: i: 1, size: 1380, entry->seqno: 47872, entry->size: 5511, entry->total_size: 34816
   skb->len: 84, skb->tailroom: 522, pkt->pkt_type: 64, pkt->version: 15, pkt->no: 0, pkt->seqno: 8302, pkt->total_size: 39971
   skb->len: 1400, skb->tailroom: 250, pkt->pkt_type: 65, pkt->version: 15, pkt->no: 0, pkt->seqno: 56880, pkt->total_size: 1464

Do you need the backtraces? ;-)

Best regards an happy hacking

Philipp

________________________
Freifunk Rheinland e. V.
– Funkzelle Wuppertal –




      KERNEL: /usr/src/linux-3.17.4-gentoo/vmlinux
    DUMPFILE: vmcore_20141130185240
        CPUS: 1
        DATE: Thu Jan  1 01:00:00 1970
      UPTIME: 00:58:42
LOAD AVERAGE: 0.19, 0.25, 0.25
       TASKS: 139
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
 #0 [ffff88001fc03790] machine_kexec at ffffffff8103ab9e
 #1 [ffff88001fc037f0] crash_kexec at ffffffff810bfa23
 #2 [ffff88001fc038c0] oops_end at ffffffff810060f8
 #3 [ffff88001fc038f0] die at ffffffff81006593
 #4 [ffff88001fc03920] do_general_protection at ffffffff8100341a
 #5 [ffff88001fc03950] general_protection at ffffffff81620388
    [exception RIP: __kmalloc_node_track_caller+237]
    RIP: ffffffff8115c24d  RSP: ffff88001fc03a08  RFLAGS: 00010246
    RAX: 0000000000000000  RBX: ffff88001587bd00  RCX: 0000000000307c82
    RDX: 0000000000307c81  RSI: 0000000000000000  RDI: 0000000000015900
    RBP: ffff88001fc03a48   R8: ffff88001fc15900   R9: ffff88000bd41000
    R10: 0a01005e00000000  R11: ffff88001950bde0  R12: ffff88001f001400
    R13: 00000000000007c0  R14: 00000000ffffffff  R15: 0000000000010220
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #6 [ffff88001fc03a50] __kmalloc_reserve at ffffffff81464387
 #7 [ffff88001fc03aa0] pskb_expand_head at ffffffff81465af7
 #8 [ffff88001fc03af0] __pskb_pull_tail at ffffffff81466207
 #9 [ffff88001fc03b40] dev_hard_start_xmit at ffffffff814762c2
#10 [ffff88001fc03ba0] __dev_queue_xmit at ffffffff81476798
#11 [ffff88001fc03bf0] dev_queue_xmit at ffffffff8147696b
#12 [ffff88001fc03c00] ip_finish_output at ffffffff814c4608
#13 [ffff88001fc03c60] ip_output at ffffffff814c5128
#14 [ffff88001fc03c90] ip_forward_finish at ffffffff814c0d41
#15 [ffff88001fc03cb0] ip_forward at ffffffff814c10fe
#16 [ffff88001fc03cf0] ip_rcv_finish at ffffffff814bef2c
#17 [ffff88001fc03d20] ip_rcv at ffffffff814bf86c
#18 [ffff88001fc03d60] __netif_receive_skb_core at ffffffff81474152
#19 [ffff88001fc03dd0] __netif_receive_skb at ffffffff81474691
#20 [ffff88001fc03df0] netif_receive_skb_internal at ffffffff81474878
#21 [ffff88001fc03e20] napi_gro_receive at ffffffff81475288
#22 [ffff88001fc03e50] gro_cell_poll at ffffffff81507e07
#23 [ffff88001fc03ea0] net_rx_action at ffffffff81474f31
#24 [ffff88001fc03f00] __do_softirq at ffffffff81052e28
#25 [ffff88001fc03f60] irq_exit at ffffffff81053205
#26 [ffff88001fc03f70] do_IRQ at ffffffff810046f2
--- <IRQ stack> ---
#27 [ffffffff81a03dc8] ret_from_intr at ffffffff8161f26d
    [exception RIP: native_safe_halt+6]
    RIP: ffffffff8103fb16  RSP: ffffffff81a03e78  RFLAGS: 00000246
    RAX: 0000000000000000  RBX: 0000000000000000  RCX: 0000000000000000
    RDX: 00000000ffffffed  RSI: 0000000000000000  RDI: 0000000000000000
    RBP: ffffffff81a03e78   R8: 0000000000000000   R9: 0000000000000000
    R10: 00000000000014e0  R11: 0000000000000293  R12: 0000000000000086
    R13: 00000000000134c0  R14: 000000000000d460  R15: 0000000000000040
    ORIG_RAX: ffffffffffffff8e  CS: 0010  SS: 0018
#28 [ffffffff81a03e80] default_idle at ffffffff8100c6ef
#29 [ffffffff81a03ea0] arch_cpu_idle at ffffffff8100cf9a
#30 [ffffffff81a03eb0] cpu_startup_entry at ffffffff81084614
#31 [ffffffff81a03f10] rest_init at ffffffff81610332
#32 [ffffffff81a03f20] start_kernel at ffffffff81ad8062
#33 [ffffffff81a03f70] x86_64_start_reservations at ffffffff81ad75cc
#34 [ffffffff81a03f80] x86_64_start_kernel at ffffffff81ad7714
crash> log
[…]
[   77.969379] tun: Universal TUN/TAP device driver, 1.6
[   77.969383] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[   78.974721] batman_adv: B.A.T.M.A.N. advanced 2014.3.0-44-g650251a-dirty (compatibility version 15) loaded
[   79.201904] batman_adv: bat0: Adding interface: fastd0
[   79.201908] batman_adv: bat0: The MTU of interface fastd0 is too small (1426) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1532 would solve the problem.
[   79.201918] batman_adv: bat0: Interface activated: fastd0
[   79.210058] batman_adv: bat0: orig_interval: Changing from: 1000 to: 5000
[   79.217144] batman_adv: bat0: bridge_loop_avoidance: Changing from: disabled to: enabled
[   79.222337] batman_adv: bat0: Changing gw mode from: off to: client
[   81.148969] ipip: IPv4 over IPv4 tunneling driver
[   85.746156] random: nonblocking pool is initialized
[  174.891042] batman_adv: bat0: Changing gw mode from: client to: server
[  174.891065] batman_adv: bat0: Changing gateway bandwidth from: '10.0/2.0 MBit' to: '90.0/90.0 MBit'
[  414.478142] crash (3158) used greatest stack depth: 11784 bytes left
[  431.791532] device eth0 entered promiscuous mode
[  564.949265] nf_conntrack: automatic helper assignment is deprecated and it will be removed soon. Use the iptables CT target to attach helpers instead.
[ 3396.272805] UDP: bad checksum. From _._._._:34798 to _._._._:1024 ulen 1393
[ 3396.276540] UDP: bad checksum. From _._._._:34798 to _._._._:1024 ulen 1393
[ 3396.293255] UDP: bad checksum. From _._._._:34798 to _._._._:1024 ulen 1393
[ 3397.525103] UDP: bad checksum. From _._._._:34798 to _._._._:1024 ulen 1393
[ 3399.559563] UDP: bad checksum. From _._._._:34798 to _._._._:1024 ulen 1393
[ 3403.646348] UDP: bad checksum. From _._._._:34798 to _._._._:1024 ulen 1393
[ 3411.810063] UDP: bad checksum. From _._._._:34798 to _._._._:1024 ulen 1393
[ 3425.410958] UDP: bad checksum. From _._._._:34798 to _._._._:1024 ulen 1393
[ 3522.462842] batadv_frag_merge_packets: i: 1, size: 1380, entry->seqno: 47872, entry->size: 5511, entry->total_size: 34816
[ 3522.462847]   skb->len: 84, skb->tailroom: 522, pkt->pkt_type: 64, pkt->version: 15, pkt->no: 0, pkt->seqno: 8302, pkt->total_size: 39971
[ 3522.462849]   skb->len: 1400, skb->tailroom: 250, pkt->pkt_type: 65, pkt->version: 15, pkt->no: 0, pkt->seqno: 56880, pkt->total_size: 1464
[ 3522.472116] general protection fault: 0000 [#1] SMP 
[ 3522.472287] Modules linked in: xt_nat iptable_nat nf_nat_ipv4 nf_nat ipip batman_adv(O) libcrc32c tun crc32c_intel aesni_intel aes_x86_64 glue_helper intel_agp lrw intel_gtt gf128mul agpgart ablk_helper psmouse cryptd evdev mousedev
[ 3522.472890] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G           O   3.17.4-gentoo #1
[ 3522.473005] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2007
[ 3522.473005] task: ffffffff81a19480 ti: ffffffff81a00000 task.ti: ffffffff81a00000
[ 3522.473005] RIP: 0010:[<ffffffff8115c24d>]  [<ffffffff8115c24d>] __kmalloc_node_track_caller+0xed/0x1b0
[ 3522.473005] RSP: 0018:ffff88001fc03a08  EFLAGS: 00010246
[ 3522.473005] RAX: 0000000000000000 RBX: ffff88001587bd00 RCX: 0000000000307c82
[ 3522.473005] RDX: 0000000000307c81 RSI: 0000000000000000 RDI: 0000000000015900
[ 3522.473005] RBP: ffff88001fc03a48 R08: ffff88001fc15900 R09: ffff88000bd41000
[ 3522.473005] R10: 0a01005e00000000 R11: ffff88001950bde0 R12: ffff88001f001400
[ 3522.473005] R13: 00000000000007c0 R14: 00000000ffffffff R15: 0000000000010220
[ 3522.473005] FS:  0000000000000000(0000) GS:ffff88001fc00000(0000) knlGS:0000000000000000
[ 3522.473005] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
[ 3522.473005] CR2: 00007f07b1ba3000 CR3: 000000001954c000 CR4: 00000000000006f0
[ 3522.473005] Stack:
[ 3522.473005]  ffff88001fc03a78 ffffffff81465af7 ffff88001fc03a48 ffff88001587bd00
[ 3522.473005]  0000000000000000 0000000000000020 00000000000007c0 00000000ffffffff
[ 3522.473005]  ffff88001fc03a98 ffffffff81464387 0000000000000000 0000000000000000
[ 3522.473005] Call Trace:
[ 3522.473005]  <IRQ> 
[ 3522.473005] 
[ 3522.473005]  [<ffffffff81465af7>] ? pskb_expand_head+0x67/0x270
[ 3522.473005]  [<ffffffff81464387>] __kmalloc_reserve.isra.58+0x37/0xa0
[ 3522.473005]  [<ffffffff81465af7>] pskb_expand_head+0x67/0x270
[ 3522.473005]  [<ffffffff81466207>] __pskb_pull_tail+0x47/0x320
[ 3522.473005]  [<ffffffff814762c2>] dev_hard_start_xmit+0x3a2/0x580
[ 3522.473005]  [<ffffffff814c4000>] ? ip_finish_output2+0x300/0x300
[ 3522.473005]  [<ffffffff81476798>] __dev_queue_xmit+0x2f8/0x4b0
[ 3522.473005]  [<ffffffff8147696b>] dev_queue_xmit+0xb/0x10
[ 3522.473005]  [<ffffffff814c4608>] ip_finish_output+0x608/0x7f0
[ 3522.473005]  [<ffffffff814c5128>] ip_output+0x88/0x90
[ 3522.473005]  [<ffffffff814c0d41>] ip_forward_finish+0x61/0x80
[ 3522.473005]  [<ffffffff814c10fe>] ip_forward+0x39e/0x430
[ 3522.473005]  [<ffffffff814bef2c>] ip_rcv_finish+0x7c/0x320
[ 3522.473005]  [<ffffffff814bf86c>] ip_rcv+0x2dc/0x3f0
[ 3522.473005]  [<ffffffff81474152>] __netif_receive_skb_core+0x222/0x740
[ 3522.473005]  [<ffffffff81474691>] __netif_receive_skb+0x21/0x70
[ 3522.473005]  [<ffffffff81474878>] netif_receive_skb_internal+0x28/0x90
[ 3522.473005]  [<ffffffff81475288>] napi_gro_receive+0x98/0x100
[ 3522.473005]  [<ffffffff81507e07>] gro_cell_poll+0x77/0xb0
[ 3522.473005]  [<ffffffff81474f31>] net_rx_action+0x141/0x240
[ 3522.473005]  [<ffffffff81052e28>] __do_softirq+0xe8/0x280
[ 3522.473005]  [<ffffffff81053205>] irq_exit+0x95/0xa0
[ 3522.473005]  [<ffffffff810046f2>] do_IRQ+0x62/0x110
[ 3522.473005]  [<ffffffff8161f26d>] common_interrupt+0x6d/0x6d
[ 3522.473005]  <EOI> 
[ 3522.473005] 
[ 3522.473005]  [<ffffffff8103fb16>] ? native_safe_halt+0x6/0x10
[ 3522.473005]  [<ffffffff8100c6ef>] default_idle+0x1f/0xb0
[ 3522.473005]  [<ffffffff8100cf9a>] arch_cpu_idle+0xa/0x10
[ 3522.473005]  [<ffffffff81084614>] cpu_startup_entry+0x284/0x330
[ 3522.473005]  [<ffffffff81610332>] rest_init+0x72/0x80
[ 3522.473005]  [<ffffffff81ad8062>] start_kernel+0x422/0x42f
[ 3522.473005]  [<ffffffff81ad7a2d>] ? set_init_arg+0x58/0x58
[ 3522.473005]  [<ffffffff81ad7117>] ? early_idt_handlers+0x117/0x120
[ 3522.473005]  [<ffffffff81ad75cc>] x86_64_start_reservations+0x2a/0x2c
[ 3522.473005]  [<ffffffff81ad7714>] x86_64_start_kernel+0x146/0x155
[ 3522.473005] Code: 00 4c 89 d0 48 8b 5d d8 4c 8b 65 e0 4c 8b 6d e8 4c 8b 75 f0 4c 8b 7d f8 c9 c3 0f 1f 40 00 49 63 44 24 20 49 8b 3c 24 48 8d 4a 01 <49> 8b 1c 02 4c 89 d0 65 48 0f c7 0f 0f 94 c0 84 c0 0f 84 56 ff 
[ 3522.473005] RIP  [<ffffffff8115c24d>] __kmalloc_node_track_caller+0xed/0x1b0
[ 3522.473005]  RSP <ffff88001fc03a08>



