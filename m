Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3F8C61DD6
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:25:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9F0BA83CF3
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:25:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984725;
 b=IUvqAi2/tyHdCZX27IolQo4h3OPxftYVKjBRQ48JMf0B5KbdLmaOZCa4I5wxfTe/hNqBl
 E9suaryWiOiv2AdN1LRBqvSW4TiThqOo1OVNonDmSEjWSCZx6wLfzxsZCsVphAe7B0Nk6c/
 6aECJppvKBOXXwUa5skDZ0OHOv6sdac=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984725; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fph2l5kZWsq3QPlQP2VH2MrIa/rfELusD62fR8SBGmQ=;
 b=bgLPdln+S/IpHpiYPc5Qa+x/HbEB7xy7eM/1uCxXn9j4YegJeWGZpSMindgJ2qtqswXbP
 pxgtLm1E9dXEqydq4v7Oq0dB9Qbv8uPUelUUGYzbOrrgW5bQ3IlaUTWCe0Ca/Q+8Pzlkmeh
 xt7/VzYNLqgoMpyVhvR2QwtO7tLEuAg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 700CC842E6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:21:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984492;
	b=qRDW0BqdiTEQo9RHU/OQGYHM+4fHKvCh7kWslB7JI5IgFEc8nfJpYQZrU+Pvl+7XrKKY4V
	81O4iEL2TOOiVfnvQyw5xHjIGbtd/7IpSlJ8Zze+NtBIC9+jdY4JFcsznsFELuqHhHFBVW
	aeHJxAgWY9eu2HZuPFYOfzzN7MoKP9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=fph2l5kZWsq3QPlQP2VH2MrIa/rfELusD62fR8SBGmQ=;
	b=iA/HShIjDqJaev0SNB/NpZ/OGGeomPDogSoCdbdgrRBcpEF2uJbiws/gNmdNK0IOGe2Nv3
	hYH5Z/pUHQISFFm12CvdEgz0jjzoOTROvz5giwXlAmCinBSStxqjc+3goVsNif2+SexV+b
	ojuywCV0tIcBLCEslTKvjZI975A8CgA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=bwskdobs;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 10D51200E4;
	Sat, 29 Aug 2026 06:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fph2l5kZWsq3QPlQP2VH2MrIa/rfELusD62fR8SBGmQ=;
	b=bwskdobsmJDXyia+L63LQyIEpnkqY89kq3/KQWfujrfrKSrvGVX9343C4x0jL/CmOmKygo
	zQHAu0CWwkJ4dIlZRf2TnbQyBj8hLLNACRIWQzP0e0tXfhzT6xGXzr/aQbGWzALBGwclo2
	DCk7r/JwatAqIfd2c6EX2H38gk6OXPc=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:23 +0200
Subject: [PATCH batadv v5 12/20] batman-adv: tt: extract refresh of
 existing local entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-12-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4474; i=sven@narfation.org;
 h=from:subject:message-id; bh=hPNY1ewlXwj20+9UGYe3QVXCkqm+PN+GxBrgTKtFAGg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKtdKFtWfSlb82Wq0w7CZJezmx5vchlM/Ki7l3LRG9
 xpHhpt0RykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAivDMYGR7GvEzbJpkTXLfd
 9OISi31XBO2OXH3v3Mdb4OFX+tqpeArDf79ogb6oF2Z9a1mNphtsqZ99RfV00tzjJ5/23VLdsHD
 RPRYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: SLCUXLQDUBH626N46LN7REWQVKYXK4LE
X-Message-ID-Hash: SLCUXLQDUBH626N46LN7REWQVKYXK4LE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SLCUXLQDUBH626N46LN7REWQVKYXK4LE/>
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

