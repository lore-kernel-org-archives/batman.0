Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09674606A31C
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=URx5qU17
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 978CE84220
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 14:54:44 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793368484;
 b=h5GWB0T5xP/tXDITJcVgYeC/ex7p/8mF7CgQIQG0YU2xHBixhfWQPZYF2n0z8zdw0t27b
 VQ3373yqtx0y5paFOXCY1HcCAhYNg8QfxzUjj8DI4WsUUz4LlA8plpQDYa8h4eqRf0GUo5r
 lw7C87Gi8hBvFHznOOy/NG+C2Y0Q6hE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793368484; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MN8z/mlRHPV44mj1rD2L1TistCnF9IQ3ZHZlaq5saXc=;
 b=vnry7nzMFToxddv90EqvyXzC6sPGfixCuzUxl9T1VZ/lfi7Gt0qcuC1nSMdaemlFfMqyU
 5noBISSewdpKXh/W/jW63jcLo+wMjYB06UQ4sfDWFnOPU/W6MWYMGNYstYNOiCjr2ZZZqxJ
 /s5FnozCJyglyo2rH5HPXCZ7isn3RDU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 04F2584260
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 14:51:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793368290;
	b=uYbl05jx1HBhwQG3qEyMm7rtnA4aBE3sQf70nQW1uqx0bN8LhvzaNupB5kYSonWlk0aZ4H
	TDowliIpBieBTyQdZca2/Om7XPasvS8vSTfE13sjKIerwQIWiuLQbcY7gupUAOXyPzBSfy
	BkUZXCa60ccIgQTVTz5Vq9pDDjwLv9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793368290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MN8z/mlRHPV44mj1rD2L1TistCnF9IQ3ZHZlaq5saXc=;
	b=cRX+zgPK0FSGYTxR3PAy8y0TMKxKmMR60jYj8fQcHPvZMRPtG9QoSTiuzxmGK8bZSLEpcH
	ms197VtXy9Psu8eb+aef0a+kPHqRra783OEe/kMdvZhYr0unzeyJGGYpJcnBzJlSx+51+D
	uEhepvKmQm73VAJlgK6OFYizLNCoybY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=URx5qU17;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c597124Fd839580c360D3ED6F6.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 80F8CFA1BF;
	Fri, 30 Oct 2026 14:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN8z/mlRHPV44mj1rD2L1TistCnF9IQ3ZHZlaq5saXc=;
	b=URx5qU17hWFzI5EDnjEk7CwCJw3sng7NjxHdv6MfYpTKfQHL/XEBv19itM7VCUyk5Nd9pm
	rlLoBHWuST4nePgWSxFFzD5JGrIJE05lmBwV895nizIP7xM/q8kdlyoBuOy11zwaJNXIn3
	NPL5vSKgpKqVzr6Srbk961dOuzSxDW3QTQMYFYhTZCN4knwMdV/u05RKi8VRoc6sNOnnrM
	IOMDH3wJTkclipjnv9RZMZ/AkFDRWjE00hw+DwdizDqmCGJNLwzhbXRF8bhJ1axER/Vjvu
	nefrrdNLJdToPhhuohsk0u9wD7IQNkT/569kEf5uUnoxFM6ATXPoXQx3OEQpQQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 06/14] batman-adv: fix skb leak when hard_iface is being
 released
Date: Fri, 30 Oct 2026 14:50:57 +0100
Message-ID: <20261030135105.2555887-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 3ZLOLHQDRJI4P3MHEQGCMNYORFB4HMTY
X-Message-ID-Hash: 3ZLOLHQDRJI4P3MHEQGCMNYORFB4HMTY
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/3ZLOLHQDRJI4P3MHEQGCMNYORFB4HMTY/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sven Eckelmann <sven@narfation.org>

batadv_batman_skb_recv() owns the skb it is given. When the hard_iface
refcount already dropped to zero, the function jumped to err_out, which
only returned NET_RX_DROP and skipped the kfree_skb() under err_free.

To avoid a leak, free the skb before returning in this case.

Cc: stable@vger.kernel.org
Fixes: 4fe56e60ac1b ("batman-adv: Check hard_iface refcnt when receiving skb")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 6c54a8d4be3ec..ced76942f33c5 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -484,8 +484,10 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	 * shut down otherwise the packet may trigger de-reference errors
 	 * further down in the receive path.
 	 */
-	if (!kref_get_unless_zero(&hard_iface->refcount))
-		goto err_out;
+	if (!kref_get_unless_zero(&hard_iface->refcount)) {
+		kfree_skb(skb);
+		return NET_RX_DROP;
+	}
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 
@@ -541,7 +543,6 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	kfree_skb(skb);
 err_put:
 	batadv_hardif_put(hard_iface);
-err_out:
 	return NET_RX_DROP;
 }
 
-- 
2.47.3

