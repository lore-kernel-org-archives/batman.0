Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD586606A324
	for <batman@archiver.kernel.org>; Mon,  2 Nov 2026 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=iBPrbcD2
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 614AD842C1
	for <batman@archiver.kernel.org>; Mon, 02 Nov 2026 19:22:37 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793643757;
 b=YY4tIBKq2Uw4hCj5H0oL9q0Cp18auH5dT/5ph3brQ8bXFBQJ3jqGc7GDakzffYxeUjfIv
 AMdcNO9GQ6LwlRQrUM7CRzA3KyBdTmK9VAIOks6CxFTBlv5dlYNzwIvtt2T/HyihLpU0zo8
 voGHD13PzPCVhtvgauIzy/MRnxjH9XM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793643757; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=82OnINR+mZmmlUPY/g8uMPePi7qryrUH7aN62aaDi2Q=;
 b=EoRWKtNt4BnFCC0BLNYwk9aDonbT+p+w/2fETy5Zt8+CA7o7CT8MCH8Xz1xlrJVynvFNM
 LqG79fskwwpfRQP7dhF1a+FA3x6ebGvzAAMgmLNp7zxEKZU6OXGypTbcz8wxFzYQN6MYUqw
 sj/hRbqfryMK2Ut4apLg9VH0dZzD5Xs=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 622A6802BD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 02 Nov 2026 19:22:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793643742;
	b=1MkdRPLBh6Kl4shyG/pnpSEvwyAaMHXUdmqcPM9rC96a1bi/CfI5QPz4zGs0kA5WWgmgJF
	mNBi9zuxrFQ3ta/AvfYxeGmlHz2/PNHeaSIt2cySrfB9LPFNsGlQyeM3D3h1vi3AH6412l
	FbUgL0a7rj9cqJht7GQVN4c2oGUmJG8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793643742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=82OnINR+mZmmlUPY/g8uMPePi7qryrUH7aN62aaDi2Q=;
	b=PMmyzsMzV3AHlodaI8U+IBxONkUNixkLVggjJDsgSwx5/QNTyK2tvUe6tRgYzJelqNPTOx
	C7yLYNEjHSQv7BU1a0pnSWdhzyPkPKW7uCm0gypxSNfSm7gFcI79KAy2l7GNbVrXIReXoB
	OckyY16YB+f+zkQ+hd3k21VTwnL1L84=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iBPrbcD2;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id AEAB81FF75;
	Mon, 02 Nov 2026 18:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793643730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=82OnINR+mZmmlUPY/g8uMPePi7qryrUH7aN62aaDi2Q=;
	b=iBPrbcD2PYU8UhQaMRi/laiCL38zQnPASpoyWmBfvSAJE0BQ1jdleZlANZhjKSQcM56J7V
	HEppfUg+dcEgYYkemeInEthhdga/P+LL05b8pmqmxkLa518YxOc9sJIX9FGlXZjJv/1+cg
	h99p2G1jB9fYBMdlglDzsTRyOMpAfVU=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 02 Nov 2026 19:22:05 +0100
Subject: [PATCH batadv] batman-adv: clear skbuff timestamp on send
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-clear-tstamp-v1-1-f64a8ac9af80@narfation.org>
X-B4-Tracking: v=1; b=H4sIAMzU6GoC/yWMwQ6CMBAFf4W8s01oDRr8FeNh2S66RJF0KzEh/
 LtFjjPJzAKTpGK4VAuSzGr6Hgv4QwV+0HgXp7EwQh1O3tfB8VMouWyZXpNrj03ozw1Hz4ySTEl
 6/f53V3SUKc647d4+3SCctxfW9Qc+nQPNeAAAAA==
X-Change-ID: 20261102-clear-tstamp-9352f75cd1cc
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: David Lutz <kpanic@ff3l.net>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336; i=sven@narfation.org;
 h=from:subject:message-id; bh=6SaXf4NFkN3G8xNu2syp/onSXYqeUPeN0FVEtQzyvig=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkvrpwLC8hfLv8ydO6PyrzXcr7TncX/v218JB7NfVSmr
 +hUM09ARykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAi0aWMDI+1W49nsKYZ1npO
 Oc764Av/z+pFO+8u+LbcYb7pq31/jjswMnys1ZiYrXp9yu/1N3bfXvI81KQ3I/UBi+3D0O+lCjd
 ZT7MDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JE47F56KAIC6JW7PNJO3C7ZL4EOOC3YG
X-Message-ID-Hash: JE47F56KAIC6JW7PNJO3C7ZL4EOOC3YG
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JE47F56KAIC6JW7PNJO3C7ZL4EOOC3YG/>
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

When a packet is forwarded, it can contain a tstamp in CLOCK_REALTIME. But
fq's scheduler expects a the CLOCK_MONOTONIC timestamp. If the timestamp
wasn't reset, it will simply drop the packet (horizon_drops).

commit 8203e2d844d3 ("net: clear skb->tstamp in forwarding paths") already
fixed this problem for the IPv(4|6) code base. A similar approach is taken
here with the more skb_clear_tstamp() helper function.

Fixes: fb420d5d91c1 ("tcp/fq: move back to CLOCK_MONOTONIC")
Reported-by: David Lutz <kpanic@ff3l.net>
Closes: https://www.open-mesh.org/issues/489
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 929b6dd3..97d5e72a 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -92,6 +92,7 @@ int batadv_send_skb_packet(struct sk_buff *skb,
 	skb->protocol = htons(ETH_P_BATMAN);
 
 	skb->dev = hard_iface->net_dev;
+	skb_clear_tstamp(skb);
 
 	/* dev_queue_xmit() returns a negative result on error.	 However on
 	 * congestion and traffic shaping, it drops and returns NET_XMIT_DROP

---
base-commit: 04071c46a5cb4fe3078ac44b48d11268ba275438
change-id: 20261102-clear-tstamp-9352f75cd1cc

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

