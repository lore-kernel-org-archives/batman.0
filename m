Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E070DCD6E74
	for <batman-adv@archiver.kernel.org>; Fri,  5 Jun 2026 07:28:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8B9C984790
	for <batman-adv@archiver.kernel.org>; Fri, 05 Jun 2026 09:28:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780644519;
 b=eydc8+O3WNNTUREZliJx07qlem0ifbgjZwjNRttDlQhqN9lFsWHdRB83FUTLIFGGQtm/j
 NyFphgQCE5h9euNrEKul9nu4A72DH1y63qcH8utNc6rx0X9NzItKtSKDZJ+PgITxUPSg87c
 y3IIlI9JN29wKNYz1hBwiX72LKH1Pa4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780644519; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=l6ymu5WtKNXPSHwu5QBSvWS8PabPHSE8dRLENSvCWqE=;
 b=DqxFk1rHNO40PNJwQYY46ppJW6icd+xfkSCua02Un92wNCxYhdBHi60o3kLFMuvWl7J+o
 xNOU/g3s2/lnYWQHZVyxa3iVe668cFLHKpI3cTjEsvvHw0/jbj39VIP8A8EOT2bnR6pb63M
 1xe2Df5vbm6nIye70vVVHav5GqosGGU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 62885810FF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 05 Jun 2026 09:20:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780644020;
	b=kujrMSXMCGffK+U/Yj8SbRbDnC6kq3pAycW5iDmiekCvEoy2Z7hM1QjDZbfiUog1OFK8jX
	+ICavFUHPg1GSUUTPekgXM0b/tzCFAvqZ9Dr9gIjT6Z/6tpq5myax5dbKba3F7q6RWeigu
	CLrc6QsORLNa7umoz1+SRhgPlCArWoY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=JAfYZRRY;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780644020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=l6ymu5WtKNXPSHwu5QBSvWS8PabPHSE8dRLENSvCWqE=;
	b=Qr22kKE/8wWrRMG97hyWcKYGbCZElt8PkdTR8NW+biJjANN4dR6mWRDSwgPL37dApdQ+Kl
	1r8/mzUC+YLIdDB/zQ4GU8Eoi5mvBRjMYHWCTzvHhSIlYdkUxBtym9tKzNkXHIBPpgva5p
	NAMDg89+YmAe1l78fhjV7sb8p6aPy0k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l6ymu5WtKNXPSHwu5QBSvWS8PabPHSE8dRLENSvCWqE=;
	b=JAfYZRRYAD1mcR1rKlpgYhn08nHSD4uQ9zqI6wv8cS0bJiSPa8SfPJNTtdxDSC0Sj7H+bc
	6VWVJFQOisCRGVIFX3N2CLnXY/kT0wU9a+RYOM3l2TTUW+cLHgyVOWTOr5ISI8cUwrkePt
	zfU3qrRRJSaTEKkygVUxzbkgpuxugtD6IetHMgM4g0+nv4/o848+iAyTsinRFUcW9asN3C
	yqNulUJD9FYOX9Curyh41WI3xKMVg0sid/JTT4FoIfsD5P/WI3/XFRztgbrvA0GzHQ7FpB
	G1tD7fmi/h+kqENjkvg2XlAk1aczDG1ovi8XTBvte0w1RRcqLgT031S7uLu1Rg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 11/11] batman-adv: fix kernel-doc typos and grammar
 errors
Date: Fri,  5 Jun 2026 09:20:05 +0200
Message-ID: <20260605072005.490368-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CEFP6N33IBJEWIUVCFQ6IH2AHOIS5WMC
X-Message-ID-Hash: CEFP6N33IBJEWIUVCFQ6IH2AHOIS5WMC
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CEFP6N33IBJEWIUVCFQ6IH2AHOIS5WMC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Various minor errors were gathered over the time in batman-adv's kernel-doc
comments. Get rid of many of them before they are copied (again) to new
functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v.c          | 2 +-
 net/batman-adv/bat_v_ogm.c      | 8 ++++----
 net/batman-adv/bitarray.c       | 2 +-
 net/batman-adv/bitarray.h       | 2 +-
 net/batman-adv/fragmentation.c  | 3 ++-
 net/batman-adv/hash.h           | 4 ++--
 net/batman-adv/mesh-interface.c | 6 +++---
 net/batman-adv/netlink.c        | 4 ++--
 net/batman-adv/originator.c     | 4 ++--
 net/batman-adv/tvlv.c           | 4 ++--
 10 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index cb081038d14f5..fe7c0113d0df3 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -587,7 +587,7 @@ batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_v_gw_is_eligible() - check if a originator would be selected as GW
