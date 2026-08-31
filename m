Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE57C624A4
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:59:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F41A88565C
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:59:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184784;
 b=B+UqOqTVNspnPYRq1Cg4MbbDnTbvDftNFExX0wzp6MhE8q76RvqQxynpuEUfPCEwtdKMq
 aHtwNVBUtUfbahtr+IY5+lg6mI4c5C4GcWYH53R3COtDPlNzJzMOCKCxtZk2rtwVHuAJ3nD
 OP9RTbnGguHGIDF6iHr3paYR0tNQxVM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184784; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=M17yNbbXZaFjkt4hjjms2dM3rlKCV48jAS/RCVbz2cY=;
 b=JRfCLCd+FKyq262UqpIsL+hgU6sc5aoC4tZFoZogMdXjG5BUSqv0Joxaptx/dg+pkO38Y
 p1BLxYFWLE3qsU2AF4bmjqcmV+jzlPQdO5QhtKM09uCyDHzwQoeVouEDvz+Foujgo7lvTOr
 Ed7IHy1mNUtxt49e7R9edvf016G2xck=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B6D408195C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184305;
	b=Yo42YoECw9KOEhcPUrDUnZ/o59WRWP0VKZ0R7rNqEkXrBWSduYPYHqci1RlAFy1eg5BKrI
	arXUwbAqroD/ziNiAmZmeAL+GCPOi6KVhg78saTatUBOS2gwLZk0fGvRwzCQ6rj+wJ/9Sc
	xfuxjDHXn/C25FGxMR3ht+SCcSspxhU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=M17yNbbXZaFjkt4hjjms2dM3rlKCV48jAS/RCVbz2cY=;
	b=Vqm8OtWUabGHeKtOs4TZoOmnlPAtaNFNWA5UCTZW72iqMHKFRYQTd31p+R09XO9gphm2cS
	uedKKMzqdS9Tm+1W3BCRjrpphrwTkq6JBSlCwnWdWhZg0Lr5IMbp7voR4OdFdcQiGcivxq
	F6G3jQ7jI0OWXzGSvRCskzn/4JRuUko=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=jkHLLo6G;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C5970eeDd85f51f1faa919D7a5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 6F3C5FA364;
	Mon, 31 Aug 2026 15:51:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M17yNbbXZaFjkt4hjjms2dM3rlKCV48jAS/RCVbz2cY=;
	b=jkHLLo6G/9x/pyW5wNX0rDMxv8h0QzgS0MusCmImBqNtkujuFFKW3TqgIekMgNV+JLuavM
	RqQznr3hplj3oeWqCI+Q9biP8Q+iFsxgJQDXOmrwn20MWgVw089qzdrc0DwJBPr4UFnpWH
	Ih1bLOj0O0YFkFvwbLX3UeH1TmSl4xakd9BCSch4+JUe3mx8Hl/S6c7v2TyDyt28meFYWI
	T6Ju6yhULMyqgJLgEgv8MJAWUaKt46CEIDnmuyFoJyGBeHq4c84paxDI35BJsESHOIDYLD
	5uY0zPJjy8RHRPo3aRpLq3OkUpgf7FDoxWDoKCtdDbd8KUjOhNIAeew+wo15yg==
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
Subject: [PATCH net-next 09/15] batman-adv: tt: extract code handling a roam
 on add
Date: Mon, 31 Aug 2026 15:51:11 +0200
Message-ID: <20260831135117.574836-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 2H2T22PH2ANHEA2GNZ4UCWMUQ7TPSACZ
X-Message-ID-Hash: 2H2T22PH2ANHEA2GNZ4UCWMUQ7TPSACZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2H2T22PH2ANHEA2GNZ4UCWMUQ7TPSACZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The code for handling the roaming of clients is mostly self contained but
embedded in the already too large batadv_tt_local_add function. The
maintainability can be improved by keeping it in an separate function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 71 +++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 66456a2d45e26..01c74d4a7e521 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -614,6 +614,50 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
 	batadv_tt_global_entry_put(tt_global);
 }
 
+/**
+ * batadv_tt_local_add_roam() - handle roamed clients during batadv_tt_local_add()
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_global: the global TT entry
+ * @roamed_back: whether @tt_global roamed back
+ */
+static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
+				     struct batadv_tt_global_entry *tt_global,
+				     bool roamed_back)
+{
+	struct batadv_tt_orig_list_entry *orig_entry;
+	struct hlist_head *head;
+
+	if (!tt_global)
+		return;
+
+	/* Check whether it is a roaming, but don't do anything if the roaming
+	 * process has already been handled
+	 */
+	if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
+		return;
+
+	/* These node are probably going to update their tt table */
+	head = &tt_global->orig_list;
+	rcu_read_lock();
+	hlist_for_each_entry_rcu(orig_entry, head, list) {
+		batadv_send_roam_adv(bat_priv, tt_global->common.addr,
+				     tt_global->common.vid,
+				     orig_entry->orig_node);
+	}
+	rcu_read_unlock();
+
+	if (roamed_back) {
+		batadv_tt_global_free(bat_priv, tt_global,
+				      "Roaming canceled");
+	} else {
+		/* The global entry has to be marked as ROAMING and
+		 * has to be kept for consistency purpose
+		 */
+		tt_global->common.flags |= BATADV_TT_CLIENT_ROAM;
+		tt_global->roam_at = jiffies;
+	}
+}
+
 /**
  * batadv_tt_local_add() - add a new client to the local table or update an
  *  existing client
@@ -632,14 +676,12 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 {
 	struct batadv_priv *bat_priv = netdev_priv(mesh_iface);
 	struct batadv_tt_global_entry *tt_global = NULL;
-	struct batadv_tt_orig_list_entry *orig_entry;
 	struct batadv_tt_local_entry *tt_local;
 	struct net *net = dev_net(mesh_iface);
 	struct net_device *in_dev = NULL;
 	struct batadv_meshif_vlan *vlan;
 	bool roamed_back = false;
 	bool iif_is_wifi = false;
-	struct hlist_head *head;
 	int packet_size_max;
 	bool ret = false;
 	u8 remote_flags;
@@ -758,30 +800,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
 	batadv_tt_local_event(bat_priv, tt_local, BATADV_NO_FLAGS);
 
 check_roaming:
-	/* Check whether it is a roaming, but don't do anything if the roaming
-	 * process has already been handled
-	 */
-	if (tt_global && !(tt_global->common.flags & BATADV_TT_CLIENT_ROAM)) {
-		/* These node are probably going to update their tt table */
-		head = &tt_global->orig_list;
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(orig_entry, head, list) {
-			batadv_send_roam_adv(bat_priv, tt_global->common.addr,
-					     tt_global->common.vid,
-					     orig_entry->orig_node);
-		}
-		rcu_read_unlock();
-		if (roamed_back) {
-			batadv_tt_global_free(bat_priv, tt_global,
-					      "Roaming canceled");
-		} else {
-			/* The global entry has to be marked as ROAMING and
-			 * has to be kept for consistency purpose
-			 */
-			tt_global->common.flags |= BATADV_TT_CLIENT_ROAM;
-			tt_global->roam_at = jiffies;
-		}
-	}
+	batadv_tt_local_add_roam(bat_priv, tt_global, roamed_back);
 
 	/* store the current remote flags before altering them. This helps
 	 * understanding is flags are changing or not
-- 
2.47.3

