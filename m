Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35257C61DD6
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:22:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CB35783CF3
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:22:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984568;
 b=DKoIHWxv/3hVaUTvYAQp3US8OMdQ5MY9/WRmBE8hAAKlUOXUH9vLLqFcuDk2QKFyI+9sM
 d/jDehBW1k3l+OE+IcLrgL1Zbd+HZWrYOAW9vU2XAvQG0t/dCLl5I3iEbqjYfmR52QWGS8q
 ZxO8RY2ty1G+v7r5ZJ81LGdcJJkhG4w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984568; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ogI2ixKmdmscZePZ1DbVvILq9gjulzT6iZWOK44TMbY=;
 b=xzxL1YVyc+NtR4IqWmtlD1XKZUFQSjGz0P5vr4jnJpM+HIM1QU8QLCBEkykE5r4wuWB3a
 FgOTC3tHOkAwa1XEJ2GvmkrmTMXpypNfUwzuQ1nFeOSwIhWd+6KrEQKKvWEcMJpIgLbTfPX
 VHMGs4WWerv8w2TM4rtrouKfBeuAegs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C3E7E83E53
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:20:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984409;
	b=Mg0YB97wz0PZkbG0LQNz0/6N96kRXFCTt2CGsQD4mpxSpZvnBt4b3A4szY1S+WTf1hEzI0
	aHI+DxsB2g5VCR/Udh4w7baIVPgQ9Ic2+YwIGycJrmHhZ9qKsJVJAld2txSTUgafesiiec
	jTVKZkgD9FAhKHr6Wzx1KKSFsXeBt7E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ogI2ixKmdmscZePZ1DbVvILq9gjulzT6iZWOK44TMbY=;
	b=so34rvxXvnyOBBZYIPFht1ODdmMalT/hXO9xfHFq+2VDX+9wgVHeO8Tg+gg4zE08kafbiq
	KLIzvMoR7CvrF4oPnjNw7sMMMehQk15xPnMl2CE7lQZTigpKen9Cw/+kL3BWiiYxTSWdtg
	ULB3nFlBGQj83rqTDU/9KzlI7wAngx8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=UyeNM7Va;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5C2261FDC6;
	Sat, 29 Aug 2026 06:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ogI2ixKmdmscZePZ1DbVvILq9gjulzT6iZWOK44TMbY=;
	b=UyeNM7Va19n3Miju5RiRm6WqSoDVWpdTIjtOpSRvBANboAhc/VrSHEaqoWfxXVJtJWOPxw
	O9ZvZGBxMn3ywHCDHXccfWg9T98/fIdqLjg3FmQutTod2g9tWdkifsUmOG2pzlzCPruxIg
	S7aOLDh0bc8TqPlQZeOaE8eCTgh6WCg=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:18 +0200
Subject: [PATCH batadv v5 07/20] batman-adv: tt: don't uncount never
 committed clients on pending purge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-7-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1993; i=sven@narfation.org;
 h=from:subject:message-id; bh=VeJiKtI2zQ3Q//ZbK0uqorXKbKglG0ID/eMKk+I87x4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKtdMvah0LXTNv+OilqfDb/+az8tW7ndfok7vNzO/V
 P/OIkfDjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEIi0ZGY5GfNAX9ma/lf1t
 neLH9f7qoYwBfBvXbDtZoDD5/m2b6vMM/4z6SswqZlux3kpMuD8ncVKe3e8+b4e0hbmZO4t/hM0
 q5QIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2VMWDD2M36SNTOV4LE5QGHJK5FPJ2IAK
X-Message-ID-Hash: 2VMWDD2M36SNTOV4LE5QGHJK5FPJ2IAK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2VMWDD2M36SNTOV4LE5QGHJK5FPJ2IAK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tt_local_purge_pending_clients() decreases vlan->tt.num_entries for
every entry it unlinks, but an entry which still carries
BATADV_TT_CLIENT_NEW was never counted by batadv_tt_local_transition_new().

batadv_tt_local_resize_to_mtu() calls batadv_tt_local_purge() and
batadv_tt_local_purge_pending_clients() directly, without committing in
between, and it halves its timeout down towards zero. Once the timeout is
short enough, batadv_tt_local_purge_list() marks even freshly added clients
as pending. And each of them decreases a counter it never increased.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 431d1b7f..ee4e3594 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -398,6 +398,10 @@ static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
  *  given vid
  * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier
+ *
+ * It must only be called after a batadv_tt_local_entry without NEW flag
+ * was removed from bat_priv->tt.local_hash (under under the specific
+ * list_locks[i]).
  */
 static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 				     unsigned short vid)
@@ -4070,8 +4074,13 @@ static void batadv_tt_local_purge_pending_clients(struct batadv_priv *bat_priv)
 					   tt_common->addr,
 					   batadv_print_vid(tt_common->vid));
 
-				batadv_tt_local_size_dec(bat_priv, tt_common->vid);
 				hlist_del_rcu(&tt_common->hash_entry);
+
+				/* An entry which still carries BATADV_TT_CLIENT_NEW was
+				 * never counted and must not be uncounted here.
+				 */
+				if (!(tt_common->flags & BATADV_TT_CLIENT_NEW))
+					batadv_tt_local_size_dec(bat_priv, tt_common->vid);
 			}
 
 			if (cont)

-- 
2.47.3

