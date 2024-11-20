Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DEBD711D2
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 17:51:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 60D2584260
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 18:51:34 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732125094;
 b=Y8TNqb/eOQhR3/7GK+boQgR+yWKL7m5+MmNyaMvscAgW4j6deLy/h9Lr+59pOEEon71MX
 5L7HR20eX9hP7WASKX2WyMVvwkyu5p+dFsKJKiGoA+WZHloE1/TkSamOIkWwYEHEpOBzmLJ
 OHUtEICH1w0CZuU7xy26W9dw59zQ68c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732125094; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rDUayW4aFK+1cp0raz697j+mJMSNhASAjYXL89KJfos=;
 b=wx+EBarX8tERZtnPlF3ltuKas/rFc33t67kP5KGrtJU2nxymhuu8b2FOz+ZnvDO1urKpr
 dtMtcCf12FYwfMB1oNggjHzl79G4AnAp1SYEeqwo8U/XcmOGu+8THoMOYFCbiDxV/lRKzPC
 UoIUVhb6neSTQpChfSapEQw1NVzaaX8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A26CD83ABC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 Nov 2024 18:48:37 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732124918; a=rsa-sha256;
	cv=none;
	b=kHDXgePp0UsMN5EOvcCytU3eP0ORXpH3K1YODiTeZqJPCVchedcZxPdmdu1uACuELV4MDh
	mwJmu5af0rQ2u2mzOqJDANhEPZugPj45g8MYo6lf9Hw1bueICH2/FRp8cafFOsBWPFrUYd
	n7iiLyiUlTRn6gAl56m8z9KpKVWv++c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=aIqzafFD;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b="duBLC/NL";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.daaihhfdxmuyck7=evgi3cyfmy5m=022x7rsmsk6r00@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.daaihhfdxmuyck7=evgi3cyfmy5m=022x7rsmsk6r00@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732124918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rDUayW4aFK+1cp0raz697j+mJMSNhASAjYXL89KJfos=;
	b=alQqNssbz1hXcPIibyVyT7l4Jt9Y0/9lh/AIIz9iiYV3ftcUDSH2Y5QJnk+3W7B6rsBy5I
	A6FEAegVLD/ye/2IU+y8F7WPJReqfyiG3qSAno9rLclu2JFJKmtWx0m/MgCLvesd2QFL+a
	9uQIUl0RJHpYFc4cTyD44ljgU2aKqfQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732125817; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=rDUayW4aFK+1cp0raz697j+mJMSNhASAjYXL89KJfos=; b=aIqzafFDUxspYJfHoYs5p4b2a1
	Z+puFCVCZ0cBcvEUB+SMphrhK07pLFScYUt2EqIfG7hsjQCAf+BI2HNS/hqiR/ftoEq+PFmbT7pfu
	Hl7WUPn2t8EFMVpzGhmDXnXWAM+Vox27armEVC2PAVdzfL7BR16cIDKSOxPLVL4CqlfwiqW/s0SG6
	Y6OXOnhXJsxMYLy0epn5fv5b7wfhJ5l7kRQqF0d3ZVM5zG4tvUNBOLq9wXy+6piMOmyZxousd0PJ8
	RN9ySs0+y/SjLAc0DOV9HREycTZ7RFPKvJtifKDOffQPh57azkMpoj1BmtmJfseuRoeYHGceTLFQX
	lr1Ikxhw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732124917; h=from : subject
 : to : message-id : date;
 bh=rDUayW4aFK+1cp0raz697j+mJMSNhASAjYXL89KJfos=;
 b=duBLC/NLt6+Fl5QgkiQlZvr8vdabYJKXbc/XfW2WGp13d8FoXZDW6T8oO8wWsv6FJYvJR
 xWgbx/OK+t9yIsPAdpVqawE6ujk4W4p/RxGCGT3XzFQ2++ULaX4HKUX/CuJrcFYvrpc/VdP
 LaRlrH4vgj27i0trbM5kNQM6AacYM21zKljFrX5d0PZdz4nZZiOBNz7YRRA5UinufuzvrFD
 AXvg0/y3WqucHWTv0oPlpw4f/j4N1GR08S/GDncIx67U7X9DEAOV1wCFaXHMbgKcdrQ6XSW
 FdT9akfiZzM3CNPx+eIz7oy7qhBgFItr7jhKdpSpwnbA/1LKnfa7wD2EvG4A==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tDooe-TRk3CN-QS; Wed, 20 Nov 2024 17:48:36 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tDooe-FnQW0hPvveB-lhPn; Wed, 20 Nov 2024 17:48:36 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 5/5] batman-adv: Don't keep redundant TT change events
Date: Wed, 20 Nov 2024 18:47:18 +0100
Message-Id: 
 <71e47271e530851861441f55d102e55a7e5d1fc8.1732124716.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1732124716.git.repk@triplefau.lt>
References: <cover.1732124716.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: qb8RfAm-fqQQ.TV8smeouS-Ro.EzEBaApmwU6
Feedback-ID: 510616m:510616apGKSTK:510616sfdQI8aIhI
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: TZLNW77OLJ34YSHJGRDYPBK3WKYNBNHO
X-Message-ID-Hash: TZLNW77OLJ34YSHJGRDYPBK3WKYNBNHO
X-MailFrom: 
 bT.daaihhfdxmuyck7=evgi3cyfmy5m=022x7rsmsk6r00@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TZLNW77OLJ34YSHJGRDYPBK3WKYNBNHO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When adding a local TT twice within the same OGM interval (e.g. happens
when flag get updated), the flags of the first TT change entry is updated
with the second one and both change events is added to the change list.
This leads to having the same ADD change entry twice. Similarly a
DEL+DEL scenario is also creating twice the same event.

Deduplicate ADD+ADD or DEL+DEL scenarios to reduce the TT change events
that need to be sent in both OGM and TT response.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/translation-table.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 39704af81169..4cc69a930b2c 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -477,7 +477,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
-	/* check for ADD+DEL or DEL+ADD events */
+	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
 				 list) {
@@ -497,17 +497,21 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (del_op_requested && !del_op_entry)
 			goto del;
 
-		/* this is a second add in the same originator interval. It
-		 * means that flags have been changed: update them!
+		/* this is a second add or del in the same originator interval.
+		 * It could mean that flags have been changed (e.g. double
+		 * add): update them
 		 */
-		if (!del_op_requested && !del_op_entry)
+		if (del_op_requested == del_op_entry) {
 			entry->change.flags = flags;
+			goto discard;
+		}
 
 		continue;
 del:
 		list_del(&entry->list);
 		kmem_cache_free(batadv_tt_change_cache, entry);
 		bat_priv->tt.local_changes--;
+discard:
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto unlock;
 	}
-- 
2.40.0

