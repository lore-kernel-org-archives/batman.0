Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF42CD3423
	for <batman@archiver.kernel.org>; Sat, 31 Aug 2024 19:46:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2619883E04
	for <batman@archiver.kernel.org>; Sat, 31 Aug 2024 21:46:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1725133562;
 b=U7nJyz29i9C/xmHAERRupBdf13KDku36StfIL0zm5OIXOmWQDjtp4HggtuBS2epMSbsTK
 M9t3aCOg37cP80UxTlYdxp6NYhls9G1rvzfEEkvw0SY2F4CMfOIPyhUJ7fyZ+NEVqxqD+wh
 ToGh9WKC9ZS5Ejp65NKn8kSBeZkgn7s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1725133562; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ELlYu1zc15o6YOC0nMPzdqiElsc8OsVcXbF9wLCd4hU=;
 b=oXWf03r3X9TK3M3s63M2DrsfPNE6CtrrGUFJ1PxR7Ha/vwvgHRCwSuDj3I5Y/CQBaN4p5
 KQZzzkKrFvKoDC/HY1+7aT/VBzvUhj++ziGSXkAPrJjYED1QOpSyRHkR/CSNchHoW4c7IwE
 VHT97uh16EOXd672wGloluyhs97jM1Y=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CF2B583D07
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Aug 2024 21:45:32 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1725133532; a=rsa-sha256;
	cv=none;
	b=j4LuZZ1q6x9u1orXrOLSPZU5MP2Gw71eYeG6CPnMvbJUegRKuRNB7eQlzcAnpOOgGcbVO5
	bfpWC9SNH5oaErq4GmEgcgYk52UoI9ZH3HqzxLSQpUke8b34HmOD6UJj+uc8jxcvlByh8o
	Extn2ABEteMWQZNXoFzt8f/UAnV+y3I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 116.203.183.178 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1725133532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ELlYu1zc15o6YOC0nMPzdqiElsc8OsVcXbF9wLCd4hU=;
	b=u4t5KbbTtylFtGPqQqSvPXpsxT8c66as0RJGwvYXmVkZfpUlSfTbFwl6/m62wbt1NobdPJ
	edsz7Yff4plhDojUliH3zriO/cjGKeVyiJprUsDlCGzP+T0vJgZfbOGA0+6kj2xaMWHnFT
	XYYH4nao2wscWTS9/WwZNm3mNNL1nCI=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BD4CD3EDBA;
	Sat, 31 Aug 2024 21:45:31 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH] batman-adv: mcast: add option to forward MLD reports only to
 mcast routers
Date: Sat, 31 Aug 2024 21:45:28 +0200
Message-ID: <20240831194528.1932-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: VDNN6OVU4MEASRVBGCL5ULSMRVD3D4HP
X-Message-ID-Hash: VDNN6OVU4MEASRVBGCL5ULSMRVD3D4HP
X-MailFrom: linus.luessing@c0d3.blue
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VDNN6OVU4MEASRVBGCL5ULSMRVD3D4HP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

In most setups it is sufficient for us to only send MLD reports to nodes
which have a multicast router attached. Which reduces overall overhead,
especially in large batman-adv mesh networks, where broadcasts are
particularly undesirable.

However there is one specific, known issue / broken scenario with this
setting:

If the IGMP/MLD querier is configured directly on the bridge on top of
bat0. But there is no multicast router on or behind this node. Then this
bridge will be unable to detect multicast listeners on/behind other
nodes which have the MLD-RTR-ONLY setting enabled. (A workaround for this
can then in turn be to set multicast_router=2 on the bat0 bridge port
on the node with the IGMP/MLD querier.)

Therefore MLD report flooding is kept the default and MLD report to
multicast routers only forwarding is considered experimental and
warned about.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---

An list of scenarios with illustrations and a step-by-step
evaluation with this setting for them can be found on the batman-adv wiki:
* https://www.open-mesh.org/projects/batman-adv/wiki/Multicast-IGMP-MLD-Report-Forwarding#section-2

This patchset is applied and tested on/between Freifunk Lübeck
(180 nodes) and a small Freifunk Vogtland domain. It allowed using
layer 3 IPv6 multicast routing here without flooding the whole mesh
network with MLD reports.

 include/uapi/linux/batman_adv.h |  9 ++++++
 net/batman-adv/multicast.c      | 52 +++++++++++++++++++++++++--------
 net/batman-adv/netlink.c        | 17 +++++++++++
 net/batman-adv/soft-interface.c |  1 +
 net/batman-adv/types.h          |  7 +++++
 5 files changed, 74 insertions(+), 12 deletions(-)