+ * batadv_v_gw_is_eligible() - check if an originator would be selected as GW
  * @bat_priv: the bat priv with all the mesh interface information
  * @curr_gw_orig: originator representing the currently selected GW
  * @orig_node: the originator representing the new candidate
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 14920f4bb315b..81926ef9c02c9 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -515,7 +515,7 @@ static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @ogm_received: previously received OGM to be forwarded
  * @orig_node: the originator which has been updated
- * @neigh_node: the neigh_node through with the OGM has been received
+ * @neigh_node: the neigh_node through which the OGM has been received
  * @if_incoming: the interface on which this OGM was received on
  * @if_outgoing: the interface to which the OGM has to be forwarded to
  *
@@ -602,7 +602,7 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @ogm2: OGM2 structure
  * @orig_node: Originator structure for which the OGM has been received
- * @neigh_node: the neigh_node through with the OGM has been received
+ * @neigh_node: the neigh_node through which the OGM has been received
  * @if_incoming: the interface where this packet was received
  * @if_outgoing: the interface for which the packet should be considered
  *
@@ -686,7 +686,7 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
  * @ethhdr: the Ethernet header of the OGM2
  * @ogm2: OGM2 structure
  * @orig_node: Originator structure for which the OGM has been received
- * @neigh_node: the neigh_node through with the OGM has been received
+ * @neigh_node: the neigh_node through which the OGM has been received
  * @if_incoming: the interface where this packet was received
  * @if_outgoing: the interface for which the packet should be considered
  *
