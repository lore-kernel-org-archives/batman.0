Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96618606A320
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 11:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=EiAEQRHn
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2758C84265
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 12:43:14 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795002194;
 b=rhzINq4RwHUfss17k9TWghuWCeBFFKpnETmxbWksa4jr4fObU2A0RdPeSHe7Jm34arcmT
 uZz8Ql+jw+2I7UOpyXkBs5oOpRtD5F81A/7F8OTRPdVxNGic/KCUk57Dzrrqf9s62dF+gqt
 Fe+wRhSp6M1uLWjlnkgHOTM4MGIvj3g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795002194; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dPOqFKQrOdzpC9VTIlPXCg9WzgfUr663xx1Q4AMpdfA=;
 b=hfsf9AXYZHh5LACkt8z2dR5Eeg7KOONQagTwGMZ1Hm8l/X2P/8uohQRidEKWtgA3L/fMI
 yy0ppRSlaO6cEXwNHELpHgXgtCg4KoKIu9jO7gz/10tkYj67k/OOoXVzavmGy3ULbn53N4c
 mVgMRLiQFuFOM2xbiBym5RqQiksZmuQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6DFE68269F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Nov 2026 12:42:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795002126;
	b=aYP3SvqGb6+hY+9OGrbblObAPkfw9WVppoyzz+zhTz5gBSpmWRBg/+ix4IgxVZBuPxYzyL
	ZfqKTWt29hy79P0t1URiBMgXGzubzp+HzlPFhz0eEh92CessoiMkGEst5YdkDzyg8HFaXw
	QLcUFkEQ/EEz9W7jH6G2x8AZ1W9nNVs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795002126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dPOqFKQrOdzpC9VTIlPXCg9WzgfUr663xx1Q4AMpdfA=;
	b=2iS9taYdrmxt/LRZpbLKTRZL3XPauoozzT87BisdUzqeqSfyKdc1LVMsdOU848wAK9BCnD
	F0PSW8aXTDC/krxabUQKmH94Mh+94Yi3mRYk1rDz2vnpfphGilztH9x4K6rdBC2VzbAqGS
	INrTdGB4flSk6EBe0RZCLFWXRk6rtEI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=EiAEQRHn;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 5B27420EAD;
	Wed, 18 Nov 2026 11:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795002125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dPOqFKQrOdzpC9VTIlPXCg9WzgfUr663xx1Q4AMpdfA=;
	b=EiAEQRHnqm2Qc2N5HQ8pMAVOTdfDb+5+I1sX7JSSOpBykIMYG4UG2hyvvAigLchVyWhj+F
	UthJf3g5h1Gjt+TmQLXiawARUGzx578ZQC/hMaNba641EASeVRJrvH6riO6NagIFGJ7Avc
	BnbtqlhqdP+8DaW0rd6rU9EV+jKHur0=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 18 Nov 2026 12:41:52 +0100
Subject: [PATCH batadv v5 02/11] batman-adv: tt: refresh local entry in
 single flags_lock section
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-tt-avoid-unhashed-event-v5-2-bce9ead803e6@narfation.org>
References: <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
In-Reply-To: 
 <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8152; i=sven@narfation.org;
 h=from:subject:message-id; bh=Nx4p+c2ipwPYLs7IoZ7rQwXd3L0MXNCCQtCwWxnysCI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl/+5lfiS0+tp5f/LeIVXfxxCP6x4QnSH4vV9la98Rt5
 +XO279TOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATcdNi+J8kkSNbHm/CKGPS
 /mnzsQ+7bmxXb/MI5967+Outq7W5a3Yy/OE5ftm3JmTbDRbnOvV/xw+4Orw5c/bFJr36Dz3Sv1m
 dd/ICAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: A3OQONKUBOOY7DWUS2UAV7URQW6N33OT
X-Message-ID-Hash: A3OQONKUBOOY7DWUS2UAV7URQW6N33OT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/A3OQONKUBOOY7DWUS2UAV7URQW6N33OT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

batadv_tt_local_add() modifies the flags of a local entry in two steps.
batadv_tt_local_add_existing() cancels a pending removal and
batadv_tt_local_update_flags() updates the dynamic flags. Each of them has
its own flags_lock section and the ADD events are queued by
batadv_tt_local_add() with a snapshot of the flags which is taken after the
lock was released.

Merge both helpers into batadv_tt_local_refresh(). It modifies the flags
and queues the (single) ADD event in the same flags_lock section. The
announced flags are therefore always the ones which were just stored in the
entry.

The initial ADD of a new entry is requested via the announce parameter
after the entry was added to the hash.

This is a preparation for the validation of the entry under the hash bucket
list_lock, which then only needs to cover a single region.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 129 ++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 74 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index fabc4879..a86a4d70 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -956,57 +956,6 @@ static bool batadv_tt_iif_is_wifi(struct net *net, int ifindex)
 	return batadv_is_wifi(wifi_flags);
 }
 
