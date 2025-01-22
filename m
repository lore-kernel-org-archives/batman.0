Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14659C02181
	for <batman-adv@archiver.kernel.org>; Wed, 22 Jan 2025 20:52:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8CA6A841E8
	for <batman-adv@archiver.kernel.org>; Wed, 22 Jan 2025 21:52:20 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737579140;
 b=kgauLDgLWrfbQzNxO5qiYRWb0j5R1tGbSfK+4VxFhMjKyPszpPgxl67NYGTs8pxj/a8tt
 UtPIJ5NA28aiQaKoD6jfqecZ9sktQZcTGYS6POmXnC0stbH20uoIePo6BA7jlq8ppYfO7z0
 78p1inT3UG547m9/NxNNvo0H0YfWa5w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737579140; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wOkwYCACqCv5touvt8k9h7pTCHSzk//xesLOrR9Asqg=;
 b=pNVbRv7zYu2V6sl1XbWEzLJMh6oyBldTuvgLxVsRYt/amxuL0Mm/eJJ97/wElSbUPKz7J
 0uwZf/q2VPVn4MoekH2jEQdJgOuWPbUE7+vLfLS9qlj2ykUnanHxKpaaE65fH226tWDRa4I
 Idydx42E7LaMegkL+zuDAH9Zwe9An28=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E7776821A9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 22 Jan 2025 21:51:30 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737579091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wOkwYCACqCv5touvt8k9h7pTCHSzk//xesLOrR9Asqg=;
	b=A/d02/PTfUN++cQUpYT/BMMH7LRNk2JzLuYfeLsPdF1+MhfVB7UMRk29wVHMZ5hugNXF16
	6BXloA8sFZ/JRsJgLBkZnpt+XwryRQp0R5l56Xa91vlGGFw7EfSJnTXm7YPMbEo4CWoU1V
	1x+OaL+o3yhsPFdtH1YZRuH4tE1BxFA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=vD6fWp1f;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737579091; a=rsa-sha256;
	cv=none;
	b=fT2n1R5+TB5YA3dRpoTlqM+Q1JUwSPMgqifueXlhO6A0ISA4gq1lICBP++RiuIHPq79k02
	FVlfm9l4wZLqRwN8g2HwMk8HjwUrtw9wBuYc9tXfUMSisQT3mM/AtSs3l3d/uw653bbBi7
	PdU2yx4eopzJU4igYHBnogYTE21GWy8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1737579090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wOkwYCACqCv5touvt8k9h7pTCHSzk//xesLOrR9Asqg=;
	b=vD6fWp1f1Tzg5KpRHitZF+1MCUsXomgkeDP6py2QumNSKINXcRMKUjv9oKOXknJ5LANgbp
	NykwMinUWvPiaNJx2ekBnXJ6hojdz7qX6Apq95K3rB4a49At1OGNRk8U8rBqL8ABbe1Mmc
	y82JEUI7BeCl6XpL+TUa3IQVDKBAQOc=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 22 Jan 2025 21:51:20 +0100
Subject: [PATCH 1/2] batman-adv: Ignore neighbor throughput metrics in
 error case
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250122-fix-metric-update-v1-1-c489b3f82f6d@narfation.org>
References: <20250122-fix-metric-update-v1-0-c489b3f82f6d@narfation.org>
In-Reply-To: <20250122-fix-metric-update-v1-0-c489b3f82f6d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4636; i=sven@narfation.org;
 h=from:subject:message-id; bh=EniJmwcaSN2ZB9qjMMpmE24bfdV1Hl66zg6CaZOTbwU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOkTo7z8NzvZzbkVXGtzzGHHNMf9vHe9p038+3vJI/1dq
 0r0SqZLdJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmclKNkeEC50odsRcW/L1f
 Wa451let0BB7k2Q+O+1mzKViz4mT/p1nZNi9OrSy7kz/HhnLt7rMB8MvOEuy7Z4zRe/4AbNe/nD
 fgwwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ITULMXN4CB5RWNXTHDUHALMZODQSM5ZG
