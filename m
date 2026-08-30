Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42545C61DD9
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:26:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A8BD18039A
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:26:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103585;
 b=Tgv9CuseXo6M+wREYGXXCW5zKOiP1lGnh2lQdfVzgn7OmHNLiwCilEMnTnbTKlM7cE/yj
 Imjim6ZwyB79FbpHen4NV+boXs0fkAJeNGdhP0DhxucFA11HWpo6aAK0f+zAycyGWGySIQO
 ZaTzU7Bim6L9OxkLktxoUkUpQDR4YHY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103585; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dIhS3BDtoqpwGhn8he57z8kgKywH7OpgafBW6650XLA=;
 b=ktG6SLzxEd5IuxxyLSWEfAUyNJDJxkqDrVqsWAU+Jzjhhvm1dW7W/jZaRRzrp/WFUK7B3
 54SDhgkSKN94hH82q29DmKcOO89T33moloZ0o10Oq6hqjdehdTOvFWZP9xdgxRvqFSdphhG
 qsGYpYf6lEMYFNhE+RVZZpilk+q6Ask=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1205080458
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:22:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103346;
	b=4RlPfMqgOIlomHfou1nQRCAhfmRnWIt5TU6kU+1LeZCVNWljGb6Jp62ZuGaUxUrE+9oLjq
	MA6GzQCRFBi1vxLJ9C/s6ppkWNNqnI5UXfFk8e64GyF1lzCLjQxi8Nm9s3Mq72jKI0nhQx
	G5EKrvr6GdRwIlo2SJwk/UWorT13KrU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dIhS3BDtoqpwGhn8he57z8kgKywH7OpgafBW6650XLA=;
	b=oqZ6OII3K3P5DRYw/UOQln4QkQ0l6nIUNxIFiR0+n8RGrkXh8WsIMwLmeaY/AS21crFZWo
	yA0zZ10bDfm+rarUQJKRlFHiZIp3rRUCLZnzvsjLy7mjurcM3jKWDgRL8itliJXPeLcmem
	WGo9c41zDyVmc7qT3XoHiXiHhUfC+xM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=JIHxdNSP;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9F40D203BC;
	Sun, 30 Aug 2026 15:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIhS3BDtoqpwGhn8he57z8kgKywH7OpgafBW6650XLA=;
	b=JIHxdNSPqKVliwOMuH0z/ljD9wNwzWIL5PM6OaOztQsCMRk1EZDYHLBDuk+QWoRTZj29sz
	ZfWkUdu7V5648PM1aXbIU9AevjmmyxNjMF7xYN87mcP28n/PdOIFpF2zTWSaFQwBK+M0zH
	rbntdiEOiMgHBV/ioMj6lwjz5JW3rKc=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:45 +0200
Subject: [PATCH batadv v6 08/20] batman-adv: tt: decrement count for
 committed client on local_remove
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-8-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; i=sven@narfation.org;
 h=from:subject:message-id; bh=Xuux60KQ2peCIFNCyQLrqVjg57L3dvdF4erOEeYTE9A=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvNpY9lyccVl4+9V4yYi9W5l/CJjcXv1zjg73ra9LZ
 WZrnQr37ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMRFOfkeHNQ8unoc4H3hu2
 eTVqrOeb56o2uWEL34xLs5kvSDg1s0sx/M//vfZndZFI15TJu212l632/XZarGTN6vQgYzW+o0d
 ffWADAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: D5AC2WEOXQTAXESW5IOQ3KXQDYJMIIHM
X-Message-ID-Hash: D5AC2WEOXQTAXESW5IOQ3KXQDYJMIIHM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/D5AC2WEOXQTAXESW5IOQ3KXQDYJMIIHM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Local TT entries which have the BATADV_TT_CLIENT_NEW no longer set are
committed. The batadv_tt_local_size_inc() was called for them and thus the
batadv_tt_local_size_dec() has to be called also when
batadv_tt_local_remove() is called for them when the BATADV_TT_CLIENT_NEW
wasn't consumed in the remove path.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 074d7991..2bd0362e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -401,7 +401,8 @@ static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
  *
  * It must only be called after a batadv_tt_local_entry without NEW flag
  * was removed from bat_priv->tt.local_hash (under the specific
- * list_locks[i]).
+ * list_locks[i]) or when it is ensured that it is not accessible
+ * in this list.
  */
 static void batadv_tt_local_size_dec(struct batadv_priv *bat_priv,
 				     unsigned short vid)
@@ -1476,6 +1477,13 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_removed_node)
 		goto out;
 
+	/* batadv_tt_local_transition_new() may have committed the entry and
+	 * thus counted it in the local table size since the BATADV_TT_CLIENT_NEW
+	 * check above.
+	 */
+	if (!(batadv_tt_flags_get(&tt_local_entry->common) & BATADV_TT_CLIENT_NEW))
+		batadv_tt_local_size_dec(bat_priv, tt_local_entry->common.vid);
+
 	/* drop reference of remove hash entry */
 	batadv_tt_local_entry_put(tt_local_entry);
 

-- 
2.47.3

