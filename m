Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081F8CD4851
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 08:16:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 33A0285C76
	for <batman@archiver.kernel.org>; Thu, 14 May 2026 10:16:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778746570;
 b=3NQPgW07aKo4UH8MgsRCQQMbEHVUO5qUoZy7tcHY5uOB7nlVoJ8l7pow0C+SQUA7gVxR3
 CPccAGTsC1oKmPtuXiKvPLqOJ4G3je12rw0+z+83K83sx/PsRBIzj8tG7iMBUWCSSh1eGpg
 bm81Cb4uhafe9/04WqBedz8RkW5loys=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778746570; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=pM8xy5u94966f7bCyaRdKZOuaRQWEZ+6Am9ons7uYoM=;
 b=pCtW4ZbU0XH7iyB905Yn7Us4YED8bwAU0Gapz0AdoD4StX/q1q4j5HGuol327h7G3+mts
 8Zq11ncK/XKvt8CEpacbQSxDa1lzWz7RvnGwbR3xqaDn2+ktTpfS1liqj0g9+S5c8En6mTT
 9VdQN79bv1CJSJXQfZtw7pOsizv4PZE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net
 [52.175.55.52])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 79AFF802C9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 14 May 2026 10:13:49 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778746442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pM8xy5u94966f7bCyaRdKZOuaRQWEZ+6Am9ons7uYoM=;
	b=JPFHxfHifTs+tfItzOHr7+PvVOXkdiLYX5eA92/UvnBme0VzoPR8MtKVjpeWP+QLNcHKhe
	R77Ji1Kjh1/NXHlTJT4EHU62tPmCrAyGJbbXcQRrIassmI+G+FHBUYNwAk9xLarCE5S8Hh
	uLlXsTfrLBlmWYxbvfpz8LeXFlwWZMo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of n05ec@lzu.edu.cn designates
 52.175.55.52 as permitted sender) smtp.mailfrom=n05ec@lzu.edu.cn
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778746442;
	b=FVtoBXouGuPvzvPia8DmcrRwELKaLlJthaSx8nSkK0v91j0IfJCoMaYa3LK+MUVZJ3BFIV
	Ls0wIFY3zl+h+c2TjB8yreclI2kI33ZeGBwijM4/888mAYrxqIfM995HuFpd/3bezSbiYf
	YMZx00/7M2AnOByA+eERRj5Ad71x4Gg=
Received: from enjou-Legion-Y7000P-2019.coin-barley.ts.net (unknown
 [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACXusQphAVqgHYGAA--.7536S3;
	Thu, 14 May 2026 16:13:41 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	bird@lzu.edu.cn,
	ruijieli51@gmail.com,
	lzhanpeng2025@lzu.edu.cn,
	n05ec@lzu.edu.cn
Subject: [PATCH batadv 1/1] batman-adv: clear current gateway during teardown
Date: Thu, 14 May 2026 16:13:25 +0800
Message-ID: 
 <05bdee6e85c3514822f98afa8fb75826b3928dd0.1778671969.git.ruijieli51@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1778671969.git.ruijieli51@gmail.com>
References: <cover.1778671969.git.ruijieli51@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: ygmowACXusQphAVqgHYGAA--.7536S3
X-Coremail-Antispam: 1UD129KBjvJXoW7ury5tFWxCrW8Aw4UGw43Awb_yoW8Ar4fpr
	WfCryYka9rJw10kFs2yryrA34ayF4DGrW2qa4DAF4UJw1ktrWIyF9Yg34UZr45tan2grs0
	qFWqvFW7uw4UuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQsHCWoFZ+8DaQAAsJ
X-MailFrom: n05ec@lzu.edu.cn
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: 3WCMTFXZ2QTGSXFYL5OJKQCM2EF7J4GI
X-Message-ID-Hash: 3WCMTFXZ2QTGSXFYL5OJKQCM2EF7J4GI
X-Mailman-Approved-At: Thu, 14 May 2026 10:15:47 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3WCMTFXZ2QTGSXFYL5OJKQCM2EF7J4GI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Ruijie Li <ruijieli51@gmail.com>

batadv_gw_node_free() removes the gateway list entries during mesh teardown,
but it does not clear the currently selected gateway. This leaves stale
gateway state behind across cleanup and can break a later mesh recreation.

Clear bat_priv->gw.curr_gw before walking the gateway list so the selected
gateway reference is dropped as part of teardown.

Fixes: 2265c1410864 ("batman-adv: gateway election code refactoring")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ruijie Li <ruijieli51@gmail.com>
Signed-off-by: Zhanpeng Li <lzhanpeng2025@lzu.edu.cn>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/batman-adv/gateway_client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 51e9c081a2a4..a9d0346e8332 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -478,10 +478,14 @@ void batadv_gw_node_delete(struct batadv_priv *bat_priv,
  */
 void batadv_gw_node_free(struct batadv_priv *bat_priv)
 {
+	struct batadv_gw_node *curr_gw;
 	struct batadv_gw_node *gw_node;
 	struct hlist_node *node_tmp;
 
 	spin_lock_bh(&bat_priv->gw.list_lock);
+	curr_gw = rcu_replace_pointer(bat_priv->gw.curr_gw, NULL, true);
+	batadv_gw_node_put(curr_gw);
+
 	hlist_for_each_entry_safe(gw_node, node_tmp,
 				  &bat_priv->gw.gateway_list, list) {
 		hlist_del_init_rcu(&gw_node->list);
-- 
2.34.1

