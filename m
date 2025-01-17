Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86866C02183
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 02:16:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0EA22840D2
	for <batman-adv@archiver.kernel.org>; Fri, 17 Jan 2025 03:16:20 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1737080180;
 b=WefbbWqucZZ4HCj+yDCD82KGFvsJTuLUpAkGSE5Va7IVERmQX7noeqGPJRHntKchnqYwK
 OXj0HJdmxVysYjcBL973PFPllpDerINPyxn00PJyTvS7AJ2v6tQwlDwh9nsl1rWadFvo/8+
 nT0Wgvu7+u0tixY7Gs2XtD5r9ZuVpcU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1737080180; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OhZ6z1BmzL5/trqhCQ4yYaWH+FSFGaS2++DLjrPFH8s=;
 b=WKbrBk5Vzw8btGQcqBTaLPjO6Ssvf1UsAkoR5tWePhzGPRB63fQMyZNZkN68+y1YpGRe/
 yDELmF17GCMO8OqwUj5+AJu0wUTysFJZoxS41tvG1PEhlb3v7JU4DuZ/WLXFxLPpQ6nTtbu
 qScQR9gecmtghP+wqlesKMF3Wz8fF6g=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D369E81415
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 17 Jan 2025 03:13:55 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1737080036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhZ6z1BmzL5/trqhCQ4yYaWH+FSFGaS2++DLjrPFH8s=;
	b=2DoLELOMFEhldBBMIijcSxwKZ2DQH2VrW7Jmp/YNX8yZdFp6WLP/VW3Y0lxJ8g6JApc0L0
	uhlBzkr+/TBSZWH6QepUkVkb/ua4y6lVaQ8PdGwZe1dGtnYp+fIUlH6MnBqkIvGu7uZqdl
	3ztUb/Gu4yBjRjDbPBFe5iga85F9C4g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue;
	dmarc=none
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1737080036; a=rsa-sha256;
	cv=none;
	b=Qv/+41PosZuJ/rJc9uZP8M3+mZmfQ4xeGiMfWRD1Y8qZ/Oa9jaWeTo+Fkb0i/ypjcc9s11
	GH0CO4UcsSgR0iVZ3R0BR3I5ro+9ZNQADu8ENaTCIC6OKaocRDlAwvlXff6BVrznwKFjze
	ojGB+hHlPH5o6oCZCGwaT6Xnbn1vzs4=
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 52C5A5411D0;
	Fri, 17 Jan 2025 03:13:55 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH v9 3/3] batman-adv: increase DAT DHT timeout
Date: Fri, 17 Jan 2025 03:06:37 +0100
Message-ID: <20250117021348.2021-4-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117021348.2021-1-linus.luessing@c0d3.blue>
References: <20250117021348.2021-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: BX2PMT7ND5SOMOKIN74AAN2CKLWBWODF
X-Message-ID-Hash: BX2PMT7ND5SOMOKIN74AAN2CKLWBWODF
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BX2PMT7ND5SOMOKIN74AAN2CKLWBWODF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Currently, the DHT_GET messages of the DAT will likely be left
unanswered due to the following issues:

When a node has a matching DAT Cache entry for a local ARP Request then
this node will answer it directly with the information provided by the
cache. This however, will likely lead to missing ARP Replies from the
original host. Which in turn leads to the DAT DHT not being updated.

Then the local DAT cache entry will time out, triggering a unicasted
DHT_GET. However, as the 5min. timeout has passed, the DAT DHT
candidates will likely have purged their entry, too.

So basically this results in an ARP Request broadcast fallback every
five minutes.

A second issue is that it is quite common that a host which has long
gone offline will be tried to be contacted by another one at some remote
period larger than the current 5min. timeout. This too leads to flooded
ARP Requests.

With this patch the purge timeout for DAT DHT entries is increased to
30min to reduce the number of DAT ARP broadcast fallbacks.

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 net/batman-adv/distributed-arp-table.c | 22 +++++++++++++++++-----
 net/batman-adv/main.h                  |  3 ++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 8d6d5e338130..7817409bdd44 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -132,15 +132,27 @@ static void batadv_dat_entry_put(struct batadv_dat_entry *dat_entry)
 }
 
 /**
- * batadv_dat_to_purge() - check whether a dat_entry has to be purged or not
+ * batadv_dat_cache_to_purge() - check if a cache entry has to be purged or not
  * @dat_entry: the entry to check
  *
  * Return: true if the entry has to be purged now, false otherwise.
  */
-static bool batadv_dat_to_purge(struct batadv_dat_entry *dat_entry)
+static bool batadv_dat_cache_to_purge(struct batadv_dat_entry *dat_entry)
 {
 	return batadv_has_timed_out(dat_entry->last_update,
-				    BATADV_DAT_ENTRY_TIMEOUT);
+				    BATADV_DAT_CACHE_ENTRY_TIMEOUT);
+}
+
+/**
+ * batadv_dat_dht_to_purge() - check if a DHT entry has to be purged or not
+ * @dat_entry: the entry to check
+ *
+ * Return: true if the entry has to be purged now, false otherwise.
+ */
+static bool batadv_dat_dht_to_purge(struct batadv_dat_entry *dat_entry)
+{
+	return batadv_has_timed_out(dat_entry->last_update,
+				    BATADV_DAT_DHT_ENTRY_TIMEOUT);
 }
 
 /**
@@ -201,8 +213,8 @@ static void batadv_dat_purge(struct work_struct *work)
 	priv_dat = container_of(delayed_work, struct batadv_priv_dat, work);
 	bat_priv = container_of(priv_dat, struct batadv_priv, dat);
 
-	__batadv_dat_purge(bat_priv->dat.cache_hash, batadv_dat_to_purge);
-	__batadv_dat_purge(bat_priv->dat.dht_hash, batadv_dat_to_purge);
+	__batadv_dat_purge(bat_priv->dat.cache_hash, batadv_dat_cache_to_purge);
+	__batadv_dat_purge(bat_priv->dat.dht_hash, batadv_dat_dht_to_purge);
 	batadv_dat_start_timer(bat_priv);
 }
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 964f3088af5b..4cd4b0e84a6d 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -38,7 +38,8 @@
 #define BATADV_TT_WORK_PERIOD 5000 /* 5 seconds */
 #define BATADV_ORIG_WORK_PERIOD 1000 /* 1 second */
 #define BATADV_MCAST_WORK_PERIOD 500 /* 0.5 seconds */
-#define BATADV_DAT_ENTRY_TIMEOUT (5 * 60000) /* 5 mins in milliseconds */
+#define BATADV_DAT_CACHE_ENTRY_TIMEOUT (5 * 60000) /* 5 mins in milliseconds */
+#define BATADV_DAT_DHT_ENTRY_TIMEOUT (30 * 60000) /* 30 mins in milliseconds */
 /* sliding packet range of received originator messages in sequence numbers
  * (should be a multiple of our word size)
  */
-- 
2.47.1

