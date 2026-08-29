Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA74C61DD6
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:19:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DAA1383C5C
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:19:33 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984373;
 b=KYlVXraRJjDkure+LKS1Ft/xCD+F/lhb+UklKyF5Z8RSu2TTUOGZcPQB+CWm+8YL7MziK
 NJivpNnAN75ytIJ1fv52ntMngvm7QvneHHkt8dFarp5/kNf22hb0OBzGNFUKP7n+pfJLcVI
 lvbBqMI0CCXKMJN7IWR30Mp5O3duFfs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984373; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Amjff2WWxRe7p1zqEYWtzp7p6nXgyLWm0YMZZxleEfk=;
 b=thLZbaTChyak0su0xi7txQvUjxjDTIutFuDcQyHqu+Z/1n7FNaXuLqscyYH6C2C1rQhQ2
 8tNSlvr5ZBf1z5utUmb4P9PqTq4O2rqzuj7isBsupi7bgW3M14dxlUHYqxCmwQ7vGUcvHhY
 oKSEW80WwO75C4F2pEyMVnngGvap+FA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AC1DB83C7E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:19:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984346;
	b=Y+0nLyvdeNZ+11q8NYqVxPD+E+v8nr11T+pnjmwSCUY4TVtyIDdcUItV8WESYIQwU5bgmD
	N+2OcDV4pnmWCftd6VuZGe8D0RxBLcPnw5bb6N2trXwA1zitIm2yah5ZwhfnxTPm1gRDqs
	KcYkdDl3Gtvjg0aHAT27x7s+2imYwJ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Amjff2WWxRe7p1zqEYWtzp7p6nXgyLWm0YMZZxleEfk=;
	b=h03MZnC5aOY/U+WwbPtu8yLD1I0YKdrATgRjCIvOdH+0D/xlHjUQj8hkO/u3KwOFQ6qE3C
	LXS8GwzVgxSGmrkYc4WGHiKwpsAvvKOmTHm7Qq6T94X+rAKxFROv3AuQBRRmSirQTCZs6F
	VHtbIRx7cvXMeY3pLTvCYXNPcmHmgUE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=vSz5njdi;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BC8381FEC4;
	Sat, 29 Aug 2026 06:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Amjff2WWxRe7p1zqEYWtzp7p6nXgyLWm0YMZZxleEfk=;
	b=vSz5njdigcM2vJzSV+3+u+qw30Av8OnXZ1ZU1oo2GUV4r4HWUU5dTNiFrMNoaC7EoPpoUF
	UXMdPFSSYg3Nk5dUtL90cfTnsGuOn6kWu2kGWWsgv64Z9KlckZhLRhjzgbeemuWVlP2cAJ
	iv0UF8PCojfJV59qJJbmOXjbIY7kXXI=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:13 +0200
Subject: [PATCH batadv v5 02/20] batman-adv: tt: extract code handling a
 roam on add
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-2-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4026; i=sven@narfation.org;
 h=from:subject:message-id; bh=Hgi4EjdSKJlkg5yyPcewRcS19RCvc/ufPhJ7duG47D4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKle7LTV89GfCZFMXdt4JBQu9A1Lf5y2b1TjhmbpDg
 f5NGYOtHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJGMQx/PexNxDI5si+cvBQ
 4F/t6NdX0s8Gak8ykXubfqWzJKl1lT8jwzGVp9Hhfdtf1G1XSDfc5tGztlWg7+26jE+BdS82bZf
 bxQ0A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 6LFOESILG5W3EE3SDOGQ6QVBVEK5FR6H
X-Message-ID-Hash: 6LFOESILG5W3EE3SDOGQ6QVBVEK5FR6H
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6LFOESILG5W3EE3SDOGQ6QVBVEK5FR6H/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The code for handling the roaming of clients is mostly self contained but
embedded in the already too large batadv_tt_local_add function. The
maintainability can be improved by keeping it in an separate function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 71 ++++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index af40ff81..2a1d8963 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -667,6 +667,50 @@ static void batadv_tt_global_free(struct batadv_priv *bat_priv,
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
@@ -685,14 +729,12 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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
@@ -811,30 +853,7 @@ bool batadv_tt_local_add(struct net_device *mesh_iface, const u8 *addr,
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

