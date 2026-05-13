Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B1BCD4851
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 06:09:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DD0C885A10
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 08:09:22 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778652562;
 b=0olPGZb+mPb8GJ+JBTDtF4JG5jbL56RZozrH8FcOFCzn9suyDl8kLLJ+FhzonnDaC13UL
 ZGYR79saiM1V/DxGDtfpTaYzzXQONYcVLBx+knmko9RPV0XVDQ+RW7uh+Jj4UDXxKJBMQob
 pKGGq+ao69KUmcu31l9PzU8TSI5DxVY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778652562; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Nl2tEz/zyiJvMWhqCyLKNHVjKxCBJN0L3L55mjGWvFg=;
 b=37X8XgycYaJuI+GC6KtvOLPORINmlX84MwQ+DX9jUXXpiJa0ZEHDZ+/DrdqTq4qRFWkdF
 dU4cyRuq3RcrmMklR2Nv8FrLX2L+U/f0PzGtX9uskarsQ1P/4zTjMJBaNl2MnK+UVLqco90
 ywR8RvkJtr6PNwaj1dX2gZiw8ECuXQE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net
 (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A339E845FC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 May 2026 05:58:26 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778644719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nl2tEz/zyiJvMWhqCyLKNHVjKxCBJN0L3L55mjGWvFg=;
	b=rS6MUuHEtJGS3GNXV5U1+UEAOYBBiIKACgto4oPP6Cq0H8an8k08OmWCOtS17hsYy1t9uC
	zKeJhwotXjat4wihuTZHeXCvw/1XKwtxpBp7lrCFlU7kem50OIaCAgBF7qsGKhbw1l5f0B
	y7QB/ZSzAqNJpFNVF7DpO3S8FkmWJBw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of n05ec@lzu.edu.cn designates
 162.243.161.220 as permitted sender) smtp.mailfrom=n05ec@lzu.edu.cn
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778644719;
	b=QkP1/mNAsd9LHqpb20ye9qpfd5aTwDIKMCDX7PyvcGkKZ8cj0LcxZEtWwDDxAUF0Pesc12
	ZBtJ1OeHp0UjPcwOC0hLmhx5b+UG9YLyLj+XrgKjd4RLCxLQRRJB5a9ZdMfq+7RF2oLOSw
	27FzLlDqWvgDLfFC7s3p16Y3eWoQxtU=
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown
 [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowADH6sTc9gNqYN0CAA--.3450S2;
	Wed, 13 May 2026 11:58:20 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	martin@hundeboll.net,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	caoruide123@gmail.com,
	enjou1224z@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH batadv v2 1/1] batman-adv: fix fragment reassembly length
 accounting
Date: Wed, 13 May 2026 11:58:15 +0800
Message-ID: 
 <35e86b835d6bd26fe4a3d96936f3cdbef2bb44fa.1778530692.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: ygmowADH6sTc9gNqYN0CAA--.3450S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWUCw1DCF15GFW5Cw4xXrb_yoW7ArWrp3
	yUCry5Kws7J3Z7Jr18t34YvF45Jrs7Wryjga45Xa4Yya1Dtr9ag3WrK3429Fy8AFZ8C3Wf
	tF1DKa45Aw4DWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQEGCWoCxO4XQAAAsa
X-MailFrom: n05ec@lzu.edu.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: MCVA4ZH4O6CCQR35QWOJCV2WOPDVLCXT
X-Message-ID-Hash: MCVA4ZH4O6CCQR35QWOJCV2WOPDVLCXT
X-Mailman-Approved-At: Wed, 13 May 2026 08:08:59 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MCVA4ZH4O6CCQR35QWOJCV2WOPDVLCXT/>
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
---
changes in v2:
  - Use size_t for fragment length accounting and batadv_frag_size_limit()
  - Detect accumulated fragment length overflow with check_add_overflow()
  - Include linux/overflow.h for overflow handling
  - Update the changelog wording to match the overflow-checked fix
  - v1 Link: https://lore.kernel.org/all/42981e0d67fa7d02d39332c17b67aada3112bc3e.1778396146.git.caoruide123@gmail.com/

 net/batman-adv/fragmentation.c | 19 +++++++++++++------
 net/batman-adv/types.h         |  2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index f4e45cc25816..a123c376d357 100644
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
@@ -141,8 +142,10 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 	struct batadv_frag_list_entry *frag_entry_new = NULL, *frag_entry_curr;
 	struct batadv_frag_list_entry *frag_entry_last = NULL;
 	struct batadv_frag_packet *frag_packet;
+	size_t data_len;
 	u8 bucket;
 	u16 seqno, hdr_size = sizeof(struct batadv_frag_packet);
+	bool overflow = false;
 	bool ret = false;
 
 	/* Linearize packet to avoid linearizing 16 packets in a row when doing
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
@@ -188,7 +192,9 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 		if (frag_entry_curr->no < frag_entry_new->no) {
 			hlist_add_before(&frag_entry_new->list,
 					 &frag_entry_curr->list);
-			chain->size += skb->len - hdr_size;
+			if (check_add_overflow(chain->size, data_len,
+					       &chain->size))
+				overflow = true;
 			chain->timestamp = jiffies;
 			ret = true;
 			goto out;
@@ -201,13 +207,14 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 	/* Reached the end of the list, so insert after 'frag_entry_last'. */
 	if (likely(frag_entry_last)) {
 		hlist_add_behind(&frag_entry_new->list, &frag_entry_last->list);
-		chain->size += skb->len - hdr_size;
+		if (check_add_overflow(chain->size, data_len, &chain->size))
+			overflow = true;
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
index 8fc5fe0e9b05..1bfad0229fe9 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -300,7 +300,7 @@ struct batadv_frag_table_entry {
 	u16 seqno;
 
 	/** @size: accumulated size of packets in list */
-	u16 size;
+	size_t size;
 
 	/** @total_size: expected size of the assembled packet */
 	u16 total_size;
-- 
2.34.1

