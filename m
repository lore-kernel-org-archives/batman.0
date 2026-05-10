Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA5BCD3427
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 10:04:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5E3DE85BA1
	for <batman@archiver.kernel.org>; Sun, 10 May 2026 12:04:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778407450;
 b=Sd8RGfqzr65aZVVziLZMjUMxnB3qXl9p7UMgq7PCXdQXkW4AZgqfSrfHCk865Yq1O2lq2
 VdgXEq4fhwuWngN3H+ExwxcPTmEIfzyadL7qpPUvJWP7vUm/Pjk4FRvFL2ubuulSvLQDrt3
 Z7ac8WzDIeexcHbpp3R8dnm+QQuPjnw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778407450; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CciFi0Ar+J2F2o0YZ/6Ocl6Be20s8j8uvRwBbHvi6bc=;
 b=KR6EJh/y19YHpakMPBVXw9FMA//+xAoLrDINeM5Px11nLvBRqof/2xvhjNgZTfksCYws5
 CpUlZsbhOzCsOBKv2ib7dnlFkvQMToXzK7S4/ayUewlPpKf9Q2aSNyz5CyAe2rHgRjfiCmt
 cmG8OEfqMdlOw332JP2sgA5f/sXZLa4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 859B181B68
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 10 May 2026 12:03:46 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778407426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=CciFi0Ar+J2F2o0YZ/6Ocl6Be20s8j8uvRwBbHvi6bc=;
	b=BgP+/XQovh6p3TsiL+iUWv54q6e80CPX9QxKI2XkTeh8Ygqx+2F2IZjFU6rIdd5CCoYnWO
	i9TWKewpzeGWpYTctLwJAwRfaxv2soLqDx/m9xOqvgKMc3x/miiWpGWaDsxTCIH6FwNwC2
	D9dzRpT+yuOrU3D/auUuhekY3kgIJOg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=DFB9Wzwh;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778407426;
	b=YpUQlO/5GjHnPjNQz41kc831BSKpU4NDifzNblyisSGmMRg1ckXxJiHHzS1FIYzxceixFz
	uWIm9sAsk+mDeJsPEMqPxFGpKOPDp+voEPLnP3qoC2B3F1X3noAm1Mon1o/XOePwIgPMLr
	Co090ZEyVTvJH7e9NcWtM+Br7S9gMz8=
Received: by dvalin.narfation.org (Postfix) id A77A6201FE;
	Sun, 10 May 2026 10:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778407425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CciFi0Ar+J2F2o0YZ/6Ocl6Be20s8j8uvRwBbHvi6bc=;
	b=DFB9WzwhqHTcLLTtvW331sOQPOmJ2GthFRReDJsd1ArOytN2CYs0qbLWKa/0FSctCoKToh
	WDFcYEhU2QtIPCQR1h9Cm8caB5FwWXLV3AC+DdsZ4zmSPaiu9UYncFCgSUPaLPKverDcaT
	nu7UBrIjLzl3XSALc2Gu0K6c34wE7zs=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 10 May 2026 12:03:42 +0200
Subject: [PATCH RFC batadv] batman-adv: bla: fix report_work leak on
 backbone_gw purge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-bla-cancel-work-v1-1-3654903495ef@narfation.org>
X-B4-Tracking: v=1; b=H4sIAP1XAGoC/yWMQQrCMBBFr1Jm7UAStYhbwQO4lS4mk6mOllSSt
 gqldzfV5fuf92bIklQyHKsZkkyatY8F7KYCvlO8CWooDM642uytQd8RMkWWDt99euIhcN1u2bG
 3OyjWK0mrn1/xCpfzad08DRQmaP53Hv1DeFirsCxftQNz+YIAAAA=
X-Change-ID: 20260510-bla-cancel-work-8dc6f3c2cb14
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: sw@simonwunderlich.de, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3961; i=sven@narfation.org;
 h=from:subject:message-id; bh=O58I/HWImMpeSVU18Rx0HICktlt2jx9fI50Mh+9+wfI=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkM4f+nOJ9VEcrS6Lr18kuc2dEnizl+lT7MZ5vG9/j7r
 amB02s/dpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm8uw7I8ORtJRN656XKv6U
 u115RSvB9PQlqXtmvEfcY9zUTlqdEJjPyDC7kPPrhqCOwGQDvdnLFNcwzhV9efBIeuTzN76+Quk
 L+fkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZNXPDO7KEF4L62WWCZ2EHA3CXA5VGBS3
