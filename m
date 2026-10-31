Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5C3606A31A
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 20:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=yK9tjS/1
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5669884612
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 21:33:15 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793478795;
 b=a6qZ+J3XIXhuWNrc/Jrk3xbGykZVkY0y0ezUe5j0OedrZYvyK2n05p6OaeX+OgnQGPfRz
 W99+nvG63+tIuuPeFXR23OPfLRTxnvzQc9Yf8dA10qKuBfbpf4H2gIXhN5CJh+nFiwnJjUl
 69/pmvHjN3/sKiqbi/q3ZxiZsE8VWBo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793478795; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sqErTLuImJbs7C7Io3wGv79cVg6jLeJIhB4X7DHVUOc=;
 b=ghSiZrhugOc3VE68BW3JXgJKVt0UHKst17RKnvCNaCg00t+zMlrtF1sZ+OTh1DxZYpm1n
 aF8MiNKunJ2nm3kTIwsNg4tKUVw0LsfCdunQO+5qLhSanV2Q0WQ83Y/+Kpm598WXVZkwX4g
 q8A1AaaOQy1nL7U/dKl3MFGKRaNGkV4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 68B4084228
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 21:30:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793478640;
	b=gnK8ptd7MIv/kFzxG+GajzfUk5Oo/JEOXf9rQmMVNUj7UAw6dBxXXcaDKXKRDPcKPfelDJ
	DUNxwAL4SM3A7/EhF0ezBH5Zgw6gM3ex5rmaUWtZ7jk/SYY4ORLLpMIBDoioThh9yL/Fe9
	lgMmPWbcT0HdrUsniHn9X6Kqgt3BVx4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793478640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sqErTLuImJbs7C7Io3wGv79cVg6jLeJIhB4X7DHVUOc=;
	b=u12PehFSYaCHF3p9cMGqmG3SXq1h8T3MGBMXF3MLEdZCU4Im+HCIxKDtnNxEUxsul6sfyI
	oMrnspWLwJj/HKfwQrA9FtFVd4m3Fk+S3fwnFU0U4NY3ZwZnFx3TLPHQF24OQTDl1TW5KR
	gMXBKyFsoEaR8We0ALSrAu+fe3TkHGo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="yK9tjS/1";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id E690720F6B;
	Sat, 31 Oct 2026 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793478630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sqErTLuImJbs7C7Io3wGv79cVg6jLeJIhB4X7DHVUOc=;
	b=yK9tjS/1hzYGbUyD95B3QvQKFrxjg+pUK9RVQGLvtkUJ9trMU44xYWuqKAKp5ZICS7MRq1
	xc4m4fbLT0Pzgc9olwhs9enVixE3CK79G2kHrRUkcIhvVXJ4VMpMwQaS6dUdrmmV8bRvqb
	iSng2cNb50LJIjexfECSj6ACAxCCDhg=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2026 21:29:43 +0100
Subject: [PATCH batadv v4 3/7] batman-adv: bla: avoid negative reported
 BATADV_ATTR_LAST_SEEN_MSECS
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-dat-last_update-once-v4-3-3f7994b1f5fe@narfation.org>
References: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
In-Reply-To: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258; i=sven@narfation.org;
 h=from:subject:message-id; bh=tXNn/km5iC3YRqod+PDDBtedNtlL8O/kH6W/6f6JYvs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnP/Hfp7Y8v6i7PjnK4mXrplPiJuR6XT+V/Pri08voHz
 lpxCx2vjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEmmwY/jtavfrlEMX8/tYf
 9o3HT53IFL+0dAXnFPOEV69MktaX7oph+Ke/4IP1ruLqXZL8jROnzueJv79C0TdgTYrP13jpb1U
 z1/IBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: VULO6ODXRJSLU5PU3MELIL4PRKX45RTP
X-Message-ID-Hash: VULO6ODXRJSLU5PU3MELIL4PRKX45RTP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VULO6ODXRJSLU5PU3MELIL4PRKX45RTP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

To avoid an underflow due to an non-strict order read of jiffies vs
lasttime, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index a96f269d..0833f9f9 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -2363,6 +2363,7 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 			       struct batadv_bla_backbone_gw *backbone_gw)
 {
 	const u8 *primary_addr = primary_if->net_dev->dev_addr;
+	unsigned long lasttime;
 	int ret = -EINVAL;
 	u16 backbone_crc;
 	bool is_own;
@@ -2385,7 +2386,8 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 	backbone_crc = backbone_gw->crc;
 	spin_unlock_bh(&backbone_gw->crc_lock);
 
-	msecs = jiffies_to_msecs(jiffies - READ_ONCE(backbone_gw->lasttime));
+	lasttime = READ_ONCE(backbone_gw->lasttime);
+	msecs = jiffies_delta_to_msecs(jiffies - lasttime);
 
 	if (is_own)
 		if (nla_put_flag(msg, BATADV_ATTR_BLA_OWN)) {

-- 
2.47.3

