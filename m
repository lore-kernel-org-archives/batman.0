Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9C7606A329
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=J+OFjwGs
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B2FFB85347
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:19:42 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794647982;
 b=QcvsQH8FxLOOANFzd00T5FnsHSL6paQBh8WkUiLqiLCoH0mkYukCDxgeVhLc2XtIjwqni
 3saLqUfwr6/+m2VCNyneUOmTo+1uYSnJEe11VHsz1OCE6Dtdv5BNuGN5eg7ySN3wS17aWTs
 Q3onGqWfaRfOHrSs8Kv6tw7LbZJ5+6Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794647982; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gOEh9RXMNeYvAbXBnvy+OdbFk2clGUL7+cd9rDri6k8=;
 b=pzNk/b2By+AZowRv4pun399xHKzrykE+G7RrAZpf6ezXFMRWTk/yKQOitERs/J2s5hLiO
 GB/Rn34ZijfVxzNZz6NwGNKBvW7psqjQ5rahX9KdxdyqVh8ZxXmfak4e/2o8qDz8ZXdRkci
 qecJgVhXynCqLGkEjey1aSA/YJnnV4g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8A4FA84395
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:16:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647773;
	b=uunNodAEb8Af6Q3nMj3jZjy1FxJBWtNf2RxUeWEAhCFsV6VfWYhzDCAb+NUccWE93GetXu
	sqGt7bM/P4ermZAUMrjsghLOIhXiKQtFYsECl0OzMYMTxuK0TRhtdkQwr8RXtZOWkR/5wE
	VQv8LQdBu3JRsj6OgMhQ1ESMNE3njdc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gOEh9RXMNeYvAbXBnvy+OdbFk2clGUL7+cd9rDri6k8=;
	b=MowRZZAYFSav/3sQZQBApQnuJw/bwezmcYxkeSjyE4dNhkAzdQzsT9u812x2gz0/kXAS1y
	ev4lfuiYeDeyZJBDq6A5KloomeWpnhgOUSFMbJvKCvWkqFti00l5Ebxedk3zysnXLQv3Q5
	wxd6ObcNf4s3xugKK8A0Cxo7mbfq/nY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=J+OFjwGs;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de (unknown
 [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 1D69EFA039;
	Sat, 14 Nov 2026 10:16:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOEh9RXMNeYvAbXBnvy+OdbFk2clGUL7+cd9rDri6k8=;
	b=J+OFjwGsGsKs1Lr7R2K4onAmoXipkkSON7PYQ48uPNPPGQiEBjltMqzSqT1LmlhBVb99uB
	4u9dE6ITLsFicAlZyN7hcCuMwF8UXJmhVznghTy1MftnX/NjqpbEygtFyso10bqC8xMRFd
	D68xZn5wyrFyxrtqa4VWF1E4HaG68dgbKJIN0Nodq0FcDDsGTR1xy/iTNW/NLLf6mGEnVh
	3ganyl4T3c3ZGXjVuUirUwH5ATAaEwIMfsJyD3exDBPv64+nBOi1dhXw2Vn1e30GFgUmAN
	WBZXsmtW/pdA76WHwRRvTXHNVIVdqAHO8QNkfwjoaPsm5P79k6hFSHyaR6k1Zg==
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
Subject: [PATCH net-next 15/15] batman-adv: annotate functions returning
 objects with __must_check
Date: Sat, 14 Nov 2026 10:15:56 +0100
Message-ID: <20261114091556.3336038-16-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114091556.3336038-1-sw@simonwunderlich.de>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: NYUPTQXUUHTT4CKYCQU2FXOMFAQZPTTA
X-Message-ID-Hash: NYUPTQXUUHTT4CKYCQU2FXOMFAQZPTTA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NYUPTQXUUHTT4CKYCQU2FXOMFAQZPTTA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sven Eckelmann <sven@narfation.org>

Most lookup, get and create functions in batman-adv return an object with
an increased refcounter (or otherwise owned resource), which the caller has
to release again with the matching batadv_*_put(), dev_put() or free
function. If a caller ignores such a return value, the reference leaks.

Mark these functions __must_check so the compiler catches such (potential
future) callers.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c            |  8 ++++----
 net/batman-adv/bat_v.c                 |  2 +-
 net/batman-adv/bat_v_ogm.h             |  4 ++--
 net/batman-adv/bridge_loop_avoidance.c |  8 ++++----
 net/batman-adv/distributed-arp-table.c |  6 +++---
 net/batman-adv/fragmentation.c         | 10 +++++-----
 net/batman-adv/gateway_client.h        |  9 +++++----
 net/batman-adv/hard-interface.c        |  2 +-
 net/batman-adv/hard-interface.h        | 10 ++++++----
 net/batman-adv/hash.h                  |  2 +-
 net/batman-adv/mesh-interface.h        |  4 ++--
 net/batman-adv/multicast.c             |  3 ++-
 net/batman-adv/netlink.c               | 10 +++++-----
 net/batman-adv/netlink.h               |  5 +++--
 net/batman-adv/originator.c            | 10 +++++-----
 net/batman-adv/originator.h            | 26 +++++++++++++-------------
 net/batman-adv/routing.c               |  2 +-
 net/batman-adv/routing.h               |  2 +-
 net/batman-adv/send.h                  |  2 +-
 net/batman-adv/tp_meter.c              |  8 ++++----
 net/batman-adv/translation-table.c     | 12 ++++++------
 net/batman-adv/translation-table.h     |  9 +++++----
 net/batman-adv/tvlv.c                  |  4 ++--
 23 files changed, 82 insertions(+), 76 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 5faac7419e43a..a7b5d5a1cc024 100644
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
@@ -1484,7 +1484,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
  * Return: A neighbor node which is the best router towards the given originator
  * address. Bonding candidates are ignored.
  */
-static struct batadv_neigh_node *
+static struct batadv_neigh_node * __must_check
 batadv_orig_to_direct_router(struct batadv_priv *bat_priv, const u8 *orig_addr,
 			     struct batadv_hard_iface *if_outgoing)
 {
@@ -2490,7 +2490,7 @@ static void batadv_iv_init_sel_class(struct batadv_priv *bat_priv)
  * Return: gateway node with the highest score for the current selection class,
  *  or NULL if no eligible gateway exists.
  */
-static struct batadv_gw_node *
+static struct batadv_gw_node * __must_check
 batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
 	struct batadv_neigh_ifinfo *router_ifinfo;
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index bd2bf2b58635e..1ee9f966e548e 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -614,7 +614,7 @@ static int batadv_v_gw_throughput_get(struct batadv_gw_node *gw_node, u32 *bw)
  *
  * Return: the GW node having the best GW-metric, NULL if no GW is known
  */
-static struct batadv_gw_node *
+static struct batadv_gw_node * __must_check
 batadv_v_gw_get_best_gw_node(struct batadv_priv *bat_priv)
 {
 	struct batadv_gw_node *curr_gw = NULL;
diff --git a/net/batman-adv/bat_v_ogm.h b/net/batman-adv/bat_v_ogm.h
index edeffedecade8..30a4a7d904697 100644
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
index ba410dca1c89c..729534eb19fb3 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -214,7 +214,7 @@ static void batadv_claim_put(struct batadv_bla_claim *claim)
  *
  * Return: claim if found or NULL otherwise.
  */
-static struct batadv_bla_claim *
+static struct batadv_bla_claim * __must_check
 batadv_claim_hash_find(struct batadv_priv *bat_priv,
 		       const struct batadv_bla_claim_key *key)
 {
@@ -254,7 +254,7 @@ batadv_claim_hash_find(struct batadv_priv *bat_priv,
  *
  * Return: backbone gateway if found or NULL otherwise
  */
-static struct batadv_bla_backbone_gw *
+static struct batadv_bla_backbone_gw * __must_check
 batadv_backbone_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 			  unsigned short vid)
 {
@@ -481,7 +481,7 @@ static void batadv_bla_loopdetect_report(struct work_struct *work)
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
index d558d2300d607..2bb6716a124a4 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -396,7 +396,7 @@ static u32 batadv_hash_dat(const void *data, u32 size)
  *
  * Return: the dat_entry if found, NULL otherwise.
  */
-static struct batadv_dat_entry *
+static struct batadv_dat_entry * __must_check
 batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 			   unsigned short vid)
 {
@@ -704,7 +704,7 @@ static void batadv_choose_next_candidate(struct batadv_priv *bat_priv,
  *
  * Return: the candidate array of size BATADV_DAT_CANDIDATE_NUM.
  */
-static struct batadv_dat_candidate *
+static struct batadv_dat_candidate * __must_check
 batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst,
 			     unsigned short vid)
 {
@@ -1195,7 +1195,7 @@ static unsigned short batadv_dat_get_vid(struct sk_buff *skb, int *hdr_size)
  *
  * Return: An skb containing an ARP Reply.
  */
-static struct sk_buff *
+static struct sk_buff * __must_check
 batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
 			    __be32 ip_dst, const u8 *hw_src, const u8 *hw_dst,
 			    unsigned short vid)
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 936056a78effe..3a9c4ea860b90 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -259,7 +259,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
  *
  * Return: the merged skb or NULL on error.
  */
-static struct sk_buff *
+static struct sk_buff * __must_check
 batadv_frag_merge_packets(struct hlist_head *chain)
 {
 	int hdr_size = sizeof(struct batadv_frag_packet);
@@ -475,10 +475,10 @@ int batadv_frag_skb_fwd(struct batadv_priv *bat_priv, struct sk_buff *skb,
  *
  * Return: the new fragment, NULL on error.
  */
-static struct sk_buff *batadv_frag_create(struct net_device *net_dev,
-					  struct sk_buff *skb,
-					  struct batadv_frag_packet *frag_head,
-					  unsigned int fragment_size)
+static struct sk_buff * __must_check
+batadv_frag_create(struct net_device *net_dev, struct sk_buff *skb,
+		   struct batadv_frag_packet *frag_head,
+		   unsigned int fragment_size)
 {
 	unsigned int ll_reserved = LL_RESERVED_SPACE(net_dev);
 	unsigned int tailroom = net_dev->needed_tailroom;
diff --git a/net/batman-adv/gateway_client.h b/net/batman-adv/gateway_client.h
index 95c2ccdaa5545..168175c28680d 100644
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
index bf36879caab1b..46dcbba0379b8 100644
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
index 1aec7ce892445..6bdef0ae1419b 100644
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
diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index fca426c5e3c58..5d9a5abb0f474 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -66,7 +66,7 @@ struct batadv_hashtable {
 };
 
 /* allocates and clears the hash */
-struct batadv_hashtable *batadv_hash_new(u32 size);
+struct batadv_hashtable * __must_check batadv_hash_new(u32 size);
 
 /* set class key for all locks */
 void batadv_hash_set_lock_class(struct batadv_hashtable *hash,
diff --git a/net/batman-adv/mesh-interface.h b/net/batman-adv/mesh-interface.h
index 5e1e83e04ffbc..ac73f09f89c91 100644
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
index 1e086a6385261..29bfeb800fa5d 100644
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
index 107647c9badad..fd58523cea7c1 100644
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
index f92d3ea7d06cb..d6eeff0e57238 100644
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
index f85ad961f8a9b..0a5ee918cf501 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -530,7 +530,7 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
  *
  * Return: neighbor when found. Otherwise NULL
  */
-static struct batadv_neigh_node *
+static struct batadv_neigh_node * __must_check
 batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
 		      const struct batadv_hard_iface *hard_iface,
 		      const u8 *addr)
@@ -565,7 +565,7 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
  *
  * Return: the hardif neighbour node if found or created or NULL otherwise.
  */
-static struct batadv_hardif_neigh_node *
+static struct batadv_hardif_neigh_node * __must_check
 batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 			   const u8 *neigh_addr,
 			   struct batadv_orig_node *orig_node)
@@ -612,7 +612,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
  *
  * Return: the hardif neighbour node if found or created or NULL otherwise.
  */
-static struct batadv_hardif_neigh_node *
+static struct batadv_hardif_neigh_node * __must_check
 batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
 				  const u8 *neigh_addr,
 				  struct batadv_orig_node *orig_node)
@@ -670,7 +670,7 @@ batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
  *
  * Return: the neighbour node if found or created or NULL otherwise.
  */
-static struct batadv_neigh_node *
+static struct batadv_neigh_node * __must_check
 batadv_neigh_node_create(struct batadv_orig_node *orig_node,
 			 struct batadv_hard_iface *hard_iface,
 			 const u8 *neigh_addr)
@@ -1170,7 +1170,7 @@ batadv_purge_orig_neighbors(struct batadv_priv *bat_priv,
  *
  * Return: the current best neighbor, with refcount increased.
  */
-static struct batadv_neigh_node *
+static struct batadv_neigh_node * __must_check
 batadv_find_best_neighbor(struct batadv_priv *bat_priv,
 			  struct batadv_orig_node *orig_node,
 			  struct batadv_hard_iface *if_outgoing)
diff --git a/net/batman-adv/originator.h b/net/batman-adv/originator.h
index dff729ecf2df1..6b17fa62ed2c4 100644
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
 batadv_orig_to_router(struct batadv_priv *bat_priv, const u8 *orig_addr,
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
 batadv_orig_hash_find(struct batadv_priv *bat_priv, const u8 *addr);
 
 /**
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index d5772429535e9..6bcd9d9496ba9 100644
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
index e9849f032a240..74878d06e8443 100644
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
diff --git a/net/batman-adv/send.h b/net/batman-adv/send.h
index 3415afec4a0c2..ebf57751cf954 100644
--- a/net/batman-adv/send.h
+++ b/net/batman-adv/send.h
@@ -17,7 +17,7 @@
 
 void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet,
 			     bool dropped);
-struct batadv_forw_packet *
+struct batadv_forw_packet * __must_check
 batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 			 struct batadv_hard_iface *if_outgoing,
 			 atomic_t *queue_left,
diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 56feb02d2b7ef..4014a431951ec 100644
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
index 3ce5569a8872f..f9de255ef0dfd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -150,7 +150,7 @@ static inline u32 batadv_choose_tt(const void *data, u32 size)
  * Return: a pointer to the tt_common struct belonging to the searched client if
  * found, NULL otherwise.
  */
-static struct batadv_tt_common_entry *
+static struct batadv_tt_common_entry * __must_check
 batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
 		    unsigned short vid)
 {
@@ -194,7 +194,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
  * Return: a pointer to the corresponding tt_local_entry struct if the client is
  * found, NULL otherwise.
  */
-static struct batadv_tt_local_entry *
+static struct batadv_tt_local_entry * __must_check
 batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
 			  unsigned short vid)
 {
@@ -965,7 +965,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
  * Return: the new entry with an initialized reference counter on success, NULL
  * otherwise.
  */
-static struct batadv_tt_local_entry *
+static struct batadv_tt_local_entry * __must_check
 batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 		       unsigned short vid, bool iif_is_wifi)
 {
@@ -1956,7 +1956,7 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
  *
  * Return: it with an increased refcounter, NULL if not found
  */
-static struct batadv_tt_orig_list_entry *
+static struct batadv_tt_orig_list_entry * __must_check
 batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
 				 const struct batadv_orig_node *orig_node)
 {
@@ -2194,7 +2194,7 @@ batadv_tt_global_merge_flags(struct batadv_tt_global_entry *tt_global_entry,
  * Return: the new entry with an initialized reference counter on success, NULL
  * otherwise.
  */
-static struct batadv_tt_global_entry *
+static struct batadv_tt_global_entry * __must_check
 batadv_tt_global_create(const unsigned char *tt_addr, unsigned short vid,
 			u16 flags)
 {
@@ -3347,7 +3347,7 @@ static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
  * Return: the pointer to the new tt_req_node struct if no request
  * has already been issued for this orig_node, NULL otherwise.
  */
-static struct batadv_tt_req_node *
+static struct batadv_tt_req_node * __must_check
 batadv_tt_req_node_new(struct batadv_priv *bat_priv,
 		       struct batadv_orig_node *orig_node)
 {
diff --git a/net/batman-adv/translation-table.h b/net/batman-adv/translation-table.h
index 41b7c40790419..2e315d221b3a7 100644
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
index 93492d393c347..a4f7e474b4245 100644
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

