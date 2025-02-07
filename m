Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60246C02196
	for <batman-adv@archiver.kernel.org>; Fri,  7 Feb 2025 10:00:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A907884306
	for <batman-adv@archiver.kernel.org>; Fri,  7 Feb 2025 11:00:03 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738922403;
 b=jtYf6zzkcRdSbsX/lpBY5ID8bJyesqHA+L9pYEHc2Cfteu3dyRmNy4MmpV1lxdHUKhVUY
 c8PaInNv/oR15DjkNCc3ZM8E2cBQqicLD4Plf0ypnR3U69b2VBT83sMbaaOVfBf0s8ebac9
 hk/WiN13yR3lEDYxZOVwjCXbvaFiSw4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738922403; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VeQZOe2062ckw14aTYt7lQaBVa+xEFPu7zySio1JJbE=;
 b=1dLPa/OTpyRkFbgf8vKT8CPyUQ67Ms0oKE1AE03Fc6KWEKK7Hwtw2nojOy/crx9qQq4/T
 nnO/wo/NiWq/A/22/QDwzmBeegwtcjIjMw44AXo+RxbGjJMyvYAXGcQaKn3rysZz+r728cG
 W5kzWvusO22vfh7Bnv+4QIdv0mq4P0Q=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 52DB981F75
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  7 Feb 2025 10:58:31 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738922311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeQZOe2062ckw14aTYt7lQaBVa+xEFPu7zySio1JJbE=;
	b=FACpA6p4q6NrrFqXtUq69TmridYxbtUvjcFz8x10SgBkqBej+bE3IIwXvVv2tKpQmW9QdM
	lTeISxPpPpWP3xrFEKoy2BYVL9PthpiXyokYQWqj326foVQwd1tBZ/lMb4rAfJYJSKbhC7
	qWk30fieCSDSwEqhtAONuPEk117CxiQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738922311; a=rsa-sha256;
	cv=none;
	b=vMZ8hWRSHe2ZE8ziD/xxE51CE42Sqskdd7O8LF6Kkac2ETGTHVYCDocUONcp+eP7VHA6v9
	k5ZBRtHZibKnSB2Vz3zo5DNUz2quptgoulxUNge+v3dM+3DtMel1lpE7VLro5Q/fKvS/FF
	vaRXugdMBh2yA93nBlsUPqeyMEZxno0=
Received: from kero.packetmixer.de
 (p200300c59725EfD8c202009b11B64500.dip0.t-ipconnect.de
 [IPv6:2003:c5:9725:efd8:c202:9b:11b6:4500])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id D13B4FA197;
	Fri,  7 Feb 2025 10:58:30 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 2/4] batman-adv: Ignore neighbor throughput metrics in error
 case
Date: Fri,  7 Feb 2025 10:58:21 +0100
Message-Id: <20250207095823.26043-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250207095823.26043-1-sw@simonwunderlich.de>
References: <20250207095823.26043-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MRRLO6EJVDEWBPVTAWRWYZ77FFW2EECJ
X-Message-ID-Hash: MRRLO6EJVDEWBPVTAWRWYZ77FFW2EECJ
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MRRLO6EJVDEWBPVTAWRWYZ77FFW2EECJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

If a temporary error happened in the evaluation of the neighbor throughput
information, then the invalid throughput result should not be stored in the
throughtput EWMA.

Cc: stable@vger.kernel.org
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c | 50 ++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index fbf499bcc671..65e52de52bcd 100644
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
2.39.5