-/**
- * batadv_tt_local_add_existing() - refresh an already known local TT entry
- * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local: the local TT entry which was found in the local table
- * @roamed_back: set to true when the client returned to its original location
- *
- * Return: true when the client has to be announced to the mesh again, false
- * otherwise.
- */
-static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
-					 struct batadv_tt_local_entry *tt_local,
-					 bool *roamed_back)
-{
-	struct batadv_tt_common_entry *common = &tt_local->common;
-	bool readded = false;
-
-	WRITE_ONCE(tt_local->last_seen, jiffies);
-
-	scoped_guard(spinlock_bh, &common->flags_lock) {
-		if (common->flags & BATADV_TT_CLIENT_PENDING) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Re-adding pending client %pM (vid: %d)\n",
-				   common->key.addr,
-				   batadv_print_vid(common->key.vid));
-			/* whatever the reason why the PENDING flag was set,
-			 * this is a client which was enqueued to be removed in
-			 * this orig_interval. Since it popped up again, the
-			 * flag can be reset like it was never enqueued
-			 */
-			common->flags &= ~BATADV_TT_CLIENT_PENDING;
-			readded = true;
-		}
-
-		if (common->flags & BATADV_TT_CLIENT_ROAM) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Roaming client %pM (vid: %d) came back to its original location\n",
-				   common->key.addr,
-				   batadv_print_vid(common->key.vid));
-			/* the ROAM flag is set because this client roamed away
-			 * and the node got a roaming_advertisement message. Now
-			 * that the client popped up again at its original
-			 * location such flag can be unset
-			 */
-			common->flags &= ~BATADV_TT_CLIENT_ROAM;
-			*roamed_back = true;
-		}
-	}
-
-	return readded;
-}
-
 /**
  * batadv_tt_local_create() - allocate and initialize a local TT entry
  * @mesh_iface: netdev struct of the mesh interface
@@ -1081,27 +1030,63 @@ batadv_tt_local_create(struct net_device *mesh_iface, const u8 *addr,
 }
 
 /**
- * batadv_tt_local_update_flags() - update the dynamic flags of a local entry
+ * batadv_tt_local_refresh() - refresh a local TT entry of an active client
  * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local: the local TT entry to update
+ * @tt_local: the local TT entry to refresh
  * @iif_is_wifi: whether the client is connected via a wifi interface
  * @mark: the value contained in the skb->mark field of the received packet (if
  *  any)
+ * @announce: whether an ADD event has to be queued even when no announced
+ *  flag was modified
+ * @roamed_back: set to true when the client returned to its original location
  *
- * Return: true if a flag announced to the other nodes was modified, false
- * otherwise.
+ * A pending removal of the entry is cancelled and its dynamic flags are
+ * updated. An ADD event is queued when @announce is set, the pending removal
+ * was cancelled or a flag announced to the other nodes was modified.
+ *
+ * All checks and modifications of the flags and the queueing of the ADD event
+ * happen in a single flags_lock section. The announced flags are therefore the
+ * ones which were just stored in the entry.
  */
-static bool
-batadv_tt_local_update_flags(struct batadv_priv *bat_priv,
-			     struct batadv_tt_local_entry *tt_local,
-			     bool iif_is_wifi, u32 mark)
+static void
+batadv_tt_local_refresh(struct batadv_priv *bat_priv,
+			struct batadv_tt_local_entry *tt_local,
+			bool iif_is_wifi, u32 mark, bool announce,
+			bool *roamed_back)
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
 	u8 remote_flags;
 	u32 match_mark;
-	bool modified;
 
 	scoped_guard(spinlock_bh, &common->flags_lock) {
+		if (common->flags & BATADV_TT_CLIENT_PENDING) {
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Re-adding pending client %pM (vid: %d)\n",
+				   common->key.addr,
+				   batadv_print_vid(common->key.vid));
+			/* whatever the reason why the PENDING flag was set,
+			 * this is a client which was enqueued to be removed in
+			 * this orig_interval. Since it popped up again, the
+			 * flag can be reset like it was never enqueued
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_PENDING;
+			announce = true;
+		}
+
+		if (common->flags & BATADV_TT_CLIENT_ROAM) {
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Roaming client %pM (vid: %d) came back to its original location\n",
+				   common->key.addr,
+				   batadv_print_vid(common->key.vid));
+			/* the ROAM flag is set because this client roamed away
+			 * and the node got a roaming_advertisement message. Now
+			 * that the client popped up again at its original
+			 * location such flag can be unset
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+			*roamed_back = true;
+		}
+
 		/* store the current remote flags before altering them. This
 		 * helps understanding is flags are changing or not
 		 */
@@ -1123,10 +1108,13 @@ batadv_tt_local_update_flags(struct batadv_priv *bat_priv,
 		else
 			common->flags &= ~BATADV_TT_CLIENT_ISOLA;
 
-		modified = remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK);
-	}
+		if (remote_flags ^ (common->flags & BATADV_TT_REMOTE_MASK))
+			announce = true;
 
-	return modified;
+		if (announce)
+			__batadv_tt_local_event(bat_priv, common,
+						common->flags);
+	}
 }
 
 /**
@@ -1162,8 +1150,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 		tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
 
 	if (tt_local) {
-		added = batadv_tt_local_add_existing(bat_priv, tt_local,
-						     &roamed_back);
+		WRITE_ONCE(tt_local->last_seen, jiffies);
 	} else {
 		tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
 		if (!tt_local)
@@ -1183,18 +1170,12 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 		added = true;
 	}
 
-	/* announce the (re-)added client to the mesh */
-	if (added)
-		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
+	/* announce the (re-)added client or its modified flags to the mesh */
+	batadv_tt_local_refresh(bat_priv, tt_local, iif_is_wifi, mark, added,
+				&roamed_back);
 
 	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
-	/* if any "dynamic" flag has been modified, resend an ADD event for this
-	 * entry so that all the nodes can get the new flags
-	 */
-	if (batadv_tt_local_update_flags(bat_priv, tt_local, iif_is_wifi, mark))
-		batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
-
 	ret = true;
 out:
 	batadv_tt_local_entry_put(tt_local);

-- 
2.47.3

