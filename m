Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E75C43458
	for <batman-adv@archiver.kernel.org>; Fri,  3 Jul 2026 18:29:11 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7B05A83FFF
	for <batman-adv@archiver.kernel.org>; Fri, 03 Jul 2026 20:29:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783103349;
 b=f9FjuPAd6IdWj3xG+Xm37yJwkdYISXnm9Kg/5osx8QBgFicV1+bD85FbpOvs1zAlZkz+j
 31iEOZ3f6M+iscX38NOMz3KtG2Oz3a/0KV/DapvsI3zPu4l5NdCgGB8pObxdVQccaCjeXR1
 q0zuR3h80VkIi1+M4+DfKpdp0f+IX9k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783103349; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=xbF65oUllXW1riljpzq16hr3bK/nnU32KPuIa/pGRrc=;
 b=cEMq16Gu58i55xYOV2VHg4PkTKGICbGkSaW9fjKrncWUNHVezqHNCBLFxmlDsX40Y7yGr
 NJWFoas0cE2Bu1e/vgxmHcDvqsdmtkuK3MZIS9M/Hwak1CK+Jd4H6493C7XIHDaY5fGFDol
 7VvRNVHHO6S+2/9wzMyZCJjnk5+P06w=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 861D8815BB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 03 Jul 2026 20:28:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783103329;
	b=oIjVoH01vG16ewcuTbq0K+UdTUKHphvBhpoacIGqL8xT1p9r/4E7+zKAslzHdUD0/eMB9k
	nifTEQEqTkemFTSJIuYaC2NM2NOBE6k/haWbihHPbx6MMqtus2O8E31tmF0wWLaDI84/S3
	8PyyxAwpq4sN38JiPkTaMQ9QwEAE1Fc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783103329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=xbF65oUllXW1riljpzq16hr3bK/nnU32KPuIa/pGRrc=;
	b=btwEPnJaLjlDoactzJSCIXnOOfEh0p7JLgJCy7MU/yOwTk2yB1rrBpsV6Ib82uqzVshEKF
	ayWtNSD8XurNUeJvSAT5Pn1+qyrrCJRYaFzC2K6jhwcsAss3NRpbD93kLYd6TWV2bpOvmB
	5REfjpttxxdWVbBf+Uoe+9gWGH7GU04=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=akI+W9ta;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 798AF1FEF7;
	Fri, 03 Jul 2026 18:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783103318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xbF65oUllXW1riljpzq16hr3bK/nnU32KPuIa/pGRrc=;
	b=akI+W9taHgHeoABvHohRXdX9c4jqYAyAYmZsYvWfMOO/3ureTvT8UibY7vxPHo9BOPdSS5
	/AfLoTbPN5a5iooTX98R+7RHxvdW0e8mZp0MtaIYHovZZquOT2a7wBjOX2SaPbg04EDGA6
	qAvFIRnscQHhUPmGUX6cv8K9QBGjq58=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 03 Jul 2026 20:28:31 +0200
Subject: [PATCH batadv] batman-adv: frag: free unfragmentable packet
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-frag-tx-always-consume-v1-1-ee5e5f0d1d10@narfation.org>
X-B4-Tracking: v=1; b=H4sIAE7/R2oC/yWMQQ6CMBAAv0L27CalhBr9ivGwLQuu0WK6BTGEv
 1P1OJPMrKCchBXO1QqJZ1EZY4H6UEG4URwYpSsM1lhnjqbBPtGAeUF6vOmjGMao05OxCa0x1jt
 /qh2U+JW4l+U3voCnTN0M17/Xyd855O8Vtm0HaOLQQYIAAAA=
X-Change-ID: 20260703-frag-tx-always-consume-3c5002b6b916
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1368; i=sven@narfation.org;
 h=from:subject:message-id; bh=twrs7QxdLJzSE2S2mWzoV/XuLU1XMaG5aQKcW+zj2DY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnu//23lT8/OMHwgYfLF8/Np5vMjGwnL7hvcqVZf9Wd5
 PUX1GPPdJSyMIhxMciKKbLsuZJ/fjP7W/nP0z4ehZnDygQyhIGLUwAm4u7ByPDkiAHDSa27ibuF
 L0/nrjDzVz51M+XDQvEv5RW3myZF/CpkZHhh+Ui49Icm3xqDJv5b8rOVO7naNsub3GPJWytYvOH
 VXT4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JCQ27QBTABU6WOUA5N4O4INARC4RBOTP
X-Message-ID-Hash: JCQ27QBTABU6WOUA5N4O4INARC4RBOTP
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JCQ27QBTABU6WOUA5N4O4INARC4RBOTP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The caller of batadv_frag_send_packet() assume that the skb provided to the
function are always consumed. But the pre-check for an empty payload or the
zero fragment size returned an error without any further actions.

A failed pre-check must use the same error handling code as the rest of the
function.

Fixes: db56e4ecf5c2 ("batman-adv: Fragment and send skbs larger than mtu")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index e2c74ae6..e9d2bbc4 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -524,8 +524,10 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 	mtu = min_t(unsigned int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
 	max_fragment_size = mtu - header_size;
 
-	if (skb->len == 0 || max_fragment_size == 0)
-		return -EINVAL;
+	if (skb->len == 0 || max_fragment_size == 0) {
+		ret = -EAGAIN;
+		goto free_skb;
+	}
 
 	num_fragments = (skb->len - 1) / max_fragment_size + 1;
 	max_fragment_size = (skb->len - 1) / num_fragments + 1;

---
base-commit: 22b12d005035f37f898e5bf80480719fe1ef4fba
change-id: 20260703-frag-tx-always-consume-3c5002b6b916

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