X-Message-ID-Hash: ITULMXN4CB5RWNXTHDUHALMZODQSM5ZG
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ITULMXN4CB5RWNXTHDUHALMZODQSM5ZG/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If a temporary error happened in the evaluation of the neighbor throughput
information, then the invalid throughput result should not be stored in the
throughtput EWMA.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_v_elp.c | 50 +++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index fbf499bcc6718c677bf0e34c50576612927d0d9d..65e52de52bcd2688e0ed33cd8605821b17f5a63b 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -59,11 +59,13 @@ static void batadv_v_elp_start_timer(struct batadv_hard_iface *hard_iface)
 /**
  * batadv_v_elp_get_throughput() - get the throughput towards a neighbour
  * @neigh: the neighbour for which the throughput has to be obtained
+ * @pthroughput: calculated throughput towards the given neighbour in multiples
+ *  of 100kpbs (a value of '1' equals 0.1Mbps, '10' equals 1Mbps, etc).
  *
- * Return: The throughput towards the given neighbour in multiples of 100kpbs
- *         (a value of '1' equals 0.1Mbps, '10' equals 1Mbps, etc).
+ * Return: true when value behind @pthroughput was set
  */
-static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
+static bool batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh,
+					u32 *pthroughput)
 {
 	struct batadv_hard_iface *hard_iface = neigh->if_incoming;
 	struct net_device *soft_iface = hard_iface->soft_iface;
@@ -77,14 +79,16 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	 * batman-adv interface
 	 */
 	if (!soft_iface)
-		return BATADV_THROUGHPUT_DEFAULT_VALUE;
+		return false;
 
 	/* if the user specified a customised value for this interface, then
 	 * return it directly
 	 */
 	throughput =  atomic_read(&hard_iface->bat_v.throughput_override);
-	if (throughput != 0)
-		return throughput;
+	if (throughput != 0) {
+		*pthroughput = throughput;
+		return true;
+	}
 
 	/* if this is a wireless device, then ask its throughput through
 	 * cfg80211 API
@@ -111,19 +115,24 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			 * possible to delete this neighbor. For now set
 			 * the throughput metric to 0.
 			 */
-			return 0;
+			*pthroughput = 0;
+			return true;
 		}
 		if (ret)
 			goto default_throughput;
 
-		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT))
-			return sinfo.expected_throughput / 100;
+		if (sinfo.filled & BIT(NL80211_STA_INFO_EXPECTED_THROUGHPUT)) {
+			*pthroughput = sinfo.expected_throughput / 100;
+			return true;
+		}
 
 		/* try to estimate the expected throughput based on reported tx
 		 * rates
 		 */
-		if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE))
-			return cfg80211_calculate_bitrate(&sinfo.txrate) / 3;
+		if (sinfo.filled & BIT(NL80211_STA_INFO_TX_BITRATE)) {
+			*pthroughput = cfg80211_calculate_bitrate(&sinfo.txrate) / 3;
+			return true;
+		}
 
 		goto default_throughput;
 	}
@@ -142,8 +151,10 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 			hard_iface->bat_v.flags &= ~BATADV_FULL_DUPLEX;
 
 		throughput = link_settings.base.speed;
-		if (throughput && throughput != SPEED_UNKNOWN)
-			return throughput * 10;
+		if (throughput && throughput != SPEED_UNKNOWN) {
+			*pthroughput = throughput * 10;
+			return true;
+		}
 	}
 
 default_throughput:
@@ -157,7 +168,8 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 	}
 
 	/* if none of the above cases apply, return the base_throughput */
-	return BATADV_THROUGHPUT_DEFAULT_VALUE;
+	*pthroughput = BATADV_THROUGHPUT_DEFAULT_VALUE;
+	return true;
 }
 
 /**
@@ -169,15 +181,21 @@ void batadv_v_elp_throughput_metric_update(struct work_struct *work)
 {
 	struct batadv_hardif_neigh_node_bat_v *neigh_bat_v;
 	struct batadv_hardif_neigh_node *neigh;
+	u32 throughput;
+	bool valid;
 
 	neigh_bat_v = container_of(work, struct batadv_hardif_neigh_node_bat_v,
 				   metric_work);
 	neigh = container_of(neigh_bat_v, struct batadv_hardif_neigh_node,
 			     bat_v);
 
-	ewma_throughput_add(&neigh->bat_v.throughput,
-			    batadv_v_elp_get_throughput(neigh));
+	valid = batadv_v_elp_get_throughput(neigh, &throughput);
+	if (!valid)
+		goto put_neigh;
+
+	ewma_throughput_add(&neigh->bat_v.throughput, throughput);
 
+put_neigh:
 	/* decrement refcounter to balance increment performed before scheduling
 	 * this task
 	 */

-- 
2.45.2

