Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A81CBC35FF3
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 16:50:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 514A88467E
	for <batman-adv@archiver.kernel.org>; Thu, 13 Mar 2025 17:50:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1741884601;
 b=eaV2D5IS+NYOuaiQsoHj9ytFkku4pTgBLXD1HcIAOw/A2wVCLqeJH9AJJBj2Gf6h53LXe
 yVezEBLjCnW2hyB+riUia5R1F2tOOJFnvDPQs10Uaw1ISpVhR3SIwXPVzKutVQjqvPQ8dGl
 e6Tj9FIUjNjJR3YLPQVX4EPLgtR/39U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1741884601; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4XbpSU8AJVK9zTUzLjfOmv+0HBg+eeMgqjWMS9B0lrw=;
 b=Jfzz57+RODvOWXOAav3IPEDwfF+5QOUK0rvunIfFUG7MJs0uRlMt+kM6Xp4Q6fywCwxIm
 4POQbYWu+p/EllgYLE5Cri/l/49Y4wLKY24QE9h0up+WW4rTlhqoosCefzBC7KwCuNgpn4u
 hEMBunMLevmh5LG0fvCfI8mhFrd6YtI=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass;
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D88DC8428D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 13 Mar 2025 17:45:30 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1741884330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4XbpSU8AJVK9zTUzLjfOmv+0HBg+eeMgqjWMS9B0lrw=;
	b=yNB2mZhFz3kYhz7NesWbnJrjOZXm0/7ad++/Iof9iTfsbDE67ZmuHjb0P+JE4AbxQ3mN+q
	ZBTnN2FHoLqmLrXWN46l74MkIQV5CwszmoCbUMhJ5VilJi2KSGa9i0QwS9YzQp3tnoezEW
	LuH2dESl7LszgLALR2tlpMmvJoFu240=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1741884330; a=rsa-sha256;
	cv=none;
	b=yImvlLE26l982z5NHg2pbVVW/7CA/JJ7dVVN4t3U2ezMkux0oOFo1gmXKkQMuIRimREFyT
	QbC5Eafe9tmr7gaFdCaN1tRrA9PMaHczK5bRoRFovOv0FFqgDQLOOqCVaSkMxXXTONs5Tb
	uxJihUcMdapzbdWHAZOwbPOaWj+2mS4=
Received: from kero.packetmixer.de
 (p200300Fa272413901A38A4BC9c0De305.dip0.t-ipconnect.de
 [IPv6:2003:fa:2724:1390:1a38:a4bc:9c0d:e305])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id BB7EEFA44B;
	Thu, 13 Mar 2025 17:45:30 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 09/10] batman-adv: Limit aggregation size to outgoing MTU
Date: Thu, 13 Mar 2025 17:45:18 +0100
Message-Id: <20250313164519.72808-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250313164519.72808-1-sw@simonwunderlich.de>
References: <20250313164519.72808-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RZ7FJXLAJZHT7R6CD6IA3GM2E5O2BVFQ
X-Message-ID-Hash: RZ7FJXLAJZHT7R6CD6IA3GM2E5O2BVFQ
X-MailFrom: sw@simonwunderlich.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RZ7FJXLAJZHT7R6CD6IA3GM2E5O2BVFQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

If a B.A.T.M.A.N. IV aggregated OGM was prepared, it was always assumed
that 512 bytes (BATADV_MAX_AGGREGATION_BYTES) can be transmitted. But the
outgoing MTU might be too small for these 512 bytes and the aggregation
size must be adjusted in this case. Otherwise, the aggregates will cause
unnecessary packet loss.

For now, the non-aggregated packet length is not touched.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index a20d7f3004c1..7b4f659612a3 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -23,6 +23,7 @@
 #include <linux/kref.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
+#include <linux/minmax.h>
 #include <linux/mutex.h>
 #include <linux/netdevice.h>
 #include <linux/netlink.h>
@@ -444,22 +445,26 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 			    const struct batadv_forw_packet *forw_packet)
 {
 	struct batadv_ogm_packet *batadv_ogm_packet;
-	int aggregated_bytes = forw_packet->packet_len + packet_len;
+	unsigned int aggregated_bytes = forw_packet->packet_len + packet_len;
 	struct batadv_hard_iface *primary_if = NULL;
 	u8 packet_num = forw_packet->num_packets;
 	bool res = false;
 	unsigned long aggregation_end_time;
+	unsigned int max_bytes;
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)forw_packet->skb->data;
 	aggregation_end_time = send_time;
 	aggregation_end_time += msecs_to_jiffies(BATADV_MAX_AGGREGATION_MS);
 
+	max_bytes = min_t(unsigned int, if_outgoing->net_dev->mtu,
+			  BATADV_MAX_AGGREGATION_BYTES);
+
 	/* we can aggregate the current packet to this aggregated packet
 	 * if:
 	 *
 	 * - the send time is within our MAX_AGGREGATION_MS time
 	 * - the resulting packet won't be bigger than
-	 *   MAX_AGGREGATION_BYTES
+	 *   MAX_AGGREGATION_BYTES and MTU of the outgoing interface
 	 * - the number of packets is lower than MAX_AGGREGATION_PACKETS
 	 * otherwise aggregation is not possible
 	 */
@@ -467,7 +472,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	    !time_after_eq(aggregation_end_time, forw_packet->send_time))
 		return false;
 
-	if (aggregated_bytes > BATADV_MAX_AGGREGATION_BYTES)
+	if (aggregated_bytes > max_bytes)
 		return false;
 
 	if (packet_num >= BATADV_MAX_AGGREGATION_PACKETS)
@@ -552,9 +557,9 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
 	unsigned int skb_size;
 	atomic_t *queue_left = own_packet ? NULL : &bat_priv->batman_queue_left;
 
-	if (atomic_read(&bat_priv->aggregated_ogms) &&
-	    packet_len < BATADV_MAX_AGGREGATION_BYTES)
-		skb_size = BATADV_MAX_AGGREGATION_BYTES;
+	if (atomic_read(&bat_priv->aggregated_ogms))
+		skb_size = max_t(unsigned int, BATADV_MAX_AGGREGATION_BYTES,
+				 packet_len);
 	else
 		skb_size = packet_len;
 
-- 
2.39.5

