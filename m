Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F48DC56208
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 09:47:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D6D1284299
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 11:47:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786009632;
 b=xGlS52h6O2bauumW6lTS2RMcP5EdlYseDJc3ITFXlDM8nO9jf7wgUO1Dk/BAVIKihEUkc
 vg6ie7KuwYLOu2bZl6lTaAOhoZsoB/3N3CtP7evlLau/uKCT1vOREojBPDJ7Cr3DiwsCJky
 CxP4GzAhrc1UmzT62/nzSC+sN3fI1E4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786009632; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fph2l5kZWsq3QPlQP2VH2MrIa/rfELusD62fR8SBGmQ=;
 b=qh7wi9ncNdigHJxJaixWgFip6/mzv4rVTW3xIYHnGMIHKWNPqXDaHO1W1bl5+nCaO6EIx
 k19F7bolNurU341WnRqyTOCHnziz5FbWYqgHHTZfho0JX9weYA1txL0LZZD233LtVj+58hb
 0xp6gSlzBe/rAmgsEwwMENQODlpH0E8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A28FB8161B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 11:45:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786009513;
	b=CHeKeEIIHStIXhvXs5X02WJK3GqANN2w9RB1EfN9iNCr6/POG81kJEIJiI/oy1jofo1ccI
	aKPZ0zTXvoKKkt7gQxPmy6HyFUjxtC7WrextM+Fh+w/RHOOCza4qkxP6k/3E0Tq2PJrjX4
	9y0fGpAbWooKJOOCUGGSaMIeW7Bkd18=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786009513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fph2l5kZWsq3QPlQP2VH2MrIa/rfELusD62fR8SBGmQ=;
	b=HUxg0QBkBb6UROOFsbmYVkcFqlnVKajC7RQ1uw08Fu/YSykq24FeJg+BQLkzihXiR5etIx
	KiYybA5xDy7vxf93sZaCrNXilUjlOTgBygJM7meQ/MMXh3Q8LpCvzjoCeJyuiCBnkUoL4g
	taKp9Lwz6hQ/IoqFFwuKDMwNnNk0VoM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZTxg8QxJ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 358ED20590;
	Thu, 06 Aug 2026 09:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786009509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fph2l5kZWsq3QPlQP2VH2MrIa/rfELusD62fR8SBGmQ=;
	b=ZTxg8QxJpEAtPmc84jm5mXJWASqHYbquU5cOsiTmGXMgmNKGlifPIX1/M7f+Q6pVsj8erC
	Dw323rIEQ86h1bbN/p/IIfstesxmjBeNBI7Z+BucFww0XbR3AO6Mcs1ZewedY4hs/u9DhS
	3OFb3ISnBtujI/9eamSxPzlk1R07+Uk=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 11:44:17 +0200
Subject: [PATCH RFC batadv 04/12] batman-adv: tt: extract refresh of
 existing local entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-add-cleanup-v1-4-ffcad65bccc4@narfation.org>
References: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
In-Reply-To: <20260806-tt-add-cleanup-v1-0-ffcad65bccc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4474; i=sven@narfation.org;
 h=from:subject:message-id; bh=hPNY1ewlXwj20+9UGYe3QVXCkqm+PN+GxBrgTKtFAGg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkl4c3HTNlKTa+ffVRZfeUEkzzDLBm5bImq1pt/tEzvH
 lEImTCro5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRxy4M/72t41j+nnlQvfHU
 VMdJbx6Uf8iRqjw2I3GV3E0WrjonFXWGv2KJJ7ZGnLkzszhn/8LCB5e/MiUqzFnSdP3CyUOiO/X
 KejgA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2TGXRYL2QGBJRD2GIA5A5T5BFSRRGNHD
X-Message-ID-Hash: 2TGXRYL2QGBJRD2GIA5A5T5BFSRRGNHD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2TGXRYL2QGBJRD2GIA5A5T5BFSRRGNHD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The handling of a client which is already part of the local translation
table is independent from the rest of batadv_tt_local_add(): it only
refreshes last_seen and evaluates the PENDING and ROAM flags of the entry
which was just looked up.

