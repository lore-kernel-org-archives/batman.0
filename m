Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874A1CD4851
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 10:03:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1FA9F85DD1
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 12:03:20 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778839400;
 b=oiG1aJ5ffdpYDcZBmgPqcCrKN2SdGQNsebxU8l2E0XurnMGY4Uttz4bVw1rP6Gykzm7N2
 hm/uINx/W1hsoA2Vp8VJzl3Hd/DJGOGBie8EqSCsqBhOIi6bMYN7d3bu8x37PafMbYQGRZ/
 Cy7jdmRmnWuNIiUJpQXSo7uPkv52yXI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778839400; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=B9Sja0xiBRys6g0DgbxHi3DzYvtG7c3y9TxEzig6y4A=;
 b=oENTlwJ9uCaEM7LeuekxUJa85bEwGJ1GTpjQY+gMGOUVXZMETdL6cOiXtg0c0bsDfTm3W
 abPc/v7Uu/4NuKqRDDDbxijEw3F9TB59n7hgRV5Nar9Or1o3DPJ+4/Td8C3DVvXvtE+nap+
 WbDaIVoYMx3GAbHA2ClYIwn9UEyPBVg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8C70A8537C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 11:55:55 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778838955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=B9Sja0xiBRys6g0DgbxHi3DzYvtG7c3y9TxEzig6y4A=;
	b=Ianm+Yt4FocPWCMLE3xs2pVea3S1cDtGvl/gADYdLUXqm7+Gp8DK539TBLYe6bGFl9IiwS
	R8IAfnAt50j+8HjVT5FtfDXHm3h4wsLpv0cE47d0jXb6QxPJFb5y+I5VcDnYxqUbB65BS4
	cuafBzYzFjn5DGPB9Hkd03UeEuX6ACc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="1/bNwpfF";
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778838955;
	b=N3ke+UBpQ5SeSc+ezr53NW4pgUYKSKukBhzPgL4U/mvkRKtu7Fl2ZlMbQslzUoh4bLV7oj
	CedPizhplCmGMYWbP3UPXCiJmlQmkStmq2tkTsbtd+TfOgG+PP6tB6xNhEwbfYSwK66krb
	65BavxZvTOvEVeWBwwSHHp4BAuL1xuM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1778838954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9Sja0xiBRys6g0DgbxHi3DzYvtG7c3y9TxEzig6y4A=;
	b=1/bNwpfFc9xXEZebnwjT+9ufpSs5F/4qPtRTPM0aVTz3HWGBXve3aVlyQwQfLvrbmUXOWi
	4oeI+X1fLrmefbPBja/tHekSpcq805uQ5evmlQuyutE1wtkK1ite1NWaT9SFUXfCajFanT
	EulPZDQD8VpxJLPmCy82imOHZYQEzAVQ4aUW7exRXNmAJctvc6D8SVNK8QCNfDtl3R9V3Y
	AHNu02gEeNuggTuI84dnRigviTCqIiJqGYutVDu9o0Z/RY9hceSYQ91fk7+W1vZDlqT3vF
	kfohgGWvO385rPFnAMja7qcthG+jA0tZUJVZ6Syk7/XZDGS/IvwmYwYPQki8xQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Ruide Cao <caoruide123@gmail.com>,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 09/14] batman-adv: fix fragment reassembly length
 accounting
Date: Fri, 15 May 2026 11:55:34 +0200
Message-ID: <20260515095540.325586-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260515095540.325586-1-sw@simonwunderlich.de>
References: <20260515095540.325586-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YRVDEOZVJ3TJAAN6TVGNUD3G35LUGZAM
X-Message-ID-Hash: YRVDEOZVJ3TJAAN6TVGNUD3G35LUGZAM
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YRVDEOZVJ3TJAAN6TVGNUD3G35LUGZAM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Ruide Cao <caoruide123@gmail.com>

batman-adv keeps a running payload length for queued fragments and uses it
to validate a fragment chain before reassembly.

