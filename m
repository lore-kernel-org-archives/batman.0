Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA1C2C79F89
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:18:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B9134841C4
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:18:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769125;
 b=t9YP3AeTr4VytvPRq6VluPIX/r9SZDSbzIo4yLVmq0lCJyA9YOiIbXD8z1IOy+IyNA6cw
 YgaIkqQi1UZA6tLWy6aWQokPV57+iwoaMx4i95EBFmSf0Xr39nVpO/8tGvuoPYA4xzNNFu6
 XKPuVeOmaXcPWdlgTdotZh3iuiqC6QM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769125; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UMQp12AY7tCx0JbtWTx89NvFFRz34feFo7NwGLJ4zaY=;
 b=mIMxchOExxDob6P0R4tHW1EowoYgZhkYIt6WUC676t0SgmTmR7jLIQ3iInfbr+20eJfTb
 CitiDkbLSrgF210rnQyO5QhobFEPABehpF9IKKQfPLvb6I5nOyzjMFNx/ZEUvWFdWyrSsuo
 W6ekRZboLzM15loIUAzLWIftZAk1a2o=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B609482D7A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769117;
	b=fY05NWN2GEujT8bQVG5tI+aE4/U99QmpvZysNIIIzJ3ep84E7t+AC/KEN3LtPS4OG135Ch
	yXXkx3toYY12dEsjErjpjjRfI3AjJGqOB7b4dicy9UGLws2Yrm/7GLEaSZzuLCPhjEp1Uh
	oeruME+rhxVYRNtrtPWYLXLmkKs4Yd4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UMQp12AY7tCx0JbtWTx89NvFFRz34feFo7NwGLJ4zaY=;
	b=R4Y1XVnAtwQLsqYodiJJ8gZhz9/2PESzzjR5lYWK1xLPMUvGSWbt5E60yKPpITGhXTpZGv
	YWmnDUeNdaoHnrBomY7pyCKnAsVvR9hHESXzI5yleHhYEvQsalyxKJLPfv4Lfmz5oEd0Cb
	wcW7+i9m6dBAAcbo6FM83ixOHqakFtI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=zgErtkCb;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59748D0d8C3747188E6DFE6c0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 09C61FA132;
	Mon, 07 Sep 2026 10:18:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMQp12AY7tCx0JbtWTx89NvFFRz34feFo7NwGLJ4zaY=;
	b=zgErtkCbkNlECyB8tuviLbIBo+fCY+urP4ZWVIuUUQbumckE1QwVXascasgm8sfhDfRg4V
	/m+Fc+kyj/Vz7UechIpbmBtcB1yMdBRHiKHfEmcowhLdJydJeDoTUd3xW8H9X7jLnEsy7v
	Ytl4jKcpX72Mgq/ETgD/7Qs/uXRIW2vkXK65LLOj5L7hh1o8eFdBNRldh4YtfuWxHSdOBB
	WFtO0kQWeATWccVxLBjesWRHJSq5YlWcJN8HsxJ0yALYLLi+EVwq7CRkcupHPskXpRlZMp
	aCC/zIW9sHfak9j/RHSmy66TLT66jDlOM+ZCkKZ7gzRYcDVdBxiuOXOQLUW+Jg==
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
Subject: [PATCH net-next 02/15] batman-adv: tt: extract allocation of new
 local entries
Date: Mon,  7 Sep 2026 10:18:11 +0200
Message-ID: <20260907081824.2474040-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XAKOCK5ME4QIVSZHHJQK2X4L7MG3HO5Y
X-Message-ID-Hash: XAKOCK5ME4QIVSZHHJQK2X4L7MG3HO5Y
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XAKOCK5ME4QIVSZHHJQK2X4L7MG3HO5Y/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The code which allocates and initializes a brand new local TT entry makes
up more than a third of batadv_tt_local_add(). It only shares the addr, vid
and iif_is_wifi parameters with the rest of the function.

Move it to batadv_tt_local_create(), which returns the fully initialized
entry. The error paths become plain returns.

The insertion into bat_priv->tt.local_hash intentionally stays in
batadv_tt_local_add(), keeping the extra reference for the hash next to the
error handling which has to drop it again.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 135 +++++++++++++++++------------
 1 file changed, 79 insertions(+), 56 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1c22db348267e..2bc243f0fa699 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -720,6 +720,84 @@ static bool batadv_tt_iif_is_wifi(struct net *net, int ifindex)
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
@@ -739,14 +817,11 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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
 
@@ -793,62 +868,10 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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

