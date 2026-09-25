Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15543C9830D
	for <batman-adv@archiver.kernel.org>; Fri, 25 Sep 2026 08:46:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9B37984405
	for <batman-adv@archiver.kernel.org>; Fri, 25 Sep 2026 10:46:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790325980;
 b=zOQnGoiyUkB7UafTxvBD8K4dwgHwWZ4PjrEq+DZRnNCaFJ7c3OZ7cdyUmtcOtXhGmJhMv
 7/N2Jn0QhfXADbst6IP2xvSQIggLSdaUad0/EMhcvLbxG4ODRjfonEF32HpR9QHSEBhJ2YH
 9WmJuTZgRYWG/QASqSctaQUiAlz8P7U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790325980; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=auPlUzEyNgFKN03RyhTv3neBR9cuTkQ2w+sD1XhMkc0=;
 b=GZU/z41XsafAxnzjBUQ+vB+27GtcYohPBfTUHvkXkQ2jJC29eOGNV9XHRBiUCrqPQ14Q7
 HgwGpCunK4QmiOg1RW5als96WDHKS7+92x/jYKqLxeVVWj7meEaVcFrsXYqa5E49lcZSPii
 znmDelT88J5gPAsqpzRVlmcLzWAoIj0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5CF4380DFA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 25 Sep 2026 10:44:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790325871;
	b=jCSwu05dfoVNfEW6oDDBJaxCzHjLxzWa8wDS/DaWPHmzZAiD2K7IHtS8J1ebXRBk0S8AYF
	yindaP05p2fTIYAfK2M/NN152oPfMBoN1W7RF9L792C3qo2vGwD+daulTv5vcgSJCeuxbi
	1j4HdEGW2DNAl/mmOL/Fp3fMfOxUHR8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790325871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auPlUzEyNgFKN03RyhTv3neBR9cuTkQ2w+sD1XhMkc0=;
	b=PG38bp8qGXBICePbIS9HHlIYPIPZIG4Oj2JdvlHgaErwHc92oC56RhToEk++KFaS4WwqQz
	96MTBv2aG3ZYygu3edPbQvIa1xvd130CpGr774HSnuzGBgYQdsZ9hscHTfd0nnkLxFrkPQ
	eOzqmxtmrCypFNw74cLlYcWEGLM8ETw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E6CE123562;
	Fri, 25 Sep 2026 10:44:20 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [batadv,v11 3/4] batman-adv: increase DAT DHT timeout
Date: Fri, 25 Sep 2026 10:44:09 +0200
Message-ID: <20260925084410.27483-4-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925084410.27483-1-linus.luessing@c0d3.blue>
References: <20260925084410.27483-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: BQ6EQGM2PDUM32XENGM44AFXIDYUQLNC
X-Message-ID-Hash: BQ6EQGM2PDUM32XENGM44AFXIDYUQLNC
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BQ6EQGM2PDUM32XENGM44AFXIDYUQLNC/>
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
index ec3214943d7c..7fc12323e9f7 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -199,15 +199,27 @@ static void batadv_dat_entry_put(struct batadv_dat_entry *dat_entry)
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
@@ -268,8 +280,8 @@ static void batadv_dat_purge(struct work_struct *work)
 	priv_dat = container_of(delayed_work, struct batadv_priv_dat, work);
 	bat_priv = container_of(priv_dat, struct batadv_priv, dat);
 
-	__batadv_dat_purge(bat_priv->dat.cache_hash, batadv_dat_to_purge);
-	__batadv_dat_purge(bat_priv->dat.dht_hash, batadv_dat_to_purge);
+	__batadv_dat_purge(bat_priv->dat.cache_hash, batadv_dat_cache_to_purge);
+	__batadv_dat_purge(bat_priv->dat.dht_hash, batadv_dat_dht_to_purge);
 	batadv_dat_start_timer(bat_priv);
 }
 
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index e738758ee4a7..17af6322e157 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -36,7 +36,8 @@
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
2.55.0

