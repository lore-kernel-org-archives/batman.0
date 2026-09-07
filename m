Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F22FC79F9E
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:25:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 13696857C7
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:25:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769509;
 b=M7gLokcR89/nxx61ZYWnvGOa++xThB7igkJD/7DlCULZKcsyAipBt89ToCnNzsxtNmkiH
 F6DWZ2CV+3VxOcyhgIJyILYOBFxlSfBUIhCVIjWel+/P3vjfyBFPS2+LyBieScIPQhVaX0m
 KQyxL1KDkjEYNahB6q9r5jlo+odKEsY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769509; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=uaNZxQC8O9mmgTu5dTzySZJEw/1spS5Gz0etIBABIr8=;
 b=hk2sVk7eVi1dugYGDylTQARSLCDdxbl+XA/rt4KBL6xRra7B4fYVn30Ya000aZ4pcHYlP
 GL5+jqkoG2DDgTzJMqOozTQVW74yKLGILeRn5WFB62USLAc5ctqH+2ilO6aiym+iMU3Yhpg
 hAhLAxIbsxNo4cMw9vUZQjUbhcS5wb8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3773484179
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769119;
	b=wvWUteLMzzKFxwABePRNJGfCu3pEypFznrof9XlfxoCi5gJSsJ0peBwIdvwyySnfJhMVmK
	QVjkgLae9ZF6nHtGipTrvSbbGM0HdED6Xtj4pf6JdkNkHQk99H7qVkllFS8GLCnCEtnGUM
	zqDXBu/teB9Ycpw1lirxTYrAjL64anU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uaNZxQC8O9mmgTu5dTzySZJEw/1spS5Gz0etIBABIr8=;
	b=dW5tHwHw4lx/cAee88kbqupi1P6dEY1or6IMMqGwgV+iW6OvIgbUbM9Hm5ICtYmxfmzVeV
	OTAiZbOonMXpJVRr4QwpkhBZrDA5e//TGQcpHb2OJaHrizlBO5oaguQ4WwmgmfXCbxHdd2
	mv2vlxHeRwGaEaYjK+PJfHQlUFVaXaI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=VSi5lkFc;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59748D0d8C3747188e6DFE6c0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id BF8CAFA1AC;
	Mon, 07 Sep 2026 10:18:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaNZxQC8O9mmgTu5dTzySZJEw/1spS5Gz0etIBABIr8=;
	b=VSi5lkFc7V1vbOClS7FDKKyZqxsliiwB61The8Aof9Gxuyl2s4tAY7XeUDfYeb2iXS8HGA
	lZSb5YftjhQUQmdhF1hqy91bccmqR9NufSbd4tNe5WCpPrmtTxeP2wCng8MEa/2YQjyO3N
	82pQwqpyyCGmHZSPfM7QOQdBZeaOV4hNQohsU1OZ59hPZka6DUfCIkxL27i/HE7bkIaWqN
	8ekD+zFp3nF3jE2MjWc66TP2TcScHOHFtGKwT0Q9BCFc9w7xO51JFommSeor7US/ooLu2T
	vILO4lf4vV+joCQM5kQgXJb5tjfOwBeeAhzpWd9IyaUKpQ1e2DYZMN8a70dNtg==
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
Subject: [PATCH net-next 04/15] batman-adv: tt: extract refresh of existing
 local entries
Date: Mon,  7 Sep 2026 10:18:13 +0200
Message-ID: <20260907081824.2474040-5-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VGEGJPP4KRN6Q2U2ASSCBVUGZWRIFI5H
X-Message-ID-Hash: VGEGJPP4KRN6Q2U2ASSCBVUGZWRIFI5H
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VGEGJPP4KRN6Q2U2ASSCBVUGZWRIFI5H/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The handling of a client which is already part of the local translation
table is independent from the rest of batadv_tt_local_add(): it only
refreshes last_seen and evaluates the PENDING and ROAM flags of the entry
which was just looked up.

Move it to batadv_tt_local_add_existing(). It reports via its return value
whether the client has to be announced to the mesh again and whether the
client roamed back to its original location.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 78 +++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 27 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5d5f270b7eb4c..91e11e5f10140 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -720,6 +720,55 @@ static bool batadv_tt_iif_is_wifi(struct net *net, int ifindex)
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
@@ -834,33 +883,8 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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

