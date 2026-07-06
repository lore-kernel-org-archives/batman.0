Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9DBC43458
	for <batman-adv@archiver.kernel.org>; Mon,  6 Jul 2026 16:50:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2093883F44
	for <batman-adv@archiver.kernel.org>; Mon, 06 Jul 2026 18:50:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783356629;
 b=3SWZJzRzN04nSzedE5RlNsLUF7HN2lN7N0tyNbT/7Ko6IAJbeNaj4108RJQL7dl07os3o
 n/hxClrqclUF066sadTFXXlHRlR+5oKejtR+/BFc8BH5bGn8k/6f1Egk62fwzB0E4Khb00f
 Ltp3WbWaVW/NepzQX3E8lcQZ2hk9i0Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783356629; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wIgJEV5Pb1o//hdhBgTuVOqPuBmbk7SiXnT8pW+L5Ck=;
 b=djAmitO8x9Gg/uBQExcxWo+L1JNWZrSb3F2cLBcrhv2eNVgAVDGAJexw9QDPrbfTOFh7b
 AkLjrA2Lmyl0oqWusM3phwq1Uc2gMakJrCLaXaAStUWkpLT74IKc/+v1xNyTYLCodSKhP9V
 c75R/vleHMGmqoTW3P0UeQMHmHUYuio=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id BB3C683625
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 06 Jul 2026 18:49:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783356606;
	b=0ucVwvRzUTyXzhGzguxw5R38jr6XXwWj8naBQbORUwu51cFm7FIsXAKAY1oEHOzoREfnKv
	WbChUwwDlZ8+HhuRxVtrPzKXYKjCiqUxL0y9d/3emdGa0sBIQ7L7rbZcBxGzrOCvY01F2L
	NG5fvcSE100xuJVey5rVhg65WQlVegk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783356606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=wIgJEV5Pb1o//hdhBgTuVOqPuBmbk7SiXnT8pW+L5Ck=;
	b=1J5Dxh8E72CO7JbMk+UEb9Jfv4b3c3mIV1lY86ASKu/TidNmgh+IvfNrYgy4RilN1sLTRC
	x9Mf3GS15cgyU3aUHY2yihyhV+/qnb4+iuHBV7LPom2xOGQQUS2beQFlUBEsw9RKGOapYA
	Z9+wWBb29PJZx9fF3/Xjie1U/RP99tY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=NndkyRxn;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 04B83202E1;
	Mon, 06 Jul 2026 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783356595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wIgJEV5Pb1o//hdhBgTuVOqPuBmbk7SiXnT8pW+L5Ck=;
	b=NndkyRxnSIdLLetNjb26hS+mR1X7ZsJiYEkz9s9d6CP0Y0zUUBOibEr8VP+zQPERatLLxG
	5K2AaaSuUVzuTqSf33+xnndsopgHCLYbEFGzxpEbwbXLiLS6OQudtRBfVf4hT710G/KaPG
	oOw1C9B8I5zaPminJgQj19PnnBHL1o8=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 06 Jul 2026 18:49:51 +0200
Subject: [PATCH batadv v3] batman-adv: bla: avoid CRC corruption due to
 parallel claim add
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260706-bla-parallel-add-crc-corruption-v3-1-d1261a377b2a@narfation.org>
X-B4-Tracking: v=1; b=H4sIAK7cS2oC/42Oyw6CMBBFf4V07Zi2PqCu/A/jYvqCGgJkCo3G8
 O8W3Bg3urwzd86ZJ4uOgovsVDwZuRRi6LscdpuCmQa72kGwOTPJ5ZGX/AC6RRiQsG1dC2gtGDJ
 geqJpGPMtyJ3U5V4Lr5RmmTKQ8+G+Gi5M44g2set7Hid9c2Zc8EuzCXHs6bG+ksTa/9uaBAhQv
 JKea+kOyp47JI/LbttTvRqT/GQefzNlZpZCYWb6qvT4zZzn+QXq4bLLQAEAAA==
