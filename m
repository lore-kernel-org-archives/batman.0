Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D728CC6B2F
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 06:33:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6A3B884258
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 08:33:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792046024;
 b=WfnBWR6G7Zp6Wp8ZkJO++P+cROPNXBsDsz2jv3QkjZgZuWwEO+RrBXcUaVH3BiaDGCaWn
 kOirSrtAhUyY5zVCTWTw8vVCxHubKO8ivvYaKNBM0XOvThn/FIGZ2uqvbBxfXa5R+PvvB7q
 y9fNc8mBxhmQxz8A/ViQxnIAAc+uW8Y=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792046024; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YbXE/UhiQJrFrhH80OrszHURQrBd4iUXfqqT2L1+zcQ=;
 b=t3B7nFiLWKovB6n9nuY6gEHmfBjsB5OVb29aIQ14m5H3Cv54gUu166O4LwSeKAjdsrdn4
 ZErq3RZsnAUvBeQWNKD+HX6u9gB1Paaj4w6YV9qcc1BaWyUba8uT1MKDMH2iXQ/VikhrO7z
 v/M+D+J0WjzA+BxNe24obHh/kdfc0ZQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 589348450C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 15 Oct 2026 08:31:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792045902;
	b=r3mDyoKvtWeQrzpQscj4iOQDN4KGEkiLwhEbXrnxTKaieWNxhczSVT84io61TLKWthwReO
	1yxMvX//cJ2c6JxYhdZYuTLyVCosyxxURDtXeCZR7mBwx3YlpU+gdAVXa8u2iR2L0lPac8
	k8+Gyuz+WXljig36D19g6wIGH3zKmrY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792045902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YbXE/UhiQJrFrhH80OrszHURQrBd4iUXfqqT2L1+zcQ=;
	b=1mOukpUWtVBygB7l0q8+Ps6mJlocD0uP+kjTMy1OHJuxLKx0hKDqRy6LyUiKrkID6Hm8Y4
	JFvtBXGqTv+u0chgDB88UcS12oKCAhCW6SX5BVoIz9ySWkbheUyR2UmCVrdm3driPPml5n
	/dVGnjoZXy6/nDnMscH0W5CciYOJNZw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=FJ8RlYiC;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id EEAC920F2B;
	Thu, 15 Oct 2026 06:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792045892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YbXE/UhiQJrFrhH80OrszHURQrBd4iUXfqqT2L1+zcQ=;
	b=FJ8RlYiC6Ms8LGbARlbyZEHZhCf40qAGZ6yNT1ajIRhXPUhwt56f/yX3pHbCCcy8DyL7Yu
	RuNhLPg/ExD3zg3vl1oFzezTcRLchwVQJdc9kr4XFJgHfb6SNSzbo6WGhXtubEn6fVB4PF
	Q2OgP+7IxMiBiMi+LH8a+Om0Kc6ZEYI=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 15 Oct 2026 08:31:04 +0200
Subject: [PATCH RESEND batadv 4/4] batman-adv: document skb ownership of
 always-consuming functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-skb-ownership-v1-4-8bb03bba6701@narfation.org>
References: <20261015-skb-ownership-v1-0-8bb03bba6701@narfation.org>
In-Reply-To: <20261015-skb-ownership-v1-0-8bb03bba6701@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5321; i=sven@narfation.org;
 h=from:subject:message-id; bh=RIZQ9gDwzjdqywgsO2pF7IpadzOb2exKwO8YJAIwaYU=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkXinWLr2+1meewMczoSdESzToTnvUT7s+JT9/YJpW57
 flGGZFdHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJnLRiZOg7Fbb68+Mfhi5Z
 Wzo4iyp4r9rfyeXgNDN4zX1u4vpHNfMZ/im42S9/l7F+vmKXQ4Z156oDi7e92bW1PkF0Tj9PfmH
 Hbz4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: V3IY5BYU7K7FIPFVMTAGLNAM3WVM47TI
X-Message-ID-Hash: V3IY5BYU7K7FIPFVMTAGLNAM3WVM47TI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/V3IY5BYU7K7FIPFVMTAGLNAM3WVM47TI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

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
---
 net/batman-adv/bat_v_elp.c     |  6 ++++--
 net/batman-adv/fragmentation.c |  2 ++
 net/batman-adv/send.c          | 17 ++++++++++++++---
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index 6ad6042a..bdaf7f0b 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -549,8 +549,10 @@ static void batadv_v_elp_neigh_update(struct batadv_priv *bat_priv,
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
index 9025d5f6..936056a7 100644
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
index 6672f817..24eb2222 100644
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

