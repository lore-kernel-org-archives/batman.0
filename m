Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F836CD37AC
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 20:38:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D143685B9E
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 22:38:41 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778704721;
 b=BtGZPsgIRigi5UcowtQ9d9Fo//93ikoe+olEkPufMC+EFoNkJKAsERapwM/N82GuuOW0k
 6yn0MlFu70I0yi1/7UlovOaD5LVB72Hn/tiFL4ey2mRIpyRDW43HIna1UVh9pa5coKXCrkB
 7nhlEze96FoiG4mBuXVdPjqJ9fePfkw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778704721; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+AjkjfBPRDmpWN1LczW8eCsFff1DdBs0RANtnFCzFAk=;
 b=XiNRvW17E8x2+KnsQ+X/Egys0lrZ4ax9XrcjFM+j8Gy6JYuBmMCsKrZN+8E51SsvkAgzF
 V8qILqGXcJjoCV9TeZw7m6qlR4MIMOw21nEHXUfL3KFjIh8JhdJ4RZgokyaNZVu7RpKQj2I
 dI0MDSXlbavFhpS1qs/WWUX7/YybyHQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1ED4E8581C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 May 2026 22:36:42 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778704612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+AjkjfBPRDmpWN1LczW8eCsFff1DdBs0RANtnFCzFAk=;
	b=ujSyDvDIBgXcgjNJMQk1fF+6KywSr7DQrGA7NglbCepeXmymy+yMsCozpezzyL43wNiS8P
	zWR2H1RReKneqaWWYvKmOxmGlUVBCzZXY+K2Py4KUVoNvwg3uEV37zvUpL653FwUbKBUuK
	+iNgCwkS+cIecrMpVbBXDDeXh2rjIUE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=QaFd50Kc;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778704612;
	b=IUQoanpxtw/Rm415fhT6Lg/oRKt6cjC6g8dxcQ8HFcGqM9Jc8YCnoOGxEPSnc25zOvSm55
	UvpWuuz6VAJC5UudUayKxSp7pjSU73yWZuEsYVKEbcfCYPt5LXr9Zs2yNvcDgZPcDt3IS8
	y4XX3HBWJz1020hdf65JW9sptoNUWRc=
Received: by dvalin.narfation.org (Postfix) id C6E6421A12;
	Wed, 13 May 2026 20:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778704601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AjkjfBPRDmpWN1LczW8eCsFff1DdBs0RANtnFCzFAk=;
	b=QaFd50KcMWgRRmHRpC4aPPW9ikptTUURCDU+bHEkXqfISEcY3NbG0HSrqp9uwfWJCB9RAX
	1D3AHZTv3yeGWlmK4YOV6vrBXCFQdnsBZac8sNYTwoemxRtQMElhaAXIrcfgQt5YY8yLGA
	IsvpVTonmeIfXnqy+d2T55LeLDTkoFQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 13 May 2026 22:36:26 +0200
Subject: [PATCH batadv v2 2/2] batman-adv: bla: avoid double decrement of
 bla.num_requests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-bla-cancel-work-v2-2-9c17d82d7e2d@narfation.org>
References: <20260513-bla-cancel-work-v2-0-9c17d82d7e2d@narfation.org>
In-Reply-To: <20260513-bla-cancel-work-v2-0-9c17d82d7e2d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6478; i=sven@narfation.org;
 h=from:subject:message-id; bh=bEoKMaqD/+5XgWPpVXAud1G+osq0xozaYzSyfOgbboo=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGoE4NGg0XvDhYMVhjTExd+YJmkxk07fywqFBMbwIoPjcQFkU
 4h1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmoE4NEACgkQTQ93K9MU9cvckAD9FX4S
 jdNF5tsO51CsYJPrWySPJxLNpc4RwmXWk6g8EUQBAPUvAmItDh/vk7NK2k2w0VPw0DXuV7qF8V0
 aCjwjOwsE
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LLDA2R245LCJGW2OQPHBDJD5KBT7MH7C
X-Message-ID-Hash: LLDA2R245LCJGW2OQPHBDJD5KBT7MH7C
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LLDA2R245LCJGW2OQPHBDJD5KBT7MH7C/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The bla.num_requests is increased when no request_sent was in progress. And
it is decremented in various places (announcemnt was received, backbone is
purged, periodic work). But the check if the request_sent is actually set
to a specific state and the atomic_dec/_inc are not safe because they are
not atomic (TOCTOU) and multiple such code portions can run concurrently.

At the same time, it is necessary to modify request_sent and
bla.num_requests at the same time. Otherwise batadv_bla_send_request()
might set request_sent to 1 and is interrupted.  batadv_handle_announce()
can then set request_sent back to 0 and decrement num_requests before
batadv_bla_send_request() incremented it.

The two operations must therefore be locked. And since request_sent is only
accessed inside this lock, it can be converted to a simpler datatype.

Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 45 +++++++++++++++++++++++-----------
 net/batman-adv/mesh-interface.c        |  1 +
 net/batman-adv/types.h                 |  7 ++++--
 3 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index df1dfdf4..29bfb052 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -514,7 +514,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
 	spin_lock_init(&entry->crc_lock);
