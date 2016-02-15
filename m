Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Mon, 15 Feb 2016 13:35:31 +0100
Message-ID: <1792155.rcBUdH4UUQ@bentobox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [B.A.T.M.A.N.] Unsigned integer overflow in batadv_iv_ogm_calc_tq
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

Hi,

just ran my emulation setup [1] and got an integer overflow (undefined behavior):

    ================================================================================
    UBSAN: Undefined behaviour in /home/sven/tmp/qemu-batman/batman-adv/net/batman-adv/bat_iv_ogm.c:1246:25
    signed integer overflow:
    8713350 * 255 cannot be represented in type 'int'
    CPU: 1 PID: 0 Comm: swapper/1 Tainted: G           O    4.5.0-rc4-next-20160215 #10
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Debian-1.8.2-1 04/01/2014
     1ffff10001980ea7 10e2f8880f23fbe1 ffff88000cc075b0 ffffffff817f196f
     0000000041b58ab3 ffffffff824b0b5f ffffffff817f1894 ffff88000cc075d8
     ffff88000cc07588 ffff88000cc075a0 00000000000000ff ffff88000cc07398
    Call Trace:
     <IRQ>  [<ffffffff817f196f>] dump_stack+0xdb/0x15c
     [<ffffffff817f1894>] ? _atomic_dec_and_lock+0xc4/0xc4
     [<ffffffff8186c21b>] ubsan_epilogue+0xd/0x8a
     [<ffffffff8186dbba>] handle_overflow+0x211/0x260
     [<ffffffff8186d9a9>] ? __ubsan_handle_negate_overflow+0x1b1/0x1b1
     [<ffffffff811ebd6d>] ? trace_hardirqs_on+0xd/0x10
     [<ffffffffa0041ed0>] ? batadv_neigh_ifinfo_get+0x330/0x330 [batman_adv]
     [<ffffffffa0008390>] ? batadv_iv_ogm_process_per_outif+0x1380/0x33f0 [batman_adv]
     [<ffffffff811ebd6d>] ? trace_hardirqs_on+0xd/0x10
     [<ffffffff8186dc37>] __ubsan_handle_mul_overflow+0xe/0x17
     [<ffffffffa0009d74>] batadv_iv_ogm_process_per_outif+0x2d64/0x33f0 [batman_adv]
     [<ffffffffa0007f27>] ? batadv_iv_ogm_process_per_outif+0xf17/0x33f0 [batman_adv]
     [<ffffffffa000acd4>] batadv_iv_ogm_receive+0x8d4/0x1d20 [batman_adv]
     [<ffffffffa000a7c2>] ? batadv_iv_ogm_receive+0x3c2/0x1d20 [batman_adv]
     [<ffffffffa0037468>] batadv_batman_skb_recv+0x378/0x490 [batman_adv]
     [<ffffffffa00370f0>] ? batadv_skb_set_priority+0x640/0x640 [batman_adv]
     [<ffffffff81c68577>] __netif_receive_skb_core+0x7b7/0x2a50
     [<ffffffff81c67dc0>] ? __skb_csum_offload_chk+0x12a0/0x12a0
     [<ffffffff81c6f215>] __netif_receive_skb+0x55/0x200
     [<ffffffff81c6f4b9>] netif_receive_skb_internal+0xf9/0x3e0
     [<ffffffff81c6f454>] ? netif_receive_skb_internal+0x94/0x3e0
     [<ffffffff81c6f3c0>] ? __netif_receive_skb+0x200/0x200
     [<ffffffff81c71bce>] ? dev_gro_receive+0x76e/0x1ca0
     [<ffffffff81c71a6c>] ? dev_gro_receive+0x60c/0x1ca0
     [<ffffffff81c32331>] ? __netdev_alloc_skb+0x1d1/0x350
     [<ffffffff813ec1a6>] ? memcpy+0x36/0x40
     [<ffffffff81ce34b0>] ? eth_commit_mac_addr_change+0x70/0x70
     [<ffffffff81acc2f4>] ? page_to_skb+0x1d4/0x720
     [<ffffffff81c7321a>] napi_gro_receive+0x11a/0x240
     [<ffffffff81ad2564>] virtnet_receive+0xc14/0x26b0
     [<ffffffff81ad1950>] ? try_fill_recv+0x1530/0x1530
     [<ffffffff810cbe70>] ? pvclock_read_flags+0x6d0/0x6d0
     [<ffffffff8185bd80>] ? __list_add+0x3f0/0x3f0
     [<ffffffff81ad437d>] virtnet_poll+0x1d/0x160
     [<ffffffff81c70e63>] net_rx_action+0x6a3/0xca0
     [<ffffffff812183ed>] ? handle_irq_event+0xcd/0x1a0
     [<ffffffff81223245>] ? handle_fasteoi_irq+0x275/0x8f0
     [<ffffffff810fa930>] ? __do_softirq+0x1d0/0x870
     [<ffffffff810fa9e8>] __do_softirq+0x288/0x870
     [<ffffffff810fb263>] irq_exit+0xe3/0x140
     [<ffffffff8102209e>] do_IRQ+0x9e/0x200
     [<ffffffff8216fdcc>] common_interrupt+0x8c/0x8c
     <EOI>  [<ffffffff810c9a66>] ? native_safe_halt+0x6/0x10
     [<ffffffff811ebd6d>] ? trace_hardirqs_on+0xd/0x10
     [<ffffffff810364de>] default_idle+0xe/0x20
     [<ffffffff8103774a>] arch_cpu_idle+0xa/0x10
     [<ffffffff811d199f>] default_idle_call+0x4f/0x80
     [<ffffffff811d1c94>] cpu_startup_entry+0x2c4/0x540
     [<ffffffff8216eb76>] ? _raw_spin_unlock_irqrestore+0x36/0x60
     [<ffffffff811d19d0>] ? default_idle_call+0x80/0x80
     [<ffffffff8126f5b8>] ? clockevents_register_device+0xf8/0x1f0
     [<ffffffff810a9f9b>] start_secondary+0x35b/0x4c0
     [<ffffffff810a9c40>] ? set_cpu_sibling_map+0x2fe0/0x2fe0
    ================================================================================

