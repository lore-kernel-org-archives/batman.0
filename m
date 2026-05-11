Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85A7ACD37BE
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 17:32:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1106885C64
	for <batman@archiver.kernel.org>; Mon, 11 May 2026 19:32:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778520772;
 b=rZ+rv9/tv1mO+vBlusE+M7t265d0Sd5eGXQfBKV5UqNu8Qoxk3R1BExzcRtSYqb7177E9
 o+XJtclPBJjDOdlfzkVz80ZbJIgvrTmyrZozwBjQza1msgt9lPbndijQmvFfFeyrViFVaZz
 wHUveXZVKD/sZpm6J7P0dS9qMmZT9OQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778520772; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=U8p1bmfbFTLTDcXCYavEaco35Q/ys/xMNNalBJ4SIT8=;
 b=wOsbXy4r1IMGNuZN8XgYQPOGfyFQwS+jMfz4udiwpgYd8dTC049W3MxsGggENGwTX6dmd
 T6cxx3l36ZHh0bZU+VGt/eLA0h5s9fh13sOdTRuQAPooEDPOiI1QdH9AmUS0nAMOOg8no74
 Uwh7lUz5uIyujgDYHlcechbkK6wSwl0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id C662485A75
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 11 May 2026 19:30:15 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778520615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=U8p1bmfbFTLTDcXCYavEaco35Q/ys/xMNNalBJ4SIT8=;
	b=JbEA5ATyQgnQCey6NEvqTdOunCXQ3QeOXKRTkVNXgMPsudVBlQR0xJ7LtuwpIxq7Q2EmBX
	X6MG0qHWqVVC8FAvMQx2yPiVcbF2j90zJPL6OXwkpOatSxpHWmWGaKo3JtAXMbLWgAVsbh
	I8kSLwOYAHSxuHw8tX2Gdrq4E6SohfY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZWVTxXr4;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778520615;
	b=VRcPgE7tPDCaJGpQnbymtXnU6NDx+DWEAbaDvJm7GMrLtGOwwwlZQdTEsFlVnhMslQTqZW
	cSbHC0rjTexRc3Pkz91ZEG++n1CZyyX7+go/irxtTi1KMcMrWwNPW27PlYowoLEhyubZXM
	rGLgNPEgu8vsDdu+E3OuRTPxOidFjN4=
Received: by dvalin.narfation.org (Postfix) id 33E8621A12;
	Mon, 11 May 2026 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778520615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8p1bmfbFTLTDcXCYavEaco35Q/ys/xMNNalBJ4SIT8=;
	b=ZWVTxXr4ui9uFVxpHdtCLDYYknWEcvCnl1skZit+A8HVqMmnEZnp8998sfloiJywhxGT4M
	K+qjpy+pFPyVsB3UB8a3rsHInn9whSMU26G3Mzh5hjC8yvGBrjKpGfyIHhJpQbHBJ0/8AP
	2kPOqQCG/nBNfZs2F+EZUsPlh4CzgPQ=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 11 May 2026 19:30:01 +0200
Subject: [PATCH batadv 3/5] batman-adv: frag: disallow unicast fragment in
 fragment
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-yuantan098-bugfixes-v1-3-6adf6965f2b3@narfation.org>
References: <20260511-yuantan098-bugfixes-v1-0-6adf6965f2b3@narfation.org>
In-Reply-To: <20260511-yuantan098-bugfixes-v1-0-6adf6965f2b3@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>,
 stable@kernel.org, Yifan Wu <yifanwucs@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Xin Liu <bird@lzu.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2665; i=sven@narfation.org;
 h=from:subject:message-id; bh=+aVsNTPGpL4xP/xAohMMxJJWimdlvb/hXASrfySGpz4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlMQlL7pv6yLNqarP97moul0a3773fcMkpZsW3hgXPL2
 6Tc9v0K6ihlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMpL6T4a9g6b9NVke414j6
 LF4/w+jqwiC5Wc1/voo6iUzPv/5tU6s7w28WRaYviyVl1GseTVEQk5m7f5+e0I3vxZuYawSPPmW
 6zcsJAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: VQRPHRZM57TXW4ZNTKFJA3PQC42PA6WG
X-Message-ID-Hash: VQRPHRZM57TXW4ZNTKFJA3PQC42PA6WG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VQRPHRZM57TXW4ZNTKFJA3PQC42PA6WG/>
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
index 068d8b41..380f868e 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -294,6 +294,31 @@ batadv_frag_merge_packets(struct hlist_head *chain)
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
@@ -327,6 +352,16 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
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

