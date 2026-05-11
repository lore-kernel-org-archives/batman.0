Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43231CD37AC
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 07:03:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7145B85BE4
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 09:03:07 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778482987;
 b=2WQ3Kyw29DXboASRi5xQ+PH2WU+PQFnUkGS/WC15Cw8SBRzdf6hPz8fKGqbd4H4EO0xyI
 fpDBvsxNLtNxth3LY9oAYvim09OSOOw8aPyjEKQI0ipIJUbvrdptkOYo6En4F0+/1m/+pCJ
 IOz0qNqg8O6JSu6kZTVflI9zGgkcsgA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778482987; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rcv8A/DQ9rScLcO5h55zRlIPng8vqcJn1522U85ESB0=;
 b=VrcocbCWrHGmdNG46+uTJVyd1yR6k57fultqbmIFzwwnrUhsblr5yyuCJqCq4zQDstJ2U
 Rk1JKCxLidpNxCPQLzDBdzLvSAixX/53d3aUQbkPUy/Bz8dyUeRwwoJt/Ymu3y0vWvUDFkd
 hlodxt1VNLWQWVtw2FQsg+XjujWxVX0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net
 (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B25DF8050D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 11 May 2026 08:53:02 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778482394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcv8A/DQ9rScLcO5h55zRlIPng8vqcJn1522U85ESB0=;
	b=Ux330EB2e6saIMtHEt9fugaSNKuGFK5Met1sQo3tbD+fqKXPOANqvuEIqfvjEmtfh0JCAx
	g5mVvhT7WXDo9R9nR2ScCsSsbiqfjFT0ZtqVnuxgATdw3C6PnlYHneRa6CBe55R6mJQgh9
	c4hPudk8i67nAO6rJQqyzkc5OhDKxng=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of n05ec@lzu.edu.cn designates
 209.97.182.222 as permitted sender) smtp.mailfrom=n05ec@lzu.edu.cn
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778482394;
	b=KQX30ln1lkuzi23unUGysPOmkQxL2rdGJ+cvIRG15b6s1DCnM8DGCYAvtKr/tTP3TkrJtM
	E+h6rxNz6BFa7/bo2NT03fB2eVAxPwuRyGYTHclaT6WUM7+yNp7edUr7e0TdEz4BpAy8Ut
	OH81WZQ4fDoAx9/9cJYLw9KzNBM3DUg=
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown
 [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowAAXhva_fAFqYjcDAQ--.4224S3;
	Mon, 11 May 2026 14:52:50 +0800 (CST)
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
Subject: [PATCH batadv 1/1] batman-adv: fix fragment reassembly length
 accounting
Date: Mon, 11 May 2026 14:52:42 +0800
Message-ID: 
 <42981e0d67fa7d02d39332c17b67aada3112bc3e.1778396146.git.caoruide123@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1778396146.git.caoruide123@gmail.com>
References: <cover.1778396146.git.caoruide123@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: ygmowAAXhva_fAFqYjcDAQ--.4224S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuF43Kr17WF1fArWfKFyfWFg_yoWrAw4xpa
	y5Cry5K397Ja1kJw18t3yYvr45Jrs7Wr12g3yrXa4Yyan8tr9YqF1rta42vFyvvayDG3Wf
	tF4qgFy5AwsrGrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
	Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQAECWoARmURIgAAs2
X-MailFrom: n05ec@lzu.edu.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: KAE464H6MH44X2WHUAPOJIGJOU6SSPLY
X-Message-ID-Hash: KAE464H6MH44X2WHUAPOJIGJOU6SSPLY
X-Mailman-Approved-At: Mon, 11 May 2026 09:02:43 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KAE464H6MH44X2WHUAPOJIGJOU6SSPLY/>
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

That accounting currently uses a type that can truncate the accumulated
value. As a result, malformed fragment chains can bypass the intended
validation and drive reassembly with inconsistent length state, leading to
a local denial of service.

Fix the accounting by using a non-truncating type for the accumulated
fragment length so the existing validation logic always operates on the
real value.

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
 net/batman-adv/fragmentation.c | 12 +++++++-----
 net/batman-adv/types.h         |  2 +-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index f4e45cc25816..e4472dbef4d9 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -80,9 +80,9 @@ void batadv_frag_purge_orig(struct batadv_orig_node *orig_node,
  *
  * Return: the maximum size of payload that can be fragmented.
  */
-static int batadv_frag_size_limit(void)
+static u32 batadv_frag_size_limit(void)
 {
-	int limit = BATADV_FRAG_MAX_FRAG_SIZE;
+	u32 limit = BATADV_FRAG_MAX_FRAG_SIZE;
 
 	limit -= sizeof(struct batadv_frag_packet);
 	limit *= BATADV_FRAG_MAX_FRAGMENTS;
@@ -141,6 +141,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 	struct batadv_frag_list_entry *frag_entry_new = NULL, *frag_entry_curr;
 	struct batadv_frag_list_entry *frag_entry_last = NULL;
 	struct batadv_frag_packet *frag_packet;
-	u8 bucket;
-	u16 seqno, hdr_size = sizeof(struct batadv_frag_packet);
+	u32 data_len;
+	u16 seqno, hdr_size = sizeof(struct batadv_frag_packet);
+	u8 bucket;
 	bool ret = false;
@@ -153,6 +154,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 		goto err;
 
 	frag_packet = (struct batadv_frag_packet *)skb->data;
+	data_len = skb->len - hdr_size;
 	seqno = ntohs(frag_packet->seqno);
 	bucket = seqno % BATADV_FRAG_BUFFER_COUNT;
 
@@ -171,7 +173,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 	spin_lock_bh(&chain->lock);
 	if (batadv_frag_init_chain(chain, seqno)) {
 		hlist_add_head(&frag_entry_new->list, &chain->fragment_list);
-		chain->size = skb->len - hdr_size;
+		chain->size = data_len;
 		chain->timestamp = jiffies;
 		chain->total_size = ntohs(frag_packet->total_size);
 		ret = true;
@@ -188,7 +190,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 		if (frag_entry_curr->no < frag_entry_new->no) {
 			hlist_add_before(&frag_entry_new->list,
 					 &frag_entry_curr->list);
-			chain->size += skb->len - hdr_size;
+			chain->size += data_len;
 			chain->timestamp = jiffies;
 			ret = true;
 			goto out;
@@ -201,7 +203,7 @@ static bool batadv_frag_insert_packet(struct batadv_orig_node *orig_node,
 	/* Reached the end of the list, so insert after 'frag_entry_last'. */
 	if (likely(frag_entry_last)) {
 		hlist_add_behind(&frag_entry_new->list, &frag_entry_last->list);
-		chain->size += skb->len - hdr_size;
+		chain->size += data_len;
 		chain->timestamp = jiffies;
 		ret = true;
 	}
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 8fc5fe0e9b05..96ea4c70fd59 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -300,7 +300,7 @@ struct batadv_frag_table_entry {
 	u16 seqno;
 
 	/** @size: accumulated size of packets in list */
-	u16 size;
+	u32 size;
 
 	/** @total_size: expected size of the assembled packet */
 	u16 total_size;
-- 
2.34.1

