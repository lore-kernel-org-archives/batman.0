Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6DAE732D0
	for <batman@archiver.kernel.org>; Thu, 28 Sep 2023 13:51:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 824EE833A4
	for <batman@archiver.kernel.org>; Thu, 28 Sep 2023 15:51:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1695909107;
 b=190/Q/iDVh+hS2AE+0PVEhpnYPu+cBsQKiBuLptacpRUM8TQ8g+JL8MlTx64BRms0/RIo
 PyFYQURZWatHzZf5oauZsACuGdrwkkPO+AOAvQL+x6VtQz9MEaIp88Jb5oOEW2aeg5h07QX
 BXTZVLt68f7bZtpIA6uJTL4lTYzfGsI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1695909107; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TBjKwdDPoBhNyhGLuJrHOWdOCkX88hrW7nKxsponQFg=;
 b=YOjx6JLdkkz7aP72gURNtZj/lFbQWdH2zYkw54hZKz1CF3jwTZRVxUWILU4rR0h4QULCy
 3pXayzHTtXxGE2WCDmvz7cAzeALX/6ZOHC1hb3CUDGEWjpVfISauGA+0uhKyLDhtvPeEdZ2
 WvADBcKkiOQr6WGAdr8u6YdjXIG64Hk=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net
 [217.70.183.193])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7AEE783101
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 28 Sep 2023 14:40:40 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1695904840; a=rsa-sha256;
	cv=none;
	b=w97AzsG8IQ+N96J/llb5HYgVRs24HBZNqaWu9FddJCCm9qDVDw7MbueV8BAfPUE5XyjNBL
	uMOK4LO0H3qQ1SnhukxJ3jt/WCdAcMMx3/8BtLE0/Rwgp1sBihk/XV4zTbhbRn71etuuyy
	2QtQdA5NAr1ndtNhZv21fXiSgGSl490=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of repk@triplefau.lt designates
 217.70.183.193 as permitted sender) smtp.mailfrom=repk@triplefau.lt
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1695904840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TBjKwdDPoBhNyhGLuJrHOWdOCkX88hrW7nKxsponQFg=;
	b=19zQyZOeQ7P7Fl298MCNsDgGpmKZ0+QUjzAzAEjVrJvFYCEBfGHcM+n7DZuC4IkjDf1+va
	W4VU3F643F6Y4ZmUa9fJewunTX888hMBHjAZDWXL1yDnqQPjyFSOdPUq5iRVTveHD8QMV1
	5BSkybDFZQKHNtWEDn275Bev0cbCUhk=
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA6B324000F;
	Thu, 28 Sep 2023 12:40:39 +0000 (UTC)
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH RFC 1/2] batman-adv: Keep half duplex penalty on OGM receiving
 side also
Date: Thu, 28 Sep 2023 14:39:35 +0200
Message-Id: 
 <267dc235e8a1587ce469794ad9a69c651f59a613.1695904299.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1695904299.git.repk@triplefau.lt>
References: <cover.1695904299.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: repk@triplefau.lt
X-MailFrom: repk@triplefau.lt
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1
Message-ID-Hash: Z47VKT3HOUBBT6BOYNWGMF2CO67CPBGC
X-Message-ID-Hash: Z47VKT3HOUBBT6BOYNWGMF2CO67CPBGC
X-Mailman-Approved-At: Thu, 28 Sep 2023 15:50:50 +0200
CC: Remi Pommarel <repk@triplefau.lt>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Z47VKT3HOUBBT6BOYNWGMF2CO67CPBGC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Considering the following topology:

+-------+         +-------+         +-------+
| Orig0 | <------ | Orig1 | <------ | Orig2 |
+-------+   T01   +-------+   T12   +-------+

Where T01 and T12 are throughput estimations for link between Orig0 and
Orig1 and the one between Orig1 and Orig2 respectively. And where Orig1
is using the same WiFi interface to reach Orig0 and Orig2.

In this case Orig2 will receive an OGM for Orig0 from Orig1 with a
throughput of T01/2 to take into account store & forward charactersitic
of WiFi interface. But if T12 is lower that T01/2 this penalty is
dropped and end-to-end throughput for Orig2 to Orig0 path will be
estimated to be T12.

This patch adds a flag in OGM packet that indicates the OGM needs half
duplex penalty. Thus the node receiving it (i.e. Orig2 in the situation
above) can correctly apply the penalty on its throughput.

In the case above Orig2 will received from Orig1 a OGM for Orig0 with
BATADV_V_HALF_DUPLEX flag set, so it could use T12/2 as its end-to-end
path throughput instead of T12.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 include/uapi/linux/batadv_packet.h |  8 ++++++
 net/batman-adv/bat_v_ogm.c         | 42 +++++++++++++++++++++++++-----
 net/batman-adv/types.h             |  3 +++
 3 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index ea4692c339ce..9c711d149a45 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -84,6 +84,14 @@ enum batadv_iv_flags {
 	BATADV_DIRECTLINK          = 1UL << 2,
 };
 
