Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A5FCC6B0E
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 17:32:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CE08483C3D
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 19:32:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791912720;
 b=xnI3iAImpvrGD7k+QgDTgHXQI6BSLNfA/DtfyRO7I0wOwhdUJeluevZahE/dJawxHen63
 dT4ghELkvS3s8MccgPUQtT3QtOPV77EO9N0h3CciLDW0IDh5L2VbGqoQp2mw24SnYfyBYiT
 Y3/gW5JbxrtAO3B1c250wuZrLXAbBnY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791912720; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=r3jWubZVTIPI0V6u7D8RWuV9740TgJ3COC0rCd0V8m0=;
 b=q3nY0sBBI9zx2JDJUMl6YBDlxFBwBZPooxRVeDDpRBc/3qO5xzclwSR8j3thuXo5FvLUG
 dr8nvx28wg7FQl7EdScT58oWRYc9QG1WE3/UbwVz6VNzb2Voqa7uxr0Q+5hQtkK05O02Sip
 BcdyeSFd0w8VrEat6xO0oFeHFRQwJvI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2583F80723
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 19:31:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791912682;
	b=uErxKGHh3yOaHWiFYj3QUw/jPx4W6YhREX46knZvmy6k/fsPZN9NS8/bs+D+PUB87+X1qj
	XOWz3SU89jmOkeEgWkLRsaUirpBw7h1x7h7c+/XiaffYLKb8zZ+q46P3vMdvwykXfLcakj
	uy6k/410MaAUrzIEjcxFAuxNaMxwVfk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791912682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=r3jWubZVTIPI0V6u7D8RWuV9740TgJ3COC0rCd0V8m0=;
	b=04Rd8V2bFGW69NeQ0OZpprQJObeARJGaElOZzhDdoSWN0LfKeUhGLzhcuWTeZl2GYIbplX
	8qTM6dCOu5hn8TqinSNc0B3LyFK51+PrwwQNjAZH+nYYxke7Adl80EyPYFMUBi4e5bhMiJ
	thnkl9AZXIpJ0qd2OeiduWdo5CjFh20=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=uzeEgR+a;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BA58B20515;
	Tue, 13 Oct 2026 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791912671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r3jWubZVTIPI0V6u7D8RWuV9740TgJ3COC0rCd0V8m0=;
	b=uzeEgR+aKwl1h5QRiOWpQM6BnDB18EhY4G+47d04l8WaZmsbOoB+WKnT49rRFkaVUNPhzi
	GFAfCNCCaW/vL8+Lo4Hq+IgoLL6vwjuGgHSFbsE3PEe36ob4I15bLStvFfR6VGpZW6yYeE
	YhOfHF8Gr9RGJ7u2x5pr1NxTQDHwYaU=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Oct 2026 19:30:38 +0200
Subject: [PATCH batadv 1/2] batman-adv: annotate functions returning
 objects with __must_check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-refcnt-explici-v1-1-05441b45da99@narfation.org>
References: <20261013-refcnt-explici-v1-0-05441b45da99@narfation.org>
In-Reply-To: <20261013-refcnt-explici-v1-0-05441b45da99@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=27547; i=sven@narfation.org;
 h=from:subject:message-id; bh=mcMdsjL7TuKDqRZVdcCDz1z8INFHFRqlkArOYUFQVeI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnsq6+6l5u1uhtyLXqb8b6c8mTX5mv9FH+yX32zonA/
 mta0yyLOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATCdrHyHD/qptSrcvUMtXS
 9jWJV9T7Mq/vmrx+TUvXgyWaBR0Mwh8ZGfaVeSvs/NCpvCv1gvr+ckZHnmIz3/ZNfBcn+drkPIh
 YwwEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 6IX3A3JCWWY33SJY5CVHCUROZLEUXPEC
X-Message-ID-Hash: 6IX3A3JCWWY33SJY5CVHCUROZLEUXPEC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6IX3A3JCWWY33SJY5CVHCUROZLEUXPEC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Most lookup, get and create functions in return an object with an increased
refcounter, which the caller has to release again with the matching
batadv_*_put(). If a caller ignores such a return value, the reference
leaks.

