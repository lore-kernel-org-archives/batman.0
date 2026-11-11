Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241D606A31C
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 10:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=DESMkFGZ
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 95486853FF
	for <batman@archiver.kernel.org>; Wed, 11 Nov 2026 11:31:16 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794393076;
 b=MVNkmxkq5X8rCCQMPwpp3vmyzZXtvbdu6BNX1vCc5F1OXSBEFfaBBIEX3i8N9to4l6jMK
 /pCV7YbtJBxmLjO6TNnIz3GcXj8j0x2QRPdHJKzazAVtiKlyBgJrrPojyHmTeRDg/wUAMzc
 TkUrJ1f+66dBkMRUUnE588Y5gnDwz5c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794393076; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=061AyPVq+UbNcTTu8ui/UjYhadGaINZY0Wyh6TQdlnA=;
 b=q2DVousneE8HneqURoKrNP32H0n1ibGCPx7HYnyr5G+sWLlszqvrk4pD3r93uMVZ6NtcI
 MSIdkpswtwTEd8c/Nrj2Og/nhyk0PoKaZRkgHDQc+h/TJEwKDxy7ZveB5nncjG5UPsfIKGk
 nEdyS4ESFlJ9BW4xRXx/PaxrVxeDbjk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 54F93842F2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 11 Nov 2026 11:27:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794392865;
	b=itS5CN1TmoW4kPfAxhJLJRHVHfvHF43dFJXm8Y51ERX+Z7ZDnPnMsBqU4iUGHbqlP1gisY
	XxgvQgv/FoC7YOOGj8GLMWGCDdUCjWOQjNYTxMkzSLDaSpkLNiu/m/0eYGBCb3hIqJWQ4d
	p04RLlcU/L6HeWlY7bQ1N+msIeDqUXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794392865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=061AyPVq+UbNcTTu8ui/UjYhadGaINZY0Wyh6TQdlnA=;
	b=YCKoq7BrGIpl4zsued27K2pmORYvstt0L525R8eMFi2R9U4xjYxFuTia5PCmeLGtSzek7r
	tXIKtIZ4qvrjqRqe+lAZ9K0P5qR3KhgUJCpeYRsWP23FkveeNFaOovNZSW/nzETWP9DoEj
	8xq66DIxTliQM6BSMW6lEF4DKAAUwWs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=DESMkFGZ;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59740deD843Be7e4A980e9c65.dip0.t-ipconnect.de
 [IPv6:2003:c5:9740:ded8:43be:7e4a:980e:9c65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 4EBA7FA2F2;
	Wed, 11 Nov 2026 11:27:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794392862;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=061AyPVq+UbNcTTu8ui/UjYhadGaINZY0Wyh6TQdlnA=;
	b=DESMkFGZkfmDTZFvXolYreqs8euou2Bvhr3RZ+PyFs6D1Ek951LUVo+uSQ1O+xO7q+VDst
	w1SRZ+JVhnLe0iwCxDCbE+WLTf+fia2EW8CdkoqExdePmvAhA+bu1msnSSXTdWn866w14e
	/i8+iz8hoHfy2p2/dwKBDVKSUr5Xf5cJcW7JV7jyjY5NofCS5Nbnrj6ZxUsVk0d6e+QkBb
	I1dZZ+Jq+vDWqAotrVv34QNmgMp+RikL5LPYvwE9Ji9FFqzz9BnhpPDA96j790U478j4mH
	AQCd58O8fb21wC4HvCVjPFHHFJ3VWUY805oc1T0G1oDrIp0Rf3sXjhd2HBwbrg==
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
Subject: [PATCH net-next 15/15] batman-adv: mcast: document the value stored
 in is_routable
Date: Wed, 11 Nov 2026 11:27:29 +0100
Message-ID: <20261111102729.2096241-16-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261111102729.2096241-1-sw@simonwunderlich.de>
References: <20261111102729.2096241-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TZC43GI272MZWTRX4A7XUII6FNATUWF4
X-Message-ID-Hash: TZC43GI272MZWTRX4A7XUII6FNATUWF4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/TZC43GI272MZWTRX4A7XUII6FNATUWF4/>
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

The kerneldoc of is_routable says it indicates whether the destination is
routable, which reads like a boolean. But it actually holds the
protocol of the routable destination (ETH_P_IP or ETH_P_IPV6) or 0.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c      | 16 ++++++++++------
 net/batman-adv/multicast_forw.c |  9 ++++++---
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 0446324c64e85..1e086a6385261 100644
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
index 8700f92b9bb0f..0120d1ea30acf 100644
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

