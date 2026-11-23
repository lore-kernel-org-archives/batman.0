Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F316606A32D
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=iBXojrTb
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DA9A48465C
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:19:21 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795454361;
 b=DE3enbFEIxcgB6xx0WuDGbsOe38xgfuQ9B5kNoyt/IyKXtcfc5gryXeziHDrHi20L28Q0
 qTbSt5PbeG1wcTXHNW4k1oLhN5lasAICEG8/zwHZCxq8MJ8HC2nobM+toUpiIvaZmqzQZgk
 FfoOAAB4F1tGirpCtu8cgUM0UEzYjlg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795454361; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+Ujdg5G89P0pU+ZP7KvnYTjdgZuzFmYy+5yVDPI5RbI=;
 b=IKaHs2ViEc5+0DeWVo138IMl9o3cr21DDHGJANgioOdayDTLTkjQKhRkqL5prDrjTsXfI
 jERHUwD1+oUcPnsZ6MlPD/2NvBVpu7Au2XnCVaAuGppDQ9DphQ2lJ6J9rvAagRg1Ba4h14j
 vUUf3tlRs9/+rdavFrXRNpBpyIDvjac=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 56891830EF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 18:18:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795454322;
	b=aN+Y7+aCDkDcEEDu2CgHtm0bjpDvOFhXuKJSYSxoUX2au153lvb/Uytr+AnRJYeHctHSiK
	/dXBtN7+idzzYFakHDRPlz97Fvvioj9LzszObh4zHDlJXUWmh8ekp7+ilI3mMQCZZcBPW4
	Fxw5SuIirdnMIAs1VqY/TiV0iX/K1Go=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795454322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+Ujdg5G89P0pU+ZP7KvnYTjdgZuzFmYy+5yVDPI5RbI=;
	b=RV8pQQyqN9a7JPplEb+onSKk7lQfSJXT6TcXpaoXLKF1/uRz7RDc1XnLkoRihVUsvBDgcu
	srms1t2x9S77hqNZ4vVTVqt2HG5ak+1jcygWpYk2+YUhquVroBCMOrC7ZE9rHQes0fdelv
	DYljUBrHH6frVzHWLgKiGo1Nt6IMHfg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=iBXojrTb;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59714c2E05A704819B6bA2DB4.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:c2e0:5a70:4819:b6ba:2db4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 55EDCFA0B2;
	Mon, 23 Nov 2026 18:18:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1795454311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ujdg5G89P0pU+ZP7KvnYTjdgZuzFmYy+5yVDPI5RbI=;
	b=iBXojrTbNS/oh1VX5SrCVYBB+Gi4Xb5NA3bASBr10YlNB8uSjUwbp+Q5e8kij2vM/Ta570
	8C+tclsSGUWsE0WSQH4JY9F/5Tpv3rqDaEwSAJyMdCNkVm0prZbGwdPbYdk1qweCuSnGgy
	dRU+N/TP00rBxzzyDsnJoVyC9MYYbsT8/ofVZXwwmPj9xuTO26/JLz8AYaAi/gH/b5fn4X
	9GmB+YugZIJHLHH6f+ILqHrNi8aHFIjbdevOGOMk0QFIn6TlhhZEZZ/yzXVRE+so5NySPk
	RNIABEF6l0DACW9MCc0g8w9TlZ/UNqm8VsBbwC8pwjiKMZuwUxXgoBa1+QkG8Q==
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
Subject: [PATCH net-next 01/15] batman-adv: document refcount of returned
 objects
Date: Mon, 23 Nov 2026 18:18:13 +0100
Message-ID: <20261123171827.3294525-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123171827.3294525-1-sw@simonwunderlich.de>
References: <20261123171827.3294525-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 5Q6W5E6C4J7MNSOUNOAQQHQIN3LK5P52
X-Message-ID-Hash: 5Q6W5E6C4J7MNSOUNOAQQHQIN3LK5P52
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5Q6W5E6C4J7MNSOUNOAQQHQIN3LK5P52/>
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

