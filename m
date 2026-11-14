Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771BF60A260A
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=I5KeVkSM
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E690885BF4
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:23:03 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794648183;
 b=3zqmaQvmXaxDxTKzr2dGosa4Fr4LIrO16J4F8+QbETn/gnNK4M/ajnTuoMUQbkOceWvFk
 /mJZdvCD9bHlIlKN0pYk+hhrJxGDxDFC6tv+H4fmj0gvHtam737WVfPMQ4bIPK4tzzNnCSh
 xSZKDUNtOCfoPms+OE0rQxkX811KdmU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794648183; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wmZwJtte7nN5ISs0EOLLPKSeOakG+0DgYFGlBVu/uOA=;
 b=K1K8/dvhkvt0DJu5sFE/5M+ibS0JJvcjn2psSYgeNiWeJrBlz8DQGiO+U7VFWI0V1Meht
 ogcqtwUFEHo8+UwCsK5c8CL8xPBbuD7IK7SO7yn2rks23wyApzmeuDD54yBan60lv4qhROZ
 Qi9SQ7JTdHN+0+P8PEEYxHhTYoaSAmI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id EACEF80B7F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:16:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647782;
	b=kwIZJi3+b5KlXjgiVp3IE/HOiC+nrMzHcBkPxImReThpPL8iZlngCloZH5j3CkpR5JcPUH
	hPscxDXvXjIZU/Sa0brMyRtbH79/qHib131uRz/vfYVpOphlEftCP7LyTOqTD0flHjY975
	Fl49MBtRBZ4BxxGmNax3HsPMZHMeaW4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=wmZwJtte7nN5ISs0EOLLPKSeOakG+0DgYFGlBVu/uOA=;
	b=FEr1WDkO2bpBVIRAhr2fagrutvDLg4CoMl9CVeXtBHd8u1/R7MyYeiuWMA6bYvPAgtpLZB
	YKn1v8+C7o0AvppSmHOEus1Rp+vcVeUb/TJTNZ24E6qboMbDM80/ef0NoVQPtl7XkCsFxL
	pkj/Y1Oi5Zr1M9+fBvBmIZ9+tz3WpP8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=I5KeVkSM;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de (unknown
 [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 9C1F3FA260;
	Sat, 14 Nov 2026 10:16:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wmZwJtte7nN5ISs0EOLLPKSeOakG+0DgYFGlBVu/uOA=;
	b=I5KeVkSMNm+SqQ19p5Tx2TpNMOPn3lJEOCAGX4z0fC/gnGokHbVJzz+CNVG3oQG2FuCwOS
	jHYCAAppx2hqSU1qdOCKOQ2peqyN7oA68YChQSzIWYo2ulg1mKCT1w2CTs62XMltx2cAvZ
	UAbyJC/DFDf7X3nr7XScBbUblX7sX72EC7HdkqFQQCGdvhwARIcvTN6o8+IgRzZ6Ay9iQo
	u9E3/VPYnYwI64IdqnBc6az4+EHsXrVocBuLj2vKWdesoUgYzCExCFgoDSWFwRn4Utxv+Z
	fL+/uVI5Gobd4I1aNOLuiV0ReXcUrH2xGrqWsVS3bMshfQ1GtoOcbejz/9VXlg==
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
Subject: [PATCH net-next 10/15] batman-adv: document skb ownership of
 always-consuming functions
Date: Sat, 14 Nov 2026 10:15:51 +0100
Message-ID: <20261114091556.3336038-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114091556.3336038-1-sw@simonwunderlich.de>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CNPJ2CROOKXFGGTWYO6N3NJMP2N4PGNL
X-Message-ID-Hash: CNPJ2CROOKXFGGTWYO6N3NJMP2N4PGNL
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CNPJ2CROOKXFGGTWYO6N3NJMP2N4PGNL/>
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

Several functions always consume the skb they are given, but their
kernel-doc did not say so. Add an explicit "The skb is always consumed by
this function" to these functions.

Some even suggested the opposite and need corrections:

* batadv_v_elp_packet_recv() said the skb is consumed on NET_RX_SUCCESS,
  but it is freed on NET_RX_DROP as well
* batadv_send_skb_to_orig() still documented an -EINPROGRESS return
  value, which it no longer returns since the removal of the network coding
  support
* batadv_frag_insert_packet() did not say that the skb is freed on error

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_v_elp.c     |  6 ++++--
 net/batman-adv/fragmentation.c |  2 ++
 net/batman-adv/send.c          | 17 ++++++++++++++---
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 0eb07b789cffc..5c251feecabc5 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -551,8 +551,10 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
  * @skb: the received packet
  * @if_incoming: the interface this packet was received through
  *
- * Return: NET_RX_SUCCESS and consumes the skb if the packet was properly
- * processed or NET_RX_DROP in case of failure.
+ * The skb is always consumed by this function.
+ *
+ * Return: NET_RX_SUCCESS if the packet was properly processed or NET_RX_DROP
+ * in case of failure.
  */
 int batadv_v_elp_packet_recv(struct sk_buff *skb,
 			     struct batadv_hard_iface *if_incoming)
diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 9025d5f651464..936056a78effe 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -131,6 +131,8 @@ static bool batadv_frag_init_chain(struct batadv_frag_table_entry *chain,
  * Insert a new fragment into the reverse ordered chain in the right table
  * entry. The hash table entry is cleared if "old" fragments exist in it.
  *
+ * The skb is always consumed by this function.
+ *
  * Return: true if skb is buffered, false on error. If the chain has all the
  * fragments needed to merge the packet, the chain is moved to the passed head
  * to avoid locking the chain in the table.
diff --git a/net/batman-adv/send.c b/net/batman-adv/send.c
index 6672f81798e91..24eb222299d33 100644
--- a/net/batman-adv/send.c
+++ b/net/batman-adv/send.c
@@ -109,6 +109,8 @@ int batadv_send_skb_packet(struct sk_buff *skb,
  * @skb: packet to be transmitted (with batadv header and no outer eth header)
  * @hard_iface: outgoing interface
  *
+ * The skb is always consumed by this function.
+ *
  * Return: A negative errno code is returned on a failure. A success does not
  * guarantee the frame will be transmitted as it may be dropped due
  * to congestion or traffic shaping.
@@ -126,6 +128,8 @@ int batadv_send_broadcast_skb(struct sk_buff *skb,
  * @skb: packet to be transmitted (with batadv header and no outer eth header)
  * @neigh: neighbor which is used as next hop to destination
  *
+ * The skb is always consumed by this function.
+ *
  * Return: A negative errno code is returned on a failure. A success does not
  * guarantee the frame will be transmitted as it may be dropped due
  * to congestion or traffic shaping.
@@ -163,9 +167,10 @@ int batadv_send_unicast_skb(struct sk_buff *skb,
  * host, NULL can be passed as recv_if and no interface alternating is
  * attempted.
  *
- * Return: negative errno code on a failure, -EINPROGRESS if the skb is
- * buffered for later transmit or the NET_XMIT status returned by the
- * lower routine if the packet has been passed down.
+ * The skb is always consumed by this function.
+ *
+ * Return: negative errno code on a failure or the NET_XMIT status returned by
+ * the lower routine if the packet has been passed down.
  */
 int batadv_send_skb_to_orig(struct sk_buff *skb,
 			    struct batadv_orig_node *orig_node,
@@ -313,6 +318,8 @@ bool batadv_send_skb_prepare_unicast_4addr(struct batadv_priv *bat_priv,
  * depending on whether BATADV_UNICAST or BATADV_UNICAST_4ADDR was supplied
  * as packet_type. Then send this frame to the given orig_node.
  *
+ * The skb is always consumed by this function.
+ *
  * Return: NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
  */
 int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
@@ -389,6 +396,8 @@ int batadv_send_skb_unicast(struct batadv_priv *bat_priv,
  * BATADV_UNICAST_4ADDR was supplied as packet_type. Then send this frame
  * to the according destination node.
  *
+ * The skb is always consumed by this function.
+ *
  * Return: NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
  */
 int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
@@ -429,6 +438,8 @@ int batadv_send_skb_via_tt_generic(struct batadv_priv *bat_priv,
  * Look up the currently selected gateway. Wrap the given skb into a batman-adv
  * unicast header and send this frame to this gateway node.
  *
+ * The skb is always consumed by this function.
+ *
  * Return: NET_XMIT_DROP in case of error or NET_XMIT_SUCCESS otherwise.
  */
 int batadv_send_skb_via_gw(struct batadv_priv *bat_priv, struct sk_buff *skb,
-- 
2.47.3

