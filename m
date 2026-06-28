Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7ED2C43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 05:42:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3871283EC3
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 07:42:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782625343;
 b=0ylCw9Wu53AeeQUrPrDx303PYBWPDmlFnMuL4/h6Rupo6Bj31JIUK3ROYQAxB+hkTRgQS
 QdMWkmz32QCxuvzFtFymcXMGXuiqhZO2nolOuWeujJXV0nzW1aAVpl4CdLwYd65ksDAgoKV
 mOX0ZpafD3lIwwuk+42FXDzqnF2TlaY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782625343; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5LSnIwquaXIdodFd6wEaGmfWIJqwzucCdnCRmg+q8AY=;
 b=b3f2NjH1LlB7kZZMj37lC+4vggpBhwcZu4O+ecGXICe7JyLj2H3FnNuxXtwmbjri2Irx8
 EhWmdxCJ6T/0XY03M/B9l70mTM79YpyZhk5RVnQbDqEExAlodeXA1z3Vr4qdykhALnLh0f0
 ZKX3XM3HNqbsXfbvg3u77CiiLLQo6rU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6B76E8112C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 07:41:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782625322;
	b=cqDU5MBtpyb4nCxweAQKfu2oglTX9AV/hbso5hZXlYsyFkl2ATbESi3jWiJ+5R7mDB6awU
	+qRva6f2qGxdrgC4S8yhB7v+RNJi7rkgRE350cdnxmnbWrxbEpsL4fhQXh3WqIzmvQ1+4i
	aVmC1grWzIcf9ngD4Wa8dUJLOOw+Yag=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782625322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=5LSnIwquaXIdodFd6wEaGmfWIJqwzucCdnCRmg+q8AY=;
	b=0gkia7gzR3w+D5e/7o08LQWrYcQ0BE/NAd0x9bglHb3UUhDVW1BM2QRRXS2vB+z761vuPE
	FR6ksL33E0AyZzajRwXgxmJIOeQXZGqWNQbHxWZ4KIMxCFrdmqy/vd0qtQcNEqEiFHhvKw
	b/pw6DZp51Mjfx1p8s68fzqKkcANd5I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ZPyBsvxt;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 8234D20272;
	Sun, 28 Jun 2026 05:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782625311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5LSnIwquaXIdodFd6wEaGmfWIJqwzucCdnCRmg+q8AY=;
	b=ZPyBsvxtfaadyaWUCM9ZdkBIQGYDVWzLpf+emAve16KerrzrtnQa6XiiO4kDxsdEMB3Lkh
	pzaJHTuU0p/A2+PJPcyk30XOFPPoAsCyt5th+en4bkK3FKZVEHLn0mrY0XmJmGCBOmFBUv
	YAULRLl+lkIOsNvdm3Yjkq/UFTWkDyg=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Jun 2026 07:40:50 +0200
Subject: [PATCH batadv] batman-adv: retrieve ethhdr after potential skb
 realloc on RX
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-skb-post-realloc-v1-1-6218ffb71633@narfation.org>
X-B4-Tracking: v=1; b=H4sIAOGzQGoC/yWMywqDMBAAf0X27EISUaS/Ih7y2LarYiQbpSD+e
 1N7nIGZE4QSk8CjOiHRwcJxLaDrCvzbri9CDoXBKNOpzvQos8MtSsZEdlmiR02u1aFVfWgaKNm
 W6MmfezmAs9mGA8a/l91N5PPvB9f1BVUcqnd8AAAA
X-Change-ID: 20260628-skb-post-realloc-1eb51d508d33
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sashiko <sashiko-bot@kernel.org>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1296; i=sven@narfation.org;
 h=from:subject:message-id; bh=xd0M2vxpH48FeHrI0dxP4eM+4kivptekCiOnkxEEIbE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkOm3+FfsqzMNyzms03z3TeSflfy4IuVATlfnMU7P0Vm
 5y10OJYRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAiVvqMDBsfyIjfXz5tPXt1
 gXl8jFRP+Qae3ijVrqX12e/yNdexTmf4H/+mr3NOCPf0OUuMXns+Tvq83zfErC5kw09ru2USm+v
 juAE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 3QYB2YJNDQJACMWKMPK4FOI6TOPCP5Z7
X-Message-ID-Hash: 3QYB2YJNDQJACMWKMPK4FOI6TOPCP5Z7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3QYB2YJNDQJACMWKMPK4FOI6TOPCP5Z7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

pskb_may_pull() in batadv_interface_rx() could reallocate the buffer behind
the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

This was done correctly for the VLAN header but missed for the ethernet
header which is later used for the TT and AP isolation handling.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 48628bb9419f ("batman-adv: softif bridge loop avoidance")
Fixes: 7d2f8a773bae ("batman-adv: Check skb size before using encapsulated ETH+VLAN header")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/mesh-interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index e5a55d24..907968a1 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -434,6 +434,7 @@ void batadv_interface_rx(struct net_device *mesh_iface,
 		if (!pskb_may_pull(skb, VLAN_ETH_HLEN))
 			goto dropped;
 
+		ethhdr = eth_hdr(skb);
 		vhdr = skb_vlan_eth_hdr(skb);
 
 		/* drop batman-in-batman packets to prevent loops */

---
base-commit: 70dab058ebed0bc0c66dc40113039129b3089780
change-id: 20260628-skb-post-realloc-1eb51d508d33

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