Callers of lookup, get and create functions have to know whether they own a
reference to the returned object (and have to release it with the matching
batadv_*_put() or dev_put()), or only borrow it. Some functions document
this already (e.g. "(with increased refcnt)" or "The object is returned
with refcounter increased by 1."), but many say nothing.

Add a note to the kerneldoc of the __must_check functions that return an
object with an increased refcounter and did not document this yet. For the
exceptions:

* batadv_transtable_best_orig()
* batadv_mcast_forw_orig_entry()

the opposite is stated to make the difference clear ("no increased refcnt",
"only valid in current RCU read-side critical section")

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
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
 net/batman-adv/netlink.c               | 28 +++++++++++++-------------
 net/batman-adv/originator.c            | 16 ++++++++++++---
 net/batman-adv/routing.c               |  1 +
 net/batman-adv/tp_meter.c              | 12 +++++++----
 net/batman-adv/translation-table.c     | 18 ++++++++++++-----
 net/batman-adv/tvlv.c                  |  2 ++
 16 files changed, 80 insertions(+), 34 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a7b5d5a1cc02..4f60e50dbad2 100644
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
@@ -1483,6 +1485,7 @@ batadv_iv_ogm_update_seqnos(const struct ethhdr *ethhdr,
  *
  * Return: A neighbor node which is the best router towards the given originator
  * address. Bonding candidates are ignored.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_neigh_node * __must_check
 batadv_orig_to_direct_router(struct batadv_priv *bat_priv, const u8 *orig_addr,
@@ -2489,6 +2492,7 @@ static void batadv_iv_init_sel_class(struct batadv_priv *bat_priv)
  *
  * Return: gateway node with the highest score for the current selection class,
  *  or NULL if no eligible gateway exists.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_gw_node * __must_check
 batadv_iv_gw_get_best_gw_node(struct batadv_priv *bat_priv)
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 1ee9f966e548..1214e6f9c43c 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -612,7 +612,8 @@ static int batadv_v_gw_throughput_get(struct batadv_gw_node *gw_node, u32 *bw)
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
index 4abb4c871e8c..c2ad9ac0d6e7 100644
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
index 729534eb19fb..68ff2f94cf49 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -213,6 +213,7 @@ static void batadv_claim_put(struct batadv_bla_claim *claim)
  * @key: key of the searched claim
  *
  * Return: claim if found or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_bla_claim * __must_check
 batadv_claim_hash_find(struct batadv_priv *bat_priv,
@@ -252,7 +253,8 @@ batadv_claim_hash_find(struct batadv_priv *bat_priv,
  * @addr: the address of the originator
  * @vid: the VLAN ID
  *
- * Return: backbone gateway if found or NULL otherwise
+ * Return: backbone gateway if found or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_bla_backbone_gw * __must_check
 batadv_backbone_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
@@ -479,7 +481,8 @@ static void batadv_bla_loopdetect_report(struct work_struct *work)
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
index 2bb6716a124a..a6145383e6d7 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -395,6 +395,7 @@ static u32 batadv_hash_dat(const void *data, u32 size)
  * @vid: VLAN identifier
  *
  * Return: the dat_entry if found, NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_dat_entry * __must_check
 batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index e6e97c0478cc..0dddcea7def9 100644
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
index 46dcbba0379b..b692b5b83d7c 100644
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
index 6bdef0ae1419..ad53e6086bae 100644
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
index 29bfeb800fa5..415981fe6dc6 100644
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
index 0120d1ea30ac..863ada459480 100644
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
index fd58523cea7c..361660371726 100644
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
+ * Return: Pointer to mesh interface on success, error pointer on error.
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
+ * Return: Pointer to mesh interface on success, error pointer on error.
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
index 0a5ee918cf50..25a3f78aca1a 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -48,7 +48,8 @@ static struct lock_class_key batadv_orig_hash_lock_class_key;
  * @bat_priv: the bat priv with all the mesh interface information
  * @addr: mac address of the originator
  *
- * Return: orig_node (with increased refcnt), NULL on errors
+ * Return: orig_node, NULL on errors.
+ * The returned object has an increased refcounter.
  */
 struct batadv_orig_node *
 batadv_orig_hash_find(struct batadv_priv *bat_priv, const u8 *addr)
@@ -106,6 +107,7 @@ bool batadv_compare_orig(const struct hlist_node *node, const void *data2)
  *
  * Return: the vlan object identified by vid and belonging to orig_node or NULL
  * if it does not exist.
+ * The returned object has an increased refcounter.
  */
 struct batadv_orig_node_vlan *
 batadv_orig_node_vlan_get(struct batadv_orig_node *orig_node,
@@ -346,6 +348,7 @@ batadv_orig_router_get(struct batadv_orig_node *orig_node,
  *
  * Return: A neighbor node which is the best router towards the given originator
  * address.
+ * The returned object has an increased refcounter.
  */
 struct batadv_neigh_node *
 batadv_orig_to_router(struct batadv_priv *bat_priv, const u8 *orig_addr,
@@ -528,7 +531,8 @@ batadv_neigh_ifinfo_new(struct batadv_neigh_node *neigh,
  * Looks for and possibly returns a neighbour belonging to this originator list
  * which is connected through the provided hard interface.
  *
- * Return: neighbor when found. Otherwise NULL
+ * Return: neighbor when found. Otherwise NULL.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_neigh_node * __must_check
 batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
@@ -564,6 +568,7 @@ batadv_neigh_node_get(const struct batadv_orig_node *orig_node,
  * @orig_node: originator object representing the neighbour
  *
  * Return: the hardif neighbour node if found or created or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_hardif_neigh_node * __must_check
 batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
@@ -611,6 +616,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
  * @orig_node: originator object representing the neighbour
  *
  * Return: the hardif neighbour node if found or created or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_hardif_neigh_node * __must_check
 batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
@@ -634,7 +640,8 @@ batadv_hardif_neigh_get_or_create(struct batadv_hard_iface *hard_iface,
  *
  * Looks for and possibly returns a neighbour belonging to this hard interface.
  *
- * Return: neighbor when found. Otherwise NULL
+ * Return: neighbor when found. Otherwise NULL.
+ * The returned object has an increased refcounter.
  */
 struct batadv_hardif_neigh_node *
 batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
@@ -669,6 +676,7 @@ batadv_hardif_neigh_get(const struct batadv_hard_iface *hard_iface,
  * Allocates a new neigh_node object and initialises all the generic fields.
  *
  * Return: the neighbour node if found or created or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_neigh_node * __must_check
 batadv_neigh_node_create(struct batadv_orig_node *orig_node,
@@ -734,6 +742,7 @@ batadv_neigh_node_create(struct batadv_orig_node *orig_node,
  * @neigh_addr: the mac address of the neighbour interface
  *
  * Return: the neighbour node if found or created or NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 struct batadv_neigh_node *
 batadv_neigh_node_get_or_create(struct batadv_orig_node *orig_node,
@@ -945,6 +954,7 @@ void batadv_originator_free(struct batadv_priv *bat_priv)
  * The new object is not added to the originator list.
  *
  * Return: the newly created object or NULL on failure.
+ * The returned object has an increased refcounter.
  */
 struct batadv_orig_node *batadv_orig_node_new(struct batadv_priv *bat_priv,
 					      const u8 *addr)
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 6bcd9d9496ba..821fb5addbfe 100644
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
index 4014a431951e..d3ffcc3aa44b 100644
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
index f9de255ef0df..216f41387afa 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -149,6 +149,7 @@ static inline u32 batadv_choose_tt(const void *data, u32 size)
  *
  * Return: a pointer to the tt_common struct belonging to the searched client if
  * found, NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tt_common_entry * __must_check
 batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
@@ -193,6 +194,7 @@ batadv_tt_hash_find(struct batadv_hashtable *hash, const u8 *addr,
  *
  * Return: a pointer to the corresponding tt_local_entry struct if the client is
  * found, NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tt_local_entry * __must_check
 batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
@@ -218,6 +220,7 @@ batadv_tt_local_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
  *
  * Return: a pointer to the corresponding tt_global_entry struct if the client
  * is found, NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 struct batadv_tt_global_entry *
 batadv_tt_global_hash_find(struct batadv_priv *bat_priv, const u8 *addr,
@@ -962,8 +965,8 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
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
@@ -1954,7 +1957,8 @@ static void batadv_tt_changes_list_free(struct batadv_priv *bat_priv)
  * retrieve the orig_tt_list_entry belonging to orig_node from the
  * batadv_tt_global_entry list
  *
- * Return: it with an increased refcounter, NULL if not found
+ * Return: found entry on success, NULL if not found.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tt_orig_list_entry * __must_check
 batadv_tt_global_orig_entry_find(const struct batadv_tt_global_entry *entry,
@@ -2191,8 +2195,8 @@ batadv_tt_global_merge_flags(struct batadv_tt_global_entry *tt_global_entry,
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
@@ -2356,6 +2360,8 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
  *
  * This function assumes the caller holds rcu_read_lock().
  * Return: best originator list entry or NULL on errors.
+ * The returned object has no increased refcounter and is only valid inside
+ * the RCU read-side critical section of the caller.
  */
 static struct batadv_tt_orig_list_entry *
 batadv_transtable_best_orig(struct batadv_priv *bat_priv,
@@ -3024,6 +3030,7 @@ _batadv_is_ap_isolated(struct batadv_tt_local_entry *tt_local_entry,
  * mesh for contacting the client 'addr', NULL otherwise.
  * In case of multiple originators serving the same client, the function returns
  * the best one (best in terms of metric towards the destination node).
+ * The returned object has an increased refcounter.
  *
  * If the two clients are AP isolated the function returns NULL.
  */
@@ -3346,6 +3353,7 @@ static void batadv_tt_req_purge(struct batadv_priv *bat_priv)
  *
  * Return: the pointer to the new tt_req_node struct if no request
  * has already been issued for this orig_node, NULL otherwise.
+ * The returned object has an increased refcounter.
  */
 static struct batadv_tt_req_node * __must_check
 batadv_tt_req_node_new(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index a4f7e474b424..d26f3f7754a2 100644
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