@@ -781,7 +781,7 @@ static bool batadv_v_ogm_route_update(struct batadv_priv *bat_priv,
  * @ethhdr: the Ethernet header of the OGM2
  * @ogm2: OGM2 structure
  * @orig_node: Originator structure for which the OGM has been received
- * @neigh_node: the neigh_node through with the OGM has been received
+ * @neigh_node: the neigh_node through which the OGM has been received
  * @if_incoming: the interface where this packet was received
  * @if_outgoing: the interface for which the packet should be considered
  */
diff --git a/net/batman-adv/bitarray.c b/net/batman-adv/bitarray.c
index 2c49b27116503..67cb356332bf1 100644
--- a/net/batman-adv/bitarray.c
+++ b/net/batman-adv/bitarray.c
@@ -24,7 +24,7 @@ static void batadv_bitmap_shift_left(unsigned long *seq_bits, s32 n)
  * batadv_bit_get_packet() - receive and process one packet within the sequence
  *  number window
  * @priv: the bat priv with all the mesh interface information
- * @seq_bits: pointer to the sequence number receive packet
+ * @seq_bits: pointer to the sequence number bitmap of received packets
  * @seq_num_diff: difference between the current/received sequence number and
  *  the last sequence number
  * @set_mark: whether this packet should be marked in seq_bits
diff --git a/net/batman-adv/bitarray.h b/net/batman-adv/bitarray.h
index 37f7ae413bc66..2b9f5dbb3ec41 100644
--- a/net/batman-adv/bitarray.h
+++ b/net/batman-adv/bitarray.h
@@ -17,7 +17,7 @@
 /**
  * batadv_test_bit() - check if bit is set in the current window
  *
- * @seq_bits: pointer to the sequence number receive packet
+ * @seq_bits: pointer to the sequence number bitmap of received packets
  * @last_seqno: latest sequence number in seq_bits
  * @curr_seqno: sequence number to test for
  *
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 14ccf7811bf62..1e42cf99f8b33 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -309,7 +309,8 @@ batadv_frag_merge_packets(struct hlist_head *chain)
  * batadv_skb_is_frag() - check if newly merged skb contains unicast fragment
  * @skb: newly merged skb
  *
- * Return: if newly merged skb is of type BATADV_UNICAST_FRAG
+ * Return: true if the newly merged skb is of type BATADV_UNICAST_FRAG, false
+ *  otherwise
  */
 static bool batadv_skb_is_frag(struct sk_buff *skb)
 {
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index fb251c385a1bb..86a2c20000dcf 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -120,10 +120,10 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
  * @choose: callback calculating the hash index
  * @data: data passed to the aforementioned callbacks as argument
  *
- * ata could be the structure you use with  just the key filled, we just need
+ * data could be the structure you use with just the key filled, we just need
  * the key for comparing.
  *
- * Return: returns pointer do data on success, so you can remove the used
+ * Return: returns pointer to data on success, so you can remove the used
  * structure yourself, or NULL on error
  */
 static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index b6797654b18ab..44026810b99ce 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -392,13 +392,13 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
  * @orig_node: originator from which the batman-adv packet was sent
  *
  * Sends an ethernet frame to the receive path of the local @mesh_iface.
- * skb->data has still point to the batman-adv header with the size @hdr_size.
+ * skb->data must still point to the batman-adv header with the size @hdr_size.
  * The caller has to have parsed this header already and made sure that at least
  * @hdr_size bytes are still available for pull in @skb.
  *
  * The packet may still get dropped. This can happen when the encapsulated
- * ethernet frame is invalid or contains again an batman-adv packet. Also
- * unicast packets will be dropped directly when it was sent between two
+ * ethernet frame is invalid or contains again a batman-adv packet. Also
+ * unicast packets will be dropped directly when they were sent between two
  * isolated clients.
  */
 void batadv_interface_rx(struct net_device *mesh_iface,
diff --git a/net/batman-adv/netlink.c b/net/batman-adv/netlink.c
index 1ba206e402733..4cf9e3c54ad3b 100644
--- a/net/batman-adv/netlink.c
+++ b/net/batman-adv/netlink.c
@@ -944,7 +944,7 @@ static int batadv_netlink_set_hardif(struct sk_buff *skb,
 }
 
 /**
- * batadv_netlink_dump_hardif() - Dump all hard interface into a messages
+ * batadv_netlink_dump_hardif() - Dump all hard interfaces into a message
  * @msg: Netlink message to dump into
  * @cb: Parameters from query
  *
@@ -1101,7 +1101,7 @@ static int batadv_netlink_get_vlan(struct sk_buff *skb, struct genl_info *info)
 }
 
 /**
- * batadv_netlink_set_vlan() - Get vlan attributes
+ * batadv_netlink_set_vlan() - Set vlan attributes
  * @skb: Netlink message with request data
  * @info: receiver information
  *
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index b161232c10885..9b38bd9e8da7e 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -439,7 +439,7 @@ batadv_orig_ifinfo_new(struct batadv_orig_node *orig_node,
 }
 
 /**
- * batadv_neigh_ifinfo_get() - find the ifinfo from an neigh_node
+ * batadv_neigh_ifinfo_get() - find the ifinfo from a neigh_node
  * @neigh: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
@@ -472,7 +472,7 @@ batadv_neigh_ifinfo_get(struct batadv_neigh_node *neigh,
 }
 
 /**
- * batadv_neigh_ifinfo_new() - search and possibly create an neigh_ifinfo object
+ * batadv_neigh_ifinfo_new() - search and possibly create a neigh_ifinfo object
  * @neigh: the neigh node to be queried
  * @if_outgoing: the interface for which the ifinfo should be acquired
  *
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index cd75daea478c5..403c854568704 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -48,7 +48,7 @@ static void batadv_tvlv_handler_release(struct kref *ref)
 }
 
 /**
- * batadv_tvlv_handler_put() - decrement the tvlv container refcounter and
+ * batadv_tvlv_handler_put() - decrement the tvlv handler refcounter and
  *  possibly release it
  * @tvlv_handler: the tvlv handler to free
  */
@@ -272,7 +272,7 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
  * @additional_packet_len: requested additional packet size on top of minimum
  *  size
  *
- * Return: true of the packet buffer could be changed to the requested size,
+ * Return: true if the packet buffer could be changed to the requested size,
  * false otherwise.
  */
 static bool batadv_tvlv_realloc_packet_buff(struct batadv_ogm_buf *ogm_buff,
-- 
2.47.3

