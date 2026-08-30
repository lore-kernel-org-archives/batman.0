Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE03C61DE1
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:24:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A2DCA80335
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:24:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103457;
 b=Bujw1KGa+oc1cLp9eE8+FQ+VX0W93KZSG1Hkhx0lo4tdEQCeC6tTqkRs1VT0TtC8seZtM
 lUK8iflHj6gb+C+LbmJKlIlWeGnL9gfZG3lz9YQqziEUmyQH1N+5CkzqhZiVMZXRWtAE1Xv
 R0syx7N+5rixbmuLjymSH97ZLZcmJME=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103457; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1IlOR6C+GPrNQ4aD+/eB2iyxMYj31jzTBcuysIy20Y8=;
 b=0geckYmhfKWn85jINYagmgvS85tUsQcQNr4YijO86sbGe80P3DiuZEXghgHLCaTDWuJs4
 rVAKFpSXO7smU3jklJBt9dWqJmagb+yLjLO/43XO1LCE5T2cr5lKQ2yYZMQIKR5S9HXM1Ng
 O8vpO4C+/0SjgTnxSJw5NZfildEaTKM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D71C7803FF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:22:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103327;
	b=qcp8LuVR78a4wA9WHZ82YdwLBtGhZnWEp++Kwr9BUbwbazs0aiHVuTmkXflUU0GAt3DnPn
	3Mu0zHtUq8rDhKkWBSQdBbHZlurlkCTQteY7cymtc2SjpD8TuuTTPn6+OftGsNplHUnM6a
	199eNxFwSNMtVYUcGWanizob+ifXibI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1IlOR6C+GPrNQ4aD+/eB2iyxMYj31jzTBcuysIy20Y8=;
	b=e23FpHEIDiMnjmPGzsidLLcIddF2lepWra6StZFDZf/FKXMglnlyZ8Agb6DdqWvmUX/3yZ
	7d7YucUGx0k7fRELlmT1ygpWM79fzA1gjEe17gwVF383ZqjrYRsJS7QSEC9ccouDy+n+IF
	Sapzn7ehvdj1q4dCS5jqjpwCI87K63s=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="wC/OSQyQ";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7111C20131;
	Sun, 30 Aug 2026 15:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IlOR6C+GPrNQ4aD+/eB2iyxMYj31jzTBcuysIy20Y8=;
	b=wC/OSQyQlbFO8Iz2S1us+Lr/n2wZUbAdjc9g+SHssqPHXZ1TZQUX3SsqQrMBO94xhSGrUf
	erVlZE/w0MauE0M6+B2/SLLNYm4qy4CgdBkEnZzigQRbz/Bp0paI8peJnGe+I7+f/Ix2S8
	pqyEwkSBByzXNLj0yERHGzL6KRjRNbg=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:41 +0200
Subject: [PATCH batadv v6 04/20] batman-adv: tt: drop unnecessary cleanup
 goto in helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-4-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546; i=sven@narfation.org;
 h=from:subject:message-id; bh=/kMODKjY1t4GkqfjU9QoPZ9fhD8PHp0kXZ/DXAZKls0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvNpWhydwLjLt4ugw6TZ9Ht61IGSS00S5Y+pmWxV6b
 O4t6dTsKGVhEONikBVTZNlzJf/8Zva38p+nfTwKM4eVCWQIAxenAExkuhEjwyEpu+tmjl7S+vb2
 ey/+yl1fpfrpVda2o4XP9z88PI390BZGhu7EgGN/T21V5V0kxn3gj9tJvvCFSdHzzTwv1ryanp7
 6jAkA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 5DGQSQMB55Z2AUNQYQOLJDLZO2KTVJGW
X-Message-ID-Hash: 5DGQSQMB55Z2AUNQYQOLJDLZO2KTVJGW
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/5DGQSQMB55Z2AUNQYQOLJDLZO2KTVJGW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

To use scoped_guard(), it is not allowed to use goto in the same routine.
These goto's should only be used for cleanups but are not necessary of
minimal helpers like batadv_is_my_client(),
batadv_tt_global_client_is_roaming() and
batadv_tt_local_client_is_roaming(). Removing the goto's is actually making
these functions more readable.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5f0f7fb6..2dcee14d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3597,19 +3597,18 @@ bool batadv_is_my_client(struct batadv_priv *bat_priv, const u8 *addr,
 			 unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	bool ret = false;
+	bool ret;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
-		goto out;
+		return false;
+
 	/* Check if the client has been logically deleted (but is kept for
 	 * consistency purpose)
 	 */
-	if ((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
-	    (tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM))
-		goto out;
-	ret = true;
-out:
+	ret = !((tt_local_entry->common.flags & BATADV_TT_CLIENT_PENDING) ||
+		(tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM));
+
 	batadv_tt_local_entry_put(tt_local_entry);
 	return ret;
 }
@@ -4135,15 +4134,15 @@ bool batadv_tt_global_client_is_roaming(struct batadv_priv *bat_priv,
 					u8 *addr, unsigned short vid)
 {
 	struct batadv_tt_global_entry *tt_global_entry;
-	bool ret = false;
+	bool ret;
 
 	tt_global_entry = batadv_tt_global_hash_find(bat_priv, addr, vid);
 	if (!tt_global_entry)
-		goto out;
+		return false;
 
 	ret = tt_global_entry->common.flags & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_global_entry_put(tt_global_entry);
-out:
+
 	return ret;
 }
 
@@ -4161,15 +4160,15 @@ bool batadv_tt_local_client_is_roaming(struct batadv_priv *bat_priv,
 				       u8 *addr, unsigned short vid)
 {
 	struct batadv_tt_local_entry *tt_local_entry;
-	bool ret = false;
+	bool ret;
 
 	tt_local_entry = batadv_tt_local_hash_find(bat_priv, addr, vid);
 	if (!tt_local_entry)
-		goto out;
+		return false;
 
 	ret = tt_local_entry->common.flags & BATADV_TT_CLIENT_ROAM;
 	batadv_tt_local_entry_put(tt_local_entry);
-out:
+
 	return ret;
 }
 

-- 
2.47.3

