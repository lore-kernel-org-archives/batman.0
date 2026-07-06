Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB991C43458
	for <batman-adv@archiver.kernel.org>; Mon,  6 Jul 2026 16:25:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1F4F2812B3
	for <batman-adv@archiver.kernel.org>; Mon, 06 Jul 2026 18:24:59 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783355099;
 b=tgyU+DzbkaebtP+L1gl/4im0SvuImACPwbpjZdf41RWWPsGVG+jVBIixIejH2ksgZGAJ6
 vqM39E2BdwgzJNybv1owTgQT6hy/+2S7YeA8jNuqnDWIy/sUdH+vIEjkhGJNWVAl95SXksG
 qMlANmyTRYts7Pr7p9oJFqpBJtvwaT0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783355099; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hRNzpFCEH0j3rX4SlTUuSsUZ8Y87AH+XqKh6FAKt5Fc=;
 b=Kcr+khgM93mZ2EWTUAE/VcgC//ymJPOryDUyHDGy8xKmjmWrVZqFaeWnfp2zV6KpelgDn
 JVOUZYSQImegNTdZ9KUDafnH5AxWhkPq0W1zFLaLriPfmbDSVpBVh0B94kRPX7ieURYZ3do
 1BcZHGx2c96wkYY9shLM8D9yOeireos=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id BF2A180B67
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 06 Jul 2026 18:24:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783355077;
	b=Qxeu8SgpyoLZ5G0loo3vq237lVLK3kGaLwaE0NyudftF8PUoILX0MuXhVapqXZgtkr+1a4
	wqi4Qb3jZJJSkmCUsAsb/+u/eOYFZB5kahOQy4lN0ZYEo9eMcFEGz8EuqTdxFNDchCqTPv
	TUylYeA3G/ChgCwa4lUK+dpkH2Mk4N0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783355077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=hRNzpFCEH0j3rX4SlTUuSsUZ8Y87AH+XqKh6FAKt5Fc=;
	b=ToK1OXePreWh2ws/8C0xA2hll7wahesxbFSMSoqz9TwH9te5PzO48kcHJ1mNVNzGtgBu72
	NLxSAkmxa6Om/xqg9MDtbSUADQic7Lcb69/1u1SzhxoZCirXn6vCTm9Fo1uG8WolcQMduZ
	2/P9HNlMRmLAGXlvTew9ghBxPIW7ieY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XgmlrgD2;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4B1C11FEE6;
	Mon, 06 Jul 2026 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783355066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hRNzpFCEH0j3rX4SlTUuSsUZ8Y87AH+XqKh6FAKt5Fc=;
	b=XgmlrgD2kLMxhor3HtEBLSAkHlv616oK5GVdPaPFUXYOw/3Yq6XybK/rcmEUNEsEfSwQFx
	IvD6H43tu265ItyaHb+B3WMtoQnlX2NYBlwXoflQkTzwWeKke5nK1GgWYIrRrU0hnBVf6w
	NCMA4WGSAgI/jdqyRXhzOZ7RxruY32I=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 06 Jul 2026 18:24:22 +0200
Subject: [PATCH batadv v2] batman-adv: bla: avoid CRC corruption due to
 parallel claim add
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260706-bla-parallel-add-crc-corruption-v2-1-719af0bf87fa@narfation.org>
X-B4-Tracking: v=1; b=H4sIALXWS2oC/41OSw6CMBC9ipm1Y9oqIq68h2Ex/UENATItjYZwd
 wEv4PL93wzRcXAR7ocZ2OUQw9CvQB0PYFrqG4fBrhiUUFdRigJ1RzgSU9e5DslaNGzQDMzTmNY
 sqrPS5UVLX1Ua1paRnQ/vfeEJmhLZDPWPj5N+OZO2+s3ZhpgG/uxXstz9f69miRIrcVNeaOWKy
 j56Yk+bdhq4gXpZli9ZMOhY7AAAAA==
X-Change-ID: 20260705-bla-parallel-add-crc-corruption-232b74b1f99b
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5539; i=sven@narfation.org;
 h=from:subject:message-id; bh=pEX9g0TQJ7Sc2Amjrs2erTVIkfIxokmJGuztNTgCu3M=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFne17b9W/okou6er8Zc+W+L722zP3GisPNa/8/WNr32v
 2IPzysIdZSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmwunB8D9p8eo/7PNKQ36J
 SSSffdPOoeWoefEnx73C9n/TnP/6fClg+J++/uy/S+Yn0l54OBvp7bzBZRoglKofeEuoK2puudu
 dS9wA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KM3TN3WRH4BDCQRCOZUIUTVYTU2IT7KL
X-Message-ID-Hash: KM3TN3WRH4BDCQRCOZUIUTVYTU2IT7KL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KM3TN3WRH4BDCQRCOZUIUTVYTU2IT7KL/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_bla_add_claim() is used to add claims and modify the backbone of
claims for CLAIM frames from remote backbones and local packets. When it
handles a claim, it needs to either

* add the new claim's CRC to the backbone CRC
* remove the already existing claim's CRC from the old backbone and add it
  to the new backbone

