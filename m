Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0810E606A31A
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 22:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=O52/hycA
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9EDEF83BE1
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 23:15:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793484947;
 b=BrqLDGz3kun0IYuVILd8krpGHyRx/Y6GLwBShfUj05++Uk/x/urWqkGamT9PISNpO6l3a
 7XiMSM6zLW9zfK9ZQJeqYZlek1GDzZOkpBMcXfJM+45FtjYPf3kC/Ru5bc61HOGgGrwXwGj
 Zl4DuxEmrY+gL+uOcDwVYuJI1w8Zc10=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793484947; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=S/izb6dCdGra8mXEg0cELRG4ezZ7nRq521hlsxQ41p4=;
 b=JjYv95NzwPoTC5YTsAGWsge1SfWWUUrSIZxnVaUJQWkJfK8VoxTeWqsl9BxNrw2aTrWuN
 TOrYm6wBcBLWyFt388X6P3lZp15lwwhfGI/CuhXEfoMCqAVUFLD81YM378rIFgG8/cVuAPu
 5BJZTTfyF2DkgQvaeFWdpLY1JMN2IzE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 1BDFF806E1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 23:14:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793484903;
	b=WTAhA7D6tQ6Hn9XEU94vHR7NjIMCKYGewnakPiQhOz3bOeul0maqWBcJ8mWY4+LJEBGWrv
	6xToJoiswggRkMr44IsZWpTXvXKmVRKBO4x4PsURqDtwGX6IjI+mL2sHz7tgMEaSUJMDFx
	Wdfxo6HTyG4unpBPSSBFLz7Med0lvEM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793484903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=S/izb6dCdGra8mXEg0cELRG4ezZ7nRq521hlsxQ41p4=;
	b=g7YeT0OeQQTPRnPISSI/u5IYcarnKyEDUmhd8CefoRsV5mig19cOGyEsEP6MeRHrfwsKlY
	TjHY6vUNfG3wecMWLcOOyqf8iXKFfLtco2E0oAXnDXijCPiuChJ4i4F6zExCx3XMtun2Ay
	N0bzrdh+oB+L4Q0NeW2bUw2S0zsrUN0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="O52/hycA";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B5D9F20FE8;
	Sat, 31 Oct 2026 22:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793484892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S/izb6dCdGra8mXEg0cELRG4ezZ7nRq521hlsxQ41p4=;
	b=O52/hycAMDXUP1EEkX7URFSuV4J/ivfsw2lq+RLr/0NbwUMMu9IixyW4mVXH0yjzxjVS6I
	Ps/3m16APofoWgKns/U0XQ98W1hpDGamG/Z7rRHQLUJcZt3omZwYaU3W61XUlHiOSoiD1y
	6M2VETTMEeoJKjrSmHAap7gm21qHhsY=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2026 23:14:46 +0100
Subject: [PATCH batadv v2 1/4] batman-adv: use matching return types for
 bool and void functions
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-simple-type-cleanup-v2-1-2c8f42edbc90@narfation.org>
References: <20261031-simple-type-cleanup-v2-0-2c8f42edbc90@narfation.org>
In-Reply-To: <20261031-simple-type-cleanup-v2-0-2c8f42edbc90@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3281; i=sven@narfation.org;
 h=from:subject:message-id; bh=z3+oxvovHJUxEcu/uvaN0kVae4IhkSAiiW+03T8+Ueg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnPMsISmlasv/FwXtG8x29X8XD8aVbwUH5coZV3fT7/G
 6Hi4n/rOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATWRbB8E/pk3Ywk2pAq1Dm
 zuLpLrONbkfG/8jSf7v97kP2gPxHR38w/E9tL1/IoFJjycu8RInr5awLV+pXeR4LXpD+Uv3VnG8
 bfzACAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 6IOPCFGLUQSS73ZGYZMJCD7ZT3ICU6VF
X-Message-ID-Hash: 6IOPCFGLUQSS73ZGYZMJCD7ZT3ICU6VF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6IOPCFGLUQSS73ZGYZMJCD7ZT3ICU6VF/>
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

Some functions declare a different return type than the values they
actually return:

* batadv_mcast_forw_push_dests_list() is documented as returning
  true/false and only returns true/false, but was declared to return int
* the !CONFIG_BATMAN_ADV_DAT stub of batadv_dat_snoop_outgoing_arp_reply()
  returned bool, while the real function returns void
* the !CONFIG_BATMAN_ADV_MCAST stub of batadv_mcast_init() returned int,
  while the real function returns void

Make the declarations match.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/distributed-arp-table.h |  3 +--
 net/batman-adv/multicast.h             |  3 +--
 net/batman-adv/multicast_forw.c        | 18 +++++++++---------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index e7b75e82..807178fd 100644
--- a/net/batman-adv/distributed-arp-table.h
+++ b/net/batman-adv/distributed-arp-table.h
@@ -117,11 +117,10 @@ batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	return false;
 }
 
-static inline bool
+static inline void
 batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 				    struct sk_buff *skb)
 {
-	return false;
 }
 
 static inline bool
diff --git a/net/batman-adv/multicast.h b/net/batman-adv/multicast.h
index d97ee51d..d46f3a25 100644
--- a/net/batman-adv/multicast.h
+++ b/net/batman-adv/multicast.h
@@ -88,9 +88,8 @@ batadv_mcast_forw_send(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	return NET_XMIT_DROP;
 }
 
-static inline int batadv_mcast_init(struct batadv_priv *bat_priv)
+static inline void batadv_mcast_init(struct batadv_priv *bat_priv)
 {
-	return 0;
 }
 
 static inline int
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 9ffed1f2..8700f92b 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -187,13 +187,13 @@ static bool batadv_mcast_forw_push_dest(struct batadv_priv *bat_priv,
  *
  * Return: true on success, false otherwise.
  */
-static int batadv_mcast_forw_push_dests_list(struct batadv_priv *bat_priv,
-					     struct sk_buff *skb,
-					     unsigned short vid,
-					     struct hlist_head *head,
-					     size_t entry_offset,
-					     unsigned short *num_dests,
-					     unsigned short *tvlv_len)
+static bool batadv_mcast_forw_push_dests_list(struct batadv_priv *bat_priv,
+					      struct sk_buff *skb,
+					      unsigned short vid,
+					      struct hlist_head *head,
+					      size_t entry_offset,
+					      unsigned short *num_dests,
+					      unsigned short *tvlv_len)
 {
 	struct batadv_orig_node *orig_node;
 	struct hlist_node *node;
@@ -278,7 +278,7 @@ static bool batadv_mcast_forw_push_want_all(struct batadv_priv *bat_priv,
 {
 	struct hlist_head *head = NULL;
 	size_t offset;
-	int ret;
+	bool ret;
 
 	switch (eth_hdr(skb)->h_proto) {
 	case htons(ETH_P_IP):
@@ -324,7 +324,7 @@ static bool batadv_mcast_forw_push_want_rtr(struct batadv_priv *bat_priv,
 {
 	struct hlist_head *head = NULL;
 	size_t offset;
-	int ret;
+	bool ret;
 
 	switch (eth_hdr(skb)->h_proto) {
 	case htons(ETH_P_IP):

-- 
2.47.3

