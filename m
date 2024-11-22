Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3091DE69173
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 15:57:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BACBF83F55
	for <batman-adv@archiver.kernel.org>; Fri, 22 Nov 2024 16:57:09 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732291029;
 b=X5u4aobTjxhYYpJSOuwXIT64cY1NM3148fR3Mqv8q7eEX2VwRm4GdmVZ0FLDXDxpYhphq
 VzcsJcJMieNuswu64ZGskj6YEx++4PI6ex5D0bhw6vN9bGJRPAJuVb8kEcJ9E8n9AyvXZ7O
 tYXQCOdlxZpL9j5WmyRrKMBnol7sHAI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732291029; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JcSS7AOyM0f7SJKMMLWb/AV4vmfNhPja2jn99QswWvg=;
 b=kE2aR2GYcBu2Hk0AIeH4bZVOjgjDZF4tTlVppTVXb8+PH0kR9wo+ZBRyIA66R4ocdEvrH
 I8YrJTAs4tNuCZhSB6snhw3mF8vBnm2IBLLjjH6ig4bhvIMZZbzE2jfews5huRWtUSmmyBS
 WSuWoZ9eM4D6hIMa69nAoObsuWrMwqg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AF88E83F77
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 22 Nov 2024 16:54:12 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732290852; a=rsa-sha256;
	cv=none;
	b=KlqKcyVpGlXMXQlBskyxsFr0+81jY+IddUA1QuxwxB+XdUG63INv3E4WlWpD43nYcvsC2l
	VYgKnygXU4eGeuCVoAuHNYpHX6plYkmGJ8GrmYz3xPBGXvtw1bN47swx9zqSe6p5d5o6Ya
	GSRWShk/o6BOTWBAE6H0F59hRF+ViMs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b="QgECQ4U/";
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b="UAhw/P+3";
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.1vbcjro7e0651q5=iet6zrhwrfvf=zky9isihklzct1@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.1vbcjro7e0651q5=iet6zrhwrfvf=zky9isihklzct1@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732290852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JcSS7AOyM0f7SJKMMLWb/AV4vmfNhPja2jn99QswWvg=;
	b=p1X+MNREw3SVm/0FYAV+azuAiPFUqqtNpTOdfaHDVq1t87MmQ9rzmSPk9Fw7WzcaZ5HIf8
	f5UR9rzbEpbBvPUiU8E8A0sLXFNL964s7qKSr4Ov0BEPrbnM+ojkEx+ha7iWyrG8dsgi/d
	duHg5PD6BzNsbWFNfjHrqGXJu8CL77c=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732291752; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=JcSS7AOyM0f7SJKMMLWb/AV4vmfNhPja2jn99QswWvg=; b=QgECQ4U/rVTR7LecBcRQT9hIng
	vEGuZZt6lrHLZrVDRNWzjJAYgBy5pXBwdpiAexwzGG6n+h70oG6k+ShXHrelK9KUQ2mmFY08vogcS
	W5hkW9qUx7l2O1y/N2K/INTBYsTEPWtDvT94c45I36kOiCC92ciY3xiBA+uiR1t7zSJLUeEqK30Wk
	ODjQvS6NySdsNAVbdyYjLkH6xWQ9YfnyAmkLP7g3L/tiS3T/jcDyWp5K9zwjvbu44phEJT9VzlIrV
	MQPkVyeiykkD0h1aOfer5XlhWO7sfGQPH9uttnUY9SMbJcq6kvf0L4PZQm1GQHMunu48Tz9p5KQ8/
	2+d+hbZw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732290852; h=from : subject
 : to : message-id : date;
 bh=JcSS7AOyM0f7SJKMMLWb/AV4vmfNhPja2jn99QswWvg=;
 b=UAhw/P+3duOgVZpZBgjWRkI9TBBQsSuZ1WliUupN/21mOhOl0pgRdmFRBqGmJUMZkzQat
 p8AkmjzkzhR2HwB2tocRu/Q3wB25PwLqMSEGWxmO5nguvo32vvJN+GEwIHxntDiQMgaZc2R
 uQdKEGwkdecqOkHAOT54JNKt/vjp9as0dbgdZdRoLHNyFrdFwScFY+XzxttSfMYyu+qA6Zt
 JfIJLS4xqGCuXpLNaCgoYfOU3KMeYc9BFzCr5KbPsZO4YN+kmOZBt5/aVTWQCvodNefxfMi
 YRlXB1x5tMHP7IRagtK4MtMFpLGxfSLFLZ+bgcHBbsY8BNVaOP6CQkOgArCw==
