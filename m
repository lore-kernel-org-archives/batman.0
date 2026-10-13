Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04184CC6B12
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 18:08:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9961A84392
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 20:08:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791914924;
 b=v5OkcA/nVV1KUVAt4U+ERqIf9QDLcS6FAt5iCVsHxip9pfEVJjXwD5FtJdf6HNHOqwx6o
 L+hCtIkrHJqqQQkNBYnpgtHQlNn/fDlgB6gFKT11KqofYAPIY4bUc30RP1vC8kiTsCo+9CV
 Xm6ReDEYBW8IYqTmIDHzDOGheijYJ5k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791914924; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PPrxqyq2RKnGcw/2fGBN9rO8VkBQkfJmg8sHpuW83iA=;
 b=iEHbVsJzA/bAXws5ovYNBuGCYiaVZ7raNDtAOKuM8CslhHDvKS2vUxNNpRjXEy0EobYnW
 qwO3+YRitI+GXJaYK5NtXXYqYKZ0p5s67ARF7320fG5BN6dOQ8R3oh1gI23IijCc+3nJF30
 X8Tsy4yJnP2I4aDjThbYUKALI+xZBas=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id CEC1181BA5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 20:07:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791914882;
	b=i9pWbSmZPQekUXUxFGgGHiiokpSj07dnmJXPolA2P6EUDcLJW682zfv688CNUyYyTmcXQu
	LxWWiq/MugGmTz0g0mxFczHYHnMk6jPG0NoaDh4xPJlMRtEkO7zvRHD/kHwn7+BB8MLAtT
	5mhdMcd/tt2ngZeCtFHErsVC+2z/R0Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791914882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PPrxqyq2RKnGcw/2fGBN9rO8VkBQkfJmg8sHpuW83iA=;
	b=sSi0FaZFKK98scT4/5lxdyMboeT3PG2NkUNpKM4SpYf9pVfV+ooedQZBoRpQCa4a/3hWKs
	akl4pREOluOwAXnJ2cUVFiXMjSfZJ002KUeyT81lo3/SqwWYkRxDETehxWF1EZ7wKJXYuQ
	2KEpONIDEDCFWPN0OxpaUjyAQ5c4C8Q=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ltMWBrCj;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 73A3220560;
	Tue, 13 Oct 2026 18:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791914872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PPrxqyq2RKnGcw/2fGBN9rO8VkBQkfJmg8sHpuW83iA=;
	b=ltMWBrCjmECVbSaX8LffJsOLSrcRv4fIVipnjgQE5y2opb7mTsF1jch2+RPaAJQItBQVv+
	urt8jPFJcvbFVsrbNlr0VM+3B+zuGIizfhYRMkR/hlOT4KBG6Z1rfBCnZatLah0TxiNJyN
	5YZ0FxKEQoCkSQRdCLgfd4AnfNhumcI=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Oct 2026 20:07:47 +0200
Subject: [PATCH batadv 1/4] batman-adv: use matching return types for bool
 and void functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-simple-type-cleanup-v1-1-8a31d7e82eb4@narfation.org>
References: <20261013-simple-type-cleanup-v1-0-8a31d7e82eb4@narfation.org>
In-Reply-To: <20261013-simple-type-cleanup-v1-0-8a31d7e82eb4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3281; i=sven@narfation.org;
 h=from:subject:message-id; bh=/LzWqQQys9wLP3s69nMyS9sBuIJYV8odCaRy8i9fwdk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnniosZjc9ZSm5f73X9fyP3P5dtJ1ccfi41qcdP38dIq
 7xJ+51gRykLgxgXg6yYIsueK/nnN7O/lf887eNRmDmsTCBDGLg4BWAihtWMDNcOzRHd0NT37LGX
 POuHJelxl9S9536yUDHX1p0s15E51YyR4bwVV7Hv1Slify7ILGa6nFHqITblG6+ccbvznOAF2a8
 s2QE=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NHQV2KD4SHD5V2HPSJEOY775AWZCDQ6D
X-Message-ID-Hash: NHQV2KD4SHD5V2HPSJEOY775AWZCDQ6D
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NHQV2KD4SHD5V2HPSJEOY775AWZCDQ6D/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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
index ac97cd8b..e77a111f 100644
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

