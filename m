Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C7606A329
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=xDcF1+s3
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A1E5A85A81
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:21:31 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794648091;
 b=MqIs+RlQcmHc4miNAusQRdDdIfgcATJ7Zvqj8bGdK0P6evPEs5GQEvGY8JQDyLkPlmz6c
 7cWMAv/3g0HyQz85Gn9JpDRzwKvDoSntnzt9Q+gx0tY60ZljjhBgjUifDea8f4NOWTLtMCy
 dnhEelRSgUpg3eZMATcUAHPK8n+QQUM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794648091; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=I1AmFeLV+vRIYLKijEb73ZThGt5Z4q1iPlXzgCCWvak=;
 b=hMigTsGnUTYrDdzEeFYiwGHQOaa5FPC1XHeP0+vp4O8YneyEFLz9bYQekqLzuxL8oND7I
 stwG7rQwTO5Nk2sZ95sdpCwpnpvCviSL9U19npnlYt8XJiImdgWczggj8wfynA+6Ui8Bbgr
 n5hLysgKPucKenfrHM1Lk8Mn8hp7H9E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5F56F84725
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:16:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647781;
	b=jJD9uUEhCW5BlTBLezvYeC0t154uDzJkOTMh4NwZIJ/7qiLJuGfobV72uidnmC7OWjcDkY
	D8nDMoe3lKjp4UU6U203rrtrazDf33g1SfowqaG4WFacYE3nsGqtBUpt93f1vCWlTLVskK
	SOf5/U6UB5ZPr94W/jpfTNzuo8I1C74=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=I1AmFeLV+vRIYLKijEb73ZThGt5Z4q1iPlXzgCCWvak=;
	b=uqgPqRIV89kszFCeSYIXQ0/AncQcw3PhM9jibitDqgoHDBBEodBlECY+n2RPQ+zvuDSDRK
	PhQW7ki/7ijWFrzKkQaareUjQmDRMTk/JrNddc0RxZzB4x4rUg7Cm8l/bff3ZtJEzW/JM+
	cSt08FzEAZWkzb439gis93mF80m8ZlU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=xDcF1+s3;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de (unknown
 [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id D4770FA25D;
	Sat, 14 Nov 2026 10:16:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I1AmFeLV+vRIYLKijEb73ZThGt5Z4q1iPlXzgCCWvak=;
	b=xDcF1+s3P2oLaMfM2p732UW1Nfi6BCW9Q+vAyUklNfDwMoZ50w6PUU397IlAL7tipjRYFL
	+hF5uF6imTipVXOVcPT7mWmi5OEUPsKGe1tgZszhnlJQvWxgUqEfZws5aeWeWC5t8YeybW
	uz/hn7CoYHCRNxuG3Seki9CMxP8eOcPofrZ5kvufveH8KLpGQTZHi3uo/+872yP0GUfMag
	57XACPAIj+Wg0IrsKEoQnCjwJItpQOUMadq6ASqh4Q224W25usBmU5qRlvxHOhF+LxnmZT
	itV42ij7N0t4d44QQ1AL7Pcq4P4Ub8L8kVixSMmVbzX7mNuuSo4uoFcGxgKP3w==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 08/15] batman-adv: always consume skb in
 batadv_forw_packet_alloc()
Date: Sat, 14 Nov 2026 10:15:49 +0100
Message-ID: <20261114091556.3336038-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114091556.3336038-1-sw@simonwunderlich.de>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: S3E3IAK4KYRE6P5DTOKK2HEL7V366EAI
X-Message-ID-Hash: S3E3IAK4KYRE6P5DTOKK2HEL7V366EAI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/S3E3IAK4KYRE6P5DTOKK2HEL7V366EAI/>
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

On success, batadv_forw_packet_alloc() stores the skb in the new
forw_packet, and batadv_forw_packet_free() frees it later. On failure
(queue full or out of memory), the skb was left for the caller to free.
Whether the caller still owned the skb therefore depended on the return
value.

Free the skb inside batadv_forw_packet_alloc() on failure, so the skb is
always consumed, and drop the kfree_skb() calls from both callers.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c |  4 +---
 net/batman-adv/send.c       | 14 +++++++-------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 376c0f80bcee9..5faac7419e43a 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -647,10 +647,8 @@ static bool batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	queue_left = own_packet ? NULL : &bat_priv->batman_queue_left;
 	forw_packet_aggr = batadv_forw_packet_alloc(if_incoming, if_outgoing,
 						    queue_left, bat_priv, skb);
-	if (!forw_packet_aggr) {
-		kfree_skb(skb);
+	if (!forw_packet_aggr)
 		return false;
-	}
 
 	forw_packet_aggr->skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(forw_packet_aggr->skb, ETH_HLEN);
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 929b6dd34c107..6672f81798e91 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -481,6 +481,9 @@ void batadv_forw_packet_free(struct batadv_forw_packet *forw_packet,
  * (optional) if_incoming, if_outgoing and queue_left. If queue_left
  * is NULL then bat_priv is optional, too.
  *
+ * The skb is always consumed: on success, it is owned by the returned
+ * forwarding packet, on failure it is freed.
+ *
  * Return: An allocated forwarding packet on success, NULL otherwise.
  */
 struct batadv_forw_packet *
@@ -505,6 +508,7 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
 			   "%s queue is full\n", qname);
 
+		kfree_skb(skb);
 		return NULL;
 	}
 
@@ -532,6 +536,7 @@ batadv_forw_packet_alloc(struct batadv_hard_iface *if_incoming,
 	if (queue_left)
 		atomic_inc(queue_left);
 
+	kfree_skb(skb);
 	return NULL;
 }
 
@@ -753,13 +758,13 @@ static int batadv_forw_bcast_packet_to_list(struct batadv_priv *bat_priv,
 
 	newskb = skb_clone(skb, GFP_ATOMIC);
 	if (!newskb)
-		goto err;
+		return NETDEV_TX_BUSY;
 
 	forw_packet = batadv_forw_packet_alloc(if_in, if_out,
 					       &bat_priv->bcast_queue_left,
 					       bat_priv, newskb);
 	if (!forw_packet)
-		goto err_packet_free;
+		return NETDEV_TX_BUSY;
 
 	forw_packet->own = own_packet;
 
@@ -770,11 +775,6 @@ static int batadv_forw_bcast_packet_to_list(struct batadv_priv *bat_priv,
 
 	batadv_forw_packet_bcast_queue(bat_priv, forw_packet, send_time);
 	return NETDEV_TX_OK;
-
-err_packet_free:
-	kfree_skb(newskb);
-err:
-	return NETDEV_TX_BUSY;
 }
 
 /**
-- 
2.47.3

