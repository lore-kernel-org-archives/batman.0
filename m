Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCF8C5518F
	for <batman-adv@archiver.kernel.org>; Tue,  4 Aug 2026 10:19:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8BDEB8417B
	for <batman-adv@archiver.kernel.org>; Tue, 04 Aug 2026 12:19:56 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785838796;
 b=Gm20fOhFgvqh3U108f4vIl9CvoUlWDEoOOoEWlKT9867r4F/h419M0dy+WZqiRY59BQwl
 NH7V+A2z/mgRTDo+skl5aBUUy697NfRjiOfPHYbhQujq47f/JyR7e3FwUApgU7eB4JIIJgJ
 WCaEkVrnLgTP86uxX22cgLDsOG0dxp4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785838796; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Amjff2WWxRe7p1zqEYWtzp7p6nXgyLWm0YMZZxleEfk=;
 b=fgtYIvRIxXUW1gd7VNJTpowAHNbTPqcZAUCfd1O6G6alCNtXhT8M5L85Ija6E++nVJ1UL
 yk27CPsOGT0bqN3JwCVfQEHzsdtN0m8cm4TJ84wN+x0sKVDXeAR3COiKMYSg4CMNoxGuVh7
 aGP0A0g6UeA2z8OI6vVqFixa57IfU3M=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6C9108405E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 04 Aug 2026 12:18:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785838739;
	b=htWaeVcoiw8a4ZcVkofU8qBCrojKJBDIwTurpHtqUBYFmaiC1xnQJme3wJoQphoJiQJZtQ
	eSfIr5o/C1fHroDQEFxE/HHgb6+lbrir45q8XBwF9eLTI52DbpiBUIvP+L8vVHCsaHDeSB
	O0tPzjGOxedo2saUXWqByypI6INHol4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785838739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Amjff2WWxRe7p1zqEYWtzp7p6nXgyLWm0YMZZxleEfk=;
	b=irNpYNRdWZubOk6BLWC/sk8X16RCGlL1fMNAkPmipJ1siglq6w5YMoD4CN3ZcTweAEqXJ3
	M+SMmZI23p5Ph+Hm/qk5MQielLkIU5/Df13CR4jekmYXKTka2JBrwQQ3Q4OxVmf8bnIC6z
	a6OxUaCumZ+K1o9r/8BHJxaVJGuPv8A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iTSF4Y+E;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 05DA920210;
	Tue, 04 Aug 2026 10:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785838735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Amjff2WWxRe7p1zqEYWtzp7p6nXgyLWm0YMZZxleEfk=;
	b=iTSF4Y+EVli6M6040nBnN4rk4iUqMuk5d9BHAN/LRH9Qv19L9gZimJvW728gJRPSmcxCLO
	u5xMbkrhDVo8GqoJDoe3t1aglfpMypjI9zFwLyR/leYACE1t7Q9KA9Kr6hY6riIXoga4bC
	Biln1yqF/sVdpcj0cAOGYrs9kJaXK00=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 04 Aug 2026 12:18:13 +0200
Subject: [PATCH batadv v2 2/6] batman-adv: tt: extract code handling a roam
 on add
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-tt-fixes-v2-2-487c48fc7fc4@narfation.org>
References: <20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org>
In-Reply-To: <20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4026; i=sven@narfation.org;
 h=from:subject:message-id; bh=Hgi4EjdSKJlkg5yyPcewRcS19RCvc/ufPhJ7duG47D4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmFezLfZDXe37yLz5L93//dfJ+fO28659438e2Elqb1C
 zfkLzyn2lHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYiC0Tw//ACy+DL95S0/Zg
 0p2Qe/qtho/F8/5M+eOz21j94tMPGi5lZPiYN6eX4ez32Pd9q04E3T3ityG9M1UpWvPcsw1z2Ba
 cncwNAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: AVZXKL6V2ZRU4OIBLVN4DOTJXD5V6U3V
X-Message-ID-Hash: AVZXKL6V2ZRU4OIBLVN4DOTJXD5V6U3V
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AVZXKL6V2ZRU4OIBLVN4DOTJXD5V6U3V/>
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