+/**
+ * enum batadv_v_flags - flags used in B.A.T.M.A.N. V OGM2 packets
+ * @BATADV_V_HALF_DUPLEX: Half Duplex penalty should be applied to throughput
+ */
+enum batadv_v_flags {
+	BATADV_V_HALF_DUPLEX   = 1UL << 0,
+};
+
 /**
  * enum batadv_icmp_packettype - ICMP message types
  * @BATADV_ECHO_REPLY: success reply to BATADV_ECHO_REQUEST
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index 1d750f3cb2e4..27597f4cdf3e 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -474,12 +474,14 @@ void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *primary_iface)
 static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
 				    struct batadv_hard_iface *if_incoming,
 				    struct batadv_hard_iface *if_outgoing,
-				    u32 throughput)
+				    u32 throughput, bool *half_duplex)
 {
 	int if_hop_penalty = atomic_read(&if_incoming->hop_penalty);
 	int hop_penalty = atomic_read(&bat_priv->hop_penalty);
 	int hop_penalty_max = BATADV_TQ_MAX_VALUE;
 
+	*half_duplex = false;
+
 	/* Apply per hardif hop penalty */
 	throughput = throughput * (hop_penalty_max - if_hop_penalty) /
 		     hop_penalty_max;
@@ -494,8 +496,10 @@ static u32 batadv_v_forward_penalty(struct batadv_priv *bat_priv,
 	 */
 	if (throughput > 10 &&
 	    if_incoming == if_outgoing &&
-	    !(if_incoming->bat_v.flags & BATADV_FULL_DUPLEX))
+	    !(if_incoming->bat_v.flags & BATADV_FULL_DUPLEX)) {
+		*half_duplex = true;
 		return throughput / 2;
+	}
 
 	/* hop penalty of 255 equals 100% */
 	return throughput * (hop_penalty_max - hop_penalty) / hop_penalty_max;
@@ -573,6 +577,9 @@ static void batadv_v_ogm_forward(struct batadv_priv *bat_priv,
 
 	/* apply forward penalty */
 	ogm_forward = (struct batadv_ogm2_packet *)skb_buff;
+	ogm_forward->flags &= ~BATADV_V_HALF_DUPLEX;
+	if (neigh_ifinfo->bat_v.half_duplex)
+		ogm_forward->flags |= BATADV_V_HALF_DUPLEX;
 	ogm_forward->throughput = htonl(neigh_ifinfo->bat_v.throughput);
 	ogm_forward->ttl--;
 
@@ -615,6 +622,7 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 	bool protection_started = false;
 	int ret = -EINVAL;
 	u32 path_throughput;
+	bool half_duplex;
 	s32 seq_diff;
 
 	orig_ifinfo = batadv_orig_ifinfo_new(orig_node, if_outgoing);
@@ -656,10 +664,12 @@ static int batadv_v_ogm_metric_update(struct batadv_priv *bat_priv,
 
 	path_throughput = batadv_v_forward_penalty(bat_priv, if_incoming,
 						   if_outgoing,
-						   ntohl(ogm2->throughput));
+						   ntohl(ogm2->throughput),
+						   &half_duplex);
 	neigh_ifinfo->bat_v.throughput = path_throughput;
 	neigh_ifinfo->bat_v.last_seqno = ntohl(ogm2->seqno);
 	neigh_ifinfo->last_ttl = ogm2->ttl;
+	neigh_ifinfo->bat_v.half_duplex = half_duplex;
 
 	if (seq_diff > 0 || protection_started)
 		ret = 1;
@@ -842,6 +852,26 @@ batadv_v_ogm_aggr_packet(int buff_pos, int packet_len,
 	       (next_buff_pos <= BATADV_MAX_AGGREGATION_BYTES);
 }
 
+/**
+ * batadv_v_get_throughput() - Compute path throughput from received OGM
+ * @ogm: OGM2 packet received
+ * @neigh: Neighbour OGM packet has been received from
+ * @return: Estimated path throughput
+ */
+static u32 batadv_v_get_throughput(struct batadv_ogm2_packet *ogm,
+				   struct batadv_hardif_neigh_node *neigh)
+{
+	u32 oth, lth;
+
+	oth = ntohl(ogm->throughput);
+	lth = ewma_throughput_read(&neigh->bat_v.throughput);
+
+	if ((ogm->flags & BATADV_V_HALF_DUPLEX) && lth > 10)
+		lth /= 2;
+
+	return min_t(u32, lth, oth);
+}
+
 /**
  * batadv_v_ogm_process() - process an incoming batman v OGM
  * @skb: the skb containing the OGM
@@ -858,7 +888,7 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	struct batadv_neigh_node *neigh_node = NULL;
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
-	u32 ogm_throughput, link_throughput, path_throughput;
+	u32 ogm_throughput, path_throughput;
 	int ret;
 
 	ethhdr = eth_hdr(skb);
@@ -911,9 +941,9 @@ static void batadv_v_ogm_process(const struct sk_buff *skb, int ogm_offset,
 	 *    neighbor) the path throughput metric equals the link throughput.
 	 *  - For OGMs traversing more than hop the path throughput metric is
 	 *    the smaller of the path throughput and the link throughput.
+	 *  - Also apply Half Duplex interfaces penalty
 	 */
-	link_throughput = ewma_throughput_read(&hardif_neigh->bat_v.throughput);
-	path_throughput = min_t(u32, link_throughput, ogm_throughput);
+	path_throughput = batadv_v_get_throughput(ogm_packet, hardif_neigh);
 	ogm_packet->throughput = htonl(path_throughput);
 
 	batadv_v_ogm_process_per_outif(bat_priv, ethhdr, ogm_packet, orig_node,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 2be5d4a712c5..147b1595d32a 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -708,6 +708,9 @@ struct batadv_neigh_ifinfo_bat_v {
 
 	/** @last_seqno: last sequence number known for this neighbor */
 	u32 last_seqno;
+
+	/** @half_duplex: throughput should suffer half duplex penalty */
+	bool half_duplex;
 };
 
 /**
-- 
2.40.0

