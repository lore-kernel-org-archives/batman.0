Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1918C606A324
	for <batman@archiver.kernel.org>; Mon,  2 Nov 2026 18:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=s+S1LMZ1
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B181584260
	for <batman@archiver.kernel.org>; Mon, 02 Nov 2026 19:46:58 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793645218;
 b=IBTh+Mjm8Hc+gMBHOmE020yiLIQLsnNB5KAmT1U0MoymZGT+FYWtrY6HJUMk0V+WNgxJh
 2zZFIvGaZbMg+7a+3/0pqfNxLVnpmOPyWeY8Txf8xPOELy7xXDpVYAKM2fxcqBz1un5WJmH
 8HZAuS+/aS1DRPA3ggb+Zii/ydN1/xY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793645218; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mk9E4FPEAd0Yl9pPUwxZTWF7HxWQtF8VsV+809ojBD4=;
 b=cMH8fa112i6wOnmaBM+b5JEzlYqJxxUZ6ErTRPZPXuD198NCQpS8gxMqjl4psnV3pd9fe
 IXBACNWR2UDMLXP1wJE8SwKM7nAC0EDfpyPVnosBddCBUbYfuL8456aY5IjNTZ8A5gbgl/Y
 jkX/2lmzKtrGYMzHVAmNWXxP1OsE/mU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 14A24803A4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 02 Nov 2026 19:46:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793645203;
	b=Rnrn8r/MfX+EgnsN9s5X4Bvji9oFMWvS8s5WL346LixHLAitqwVI2qT0RUTnPu1BNixlcy
	8+kjVLDOSagg3KZDAB1m9ZXccd9N/8q0YKkYkF+TV5jLf0eQGXmUvs+nMxUbc2Q3F+rMsI
	B+Yo1fLUgbh7WaXZTGwfbU6/Gt/Vi5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793645203;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=mk9E4FPEAd0Yl9pPUwxZTWF7HxWQtF8VsV+809ojBD4=;
	b=DrNoXq3m6K2/L5F7VQ/Ho/cUG5RIUXWaSHI00WW9Tv3003VdD42hUqQY339mAWxyQpmVGM
	pKxS2S11NlFgVeQT2HEHNo7j7te3lTWMhopbWQvzOt7t3BT8oMLGey+fGErHiVYShh5GlU
	pXzaMPU30Rih5ChHpfRhoU+5QBCBaQ8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=s+S1LMZ1;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3B0661FF75;
	Mon, 02 Nov 2026 18:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793645190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mk9E4FPEAd0Yl9pPUwxZTWF7HxWQtF8VsV+809ojBD4=;
	b=s+S1LMZ1heON5O8ej0Go9qT5dO3lgNOen8hl1dwO+AVtWbffPp8DTUrJ3aAuiOqQFgza3d
	U/8OB04NfShuhmY8ZzaK3eiEBNPJ4HHkqy+jXtRJuGdqjTqN5nXo9/BeljBBtfYIYc58Fr
	RH35F80uAPJDzq7rgst5Fpd0OBOED50=
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 02 Nov 2026 19:45:51 +0100
Subject: [PATCH batadv] batman-adv: scrub skb state on mesh interface
 encap/decap
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-skb_scrub_packet-v1-1-36bc5df5b2f0@narfation.org>
X-B4-Tracking: v=1; b=H4sIAF7a6GoC/yWM0QrCMAwAf2Xk2ULaQVF/RWSkWaZxMEfTDWHs3
 63z8Q7uNjDJKgbXZoMsq5q+pwr+1AA/aXqI074yBAzRewzOxtQZ5yV1M/EoxWEbA0U+46VFqNm
 cZdDPsbxBokL9Cve/tyW9hMvvB/v+BaCUcuJ8AAAA
X-Change-ID: 20261102-skb_scrub_packet-0362a6c80930
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2219; i=sven@narfation.org;
 h=from:subject:message-id; bh=CQY6OifshoNwRghYw4qM0YLRu8pwIFHqZ7T6iE0XhPk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkvbjWJveE7qdYZZrjmT9wk8XvPomNN0nZ5JhYvljp45
 /QEl9+FHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJXE9l+CsRxM+SGV178qux
 wbZey/XzOo/lG/977vHyw5PT/66dstdgZDgbnn6z2vxcpfrb6axvSs/wbpAJ5+6uT2WZcPhF3qc
 OHi4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GVBNPLQSX3CZ4MD5P7RHFOKNAAURBYSI
X-Message-ID-Hash: GVBNPLQSX3CZ4MD5P7RHFOKNAAURBYSI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GVBNPLQSX3CZ4MD5P7RHFOKNAAURBYSI/>
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

The mesh interface acts like an L2 tunnel: frames from the mesh interface
are encapsulated in a batman-adv header and transmitted via the hard
interfaces, and received batman-adv frames are decapsulated and injected
into the mesh interface again.

On decap, only the conntrack state of the outer packet was cleaned up via
nf_reset_ct(). But other state of the outer packet (dst, skb extensions, nf
trace, switchdev offload marks, ipvs state, ...) was still passed on to the
inner packet. And on encap, the complete state of the inner packet was kept
for the outer batman-adv packet - even while it is queued for a long time
(e.g. for rebroadcasts).

Other tunnel implementations (vxlan, geneve, ip_tunnel, ...) use
skb_scrub_packet() for this purpose. Do the same on both sides.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/mesh-interface.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index d1263c77..497a8879 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -309,6 +309,11 @@ static netdev_tx_t batadv_interface_tx(struct sk_buff *skb,
 	if (batadv_compare_eth(ethhdr->h_dest, ectp_addr))
 		goto dropped;
 
+	/* the state of the inner packet (dst, netfilter, skb extensions, ...)
+	 * must not leak into the batman-adv packet.
+	 */
+	skb_scrub_packet(skb, false);
+
 	batadv_skb_set_priority(skb, 0);
 
 	gw_mode = READ_ONCE(bat_priv->gw.mode);
@@ -473,10 +478,10 @@ void batadv_interface_rx(struct net_device *mesh_iface,
 	skb_pull_rcsum(skb, hdr_size);
 	skb_reset_mac_header(skb);
 
-	/* clean the netfilter state now that the batman-adv header has been
-	 * removed
+	/* clean the state of the outer packet (dst, netfilter, skb extensions,
+	 * ...) now that the batman-adv header has been removed
 	 */
-	nf_reset_ct(skb);
+	skb_scrub_packet(skb, false);
 
 	if (unlikely(!pskb_may_pull(skb, ETH_HLEN)))
 		goto dropped;

---
base-commit: 04071c46a5cb4fe3078ac44b48d11268ba275438
change-id: 20261102-skb_scrub_packet-0362a6c80930

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

