Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AEDCA6007
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 14:33:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2E3DA833D0
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 16:33:26 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791470006;
 b=SgssEq6YBCEqA10vCJ6MdntT35XFmjI19Qth68NalJK5WzUG2d9/W3iIY6W1TW+wf3Lfv
 QyWgi7LykS/4WgHjcOEKCnsgG8Cf8XkbC21UDKoGqr3SPUL2IiWJFWBbXu/2y5lOBXSLOml
 5EIt7ThfYP8Av70e6BFGUGOCRBGu0v8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791470006; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qvH5tL2hHwvscHFxzkNY102WBSUhJiop4rNkmOR0Bu0=;
 b=kcbqjAiocmax3NWZ8BUTZ88BttkKiKHikhxKrN4RTvT/Z+2ot/mVDXUYfR2VGiQgWXtll
 iO+fhK1h/y9UMlWiqZZAfw0rrFQyFpPADIGJ9RSMZ8QJqN/SO+khuZ+k8E9a1/EvT9/eBeK
 3p4Bd0Hv8gSwttJso57QKNEvY2+STcU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 74E3784292
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 16:30:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791469844;
	b=UIJDIxoy1EwBl/PcW2ThnitrhPO8YJ5XZ/JVuNd/p8p2GrHnPxJZyMOmuSeieAv53yZo9S
	HfMaYKs8zIcR7kO3urS0xeX+A1143Tx5EMcvXuKSErYQTZ5gZ8/MbrcD0uUcfw30jNjGmt
	KDRDRy5C16xUJZt6krZEzj9iDT/KQYQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791469844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qvH5tL2hHwvscHFxzkNY102WBSUhJiop4rNkmOR0Bu0=;
	b=cs+EZMqRP0dJKRk4fkhKpOwYeLT5w7TdasT1WdIprwy1zzaJEemBJmPaKlXLMoPnKc+xYM
	0iPBc/aRbrFA2axOnErnaB4Ga139DVj4jPee3esr3+ujCMFlPu7lP2UtT9k9fjENH0szrY
	8FFD4fuR/s+sXC1V6DHeprckW3ipVo4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=PFUYLLc7;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1F9BB205A6;
	Thu, 08 Oct 2026 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791469834;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvH5tL2hHwvscHFxzkNY102WBSUhJiop4rNkmOR0Bu0=;
	b=PFUYLLc7hNOMS6KTkV0RGtOm28bFf+igjIzS+28OuMCch/hwI1v5e3+XeAaNNeNNzeiYaX
	cBKxQsnbgWoQwBMGZ5ffovJoIThmBitDGO0NOKo4p/D0dlNpB09aZjRB8hYyMwdnbXhtvm
	CN+0z5URbPUiT2FGfTqpqe8amZXQMRc=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 16:30:09 +0200
Subject: [PATCH batadv v2 4/8] batman-adv: tt: ignore ROAM flag of received
 ADD changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-avoid-unhashed-event-v2-4-7c4eed81606d@narfation.org>
References: <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
In-Reply-To: 
 <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2298; i=sven@narfation.org;
 h=from:subject:message-id; bh=aSZvrOlPyPrlsSb/XssvVyn065hTFfZAgL+OigJHLWQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnHV3zgMH+902vB0uVv3x2alxb8WPnu2vIa7m6/pQaLb
 qi6Jp+b3lHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYyHULRoaLjYdOaiy4m5hX
 lJ27x33B8lNfBVJvzrQJ0DK9Eb+GfxkfI8PE37rXE4L2L37qdseIZ65BsveXD+rzPZdtcO+dMW1
 eRCcrAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: SDXLAKYUSLBU3MKIAXN2UF5QJOINIEK5
X-Message-ID-Hash: SDXLAKYUSLBU3MKIAXN2UF5QJOINIEK5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SDXLAKYUSLBU3MKIAXN2UF5QJOINIEK5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

A received TT change (OGM diff or full table response) with the ROAM flag
but without DEL is handled by batadv_tt_global_add() like a ROAMING_ADV:

* a newly created global entry gets BATADV_TT_CLIENT_ROAM and is
  therefore excluded from the global CRC. The sender has it in its local
  CRC and the receiver has to request the full table again
* batadv_tt_global_purge_local() removes the local entry of the
  receiver. The receiver's own client is considered as roamed to the sender
  and frames for it are rerouted

The ROAM flag only has a meaning together with DEL. Drop it on reception to
keep it from affecting the global and local tables.

Fixes: 2443ba383c7d ("batman-adv: roaming handling mechanism redesign")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5b0dce2e..2792617c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3994,21 +3994,30 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 				      u16 tt_num_changes, u8 ttvn)
 {
 	int roams;
+	u8 flags;
 	int i;
 
 	for (i = 0; i < tt_num_changes; i++) {
-		if ((tt_change + i)->flags & BATADV_TT_CLIENT_DEL) {
-			roams = (tt_change + i)->flags & BATADV_TT_CLIENT_ROAM;
+		flags = (tt_change + i)->flags;
+
+		if (flags & BATADV_TT_CLIENT_DEL) {
+			roams = flags & BATADV_TT_CLIENT_ROAM;
 			batadv_tt_global_del(bat_priv, orig_node,
 					     (tt_change + i)->addr,
 					     ntohs((tt_change + i)->vid),
 					     "tt removed by changes",
 					     roams);
 		} else {
+			/* an announced client cannot have roamed away from
+			 * orig_node. Only a ROAMING_ADV is allowed to add a
+			 * global entry with the ROAM flag
+			 */
+			flags &= ~BATADV_TT_CLIENT_ROAM;
+
 			if (!batadv_tt_global_add(bat_priv, orig_node,
 						  (tt_change + i)->addr,
 						  ntohs((tt_change + i)->vid),
-						  (tt_change + i)->flags, ttvn))
+						  flags, ttvn))
 				/* In case of problem while storing a
 				 * global_entry, we stop the updating
 				 * procedure without committing the

-- 
2.47.3

