Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4F5C61DBE
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:24:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0C5F483B25
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:24:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984659;
 b=S5Q3L88A6IE4kya6tHLWO1aaAzOoOHJoT9Ob1dnekmz6NAD+IoSnMfwxdxlyFBRftpz2P
 O9qrmHz5MwlG47SN0DGYQsV60vDFeYSgi/prs37JXDGbXhHIrJl+3YHqLVU7+REJ3SPMQIc
 iLvzChMFMLCp4m0Q2gz6ov7uXPqQNRg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984659; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WTx4NvEYYAZbt03HbPpJrffP6k39Cx6VTKfLkf/cf0s=;
 b=QOhWnu5fOrdIS8249jGhHeH9BLP1S3vN+xI9+rTQOJmAnQ8F1LEQK2lJ5PXaBFyCGSJjM
 ZZOMOkBk/Mtu53m9ivERDUE4r2rMZNRUnmmvPCTetzFIHrlR49l5yTkkp2Vzjhwn/7oDWPD
 MWVbdxgpiFXqeoyJYHQpWJKGPXSLeFA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EA611841E4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:20:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984459;
	b=Rd9LbHiwIsuvtk11d5HijJnuwHZsKksYvp9sWenS5ITsfvclQY6oGGuXC1+UU6OQLdD/f9
	2tpMjPfl6sqvLrPClfw1CAeuIUsuYhxU27PNP5MkhgZ4w9KxkwJ619kn+T0FhlzsWQbFoW
	XcNYDkYV9Lc6zTxNTWE7G65uy4/65O0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WTx4NvEYYAZbt03HbPpJrffP6k39Cx6VTKfLkf/cf0s=;
	b=nZWJ43H5hzBO1jUoJHYLKDus3qjliwOAtmakSjqt24tvcxNDnmew9qoSCqMnBjPofpKcCx
	aEpW0itAnz8ACoYjRhH9+sdjwQkanHO62cIZolANAZD/xnIKNbPRGajRLlhZ8/l8pXqPN9
	cWohnWFPEH2FF8sSb0X1bebG+9k0cYo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=gf4Ym87r;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 92550200E4;
	Sat, 29 Aug 2026 06:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WTx4NvEYYAZbt03HbPpJrffP6k39Cx6VTKfLkf/cf0s=;
	b=gf4Ym87rLwJuQM+ybaAh7AjcEtgZRvdHMGts/Sje6DKWhLM9buoPZ9cjK+tIaVBEnvTAJN
	SMwMVOFVrhGqXZBTQov4y5LWk4sdaRy62AA9Ym7Xcpm9lQ1n+z6YdmcKa4PRlPRp1bVly+
	zNVPiM/OWkTdGdflNnrJKFJFxT/wWiU=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:21 +0200
Subject: [PATCH batadv v5 10/20] batman-adv: tt: extract allocation of new
 local entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-10-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6953; i=sven@narfation.org;
 h=from:subject:message-id; bh=qoRrQmVO/exXJ21AhMC1MAbe8REinlV1CJXQ+Mt7L4w=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKtd4KU4UKll8f116XP2aeVZl99ZNn18QtbBpQjPjo
 QCebFn3jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEmPcwMjw1vrzEqUQ5Lbe8
 2r3nvHIFt6jB3pSdjsrXm+9kWTYEOTD8jzumtm/OutrNF2c3bO92y9Gq86kSZ3s0f2/GBIYK7p1
 6fAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: D3OF4B74TOIO634KNU7N6DTCYSELHQB5
X-Message-ID-Hash: D3OF4B74TOIO634KNU7N6DTCYSELHQB5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/D3OF4B74TOIO634KNU7N6DTCYSELHQB5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The code which allocates and initializes a brand new local TT entry makes
up more than a third of batadv_tt_local_add(). It only shares the addr, vid
and iif_is_wifi parameters with the rest of the function.

Move it to batadv_tt_local_create(), which returns the fully initialized
entry. The error paths become plain returns.

The insertion into bat_priv->tt.local_hash intentionally stays in
batadv_tt_local_add(), keeping the extra reference for the hash next to the
error handling which has to drop it again.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 135 ++++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 56 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index d040c0d3..8726bbba 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -772,6 +772,84 @@ static bool batadv_tt_iif_is_wifi(struct net *net, int ifindex)
 	return batadv_is_wifi(wifi_flags);
 }
 
