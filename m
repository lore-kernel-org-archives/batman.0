Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F90CC6B19
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 17:32:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0675F841A9
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 19:32:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791912761;
 b=RI4zrpTR2pcxdKZXdN1NroxSNiZ5rFpec8dCGs9hdwujgvwZ0wlXuHm9sIBXHUkPAdjpD
 v79Qk38lgompgekZ1/cS59bk3U7VoAVamfm+CaHyfOXIRR1BhssfQD8Zgl1wDPPlD8wV4b3
 zq+rU0/4BQjilzvES7aouus1S4CKfWc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791912761; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=3wzHYTni6EmhW0wZO2jYCdZA00iPZZjllQxA2tCwg1k=;
 b=1NKO9b+olGEVrcj81Kwq+ZEcWDXWNcq5jCTO6yquISuAU8NGhsoOnrpYdUXUq++JIpT3H
 /Xn9/R/f4dE09Zb9hQSoOPvuVCTBB6y0ra6as7GtaFVdjftIUwgJe+/00B1iEVKXe8yaUMW
 ZWr+9VYSF9mIHfLt+vKkU1Yn7cbzgOc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 337EE841B6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 19:31:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791912684;
	b=o1jRVBeYAcUs+gjIzigWczyxtdYDRZLBkAsjG41JqpDmivYK3/pWsQYr7aYH4OXJ9Gz5di
	zyMvEkQVRL+WZfwF3Fy83o0OB8QNM3a75G1HfDdksq4Zeb0djdDR+g7DEgoHsCLhlhSnYv
	5siNnuI6hVeW9Ftosyba07bszSeMflc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791912684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=3wzHYTni6EmhW0wZO2jYCdZA00iPZZjllQxA2tCwg1k=;
	b=bUnGg7lQOr2WU7WqoaEzmFo4aR7KxHs0QwJ8JPVQ3GvQ9I5wlYzNBwfeT+iPfyTwwKFoeO
	xjbtXwH2Hh8PWxUeP3CNifKDTuHMpcI8qcznVdNhJZBVwBZTiK0KObfw/z0PoVB5Ol1XM5
	c23TO6uX6mrfrBlCQ6eGeNdSvA5koKM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=tqQ33NFp;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B315920E43;
	Tue, 13 Oct 2026 17:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791912673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wzHYTni6EmhW0wZO2jYCdZA00iPZZjllQxA2tCwg1k=;
	b=tqQ33NFpD/hVLHJ8W7O9Hhb9ok/uiQH/WHyGIcLWa1Xf3T8Zjmy/7n9TFEWHrD11XFunMb
	7XKpa1X7pk0RLPB3C96EHLBRFKPBQZnzIbWKD1csvRQnZyn564ff5JK47UVyarsyPC2UW0
	bA43koyl+MtH6xefqfkroWmLNxpE0HI=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Oct 2026 19:30:39 +0200
Subject: [PATCH batadv 2/2] batman-adv: document refcount of returned
 objects
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-refcnt-explici-v1-2-05441b45da99@narfation.org>
References: <20261013-refcnt-explici-v1-0-05441b45da99@narfation.org>
In-Reply-To: <20261013-refcnt-explici-v1-0-05441b45da99@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=28345; i=sven@narfation.org;
 h=from:subject:message-id; bh=SvnfO8fPYr5mCoqJoJORUS2lj91nxz5Bc0vVOiPOkp0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnsq6Kxi/JnqfOcVJ06q3qzxXZi3PK2JZUvU7Zs+RDk
 dks11T3jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEZNcyMmzVW+Zuf/3HWU8v
 Ixn9kBq9T+qP7ZZ8n224/XZd/4EgmfWMDBvVvUxjDx9WONiqe37Ws6Ywoc1Pri2ZmHY6+07i7s9
 pS7gA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XZ4FZAVXNWASV7RORYIGDK4B22WS7U5W
X-Message-ID-Hash: XZ4FZAVXNWASV7RORYIGDK4B22WS7U5W
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XZ4FZAVXNWASV7RORYIGDK4B22WS7U5W/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Callers of lookup, get and create functions have to know whether they own a
reference to the returned object (and have to release it with the matching
batadv_*_put()), or only borrow it. Some functions document this with
"(with increased refcnt)", but many say nothing.

