Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A69606A31A
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=OFGariA9
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EFA4C8084B
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 23:17:29 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793485049;
 b=eCcB0zFlK/x+ljId4b7OqQQQ49z247vitEC+N9T2ZUGKLOmW65fn1kPigsxZD7XY/LqR0
 t8G+nu16K663A+fe2nuxeGOpInVHOa4gh7m3+gUw5EH/In7uyTZV51aboezixPlJwYsqv8j
 4URYwkAeMUUZ42kFFjjoU//+g1vJzuU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793485049; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=KBbXs44h18eJYbObuXcfTmbwLeVgAjmwr7mXT/atFpA=;
 b=TzjEL61sK+IiPBP4poXh0G6Jh6PgRSiOcrE9Q9o8JL/SFPnrU3owLFAvldIoOMY1Mg1SY
 5Hv7wYKCwdCDPzwIU37b5Spu1PVkMEJ0A6+rKuvg3rE7BVuaJHjotqYWIhKfS1VdQQh0EpK
 uC/pJSlZLrBxKgRFRrZ+A5Bow/DmHJM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id A8DC181CDC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 23:15:00 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793484910;
	b=oO5vW1sJrpfgSLz5zTsIRIm8HUxaKgRW27l/vM7HxVIh+uNjZWCD73d/Gyo5bLLLQwXk6a
	CvzuZcbxwmzu+LZ9TzcK0CXEOdpiyaNlKTiQeh/4ZVWq3Hrcjwu5qhJUJPw3V47dFKorBe
	qdDaWDj/5GEtnfW/aNCbZQWYWm7x42Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793484910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=KBbXs44h18eJYbObuXcfTmbwLeVgAjmwr7mXT/atFpA=;
	b=lciNi8/kZCOHF67xnY/5ZxGzWy8zFQyWDGKd2iOpqGza1VC47Qcoy7CxC1rrTQ2mf1WvIj
	q6kH+3lfxcwwvdDMYiguMl8akwzVNsm1tPa2VOTfgSqtZltcyaOXyLWnwgq/VegNAFXVk4
	iqs+eGLwvrLeS97zkxvm+5pTztw14jo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OFGariA9;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 405D8210BE;
	Sat, 31 Oct 2026 22:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793484900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBbXs44h18eJYbObuXcfTmbwLeVgAjmwr7mXT/atFpA=;
	b=OFGariA9PBXr2CkJonRq1zjSkBsC1ovjDq7M6qv31mBadfcy/hlaofoGdCK6O+S4u1YpxH
	lSzBfBntSNrwQXwlwvX3iokk4qbwD18YEuplqFVpUFldjAi70oyFftXUgtOc6ZOBCN4R7f
	p6hgjZCqJsLBC0YpK/9ZodA5zBwkII4=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2026 23:14:49 +0100
Subject: [PATCH batadv v2 4/4] batman-adv: mcast: document the value stored
 in is_routable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-simple-type-cleanup-v2-4-2c8f42edbc90@narfation.org>
References: <20261031-simple-type-cleanup-v2-0-2c8f42edbc90@narfation.org>
In-Reply-To: <20261031-simple-type-cleanup-v2-0-2c8f42edbc90@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5889; i=sven@narfation.org;
 h=from:subject:message-id; bh=e5QKXNXRaPMKz6vf0drVWddUBKROZNk74jQoYr+PJtg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnPMsL59781ORJ42S24asX91u1uH/adkmMLSolN3nhCi
 CVs+k29jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEAmQYGbZ8qzZ5JTpXw8gx
 ucc3/HaITbGoeqiJad+KxA9nf89T7WJk2GtjZHxo15XpB182OzUXLWLVYEkvDo86qez2um5RwL4
 pzAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: J4ODY2JGVX5ODBTC4GXIPECAEQDIAMO5
X-Message-ID-Hash: J4ODY2JGVX5ODBTC4GXIPECAEQDIAMO5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/J4ODY2JGVX5ODBTC4GXIPECAEQDIAMO5/>
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

