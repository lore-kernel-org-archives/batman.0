Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831D606A31A
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=P9VCeTEr
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3F45B8167E
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 21:33:51 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793478831;
 b=S5NW1p49yvs93I5pWJsQBKuk6WVE1G3OEI1AiIiVf322qRAjs8193UDRXKZPY0FOu0qvU
 MmqIbBzoWuMnxN81pnF7WSslKDnDnqN+JPAEbFleuAyNexEO9p1jJS33D1blmaOicRr4SMs
 69DCQ6EHTrefqAReAIrZONSeEi+61nk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793478831; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XlMQkjI+9SqkyGAJ73gYSdHQEUdRMNdfCXqo6Tx2gkk=;
 b=axQTgVDVsqa0DYj1FZcFn3y9veF3KXVz3UZFaV2viYn243scet/MIK0JYqZOWsykBDuGz
 YiSU5EwPtsIqokOPz8q0D8mxSVS9lIhrShkaaFC8Hh7IaXRuuI28F2mD2zkEuHtOLTE1P8v
 xK4I59JOrJcxvY0tQW3WlQj+8N2C+1A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 25D6481431
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 21:30:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793478642;
	b=Am4sqj22Wh46Xwy2F4F4PMTGH2AmB9N/n4zq3gb4CSWuwi8gWHs9qBB98SDOKlVCOy15g4
	c8ZdPcFAjapqmX8C9wLY4tXJoSNZulrxa6ni2X1/3XbWxYtjkX5bgyqhOTNbtRw/GSBDdW
	1903YKQZiplIgmXaT2S/YkSNPnagY10=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793478642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XlMQkjI+9SqkyGAJ73gYSdHQEUdRMNdfCXqo6Tx2gkk=;
	b=wPxvvm3EtVa28mAgmkQjCN45KWpg6oXEHLmUOnpgBLrvx2tAvYfbS2+CGiKQdoUpBUBdez
	PSVmDeS91xuqQ70rUHtXffiGQ1N+UZKpsGMe23fDtc80ZqvbTbMfoo9gkLlzE4HBEVR6rQ
	tumdVf5rNymbHkcRwMznN7T9WOZUpI0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=P9VCeTEr;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A837E20F6B;
	Sat, 31 Oct 2026 20:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793478641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlMQkjI+9SqkyGAJ73gYSdHQEUdRMNdfCXqo6Tx2gkk=;
	b=P9VCeTErdZj3oZuINgRYkZreIhkH0MyGlcKWOPE7S9wSaF0S5nf6VLRyoqqUEbX8Bpx9zJ
	oBgUlYtDuYvchejQuyOYSX0IDVLld01tOijsES6MusJYTYbzX9O7UtTDq09siyz92gPCbq
	r2pKi1p8CLeyHTlXKhLMQDsl25E+3PM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2026 21:29:47 +0100
Subject: [PATCH batadv v4 7/7] batman-adv: annotate hardif_neigh_node
 last_seen with READ/WRITE_ONCE
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-dat-last_update-once-v4-7-3f7994b1f5fe@narfation.org>
References: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
In-Reply-To: <20261031-dat-last_update-once-v4-0-3f7994b1f5fe@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3626; i=sven@narfation.org;
 h=from:subject:message-id; bh=avFj+/aAwZG9xWv7cPkFE7hU4S//PeuxlBBzkf21+S4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnP/HedumfW9KizT/Ayp+zubo47t/PnSmW51Mq/jZ6T3
 7Rq2ekXHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ+HQyMmzy8tkrsnn+Po3E
 6oiaeWfEMx/b+ob/rD11ePtsy/mpBjcYGbap3pP7nJfcMT/TZc4V7ydPEiPCpBfuDjDceXuO/AF
 /Tz4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: GFQF4ZNPS6UYLXPCYTSQR4C6K6BLNCY2
X-Message-ID-Hash: GFQF4ZNPS6UYLXPCYTSQR4C6K6BLNCY2
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GFQF4ZNPS6UYLXPCYTSQR4C6K6BLNCY2/>
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

The last_seen field for batadv_hardif_neigh_node tracks the jiffies value
of the most recent activity and is used to detect timeouts. These accesses
are not consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be
used to prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jiffies vs
last_seen, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 6 ++++--
 net/batman-adv/bat_v.c      | 4 +++-
 net/batman-adv/bat_v_elp.c  | 2 +-
 net/batman-adv/originator.c | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index d4b6c09d..4e15af1e 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1569,7 +1569,7 @@ batadv_iv_ogm_process_per_outif(const struct sk_buff *skb, int ogm_offset,
 		hardif_neigh = batadv_hardif_neigh_get(if_incoming,
 						       ethhdr->h_source);
 		if (hardif_neigh)
-			hardif_neigh->last_seen = jiffies;
+			WRITE_ONCE(hardif_neigh->last_seen, jiffies);
 	}
 
 	router = batadv_orig_router_get(orig_node, if_outgoing);
@@ -2287,9 +2287,11 @@ batadv_iv_ogm_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			       struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	void *hdr;
 
-	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
+	last_seen = READ_ONCE(hardif_neigh->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 
 	hdr = genlmsg_put(msg, portid, seq, &batadv_netlink_family,
 			  NLM_F_MULTI, BATADV_CMD_GET_NEIGHBORS);
diff --git a/net/batman-adv/bat_v.c b/net/batman-adv/bat_v.c
index 2679090c..bd2bf2b5 100644
--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -161,10 +161,12 @@ batadv_v_neigh_dump_neigh(struct sk_buff *msg, u32 portid, u32 seq,
 			  struct batadv_hardif_neigh_node *hardif_neigh)
 {
 	unsigned int last_seen_msecs;
+	unsigned long last_seen;
 	u32 throughput;
 	void *hdr;
 
-	last_seen_msecs = jiffies_to_msecs(jiffies - hardif_neigh->last_seen);
+	last_seen = READ_ONCE(hardif_neigh->last_seen);
+	last_seen_msecs = jiffies_delta_to_msecs(jiffies - last_seen);
 	throughput = ewma_throughput_read(&hardif_neigh->bat_v.throughput);
 	throughput = throughput * 100;
 
diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index cf84aed0..144bb30d 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -534,7 +534,7 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
 
 	last_seen = jiffies;
 	WRITE_ONCE(neigh->last_seen, last_seen);
-	hardif_neigh->last_seen = last_seen;
+	WRITE_ONCE(hardif_neigh->last_seen, last_seen);
 	hardif_neigh->bat_v.elp_latest_seqno = ntohl(elp_packet->seqno);
 	hardif_neigh->bat_v.elp_interval = ntohl(elp_packet->elp_interval);
 
diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 352a8805..0f47ac3e 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -587,7 +587,7 @@ batadv_hardif_neigh_create(struct batadv_hard_iface *hard_iface,
 	ether_addr_copy(hardif_neigh->addr, neigh_addr);
 	ether_addr_copy(hardif_neigh->orig, orig_node->orig);
 	hardif_neigh->if_incoming = hard_iface;
-	hardif_neigh->last_seen = jiffies;
+	WRITE_ONCE(hardif_neigh->last_seen, jiffies);
 
 	kref_init(&hardif_neigh->refcount);
 

-- 
2.47.3