X-Message-ID-Hash: ZNXPDO7KEF4L62WWCZ2EHA3CXA5VGBS3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZNXPDO7KEF4L62WWCZ2EHA3CXA5VGBS3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_bla_purge_backbone_gw() removes stale backbone gateway entries,
but fails to properly handle their associated report_work:

- If report_work is running, the purge must wait for it to finish before
  freeing the backbone_gw, otherwise the worker may access freed memory
  (e.g. bat_priv).
- If report_work is pending, the purge must cancel it and release the
  reference held for that pending work item.

The previous implementation called hlist_for_each_entry_safe() inside a
spin_lock_bh() section, but cancel_work_sync() may sleep and therefore
cannot be called from within a spinlock-protected region.

Restructure the loop to handle one entry per spinlock critical section:
acquire the lock, find the next entry to purge, remove it from the hash
list, then release the lock before calling cancel_work_sync() and
dropping the hash_entry reference. Repeat until no more entries require
purging.

Fixes: a998bf5dfbd7 ("batman-adv: add detection for complex bridge loops")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
See
https://sashiko.dev/#/patchset/20260508154314.12817-1-sw@simonwunderlich.de?part=7
---
 net/batman-adv/bridge_loop_avoidance.c | 53 ++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index cec11f12..ff2097eb 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1224,6 +1224,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 	struct hlist_head *head;
 	struct batadv_hashtable *hash;
 	spinlock_t *list_lock;	/* protects write access to the hash lists */
+	bool purged;
 	int i;
 
 	hash = bat_priv->bla.backbone_hash;
@@ -1234,30 +1235,44 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 		head = &hash->table[i];
 		list_lock = &hash->list_locks[i];
 
-		spin_lock_bh(list_lock);
-		hlist_for_each_entry_safe(backbone_gw, node_tmp,
-					  head, hash_entry) {
-			if (now)
-				goto purge_now;
-			if (!batadv_has_timed_out(backbone_gw->lasttime,
-						  BATADV_BLA_BACKBONE_TIMEOUT))
-				continue;
+		do {
+			purged = false;
 
-			batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
-				   "%s(): backbone gw %pM timed out\n",
-				   __func__, backbone_gw->orig);
+			spin_lock_bh(list_lock);
+			hlist_for_each_entry_safe(backbone_gw, node_tmp,
+						  head, hash_entry) {
+				if (now)
+					goto purge_now;
+				if (!batadv_has_timed_out(backbone_gw->lasttime,
+							  BATADV_BLA_BACKBONE_TIMEOUT))
+					continue;
+
+				batadv_dbg(BATADV_DBG_BLA, backbone_gw->bat_priv,
+					   "%s(): backbone gw %pM timed out\n",
+					   __func__, backbone_gw->orig);
 
 purge_now:
-			/* don't wait for the pending request anymore */
-			if (atomic_read(&backbone_gw->request_sent))
-				atomic_dec(&bat_priv->bla.num_requests);
+				purged = true;
+				/* don't wait for the pending request anymore */
+				if (atomic_read(&backbone_gw->request_sent))
+					atomic_dec(&bat_priv->bla.num_requests);
 
-			batadv_bla_del_backbone_claims(backbone_gw);
+				batadv_bla_del_backbone_claims(backbone_gw);
 
-			hlist_del_rcu(&backbone_gw->hash_entry);
-			batadv_backbone_gw_put(backbone_gw);
-		}
-		spin_unlock_bh(list_lock);
+				hlist_del_rcu(&backbone_gw->hash_entry);
+				break;
+			}
+			spin_unlock_bh(list_lock);
+
+			if (purged) {
+				/* reference for pending report_work */
+				if (cancel_work_sync(&backbone_gw->report_work))
+					batadv_backbone_gw_put(backbone_gw);
+
+				/* reference for hash_entry */
+				batadv_backbone_gw_put(backbone_gw);
+			}
+		} while (purged);
 	}
 }
 

---
base-commit: 05abe1217c5104b3514ef1945dacf511b012b921
change-id: 20260510-bla-cancel-work-8dc6f3c2cb14

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

