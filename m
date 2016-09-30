Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Fri, 30 Sep 2016 12:31:07 +0200
Message-ID: <11805743.THDJhVGOyW@bentobox>
In-Reply-To: <2046441.Yi1MnWNqWl@bentobox>
References: <1468314486-29592-1-git-send-email-mareklindner@neomailbox.ch>
 <1954516.MjuANSl94h@bentobox> <2046441.Yi1MnWNqWl@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2081682.tX7zmXn6zA";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/3] batman-adv: additional checks for
	virtual interfaces on top of WiFi
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>

--nextPart2081682.tX7zmXn6zA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 12. Juli 2016 17:50:27 CEST Sven Eckelmann wrote:
> On Dienstag, 12. Juli 2016 14:33:09 CEST Sven Eckelmann wrote:
> [....]
> 
> > > diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-
> 
> interface.c
> 
> > > index 478977b..6324474 100644
> > > --- a/net/batman-adv/hard-interface.c
> > > +++ b/net/batman-adv/hard-interface.c
> > 
> > [...]
> > 
> > > +struct net_device *batadv_get_real_netdev(struct net_device
> > > *net_device)
> > > +{
> > 
> > [...]
> > 
> > > +	net = dev_net(hard_iface->soft_iface);
> > > +	ifindex = dev_get_iflink(net_device);
> > > +	real_netdev = dev_get_by_index(net, ifindex);
> > 
> > Andrew provided a patch [1] which gets the correct namespace of a link.
> > You
> > should consider to first accept his patch and then use batadv_getlink_net
> > to get the correct namespace for the device instead of just assuming that
> > it
> will
> 
> > be in the same netns as the batman-adv interface.
> > 
> > Something like this:
> >        net = dev_net(hard_iface->soft_iface);
> >        ifindex = dev_get_iflink(net_device);
> >        real_net = = batadv_getlink_net(net_device, net);
> >        real_netdev = dev_get_by_index(real_net, ifindex);
> > 
> > Could it also be that this has to be done with the rtnl lock held?
> > Otherwise some of the the information may change while we are going
> > through all the steps to get the real interface.
> 
> Maybe you can add ASSERT_RTNL(); in this function. The caller of these
> functions (see patch 3) have to make sure that they take the rtnl_lock().
> 
> batadv_is_cfg80211_netdev could get the rtnl_lock because it is used for the
> elp code (which isn't inside the rtnl_lock, right?). But the call to
> batadv_get_real_netdev in batadv_v_elp_get_throughput from Patch 3 still
> has to be protected.

This one failed because the rest of the code is rtnl-wise a complete mess. TT
code sometimes is in rtnl-locked context and sometimes not. But it always
wants to know if it is a wifi device. Same for multicast code which accesses
tt.

The rest of the code could be splitted to use two different functions but at
the end we even have problems that we cannot take the rtnl semaphore because
some other lock is enabled:


    [   34.023637] BUG: scheduling while atomic: kworker/u2:2/254/0x00000200
    [   34.030304] Modules linked in: pppoe ppp_async iptable_nat ath9k pppox ppp_generic nf_nat_ipv4 nf_conntrack_ipv6 nf_conntrack_ipv4 ipt_REJECT ipt_MASQUERADE ath9k_common xt_time xt_tcpudp xt_state xt_nat xt_multiport xt_mark xt_mac xt_limit xt_id xt_conntrack xt_comment xt_TCPMSS xt_REDIRECT xt_LOG xt_CT slhc nf_reject_ipv4 nf_nat_redirect nf_nat_masquerade_ipv4 nf_nat nf_log_ipv4 nf_defrag_ipv6 nf_defrag_ipv4 nf_conntrack_rtcache nf_conntrack iptable_raw iptable_mangle iptable_filter ip_tables crc_ccitt ath9k_hw act_skbedit act_mirred em_u32 cls_u32 cls_tcindex cls_flow cls_route cls_fw sch_hfsc sch_ingress ath10k_pci ath10k_core mac80211 ath batman_adv libcrc32c cfg80211 compat ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 nf_log_common ip6table_raw ip6table_mangle ip6table_filter ip6_tables x_tables gpio_button_hotplug crc16 crc32c_generic crypto_hash
    [   34.108504] CPU: 0 PID: 254 Comm: kworker/u2:2 Tainted: G        W       4.4.21 #0
    [   34.116399] Workqueue: bat_events batadv_v_elp_packet_recv [batman_adv]
    [   34.123232] Stack : 839c2c20 00000000 82c07780 800a7168 83a05680 8040cd83 803a632c 000000fe
              803d0950 83a19b9c 80410000 800a50e4 82c07780 800a7168 803ab9c8 80410000
              00000003 83a19b9c 80410000 80095154 82c07780 83a19bd4 00000000 801f26d0
              8040be90 801f2600 830c58f4 83b5bf00 83b5b900 6261745f 6576656e 74730000
              00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
              ...
    [   34.160255] Call Trace:
    [   34.162795] [<80071c6c>] show_stack+0x50/0x84
    [   34.167314] [<8009b350>] __schedule_bug+0x44/0x60
    [   34.172173] [<80066770>] __schedule+0x64/0x608
    [   34.176776] [<80066d78>] schedule+0x64/0x7c
    [   34.181103] [<80066f48>] schedule_preempt_disabled+0x10/0x1c
    [   34.186957] [<80068244>] __mutex_lock_slowpath+0xb8/0x114
    [   34.192565] [<830ce03c>] batadv_is_wifi_netdev+0x14/0x38 [batman_adv]
    [   34.199274] [<830de7d4>] batadv_tt_local_add+0x1ec/0x850 [batman_adv]
    [   34.205985] [<830d0f00>] batadv_mcast_mla_update+0x4c8/0x5a4 [batman_adv]
    [   34.213043] [<830de00c>] batadv_tp_meter_init+0x15b4/0x1b4c [batman_adv]
    [   34.219988] 
    [   44.494164] random: nonblocking pool is initialized

I have just pushed the code to ecsv/wifi-master-failed. Just in case someone
is interested in working everything out.

> Or you could create an extra function which takes care of getting the real
> device for batadv_v_elp_get_throughput when it is a cfg80211 based one
> (otherwise returning NULL). This function can take care of getting the lock.
> Then you can also drop this
> batadv_is_cfg80211_netdev -> _batadv_is_cfg80211_netdev change. Of course,
> you have to re-arrange many things in your patchset.
> 
> 1. create batadv_is_cfg80211_netdev
> 2. introduce function that returns the device when it is a cfg80211
>    * make use of it in batadv_v_elp_get_throughput and use it instead of
>      batadv_is_cfg80211_netdev
> 3. introduce batadv_get_real_netdev
>    * make use of it in your newly created function of patch 2
>    * don't use batadv_get_real_netdev directly in
> batadv_v_elp_get_throughput

This idea has basically the same problem because we still would need to run
the batadv_is_wifi_netdev code.

Kind regards,
	Sven
--nextPart2081682.tX7zmXn6zA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJX7j7rAAoJEF2HCgfBJntGCQcQALe9m2AghL3EuqLXAi/3ro69
ddakbLtSM9ykbpzrfApZG7X/DZs7AiuveCLL+d4k6y3uAy3H9pWPV0Z+x1QPJxIg
0Be7JQ8fV+vWzBxVvo3OS/5jfelN+pZic8NKFa1eOTbDfUBNtiXGI7NeC6oTfk/n
eNiJHpRPBgbpdFs9K9WszwFh1XfBtoB3occhioQiDo1GX3cG9cp/JrKq1X6r+jWL
cDhKih8RAW1amrX966kkosmBG2yokp5iIq8cEgOMXbcvzPJ0vwfOkvaMeC22pmWG
ELoJiLv/QaRehaZWZcI/qQ3F1BHs6PE/Dx8E0+W5w2ebEx0cLSJ8qa+TQpumLVJ0
Q8oqswLcq4Ym5x1LyIsgbMmpfQt5W8ccVS/LyL0kWue85GSKfNajigDs4cNqM3Lb
cCxVZVf1VxyTB+RJntXijrnP3m7dtTJ1Hpogr+uVuODvV80OkQrzVEzp67iiR9bH
6UJd+g9D+lwkL17Bd/aexUpRtLzKczKkBZek+pLeiZyI6cQCnWWU0mkp3sNLOivv
TQ6cUjfYZmnHNmmGBz8sL2XE28DFo3euYjG7PbBrymje2HTxCb0m2En5mHldT8zZ
Q09SLBjF5Piebf12guuU+/sKKX/uE5tWjgv+tISNFc+98BHIZFUts0CCtMYXW/7q
BOVOThhKTd13v8eJbmCP
=7/Ar
-----END PGP SIGNATURE-----

--nextPart2081682.tX7zmXn6zA--