Add a note to the kerneldoc of every __must_check function that returns
an object with an increased refcounter. For the exceptions:

* batadv_transtable_best_orig()
* batadv_mcast_forw_orig_entry()

the opposite is stated to make the difference clear ("no increased refcnt",
"only valid in current RCU read-side critical section")

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c            |  6 +++++-
 net/batman-adv/bat_v.c                 |  3 ++-
 net/batman-adv/bat_v_ogm.c             |  1 +
 net/batman-adv/bridge_loop_avoidance.c |  7 +++++--
 net/batman-adv/distributed-arp-table.c |  1 +
 net/batman-adv/gateway_client.c        |  7 +++++--
 net/batman-adv/hard-interface.c        |  6 +++++-
 net/batman-adv/hard-interface.h        |  3 ++-
 net/batman-adv/multicast.c             |  1 +
 net/batman-adv/multicast_forw.c        |  2 ++
 net/batman-adv/netlink.c               | 28 ++++++++++++++--------------
 net/batman-adv/originator.c            | 16 +++++++++++++---
 net/batman-adv/routing.c               |  1 +
 net/batman-adv/tp_meter.c              | 12 ++++++++----
 net/batman-adv/translation-table.c     | 19 ++++++++++++++-----
 net/batman-adv/tvlv.c                  |  2 ++
 16 files changed, 81 insertions(+), 34 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 48bf3109..b373341f 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -136,6 +136,7 @@ static u8 batadv_ring_buffer_avg(const u8 lq_recv[])
  * Return: the originator object corresponding to the passed mac address or NULL
  * on failure.
  * If the object does not exist, it is created and initialised.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_orig_node * __must_check
 batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
@@ -177,7 +178,8 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
  * @neigh_addr: the mac address of the neighbour
  * @orig_node: originator object representing the neighbour
  *
