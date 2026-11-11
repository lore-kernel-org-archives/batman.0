Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86436606A327
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=MZWbUqqY
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0BCFC85B45
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:35:39 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794393339;
 b=N9qMUbdhAnfuBEAKNCL0vJGzUZewQMh3BCfL1rhGWyXMNH0T6bpWENYAlL0PkvBMXG3yd
 iDDPHGfTxetCt2BJXa62ZtOEMOEISEEt/YsCKe9ikJz42Vv53OrFYpFwuguoYe14mT8ZXFj
 M+9F349f537bk1+LUVdhmDIre9mCvcw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794393339; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZXY9RMei14Qa6qZcMDBzjNkR+zAn7SgX5Be6ZFMOjm8=;
 b=jjPXBwJSrAoURxD/Pm23QtfCX+5ytVchkp8+xeI/IbsKWAmRq0LriBNRQ2d28B3NHwODU
 a+wY5dopYACUI8eLa31u9Lm0UaCSMXCP/0w70hB9nHdBj/O6rTTM7HLHp8aCDhEeegVLk9f
 z5TOAx1a15gEtYUV9v/dusZyGIG5WaY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 87B828456E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392874;
	b=MEzke+ACZkOZAhUfCjyKujUr5hPItvnSqnPFDQVmMHcxtJmFyILHyoj1tG41/pT711kxb9
	0YkQ3lFGEfVYj2RoicjAAgS+nr0wBc+dssv5auS+fs6YngW5enXhUWbGAGz5EnnUMvLRoc
	ikSFyubEm40pTp+ygU/QY5QKE7ISDX8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZXY9RMei14Qa6qZcMDBzjNkR+zAn7SgX5Be6ZFMOjm8=;
	b=k0rCudnLiB4+teGw924pw9trFjGw4IoUsLQF9QeBBce0XGCsYqux+9mA6qO9anr4TArhpa
	Gpz5+c8SwVGkDw/BCVWOFKIBEAigjDfI1Zt0bosEBHbSl0GE8Nv9uL3KmhoQkxUn+JyOuC
	GXdcy+airb9+MVLVShMdlwFyB8+2Zys=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=MZWbUqqY;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59740dEd843be7E4A980E9C65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 4612BFA2EF;
	Wed, 11 Nov 2026 11:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXY9RMei14Qa6qZcMDBzjNkR+zAn7SgX5Be6ZFMOjm8=;
	b=MZWbUqqYR13QiKezBgP2r+m2jHP6XRE97evVzFSrx5IZlIkH10fDt01cZ6UcKUnQkg5Gv1
	ExcFwKRlpPsBdgGIfgreWdMWPA9Zj+0p1aUrL6p18YFrvZMIlWtJOmL1R56LNZTFux3vXX
	4xXog+NlCrLa68hbaAliL0mfpTMSicqLCOR12Vol8XY9DYI3b6vSEr5lKJzrAYvX0NZCDm
	dPmha3Cr7GcczHd5666ClwF6G6EMDqKIZzsAbO2vTXmdqxkUDcSbOEWd+rO+umZTQFUSkQ
	KPzBS9L4Kl5BZePIDAU4tlohUw3ECTC6TqUYFEi0/G3cA1F+lXSUmw20a0lmcg==
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
Subject: [PATCH net-next 12/15] batman-adv: use matching return types for bool
 and void functions
Date: Wed, 11 Nov 2026 11:27:26 +0100
Message-ID: <20261111102729.2096241-13-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VXSHACZCMIAU4UC2BXNWDHFVV2KGAL7C
X-Message-ID-Hash: VXSHACZCMIAU4UC2BXNWDHFVV2KGAL7C
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VXSHACZCMIAU4UC2BXNWDHFVV2KGAL7C/>
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
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.h |  3 +--
 net/batman-adv/multicast.h             |  3 +--
 net/batman-adv/multicast_forw.c        | 18 +++++++++---------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.h b/net/batman-adv/distributed-arp-table.h
index e7b75e82eb1d8..807178fd28c57 100644
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
index d97ee51d26f2e..d46f3a25ba5f2 100644
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
index 9ffed1f237b6b..8700f92b9bb0f 100644
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