The code is:

	combined_tq = batadv_ogm_packet->tq *
		      tq_own *
		      tq_asym_penalty *
		      tq_iface_penalty;
	combined_tq /= BATADV_TQ_MAX_VALUE *
		       BATADV_TQ_MAX_VALUE *
		       BATADV_TQ_MAX_VALUE;

It is easy to see that

    batadv_ogm_packet::tq (u8 255) *
    tq_own (u8 255) *
    tq_asym_penalty (int 134) *
    tq_iface_penalty (int 255)

is outside the range of an signed integer (32 bit). The maximum seen
here is 255 for each entry. So should tq_iface_penalty +
tq_iface_penalty, inv_asym_penalty be changed to unsigned int?

--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1147,9 +1147,10 @@ static int batadv_iv_ogm_calc_tq(struct batadv_orig_node *orig_node,
 	u8 total_count;
 	u8 orig_eq_count, neigh_rq_count, neigh_rq_inv, tq_own;
 	unsigned int neigh_rq_inv_cube, neigh_rq_max_cube;
-	int tq_asym_penalty, inv_asym_penalty, if_num, ret = 0;
+	int if_num, ret = 0;
+	unsigned int tq_asym_penalty, inv_asym_penalty;
 	unsigned int combined_tq;
-	int tq_iface_penalty;
+	unsigned int tq_iface_penalty;
 
 	/* find corresponding one hop neighbor */
 	rcu_read_lock();

Kind regards,
	Sven



[1] https://www.open-mesh.org/projects/open-mesh/wiki/Emulation_Debug