But when the "new" claim code was running in parallel to the "change
backbone" code, it can happen that the CRC was invalid because the
backbone_gw of the claim was changed twice in the "new" claim code path:

* CPU0 creates the claim for gateway A and publishes it in the claim
  hash. The crc16 of the address has not yet been added to A's crc at
  this point.

* CPU1 processes a claim frame of gateway B for the same client, finds
  the just published claim, and performs the ownership change: it
  switches the pointer to B, removes the crc16 from A's crc - which
  never contained it - and adds it to B's crc.

* CPU0 continues behind the creation branch, unconditionally switches
  the pointer back to A without compensating B's crc (its remove_crc
  is false for the creation path), and finally adds the crc16 to A's
  crc

The CRC is then wrong for both:

* claim belongs to A: but CRC is not part of backbone A's CRC
* claim doesn't belong to B: CRC is still part of backbone B's CRC

This wrong CRC is never recomputated from the stored claims. For local
backbone claims, this can also not recovered using syncs.

To avoid this, split the functionality in clear separate parts:

* new claim which always adds claim CRC to the backbone CRC (but never
  changes the already set backbone_gw of the claim back)

* update of existing claim which automatically changes the backbone_gw
  entry and only updates both backbone CRCs when there was an actual change

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- added the lost lasttime updates again
- Link to v1: https://patch.msgid.link/20260705-bla-parallel-add-crc-corruption-v1-1-9082f0b2e59d@narfation.org
---
 net/batman-adv/bridge_loop_avoidance.c | 56 +++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index e18e9885..15c980e0 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -695,12 +695,13 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 	struct batadv_bla_backbone_gw *old_backbone_gw;
 	struct batadv_bla_claim search_claim;
 	struct batadv_bla_claim *claim;
-	bool remove_crc = false;
 	int hash_added;
+	u16 claim_crc;
 
 	ether_addr_copy(search_claim.addr, mac);
 	search_claim.vid = vid;
 	claim = batadv_claim_hash_find(bat_priv, &search_claim);
+	claim_crc = crc16(0, mac, ETH_ALEN);
 
 	/* create a new claim entry if it does not exist yet. */
 	if (!claim) {
@@ -732,43 +733,50 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			kfree(claim);
 			return;
 		}
-	} else {
-		WRITE_ONCE(claim->lasttime, jiffies);
-		if (claim->backbone_gw == backbone_gw)
-			/* no need to register a new backbone */
-			goto claim_free_ref;
 
-		batadv_dbg(BATADV_DBG_BLA, bat_priv,
-			   "%s(): changing ownership for %pM, vid %d to gw %pM\n",
-			   __func__, mac, batadv_print_vid(vid),
-			   backbone_gw->orig);
+		spin_lock_bh(&backbone_gw->crc_lock);
+		backbone_gw->crc ^= claim_crc;
+		spin_unlock_bh(&backbone_gw->crc_lock);
 
-		remove_crc = true;
+		WRITE_ONCE(backbone_gw->lasttime, jiffies);
+
+		batadv_claim_put(claim);
+		return;
 	}
 
+	WRITE_ONCE(claim->lasttime, jiffies);
+
+	batadv_dbg(BATADV_DBG_BLA, bat_priv,
+		   "%s(): changing ownership for %pM, vid %d to gw %pM\n",
+		   __func__, mac, batadv_print_vid(vid),
+		   backbone_gw->orig);
+
 	/* replace backbone_gw atomically and adjust reference counters */
 	spin_lock_bh(&claim->backbone_lock);
-	old_backbone_gw = claim->backbone_gw;
-	kref_get(&backbone_gw->refcount);
-	claim->backbone_gw = backbone_gw;
+	if (claim->backbone_gw != backbone_gw) {
+		old_backbone_gw = claim->backbone_gw;
+		kref_get(&backbone_gw->refcount);
+		claim->backbone_gw = backbone_gw;
+	} else {
+		old_backbone_gw = NULL;
+	}
 	spin_unlock_bh(&claim->backbone_lock);
 
-	if (remove_crc) {
+	if (old_backbone_gw) {
 		/* remove claim address from old backbone_gw */
 		spin_lock_bh(&old_backbone_gw->crc_lock);
-		old_backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+		old_backbone_gw->crc ^= claim_crc;
 		spin_unlock_bh(&old_backbone_gw->crc_lock);
+
+		/* add claim address to new backbone_gw */
+		spin_lock_bh(&backbone_gw->crc_lock);
+		backbone_gw->crc ^= claim_crc;
+		spin_unlock_bh(&backbone_gw->crc_lock);
+
+		batadv_backbone_gw_put(old_backbone_gw);
 	}
 
-	batadv_backbone_gw_put(old_backbone_gw);
-
-	/* add claim address to new backbone_gw */
-	spin_lock_bh(&backbone_gw->crc_lock);
-	backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
-	spin_unlock_bh(&backbone_gw->crc_lock);
 	WRITE_ONCE(backbone_gw->lasttime, jiffies);
-
-claim_free_ref:
 	batadv_claim_put(claim);
 }
 

---
base-commit: e281f6726677f7e8950dad1640d5386867e6d2e6
change-id: 20260705-bla-parallel-add-crc-corruption-232b74b1f99b

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

