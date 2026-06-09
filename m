Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B0F9CD8CAD
	for <batman-adv@archiver.kernel.org>; Tue,  9 Jun 2026 19:50:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B1F6183F6F
	for <batman-adv@archiver.kernel.org>; Tue, 09 Jun 2026 21:50:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781034625;
 b=jT/qWYpmKX1Tc5yZWcSmr8TczuI6c5vKc2t6TdbALyDdNeaflN1UHJidWGR3hNuk/OfD/
 CGTohmz027f2pPrfylS/L3hu4jC3O1RnY0F53FaMX+0rVnj7q/HW75nKoGEQhY4JoKm7PHp
 Zuf1Atu+mofnW9BSzpi1bRQBMz46+Cc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781034625; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=BezliBaSEy97tCD+6vsYJVghPZLNTj/mdjNoJKO8W9Y=;
 b=ST8mbzMb5YULB9lA50NUw40Qf1/r/iJD2bw5Rub9KuCcnnXnNe/IjL08T+ooegZ7z2t6E
 OiGOsXRC4DVxAkAFDB/SNbdijXbtEtlVNzd9LKw1vlDnj3JtmBp3buq5EVSZQF/jR4BpP1Q
 vurxILIFZitwwnEU878btxFkr37dP/w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A1C1681F41
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 09 Jun 2026 21:50:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781034615;
	b=XorKOCM/MybeCYIJHVYV3dk8hP+c1xnq/LR/AiCzNzjFnV+cOf87rKpig4CUwYPvdQzg6w
	U4Hxn+G08DjskOoxNaJiLYAo/VPMQTXL/hRAo03/KwhrwFRmlhfcJRH3bqglSwY5JhVlz7
	OXaZZDV0mPKrm78oczewcmxBKnuTg1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781034615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=BezliBaSEy97tCD+6vsYJVghPZLNTj/mdjNoJKO8W9Y=;
	b=bW1j3fHtS82+E8s648VD1OV0WFc2ripQm+WAjnOmEV1zFb2kZgcA+36YdpJimbMropEBvK
	M5oc+z/C4VF8Pb0WwBN/oWtQEOG7rtGapdp0l1bf+nzE83lUwB9ANCGiW5xt0qZwJop00L
	IoV9TOj+lWR5lZJd5zRWzOW/WjajLis=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=GjOMYHW+;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 778A6200F4;
	Tue, 09 Jun 2026 19:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781034603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BezliBaSEy97tCD+6vsYJVghPZLNTj/mdjNoJKO8W9Y=;
	b=GjOMYHW+Rog5zucvr4dhVJw4hgKrzTLgndB6meCYknW+HxZFjIGxFyrlld75cBsZYjggr2
	nyhpyJCb8hx4fSB5YZGop1aYAYJGYOsIqxlgIpxwi/Nc2NsOMJgo7BTP1QqQZkbx/3swOo
	9S4Y0xMnzZ9htUPW7iWhV3FWWdccmtY=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 09 Jun 2026 21:49:51 +0200
Subject: [PATCH batadv] batman-adv: add missing kernel-doc comments
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-kernel-doc-v1-1-3d1b8ff0f50c@narfation.org>
X-B4-Tracking: v=1; b=H4sIAF5uKGoC/yWMywrCMBQFf6WctYF4rbX4K+Iij6NelVSSWoTSf
 2/U5QzMzCjMyoJjMyNz0qJDqrDdNAg3l640GitDrHS2s715MCc+TRyCkYP4Nu4p/c6iBq/Mi35
 +sxO8G12ccP778vZ3hvF7wrKsD+R3mXYAAAA=
X-Change-ID: 20260608-kernel-doc-272b4d5e2830
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=55030; i=sven@narfation.org;
 h=from:subject:message-id; bh=VqEnXllRPSwYlulL0s80n1ELsZW9ckCqTaNybIPJJ/o=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkaeempfb7NV/jrcxosy/itarUzdjJZr05tsIpjDZNN+
 Srx5kNHKQuDGBeDrJgiy54r+ec3s7+V/zzt41GYOaxMIEMYuDgFYCK6IQz/Cw1LHwqyRc821WLS
 T3S2rYwQvHYx30vSoz+q9X32LP01jAwr+nP/Tn55/IL2DOPSmQcPbvp3+8+aKT6/0jIf8h3JiHz
 CAwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FEEI67QV32MRZ6BHTMYSFUJQHYHJKJ5K
X-Message-ID-Hash: FEEI67QV32MRZ6BHTMYSFUJQHYHJKJ5K
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FEEI67QV32MRZ6BHTMYSFUJQHYHJKJ5K/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batman-adv requires kernel-doc for all functions and data types visible
outside their own translation unit. Promoting a function from static to
module-wide visibility currently requires adding documentation from
scratch. However, this burden falls on whoever promotes a function from
static to module-wide visibility, rather than its original implementer.

Add the missing kernel-doc comments for the remaining undocumented
functions and data types to reduce the complexity for new contributions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 include/uapi/linux/batadv_packet.h     |  16 ++-
 net/batman-adv/bat_algo.c              |  10 ++
 net/batman-adv/bat_iv_ogm.c            | 166 ++++++++++++++++++++++++++++--
 net/batman-adv/bat_v.c                 |  52 ++++++++++
 net/batman-adv/bitarray.c              |   9 +-
 net/batman-adv/distributed-arp-table.c |  38 +++++++
 net/batman-adv/gateway_client.c        |   8 ++
 net/batman-adv/hard-interface.c        |  98 ++++++++++++++++++
 net/batman-adv/hash.c                  |   5 +-
 net/batman-adv/hash.h                  |  34 +++++--
 net/batman-adv/main.c                  |  36 ++++++-
 net/batman-adv/mesh-interface.c        |  63 ++++++++++++
 net/batman-adv/netlink.c               |   8 +-
 net/batman-adv/originator.c            |   7 ++
 net/batman-adv/routing.c               |  31 ++++++
 net/batman-adv/translation-table.c     | 179 ++++++++++++++++++++++++++++++++-
 16 files changed, 727 insertions(+), 33 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 1241285b..32436560 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -192,13 +192,19 @@ enum batadv_tvlv_type {
 };
 
 #pragma pack(2)
-/* the destination hardware field in the ARP frame is used to
- * transport the claim type and the group id
+/**
+ * struct batadv_bla_claim_dst - layout of the destination MAC of a BLA claim
+ *  frame
+ * @magic: fixed magic prefix (FF:43:05) identifying claim frames
+ * @type: claim frame type, see &enum batadv_bla_claimframe
+ * @group: group identifier of the announcing backbone gateway
+ *
+ * used in the destination hardware field of the ARP frame
  */
 struct batadv_bla_claim_dst {
-	__u8   magic[3];	/* FF:43:05 */
-	__u8   type;		/* bla_claimframe */
-	__be16 group;		/* group id */
+	__u8   magic[3];
+	__u8   type;
+	__be16 group;
 };
 
 /**
diff --git a/net/batman-adv/bat_algo.c b/net/batman-adv/bat_algo.c
index 49e5861b..a040141c 100644
--- a/net/batman-adv/bat_algo.c
+++ b/net/batman-adv/bat_algo.c
@@ -116,6 +116,16 @@ int batadv_algo_select(struct batadv_priv *bat_priv, const char *name)
 	return 0;
 }
 
+/**
+ * batadv_param_set_ra() - Validate and store routing_algo module parameter
+ * @val: new value for the routing_algo module parameter
+ * @kp: kernel parameter description used to store the value
+ *
+ * Check that the requested algorithm is known to batman-adv and then store
+ * the name as the new default routing algorithm.
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 static int batadv_param_set_ra(const char *val, const struct kernel_param *kp)
 {
 	struct batadv_algo_ops *bat_algo_ops;
diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 7588e64e..2b194553 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -171,6 +171,14 @@ batadv_iv_ogm_orig_get(struct batadv_priv *bat_priv, const u8 *addr)
 	return NULL;
 }
 
+/**
+ * batadv_iv_ogm_neigh_new() - retrieve or create a B.A.T.M.A.N. IV neighbour
+ * @hard_iface: the interface where the neighbour is connected to
+ * @neigh_addr: the mac address of the neighbour
+ * @orig_node: originator object representing the neighbour
+ *
+ * Return: pointer to the neigh_node or NULL in case of failure
+ */
 static struct batadv_neigh_node *
 batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 			const u8 *neigh_addr,