-	atomic_set(&entry->request_sent, 0);
+	entry->request_sent = 0;
 	atomic_set(&entry->wait_periods, 0);
 	ether_addr_copy(entry->orig, orig);
 	INIT_WORK(&entry->report_work, batadv_bla_loopdetect_report);
@@ -544,9 +544,13 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 		batadv_bla_send_announce(bat_priv, entry);
 
 		/* this will be decreased in the worker thread */
-		atomic_inc(&entry->request_sent);
-		atomic_set(&entry->wait_periods, BATADV_BLA_WAIT_PERIODS);
-		atomic_inc(&bat_priv->bla.num_requests);
+		spin_lock_bh(&bat_priv->bla.num_requests_lock);
+		if (!entry->request_sent) {
+			entry->request_sent = 1;
+			atomic_set(&entry->wait_periods, BATADV_BLA_WAIT_PERIODS);
+			atomic_inc(&bat_priv->bla.num_requests);
+		}
+		spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 	}
 
 	return entry;
@@ -649,10 +653,12 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 			      backbone_gw->vid, BATADV_CLAIM_TYPE_REQUEST);
 
 	/* no local broadcasts should be sent or received, for now. */
-	if (!atomic_read(&backbone_gw->request_sent)) {
+	spin_lock_bh(&backbone_gw->bat_priv->bla.num_requests_lock);
+	if (!backbone_gw->request_sent) {
+		backbone_gw->request_sent = 1;
 		atomic_inc(&backbone_gw->bat_priv->bla.num_requests);
-		atomic_set(&backbone_gw->request_sent, 1);
 	}
+	spin_unlock_bh(&backbone_gw->bat_priv->bla.num_requests_lock);
 }
 
 /**
@@ -873,10 +879,12 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 		/* if we have sent a request and the crc was OK,
 		 * we can allow traffic again.
 		 */
-		if (atomic_read(&backbone_gw->request_sent)) {
+		spin_lock_bh(&bat_priv->bla.num_requests_lock);
+		if (backbone_gw->request_sent) {
+			backbone_gw->request_sent = 0;
 			atomic_dec(&backbone_gw->bat_priv->bla.num_requests);
-			atomic_set(&backbone_gw->request_sent, 0);
 		}
+		spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 	}
 
 	batadv_backbone_gw_put(backbone_gw);
@@ -1254,9 +1262,14 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 purge_now:
 				purged = true;
 
-				/* don't wait for the pending request anymore */
-				if (atomic_read(&backbone_gw->request_sent))
+				/* don't wait for the pending request anymore,
+				 * also don't set request_sent to 0 to avoid a parallel
+				 * RCU list iterator to increase num_requests again
+				 */
+				spin_lock_bh(&bat_priv->bla.num_requests_lock);
+				if (backbone_gw->request_sent)
 					atomic_dec(&bat_priv->bla.num_requests);
+				spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 
 				batadv_bla_del_backbone_claims(backbone_gw);
 
@@ -1517,14 +1530,18 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 			 * some grace time.
 			 */
 
-			if (atomic_read(&backbone_gw->request_sent) == 0)
-				continue;
+			spin_lock_bh(&bat_priv->bla.num_requests_lock);
+			if (!backbone_gw->request_sent)
+				goto unlock_next;
 
 			if (!atomic_dec_and_test(&backbone_gw->wait_periods))
-				continue;
+				goto unlock_next;
 
+			backbone_gw->request_sent = 0;
 			atomic_dec(&backbone_gw->bat_priv->bla.num_requests);
-			atomic_set(&backbone_gw->request_sent, 0);
+
+unlock_next:
+			spin_unlock_bh(&bat_priv->bla.num_requests_lock);
 		}
 		rcu_read_unlock();
 	}
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 50c26037..cad65055 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -787,6 +787,7 @@ static int batadv_meshif_init_late(struct net_device *dev)
 	atomic_set(&bat_priv->tt.ogm_append_cnt, 0);
 #ifdef CONFIG_BATMAN_ADV_BLA
 	atomic_set(&bat_priv->bla.num_requests, 0);
+	spin_lock_init(&bat_priv->bla.num_requests_lock);
 #endif
 	atomic_set(&bat_priv->tp_num, 0);
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 739439e2..5b14ead8 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1023,6 +1023,9 @@ struct batadv_priv_bla {
 	/** @num_requests: number of bla requests in flight */
 	atomic_t num_requests;
 
+	/** @num_requests_lock: locks update request_sent + num_request update */
+	spinlock_t num_requests_lock;
+
 	/**
 	 * @claim_hash: hash table containing mesh nodes this host has claimed
 	 */
@@ -1701,9 +1704,9 @@ struct batadv_bla_backbone_gw {
 	/**
 	 * @request_sent: if this bool is set to true we are out of sync with
 	 *  this backbone gateway - no bcast traffic is formwared until the
-	 *  situation was resolved
+	 *  situation was resolved. Must only be access with num_requests_lock.
 	 */
-	atomic_t request_sent;
+	u8 request_sent;
 
 	/** @crc: crc16 checksum over all claims */
 	u16 crc;

-- 
2.47.3