Move it to batadv_tt_local_add_existing(). It reports via its return value
whether the client has to be announced to the mesh again and whether the
client roamed back to its original location.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 78 +++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 27 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5405be65..ca9956be 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -772,6 +772,55 @@ static bool batadv_tt_iif_is_wifi(struct net *net, int ifindex)
 	return batadv_is_wifi(wifi_flags);
 }
 
+/**
+ * batadv_tt_local_add_existing() - refresh an already known local TT entry
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_local: the local TT entry which was found in the local table
+ * @roamed_back: set to true when the client returned to its original location
+ *
+ * Return: true when the client has to be announced to the mesh again, false
+ * otherwise.
+ */
+static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
+					 struct batadv_tt_local_entry *tt_local,
+					 bool *roamed_back)
+{
+	struct batadv_tt_common_entry *common = &tt_local->common;
+
+	tt_local->last_seen = jiffies;
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		if (common->flags & BATADV_TT_CLIENT_PENDING) {
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Re-adding pending client %pM (vid: %d)\n",
+				   common->addr, batadv_print_vid(common->vid));
+			/* whatever the reason why the PENDING flag was set,
+			 * this is a client which was enqueued to be removed in
+			 * this orig_interval. Since it popped up again, the
+			 * flag can be reset like it was never enqueued
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_PENDING;
+
+			return true;
+		}
+
+		if (common->flags & BATADV_TT_CLIENT_ROAM) {
+			batadv_dbg(BATADV_DBG_TT, bat_priv,
+				   "Roaming client %pM (vid: %d) came back to its original location\n",
+				   common->addr, batadv_print_vid(common->vid));
+			/* the ROAM flag is set because this client roamed away
+			 * and the node got a roaming_advertisement message. Now
+			 * that the client popped up again at its original
+			 * location such flag can be unset
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+			*roamed_back = true;
+		}
+	}
+
+	return false;
+}
+
 /**
  * batadv_tt_local_create() - allocate and initialize a local TT entry
  * @mesh_iface: netdev struct of the mesh interface
@@ -886,33 +935,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 		tt_global = batadv_tt_global_hash_find(bat_priv, addr, vid);
 
 	if (tt_local) {
-		tt_local->last_seen = jiffies;
-
-		spin_lock_bh(&tt_local->common.flags_lock);
-		if (tt_local->common.flags & BATADV_TT_CLIENT_PENDING) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Re-adding pending client %pM (vid: %d)\n",
-				   addr, batadv_print_vid(vid));
-			/* whatever the reason why the PENDING flag was set,
-			 * this is a client which was enqueued to be removed in
-			 * this orig_interval. Since it popped up again, the
-			 * flag can be reset like it was never enqueued
-			 */
-			tt_local->common.flags &= ~BATADV_TT_CLIENT_PENDING;
-			added = true;
-		} else if (tt_local->common.flags & BATADV_TT_CLIENT_ROAM) {
-			batadv_dbg(BATADV_DBG_TT, bat_priv,
-				   "Roaming client %pM (vid: %d) came back to its original location\n",
-				   addr, batadv_print_vid(vid));
-			/* the ROAM flag is set because this client roamed away
-			 * and the node got a roaming_advertisement message. Now
-			 * that the client popped up again at its original
-			 * location such flag can be unset
-			 */
-			tt_local->common.flags &= ~BATADV_TT_CLIENT_ROAM;
-			roamed_back = true;
-		}
-		spin_unlock_bh(&tt_local->common.flags_lock);
+		added = batadv_tt_local_add_existing(bat_priv, tt_local,
+						     &roamed_back);
 	} else {
 		tt_local = batadv_tt_local_create(mesh_iface, addr, vid, iif_is_wifi);
 		if (!tt_local)

-- 
2.47.3