That accounting currently allows the accumulated fragment length to be
truncated during updates. As a result, malformed fragment chains can
bypass the intended validation and drive reassembly with inconsistent
length state, leading to a local denial of service.

Fix the accounting by storing the accumulated length in a length-typed
field and rejecting update overflows before the existing validation logic
runs.

The fix was verified against the original reproducer and against valid
fragment reassembly paths.

Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ruide Cao <caoruide123@gmail.com>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 23 +++++++++++++++++------
 net/batman-adv/types.h         |  2 +-
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index f4e45cc258164..1152c2ce0c1ea 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -17,6 +17,7 @@
 #include <linux/lockdep.h>
 #include <linux/minmax.h>
 #include <linux/netdevice.h>
+#include <linux/overflow.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
@@ -80,9 +81,9 @@ void batadv_frag_purge_orig(struct batadv_orig_node *orig_node,
  *
  * Return: the maximum size of payload that can be fragmented.
  */
-static int batadv_frag_size_limit(void)
+static size_t batadv_frag_size_limit(void)
 {
-	int limit = BATADV_FRAG_MAX_FRAG_SIZE;
+	size_t limit = BATADV_FRAG_MAX_FRAG_SIZE;
 
 	limit -= sizeof(struct batadv_frag_packet);
 	limit *= BATADV_FRAG_MAX_FRAGMENTS;
@@ -143,7 +144,9 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 	struct batadv_frag_packet *frag_packet;
 	u8 bucket;
 	u16 seqno, hdr_size = sizeof(struct batadv_frag_packet);
+	bool overflow = false;
 	bool ret = false;
+	size_t data_len;
 
 	/* Linearize packet to avoid linearizing 16 packets in a row when doing
 	 * the later merge. Non-linear merge should be added to remove this
@@ -153,6 +156,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 		goto err;
 
 	frag_packet = (struct batadv_frag_packet *)skb->data;
+	data_len = skb->len - hdr_size;
 	seqno = ntohs(frag_packet->seqno);
 	bucket = seqno % BATADV_FRAG_BUFFER_COUNT;
 
@@ -171,7 +175,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 	spin_lock_bh(&chain->lock);
 	if (batadv_frag_init_chain(chain, seqno)) {
 		hlist_add_head(&frag_entry_new->list, &chain->fragment_list);
-		chain->size = skb->len - hdr_size;
+		chain->size = data_len;
 		chain->timestamp = jiffies;
 		chain->total_size = ntohs(frag_packet->total_size);
 		ret = true;
@@ -188,7 +192,11 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 		if (frag_entry_curr->no < frag_entry_new->no) {
 			hlist_add_before(&frag_entry_new->list,
 					 &frag_entry_curr->list);
-			chain->size += skb->len - hdr_size;
+
+			if (check_add_overflow(chain->size, data_len,
+					       &chain->size))
+				overflow = true;
+
 			chain->timestamp = jiffies;
 			ret = true;
 			goto out;
@@ -201,13 +209,16 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 	/* Reached the end of the list, so insert after 'frag_entry_last'. */
 	if (likely(frag_entry_last)) {
 		hlist_add_behind(&frag_entry_new->list, &frag_entry_last->list);
-		chain->size += skb->len - hdr_size;
+
+		if (check_add_overflow(chain->size, data_len, &chain->size))
+			overflow = true;
+
 		chain->timestamp = jiffies;
 		ret = true;
 	}
 
 out:
-	if (chain->size > batadv_frag_size_limit() ||
+	if (overflow || chain->size > batadv_frag_size_limit() ||
 	    chain->total_size != ntohs(frag_packet->total_size) ||
 	    chain->total_size > batadv_frag_size_limit()) {
 		/* Clear chain if total size of either the list or the packet
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 739439e2b2350..c8c3e8064f00c 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -301,7 +301,7 @@ struct batadv_frag_table_entry {
 	u16 seqno;
 
 	/** @size: accumulated size of packets in list */
-	u16 size;
+	size_t size;
 
 	/** @total_size: expected size of the assembled packet */
 	u16 total_size;
-- 
2.47.3