diff --git a/include/uapi/linux/batman_adv.h b/include/uapi/linux/batman_adv.h
index 35dc016c9bb4..11cd170036ff 100644
--- a/include/uapi/linux/batman_adv.h
+++ b/include/uapi/linux/batman_adv.h
@@ -481,6 +481,15 @@ enum batadv_nl_attrs {
 	 */
 	BATADV_ATTR_MULTICAST_FANOUT,
 
+	/**
+	 * @BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED: defines how IGMP/MLD
+	 * reports are forwarded in the mesh. If set to non-zero then IGMP/MLD
+	 * reports are only forwarded to detected multicast routers. If set to
+	 * zero then they are flooded instead.
+	 * Warning: The former is experimental and potentially unsafe!
+	 */
+	BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED,
+
 	/* add attributes above here, update the policy in netlink.c */
 
 	/**
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 38fab5e46ae2..d5e3f4d90fd1 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -1008,8 +1008,14 @@ static int batadv_mcast_forw_mode_check_ipv4(struct batadv_priv *bat_priv,
 	if (!pskb_may_pull(skb, sizeof(struct ethhdr) + sizeof(*iphdr)))
 		return -ENOMEM;
 
-	if (batadv_mcast_is_report_ipv4(skb))
+	if (batadv_mcast_is_report_ipv4(skb)) {
+		if (atomic_read(&bat_priv->multicast_mld_rtr_only)) {
+			*is_routable = IGMP_HOST_MEMBERSHIP_REPORT;
+			return 0;
+		}
+
 		return -EINVAL;
+	}
 
 	iphdr = ip_hdr(skb);
 
@@ -1072,8 +1078,14 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
 	if (!pskb_may_pull(skb, sizeof(struct ethhdr) + sizeof(*ip6hdr)))
 		return -ENOMEM;
 
-	if (batadv_mcast_is_report_ipv6(skb))
+	if (batadv_mcast_is_report_ipv6(skb)) {
+		if (atomic_read(&bat_priv->multicast_mld_rtr_only)) {
+			*is_routable = ICMPV6_MGM_REPORT;
+			return 0;
+		}
+
 		return -EINVAL;
+	}
 
 	ip6hdr = ipv6_hdr(skb);
 
@@ -1160,17 +1172,19 @@ static int batadv_mcast_forw_want_all_ip_count(struct batadv_priv *bat_priv,
  * @protocol: the ethernet protocol type to count multicast routers for
  *
  * Return: the number of nodes which want all routable IPv4 multicast traffic
- * if the protocol is ETH_P_IP or the number of nodes which want all routable
- * IPv6 traffic if the protocol is ETH_P_IPV6. Otherwise returns 0.
+ * if the protocol is ETH_P_IP or IGMP_HOST_MEMBERSHIP_REPORT. Or the number of
+ * nodes which want all routable IPv6 traffic if the protocol is ETH_P_IPV6 or
+ * ICMPV6_MGM_REPORT. Otherwise returns 0.
  */
-
 static int batadv_mcast_forw_rtr_count(struct batadv_priv *bat_priv,
 				       int protocol)
 {
 	switch (protocol) {
 	case ETH_P_IP:
+	case IGMP_HOST_MEMBERSHIP_REPORT:
 		return atomic_read(&bat_priv->mcast.num_want_all_rtr4);
 	case ETH_P_IPV6:
+	case ICMPV6_MGM_REPORT:
 		return atomic_read(&bat_priv->mcast.num_want_all_rtr6);
 	default:
 		return 0;
@@ -1234,10 +1248,11 @@ enum batadv_forw_mode
 batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		       unsigned short vid, int *is_routable)
 {
-	int ret, tt_count, ip_count, unsnoop_count, total_count;
+	atomic_t *unsnoop_cnt_atom = &bat_priv->mcast.num_want_all_unsnoopables;
+	int ret, ip_count, rtr_count, total_count;
+	int tt_count = 0, unsnoop_count = 0;
 	bool is_unsnoopable = false;
 	struct ethhdr *ethhdr;
-	int rtr_count = 0;
 
 	ret = batadv_mcast_forw_mode_check(bat_priv, skb, &is_unsnoopable,
 					   is_routable);
@@ -1248,11 +1263,17 @@ batadv_mcast_forw_mode(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	ethhdr = eth_hdr(skb);
 
-	tt_count = batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest,
-					       BATADV_NO_FLAGS);
-	ip_count = batadv_mcast_forw_want_all_ip_count(bat_priv, ethhdr);
-	unsnoop_count = !is_unsnoopable ? 0 :
-			atomic_read(&bat_priv->mcast.num_want_all_unsnoopables);
+	if (*is_routable != IGMP_HOST_MEMBERSHIP_REPORT &&
+	    *is_routable != ICMPV6_MGM_REPORT) {
+		tt_count = batadv_tt_global_hash_count(bat_priv, ethhdr->h_dest,
+						       BATADV_NO_FLAGS);
+
+		if (is_unsnoopable)
+			unsnoop_count = atomic_read(unsnoop_cnt_atom);
+	}
+
+	ip_count = batadv_mcast_forw_want_all_ip_count(bat_priv,
+						       ethhdr);
 	rtr_count = batadv_mcast_forw_rtr_count(bat_priv, *is_routable);
 
 	total_count = tt_count + ip_count + unsnoop_count + rtr_count;
@@ -1540,8 +1561,10 @@ batadv_mcast_forw_want_rtr(struct batadv_priv *bat_priv,
 {
 	switch (ntohs(eth_hdr(skb)->h_proto)) {
 	case ETH_P_IP:
+	case IGMP_HOST_MEMBERSHIP_REPORT:
 		return batadv_mcast_forw_want_all_rtr4(bat_priv, skb, vid);
 	case ETH_P_IPV6:
+	case ICMPV6_MGM_REPORT:
 		return batadv_mcast_forw_want_all_rtr6(bat_priv, skb, vid);
 	default:
 		/* we shouldn't be here... */
@@ -1571,12 +1594,17 @@ int batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
 {
 	int ret;
 
+	if (is_routable == IGMP_HOST_MEMBERSHIP_REPORT ||
+	    is_routable == ICMPV6_MGM_REPORT)
+		goto skip_mc_listeners;
+
 	ret = batadv_mcast_forw_tt(bat_priv, skb, vid);
 	if (ret != NET_XMIT_SUCCESS) {
 		kfree_skb(skb);
 		return ret;
 	}
 
+skip_mc_listeners:
 	ret = batadv_mcast_forw_want_all(bat_priv, skb, vid);
 	if (ret != NET_XMIT_SUCCESS) {
 		kfree_skb(skb);
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 3f0003fc502c..0923117d63b2 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -145,6 +145,7 @@ static const struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
 	[BATADV_ATTR_LOG_LEVEL]			= { .type = NLA_U32 },
 	[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_MULTICAST_FANOUT]		= { .type = NLA_U32 },
+	[BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_NETWORK_CODING_ENABLED]	= { .type = NLA_U8 },
 	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
 	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
@@ -345,6 +346,10 @@ static int batadv_netlink_mesh_fill(struct sk_buff *msg,
 	if (nla_put_u32(msg, BATADV_ATTR_MULTICAST_FANOUT,
 			atomic_read(&bat_priv->multicast_fanout)))
 		goto nla_put_failure;
+
+	if (nla_put_u8(msg, BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED,
+		       atomic_read(&bat_priv->multicast_mld_rtr_only)))
+		goto nla_put_failure;
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
 #ifdef CONFIG_BATMAN_ADV_NC
@@ -588,6 +593,18 @@ static int batadv_netlink_set_mesh(struct sk_buff *skb, struct genl_info *info)
 
 		atomic_set(&bat_priv->multicast_fanout, nla_get_u32(attr));
 	}
+
+	if (info->attrs[BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED]) {
+		u8 mld_rtr_only;
+
+		attr = info->attrs[BATADV_ATTR_MULTICAST_MLD_RTR_ONLY_ENABLED];
+		mld_rtr_only = !!nla_get_u8(attr);
+		if (mld_rtr_only)
+			batadv_info(bat_priv->soft_iface,
+				    "Warning: MLD-RTR-ONLY is experimental and has known, broken scenarios\n");
+
+		atomic_set(&bat_priv->multicast_mld_rtr_only, mld_rtr_only);
+	}
 #endif /* CONFIG_BATMAN_ADV_MCAST */
 
 #ifdef CONFIG_BATMAN_ADV_NC
diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
index 30ecbc2ef1fd..bd9168450995 100644
--- a/net/batman-adv/soft-interface.c
+++ b/net/batman-adv/soft-interface.c
@@ -762,6 +762,7 @@ static int batadv_softif_init_late(struct net_device *dev)
 #ifdef CONFIG_BATMAN_ADV_MCAST
 	atomic_set(&bat_priv->multicast_mode, 1);
 	atomic_set(&bat_priv->multicast_fanout, 16);
+	atomic_set(&bat_priv->multicast_mld_rtr_only, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_unsnoopables, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv4, 0);
 	atomic_set(&bat_priv->mcast.num_want_all_ipv6, 0);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 00840d5784fe..bf8eab36e43b 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1683,6 +1683,13 @@ struct batadv_priv {
 	 *  multicast-to-unicast conversion
 	 */
 	atomic_t multicast_fanout;
+
+	/**
+	 * @multicast_mld_rtr_only: bool indicating whether to send IGMP/MLD
+	 *  reports only to multicast routers or to flood them otherwise.
+	 * Warning: The former is experimental and potentially unsafe!
+	 */
+	atomic_t multicast_mld_rtr_only;
 #endif
 
 	/** @orig_interval: OGM broadcast interval in milliseconds */
-- 
2.45.2

