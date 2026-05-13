Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4BB1CD4851
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 07:04:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 356FF859A9
	for <batman@archiver.kernel.org>; Wed, 13 May 2026 09:04:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778655875;
 b=Fc4b8eI99mhi1R4Hh5MG01ELZWhNRQ4+FboCHYYKX5n/yqmBJpmSXvwt3rMSqbJgzwshs
 XigPmzk6k+NYrTgM4U3k5oMiX5YzEoBiHBO33uD0kixSgFlkWsebkPb+dQLujTbKELhBoBA
 J0tzo+DD8+4kixIxEz5e20bqVDNzNuk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778655875; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=eC5W8VHNbUZmASlW1gZHM3mdEXr815jbCyeH+Il3nxI=;
 b=K3DwrYJjp+qB6grZJZCHJfnLJKHa5RdcYgbl2gOJEagZ4nROViaYcQrkFXen2bV03SLwA
 eT0abLyKrkYADA8QRGzgt97PGX1mR4h5whl8+cmMm49C16ALDppwy0Ct0fpiLmnHD2VB8B9
 jQs2NO+LbkPFdB2szI70EOKLn1wD/xM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 430F88195C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 May 2026 09:01:48 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778655713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=eC5W8VHNbUZmASlW1gZHM3mdEXr815jbCyeH+Il3nxI=;
	b=dXAdHNy9zXtRph8qQPO0YJayLJzqIDw4Iw/UR7eKkN1SBoHui0LohULX7Kr3y8nEuHLSae
	F61u7PIHCWPkGnm0x5QxhH1M40tgVIUhWPyxtZ+YuCFd95PxuwET1X8tc3MDybooRBT+04
	QMdCcoZxnpXh4X+XdUPtBB25AetXFiA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=BAmfwzAk;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778655713;
	b=bj6LvqAhG5bB1NbGXqNGW9Odk+3eHO0kdcvL2uhmV2LjLIYHjESrxN1aEjAWav/DaBRhL9
	ZlJ/YNUNouhLTG4kECxaQG2wz1kXxmlIqskUl5hyNgkubKoNgkUnV+z5JoZATmQ4HTxYST
	wK4iyNXzugw5AB6+cQVE31pyVNLplJc=
Received: by dvalin.narfation.org (Postfix) id 59E6C21BD1;
	Wed, 13 May 2026 07:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778655707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eC5W8VHNbUZmASlW1gZHM3mdEXr815jbCyeH+Il3nxI=;
	b=BAmfwzAkiF6FySNgi4YXAWnRwP8Vrq4CBaKs9B9bGSslSeBdmqoiashhf+tcKeXEl5mlbl
	RXIjlkYLsYowWtGC6QWOdJQWQBCHmac8K3JUzPobMKVh1PgKBozZaSpvlIFyyKc8JdTYdD
	bswAtxfNgNemV6C5XldwXvZCq+ZeAe8=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 13 May 2026 09:01:36 +0200
Subject: [PATCH batadv v2 3/5] batman-adv: frag: disallow unicast fragment
 in fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-yuantan098-bugfixes-v2-3-863e9caa2a57@narfation.org>
References: <20260513-yuantan098-bugfixes-v2-0-863e9caa2a57@narfation.org>
In-Reply-To: <20260513-yuantan098-bugfixes-v2-0-863e9caa2a57@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665; i=sven@narfation.org;
 h=from:subject:message-id; bh=v+qPJhGi6bAa1Lr04+y2pmSOWfuYnyiw0SVtH5i7P2c=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFksiud7N216V808zWR/em7kJevrzvErOE49nLH42KeHq
 zzm5oas7ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMRPY/I0Pv1597fT43H7Bd
 3hzLNcMjmqneIiwqtelWzU+L5ryneusYGa5ysnl5Twwt5IwUn8Ap+lBXSmL2UvlDpg45ARcjv59
 14QEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FIPNQ36VEJFYDCV2AY466JAXKLEV55BQ
X-Message-ID-Hash: FIPNQ36VEJFYDCV2AY466JAXKLEV55BQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FIPNQ36VEJFYDCV2AY466JAXKLEV55BQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_frag_skb_buffer() is called by batadv_batman_skb_recv() when a
BATADV_UNICAST_FRAG packet is received. Once all fragments are collected
and the packet is reassembled, batadv_recv_frag_packet() calls
batadv_batman_skb_recv() again to process the defragmented payload.

A malicious sender can craft a BATADV_UNICAST_FRAG packet whose reassembled
payload is itself a BATADV_UNICAST_FRAG packet (matryoshka-style nesting).
Each nesting level recurses through batadv_batman_skb_recv() without bound,
growing the kernel stack until it is exhausted.

Since refragmentation or fragments in fragments are not actually allowed,
discard all packets which are still BATADV_UNICAST_FRAG packets after the
defragmentation process.

Cc: stable@kernel.org
Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index f4e45cc2..42f3d4ee 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -293,6 +293,31 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 	return skb_out;
 }
 
+/**
+ * batadv_skb_is_frag() - check if newly merged skb is gain a unicast packet
+ * @skb: newly merged skb
+ *
+ * Return: if newly skb is of type BATADV_UNICAST_FRAG
+ */
+static bool batadv_skb_is_frag(struct sk_buff *skb)
+{
+	struct batadv_ogm_packet *batadv_ogm_packet;
+
+	/* packet should hold at least type and version */
+	if (unlikely(!pskb_may_pull(skb, 2)))
+		return false;
+
+	batadv_ogm_packet = (struct batadv_ogm_packet *)skb->data;
+
+	if (batadv_ogm_packet->version != BATADV_COMPAT_VERSION)
+		return false;
+
+	if (batadv_ogm_packet->packet_type != BATADV_UNICAST_FRAG)
+		return false;
+
+	return true;
+}
+
 /**
  * batadv_frag_skb_buffer() - buffer fragment for later merge
  * @skb: skb to buffer
@@ -326,6 +351,16 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
 	if (!skb_out)
 		goto out_err;
 
+	/* fragment in fragment is not allowed. otherwise it is possible
+	 * to exhaust the stack when receiving a matryoshka-style
+	 * "fragments in a fragment packet"
+	 */
+	if (batadv_skb_is_frag(skb_out)) {
+		kfree_skb(skb_out);
+		skb_out = NULL;
+		goto out_err;
+	}
+
 out:
 	ret = true;
 out_err:

-- 
2.47.3

