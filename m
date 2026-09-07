Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF969C79F89
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:24:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5613485600
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:24:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769478;
 b=SC2/mT1IkXOVhagLmrl8G1a2KZTN9e5uH1HIgBkaTfNPym/+H5j75f7YEIdv3IlKppbqd
 FYGJ2n9v2jFkjqWEf10DvZaUVeqnA5lRe59fAaw0glliPT8/ZvLsY4PiWbAvav1Q4+wwNjf
 0UynTC5giQM4qGKA0sq5JZLiezwtH2Q=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769478; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Qx42SSP6TSVRnmDAWlf0ao23yIX26HwAK66gY1duE24=;
 b=vafEPERjB0RehmCEoAXbCNAH495ZZC6NKGXfoNV3VHPE7aYJ4r0raY3nsQxzTlypN9C5G
 V52RJJOnzaVgjKQ0SSaeUUEgUZtIMRb92MOt4xVb8yeI1eRznUqoHBWztDMQ9KGZ2gI706F
 U/SSTyLZSGkHaZK3Ab5qCyVxgOpYk+Y=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C216D80888
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769118;
	b=puwSHmYwe/C1llG6vHpIsxmiMjmzncrNeebBXTQqHGEY6VAptcr4+YDquv8EUtPzW+86oV
	kP9DAeWvnXLZk0+PAzAwMDX5vWk4FaSTAZnbyiVC26qhvCUYGGwfMasKOP+kTtf/6+nmJh
	jwB4toeve2uzjHtM15NGaBIsO0SOlAQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Qx42SSP6TSVRnmDAWlf0ao23yIX26HwAK66gY1duE24=;
	b=x3xwGPyEG4G36UUQREDTYfPg/Np5o8m9b4h9GKxcByzPOkuXvs1Ks8HNBYRTZriYCCxGhC
	9sQnvVqzA+uAUAk3z1j3+u3RnWr6wkOye4QVWwsGrDtOqSl5btW0AUcFVKp32GTN65+MNn
	f39g2O+uSzRNxhY8t9LUOdV3ei3Pxvk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=y8ksAf+V;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59748d0D8c3747188e6dFe6C0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 8A0D1FA2C4;
	Mon, 07 Sep 2026 10:18:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qx42SSP6TSVRnmDAWlf0ao23yIX26HwAK66gY1duE24=;
	b=y8ksAf+V/38C4w/h24eNIVmM1mj6SR5BAg1aibuXt26pb/UWrTEi/rKfpChv+GBHefSB28
	+x9NblYEpO/dCMTyRrqBGYy3Dzil3jh3F8RYRu3Sht7jOB1URIubsQyl9l5rmdI0jSyVxp
	upSHq5tdWT9cx+pGVUD5cPgf7nuPGuKgUUzhLV9otYUfGOf+q6QPsOJ4r2R7Vq+8OL1+BU
	OQBrzAAr439S1UXqPFmI6um0QFHGTsVqFxOcq9OoGj48xvVRKsyfL7HkDAnzGrR6qiyke3
	S9HP8cuI/cF+5Fz2EH4PxBkZVPkp7ZdmATeLH4FtPt0jWX4xBM26aLN+wo25YQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 15/15] batman-adv: correct batadv_hash_remove kdoc
 return type
Date: Mon,  7 Sep 2026 10:18:24 +0200
Message-ID: <20260907081824.2474040-16-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: V556NWU6CU74S7FGXJTEWLMVC22QQXH4
X-Message-ID-Hash: V556NWU6CU74S7FGXJTEWLMVC22QQXH4
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/V556NWU6CU74S7FGXJTEWLMVC22QQXH4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Not the data is returned after a batadv_hash_remove() but the pointer to
the hlist_node which was used to look up the entry in the hash.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=8
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/hash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/hash.h b/net/batman-adv/hash.h
index e67afe01304ce..45a432cc15789 100644
--- a/net/batman-adv/hash.h
+++ b/net/batman-adv/hash.h
@@ -137,7 +137,7 @@ static inline int batadv_hash_add(struct batadv_hashtable *hash,
  * data could be the structure you use with just the key filled, we just need
  * the key for comparing.
  *
- * Return: returns pointer to data on success, so you can remove the used
+ * Return: returns pointer to hlist_node on success, so you can remove the used
  * structure yourself, or NULL on error
  */
 static inline void *batadv_hash_remove(struct batadv_hashtable *hash,
-- 
2.47.3

