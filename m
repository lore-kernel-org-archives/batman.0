Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE2F7C61DD3
	for <batman-adv@archiver.kernel.org>; Tue,  1 Sep 2026 18:39:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1501482299
	for <batman-adv@archiver.kernel.org>; Tue, 01 Sep 2026 20:39:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788287959;
 b=ETEBOmZN6O23tbVPXIWs8U6w37hU/6CMNCrfboS4rthgQ9fxzbi1qIlos5ay7VI7vgLVh
 SUmk45ai6KifUrBuoPJAvT99wkMbkIYSQvfMJKS7ZpuHxLjn5knZDJt2uxWrc/ydlC8iyQ8
 sy39gb76D8Svp07Si5KP1xWbkXemWjU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788287959; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hSU+CZ0ivvuK/xVn3yVLY1xyvjvrOzEeKswAhXePAhc=;
 b=jrgoiQ31cZAHDjLmtcas8oW7LC4EeTEdNnlb6phiEpnu3CdD7LiFQzw6Hor6XRIqgYqXX
 N0lXCvOu0wkJKI9bGhXNa9vYnc7SJmet6wVbltlO8vzvaylJh3GNOwPsQDsxR9cQEctLrKz
 fjbeibQZzFEn5B2Ix0/jsaAgDuQcXi0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 84F9F80585
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 01 Sep 2026 20:39:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788287950;
	b=2zvPhfjXcXCh9s/oq1Z8MPgyyNB1geJRqaj8qi06ir3AfST6/EGODggytlREP+cwoP+cWC
	teLnR1DxDA6g7B6aWnzFmVU4i0ncjvrgE7zyf0XqUnkZDCOBiIALAOJ49iAG2LW1vdF80E
	nsOobqdhEZBh6PxH4ao9kNkcIJuPMkQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788287950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=hSU+CZ0ivvuK/xVn3yVLY1xyvjvrOzEeKswAhXePAhc=;
	b=hKOzYBUrEoMaS0NgGTE5XVGaDGGLFnJebx5yp/TfwC1HaBEF3g5RO11ZqKg+tIwYnOiTY1
	inDi9U+58/gFyePwJnIOiF9cm3hAvdOjvxbwfSNHvDwoQo+5XG596V+DEfu/oIn6fKquSU
	dnOnUSByiZ/sghldZga8MbD5iy/7Fzo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0dt1tNZn;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C97FD20320;
	Tue, 01 Sep 2026 18:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788287945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hSU+CZ0ivvuK/xVn3yVLY1xyvjvrOzEeKswAhXePAhc=;
	b=0dt1tNZnboLThHAC87iaRZARdgu07AscsdYrY4g/ydK1D5gLtkkNdacZxeYRSv9jJxavFM
	fSHLozyQaCVhy8hrtTeH5kGXht8CHQvkLGMrHrVLA5d609z5mNBliccVAV3pad0CW5Otts
	P2tOy1o6yjb+GBIM2/JUweQllRAc2W4=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 01 Sep 2026 20:39:01 +0200
Subject: [PATCH batadv] batman-adv: tt: clarify kernel doc for
 batadv_tt_local_set_pending_event()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-tt-pending-event-kdoc-v1-1-0454b0799d48@narfation.org>
X-B4-Tracking: v=1; b=H4sIAMQbl2oC/yWMywrCMBAAf6Xs2YUkolV/RTzksamrsC3JGoTSf
 zfqcQZmVqhUmCpchhUKNa48Swe7GyDevUyEnDqDM+5ozsaiKi4kiWVCaiSKzzRH3FuXT45CHg8
 j9HYplPn9+14hePWpwe3v6ys8KOp3Ctv2AWOwWCWBAAAA
X-Change-ID: 20260901-tt-pending-event-kdoc-312f82ebf757
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727; i=sven@narfation.org;
 h=from:subject:message-id; bh=0Ty9JcEUsfd6BdkuF+/dPgs8gsAJPFMyXybdMKCjwPk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnTpY86qjHk3xUwOxD2+6DhReEzPJVCve9vXXRZvMPww
 XTrx1vZO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATWV3GyLDx6D85ZrPdm49L
 sPq9t723YaZIrcnpbdkiuZcmrji93eU2I8P9LYqBN1YzbXx73FEnVjcse32a1bNTPH8s9zbpupz
 7qMUAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4V76X7FYQYYVY2ZIG6EDOCJFPB6NGCMM
X-Message-ID-Hash: 4V76X7FYQYYVY2ZIG6EDOCJFPB6NGCMM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4V76X7FYQYYVY2ZIG6EDOCJFPB6NGCMM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The function batadv_tt_local_set_pending_event() is no longer setting the
BATADV_TT_CLIENT_PENDING because it must be done with the flags_lock held.
The kernel-doc must therefore correctly state that the flag must already be
set.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 1fcbe417..775e60dd 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1475,13 +1475,12 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 /**
  * batadv_tt_local_set_pending_event() - trigger events for TT pending removal
  * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local_entry: local TT entry to mark
+ * @tt_local_entry: local TT entry which was marked as BATADV_TT_CLIENT_PENDING
  * @flags: TT change flags to announce together with the pending removal
  * @message: debug message describing the reason for the change
  *
- * Schedule the TT change announcement for the entry. The entry is kept in the
- * local table until the next TTVN increment so that a consistency-check
- * response can still be answered.
+ * Schedule the TT change announcement for the entry. The caller must already
+ * have added BATADV_TT_CLIENT_PENDING to the @tt_local_entry
  */
 static void
 batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,

---
base-commit: bd881c94108e3fb3f3d9ef7186d74e51afe1e5a6
change-id: 20260901-tt-pending-event-kdoc-312f82ebf757

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