@@ -183,6 +191,14 @@ batadv_iv_ogm_neigh_new(struct batadv_hard_iface *hard_iface,
 	return neigh_node;
 }
 
+/**
+ * batadv_iv_ogm_iface_enable() - prepare an interface for B.A.T.M.A.N. IV
+ * @hard_iface: the interface to prepare
+ *
+ * Allocate and prepare the per-interface OGM buffer
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_ogm_packet *batadv_ogm_packet;
@@ -220,6 +236,14 @@ static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 	return 0;
 }
 
+/**
+ * batadv_iv_ogm_iface_disable() - release B.A.T.M.A.N. IV resources of an
+ *  interface
+ * @hard_iface: the interface which is shutting down
+ *
+ * Free the per-interface OGM buffer and cancel a possibly pending OGM
+ * rescheduling work.
+ */
 static void batadv_iv_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 {
 	mutex_lock(&hard_iface->bat_iv.ogm_buff_mutex);
@@ -233,6 +257,11 @@ static void batadv_iv_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 	disable_delayed_work_sync(&hard_iface->bat_iv.reschedule_work);
 }
 
+/**
+ * batadv_iv_ogm_iface_update_mac() - update the originator MAC stored in the
+ *  per-interface OGM buffer
+ * @hard_iface: the interface for which the OGM buffer should be updated
+ */
 static void batadv_iv_ogm_iface_update_mac(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_ogm_packet *batadv_ogm_packet;
@@ -254,6 +283,14 @@ static void batadv_iv_ogm_iface_update_mac(struct batadv_hard_iface *hard_iface)
 	mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
 }
 
+/**
+ * batadv_iv_ogm_primary_iface_set() - apply primary interface state to
+ *  a batadv_hard_iface
+ * @hard_iface: interface which just became the primary
+ *
+ * The primary interface uses the full TTL for its own OGMs, so adjust the TTL
+ * stored in the OGM template buffer accordingly.
+ */
 static void
 batadv_iv_ogm_primary_iface_set(struct batadv_hard_iface *hard_iface)
 {
@@ -273,7 +310,17 @@ batadv_iv_ogm_primary_iface_set(struct batadv_hard_iface *hard_iface)
 	mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
 }
 
-/* when do we schedule our own ogm to be sent */
+/**
+ * batadv_iv_ogm_emit_send_time() - calculate the jiffies when an own OGM
+ *  should be sent next
+ * @bat_priv: the bat priv with all the mesh interface information
+ *
+ * The next emission point is the configured orig_interval randomised by
+ * +/- BATADV_JITTER milliseconds to reduce chance of potential collisions
+ * between neighbours.
+ *
+ * Return: jiffies value when the next OGM should be transmitted
+ */
 static unsigned long
 batadv_iv_ogm_emit_send_time(const struct batadv_priv *bat_priv)
 {
@@ -285,13 +332,24 @@ batadv_iv_ogm_emit_send_time(const struct batadv_priv *bat_priv)
 	return jiffies + msecs_to_jiffies(msecs);
 }
 
-/* when do we schedule a ogm packet to be sent */
+/**
+ * batadv_iv_ogm_fwd_send_time() - calculate the jiffies when a forwarded OGM
+ *  should be sent next
+ *
+ * Return: jiffies value at which a forwarded OGM should be transmitted
+ */
 static unsigned long batadv_iv_ogm_fwd_send_time(void)
 {
 	return jiffies + msecs_to_jiffies(get_random_u32_below(BATADV_JITTER / 2));
 }
 
-/* apply hop penalty for a normal link */
+/**
+ * batadv_hop_penalty() - apply the configured hop penalty to a TQ value
+ * @tq: input TQ value to be reduced
+ * @bat_priv: the bat priv with all the mesh interface information
+ *
+ * Return: the TQ value after the hop penalty has been applied
+ */
 static u8 batadv_hop_penalty(u8 tq, const struct batadv_priv *bat_priv)
 {
 	int hop_penalty = READ_ONCE(bat_priv->hop_penalty);
@@ -328,7 +386,15 @@ batadv_iv_ogm_aggr_packet(int buff_pos, int packet_len,
 	return next_buff_pos <= packet_len;
 }
 
-/* send a batman ogm to a given interface */
+/**
+ * batadv_iv_ogm_send_to_if() - send a batman OGM to a given interface
+ * @forw_packet: forward packet containing the OGM(s) to be transmitted
+ * @hard_iface: interface to send the OGM out on
+ *
+ * Update the direct link flags of each aggregated OGM for the outgoing
+ * interface, log the transmission and finally hand a clone of the skb to the
+ * lower layer for broadcast.
+ */
 static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 				     struct batadv_hard_iface *hard_iface)
 {
@@ -392,7 +458,13 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 	}
 }
 
-/* send a batman ogm packet */
+/**
+ * batadv_iv_ogm_emit() - emit an (aggregated) OGM packet
+ * @forw_packet: forward packet which should be emitted
+ *
+ * The @forw_packet will be emitted but not consumed. When the interface is
+ * no longer active, the transmission will be skipped.
+ */
 static void batadv_iv_ogm_emit(struct batadv_forw_packet *forw_packet)
 {
 	struct net_device *mesh_iface;
@@ -603,7 +675,14 @@ static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	return true;
 }
 
-/* aggregate a new packet into the existing ogm packet */
+/**
+ * batadv_iv_ogm_aggregate() - append an OGM to an existing aggregated forward
+ *  packet
+ * @forw_packet_aggr: aggregated forward packet to extend
+ * @packet_buff: pointer to the OGM to append
+ * @packet_len: length of the OGM to append
+ * @direct_link: true if @packet_buff was received as a direct link OGM
+ */
 static void batadv_iv_ogm_aggregate(struct batadv_forw_packet *forw_packet_aggr,
 				    const unsigned char *packet_buff,
 				    int packet_len, bool direct_link)
@@ -699,6 +778,21 @@ static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 	}
 }
 