Mark these functions __must_check so the compiler catches such (potential
future) callers.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c            |  8 ++++----
 net/batman-adv/bat_v.c                 |  2 +-
 net/batman-adv/bat_v_ogm.h             |  4 ++--
 net/batman-adv/bridge_loop_avoidance.c |  8 ++++----
 net/batman-adv/distributed-arp-table.c |  2 +-
 net/batman-adv/gateway_client.h        |  9 +++++----
 net/batman-adv/hard-interface.c        |  2 +-
 net/batman-adv/hard-interface.h        | 10 ++++++----
 net/batman-adv/mesh-interface.h        |  4 ++--
 net/batman-adv/multicast.c             |  3 ++-
 net/batman-adv/netlink.c               | 10 +++++-----
 net/batman-adv/netlink.h               |  5 +++--
 net/batman-adv/originator.c            | 10 +++++-----
 net/batman-adv/originator.h            | 26 +++++++++++++-------------
 net/batman-adv/routing.c               |  2 +-
 net/batman-adv/routing.h               |  2 +-
 net/batman-adv/tp_meter.c              |  8 ++++----
 net/batman-adv/translation-table.c     | 12 ++++++------
 net/batman-adv/translation-table.h     |  9 +++++----
 net/batman-adv/tvlv.c                  |  4 ++--
 20 files changed, 73 insertions(+), 67 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 85e99506..48bf3109 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -137,7 +137,7 @@ static u8 batadv_ring_buffer_avg(const u8 lq_recv[])
  * on failure.
  * If the object does not exist, it is created and initialised.
  */
-static struct batadv_orig_node *
+static struct batadv_orig_node * __must_check
 batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 {
 	struct batadv_orig_node *orig_node;
@@ -179,7 +179,7 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
  *
  * Return: pointer to the neigh_node or NULL in case of failure
  */
-static struct batadv_neigh_node *
+static struct batadv_neigh_node * __must_check
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr,
 			struct batadv_orig_node *orig_node)
@@ -1486,7 +1486,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
  * Return: A neighbor node which is the best router towards the given originator
  * address. Bonding candidates are ignored.
  */
-static struct batadv_neigh_node *
+static struct batadv_neigh_node * __must_check
 batadv_orig_to_direct_router(struct batadv_priv *bat_priv, u8 *orig_addr,
 			     struct batadv_hard_iface *if_outgoing)
 {
@@ -2488,7 +2488,7 @@ static void batadv_iv_init_sel_class(struct batadv_priv *bat_priv)
  * Return: gateway node with the highest score for the current selection class,
  *  or NULL if no eligible gateway exists.
  */
-static struct batadv_gw_node *
+static struct batadv_gw_node * __must_check
 batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
 	struct batadv_neigh_ifinfo *router_ifinfo;
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 596889b3..e42ec410 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -609,7 +609,7 @@ static int batadv_v_gw_throughput_get(struct batadv_gw_node *gw_node, u32 *bw)
  *
  * Return: the GW node having the best GW-metric, NULL if no GW is known
  */
-static struct batadv_gw_node *
+static struct batadv_gw_node * __must_check
 batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
 	struct batadv_gw_node *curr_gw = NULL;
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index edeffede..30a4a7d9 100644
--- a/net/batman-adv/bat_v_ogm.h
+++ b/net/batman-adv/bat_v_ogm.h
@@ -18,8 +18,8 @@ void batadv_v_ogm_free(struct batadv_priv *bat_priv);
 void batadv_v_ogm_aggr_work(struct work_struct *work);
 int batadv_v_ogm_iface_enable(struct batadv_hard_iface *hard_iface);
 void batadv_v_ogm_iface_disable(struct batadv_hard_iface *hard_iface);
-struct batadv_orig_node *batadv_v_ogm_orig_get(struct batadv_priv *bat_priv,
-					       const u8 *addr);
+struct batadv_orig_node * __must_check
+batadv_v_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr);
 void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *primary_iface);
 int batadv_v_ogm_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming);
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index a96f269d..845fa231 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -215,7 +215,7 @@ static void batadv_claim_put(struct batadv_bla_claim *claim)
  *
  * Return: claim if found or NULL otherwise.
  */