- * Return: pointer to the neigh_node or NULL in case of failure
+ * Return: pointer to the neigh_node or NULL in case of failure.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_neigh_node * __must_check
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
@@ -1485,6 +1487,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
  *
  * Return: A neighbor node which is the best router towards the given originator
  * address. Bonding candidates are ignored.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_neigh_node * __must_check
 batadv_orig_to_direct_router(struct batadv_priv *bat_priv, u8 *orig_addr,
@@ -2487,6 +2490,7 @@ static void batadv_iv_init_sel_class(struct batadv_priv *bat_priv)
  *
  * Return: gateway node with the highest score for the current selection class,
  *  or NULL if no eligible gateway exists.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_gw_node * __must_check
 batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index e42ec410..8962dc81 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -607,7 +607,8 @@ static int batadv_v_gw_throughput_get(struct batadv_gw_node *gw_node, u32 *bw)
  * batadv_v_gw_get_best_gw_node() - retrieve the best GW node
  * @bat_priv: the bat priv with all the mesh interface information
  *
- * Return: the GW node having the best GW-metric, NULL if no GW is known
+ * Return: the GW node having the best GW-metric, NULL if no GW is known.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_gw_node * __must_check
 batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 70846c99..5fb459ee 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -51,6 +51,7 @@
  * Return: the orig_node corresponding to the specified address. If such an
  * object does not exist, it is allocated here. In case of allocation failure
  * returns NULL.
+ * The returned object has an increased refcounter.
  */
 struct batadv_orig_node *batadv_v_ogm_orig_get(struct batadv_priv *bat_priv,
 					       const u8 *addr)
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 845fa231..cb15b5b5 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -214,6 +214,7 @@ static void batadv_claim_put(struct batadv_bla_claim *claim)
  * @data: search data (may be local/static data)
  *
  * Return: claim if found or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_bla_claim * __must_check
 batadv_claim_hash_find(struct batadv_priv *bat_priv,
@@ -253,7 +254,8 @@ batadv_claim_hash_find(struct batadv_priv *bat_priv,
  * @addr: the address of the originator
  * @vid: the VLAN ID
  *
- * Return: backbone gateway if found or NULL otherwise
+ * Return: backbone gateway if found or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_bla_backbone_gw * __must_check
 batadv_backbone_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
@@ -480,7 +482,8 @@ static void batadv_bla_loopdetect_report(struct work_struct *work)
  * @vid: the VLAN ID
  * @own_backbone: set if the requested backbone is local
  *
- * Return: the (possibly created) backbone gateway or NULL on error
+ * Return: the (possibly created) backbone gateway or NULL on error.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_bla_backbone_gw * __must_check
 batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a14951df..eaed2545 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -394,6 +394,7 @@ static u32 batadv_hash_dat(const void *data, u32 size)
  * @vid: VLAN identifier
  *
  * Return: the dat_entry if found, NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_dat_entry * __must_check
 batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index e6e97c04..0dddcea7 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -74,7 +74,8 @@ void batadv_gw_node_release(struct kref *ref)
  * batadv_gw_get_selected_gw_node() - Get currently selected gateway
  * @bat_priv: the bat priv with all the mesh interface information
  *
- * Return: selected gateway (with increased refcnt), NULL on errors
+ * Return: selected gateway, NULL on errors.
+ * The returned object has an increased refcounter.
  */
 struct batadv_gw_node *
 batadv_gw_get_selected_gw_node(struct batadv_priv *bat_priv)
@@ -98,7 +99,8 @@ batadv_gw_get_selected_gw_node(struct batadv_priv *bat_priv)
  * batadv_gw_get_selected_orig() - Get originator of currently selected gateway
  * @bat_priv: the bat priv with all the mesh interface information
  *
- * Return: orig_node of selected gateway (with increased refcnt), NULL on errors
+ * Return: orig_node of selected gateway, NULL on errors.
+ * The returned object has an increased refcounter.
  */
 struct batadv_orig_node *
 batadv_gw_get_selected_orig(struct batadv_priv *bat_priv)
@@ -374,6 +376,7 @@ static void batadv_gw_node_add(struct batadv_priv *bat_priv,
  * @orig_node: originator announcing gateway capabilities
  *
  * Return: gateway node if found or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
 					  struct batadv_orig_node *orig_node)
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 434c69ac..1e9f944b 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -73,7 +73,8 @@ void batadv_hardif_release(struct kref *ref)
  * batadv_hardif_get_by_netdev() - Get hard interface object of a net_device
  * @net_dev: net_device to search for
  *
- * Return: batadv_hard_iface of net_dev (with increased refcnt), NULL on errors
+ * Return: batadv_hard_iface of net_dev, NULL on errors.
+ * The returned object has an increased refcounter.
  */
 struct batadv_hard_iface *
 batadv_hardif_get_by_netdev(struct net_device *net_dev)
@@ -236,6 +237,7 @@ static bool batadv_is_valid_iface(const struct net_device *net_dev)
  *
  * Return: the 'real' net device or the original net device and NULL in case
  *  of an error.
+ * The returned object has an increased refcounter.
  */
 struct net_device *__batadv_get_real_netdev(struct net_device *netdev)
 {
@@ -284,6 +286,7 @@ struct net_device *__batadv_get_real_netdev(struct net_device *netdev)
  *
  * Return: the 'real' net device or the original net device and NULL in case
  *  of an error.
+ * The returned object has an increased refcounter.
  */
 struct net_device *batadv_get_real_netdev(struct net_device *net_device)
 {
@@ -485,6 +488,7 @@ int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
  *
  * Return: first hard interface in BATADV_IF_ACTIVE state attached to
  *  @mesh_iface, or NULL if none is active.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_hard_iface * __must_check
 batadv_hardif_get_active(struct net_device *mesh_iface)
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index f91d6c77..3fd33671 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -99,7 +99,8 @@ static inline void batadv_hardif_put(struct batadv_hard_iface *hard_iface)
  * batadv_primary_if_get_selected() - Get reference to primary interface
  * @bat_priv: the bat priv with all the mesh interface information
  *
- * Return: primary interface (with increased refcnt), otherwise NULL
+ * Return: primary interface, otherwise NULL.
+ * The returned object has an increased refcounter.
  */
 static inline struct batadv_hard_iface * __must_check
 batadv_primary_if_get_selected(struct batadv_priv *bat_priv)
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 5f2ee79a..0bfebbd8 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -80,6 +80,7 @@ static void batadv_mcast_start_timer(struct batadv_priv *bat_priv)
  *
  * Return: NULL if no such bridge exists. Otherwise the net device of the
  * bridge.
+ * The returned object has an increased refcounter.
  */
 static struct net_device * __must_check
 batadv_mcast_get_bridge(struct net_device *mesh_iface)
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index ac97cd8b..03c24c80 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -109,6 +109,8 @@ batadv_mcast_forw_push_est_padding(struct sk_buff *skb, int count,
  * @entry_offset: the offset of the hlist node within the orig_node struct
  *
  * Return: The orig_node containing the hlist node on success, NULL on error.
+ * The returned object has no increased refcounter and is only valid inside
+ * the RCU read-side critical section of the caller.
  */
 static struct batadv_orig_node *
 batadv_mcast_forw_orig_entry(struct hlist_node *node,
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index d57c8525..b08e4114 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1135,8 +1135,8 @@ static int batadv_netlink_set_vlan(struct sk_buff *skb, struct genl_info *info)
  * @net: the applicable net namespace
  * @ifindex: index of the mesh interface
  *
- * Return: Pointer to mesh interface (with increased refcnt) on success, error
- *  pointer on error
+ * Return: Pointer to mesh interface on success, error pointer on error.
+ * The returned object has an increased refcounter.
  */
 static struct net_device * __must_check
 batadv_netlink_get_meshif_from_ifindex(struct net *net, int ifindex)
@@ -1163,8 +1163,8 @@ batadv_netlink_get_meshif_from_ifindex(struct net *net, int ifindex)
  * @net: the applicable net namespace
  * @info: receiver information
  *
- * Return: Pointer to mesh interface (with increased refcnt) on success, error
- *  pointer on error
+ * Return: Pointer to mesh interface, on success, error pointer on error.
+ * The returned object has an increased refcounter.
  */
 static struct net_device * __must_check
 batadv_netlink_get_meshif_from_info(struct net *net, struct genl_info *info)
@@ -1183,8 +1183,8 @@ batadv_netlink_get_meshif_from_info(struct net *net, struct genl_info *info)
  * batadv_netlink_get_meshif() - Retrieve mesh interface from netlink callback
  * @cb: callback structure containing arguments
  *
- * Return: Pointer to mesh interface (with increased refcnt) on success, error
- *  pointer on error
+ * Return: Pointer to mesh interface, on success, error pointer on error.
+ * The returned object has an increased refcounter.
  */
 struct net_device *batadv_netlink_get_meshif(struct netlink_callback *cb)
 {
@@ -1203,8 +1203,8 @@ struct net_device *batadv_netlink_get_meshif(struct netlink_callback *cb)
  * @net: the applicable net namespace
  * @ifindex: index of the hard interface
  *
- * Return: Pointer to hard interface (with increased refcnt) on success, error
- *  pointer on error
+ * Return: Pointer to hard interface on success, error pointer on error.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_hard_iface * __must_check
 batadv_netlink_get_hardif_from_ifindex(struct batadv_priv *bat_priv,
@@ -1245,8 +1245,8 @@ batadv_netlink_get_hardif_from_ifindex(struct batadv_priv *bat_priv,
  * @net: the applicable net namespace
  * @info: receiver information
  *
- * Return: Pointer to hard interface (with increased refcnt) on success, error
- *  pointer on error
+ * Return: Pointer to hard interface on success, error pointer on error.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_hard_iface * __must_check
 batadv_netlink_get_hardif_from_info(struct batadv_priv *bat_priv,
@@ -1267,8 +1267,8 @@ batadv_netlink_get_hardif_from_info(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @cb: callback structure containing arguments
  *
- * Return: Pointer to hard interface (with increased refcnt) on success, error
- *  pointer on error
+ * Return: Pointer to hard interface on success, error pointer on error.
+ * The returned object has an increased refcounter.
  */
 struct batadv_hard_iface *
 batadv_netlink_get_hardif(struct batadv_priv *bat_priv,
@@ -1290,8 +1290,8 @@ batadv_netlink_get_hardif(struct batadv_priv *bat_priv,
  * @net: the applicable net namespace
  * @info: receiver information
  *
- * Return: Pointer to vlan on success (with increased refcnt), error pointer
- *  on error
+ * Return: Pointer to vlan on success, error pointer on error.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_meshif_vlan * __must_check
 batadv_get_vlan_from_info(struct batadv_priv *bat_priv, struct net *net,
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 95b94d87..805f9375 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -47,7 +47,8 @@ static struct lock_class_key batadv_orig_hash_lock_class_key;
  * @bat_priv: the bat priv with all the mesh interface information
  * @data: mac address of the originator
  *
- * Return: orig_node (with increased refcnt), NULL on errors
+ * Return: orig_node, NULL on errors.
+ * The returned object has an increased refcounter.
  */
 struct batadv_orig_node *
 batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data)
@@ -104,6 +105,7 @@ bool batadv_compare_orig(const struct hlist_node *node, const void *data2)
  *
  * Return: the vlan object identified by vid and belonging to orig_node or NULL
  * if it does not exist.
+ * The returned object has an increased refcounter.
  */
 struct batadv_orig_node_vlan *
 batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
@@ -344,6 +346,7 @@ batadv_orig_router_get(struct batadv_orig_node *orig_node,
  *
  * Return: A neighbor node which is the best router towards the given originator
  * address.
+ * The returned object has an increased refcounter.
  */
 struct batadv_neigh_node *
 batadv_orig_to_router(struct batadv_priv *bat_priv, u8 *orig_addr,
@@ -526,7 +529,8 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
  * Looks for and possibly returns a neighbour belonging to this originator list
  * which is connected through the provided hard interface.
  *
- * Return: neighbor when found. Otherwise NULL
+ * Return: neighbor when found. Otherwise NULL.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_neigh_node * __must_check
 batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
@@ -562,6 +566,7 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
  * @orig_node: originator object representing the neighbour
  *
  * Return: the hardif neighbour node if found or created or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_hardif_neigh_node * __must_check
 batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
@@ -609,6 +614,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
  * @orig_node: originator object representing the neighbour
  *
  * Return: the hardif neighbour node if found or created or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_hardif_neigh_node * __must_check
 batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
@@ -632,7 +638,8 @@ batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
  *
  * Looks for and possibly returns a neighbour belonging to this hard interface.
  *
- * Return: neighbor when found. Otherwise NULL
+ * Return: neighbor when found. Otherwise NULL.
+ * The returned object has an increased refcounter.
  */
 struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
@@ -667,6 +674,7 @@ batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
  * Allocates a new neigh_node object and initialises all the generic fields.
  *
  * Return: the neighbour node if found or created or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_neigh_node * __must_check
 batadv_neigh_node_create(struct batadv_orig_node *orig_node,
@@ -732,6 +740,7 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
  * @neigh_addr: the mac address of the neighbour interface
  *
  * Return: the neighbour node if found or created or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 struct batadv_neigh_node *
 batadv_neigh_node_get_or_create(struct batadv_orig_node *orig_node,
@@ -943,6 +952,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
  * The new object is not added to the originator list.
  *
  * Return: the newly created object or NULL on failure.
+ * The returned object has an increased refcounter.
  */
 struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 					      const u8 *addr)
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 9aa79e2d..adcfc055 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -587,6 +587,7 @@ batadv_last_bonding_replace(struct batadv_orig_node *orig_node,
  *
  * Return: the router which should be used for this orig_node on
  * this interface, or NULL if not available.
+ * The returned object has an increased refcounter.
  */
 struct batadv_neigh_node *
 batadv_find_router(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index a9ad2811..e53e1737 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -262,7 +262,8 @@ static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
  * Look for a tp_vars object matching dst as end_point and return it after
  * having increment the refcounter. Return NULL is not found
  *
- * Return: matching tp_vars or NULL when no tp_vars with @dst was found
+ * Return: matching tp_vars or NULL when no tp_vars with @dst was found.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tp_sender * __must_check
 batadv_tp_list_find_sender(struct batadv_priv *bat_priv, const u8 *dst)
@@ -327,7 +328,8 @@ static bool batadv_tp_list_active(struct batadv_priv *bat_priv, const u8 *dst)
  * session and return it after having increment the refcounter. Return NULL
  * is not found
  *
- * Return: matching tp_vars or NULL when no tp_vars was found
+ * Return: matching tp_vars or NULL when no tp_vars was found.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tp_sender * __must_check
 batadv_tp_list_find_sender_session(struct batadv_priv *bat_priv, const u8 *dst,
@@ -1210,7 +1212,8 @@ void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
  * session and return it after having increment the refcounter. Return NULL
  * is not found
  *
- * Return: matching tp_vars or NULL when no tp_vars was found
+ * Return: matching tp_vars or NULL when no tp_vars was found.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tp_receiver * __must_check
 batadv_tp_list_find_receiver_session(struct batadv_priv *bat_priv, const u8 *dst,
@@ -1567,7 +1570,8 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
  * @bat_priv: the bat priv with all the mesh interface information
  * @icmp: received icmp tp msg
  *
- * Return: corresponding tp_vars or NULL on errors
+ * Return: corresponding tp_vars or NULL on errors.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tp_receiver * __must_check
 batadv_tp_init_recv(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 4e39d699..9fdc0ea4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -186,6 +186,7 @@ static inline u32 batadv_choose_tt(const void *data, u32 size)
  *
  * Return: a pointer to the tt_common struct belonging to the searched client if
  * found, NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tt_common_entry * __must_check
 batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
@@ -233,6 +234,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
  *
  * Return: a pointer to the corresponding tt_local_entry struct if the client is
  * found, NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tt_local_entry * __must_check
 batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
@@ -258,6 +260,7 @@ batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
  *
  * Return: a pointer to the corresponding tt_global_entry struct if the client
  * is found, NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 struct batadv_tt_global_entry *
 batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
@@ -985,8 +988,8 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
  * as BATADV_TT_CLIENT_NEW to avoid sending it in a full table response going
  * out before the next ttvn increment (consistency check).
  *
- * Return: the new entry with an initialized reference counter on success, NULL
- * otherwise.
+ * Return: the new entry on success, NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tt_local_entry * __must_check
 batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
@@ -1951,7 +1954,8 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
  * retrieve the orig_tt_list_entry belonging to orig_node from the
  * batadv_tt_global_entry list
  *
- * Return: it with an increased refcounter, NULL if not found
+ * Return: found entry on success, NULL if not found.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tt_orig_list_entry * __must_check
 batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
@@ -2188,8 +2192,8 @@ batadv_tt_global_merge_flags(struct batadv_tt_global_entry *tt_global_entry,
  * The returned entry is not yet part of bat_priv->tt.global_hash and has an
  * empty originator list.
  *
- * Return: the new entry with an initialized reference counter on success, NULL
- * otherwise.
+ * Return: the new entry on success, NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tt_global_entry * __must_check
 batadv_tt_global_create(const unsigned char *tt_addr, unsigned short vid,
@@ -2353,6 +2357,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
  *
  * This function assumes the caller holds rcu_read_lock().
  * Return: best originator list entry or NULL on errors.
+ * The returned object has no increased refcounter and is only valid inside
+ * the RCU read-side critical section of the caller.
  */
 static struct batadv_tt_orig_list_entry *
 batadv_transtable_best_orig(struct batadv_priv *bat_priv,
@@ -3020,8 +3026,10 @@ _batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
  * mesh for contacting the client 'addr', NULL otherwise.
  * In case of multiple originators serving the same client, the function returns
  * the best one (best in terms of metric towards the destination node).
+ * The returned object has an increased refcounter.
  *
  * If the two clients are AP isolated the function returns NULL.
+ * The returned object has an increased refcounter.
  */
 struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
 						  const u8 *src,
@@ -3342,6 +3350,7 @@ static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
  *
  * Return: the pointer to the new tt_req_node struct if no request
  * has already been issued for this orig_node, NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tt_req_node * __must_check
 batadv_tt_req_node_new(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index a4f7e474..d26f3f77 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -68,6 +68,7 @@ static void batadv_tvlv_handler_put(struct batadv_tvlv_handler *tvlv_handler)
  * @version: tvlv handler version to look for
  *
  * Return: tvlv handler if found or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tvlv_handler * __must_check
 batadv_tvlv_handler_get(struct batadv_priv *bat_priv, u8 type, u8 version)
@@ -131,6 +132,7 @@ static void batadv_tvlv_container_put(struct batadv_tvlv_container *tvlv)
  * (tvlv.container_list_lock).
  *
  * Return: tvlv container if found or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tvlv_container * __must_check
 batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)

-- 
2.47.3

