Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F73C61DE1
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:28:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7151C8039D
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:28:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103712;
 b=dPjGffCf1AVEuXFCHQ7Tx8yaMw8bi8Smc+lQ6Z4yMFhBJCE4VVIDMb+2aUGRzJfwyawPg
 WDbpbuX1cXrhvLzjfSg9vXOJuMD+g6TCTz8JDf7FbHHdvugXsrcHtH/hR/+7zD2gespUC9I
 3svI3BeN9RieyGtvO6qBVkFRfYzu/Ko=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103712; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Fp72SGPZU9zD99JpUWvZN9rhc4ynHbV0KvkGcTwnMVU=;
 b=TGAylmmUye+kFPxKaGMRgimc00sg8ZbWLeQuWjYmkgGfldw42IZ+fTukxy0RvxRBjnvXs
 n8Vpp6kC2OERHcsqet+AkH9ttRFRtLjVN6p24Gtasc8cQwU0F9bSbFuGWtyjbEYFqmrIBRH
 lzDK+ESSsTKuDiP3iHWY5D4APqiEH8g=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7CC34803FF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:22:44 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103364;
	b=M/EGBHycnQOA+bXxACabS7T6MqXtxQ44OGha9Hr7n/6CgM222QIaZZCO3l9AOgLqhql/YT
	JcRYZiTv76N3QSw1sWnLqJrQKO8O38nsIq/7SWTcj3Ki3Jcb67ndDaqBSXjypaz/SwTVXe
	zwTipW7xPcvjKuxSCM4QH9XtOINTvh4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Fp72SGPZU9zD99JpUWvZN9rhc4ynHbV0KvkGcTwnMVU=;
	b=mWJFk679aNbUdteaovX35vF/y/7jdPvDw2mKOG0/9oq8K3URxKsucbC1iSIzUqWDm483Se
	JABJQ0hA5zvZB6+/cZYZ/5Yqov0yNxMDh5ZWDrcf2+fNuJ+JaSDnqdKm7b+h+jxbVzs3ve
	ib3ade1p/B6hDvFo+6jgDaLcc9xTGww=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=U0Cyzb5a;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 13D9920131;
	Sun, 30 Aug 2026 15:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fp72SGPZU9zD99JpUWvZN9rhc4ynHbV0KvkGcTwnMVU=;
	b=U0Cyzb5a5+YEEanP+2+/JSVtwgsPmsLXey559tdb5urpoYhyeyF6AA90gqMbWqNkjVmE70
	QSRhV870FNRaZb+Owh09mR6u9NBAJxuVR0SUFEnK5FVWsWs5S7IrstqkCVJDiz4Cf65nNo
	Qxv4OgKfQQhxlKS2Pa2tKZwfCY5+3N0=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:49 +0200
Subject: [PATCH batadv v6 12/20] batman-adv: tt: extract refresh of
 existing local entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-12-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4474; i=sven@narfation.org;
 h=from:subject:message-id; bh=dejKy5z8rTbALWeknzovwQYM9D6TvF54ueBgqUhAxCI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvNp55Hju3Ai32zVp+q913t847XLPM/w4wae1KtB30
 +P2lW99OkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATOWrN8N/T4kvBk/WZaVpP
 XMX3PnKu+3zsSwF7inTfPpO2yxNOfK1h+KdaaL9nw8Zfllz3Apn7lB9PVzx8U9pPUffbj1lzoqe
 K3ecCAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4CCYQFEGCS6SAVN6FVYHB4ASDVX5IRBN
X-Message-ID-Hash: 4CCYQFEGCS6SAVN6FVYHB4ASDVX5IRBN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4CCYQFEGCS6SAVN6FVYHB4ASDVX5IRBN/>
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
index a242523f..8065b2b9 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -773,6 +773,55 @@ static bool batadv_tt_iif_is_wifi(struct net *net, int ifindex)
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
@@ -887,33 +936,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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