-static struct batadv_bla_claim *
+static struct batadv_bla_claim * __must_check
 batadv_claim_hash_find(struct batadv_priv *bat_priv,
 		       struct batadv_bla_claim *data)
 {
@@ -255,7 +255,7 @@ batadv_claim_hash_find(struct batadv_priv *bat_priv,
  *
  * Return: backbone gateway if found or NULL otherwise
  */
-static struct batadv_bla_backbone_gw *
+static struct batadv_bla_backbone_gw * __must_check
 batadv_backbone_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 			  unsigned short vid)
 {
@@ -482,7 +482,7 @@ static void batadv_bla_loopdetect_report(struct work_struct *work)
  *
  * Return: the (possibly created) backbone gateway or NULL on error
  */
-static struct batadv_bla_backbone_gw *
+static struct batadv_bla_backbone_gw * __must_check
 batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 			   unsigned short vid, bool own_backbone)
 {
@@ -789,7 +789,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
  *
  * Return: valid reference to claim::backbone_gw
  */
-static struct batadv_bla_backbone_gw *
+static struct batadv_bla_backbone_gw * __must_check
 batadv_bla_claim_get_backbone_gw(struct batadv_bla_claim *claim)
 {
 	struct batadv_bla_backbone_gw *backbone_gw;
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 74050bff..a14951df 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -395,7 +395,7 @@ static u32 batadv_hash_dat(const void *data, u32 size)
  *
  * Return: the dat_entry if found, NULL otherwise.
  */
-static struct batadv_dat_entry *
+static struct batadv_dat_entry * __must_check
 batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 			   unsigned short vid)
 {
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 95c2ccda..168175c2 100644
--- a/net/batman-adv/gateway_client.h
+++ b/net/batman-adv/gateway_client.h
@@ -18,7 +18,7 @@
 void batadv_gw_check_client_stop(struct batadv_priv *bat_priv);
 void batadv_gw_reselect(struct batadv_priv *bat_priv);
 void batadv_gw_election(struct batadv_priv *bat_priv);
-struct batadv_orig_node *
+struct batadv_orig_node * __must_check
 batadv_gw_get_selected_orig(struct batadv_priv *bat_priv);
 void batadv_gw_check_election(struct batadv_priv *bat_priv,
 			      struct batadv_orig_node *orig_node);
@@ -29,15 +29,16 @@ void batadv_gw_node_delete(struct batadv_priv *bat_priv,
 			   struct batadv_orig_node *orig_node);
 void batadv_gw_node_free(struct batadv_priv *bat_priv);
 void batadv_gw_node_release(struct kref *ref);
-struct batadv_gw_node *
+struct batadv_gw_node * __must_check
 batadv_gw_get_selected_gw_node(struct batadv_priv *bat_priv);
 int batadv_gw_dump(struct sk_buff *msg, struct netlink_callback *cb);
 bool batadv_gw_out_of_range(struct batadv_priv *bat_priv, struct sk_buff *skb);
 enum batadv_dhcp_recipient
 batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 			     u8 *chaddr);
-struct batadv_gw_node *batadv_gw_node_get(struct batadv_priv *bat_priv,
-					  struct batadv_orig_node *orig_node);
+struct batadv_gw_node * __must_check
+batadv_gw_node_get(struct batadv_priv *bat_priv,
+		   struct batadv_orig_node *orig_node);
 
 /**
  * batadv_gw_node_put() - decrement the gw_node refcounter and possibly release
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index c5bc60d1..434c69ac 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -486,7 +486,7 @@ int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
  * Return: first hard interface in BATADV_IF_ACTIVE state attached to
  *  @mesh_iface, or NULL if none is active.
  */
-static struct batadv_hard_iface *
+static struct batadv_hard_iface * __must_check
 batadv_hardif_get_active(struct net_device *mesh_iface)
 {
 	struct batadv_hard_iface *hard_iface;
diff --git a/net/batman-adv/hard-interface.h b/net/batman-adv/hard-interface.h
index 935f47ca..f91d6c77 100644
--- a/net/batman-adv/hard-interface.h
+++ b/net/batman-adv/hard-interface.h
@@ -62,12 +62,14 @@ enum batadv_hard_if_bcast {
 
 extern struct notifier_block batadv_hard_if_notifier;
 
-struct net_device *__batadv_get_real_netdev(struct net_device *net_device);
-struct net_device *batadv_get_real_netdev(struct net_device *net_device);
+struct net_device * __must_check
+__batadv_get_real_netdev(struct net_device *net_device);
+struct net_device * __must_check
+batadv_get_real_netdev(struct net_device *net_device);
 u32 batadv_netdev_get_wifi_flags(struct net_device *net_dev);
 u32 batadv_hardif_get_wifi_flags(struct batadv_hard_iface *hard_iface);
 bool batadv_is_wifi_hardif(struct batadv_hard_iface *hard_iface);
-struct batadv_hard_iface*
+struct batadv_hard_iface * __must_check
 batadv_hardif_get_by_netdev(struct net_device *net_dev);
 int batadv_hardif_enable_interface(struct net_device *net_dev,
 				   struct net_device *mesh_iface);
@@ -99,7 +101,7 @@ static inline void batadv_hardif_put(struct batadv_hard_iface *hard_iface)
  *
  * Return: primary interface (with increased refcnt), otherwise NULL
  */
-static inline struct batadv_hard_iface *
+static inline struct batadv_hard_iface * __must_check
 batadv_primary_if_get_selected(struct batadv_priv *bat_priv)
 {
 	struct batadv_hard_iface *hard_iface;
diff --git a/net/batman-adv/mesh-interface.h b/net/batman-adv/mesh-interface.h
index 5e1e83e0..ac73f09f 100644
--- a/net/batman-adv/mesh-interface.h
+++ b/net/batman-adv/mesh-interface.h
@@ -24,8 +24,8 @@ int batadv_meshif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid);
 void batadv_meshif_destroy_vlan(struct batadv_priv *bat_priv,
 				struct batadv_meshif_vlan *vlan);
 void batadv_meshif_vlan_release(struct kref *ref);
-struct batadv_meshif_vlan *batadv_meshif_vlan_get(struct batadv_priv *bat_priv,
-						  unsigned short vid);
+struct batadv_meshif_vlan * __must_check
+batadv_meshif_vlan_get(struct batadv_priv *bat_priv, unsigned short vid);
 
 /**
  * batadv_meshif_vlan_put() - decrease the vlan object refcounter and
diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 22dd28d5..5f2ee79a 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -81,7 +81,8 @@ static void batadv_mcast_start_timer(struct batadv_priv *bat_priv)
  * Return: NULL if no such bridge exists. Otherwise the net device of the
  * bridge.
  */
-static struct net_device *batadv_mcast_get_bridge(struct net_device *mesh_iface)
+static struct net_device * __must_check
+batadv_mcast_get_bridge(struct net_device *mesh_iface)
 {
 	struct net_device *upper = mesh_iface;
 
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 1177b3ce..d57c8525 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -1138,7 +1138,7 @@ static int batadv_netlink_set_vlan(struct sk_buff *skb, struct genl_info *info)
  * Return: Pointer to mesh interface (with increased refcnt) on success, error
  *  pointer on error
  */
-static struct net_device *
+static struct net_device * __must_check
 batadv_netlink_get_meshif_from_ifindex(struct net *net, int ifindex)
 {
 	struct net_device *mesh_iface;
@@ -1166,7 +1166,7 @@ batadv_netlink_get_meshif_from_ifindex(struct net *net, int ifindex)
  * Return: Pointer to mesh interface (with increased refcnt) on success, error
  *  pointer on error
  */
-static struct net_device *
+static struct net_device * __must_check
 batadv_netlink_get_meshif_from_info(struct net *net, struct genl_info *info)
 {
 	int ifindex;
@@ -1206,7 +1206,7 @@ struct net_device *batadv_netlink_get_meshif(struct netlink_callback *cb)
  * Return: Pointer to hard interface (with increased refcnt) on success, error
  *  pointer on error
  */
-static struct batadv_hard_iface *
+static struct batadv_hard_iface * __must_check
 batadv_netlink_get_hardif_from_ifindex(struct batadv_priv *bat_priv,
 				       struct net *net, int ifindex)
 {
@@ -1248,7 +1248,7 @@ batadv_netlink_get_hardif_from_ifindex(struct batadv_priv *bat_priv,
  * Return: Pointer to hard interface (with increased refcnt) on success, error
  *  pointer on error
  */
-static struct batadv_hard_iface *
+static struct batadv_hard_iface * __must_check
 batadv_netlink_get_hardif_from_info(struct batadv_priv *bat_priv,
 				    struct net *net, struct genl_info *info)
 {
@@ -1293,7 +1293,7 @@ batadv_netlink_get_hardif(struct batadv_priv *bat_priv,
  * Return: Pointer to vlan on success (with increased refcnt), error pointer
  *  on error
  */
-static struct batadv_meshif_vlan *
+static struct batadv_meshif_vlan * __must_check
 batadv_get_vlan_from_info(struct batadv_priv *bat_priv, struct net *net,
 			  struct genl_info *info)
 {
diff --git a/net/batman-adv/netlink.h b/net/batman-adv/netlink.h
index f92d3ea7..d6eeff0e 100644
--- a/net/batman-adv/netlink.h
+++ b/net/batman-adv/netlink.h
@@ -14,8 +14,9 @@
 
 int batadv_netlink_register(void);
 void batadv_netlink_unregister(void);
-struct net_device *batadv_netlink_get_meshif(struct netlink_callback *cb);
-struct batadv_hard_iface *
+struct net_device * __must_check
+batadv_netlink_get_meshif(struct netlink_callback *cb);
+struct batadv_hard_iface * __must_check
 batadv_netlink_get_hardif(struct batadv_priv *bat_priv,
 			  struct netlink_callback *cb);
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index f06583ef..95b94d87 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -528,7 +528,7 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
  *
  * Return: neighbor when found. Otherwise NULL
  */
-static struct batadv_neigh_node *
+static struct batadv_neigh_node * __must_check
 batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
 		      const struct batadv_hard_iface *hard_iface,
 		      const u8 *addr)
@@ -563,7 +563,7 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
  *
  * Return: the hardif neighbour node if found or created or NULL otherwise.
  */
-static struct batadv_hardif_neigh_node *
+static struct batadv_hardif_neigh_node * __must_check
 batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 			   const u8 *neigh_addr,
 			   struct batadv_orig_node *orig_node)
@@ -610,7 +610,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
  *
  * Return: the hardif neighbour node if found or created or NULL otherwise.
  */
-static struct batadv_hardif_neigh_node *
+static struct batadv_hardif_neigh_node * __must_check
 batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
 				  const u8 *neigh_addr,
 				  struct batadv_orig_node *orig_node)
@@ -668,7 +668,7 @@ batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
  *
  * Return: the neighbour node if found or created or NULL otherwise.
  */
-static struct batadv_neigh_node *
+static struct batadv_neigh_node * __must_check
 batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 			 struct batadv_hard_iface *hard_iface,
 			 const u8 *neigh_addr)
@@ -1168,7 +1168,7 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
  *
  * Return: the current best neighbor, with refcount increased.
  */
-static struct batadv_neigh_node *
+static struct batadv_neigh_node * __must_check
 batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 			  struct batadv_orig_node *orig_node,
 			  struct batadv_hard_iface *if_outgoing)
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index db0c5512..a923f862 100644
--- a/net/batman-adv/originator.h
+++ b/net/batman-adv/originator.h
@@ -22,46 +22,46 @@ int batadv_originator_init(struct batadv_priv *bat_priv);
 void batadv_originator_free(struct batadv_priv *bat_priv);
 void batadv_purge_orig_ref(struct batadv_priv *bat_priv);
 void batadv_orig_node_release(struct kref *ref);
-struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
-					      const u8 *addr);
-struct batadv_hardif_neigh_node *
+struct batadv_orig_node * __must_check
+batadv_orig_node_new(struct batadv_priv *bat_priv, const u8 *addr);
+struct batadv_hardif_neigh_node * __must_check
 batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr);
 void batadv_hardif_neigh_release(struct kref *ref);
-struct batadv_neigh_node *
+struct batadv_neigh_node * __must_check
 batadv_neigh_node_get_or_create(struct batadv_orig_node *orig_node,
 				struct batadv_hard_iface *hard_iface,
 				const u8 *neigh_addr);
 void batadv_neigh_node_release(struct kref *ref);
-struct batadv_neigh_node *
+struct batadv_neigh_node * __must_check
 batadv_orig_router_get(struct batadv_orig_node *orig_node,
 		       const struct batadv_hard_iface *if_outgoing);
-struct batadv_neigh_node *
+struct batadv_neigh_node * __must_check
 batadv_orig_to_router(struct batadv_priv *bat_priv, u8 *orig_addr,
 		      struct batadv_hard_iface *if_outgoing);
-struct batadv_neigh_ifinfo *
+struct batadv_neigh_ifinfo * __must_check
 batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
 			struct batadv_hard_iface *if_outgoing);
-struct batadv_neigh_ifinfo *
+struct batadv_neigh_ifinfo * __must_check
 batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 			struct batadv_hard_iface *if_outgoing);
 void batadv_neigh_ifinfo_release(struct kref *ref);
 
 int batadv_hardif_neigh_dump(struct sk_buff *msg, struct netlink_callback *cb);
 
-struct batadv_orig_ifinfo *
+struct batadv_orig_ifinfo * __must_check
 batadv_orig_ifinfo_get(struct batadv_orig_node *orig_node,
 		       struct batadv_hard_iface *if_outgoing);
-struct batadv_orig_ifinfo *
+struct batadv_orig_ifinfo * __must_check
 batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 		       struct batadv_hard_iface *if_outgoing);
 void batadv_orig_ifinfo_release(struct kref *ref);
 
 int batadv_orig_dump(struct sk_buff *msg, struct netlink_callback *cb);
-struct batadv_orig_node_vlan *
+struct batadv_orig_node_vlan * __must_check
 batadv_orig_node_vlan_new(struct batadv_orig_node *orig_node,
 			  unsigned short vid);
-struct batadv_orig_node_vlan *
+struct batadv_orig_node_vlan * __must_check
 batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
 			  unsigned short vid);
 void batadv_orig_node_vlan_release(struct kref *ref);
@@ -82,7 +82,7 @@ static inline u32 batadv_choose_orig(const void *data, u32 size)
 	return hash % size;
 }
 