X-Change-ID: 20260705-bla-parallel-add-crc-corruption-232b74b1f99b
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5794; i=sven@narfation.org;
 h=from:subject:message-id; bh=CRcbSyP02zMtUJiFh0EB20RarPM7VW4XAmw1TSZ6uCo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnedzYIFznKdzry8Hw5sOFemasnr/Wypau9b90UWGPVe
 Pia9d55HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJHHnHyHBkT0ZJb+iJHaLy
 78WK9t6/smmb9v6KVT+sX2Vk7b1YMHkxw3/vyzX9B1dFVKpenBrw9Iz6krc1rmXlCtMCW+pML+h
 OPcYJAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: EYSD2Q7EFCSAMQELWU2WFUC2ZQRYELLC
X-Message-ID-Hash: EYSD2Q7EFCSAMQELWU2WFUC2ZQRYELLC
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EYSD2Q7EFCSAMQELWU2WFUC2ZQRYELLC/>
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
Changes in v3:
- make the "changing ownership" debug message less verbose
- Link to v2: https://patch.msgid.link/20260706-bla-parallel-add-crc-corruption-v2-1-719af0bf87fa@narfation.org

Changes in v2:
- added the lost lasttime updates again
- Link to v1: https://patch.msgid.link/20260705-bla-parallel-add-crc-corruption-v1-1-9082f0b2e59d@narfation.org
---
 net/batman-adv/bridge_loop_avoidance.c | 62 +++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index e18e9885..3c3fab5c 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -695,12 +695,14 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 	struct batadv_bla_backbone_gw *old_backbone_gw;
 	struct batadv_bla_claim search_claim;
 	struct batadv_bla_claim *claim;
-	bool remove_crc = false;
 	int hash_added;
+	u16 claim_crc;
+	bool changed;
 
 	ether_addr_copy(search_claim.addr, mac);
 	search_claim.vid = vid;
 	claim = batadv_claim_hash_find(bat_priv, &search_claim);
+	claim_crc = crc16(0, mac, ETH_ALEN);
 
 	/* create a new claim entry if it does not exist yet. */
 	if (!claim) {
@@ -732,43 +734,55 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			kfree(claim);
 			return;
 		}
-	} else {
-		WRITE_ONCE(claim->lasttime, jiffies);
-		if (claim->backbone_gw == backbone_gw)
-			/* no need to register a new backbone */
-			goto claim_free_ref;
 
+		spin_lock_bh(&backbone_gw->crc_lock);
+		backbone_gw->crc ^= claim_crc;
+		spin_unlock_bh(&backbone_gw->crc_lock);
+
+		WRITE_ONCE(backbone_gw->lasttime, jiffies);
+
+		batadv_claim_put(claim);
+		return;
+	}
+
+	WRITE_ONCE(claim->lasttime, jiffies);
+
+	/* replace backbone_gw atomically and adjust reference counters */
+	spin_lock_bh(&claim->backbone_lock);
+	if (claim->backbone_gw != backbone_gw) {
+		changed = true;
+
+		old_backbone_gw = claim->backbone_gw;
+		kref_get(&backbone_gw->refcount);
+		claim->backbone_gw = backbone_gw;
+	} else {
+		old_backbone_gw = NULL;
+		changed = false;
+	}
+	spin_unlock_bh(&claim->backbone_lock);
+
+	if (changed) {
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "%s(): changing ownership for %pM, vid %d to gw %pM\n",
 			   __func__, mac, batadv_print_vid(vid),
 			   backbone_gw->orig);
 
-		remove_crc = true;
+		/* add claim address to new backbone_gw */
+		spin_lock_bh(&backbone_gw->crc_lock);
+		backbone_gw->crc ^= claim_crc;
+		spin_unlock_bh(&backbone_gw->crc_lock);
 	}
 
-	/* replace backbone_gw atomically and adjust reference counters */
-	spin_lock_bh(&claim->backbone_lock);
-	old_backbone_gw = claim->backbone_gw;
-	kref_get(&backbone_gw->refcount);
-	claim->backbone_gw = backbone_gw;
-	spin_unlock_bh(&claim->backbone_lock);
-
-	if (remove_crc) {
+	if (old_backbone_gw) {
 		/* remove claim address from old backbone_gw */
 		spin_lock_bh(&old_backbone_gw->crc_lock);
-		old_backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
+		old_backbone_gw->crc ^= claim_crc;
 		spin_unlock_bh(&old_backbone_gw->crc_lock);
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

