Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EBAC54F54
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 04:51:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 94AB98403B
	for <batman@archiver.kernel.org>; Fri, 31 Jul 2026 06:51:17 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785473477;
 b=ZavpTcrG4L1jxjzUguTIx5meNgFBxndpN/4nZX4UCFGx2hOaxg9vc9A56cSji9c9d3ghM
 /VTsqK4ZHiiRqKok/RX8XPaNEtSPXIOBAxdq7K5QTbqHi99r05lRCXSjO8BgtSm4s9dLpNg
 nEx1nrhKJAQ2p3++TGowbSEhypsXx3M=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785473477; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=FcSnRmnSUozJyCxZnZ3dFh07SwvSj/6DYCkEI6+P46s=;
 b=Hqgfx4dJ8kWG6Rn+cEvTRKtBulcnr5zoBVfcUx/G2uH748KruWeEMdRoQQzRul88PlwSP
 rcw5N0VBF7JZvcd2/NacbxOhwayGAI82sy47Mt7XEA9tP5wVizdJ2DJ/+epM+dVp6Lm8lxe
 nvhTaTlWb4pYPUeFHVjVhowi8TS+Lzw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=nebusec.ai;
 arc=pass;
 dmarc=pass header.from=nebusec.ai policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=nebusec.ai;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=nebusec.ai policy.dmarc=quarantine
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com
 [IPv6:2607:f8b0:4864:20::435])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DF4D58184C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 31 Jul 2026 05:19:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785467965;
	b=j6bd8G2SCqrrUlBKIoF1b6zNReTybYkGf4NtEY7DxHkCoGLM8GhNEOcAz5oCQlNPPsPpXa
	8Yyc1CGY6nMX+opEwD6WiZoH69PQKv2EvN8bWwKY4Nk3sjglSCriylcWMMDQRmBdQyuHZ/
	OOayqnmxeMhBokTjxlIfOZK3KYlR5Dg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785467965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=FcSnRmnSUozJyCxZnZ3dFh07SwvSj/6DYCkEI6+P46s=;
	b=jP/vLafOW/c66obEHAzQhqdBq66QiLIWvGa+wsom2zSVC/NCEMg0bssHO4y+94MfWcNfpw
	dHQZXSLzjKKG8RvxmGOjjkdjuEDVbZ9CNvVW8M/ZFRRpnLoVEWKuU5dqfQGsB+B3Volis+
	eukC4nh7EpQ/9SUzrZ2Hs+rKLMjxeKQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=nebusec.ai header.s=google header.b="OE0a6y//";
	spf=pass (diktynna.open-mesh.org: domain of zhilinz@nebusec.ai designates
 2607:f8b0:4864:20::435 as permitted sender) smtp.mailfrom=zhilinz@nebusec.ai;
	dmarc=pass (policy=quarantine) header.from=nebusec.ai
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84e27035206so661315b3a.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Thu, 30 Jul 2026 20:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785467954; x=1786072754;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FcSnRmnSUozJyCxZnZ3dFh07SwvSj/6DYCkEI6+P46s=;
        b=OE0a6y//iG8E3m2qcecC1sZw9fkhrqDKgWm24bhAx0dd7IhyHCZWS25XcIBEfGz8fz
         CAW+3BeNLaSQSl995Pip9ozxSmLRsOBCQHkjVNicq0w/hqS7UB8BIBGtneMIfxnakbTH
         HaDFxPskejt9a2ZluW6s5fPVpI2Fs/cg2k3aIyImsAOrPCBT/cOT9/dygscNOcxgdyoy
         rjH7UuloIH3jPUZ/QiWfmAXmJSEenD1t1pssUWvQzslS0mGQEjq/7dkF2WqgTn9stPzJ
         lrpBxhW/JFZcubqFVFFSDF94PWTc/PoS6Js0+R5l9PAz4IqLziuYGoXvFwI2ByRomwVf
         oCAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785467954; x=1786072754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FcSnRmnSUozJyCxZnZ3dFh07SwvSj/6DYCkEI6+P46s=;
        b=KwbWCTgNDT80xvDMAcvOTtztqyPEHuT1/3v00SQRjoPwpMS2IsyqdGHD/gBALReHum
         vEGDxl6JA2M2fT7prIYRhGvhQZa2V1MPElQyWp+A+xnifnwS0a9D71coyiS18Jqtrq0A
         xPoTjopPOjjSMbqCJB7eqiJcYWTira49PmYao6Tk0QYpJEFNdEc2dujacMFawty5MQBk
         dVITQflc81FH+EB188oGkpFfVocnDaTVeD/+OO0wjEeoXzdB7ofuuhG7KmMNeWbx00rr
         SmNLo7j/y/RGZDDm0CpbOtiYMBZ/TmB0cKpYM9q/Z7jwYdIQtcQi5ExT1D7ciPOvNl0P
         8VPg==