-struct batadv_orig_node *
+struct batadv_orig_node * __must_check
 batadv_orig_hash_find(struct batadv_priv *bat_priv, const void *data);
 
 /**
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 6442f5d0..9aa79e2d 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -542,7 +542,7 @@ static int batadv_check_unicast_packet(struct batadv_priv *bat_priv,
  *
  * The object is returned with refcounter increased by 1.
  */
-static struct batadv_orig_ifinfo *
+static struct batadv_orig_ifinfo * __must_check
 batadv_last_bonding_get(struct batadv_orig_node *orig_node)
 {
 	struct batadv_orig_ifinfo *last_bonding_candidate;
diff --git a/net/batman-adv/routing.h b/net/batman-adv/routing.h
index e9849f03..74878d06 100644
--- a/net/batman-adv/routing.h
+++ b/net/batman-adv/routing.h
@@ -42,7 +42,7 @@ int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if);
 int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
 					 struct batadv_hard_iface *recv_if);
-struct batadv_neigh_node *
+struct batadv_neigh_node * __must_check
 batadv_find_router(struct batadv_priv *bat_priv,
 		   struct batadv_orig_node *orig_node,
 		   struct batadv_hard_iface *recv_if);
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 022eb13e..a9ad2811 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -264,7 +264,7 @@ static void batadv_tp_batctl_error_notify(enum batadv_tp_meter_reason reason,
  *
  * Return: matching tp_vars or NULL when no tp_vars with @dst was found
  */
-static struct batadv_tp_sender *
+static struct batadv_tp_sender * __must_check
 batadv_tp_list_find_sender(struct batadv_priv *bat_priv, const u8 *dst)
 {
 	struct batadv_tp_sender *tp_vars = NULL;
@@ -329,7 +329,7 @@ static bool batadv_tp_list_active(struct batadv_priv *bat_priv, const u8 *dst)
  *
  * Return: matching tp_vars or NULL when no tp_vars was found
  */
-static struct batadv_tp_sender *
+static struct batadv_tp_sender * __must_check
 batadv_tp_list_find_sender_session(struct batadv_priv *bat_priv, const u8 *dst,
 				   const u8 *session)
 {
@@ -1212,7 +1212,7 @@ void batadv_tp_stop(struct batadv_priv *bat_priv, const u8 *dst,
  *
  * Return: matching tp_vars or NULL when no tp_vars was found
  */
-static struct batadv_tp_receiver *
+static struct batadv_tp_receiver * __must_check
 batadv_tp_list_find_receiver_session(struct batadv_priv *bat_priv, const u8 *dst,
 				     const u8 *session)
 {
@@ -1569,7 +1569,7 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
  *
  * Return: corresponding tp_vars or NULL on errors
  */
-static struct batadv_tp_receiver *
+static struct batadv_tp_receiver * __must_check
 batadv_tp_init_recv(struct batadv_priv *bat_priv,
 		    const struct batadv_icmp_tp_packet *icmp)
 {
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e46040fd..4e39d699 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -187,7 +187,7 @@ static inline u32 batadv_choose_tt(const void *data, u32 size)
  * Return: a pointer to the tt_common struct belonging to the searched client if
  * found, NULL otherwise.
  */
-static struct batadv_tt_common_entry *
+static struct batadv_tt_common_entry * __must_check
 batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
 		    unsigned short vid)
 {
@@ -234,7 +234,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
  * Return: a pointer to the corresponding tt_local_entry struct if the client is
  * found, NULL otherwise.
  */
-static struct batadv_tt_local_entry *
+static struct batadv_tt_local_entry * __must_check
 batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 			  unsigned short vid)
 {
@@ -988,7 +988,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
  * Return: the new entry with an initialized reference counter on success, NULL
  * otherwise.
  */
-static struct batadv_tt_local_entry *
+static struct batadv_tt_local_entry * __must_check
 batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 		       unsigned short vid, bool iif_is_wifi)
 {
@@ -1953,7 +1953,7 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
  *
  * Return: it with an increased refcounter, NULL if not found
  */
-static struct batadv_tt_orig_list_entry *
+static struct batadv_tt_orig_list_entry * __must_check
 batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 				 const struct batadv_orig_node *orig_node)
 {
@@ -2191,7 +2191,7 @@ batadv_tt_global_merge_flags(struct batadv_tt_global_entry *tt_global_entry,
  * Return: the new entry with an initialized reference counter on success, NULL
  * otherwise.
  */
-static struct batadv_tt_global_entry *
+static struct batadv_tt_global_entry * __must_check
 batadv_tt_global_create(const unsigned char *tt_addr, unsigned short vid,
 			u16 flags)
 {
@@ -3343,7 +3343,7 @@ static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
  * Return: the pointer to the new tt_req_node struct if no request
  * has already been issued for this orig_node, NULL otherwise.
  */
-static struct batadv_tt_req_node *
+static struct batadv_tt_req_node * __must_check
 batadv_tt_req_node_new(struct batadv_priv *bat_priv,
 		       struct batadv_orig_node *orig_node)
 {
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index ca01d20e..47ac4760 100644
--- a/net/batman-adv/translation-table.h
+++ b/net/batman-adv/translation-table.h
@@ -29,15 +29,16 @@ int batadv_tt_global_dump(struct sk_buff *msg, struct netlink_callback *cb);
 void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 			       struct batadv_orig_node *orig_node,
 			       s32 match_vid, const char *message);
-struct batadv_tt_global_entry *
+struct batadv_tt_global_entry * __must_check
 batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 			   unsigned short vid);
 void batadv_tt_global_entry_release(struct kref *ref);
 int batadv_tt_global_hash_count(struct batadv_priv *bat_priv,
 				const u8 *addr, unsigned short vid);
-struct batadv_orig_node *batadv_transtable_search(struct batadv_priv *bat_priv,
-						  const u8 *src, const u8 *addr,
-						  unsigned short vid);
+struct batadv_orig_node * __must_check
+batadv_transtable_search(struct batadv_priv *bat_priv,
+			 const u8 *src, const u8 *addr,
+			 unsigned short vid);
 void batadv_tt_free(struct batadv_priv *bat_priv);
 bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 			 unsigned short vid);
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 93492d39..a4f7e474 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -69,7 +69,7 @@ static void batadv_tvlv_handler_put(struct batadv_tvlv_handler *tvlv_handler)
  *
  * Return: tvlv handler if found or NULL otherwise.
  */
-static struct batadv_tvlv_handler *
+static struct batadv_tvlv_handler * __must_check
 batadv_tvlv_handler_get(struct batadv_priv *bat_priv, u8 type, u8 version)
 {
 	struct batadv_tvlv_handler *tvlv_handler = NULL;
@@ -132,7 +132,7 @@ static void batadv_tvlv_container_put(struct batadv_tvlv_container *tvlv)
  *
  * Return: tvlv container if found or NULL otherwise.
  */
-static struct batadv_tvlv_container *
+static struct batadv_tvlv_container * __must_check
 batadv_tvlv_container_get(struct batadv_priv *bat_priv, u8 type, u8 version)
 {
 	struct batadv_tvlv_container *tvlv = NULL;

-- 
2.47.3

