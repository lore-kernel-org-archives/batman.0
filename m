Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6365ECA600B
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 14:32:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B9A7A8443B
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 16:32:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791469969;
 b=ob2AKEJa1qKH/Bgh/1bzklvuXZSAScUXIZQkP6gqkltmqM5nhrBaPQlJ4EPX7TPkjubnw
 pWR7w2ALymCUKYuDyXxX0Z1d+yCI+RTAoX5Z1LKCGl45SPiw0E72+s1U7PkDb5xKgBfzVJU
 b9rjm/WOatJgLDStC4NOaftnHOWYbsQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791469969; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=P5guGod0to3PMwO3upAe0YB6+UHKCAbQJY1Y134EWNo=;
 b=xoPfKmVnFwrMwQ02nsfXG2zfKrp4D9JX19cgQcSRsT1IWunDyTEGuld7lAfUSs+X7OVDy
 ZdXEDUIPtSoDoKvcO9g5vRQbs8OrIHBq6TsPyN43LD3IwCXB2Yh1nwOGdb67VAOZiovrVJL
 D9XtME5Gecegj2qjrYmalDqhSOEECDY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8F3CC8426E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 16:30:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791469842;
	b=vkn1QENkbsv9AAP2nvlRKRmLgNGqzAQw0U6C7kYicl8khIYe6J6BHgMotTejugE5OvG43v
	WAoCMfxk/nqgryWpDKZ5Luv46BYaTxg0LOQhx65R5I6kzf6UEio9hCDhyae6GT8ekNU8g2
	yzaZFzeD/nE+BluwJJKXqCsvxStEXqk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791469842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=P5guGod0to3PMwO3upAe0YB6+UHKCAbQJY1Y134EWNo=;
	b=hczPZAVRv3oHX4eirzcRCzZeAudFribZUS3cU92RJGl8hei+LawBEI2fwXVdkc6eAZXzBP
	0xNJY0hS6fKzGSGpsjgIDG82iWuAyKolqbUfBuUSiNHaQn2tSRUt4X4aoytYf/t4VuXP6K
	MWtUVsuc5lQhMR6jcVQGfRS9kscFQhk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=a6Dk9bk0;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id BC4DE20560;
	Thu, 08 Oct 2026 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791469831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P5guGod0to3PMwO3upAe0YB6+UHKCAbQJY1Y134EWNo=;
	b=a6Dk9bk0AUTcrfs4RnC0Shy6hfSGA6JAruna4oK1zHdaCIRPLAjKfDwZ9lLrJuQyMLDun6
	64WbqE2HurLiyyP3fvZABIXg7j6GJ+S/PO5EOufGKj+WJJtGIsOEl3DYP1calkcqmF9QFn
	9DBjiHmsUxpfcw3VR+3CeN+mApWhxKc=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 16:30:08 +0200
Subject: [PATCH batadv v2 3/8] batman-adv: tt: send ROAM_ADV on each roamed
 back client
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-avoid-unhashed-event-v2-3-7c4eed81606d@narfation.org>
References: <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
In-Reply-To: 
 <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2301; i=sven@narfation.org;
 h=from:subject:message-id; bh=gyPGurNz+RE65H3XduwWfz5b8RHJRXCUvbfOtbKEWEU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnHV3zwUfvMNKHb5dFn3pvtNbtfhuSs8bR44zDzzrXaO
 T33LjyT7ChlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBM5GYbI8OvpyzhZ0IrZMzV
 DqUb3CnSa3Vbt7Rbm//51WyPqwsviy1l+B8luo6BmeHENnG9BeICV/gWZd/gLo4pY9IrsD7sdOa
 dOB8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FX5BKOQFI43GAJLW37NFL24I4J2K3G2T
X-Message-ID-Hash: FX5BKOQFI43GAJLW37NFL24I4J2K3G2T
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FX5BKOQFI43GAJLW37NFL24I4J2K3G2T/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When a ROAMING_ADV is received for an announced local client,
batadv_roam_tvlv_unicast_handler_v1() creates a global entry with the
BATADV_TT_CLIENT_ROAM flag set.

If the client sends a frame again before the next TTVN commit,
batadv_tt_local_add_roam() is expected to announce this return via a
ROAM_ADV frame. But this doesn't happen because the global entry (created
by the first ROAMING_ADV) carries BATADV_TT_CLIENT_ROAM until the new
originator announces the client.

Let batadv_tt_local_add_roam() always handle a roamed back client -
independent of the ROAM flag of the global entry:

* trigger sending of the ROAM_ADV frame(s)
* remove the (with the roaming) associated global entry

Fixes: b8416c21f9fe ("batman-adv: send ROAMING_ADV once")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2ead3643..5b0dce2e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -872,14 +872,21 @@ static void batadv_tt_local_add_roam(struct batadv_priv *bat_priv,
 	if (!tt_global)
 		return;
 
-	/* Check whether it is a roaming, but don't do anything if the roaming
-	 * process has already been handled
+	/* Handle newly roamed client - but not roamed back client.
+	 *
+	 * A client which roamed back must always be reclaimed from the
+	 * originator(s) which sent the ROAMING_ADV. The global entry created by
+	 * this ROAMING_ADV might still carry BATADV_TT_CLIENT_ROAM because the
+	 * new originator did not yet announce the client.
 	 */
-	scoped_guard(spinlock_bh, &tt_global->common.flags_lock) {
-		if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
-			return;
+	if (!roamed_back) {
+		scoped_guard(spinlock_bh, &tt_global->common.flags_lock) {
+			/* Check whether it is a roaming, but don't do anything
+			 * if the roaming process has already been handled.
+			 */
+			if (tt_global->common.flags & BATADV_TT_CLIENT_ROAM)
+				return;
 
-		if (!roamed_back) {
 			/* The global entry has to be marked as ROAMING and has to be
 			 * kept for consistency purpose.
 			 *

-- 
2.47.3

