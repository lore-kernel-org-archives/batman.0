Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C88606A31A
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=iwGdQuVg
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 973EA80487
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 23:16:54 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793485014;
 b=uTrYOJTCBml1/GQt6I5rz2Pjo0JARzNwN86+jgREPHQjLiQr0n7plZh99DN7blUC37fyY
 7eIXJbxdC5bbRiI1cJRaQubpmr3trCy03BIpmPI2KNyjk1AXkxZYdA+HVMFOmODk7qwssjk
 AX4ImkZTJskX5YLeE5Vpf1BzxfVsdJ0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793485014; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IincwVDrgIQEsmkMTuC9VgVmHlNDsSSmhqnGnCFl3kU=;
 b=NDKZltE7YkIN50+kZQMK3g+iSjgd2WlFXjpBYWkyFF7v3Xyx7dFQzqR4uEArQrwkrBH4e
 ojQodkwZynYRKPwzB7jzgDudVQ2Y0ufa30CzrDv7iVkusugITo3jfhIoYV8aCZY2c1uTZNf
 ucqKxmWTf9Dxna0QR+BEOV9kCqNSKZY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3D5E281CDC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 23:14:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793484907;
	b=tQf4jeBd492M9qQfmcFbBNs8mSW+nph/zExqCIcuSOAVmmSzaErUywKkueB5JaxWH0o0ym
	1tBmcpJkXVZNU1LTNdQl9LRzLYa6bcb/azCCVEyBouoeyjpuqgruJJpBSTwLW76/WbKOfR
	2XV2FCf/GW8mJdU6xqAl10xJ7Jcb1/Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793484907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IincwVDrgIQEsmkMTuC9VgVmHlNDsSSmhqnGnCFl3kU=;
	b=XCauwYfhr2BB40sx2ICWc6RCFXLzHChGCL3qbDLVOZDI+OVwltZkzXQQoYlJI8A+WGvYPI
	ggg205igek4yfWnOOry0itkxU0yOSg8dOcGhnzYES4Mr0OOyoCA9yZqmzS8PB6hyMMhJRp
	eMbkf0II2gYrz8Qx7kc+GxZjJyHsD60=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iwGdQuVg;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 987EA21015;
	Sat, 31 Oct 2026 22:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793484896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IincwVDrgIQEsmkMTuC9VgVmHlNDsSSmhqnGnCFl3kU=;
	b=iwGdQuVgihUhTUHWJO1x2kmH78d/YGC5VLhiExkXZ8NoWuR1DgSkT8WGPNRtTA58x1Vkhf
	rfr7sdMHE4AB1LMxs+iH1RkzQpbgSfsm1CcfkP7YnD+TlmyuMxnSqok6atygnlJ712oHaO
	7pXKvQMTt88VuDRH/rbgl8T5aaAq8mc=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2026 23:14:48 +0100
Subject: [PATCH batadv v2 3/4] batman-adv: use bool for boolean flags
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-simple-type-cleanup-v2-3-2c8f42edbc90@narfation.org>
References: <20261031-simple-type-cleanup-v2-0-2c8f42edbc90@narfation.org>
In-Reply-To: <20261031-simple-type-cleanup-v2-0-2c8f42edbc90@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3520; i=sven@narfation.org;
 h=from:subject:message-id; bh=yg1BWrBo31nYJHr85LhoUduX+3ywOF/LHoRJ7bOBcc8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnPMsK473dt+rPn98Fb704d+nvX1jS//+oU6QeT8pUmN
 KpPnxl3rqOUhUGMi0FWTJFlz5X885vZ38p/nvbxKMwcViaQIQxcnAIwkaJTDP8LOS3uGu1a43qg
 b+0+KZNPlTM6ijkPGbYmlazY//PQ7+56RoZ1uge23lTTn/bnyOYQGxlrlqScrHOlx+ctP68t0vi
 E+zwbAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YWU7HLOSRROBPXKAYSNW64JRAT6KSXYR
X-Message-ID-Hash: YWU7HLOSRROBPXKAYSNW64JRAT6KSXYR
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YWU7HLOSRROBPXKAYSNW64JRAT6KSXYR/>
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

A few flags are stored in int or u8 although they only ever hold true or
false:

* the own_packet parameter of the B.A.T.M.A.N. IV OGM queueing functions
* batadv_forw_packet::own, whose kerneldoc already calls it a bool
* is_old_ttvn in batadv_check_unicast_ttvn(), which stores the result of
  batadv_seq_before()

Use bool for them, and pass true/false instead of 1/0.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 10 +++++-----
 net/batman-adv/routing.c    |  2 +-
 net/batman-adv/types.h      |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 3c77659d..0fba3310 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -623,7 +623,7 @@ static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 					bool direct_link,
 					struct batadv_hard_iface *if_incoming,
 					struct batadv_hard_iface *if_outgoing,
-					int own_packet)
+					bool own_packet)
 {
 	struct batadv_priv *bat_priv = netdev_priv(if_incoming->mesh_iface);
 	struct batadv_forw_packet *forw_packet_aggr;
@@ -716,7 +716,7 @@ static bool batadv_iv_ogm_queue_add(struct batadv_priv *bat_priv,
 				    int packet_len,
 				    struct batadv_hard_iface *if_incoming,
 				    struct batadv_hard_iface *if_outgoing,
-				    int own_packet, unsigned long send_time)
+				    bool own_packet, unsigned long send_time)
 {
 	/* _aggr -> pointer to the packet we want to aggregate with
 	 * _pos -> pointer to the position in the queue
@@ -843,7 +843,7 @@ static void batadv_iv_ogm_forward(struct batadv_orig_node *orig_node,
 
 	batadv_iv_ogm_queue_add(bat_priv, (unsigned char *)batadv_ogm_packet,
 				BATADV_OGM_HLEN + tvlv_len,
-				if_incoming, if_outgoing, 0,
+				if_incoming, if_outgoing, false,
 				batadv_iv_ogm_fwd_send_time());
 }
 
@@ -955,7 +955,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		 * respective interfaces.
 		 */
 		scheduled = batadv_iv_ogm_queue_add(bat_priv, ogm_buff->buf, ogm_buff->len,
-						    hard_iface, hard_iface, 1, send_time);
+						    hard_iface, hard_iface, true, send_time);
 		if (!scheduled)
 			reschedule = true;
 
@@ -972,7 +972,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 
 		scheduled = batadv_iv_ogm_queue_add(bat_priv, ogm_buff->buf,
 						    ogm_buff->len, hard_iface,
-						    tmp_hard_iface, 1, send_time);
+						    tmp_hard_iface, true, send_time);
 		batadv_hardif_put(tmp_hard_iface);
 
 		if (!scheduled && tmp_hard_iface == hard_iface)
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 79fad88c..e2951bf0 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -891,7 +891,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
 	struct batadv_orig_node *orig_node;
 	struct ethhdr *ethhdr;
 	unsigned short vid;
-	int is_old_ttvn;
+	bool is_old_ttvn;
 	u8 curr_ttvn;
 	u8 old_ttvn;
 
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index b3e6dbb3..73250145 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2036,7 +2036,7 @@ struct batadv_forw_packet {
 	 * @own: bool for locally generated packets (local OGMs are re-scheduled
 	 * after sending)
 	 */
-	u8 own;
+	bool own:1;
 
 	/** @skb: bcast packet's skb buffer */
 	struct sk_buff *skb;

-- 
2.47.3

