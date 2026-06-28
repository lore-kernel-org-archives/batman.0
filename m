Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D328AC43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 07:26:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6CD1B8411F
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 09:26:53 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782631613;
 b=RlA9lF//rmHNbLDA8dSqoiv0+73saLuivzkge5WSqs2TsP2CzHZ1loXqeTi2TP7SNJruD
 3Fab1ZzsQ+M9ZN2d0ZvwvlIpcW4Q6zfxiPb0dDXXPd5vxvHiZYNmVurKHxznY9/bArf6Aqd
 POHrOnGDv8u/Tp9xOrzfn/11JHEBat4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782631613; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YCYeHIMQofO8H61H20AJV36igEOL4FcGI5/ZkqEYP9s=;
 b=Ch1M6FPIlOBgrM6IEGI/6ybYKu/0+2tevgyZx1LlBQsKrj0drFeiL6T4eVZQBpgnhdS0j
 QvkMK2XiQ5M9JZsjZ2t9s7fjsQuYFt5J/VItOBFXVy+PB7cdLUCM7Oa9RzvT1ugVovYwzqk
 35WKdCA6U5R1xEkDHStqo+FFzMIZkgw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F29D481C22
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 09:25:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782631550;
	b=k1wFBK7MZiGJjdqXUef1szcZ1iaW8n3vNh72/FOaScvwWW+aEZ5BhPhwmO5FD0J6MJ0gh5
	jXi/Hc640XzGYbx8wn8d7hEAKJXRRVLWQb0Tsj4Zso62UjFNgjKocxa2LD7QBEc4p1QneK
	8K8hTGOcJV0zyJfb55IcZyj6pFluWqI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782631550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YCYeHIMQofO8H61H20AJV36igEOL4FcGI5/ZkqEYP9s=;
	b=IUp66HHCnGslA2GN5imJvObbPCPxUjIh2AGgKPT2tH0M9g2NzP6LU0PfhxPRPldmIQfxBA
	Ztnch5xBEAsKgu3xx6E64g1TStY5WGbHhDfaEH0CqAR3zNHrECnoVfNNVTWiiIUyoolxX2
	U3vJlytbvF1fG6sIUoS+KmYKrQzgugo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=YdqdNbBR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A94D820696;
	Sun, 28 Jun 2026 07:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782631549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YCYeHIMQofO8H61H20AJV36igEOL4FcGI5/ZkqEYP9s=;
	b=YdqdNbBRvOxZPJvA4ou7Qup6vRjNuyAbRKxnJ9zinpfvRLjxc3LTs3ETa4S473qWFQ7okm
	xgQU3AHzbP5j/dluQ6YNNfBge4HsjuTFf+Xf0rsx0hym+ChKx+oljmVRJWPJ34rjVSPqT1
	6aMTL04WHUw1EpMbQtN1/x83btZ2qJo=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Jun 2026 09:25:37 +0200
Subject: [PATCH batadv v2 4/5] batman-adv: bla: reacquire gw address after
 skb realloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-skb-post-realloc-v2-4-59a58f5a471b@narfation.org>
References: <20260628-skb-post-realloc-v2-0-59a58f5a471b@narfation.org>
In-Reply-To: <20260628-skb-post-realloc-v2-0-59a58f5a471b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=948; i=sven@narfation.org;
 h=from:subject:message-id; bh=ZKYySr3srpWqdASV0NvkJsRkP8IukW9Ouq3vXiWljgs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkOZwq6xafpSK0V7Zl346eY6RmNmoUKCwx5WV9L84nse
 HSG1fRsRwkLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiXL0M/4NvtmSaP576bEVw
 49o5Ee4eL3YXb81O2v6/UMjQdMFzq10MP7YbMn+5KrtA/cNSv/1O80+uV7rtmvUtx7G3WtJQyUi
 BAwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: SZZP3QUKXEGCGDJU45RQ7KCJ62LRSWTN
X-Message-ID-Hash: SZZP3QUKXEGCGDJU45RQ7KCJ62LRSWTN
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SZZP3QUKXEGCGDJU45RQ7KCJ62LRSWTN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The pskb_may_pull() called by batadv_bla_is_backbone_gw() could reallocate
the buffer behind the skb. Variables which were pointing to the old buffer
need to be reassigned to avoid an use-after-free.

Fixes: bfe2a1971f43 ("batman-adv: drop unicast packets from other backbone gw")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 10168d23..7d9a2b59 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1073,6 +1073,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 							  hdr_size);
 			batadv_orig_node_put(orig_node_gw);
 			if (is_gw) {
+				orig_addr_gw = eth_hdr(skb)->h_source;
 				batadv_dbg(BATADV_DBG_BLA, bat_priv,
 					   "%s(): Dropped unicast pkt received from another backbone gw %pM.\n",
 					   __func__, orig_addr_gw);

-- 
2.47.3

