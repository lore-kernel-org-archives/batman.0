Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8030DCD98CE
	for <batman-adv@archiver.kernel.org>; Fri, 12 Jun 2026 13:06:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 347D382285
	for <batman-adv@archiver.kernel.org>; Fri, 12 Jun 2026 15:06:05 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781269565;
 b=nwouFIaH//Zh1drc6R8hPWxc0Sgno04SGT6EOMmeZ/4rNqq6zhuqrpJR7GTg5PGAvzshk
 BoUUr4K4OKhypLc5AmAmPBn+Seb1DWE6YxX0dF/QsWnAJWzjdkcEItotQoTYgZ8SW8/QO7N
 IyPwJRvBXjihi9iy6lWxB0Sq3S2BNAY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781269565; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5bGzUrZObLQZNz3sybIfAvmNYsErrN5voHtRJGqPuD0=;
 b=2B6djor79mEXyyoAkr7d0yNx1Ox7xTkInIQubu3jkLkCNvoDCey8f0obyT8VxuioPqWU5
 gBUHXHTTquomEhOUubn0rtdYildl5Iv9r8xIsEhRa0/MXlJyqlpRK6uySr/XnJdoqlt7pDd
 g9slhMkdiHTPJ3VK9A7rmzfA4N19mwY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 83CBA83BF3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 12 Jun 2026 15:04:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781269471;
	b=smhVfW0g6MhJY4fLGZB4QdoH8rSpOd4zNlb373TE8F10ee4mjPX4NnpVJDbqTlQKoQ/cP+
	lVWU7TOq7WH2AQPDdQ4gi8OAaRo1kDYNKslj26fbjnAY+/S7HgqzbvfKx0zoTwE2raJqLS
	6GiWSUmiP+Htw+vTBoyilHAArFn7E2o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781269471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5bGzUrZObLQZNz3sybIfAvmNYsErrN5voHtRJGqPuD0=;
	b=Hs1ZyRw8SYgkc0kByGVQV7kRzH4855QVzLLJVF1lGzNGmGKcm2dSi0oR6xYBuq6AlDxSF3
	HXbO6lS/6kDcAnoFhBQTk++ovkPONFG1AjTQHFDjSgsB5DindVPtuaNnrYrcCWC6w8JlvI
	fE4mxBxt3sUZMHY2PJNpMEjSp9mrkFA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=tJN0dU9p;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 3BCEB200FB;
	Fri, 12 Jun 2026 13:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781269471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5bGzUrZObLQZNz3sybIfAvmNYsErrN5voHtRJGqPuD0=;
	b=tJN0dU9pWnsVlCtTjn6blDcxN0O5FFY6Ubxmp52GPA5HDtZv9yY825mJBnf7KEcEJJaQij
	G5VgLPQnGbxzuDVwb76IStV+UK67uFxoxSHetkRxutUuTg1QO+frCxQmj7fGThtkguAA8E
	5AGdw6wj+HQr/yS7kMIel/LgYI2vytM=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 12 Jun 2026 15:04:24 +0200
Subject: [PATCH batadv 2/3] batman-adv: frag: avoid underflow of TTL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-frag-ttl-v1-2-6b2f4dd9d5b6@narfation.org>
References: <20260612-frag-ttl-v1-0-6b2f4dd9d5b6@narfation.org>
In-Reply-To: <20260612-frag-ttl-v1-0-6b2f4dd9d5b6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=sven@narfation.org;
 h=from:subject:message-id; bh=YCkYk2/adL82J4/Mq7AMbGTh/nqZYzlNpO/1iwlRSUE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk6zDf+KigU+/m/zog0dIh3Cn5eK7ju2s3pdzs2OZot8
 DXi3nm/o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRsARGhp+3jKMOzOSqeiYn
 f/giA19mT7Ws9OK2e55zCk7znnDfn8zI0Gi/vqjC7vHd0ourbFz3S9kYr+/+9zhjBvMXM9YbDw+
 JMAAA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: J6J46NYSBKAFS57NIMKYHCSGKTB5O5J6
X-Message-ID-Hash: J6J46NYSBKAFS57NIMKYHCSGKTB5O5J6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/J6J46NYSBKAFS57NIMKYHCSGKTB5O5J6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Packets with a TTL are using it to limit the amount of time this packet can
be forwarded. But for batadv_frag_packet, the TTL was always only reduced
but it was never evaluated. It could even underflow without any effect.

Check the TTL in batadv_frag_skb_fwd() before attempting to prepare it for
forwarding. This keeps it in sync with the not fragmented unicast packet.

Fixes: 9b3eab61754d ("batman-adv: Receive fragmented packets and merge")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index f311a422..8a006a04 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -417,6 +417,13 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 	 */
 	total_size = ntohs(packet->total_size);
 	if (total_size > neigh_node->if_incoming->net_dev->mtu) {
+		if (packet->ttl < 2) {
+			kfree_skb(skb);
+			*rx_result = NET_RX_DROP;
+			ret = true;
+			goto out;
+		}
+
 		if (skb_cow(skb, ETH_HLEN) < 0) {
 			kfree_skb(skb);
 			*rx_result = NET_RX_DROP;

-- 
2.47.3