The kerneldoc of is_routable says it indicates whether the destination is
routable, which reads like a boolean. But it actually holds the
protocol of the routable destination (ETH_P_IP or ETH_P_IPV6) or 0.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/multicast.c      | 16 ++++++++++------
 net/batman-adv/multicast_forw.c |  9 ++++++---
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 0446324c..1e086a63 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -984,7 +984,7 @@ static bool batadv_mcast_is_report_ipv4(struct sk_buff *skb)
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the IPv4 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
- * @is_routable: stores whether the destination is routable
+ * @is_routable: stores ETH_P_IP when destination is routable
  *
  * Checks whether the given IPv4 packet has the potential to be forwarded with a
  * mode more optimal than classic flooding.
@@ -1052,7 +1052,7 @@ static bool batadv_mcast_is_report_ipv6(struct sk_buff *skb)
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the IPv6 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
- * @is_routable: stores whether the destination is routable
+ * @is_routable: stores ETH_P_IPV6 when destination is routable
  *
  * Checks whether the given IPv6 packet has the potential to be forwarded with a
  * mode more optimal than classic flooding.
@@ -1094,7 +1094,8 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast frame to check
  * @is_unsnoopable: stores whether the destination is snoopable
- * @is_routable: stores whether the destination is routable
+ * @is_routable: stores the protocol (ETH_P_IP or ETH_P_IPV6) if the destination
+ *  is routable
  *
  * Checks whether the given multicast ethernet frame has the potential to be
  * forwarded with a mode more optimal than classic flooding.
@@ -1180,7 +1181,8 @@ static int batadv_mcast_forw_rtr_count(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to check
  * @vid: the vlan identifier
- * @is_routable: stores whether the destination is routable
+ * @is_routable: 0 if the destination is not routable, otherwise the protocol
+ *  (ETH_P_IP or ETH_P_IPV6) of the routable destination
  * @count: the number of originators the multicast packet need to be sent to
  *
  * For a multicast packet with multiple destination originators, checks which
@@ -1224,7 +1226,8 @@ batadv_mcast_forw_mode_by_count(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to check
  * @vid: the vlan identifier
- * @is_routable: stores whether the destination is routable
+ * @is_routable: stores the protocol (ETH_P_IP or ETH_P_IPV6) if the destination
+ *  is routable
  *
  * Return: The forwarding mode as enum batadv_forw_mode.
  */
@@ -1554,7 +1557,8 @@ batadv_mcast_forw_want_rtr(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to transmit
  * @vid: the vlan identifier
- * @is_routable: stores whether the destination is routable
+ * @is_routable: 0 if the destination is not routable, otherwise the protocol
+ *  (ETH_P_IP or ETH_P_IPV6) of the routable destination
  *
  * Sends copies of a frame with multicast destination to any node that signaled
  * interest in it, that is either via the translation table or the according
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 8700f92b..0120d1ea 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -477,7 +477,8 @@ batadv_mcast_forw_push_adjust_padding(struct sk_buff *skb, int *count,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the skb to push the destination addresses onto
  * @vid: the vlan identifier
- * @is_routable: indicates whether the destination is routable
+ * @is_routable: 0 if the destination is not routable, otherwise the protocol
+ *  (ETH_P_IP or ETH_P_IPV6) of the routable destination
  * @count: the number of originators the multicast packet needs to be sent to
  * @tvlv_len: stores the amount of currently pushed TVLV bytes
  *
@@ -569,7 +570,8 @@ static int batadv_mcast_forw_push_tracker(struct sk_buff *skb, int num_dests,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the skb to push the tracker TVLV onto
  * @vid: the vlan identifier
- * @is_routable: indicates whether the destination is routable
+ * @is_routable: 0 if the destination is not routable, otherwise the protocol
+ *  (ETH_P_IP or ETH_P_IPV6) of the routable destination
  * @count: the number of originators the multicast packet needs to be sent to
  * @tvlv_len: stores the amount of currently pushed TVLV bytes
  *
@@ -1123,7 +1125,8 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to encapsulate and send
  * @vid: the vlan identifier
- * @is_routable: indicates whether the destination is routable
+ * @is_routable: 0 if the destination is not routable, otherwise the protocol
+ *  (ETH_P_IP or ETH_P_IPV6) of the routable destination
  * @count: the number of originators the multicast packet needs to be sent to
  *
  * Encapsulates the given multicast packet in a batman-adv multicast packet.

-- 
2.47.3

