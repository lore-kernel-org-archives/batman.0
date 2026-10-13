Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A981ACC6B12
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 18:10:24 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 45A1181029
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 20:10:23 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791915023;
 b=H/N2kvf5D/h+H6A8oWBsh4bcmaMFX84U+JzYda1u5AneCjvdaU+qVR94Dd5QBjq5yaL/2
 6i2tEXeQjjUswWlxpQZWLgAT940bvwR4VXMkNukq71YukfMeDVARTDEuvO49hc2IyVogFjR
 xoB+eHEQdpUHqfOcs17Lxyls5cdHHeA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791915023; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jUbCMbrawzQzJSDiyfKGEVWAeItVg4BUcMgM+4pCz54=;
 b=uJVcIH+5z56+HcLFkWtIT9//Rci08EBfmqmeuKny25I+Ru/dyPrsrkNlh7IirgdXpbMqJ
 7J9Xp6f9RCcpgD7m9y98lTqk5j7+uHlhy49rVLkPA7cLZapoEaClNAhYRlDB9f0tSVlWZDE
 cp24cPt44wFRhD57MOjeRLqxfqEglVE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8C6C482F10
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 20:07:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791914888;
	b=x0XTuCw4klGxu80OKJOvB3wy6fRLNcI3GbtY7FA0a8pyCYPalw/OuLccF7dfF2n6BxK/Fd
	YOINmF2QSTeHpF5oZSVSVdLDoyLjlnMhj1bYXy67UMO5ipi1YVhqiF/n1vCA9N369Pcf4P
	KpReoYMR2hJ9y31ZkspbgLvODu8g8zc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791914888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jUbCMbrawzQzJSDiyfKGEVWAeItVg4BUcMgM+4pCz54=;
	b=kHpaiqUsb1qbiX/JDPt2ZLRqvMuFp/+RTWKa3I6FMHLKbnFNhcx2JyJOL5nRUf+Z1GNbMl
	stLdh7JNnoA6fJHcNRnGPx7pXUCUK4r08dr2u4qm7DvnH5oSlCQaARU4uusCiZ2hLOxNTA
	l00Nm02seWEYyOILQbopU5nl9h7bMz8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=WnOUSs9e;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 36C3820FAF;
	Tue, 13 Oct 2026 18:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791914878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUbCMbrawzQzJSDiyfKGEVWAeItVg4BUcMgM+4pCz54=;
	b=WnOUSs9eQ7DgFYA6F9CdD0/cW4dSNEPaV6BG9opsMn3x8kWsduI+55OtVBWuVPlkrKQ2fW
	iz5tu1P8YEhnwVrS3dhy4DgORd2oRGPT/2I20rYVVXidaYQagmPXLR6AlDY8LpggY9XuFS
	ohC9v8Ty1qzXMX2y0JkAQziutCTaewA=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 13 Oct 2026 20:07:50 +0200
Subject: [PATCH batadv 4/4] batman-adv: mcast: document the value stored in
 is_routable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-simple-type-cleanup-v1-4-8a31d7e82eb4@narfation.org>
References: <20261013-simple-type-cleanup-v1-0-8a31d7e82eb4@narfation.org>
In-Reply-To: <20261013-simple-type-cleanup-v1-0-8a31d7e82eb4@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6143; i=sven@narfation.org;
 h=from:subject:message-id; bh=Ypph89jOuc86azLiRBt4PdY2VrTFhMNJFGCJDQC38jA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnikvO2P3au0mgkS/4QURqRsqVBYF5bhWvDrsemHv2Q
 PbPspOnO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATkbzLyDB/pcXsiQ4BFjf+
 Hgvokbl1xEP178P565xORzyK32cR7SzM8L/ST8230vjbZM/tzSzH/W65CWkLlchM3pDfIZMpb1O
 qyAIA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JMMM2M42OWM74WREKF5CI4DQCDFKEM6L
X-Message-ID-Hash: JMMM2M42OWM74WREKF5CI4DQCDFKEM6L
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JMMM2M42OWM74WREKF5CI4DQCDFKEM6L/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The kerneldoc of is_routable says it indicates whether the destination is
routable, which reads like a boolean. But it actually holds the
protocol of the routable destination (ETH_P_IP or ETH_P_IPV6) or 0.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/multicast.c      | 18 ++++++++++++------
 net/batman-adv/multicast_forw.c |  9 ++++++---
 2 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 0446324c..100660cc 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -984,7 +984,8 @@ static bool batadv_mcast_is_report_ipv4(struct sk_buff *skb)
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the IPv4 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
- * @is_routable: stores whether the destination is routable
+ * @is_routable: stores 0 if the destination is not routable, otherwise the
+ *  protocol (ETH_P_IP or ETH_P_IPV6) of the routable destination
  *
  * Checks whether the given IPv4 packet has the potential to be forwarded with a
  * mode more optimal than classic flooding.
@@ -1052,7 +1053,8 @@ static bool batadv_mcast_is_report_ipv6(struct sk_buff *skb)
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the IPv6 packet to check
  * @is_unsnoopable: stores whether the destination is snoopable
- * @is_routable: stores whether the destination is routable
+ * @is_routable: stores 0 if the destination is not routable, otherwise the
+ *  protocol (ETH_P_IP or ETH_P_IPV6) of the routable destination
  *
  * Checks whether the given IPv6 packet has the potential to be forwarded with a
  * mode more optimal than classic flooding.
@@ -1094,7 +1096,8 @@ static int batadv_mcast_forw_mode_check_ipv6(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast frame to check
  * @is_unsnoopable: stores whether the destination is snoopable
- * @is_routable: stores whether the destination is routable
+ * @is_routable: stores 0 if the destination is not routable, otherwise the
+ *  protocol (ETH_P_IP or ETH_P_IPV6) of the routable destination
  *
  * Checks whether the given multicast ethernet frame has the potential to be
  * forwarded with a mode more optimal than classic flooding.
@@ -1180,7 +1183,8 @@ static int batadv_mcast_forw_rtr_count(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to check
  * @vid: the vlan identifier
- * @is_routable: stores whether the destination is routable
+ * @is_routable: 0 if the destination is not routable, otherwise the protocol
+ *  (ETH_P_IP or ETH_P_IPV6) of the routable destination
  * @count: the number of originators the multicast packet need to be sent to
  *
  * For a multicast packet with multiple destination originators, checks which
@@ -1224,7 +1228,8 @@ batadv_mcast_forw_mode_by_count(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: the multicast packet to check
  * @vid: the vlan identifier
- * @is_routable: stores whether the destination is routable
+ * @is_routable: stores 0 if the destination is not routable, otherwise the
+ *  protocol (ETH_P_IP or ETH_P_IPV6) of the routable destination
  *
  * Return: The forwarding mode as enum batadv_forw_mode.
  */
@@ -1554,7 +1559,8 @@ batadv_mcast_forw_want_rtr(struct batadv_priv *bat_priv,
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
index e77a111f..a33ecbb9 100644
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
@@ -1120,7 +1122,8 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
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