Received: from [10.172.233.45] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEVz1-TRjz6j-V6; Fri, 22 Nov 2024 15:54:11 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tEVz1-AIkwcC8lUNd-JGUV; Fri, 22 Nov 2024 15:54:11 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v4 5/5] batman-adv: Don't keep redundant TT change events
Date: Fri, 22 Nov 2024 16:52:52 +0100
Message-Id: 
 <3ffeca62cb1808f3d5fd3d1e0937c1e812cf16c2.1732290614.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1732290614.git.repk@triplefau.lt>
References: <cover.1732290614.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: dndJR0QZPt0o.nGc9avZj1H0B.lRwY9QdVVle
Feedback-ID: 510616m:510616apGKSTK:510616skPZRtbB3N
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: DHLQ7WML2UEBTWW6M7Z3NMDYO7RPBFFZ
X-Message-ID-Hash: DHLQ7WML2UEBTWW6M7Z3NMDYO7RPBFFZ
X-MailFrom: 
 bT.1vbcjro7e0651q5=iet6zrhwrfvf=zky9isihklzct1@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DHLQ7WML2UEBTWW6M7Z3NMDYO7RPBFFZ/>
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

Co-developped-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/translation-table.c | 43 +++++++++++++-----------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f7e894811e7f..b22a9d2aa5b2 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -478,7 +478,7 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
-	/* check for ADD+DEL or DEL+ADD events */
+	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 	changes = READ_ONCE(bat_priv->tt.local_changes);
 	list_for_each_entry_safe(entry, safe, &bat_priv->tt.changes_list,
@@ -486,30 +486,25 @@ static void batadv_tt_local_event(struct batadv_priv *bat_priv,
 		if (!batadv_compare_eth(entry->change.addr, common->addr))
 			continue;
 
-		/* DEL+ADD in the same orig interval have no effect and can be
-		 * removed to avoid silly behaviour on the receiver side. The
-		 * other way around (ADD+DEL) can happen in case of roaming of
-		 * a client still in the NEW state. Roaming of NEW clients is
-		 * now possible due to automatically recognition of "temporary"
-		 * clients
-		 */
-		del_op_entry = entry->change.flags & BATADV_TT_CLIENT_DEL;
-		if (!del_op_requested && del_op_entry)
-			goto del;
-		if (del_op_requested && !del_op_entry)
-			goto del;
-
-		/* this is a second add in the same originator interval. It
-		 * means that flags have been changed: update them!
-		 */
-		if (!del_op_requested && !del_op_entry)
-			entry->change.flags = flags;
+		if (del_op_requested != del_op_entry) {
+			/* DEL+ADD in the same orig interval have no effect and
+			 * can be removed to avoid silly behaviour on the
+			 * receiver side. The  other way around (ADD+DEL) can
+			 * happen in case of roaming of  a client still in the
+			 * NEW state. Roaming of NEW clients is now possible due
+			 * to automatically recognition of "temporary" clients
+			 */
+			list_del(&entry->list);
+			kmem_cache_free(batadv_tt_change_cache, entry);
+			changes--;
+		} else {
+			/* this is a second add or del in the same originator
+			 * interval. It could mean that flags have been changed
+			 * (e.g. double add): update them
+			 */
+                        entry->change.flags = flags;
+		}
 
-		continue;
-del:
-		list_del(&entry->list);
-		kmem_cache_free(batadv_tt_change_cache, entry);
-		changes--;
 		kmem_cache_free(batadv_tt_change_cache, tt_change_node);
 		goto update_changes;
 	}
-- 
2.40.0