X-Gm-Message-State: AOJu0YyCFCS096xZXHQ/WhW5kwHPOBodxdXxgo/sobAXYhEtvPMY0kRK
	JAshtXoxdYuZQZX5cvVjjMivn2/iedeNRr2QQxCiba5YDHuCfmrkEF8Pq+yyEsvgWG1Twt4NQDD
	xfiE+xmKbChU=
X-Gm-Gg: AR+sD10lUabhPv9YknLXETo8igNNAcC84xgT37kCAYMM0lMr2ObXu+oce/mf0axErO+
	k0W36c0Kwi13zDqblLb7mOjG0D6C+rop03Sjub3L3saZG4fLqA8dtRRfB0kYJt/h9lWNf7yO3cl
	MmrVwDJyGePDw8MudM1mrm8TXipk+/2ll0VXh7GfIqtaUTxVQlIF7LR0I93d4AI1BOp4Mq1ilNH
	PkQ+l8IdgccpsrryQ+j4Ezr1JAmjFNSqOxlRc44wyBctUTGOhMQ2HdGhvPmmAHwIZ5K0qpxoePr
	JoD5/eI8Kf02/L2Ksr73Dd5y+lAaMF5e8j5yk+05wFa8kw1G5ohbH3WspPMvYE2SOlIF301LXm0
	V3cs4YIVPKTWJdCwQXZGi3b8ikaFUzFRKNlqJiZpl6kbug2nxa9x8O41dedfGB/KzhXyfUb591j
	Us8xeiFRtVTyz7Dxy8d1XQaR5o8p5mexcYuNMLUb/Yc5hUaxuo/PL8fxnNxbBay8RnB5OB9P43d
	C2WDYrY1buh9MI=
X-Received: by 2002:a05:6a00:4089:b0:848:2f84:739 with SMTP id
 d2e1a72fcca58-84ed74deacdmr227208b3a.76.1785467954032;
        Thu, 30 Jul 2026 20:19:14 -0700 (PDT)
Received: from Roxy.localdomain ([203.175.14.58])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ed57d2197sm142557b3a.18.2026.07.30.20.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 20:19:12 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: marek.lindner@mailbox.org,
	sw@simonwunderlich.de,
	antonio@mandelbit.com,
	sven@narfation.org,
	martin@hundeboll.net,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH v2 1/1] batman-adv: fix stale receive device on merged
 fragments
Date: Fri, 31 Jul 2026 11:18:49 +0800
Message-ID: 
 <abdace3ea80a8ca052619d612ffc8d0963b57513.1785467374.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785467374.git.zhilinz@nebusec.ai>
References: <cover.1785467374.git.zhilinz@nebusec.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: zhilinz@nebusec.ai
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: BFHR55BDSPWYD6WBSVEK3D3WYOZ244P3
X-Message-ID-Hash: BFHR55BDSPWYD6WBSVEK3D3WYOZ244P3
X-Mailman-Approved-At: Fri, 31 Jul 2026 06:49:47 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BFHR55BDSPWYD6WBSVEK3D3WYOZ244P3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Fragment reassembly reuses the skb from the highest-numbered buffered
fragment as the merged packet. When that fragment was received on a hard
interface which is deleted before the chain completes, the merged skb can
re-enter the receive path with a stale skb->dev and skb_iif.

batadv_batman_skb_recv() passes such merged packets through the normal
receive handlers again. DAT and bridge loop avoidance both derive the ARP
header length from skb->dev, so they can dereference the freed net_device
before the packet reaches the local mesh interface.

Refresh the receive device metadata from the current receive device before
running the packet handlers. This keeps internally reinjected merged
fragments consistent with the normal receive path after hard interface
teardown.

Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
- Drop the net target prefix because the patch is for the batman-adv tree.
- v1 Link: https://lore.kernel.org/all/d255da4c25ad5da2462708841368872438e1b99c.1785424299.git.zhilinz@nebusec.ai/

 net/batman-adv/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 67bed3ee77e7e..7918886e6f94b 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -450,6 +450,10 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	if (!skb)
 		goto err_put;
 
+	/* Merged fragments re-enter here with reused skb metadata. */
+	skb->dev = dev;
+	skb->skb_iif = dev->ifindex;
+
 	/* packet should hold at least type and version */
 	if (unlikely(!pskb_may_pull(skb, 2)))
 		goto err_free;
-- 
2.43.0