+/**
+ * batadv_tt_local_create() - allocate and initialize a local TT entry
+ * @mesh_iface: netdev struct of the mesh interface
+ * @addr: the mac address of the client to add
+ * @vid: VLAN identifier
+ * @iif_is_wifi: whether the client is connected via a wifi interface
+ *
+ * The returned entry is not yet part of bat_priv->tt.local_hash. It is marked
+ * as BATADV_TT_CLIENT_NEW to avoid sending it in a full table response going
+ * out before the next ttvn increment (consistency check).
+ *
+ * Return: the new entry with an initialized reference counter on success, NULL
+ * otherwise.
+ */
+static struct batadv_tt_local_entry *
+batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
+		       unsigned short vid, bool iif_is_wifi)
+{
+	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
+	struct batadv_tt_local_entry *tt_local;
+	struct batadv_meshif_vlan *vlan;
+	int packet_size_max;
+	int table_size;
+
+	/* Ignore the client if we cannot send it in a full table response. */
+	table_size = batadv_tt_local_table_transmit_size(bat_priv);
+	table_size += batadv_tt_len(1);
+	packet_size_max = READ_ONCE(bat_priv->packet_size_max);
+	if (table_size > packet_size_max) {
+		net_ratelimited_function(batadv_info, mesh_iface,
+					 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
+					 table_size, packet_size_max, addr);
+		return NULL;
+	}
+
+	tt_local = kmem_cache_alloc(batadv_tl_cache, GFP_ATOMIC);
+	if (!tt_local)
+		return NULL;
+
+	/* increase the refcounter of the related vlan */
+	vlan = batadv_meshif_vlan_get(bat_priv, vid);
+	if (!vlan) {
+		net_ratelimited_function(batadv_info, mesh_iface,
+					 "adding TT local entry %pM to non-existent VLAN %d\n",
+					 addr, batadv_print_vid(vid));
+		kmem_cache_free(batadv_tl_cache, tt_local);
+		return NULL;
+	}
+
+	batadv_dbg(BATADV_DBG_TT, bat_priv,
+		   "Creating new local tt entry: %pM (vid: %d, ttvn: %d)\n",
+		   addr, batadv_print_vid(vid),
+		   (u8)atomic_read(&bat_priv->tt.vn));
+
+	ether_addr_copy(tt_local->common.addr, addr);
+	tt_local->common.vid = vid;
+	kref_init(&tt_local->common.refcount);
+	tt_local->last_seen = jiffies;
+	tt_local->common.added_at = tt_local->last_seen;
+	tt_local->vlan = vlan;
+	spin_lock_init(&tt_local->common.flags_lock);
+
+	scoped_guard(spinlock_bh, &tt_local->common.flags_lock) {
+		tt_local->common.flags = BATADV_TT_CLIENT_NEW;
+		if (iif_is_wifi)
+			tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
+
+		/* the batman interface mac and multicast addresses should never
+		 * be purged
+		 */
+		if (batadv_compare_eth(addr, mesh_iface->dev_addr) ||
+		    is_multicast_ether_addr(addr))
+			tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
+	}
+
+	return tt_local;
+}
+
 /**
  * batadv_tt_local_add() - add a new client to the local table or update an
  *  existing client
@@ -791,14 +869,11 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_global_entry *tt_global = NULL;
 	struct batadv_tt_local_entry *tt_local;
-	struct batadv_meshif_vlan *vlan;
 	bool roamed_back = false;
-	int packet_size_max;
 	bool iif_is_wifi;
 	bool ret = false;
 	u8 remote_flags;
 	int hash_added;
-	int table_size;
 	u32 match_mark;
 	bool modified;
 
@@ -845,62 +920,10 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 		goto check_roaming;
 	}
 
-	/* Ignore the client if we cannot send it in a full table response. */
-	table_size = batadv_tt_local_table_transmit_size(bat_priv);
-	table_size += batadv_tt_len(1);
-	packet_size_max = READ_ONCE(bat_priv->packet_size_max);
-	if (table_size > packet_size_max) {
-		net_ratelimited_function(batadv_info, mesh_iface,
-					 "Local translation table size (%i) exceeds maximum packet size (%i); Ignoring new local tt entry: %pM\n",
-					 table_size, packet_size_max, addr);
-		goto out;
-	}
-
-	tt_local = kmem_cache_alloc(batadv_tl_cache, GFP_ATOMIC);
+	tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
 	if (!tt_local)
 		goto out;
 
-	/* increase the refcounter of the related vlan */
-	vlan = batadv_meshif_vlan_get(bat_priv, vid);
-	if (!vlan) {
-		net_ratelimited_function(batadv_info, mesh_iface,
-					 "adding TT local entry %pM to non-existent VLAN %d\n",
-					 addr, batadv_print_vid(vid));
-		kmem_cache_free(batadv_tl_cache, tt_local);
-		tt_local = NULL;
-		goto out;
-	}
-
-	batadv_dbg(BATADV_DBG_TT, bat_priv,
-		   "Creating new local tt entry: %pM (vid: %d, ttvn: %d)\n",
-		   addr, batadv_print_vid(vid),
-		   (u8)atomic_read(&bat_priv->tt.vn));
-
-	ether_addr_copy(tt_local->common.addr, addr);
-	tt_local->common.vid = vid;
-	kref_init(&tt_local->common.refcount);
-	tt_local->last_seen = jiffies;
-	tt_local->common.added_at = tt_local->last_seen;
-	tt_local->vlan = vlan;
-	spin_lock_init(&tt_local->common.flags_lock);
-
-	spin_lock_bh(&tt_local->common.flags_lock);
-	/* The local entry has to be marked as NEW to avoid to send it in
-	 * a full table response going out before the next ttvn increment
-	 * (consistency check)
-	 */
-	tt_local->common.flags = BATADV_TT_CLIENT_NEW;
-	if (iif_is_wifi)
-		tt_local->common.flags |= BATADV_TT_CLIENT_WIFI;
-
-	/* the batman interface mac and multicast addresses should never be
-	 * purged
-	 */
-	if (batadv_compare_eth(addr, mesh_iface->dev_addr) ||
-	    is_multicast_ether_addr(addr))
-		tt_local->common.flags |= BATADV_TT_CLIENT_NOPURGE;
-	spin_unlock_bh(&tt_local->common.flags_lock);
-
 	kref_get(&tt_local->common.refcount);
 	hash_added = batadv_hash_add(bat_priv->tt.local_hash, batadv_compare_tt,
 				     batadv_choose_tt, &tt_local->common,

-- 
2.47.3

