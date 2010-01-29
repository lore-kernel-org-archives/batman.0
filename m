Return-Path: <andrew@lunn.ch>
Date: Fri, 29 Jan 2010 09:25:45 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100129082545.GI7844@lunn.ch>
References: <20100123174616.GA4795@Sellars>
 <20100126061311.GA12697@Sellars>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100126061311.GA12697@Sellars>
Subject: Re: [B.A.T.M.A.N.] slowpath warning
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> WARNING: at kernel/softirq.c:141 local_bh_enable+0x48/0xa0()
> Modules linked in: ath_ahb ath_hal(P) batman_adv ip6t_REJECT ip6t_LOG ip6t_rt ip6t_hbh ip6t_mh ip6t_ipv6header ip6t_frag ip6t_eui64 ip6t_ah ip6table_raw ip6_queue ip6table_mangle ip6table_filter ip6_tables ebt_redirect ebt_mark ebt_vlan ebt_stp ebt_pkttype ebt_mark_m ebt_limit ebt_among ebt_802_3 ebtable_nat ebtable_filter ebtable_broute ebtables xt_quota xt_pkttype xt_physdev ipt_REJECT xt_TCPMSS ipt_LOG xt_multiport xt_mac xt_limit iptable_mangle iptable_filter ip_tables xt_tcpudp x_tables tun ipv6
> Call Trace:
> [<800493a4>] dump_stack+0x8/0x34
> [<80060cd8>] warn_slowpath_common+0x70/0xb0
> [<800674ac>] local_bh_enable+0x48/0xa0
> [<801b3ef8>] dev_queue_xmit+0x388/0x3dc
> [<8062c454>] ieee80211_parent_queue_xmit+0x8c/0xb4 [ath_ahb]
> [<8062c778>] ieee80211_hardstart+0x2fc/0x34c [ath_ahb]
> [<801b3e5c>] dev_queue_xmit+0x2ec/0x3dc
> [<80bb68d8>] vis_quit+0x7c4/0x950 [batman_adv]
> 
> ---[ end trace e96b16c908cf7c40 ]---
> br-wan_vpn: received tcn bpdu on port 1(eth0.4)
> br-wan_vpn: topology change detected, propagating
> root@OpenWrt:~#

I dug a little deeper into what his means. It means we are in
interrupt context and interrupts are disabled. This seems to be not
allowed when calling local_bh_enable(), which probably means it is not
allowed when calling dev_queue_xmit. 

What i don't understand yet is the call path. The Call Trace above
does not make much sense. vis_quit() does not send any packets.

Looking at Marek's patch it is going in the right direction.
send_skb_packet() cannot be called with interrupts disabled.
which means send_raw_packet() cannot be called with interrupts disabled.
which means broadcast_vis_packet() needs to spin_unlock_irqrestore() before sending.
which means unicast_vis_packet() needs to spin_unlock_irqrestore() before sending.

This is what Mareks patch does. However, this part of Marek's patch looks wrong:

        struct vis_info *info, *temp;
        unsigned long flags;

-       spin_lock_irqsave(&vis_hash_lock, flags);
        purge_vis_packets();

        if (generate_vis_packet() == 0)
                /* schedule if generation was successful */
                list_add_tail(&my_vis_info->send_list, &send_list);

+       spin_lock_irqsave(&vis_hash_lock, flags);
        list_for_each_entry_safe(info, temp, &send_list, send_list) {
                list_del_init(&info->send_list);
                send_vis_packet(info);
        }
+
        spin_unlock_irqrestore(&vis_hash_lock, flags);
        start_vis_timer();
 }

You are disable interrupts and then call send_vis_packet(). This will
not work since all calls under send_vis_packet will have interrupts
disabled.

	Andrew
