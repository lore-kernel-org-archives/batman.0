Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC63BC54FD4
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 21:06:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 21D3B832E0
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 23:06:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785359169;
 b=iAmHRajlVejIkY8DhiJvEulfGq4/TRtokAvueCIzvaa16r/wCLQMJe40oCaawfJeOA53T
 AJcXXP4Y3CW+pXwhlknDYU2pzPB1iaJrrVIvaAGmnsYIkYzzr0uBddOYNuTyY+eUwASd3Ns
 gsySVmSyyDNWpaimvt+QO5iPWQArT1k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785359169; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Y63110EXFk56H2ncDJurTzNm1AsQYBEhDJjMoqy12h8=;
 b=CSz/XqdrcRr2D4x2QzlYBdcpKYWROmscL/Anj7EMZGujKDeca73xkIh59LVf6f6p+ksMH
 MHvVdG3pb/aIRILKX7yjYUGDP2BszT04K14T31QezXwxGvEAyFxA0T0AC2MjjaNm59mOecw
 39MW7WGYkEmx+ybHkIW3G+dqhzLPECk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1FF58803CD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 29 Jul 2026 23:05:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785359150;
	b=rCAwmcS8SCefQKFcpvJ0dM3PWog+9RaZH2v4GKExGEi+0ChQVFr44+0u/6hgorYiMMLGjC
	IkAQqHkgUOz2vkESrCqBZsP4mTRcLTlgwF/6dNsRHzAuoD/SN3YQZe2tG9YBB/f5NlIQbM
	drHlf4JrDYINs9XDtNVudIa06Z7t0hg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785359150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Y63110EXFk56H2ncDJurTzNm1AsQYBEhDJjMoqy12h8=;
	b=3T2pJ2/epCJeuIOSrtTryM+ML0NwrFWy/E3Cwquk98OmzR7HDosczk6L3sJkCbJwm0M/0n
	cv+UigElgtENh1a8Yfxl6rdPy9fuy88J/FaPxaGDvgfxE7Iq34ydd01qJ4VyblYYkuWNaB
	r74tst5EBIOVIMUc71zvj7/WNfYK1H4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=sBKiO1U3;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 9E27D2005E;
	Wed, 29 Jul 2026 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785359145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Y63110EXFk56H2ncDJurTzNm1AsQYBEhDJjMoqy12h8=;
	b=sBKiO1U3tTykwcH1SXJFSbEhuZuZeSiGgR7CAU5sDaWmTSfi6cuskgPINjo8sJj7RaXovf
	bBea5yPFeg9GqyCnWY3wCHIdo1L4hpuVWs496ZcRvRsIQnfhCXKy1hoNzEnZVlwNPSTcpO
	EDykzz5W1LP5gPLDEpMGEWP1hZ8PVIo=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 29 Jul 2026 23:05:35 +0200
Subject: [PATCH batadv] batman-adv: remove negative returns for
 batadv_send_skb_unicast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260729-ucast-send-restrict-return-v1-1-07cf6d2ec5f5@narfation.org>
X-B4-Tracking: v=1; b=H4sIAB5ramoC/yXMSw7CMAxF0a1UHhMpRC2/raAOEscFMwjIdiqkq
 nsntLN33+AsoCRMCrduAaGZld+lxfHQAT5jeZDj3BqCDyd/DldXMao5pZKdkJowWhtWpbipvwz
 oifLQJ2jAR2ji74bfIUWLeYZx/7WmF6H9ZVjXHwtNXYSGAAAA
X-Change-ID: 20260729-ucast-send-restrict-return-f485c0eed54b
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1787; i=sven@narfation.org;
 h=from:subject:message-id; bh=Xd09LvVtogI/gLpVkdI9YuTnEXgQC6icAUpuX5LgHmM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlZ2So/pDTehMRe6TwhUBvO4rds18vNr+YExR6z35S66
 2SsYMnnjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEfkswMvxYdtvLeuOrX/w2
 l6IS53sVvJMw2z+nO6JcmOWn07WK6w2MDAdWKvjadaxZEOpwomfDouObS4tEmxnEnz8VF3ZYfbp
 4By8A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: VHPT445HLHSMODOB2DN3KNZYAYYZTAKV
X-Message-ID-Hash: VHPT445HLHSMODOB2DN3KNZYAYYZTAKV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VHPT445HLHSMODOB2DN3KNZYAYYZTAKV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The kernel documentation for batadv_send_skb_unicast() states that only the
return values NET_XMIT_DROP and NET_XMIT_SUCCESS are valid. Functions like
batadv_dat_snoop_incoming_arp_request() are only checking if the return is
not NET_XMIT_DROP to check if send was successful or not. Negative values
were therefore also handled as success.

Similar functions are not returning the batadv_send_skb_to_orig() return
value directly but are checking if it is a direct success and only then
marking the return as such. This must also be adopted for
batadv_send_skb_unicast().

Fixes: 83fef820ecdb ("batman-adv: Consume skb in receive handlers")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/send.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 2122560c..8c0315e7 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -324,6 +324,7 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 	struct batadv_unicast_packet *unicast_packet;
 	int ret = NET_XMIT_DROP;
 	struct ethhdr *ethhdr;
+	int res;
 
 	if (!orig_node)
 		goto out;
@@ -360,7 +361,10 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
 	if (batadv_tt_global_client_is_roaming(bat_priv, ethhdr->h_dest, vid))
 		unicast_packet->ttvn = unicast_packet->ttvn - 1;
 
-	ret = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
+	if (res == NET_XMIT_SUCCESS)
+		ret = NET_RX_SUCCESS;
+
 	 /* skb was consumed */
 	skb = NULL;
 

---
base-commit: 95b6f66b2659f617ce1937e790f48dc578ee014c
change-id: 20260729-ucast-send-restrict-return-f485c0eed54b

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

