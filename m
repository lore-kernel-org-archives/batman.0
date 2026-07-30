Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E34C531D0
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 06:24:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 11C10808C2
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 08:24:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785392642;
 b=2sn65uoqWTqfb9TgS83HFGb605Y6JfFlC0Zic/dqK9P9Zv9FVXhV+Pygsbk3YQjLlMy/M
 O60hKpmFaowRgoUJq1J/7IOmD5yypmckteb3StlfYc/37IxZTOwqtsvUseNUJBbxvgdw/K7
 U9OFtoSumXJT2Qzsz+jmYchyt43jD4k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785392642; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ehRkeWLcdpIWzXZ3Ay2FSQuYl4p/Nb6C997u+/GfnfI=;
 b=q9Ad4mv63X3SGMbxUlxQP2EL3AfO+GuIVqhrHjOhw7cKM/U/d0M9vPnk3UFyjx7OUvkO6
 4qRURlUk+Cu49OQFC21oNaT9J62Ih09uswwV/qcEK0MbJQ+BLmIeOdyNawE0oMH1yRazrbG
 R4FEfA/LhZkzUVkxzqVHi8bxIj5A8ls=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 20D0780C1F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 08:23:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785392621;
	b=nnOtuJGj0A+GYX6Wq0CGfjRzQY3FhJjCPOySsyoLzYeglCQdkAZqwCoI26CZF9ie8vqb4z
	EGsr9eahLaaUl6k3W9dUX5QguFzK4C5/18EIenjS19KEj+AdVBT+k073ve0Lvfn+f5qquk
	43BMzB9J6+BmOH3XbKmroaGM8K+J2cc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785392621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ehRkeWLcdpIWzXZ3Ay2FSQuYl4p/Nb6C997u+/GfnfI=;
	b=sbAuX0MxCiF6Xov+n6max8JiT7KM4Dvu8V54bqnwa/AZNNFIQOhAtqsDMcwQR9wVoeZi3a
	GeZwFwFLNZPFqVdIa8+8dCHa7uEdVs2TFs4h4wmAtB7OnBS3UpLdp4KMypKf457aAeow4a
	mdzxfFN++PPjqCSpiPgNztzUjBu15PY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="SXAA3UU/";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 365931FD3C;
	Thu, 30 Jul 2026 06:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785392616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ehRkeWLcdpIWzXZ3Ay2FSQuYl4p/Nb6C997u+/GfnfI=;
	b=SXAA3UU/qokwENkdpEsM9xqiPkJkBhIsuIxkM9VMm3CHiTP2+HzWnEHCvU66bWXh6qwSfL
	IRFaDXGIcD+gH/CDirytLQNIwf0JuOy7HGvm8zgg3LPdxtErC5+XnWIoYynVvClm2TQJLL
	s0qmYC5ax/sSGHshSc4MGWMQijKICwg=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 08:23:28 +0200
Subject: [PATCH batadv v2] batman-adv: remove negative returns for
 batadv_send_skb_unicast
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: 
 <20260730-ucast-send-restrict-return-v2-1-0a40eca7803d@narfation.org>
X-B4-Tracking: v=1; b=H4sIAN/tamoC/42PwQ6CMBBEf4Xs2ZrSUFBP/ofhUNot1EMxu6XRE
 P7dgj/gbWczeTOzAiMFZLhVKxDmwGGORahTBXYycUQRXNGgpGplp65isYaTYIxOEHKiYFM50kJ
 R+OairUR0uhmgAF6EPrwP+AMGk4zL0P/+vAxPtGkn784pcJrpc7TI9eH/JzDXohays751Cq32+
 h4NeZPKhvNMI/Tbtn0BmowcquIAAAA=
X-Change-ID: 20260729-ucast-send-restrict-return-f485c0eed54b
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2007; i=sven@narfation.org;
 h=from:subject:message-id; bh=7x+j+vut6w0eKhJJvoKcW9MGYPhqOaXROtZCR9qyJEQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlZbx+c7VOdz/fHVoLl07ni7xNVmPJXTox5o82WsNMye
 cvspXOZOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATWavIyDBtWVLdpNfpUzqb
 Ls9/fsfxeds6nygOo19vtk0Q43/i8C6M4a90stHu3tZXSXvPzeuUm3pYelat8rI5CnUlF34ctCy
 JdmYBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: OI5LNMDXBA3CXZGVEMRVBFMJBI7HJGBK
X-Message-ID-Hash: OI5LNMDXBA3CXZGVEMRVBFMJBI7HJGBK
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OI5LNMDXBA3CXZGVEMRVBFMJBI7HJGBK/>
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
Changes in v2:
- fix NET_RX_SUCCESS-NET_XMIT_SUCCESS confusion in code (not actual
  behavior change)
- Link to v1: https://patch.msgid.link/20260729-ucast-send-restrict-return-v1-1-07cf6d2ec5f5@narfation.org
---
 net/batman-adv/send.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 2122560c..929b6dd3 100644
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
+		ret = NET_XMIT_SUCCESS;
+
 	 /* skb was consumed */
 	skb = NULL;
 

---
base-commit: 95b6f66b2659f617ce1937e790f48dc578ee014c
change-id: 20260729-ucast-send-restrict-return-f485c0eed54b

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