+/**
+ * batadv_iv_ogm_forward() - rebroadcast a received OGM
+ * @orig_node: originator that sent the OGM
+ * @ethhdr: ethernet header of the OGM packet
+ * @batadv_ogm_packet: OGM packet to be forwarded
+ * @is_single_hop_neigh: true if the OGM was received via a one-hop neighbour
+ * @is_from_best_next_hop: true if the sender is the currently selected best
+ *  next hop towards @orig_node
+ * @if_incoming: interface where the packet was received
+ * @if_outgoing: interface for which the retransmission should be considered
+ *
+ * Decrement the TTL, apply the hop penalty and queue the OGM for
+ * retransmission. OGMs that do not arrive over the best next hop are only
+ * forwarded for link-quality measurement reasons (and marked accordingly).
+ */
 static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 				  const struct ethhdr *ethhdr,
 				  struct batadv_ogm_packet *batadv_ogm_packet,
@@ -899,6 +993,13 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	batadv_hardif_put(primary_if);
 }
 
+/**
+ * batadv_iv_ogm_schedule() - schedule the next OGM transmission on an
+ *  interface
+ * @hard_iface: interface for which the next OGM should be scheduled
+ *
+ * Take the OGM buffer mutex and prepare the next OGM for transmission.
+ */
 static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 {
 	if (hard_iface->if_status == BATADV_IF_NOT_IN_USE ||
@@ -910,6 +1011,13 @@ static void batadv_iv_ogm_schedule(struct batadv_hard_iface *hard_iface)
 	mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
 }
 
+/**
+ * batadv_iv_ogm_reschedule() - work-queue helper to rerun batadv_iv_ogm_schedule()
+ * @work: work item embedded in the hard interface
+ *
+ * Invoked from the per-interface reschedule_work delayed work when the
+ * previous attempt to enqueue the own OGM failed.
+ */
 static void batadv_iv_ogm_reschedule(struct work_struct *work)
 {
 	struct delayed_work *delayed_work = to_delayed_work(work);
@@ -1766,6 +1874,14 @@ static void batadv_iv_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	batadv_orig_node_put(orig_node);
 }
 
+/**
+ * batadv_iv_send_outstanding_bat_ogm_packet() - work-queue helper to emit a
+ *  queued forward packet
+ * @work: work item embedded in the forward packet
+ *
+ * Emit the queued OGM forward packet and, for own primary-interface packets,
+ * schedule the next periodic OGM. The forward packet is freed afterwards.
+ */
 static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 {
 	struct delayed_work *delayed_work;
@@ -1804,6 +1920,17 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		batadv_forw_packet_free(forw_packet, dropped);
 }
 
+/**
+ * batadv_iv_ogm_receive() - receive a B.A.T.M.A.N. IV OGM packet
+ * @skb: skb containing the OGM packet
+ * @if_incoming: interface where the packet was received
+ *
+ * Validate the packet, then split the aggregated OGM packet into individual
+ * OGMs and hand each of them to batadv_iv_ogm_process(). Ownership of @skb is
+ * always taken over by this function.
+ *
+ * Return: NET_RX_SUCCESS or NET_RX_DROP
+ */
 static int batadv_iv_ogm_receive(struct sk_buff *skb,
 				 struct batadv_hard_iface *if_incoming)
 {
@@ -2311,6 +2438,12 @@ batadv_iv_ogm_neigh_is_sob(struct batadv_neigh_node *neigh1,
 	return ret;
 }
 
+/**
+ * batadv_iv_iface_enabled() - notification handler for activated interfaces
+ * @hard_iface: interface that was just activated
+ *
+ * Set up the per-interface reschedule work and start sending periodic OGMs.
+ */
 static void batadv_iv_iface_enabled(struct batadv_hard_iface *hard_iface)
 {
 	INIT_DELAYED_WORK(&hard_iface->bat_iv.reschedule_work, batadv_iv_ogm_reschedule);
@@ -2329,6 +2462,14 @@ static void batadv_iv_init_sel_class(struct batadv_priv *bat_priv)
 	WRITE_ONCE(bat_priv->gw.sel_class, 20);
 }
 
+/**
+ * batadv_iv_gw_get_best_gw_node() - retrieve the best gateway node based on
+ *  the B.A.T.M.A.N. IV metric and the configured GW selection class
+ * @bat_priv: the bat priv with all the mesh interface information
+ *
+ * Return: gateway node with the highest score for the current selection class,
+ *  or NULL if no eligible gateway exists.
+ */
 static struct batadv_gw_node *
 batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
@@ -2406,6 +2547,19 @@ batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 	return curr_gw;
 }
 
+/**
+ * batadv_iv_gw_is_eligible() - check whether a new gateway should replace the
+ *  currently selected one
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @curr_gw_orig: originator of the currently selected gateway
+ * @orig_node: originator of the gateway candidate
+ *
+ * Compare the TQ values of @curr_gw_orig and @orig_node, taking the configured
+ * gateway selection class into account.
+ *
+ * Return: true if @orig_node should take over as the active gateway, false
+ *  otherwise
+ */
 static bool batadv_iv_gw_is_eligible(struct batadv_priv *bat_priv,
 				     struct batadv_orig_node *curr_gw_orig,
 				     struct batadv_orig_node *orig_node)
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index fe7c0113..f9fe5193 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -41,6 +41,13 @@
 #include "netlink.h"
 #include "originator.h"
 
+/**
+ * batadv_v_iface_activate() - finalise the activation of a hard interface
+ * @hard_iface: interface to activate
+ *
+ * Reuse the currently selected primary interface to seed the ELP packet.
+ * Immediately activate the interface.
+ */
 static void batadv_v_iface_activate(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
@@ -61,6 +68,16 @@ static void batadv_v_iface_activate(struct batadv_hard_iface *hard_iface)
 		hard_iface->if_status = BATADV_IF_ACTIVE;
 }
 
+/**
+ * batadv_v_iface_enable() - enable the B.A.T.M.A.N. V protocol on an
+ *  interface
+ * @hard_iface: interface to enable
+ *
+ * Enable the ELP and OGM components for @hard_iface. On error, the partially
+ * enabled state is rolled back before returning.
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
 {
 	int ret;
@@ -76,12 +93,21 @@ static int batadv_v_iface_enable(struct batadv_hard_iface *hard_iface)
 	return ret;
 }
 
+/**
+ * batadv_v_iface_disable() - disable the B.A.T.M.A.N. V protocol on an
+ *  interface
+ * @hard_iface: interface to disable
+ */
 static void batadv_v_iface_disable(struct batadv_hard_iface *hard_iface)
 {
 	batadv_v_ogm_iface_disable(hard_iface);
 	batadv_v_elp_iface_disable(hard_iface);
 }
 
+/**
+ * batadv_v_primary_iface_set() - apply primary interface state
+ * @hard_iface: interface which just became the primary
+ */
 static void batadv_v_primary_iface_set(struct batadv_hard_iface *hard_iface)
 {
 	batadv_v_elp_primary_iface_set(hard_iface);
@@ -109,6 +135,11 @@ static void batadv_v_iface_update_mac(struct batadv_hard_iface *hard_iface)
 	batadv_hardif_put(primary_if);
 }
 
+/**
+ * batadv_v_hardif_neigh_init() - initialise the B.A.T.M.A.N. V state of a
+ *  hard interface neighbour
+ * @hardif_neigh: hard interface neighbour to initialise
+ */
 static void
 batadv_v_hardif_neigh_init(struct batadv_hardif_neigh_node *hardif_neigh)
 {
@@ -444,6 +475,16 @@ batadv_v_orig_dump(struct sk_buff *msg, struct netlink_callback *cb,
 	cb->args[2] = sub;
 }
 
+/**
+ * batadv_v_neigh_cmp() - compare two B.A.T.M.A.N. V neighbours by throughput
+ * @neigh1: first neighbour to compare
+ * @if_outgoing1: outgoing interface to use for @neigh1
+ * @neigh2: second neighbour to compare
+ * @if_outgoing2: outgoing interface to use for @neigh2
+ *
+ * Return: a positive value if @neigh1 is better, a negative value if @neigh2
+ *  is better and 0 if both have equal throughput
+ */
 static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
 			      struct batadv_hard_iface *if_outgoing1,
 			      struct batadv_neigh_node *neigh2,
@@ -469,6 +510,17 @@ static int batadv_v_neigh_cmp(struct batadv_neigh_node *neigh1,
 	return ret;
 }
 
+/**
+ * batadv_v_neigh_is_sob() - check whether two B.A.T.M.A.N. V neighbours have
+ *  a similar or better throughput
+ * @neigh1: first neighbour to compare
+ * @if_outgoing1: outgoing interface to use for @neigh1
+ * @neigh2: second neighbour to compare
+ * @if_outgoing2: outgoing interface to use for @neigh2
+ *
+ * Return: true if the throughput of @neigh2 is at least 3/4 of the
+ *  @neigh1 throughput
+ */
 static bool batadv_v_neigh_is_sob(struct batadv_neigh_node *neigh1,
 				  struct batadv_hard_iface *if_outgoing1,
 				  struct batadv_neigh_node *neigh2,
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 67cb3563..f814756d 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -11,7 +11,14 @@
 
 #include "log.h"
 
-/* shift the packet array by n places. */
+/**
+ * batadv_bitmap_shift_left() - shift the sequence number bitmap left
+ * @seq_bits: the sequence number bitmap to shift
+ * @n: number of positions to shift left
+ *
+ * Shift @seq_bits by @n positions. No-op if @n is not within the bounds of
+ * the bitmap.
+ */
 static void batadv_bitmap_shift_left(unsigned long *seq_bits, s32 n)
 {
 	if (n <= 0 || n >= BATADV_TQ_LOCAL_WINDOW_SIZE)
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index aaea155b..28eccfbb 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -50,27 +50,65 @@
 #include "translation-table.h"
 #include "tvlv.h"
 
+/**
+ * enum batadv_bootpop - BOOTP/DHCP message op codes
+ */
 enum batadv_bootpop {
+	/** @BATADV_BOOTREPLY: server-to-client reply */
 	BATADV_BOOTREPLY	= 2,
 };
 
+/**
+ * enum batadv_boothtype - BOOTP/DHCP hardware address types
+ */
 enum batadv_boothtype {
+	/** @BATADV_HTYPE_ETHERNET: Ethernet (10Mb) */
 	BATADV_HTYPE_ETHERNET	= 1,
 };
 
+/**
+ * enum batadv_dhcpoptioncode - DHCP option codes relevant for batman-adv DAT
+ */
 enum batadv_dhcpoptioncode {
+	/** @BATADV_DHCP_OPT_PAD: pad option */
 	BATADV_DHCP_OPT_PAD		= 0,
+
+	/** @BATADV_DHCP_OPT_MSG_TYPE: DHCP message type option */
 	BATADV_DHCP_OPT_MSG_TYPE	= 53,
+
+	/** @BATADV_DHCP_OPT_END: end of options marker */
 	BATADV_DHCP_OPT_END		= 255,
 };
 
+/**
+ * enum batadv_dhcptype - DHCP message types relevant for batman-adv DAT
+ */
 enum batadv_dhcptype {
+	/** @BATADV_DHCPACK: DHCPACK message */
 	BATADV_DHCPACK		= 5,
 };
 
 /* { 99, 130, 83, 99 } */
 #define BATADV_DHCP_MAGIC 1669485411
 
+/**
+ * struct batadv_dhcp_packet - BOOTP/DHCP packet header
+ * @op: message op code / message type
+ * @htype: hardware address type
+ * @hlen: hardware address length
+ * @hops: number of relay hops
+ * @xid: transaction identifier
+ * @secs: seconds elapsed since client started trying to boot
+ * @flags: BOOTP/DHCP flags
+ * @ciaddr: client IP address
+ * @yiaddr: "your" (client) IP address as assigned by the server
+ * @siaddr: IP address of next server to use in bootstrap
+ * @giaddr: relay agent IP address
+ * @chaddr: client hardware address
+ * @sname: optional server host name
+ * @file: boot file name
+ * @magic: BOOTP/DHCP magic cookie identifying the start of options
+ */
 struct batadv_dhcp_packet {
 	__u8 op;
 	__u8 htype;
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 305488a7..2c82c36e 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -125,6 +125,14 @@ batadv_gw_get_selected_orig(struct batadv_priv *bat_priv)
 	return orig_node;
 }
 
+/**
+ * batadv_gw_select() - select a new currently active gateway
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @new_gw_node: gateway node to be set as the current gateway, may be NULL
+ *
+ * Atomically replace the currently active gateway with @new_gw_node and drop
+ * the reference to the previous one.
+ */
 static void batadv_gw_select(struct batadv_priv *bat_priv,
 			     struct batadv_gw_node *new_gw_node)
 {
diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index 60cee2c2..f5683ead 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -196,6 +196,17 @@ static bool batadv_is_on_batman_iface(const struct net_device *net_dev)
 	return ret;
 }
 
+/**
+ * batadv_is_valid_iface() - check whether a net_device can be used as a hard
+ *  interface
+ * @net_dev: the net_device to check
+ *
+ * Refuse loopback devices, non-Ethernet devices, devices with a non-Ethernet
+ * address length and any device that is already part of a batman-adv mesh
+ * interface stack.
+ *
+ * Return: true if @net_dev can be used as a hard interface, false otherwise
+ */
 static bool batadv_is_valid_iface(const struct net_device *net_dev)
 {
 	if (net_dev->flags & IFF_LOOPBACK)
@@ -466,6 +477,14 @@ int batadv_hardif_no_broadcast(struct batadv_hard_iface *if_outgoing,
 	return ret;
 }
 
+/**
+ * batadv_hardif_get_active() - retrieve an active hard interface for a mesh
+ *  interface
+ * @mesh_iface: mesh interface to search
+ *
+ * Return: first hard interface in BATADV_IF_ACTIVE state attached to
+ *  @mesh_iface, or NULL if none is active.
+ */
 static struct batadv_hard_iface *
 batadv_hardif_get_active(struct net_device *mesh_iface)
 {
@@ -486,6 +505,15 @@ batadv_hardif_get_active(struct net_device *mesh_iface)
 	return hard_iface;
 }
 
+/**
+ * batadv_primary_if_update_addr() - propagate the new primary interface MAC
+ *  address to all dependent components
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @oldif: previously used primary interface, or NULL if none
+ *
+ * Inform DAT and BLA that the originator address has changed so they can
+ * adjust their state accordingly.
+ */
 static void batadv_primary_if_update_addr(struct batadv_priv *bat_priv,
 					  struct batadv_hard_iface *oldif)
 {
@@ -501,6 +529,15 @@ static void batadv_primary_if_update_addr(struct batadv_priv *bat_priv,
 	batadv_hardif_put(primary_if);
 }
 
+/**
+ * batadv_primary_if_select() - select the new primary interface
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @new_hard_iface: new primary interface, may be NULL
+ *
+ * Replace the currently selected primary interface with @new_hard_iface,
+ * invoke the algorithm-specific primary_set hook and update the originator
+ * MAC address.
+ */
 static void batadv_primary_if_select(struct batadv_priv *bat_priv,
 				     struct batadv_hard_iface *new_hard_iface)
 {
@@ -524,6 +561,13 @@ static void batadv_primary_if_select(struct batadv_priv *bat_priv,
 	batadv_hardif_put(curr_hard_iface);
 }
 
+/**
+ * batadv_hardif_is_iface_up() - check whether the underlying net_device of a
+ *  hard interface is up
+ * @hard_iface: the hard interface to check
+ *
+ * Return: true if the underlying net_device has the IFF_UP flag set
+ */
 static bool
 batadv_hardif_is_iface_up(const struct batadv_hard_iface *hard_iface)
 {
@@ -533,6 +577,15 @@ batadv_hardif_is_iface_up(const struct batadv_hard_iface *hard_iface)
 	return false;
 }
 
+/**
+ * batadv_check_known_mac_addr() - warn about duplicate hard interface MAC
+ *  addresses
+ * @hard_iface: hard interface that was just added or had its MAC changed
+ *
+ * Iterate over all hard interfaces of the same mesh interface and emit a
+ * warning if another in-use interface shares the same MAC address as
+ * @hard_iface.
+ */
 static void batadv_check_known_mac_addr(const struct batadv_hard_iface *hard_iface)
 {
 	struct net_device *mesh_iface = hard_iface->mesh_iface;
@@ -674,6 +727,15 @@ void batadv_update_min_mtu(struct net_device *mesh_iface)
 	batadv_tt_local_resize_to_mtu(mesh_iface);
 }
 
+/**
+ * batadv_hardif_activate_interface() - move a hard interface to the active
+ *  state
+ * @hard_iface: the interface that has come up
+ *
+ * Activate an interface, select it as the primary interface if no
+ * primary is currently active and invoke the algorithm-specific
+ * activate hook.
+ */
 static void
 batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 {
@@ -707,6 +769,14 @@ batadv_hardif_activate_interface(struct batadv_hard_iface *hard_iface)
 	batadv_hardif_put(primary_if);
 }
 
+/**
+ * batadv_hardif_deactivate_interface() - move a hard interface to the
+ *  inactive state
+ * @hard_iface: the interface that went down
+ *
+ * Demote @hard_iface to BATADV_IF_INACTIVE and recalculate the mesh minimum
+ * MTU based on the remaining active interfaces.
+ */
 static void
 batadv_hardif_deactivate_interface(struct batadv_hard_iface *hard_iface)
 {
@@ -889,6 +959,15 @@ void batadv_hardif_disable_interface(struct batadv_hard_iface *hard_iface)
 	batadv_hardif_put(primary_if);
 }
 
+/**
+ * batadv_hardif_add_interface() - allocate and register a new hard interface
+ * @net_dev: the underlying net_device for which a hard interface is created
+ *
+ * Allocate a batadv_hard_iface for @net_dev, initialise its state and add it
+ * to the global list of hard interfaces.
+ *
+ * Return: pointer to the newly created hard interface or NULL on error
+ */
 static struct batadv_hard_iface *
 batadv_hardif_add_interface(struct net_device *net_dev)
 {
@@ -931,6 +1010,13 @@ batadv_hardif_add_interface(struct net_device *net_dev)
 	return hard_iface;
 }
 
+/**
+ * batadv_hardif_remove_interface() - tear down and release a hard interface
+ * @hard_iface: the hard interface to remove
+ *
+ * Disable the interface (if still enslaved to a mesh interface), mark it for
+ * removal.
+ */
 static void batadv_hardif_remove_interface(struct batadv_hard_iface *hard_iface)
 {
 	ASSERT_RTNL();
@@ -1092,6 +1178,18 @@ static void batadv_wifi_net_device_event(unsigned long event,
 	}
 }
 
+/**
+ * batadv_hard_if_event() - netdevice notifier callback for hard interfaces
+ * @this: notifier block (unused)
+ * @event: the NETDEV_* event to handle
+ * @ptr: notifier info pointing to the affected net_device
+ *
+ * Dispatch netdevice events that affect potential or existing hard
+ * interfaces. Mesh interfaces are handled separately by
+ * batadv_hard_if_event_meshif().
+ *
+ * Return: NOTIFY_DONE
+ */
 static int batadv_hard_if_event(struct notifier_block *this,
 				unsigned long event, void *ptr)
 {
diff --git a/net/batman-adv/hash.c b/net/batman-adv/hash.c
index 759fa291..b9a652bd 100644
--- a/net/batman-adv/hash.c
+++ b/net/batman-adv/hash.c
@@ -11,7 +11,10 @@
 #include <linux/lockdep.h>
 #include <linux/slab.h>
 
-/* clears the hash */
+/**
+ * batadv_hash_init() - clear all buckets of a hashtable
+ * @hash: hashtable to clear
+ */
 static void batadv_hash_init(struct batadv_hashtable *hash)
 {
 	u32 i;
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index 86a2c200..debbbc93 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -18,21 +18,35 @@
 #include <linux/stddef.h>
 #include <linux/types.h>
 
-/* callback to a compare function.  should compare 2 element data for their
- * keys
+/**
+ * typedef batadv_hashdata_compare_cb - hash element comparison callback
+ * @node: hlist node of the element currently stored in the bucket
+ * @key: opaque payload to compare @node's key against
  *
- * Return: true if same and false if not same
+ * Compare hash element by its keys.
+ *
+ * Return: true if both elements are considered equal, false otherwise.
  */
-typedef bool (*batadv_hashdata_compare_cb)(const struct hlist_node *,
-					   const void *);
+typedef bool (*batadv_hashdata_compare_cb)(const struct hlist_node *node,
+					   const void *key);
 
-/* the hashfunction
+/**
+ * typedef batadv_hashdata_choose_cb - hash bucket selection callback
+ * @key: opaque payload whose key selects the bucket
+ * @size: number of buckets in the hash table
  *
- * Return: an index based on the key in the data of the first argument and the
- * size the second
+ * Return: bucket index derived from the key in @data and the table @size.
  */
-typedef u32 (*batadv_hashdata_choose_cb)(const void *, u32);
-typedef void (*batadv_hashdata_free_cb)(struct hlist_node *, void *);
+typedef u32 (*batadv_hashdata_choose_cb)(const void *key, u32 size);
+
+/**
+ * typedef batadv_hashdata_free_cb - hash element free callback
+ * @node: hlist node of the element being removed
+ * @arg: opaque caller-supplied argument forwarded from the caller
+ *
+ * Release a previously inserted hash element.
+ */
+typedef void (*batadv_hashdata_free_cb)(struct hlist_node *node, void *arg);
 
 /**
  * struct batadv_hashtable - Wrapper of simple hlist based hashtable
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 3c457228..50b61352 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -87,6 +87,14 @@ static char *batadv_uev_type_str[] = {
 	"bla",
 };
 
+/**
+ * batadv_init() - batman-adv module init function
+ *
+ * Initialise the global state used by all mesh interfaces, register the
+ * netdevice notifier and the netlink/rtnl family.
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 static int __init batadv_init(void)
 {
 	int ret;
@@ -134,6 +142,12 @@ static int __init batadv_init(void)
 	return ret;
 }
 
+/**
+ * batadv_exit() - batman-adv module exit function
+ *
+ * Unregister the netdevice notifier and tear down all global state allocated
+ * by batadv_init().
+ */
 static void __exit batadv_exit(void)
 {
 	batadv_netlink_unregister();
@@ -396,6 +410,17 @@ void batadv_skb_set_priority(struct sk_buff *skb, int offset)
 	skb->priority = prio + 256;
 }
 
+/**
+ * batadv_recv_unhandled_packet() - default RX handler for unsupported packet
+ *  types
+ * @skb: incoming packet
+ * @recv_if: interface on which the packet was received (unused)
+ *
+ * Drop incoming packets whose packet_type has no dedicated RX handler
+ * registered.
+ *
+ * Return: NET_RX_DROP
+ */
 static int batadv_recv_unhandled_packet(struct sk_buff *skb,
 					struct batadv_hard_iface *recv_if)
 {
@@ -404,10 +429,6 @@ static int batadv_recv_unhandled_packet(struct sk_buff *skb,
 	return NET_RX_DROP;
 }
 
-/* incoming packets with the batman ethertype received on any active hard
- * interface
- */
-
 /**
  * batadv_batman_skb_recv() - Handle incoming message from an hard interface
  * @skb: the received packet
@@ -493,6 +514,13 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	return NET_RX_DROP;
 }
 
+/**
+ * batadv_recv_handler_init() - initialise the RX handler dispatch table
+ *
+ * Initialise all entries of the RX handler table (+ unused to the
+ * default drop handler) and perform compile-time size sanity checks on
+ * all on-wire packet structs.
+ */
 static void batadv_recv_handler_init(void)
 {
 	int i;
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index e5a55d24..3e735c7c 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -98,6 +98,15 @@ static u64 batadv_sum_counter(struct batadv_priv *bat_priv,  size_t idx)
 	return sum;
 }
 
+/**
+ * batadv_interface_stats() - return netdev stats for a mesh interface
+ * @dev: the mesh interface to query
+ *
+ * Aggregate the per-CPU traffic counters into the standard netdev stats
+ * structure.
+ *
+ * Return: pointer to the populated net_device_stats structure
+ */
 static struct net_device_stats *batadv_interface_stats(struct net_device *dev)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
@@ -111,6 +120,18 @@ static struct net_device_stats *batadv_interface_stats(struct net_device *dev)
 	return stats;
 }
 
+/**
+ * batadv_interface_set_mac_addr() - change the MAC address of a mesh
+ *  interface
+ * @dev: the mesh interface to modify
+ * @p: pointer to a struct sockaddr holding the new MAC address
+ *
+ * Replace the MAC address of the mesh interface. If the mesh is already
+ * active, also update the local translation table entries for all configured
+ * VLANs so that the new MAC is announced and the old one is removed.
+ *
+ * Return: 0 on success or negative error number in case of failure
+ */
 static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
@@ -140,6 +161,16 @@ static int batadv_interface_set_mac_addr(struct net_device *dev, void *p)
 	return 0;
 }
 
+/**
+ * batadv_interface_change_mtu() - change the MTU of a mesh interface
+ * @dev: the mesh interface to modify
+ * @new_mtu: requested new MTU value
+ *
+ * Validate that @new_mtu fits within the range supported by the configured
+ * hard interfaces and remember it as the user-configured MTU.
+ *
+ * Return: 0 on success or -EINVAL if @new_mtu is out of range
+ */
 static int batadv_interface_change_mtu(struct net_device *dev, int new_mtu)
 {
 	struct batadv_priv *bat_priv = netdev_priv(dev);
@@ -166,6 +197,13 @@ static void batadv_interface_set_rx_mode(struct net_device *dev)
 {
 }
 
+/**
+ * batadv_interface_tx() - transmit a frame on a mesh interface
+ * @skb: the frame to send
+ * @mesh_iface: the mesh interface the frame was queued on
+ *
+ * Return: NETDEV_TX_OK on success
+ */
 static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 				       struct net_device *mesh_iface)
 {
@@ -890,6 +928,11 @@ static const struct net_device_ops batadv_netdev_ops = {
 	.ndo_del_slave = batadv_meshif_slave_del,
 };
 
+/**
+ * batadv_get_drvinfo() - ethtool driver info handler for mesh interfaces
+ * @dev: the mesh interface (unused)
+ * @info: ethtool_drvinfo struct to populate
+ */
 static void batadv_get_drvinfo(struct net_device *dev,
 			       struct ethtool_drvinfo *info)
 {
@@ -950,6 +993,12 @@ static const struct {
 #endif
 };
 
+/**
+ * batadv_get_strings() - ethtool string handler for mesh interfaces
+ * @dev: the mesh interface (unused)
+ * @stringset: ethtool string set to retrieve
+ * @data: buffer to copy the requested string set into
+ */
 static void batadv_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 {
 	if (stringset == ETH_SS_STATS)
@@ -957,6 +1006,12 @@ static void batadv_get_strings(struct net_device *dev, u32 stringset, u8 *data)
 		       sizeof(batadv_counters_strings));
 }
 
+/**
+ * batadv_get_ethtool_stats() - ethtool stats handler for mesh interfaces
+ * @dev: the mesh interface to query
+ * @stats: ethtool_stats struct (unused)
+ * @data: destination array for the gathered counter values
+ */
 static void batadv_get_ethtool_stats(struct net_device *dev,
 				     struct ethtool_stats *stats, u64 *data)
 {
@@ -967,6 +1022,14 @@ static void batadv_get_ethtool_stats(struct net_device *dev,
 		data[i] = batadv_sum_counter(bat_priv, i);
 }
 
+/**
+ * batadv_get_sset_count() - ethtool stringset size handler for mesh interfaces
+ * @dev: the mesh interface (unused)
+ * @stringset: ethtool string set to query
+ *
+ * Return: number of entries in @stringset or -EOPNOTSUPP if @stringset is not
+ *  supported
+ */
 static int batadv_get_sset_count(struct net_device *dev, int stringset)
 {
 	if (stringset == ETH_SS_STATS)
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index e3d47f3e..794ed825 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -52,9 +52,15 @@
 
 struct genl_family batadv_netlink_family;
 
-/* multicast groups */
+/**
+ * enum batadv_netlink_multicast_groups - batman-adv generic netlink multicast
+ *  groups
+ */
 enum batadv_netlink_multicast_groups {
+	/** @BATADV_NL_MCGRP_CONFIG: configuration change notifications */
 	BATADV_NL_MCGRP_CONFIG,
+
+	/** @BATADV_NL_MCGRP_TPMETER: throughput meter result notifications */
 	BATADV_NL_MCGRP_TPMETER,
 };
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 9b38bd9e..a5d00864 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -1299,6 +1299,13 @@ void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 	batadv_gw_election(bat_priv);
 }
 
+/**
+ * batadv_purge_orig() - periodic worker to purge stale originator entries
+ * @work: delayed work embedded in the bat_priv
+ *
+ * Invoke batadv_purge_orig_ref() to drop stale originators and reschedule the
+ * next run after BATADV_ORIG_WORK_PERIOD milliseconds.
+ */
 static void batadv_purge_orig(struct work_struct *work)
 {
 	struct delayed_work *delayed_work;
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index cd4368b8..e0cd05e5 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -274,6 +274,16 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 	return ret;
 }
 
+/**
+ * batadv_recv_icmp_ttl_exceeded() - handle an ICMP packet that hit TTL 0
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @skb: ICMP packet whose TTL has expired
+ *
+ * For traceroute-style ICMP echo requests, send a TTL exceeded reply back to
+ * the source. Other ICMP types are simply dropped.
+ *
+ * Return: NET_XMIT_SUCCESS if the reply was queued, NET_RX_DROP otherwise
+ */
 static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
 {
@@ -652,6 +662,18 @@ batadv_find_router(struct batadv_priv *bat_priv,
 	return router;
 }
 
+/**
+ * batadv_route_unicast_packet() - forward a unicast packet towards its
+ *  destination originator
+ * @skb: the received unicast packet
+ * @recv_if: interface on which the packet was received
+ *
+ * Decrement the TTL, look up the originator for the destination address and
+ * hand the packet over to batadv_send_skb_to_orig() for transmission. Drop
+ * the packet when the TTL is exhausted or no route exists.
+ *
+ * Return: NET_RX_SUCCESS if the packet was forwarded, NET_RX_DROP otherwise
+ */
 static int batadv_route_unicast_packet(struct sk_buff *skb,
 				       struct batadv_hard_iface *recv_if)
 {
@@ -782,6 +804,15 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	return ret;
 }
 
+/**
+ * batadv_check_unicast_ttvn() - check and adjust the TTVN of a unicast packet
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @skb: the unicast packet to check
+ * @hdr_len: length of the unicast header preceding the payload
+ *
+ * Return: true if the packet may be processed further, false if it has been
+ *  consumed or has to be dropped by the caller
+ */
 static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 				      struct sk_buff *skb, int hdr_len)
 {
diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 884bb0c0..f8a8cfc2 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -572,6 +572,12 @@ static int batadv_tt_local_table_transmit_size(struct batadv_priv *bat_priv)
 	return hdr_size + batadv_tt_len(tt_local_entries);
 }
 
+/**
+ * batadv_tt_local_init() - allocate and initialise the local translation table
+ * @bat_priv: the bat priv with all the mesh interface information
+ *
+ * Return: 0 on success or -ENOMEM in case of allocation failure
+ */
 static int batadv_tt_local_init(struct batadv_priv *bat_priv)
 {
 	if (bat_priv->tt.local_hash)
@@ -588,6 +594,15 @@ static int batadv_tt_local_init(struct batadv_priv *bat_priv)
 	return 0;
 }
 
+/**
+ * batadv_tt_global_free() - drop a global translation table entry
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_global: the global TT entry to remove
+ * @message: debug message explaining why the entry is being removed
+ *
+ * Remove @tt_global from the global TT hash and drop the reference held by
+ * the hash.
+ */
 static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 				  struct batadv_tt_global_entry *tt_global,
 				  const char *message)
@@ -1261,6 +1276,17 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 	return ret;
 }
 
+/**
+ * batadv_tt_local_set_pending() - mark a local TT entry as pending removal
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local_entry: local TT entry to mark
+ * @flags: TT change flags to announce together with the pending removal
+ * @message: debug message describing the reason for the change
+ *
+ * Schedule the TT change announcement and set BATADV_TT_CLIENT_PENDING on the
+ * entry. The entry is kept in the local table until the next TTVN increment
+ * so that a consistency-check response can still be answered.
+ */
 static void
 batadv_tt_local_set_pending(struct batadv_priv *bat_priv,
 			    struct batadv_tt_local_entry *tt_local_entry,
@@ -1404,6 +1430,13 @@ static void batadv_tt_local_purge(struct batadv_priv *bat_priv,
 	}
 }
 
+/**
+ * batadv_tt_local_table_free() - release the local translation table
+ * @bat_priv: the bat priv with all the mesh interface information
+ *
+ * Drop every entry of the local TT hash, free their references and finally
+ * release the hashtable itself.
+ */
 static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash;
@@ -1441,6 +1474,13 @@ static void batadv_tt_local_table_free(struct batadv_priv *bat_priv)
 	bat_priv->tt.local_hash = NULL;
 }
 
+/**
+ * batadv_tt_global_init() - allocate and initialise the global translation
+ *  table
+ * @bat_priv: the bat priv with all the mesh interface information
+ *
+ * Return: 0 on success or -ENOMEM in case of allocation failure
+ */
 static int batadv_tt_global_init(struct batadv_priv *bat_priv)
 {
 	if (bat_priv->tt.global_hash)
@@ -1457,6 +1497,12 @@ static int batadv_tt_global_init(struct batadv_priv *bat_priv)
 	return 0;
 }
 
+/**
+ * batadv_tt_changes_list_free() - drop all pending local TT changes
+ * @bat_priv: the bat priv with all the mesh interface information
+ *
+ * Discard every queued local TT change and reset the pending change counter.
+ */
 static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_tt_change_node *entry, *safe;
@@ -2061,7 +2107,11 @@ _batadv_tt_global_del_orig_entry(struct batadv_tt_global_entry *tt_global_entry,
 	batadv_tt_orig_list_entry_put(orig_entry);
 }
 
-/* deletes the orig list of a tt_global_entry */
+/**
+ * batadv_tt_global_del_orig_list() - drop every orig_list_entry of a global
+ *  TT entry
+ * @tt_global_entry: the global TT entry to clear
+ */
 static void
 batadv_tt_global_del_orig_list(struct batadv_tt_global_entry *tt_global_entry)
 {
@@ -2114,9 +2164,17 @@ batadv_tt_global_del_orig_node(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&tt_global_entry->list_lock);
 }
 
-/* If the client is to be deleted, we check if it is the last origantor entry
- * within tt_global entry. If yes, we set the BATADV_TT_CLIENT_ROAM flag and the
- * timer, otherwise we simply remove the originator scheduled for deletion.
+/**
+ * batadv_tt_global_del_roaming() - remove a roaming client from a global TT
+ *  entry
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_global_entry: the global TT entry of the roaming client
+ * @orig_node: the originator that the client has roamed away from
+ * @message: debug message describing the reason for the change
+ *
+ * If @orig_node was the last announced source for the client, mark the entry
+ * for roaming so it can be cleaned up after the roaming timer expires.
+ * Otherwise simply remove the orig_node entry from the announcer list.
  */
 static void
 batadv_tt_global_del_roaming(struct batadv_priv *bat_priv,
@@ -2278,6 +2336,15 @@ void batadv_tt_global_del_orig(struct batadv_priv *bat_priv,
 	clear_bit(BATADV_ORIG_CAPA_HAS_TT, &orig_node->capa_initialized);
 }
 
+/**
+ * batadv_tt_global_to_purge() - check whether a global TT entry has to be
+ *  purged
+ * @tt_global: global TT entry under consideration
+ * @msg: storage for a pointer to a human readable reason on return
+ *
+ * Return: true if the entry should be purged because its roaming or temporary
+ *  timer has elapsed; false otherwise
+ */
 static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
 				      char **msg)
 {
@@ -2300,6 +2367,13 @@ static bool batadv_tt_global_to_purge(struct batadv_tt_global_entry *tt_global,
 	return purge;
 }
 
+/**
+ * batadv_tt_global_purge() - purge expired global translation table entries
+ * @bat_priv: the bat priv with all the mesh interface information
+ *
+ * Iterate over the global translation table and drop every entry that the
+ * roaming or temporary timer has expired for.
+ */
 static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt.global_hash;
@@ -2339,6 +2413,13 @@ static void batadv_tt_global_purge(struct batadv_priv *bat_priv)
 	}
 }
 
+/**
+ * batadv_tt_global_table_free() - release the global translation table
+ * @bat_priv: the bat priv with all the mesh interface information
+ *
+ * Drop every entry of the global TT hash, free their references and finally
+ * release the hashtable itself.
+ */
 static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash;
@@ -2375,6 +2456,16 @@ static void batadv_tt_global_table_free(struct batadv_priv *bat_priv)
 	bat_priv->tt.global_hash = NULL;
 }
 
+/**
+ * _batadv_is_ap_isolated() - check whether two clients are AP-isolated from
+ *  each other
+ * @tt_local_entry: local TT entry of the sending client
+ * @tt_global_entry: global TT entry of the destination client
+ *
+ * Return: true if traffic between the two clients should be dropped because
+ *  either both are WiFi clients or both carry the ISOLATION flag; false
+ *  otherwise
+ */
 static bool
 _batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
 		       struct batadv_tt_global_entry *tt_global_entry)
@@ -2627,6 +2718,10 @@ static void batadv_tt_req_node_put(struct batadv_tt_req_node *tt_req_node)
 	kref_put(&tt_req_node->refcount, batadv_tt_req_node_release);
 }
 
+/**
+ * batadv_tt_req_list_free() - drop all pending TT requests
+ * @bat_priv: the bat priv with all the mesh interface information
+ */
 static void batadv_tt_req_list_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_tt_req_node *node;
@@ -2642,6 +2737,18 @@ static void batadv_tt_req_list_free(struct batadv_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt.req_list_lock);
 }
 
+/**
+ * batadv_tt_save_orig_buffer() - cache the latest TT TVLV payload of an
+ *  originator
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @orig_node: originator for which the buffer should be created
+ * @tt_buff: pointer to the TT TVLV payload to cache
+ * @tt_buff_len: length of @tt_buff in bytes
+ *
+ * Replace the previously cached TT payload of @orig_node with a copy of
+ * @tt_buff. The buffer is left untouched when @tt_buff_len is 0 so that
+ * empty OGM updates do not discard the previously cached data.
+ */
 static void batadv_tt_save_orig_buffer(struct batadv_priv *bat_priv,
 				       struct batadv_orig_node *orig_node,
 				       const void *tt_buff,
@@ -2663,6 +2770,10 @@ static void batadv_tt_save_orig_buffer(struct batadv_priv *bat_priv,
 	spin_unlock_bh(&orig_node->tt_buff_lock);
 }
 
+/**
+ * batadv_tt_req_purge() - drop timed-out TT requests
+ * @bat_priv: the bat priv with all the mesh interface information
+ */
 static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
 {
 	struct batadv_tt_req_node *node;
@@ -3290,6 +3401,18 @@ static bool batadv_send_tt_response(struct batadv_priv *bat_priv,
 					     req_dst);
 }
 
+/**
+ * _batadv_tt_update_changes() - apply a list of TT changes to the global TT
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @orig_node: originator announcing the changes
+ * @tt_change: array of TT change entries to apply
+ * @tt_num_changes: number of entries in @tt_change
+ * @ttvn: TTVN of @orig_node corresponding to @tt_change
+ *
+ * Walk @tt_change and add/remove the announced clients in the global TT.
+ * Abort early without marking the TTVN as up to date if adding an entry
+ * fails, so that the next TT request can re-sync the full table.
+ */
 static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 				      struct batadv_orig_node *orig_node,
 				      struct batadv_tvlv_tt_change *tt_change,
@@ -3323,6 +3446,18 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 	set_bit(BATADV_ORIG_CAPA_HAS_TT, &orig_node->capa_initialized);
 }
 
+/**
+ * batadv_tt_fill_gtable() - replace the cached TT of an originator with a
+ *  full table response
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_change: array of TT change entries describing the full table
+ * @ttvn: TTVN announced together with the full table
+ * @resp_src: MAC address of the responder
+ * @num_entries: number of entries in @tt_change
+ *
+ * Drop the previously known global TT entries of @resp_src and replace them
+ * with the entries from a freshly received full TT response.
+ */
 static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 				  struct batadv_tvlv_tt_change *tt_change,
 				  u8 ttvn, u8 *resp_src,
@@ -3353,6 +3488,17 @@ static void batadv_tt_fill_gtable(struct batadv_priv *bat_priv,
 	batadv_orig_node_put(orig_node);
 }
 
+/**
+ * batadv_tt_update_changes() - apply an incremental TT changeset to the
+ *  global TT
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @orig_node: originator announcing the changes
+ * @tt_num_changes: number of entries in @tt_change
+ * @ttvn: TTVN of @orig_node corresponding to @tt_change
+ * @tt_change: array of TT change entries to apply
+ *
+ * Apply the announced changes to the global TT,\
+ */
 static void batadv_tt_update_changes(struct batadv_priv *bat_priv,
 				     struct batadv_orig_node *orig_node,
 				     u16 tt_num_changes, u8 ttvn,
@@ -3453,6 +3599,10 @@ static void batadv_handle_tt_response(struct batadv_priv *bat_priv,
 	batadv_orig_node_put(orig_node);
 }
 
+/**
+ * batadv_tt_roam_list_free() - drop all entries from the roaming clients list
+ * @bat_priv: the bat priv with all the mesh interface information
+ */
 static void batadv_tt_roam_list_free(struct batadv_priv *bat_priv)
 {
 	struct batadv_tt_roam_node *node, *safe;
@@ -3467,6 +3617,10 @@ static void batadv_tt_roam_list_free(struct batadv_priv *bat_priv)
 	spin_unlock_bh(&bat_priv->tt.roam_list_lock);
 }
 
+/**
+ * batadv_tt_roam_purge() - drop timed-out roaming clients
+ * @bat_priv: the bat priv with all the mesh interface information
+ */
 static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
 {
 	struct batadv_tt_roam_node *node, *safe;
@@ -3584,6 +3738,14 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
 	batadv_hardif_put(primary_if);
 }
 
+/**
+ * batadv_tt_purge() - periodic worker to maintain the translation table
+ * @work: delayed work embedded in the per-mesh-interface TT state
+ *
+ * Purge timed-out entries from the local and global TT, drop stale TT
+ * requests and roaming clients, and reschedule the next run after
+ * BATADV_TT_WORK_PERIOD milliseconds.
+ */
 static void batadv_tt_purge(struct work_struct *work)
 {
 	struct delayed_work *delayed_work;
@@ -3670,7 +3832,14 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 	}
 }
 
-/* Purge out all the tt local entries marked with BATADV_TT_CLIENT_PENDING */
+/**
+ * batadv_tt_local_purge_pending_clients() - finalise removal of pending local
+ *  clients
+ * @bat_priv: the bat priv with all the mesh interface information
+ *
+ * Iterate over the local TT and physically remove every entry that has been
+ * marked as BATADV_TT_CLIENT_PENDING.
+ */
 static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;

---
base-commit: 385b248dd4e46c4ce022adeb1b13e547d1954901
change-id: 20260608-kernel-doc-272b4d5e2830

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

