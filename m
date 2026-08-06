Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1CAEC55ABF
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 07:44:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5D2C784221
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 09:44:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786002260;
 b=lC1tbk0ooPT8sqMtTmzZBoll2s5Av9xQ5xO/Wg1FILE9D47y9vMmKbJzMnun/HXw2UkAU
 1BLSoNK8okBLFa7z82hz4aWNodO6k2pl/H+anCsxX7ZjozIBwrqkhhTr+ewqjny+Wpov+fE
 4c3pk34RurglWH1ymGFyhUbNYgJ7GEo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786002260; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1IlOR6C+GPrNQ4aD+/eB2iyxMYj31jzTBcuysIy20Y8=;
 b=bGen4YUyhUixrvU6lmq9WEFfHBI6h8HqCUTcwSFDvov9zEpQOwDQZhErA7lDeAVh57EXr
 RkEefOTtCtX8/7KABN1Y68Y2804Y1TVrFocmtJlqsh86VZ1SaWXoDHjgydXedaAhkzA5lUp
 FKQwoEl94yrgdtw4mlN0wlUWjrY+Ii8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DBF3A84230
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 09:42:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786002137;
	b=Vd6Kz+EabQB3ZNY444uR4aZ22AxSQQdpr/qhRor1jYGl2jn6uj+NvBpmwB62y4cmOUTD9P
	15rnW8MYdtxKCa12SN/wMAaiKsMi+a7xojwibEixzb1zCDcJRPOdwYpDyNIFSpee5MFiWL
	jfjvNN+AOrfesu+Lhpv2gg9XM1yK/F0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786002137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=1IlOR6C+GPrNQ4aD+/eB2iyxMYj31jzTBcuysIy20Y8=;
	b=V3KpN03o2vSw4/UYSKj4s/L6cQgkofiHAsmXs8RliIcIaFh8av7WB9f9yFl6PD750xbNae
	rsX5EK2ugehqS8WjsiNmF3eDqZqujsL49P3ORGKDLnLNJ2zgRX7sFmrhoR+PNTy7/o4vzo
	jHeUcjBBnpT7WXjPOVuVC3IeQF5X9S8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=z7DpiJaU;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 798382049B;
	Thu, 06 Aug 2026 07:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786002133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1IlOR6C+GPrNQ4aD+/eB2iyxMYj31jzTBcuysIy20Y8=;
	b=z7DpiJaU1SVt0WS5q9ZfMMNWMt3nnasvRSdW4JEZBG8F6tJpYPSNseriXpFYiN5USP2W9q
	0QPvLUW2zTECjSns77rclvD/NHnHr6CMTVXRDIdbsglJlyHvy3zcRsiMQcMO2pvvreE+wi
	+8skBZiWy7Ccl31YmEpSu8VZYE0gdTM=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 09:41:29 +0200
Subject: [PATCH RFC batadv v4 4/8] batman-adv: tt: drop unnecessary cleanup
 goto in helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-fixes-v4-4-c2fc871fe807@narfation.org>
References: <20260806-tt-fixes-v4-0-c2fc871fe807@narfation.org>
In-Reply-To: <20260806-tt-fixes-v4-0-c2fc871fe807@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2546; i=sven@narfation.org;
 h=from:subject:message-id; bh=/kMODKjY1t4GkqfjU9QoPZ9fhD8PHp0kXZ/DXAZKls0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFklVqsP39ZzlHp6Z0kHm8stHwnTyb9m2+88Vf/+6JTn8
 dy390aVdpSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAmYq3CyHBP4372UqYlDdLS
 a63qJyW0GR1r553b2aWkoL7gvhTjhmhGht/ZGr36x1J0WU1f79i+92Woo/Gbzo9Ocx6GnWzNS+e
 czw4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FCP46D7AYQKAWGVRVAJEG3GPVVMJMXS6
X-Message-ID-Hash: FCP46D7AYQKAWGVRVAJEG3GPVVMJMXS6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FCP46D7AYQKAWGVRVAJEG3GPVVMJMXS6/>
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

