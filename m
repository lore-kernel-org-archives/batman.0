Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42537CC6B12
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 18:09:54 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8030E841A9
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 20:09:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791914992;
 b=KTgHzHs0WzplE3cSBWc0WKZY1WIsqoOvNhy4WEt4iQcp+m6gxWOyQaSq/Zm051HYb8hOa
 bQyX1TYsFx9ouqyLHye3eP9cm3STWji2qyfWfl2CUvwMpoeWiWOv1Nl8gh5NVure1C0MYtP
 zPHKjH+AKVl+XgJPUdeOGAdSKs0pf88=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791914992; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CR7eF4j9oQcvKTOeXaGiZPdwusvU0biBEFNw4KvvhPE=;
 b=phfTZYKEtLu0i1mRicftESYWoGi8k9zvks4L3+YruAjQoG4GO4r8vFH+gfIRvR5ByFg5N
 QOLGj6qe1K2oYDmh/QkDEwGJIvpNafyH4NF+QrDqQ+mlXkJh72dEsdxLPhJGrcjx1UdaALu
 hys95yqfRFxg0slFgLGQDSttwdVmnEc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id BD34784115
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 20:07:56 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791914886;
	b=3kw898jLeUTW/VRJYSm1i8a2xERV4Yaim0o4sBtOUk2tUK171XHcSB44scf4Dhz6dUz1dF
	XiDrAmwJWCm/kJ2ARoKtxSLpWcACRbp5jIhaj8aniLxr0Rp/2c04NxKqr/OXvlFac6g1Cr
	0uWSfkfoKQ/squ5FOJzx2IEt18c5PU8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791914886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CR7eF4j9oQcvKTOeXaGiZPdwusvU0biBEFNw4KvvhPE=;
	b=s6HOqpbAwCjMUmCyCo/reVf6vQsrkjmfr9RQtYLLxXmECZGdlmApt7fECuHXaCfn2PatDP
	fROLqcXmlaokU+y8dz5Mhh9GbN6IlcMY7WmRFlMVAwCQQyPlpqGi3/KCbnegGyyOPTQgvI
	jJONJtYlyoUdGYCE3CH40UJcnsryu0k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=b0dF242r;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 252E720EF2;
	Tue, 13 Oct 2026 18:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791914876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CR7eF4j9oQcvKTOeXaGiZPdwusvU0biBEFNw4KvvhPE=;
	b=b0dF242rLVHN+o4cFso3Re/euSiNotC8sd859TX+jkikKkjwQJrNT4KAESg5mIV54kGu6v
	7haPPsK0peHvkDYlkuxpvtfjXHLNzz1UtcUMyGDfAwmi1GO+k5A+c7czmqeeFn8kMC+N/+
	1NYR/ZEOvCV7j5qUiGPhFIKlxmmOKu4=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Oct 2026 20:07:49 +0200
Subject: [PATCH batadv 3/4] batman-adv: use bool for boolean flags
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-simple-type-cleanup-v1-3-8a31d7e82eb4@narfation.org>
References: <20261013-simple-type-cleanup-v1-0-8a31d7e82eb4@narfation.org>
In-Reply-To: <20261013-simple-type-cleanup-v1-0-8a31d7e82eb4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3520; i=sven@narfation.org;
 h=from:subject:message-id; bh=lcP0CBijqCggyQLXLXY0pCbWOwT2NrNv182xqVtr0yM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnikuM0+7PWc1eGTnltavN6+nfPE6Kaq/v4JeNO+p0/
 YymzOLDHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJZHUwMlzcpq1yVWeB3I1r
 fG0/D2dGagjk3peYfTvF5OmWlxt5tOIZGe4+vJxhKvT2naibYdiP/S+44xb+sNy2Zadbq8Zzs6d
 tAjwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: YSZMVW7OHH3QVHANV4DU2G3VKO6QM2AD
X-Message-ID-Hash: YSZMVW7OHH3QVHANV4DU2G3VKO6QM2AD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YSZMVW7OHH3QVHANV4DU2G3VKO6QM2AD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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
index fea10d57..769cb1d6 100644
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
index c19caa84..941fdd13 100644
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

