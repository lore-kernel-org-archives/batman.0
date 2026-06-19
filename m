Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C8ACD98E6
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 07:10:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DA7C285AE0
	for <batman@archiver.kernel.org>; Fri, 19 Jun 2026 09:10:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781853055;
 b=knWiHjKjQUEKyBipqPOk5M7AZkgOOMlnV448qey660PNsT7pIdx3Z/MTmGTfoZ5LuQmpP
 l1xF9aAYM6mJZHChAi8PzIJSokWzeNnFrpDATwDDSYCSzsdDksMwvI8G0kD0jeU+gjdh2rB
 ZY7hx/ZXfdAVMOovww6D5FLfj5uly+U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781853055; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4vd3XpcRqG07DRs5Sf90jAxQ0vzJC0YNpd4xsAKMEl4=;
 b=OlrhbaGdVkLBkzfxHj7XBGUqp80asOxZjhzi6VwpETlw3lYN0I3HuRvplyGju17zrQrfg
 9RbpYwVH4k7eTeywWsYX665uVceXIXXM3o3Q5NYrgQTNUkIiprFLxUdN6EIOWKJlrE58mTt
 EBlUqBHgG9JKYZUgvkT4aneHklsx2bw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9E81E83B11
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 19 Jun 2026 09:00:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781852456;
	b=l9UiWeF41nozdoYLR+LaXuZosHpivsK92ZKOu9pt4l57xHDBazXbB7KtXFb3oUWE3me9I5
	RBs3Kb+ftrV/mLCBzS2/sNjb86cEQg23I1i5k/WLGmIBOuK1lp3M3AsBN8zOb7AaQr99s6
	Ia+4MVYImzDD6KeRxjT/GpGWbrZd004=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781852456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4vd3XpcRqG07DRs5Sf90jAxQ0vzJC0YNpd4xsAKMEl4=;
	b=wnYfhudve3iBAqJi33OJTbjaRdveBNjTfSLOOREGh/sI1VkqyJ7vKZSvM4hYnB2btyaFFL
	WIy8y6+daopARduZruHJcvkAs7RCUFXvXKbx7OmcuRxob6ILyrp6BHnPpIOIC/sK11IusV
	4oNTLID3S6VQ/ae2G7Kh5sHsN5Oe140=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=pAt5jmmu;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1781852455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4vd3XpcRqG07DRs5Sf90jAxQ0vzJC0YNpd4xsAKMEl4=;
	b=pAt5jmmutaVQHH8SPqrS+uSvumGinZA7gjUTi19bSDn5Jtd2I1hgavcPSQOlHngQM9CWax
	EujQ9WecmRffta1Y1ih4P1GquFu6UkXIq7KBEzBc98TfLKvEts2QwFDBY/DmEV1kA1A+tR
	H4P5UJf5LEhORZSDMGHAuStgc7481QwIlm3G65nvTKZ+sOsSgzzn9k9HJ4cVEK1nObx36q
	P3P8tHFBKjvnpwxRrEjaydFERf4XiuO14atX5uOPWMGIsZAoLbiAoqczi4GXNg4z/vKr9o
	J/KnjzXAwEreMOkKexDIptgV1AJECc3tCdZDDZsQsIGwZisLD39MlbvHdemX1A==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 13/15] batman-adv: dat: prevent false sharing between
 VLANs
Date: Fri, 19 Jun 2026 09:00:43 +0200
Message-ID: <20260619070045.438101-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619070045.438101-1-sw@simonwunderlich.de>
References: <20260619070045.438101-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RX4OUA3SXFNVCAJ7MZFKZY2ANRAQX5WM
X-Message-ID-Hash: RX4OUA3SXFNVCAJ7MZFKZY2ANRAQX5WM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RX4OUA3SXFNVCAJ7MZFKZY2ANRAQX5WM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The local hash of DAT entries is supposed to be VLAN (VID) aware. But
the adding to the hash and the search in the hash were not checking the VID
information of the hash entries. The entries would therefore only be
correctly separated when batadv_hash_dat() didn't select the same buckets
for different VIDs.

Cc: stable@kernel.org
Fixes: be1db4f6615b ("batman-adv: make the Distributed ARP Table vlan aware")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index aaea155b94038..ae39ceaa2e29a 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -215,10 +215,13 @@ static void batadv_dat_purge(struct work_struct *work)
  */
 static bool batadv_compare_dat(const struct hlist_node *node, const void *data2)
 {
-	const void *data1 = container_of(node, struct batadv_dat_entry,
-					 hash_entry);
+	const struct batadv_dat_entry *entry1;
+	const struct batadv_dat_entry *entry2;
 
-	return memcmp(data1, data2, sizeof(__be32)) == 0;
+	entry1 = container_of(node, struct batadv_dat_entry, hash_entry);
+	entry2 = data2;
+
+	return entry1->ip == entry2->ip && entry1->vid == entry2->vid;
 }
 
 /**
@@ -345,6 +348,9 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 		if (dat_entry->ip != ip)
 			continue;
 
+		if (dat_entry->vid != vid)
+			continue;
+
 		if (!kref_get_unless_zero(&dat_entry->refcount))
 			continue;
 
-- 
2.47.3

