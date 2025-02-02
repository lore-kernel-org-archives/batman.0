Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82300C0218F
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 16:08:05 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0412E8402C
	for <batman-adv@archiver.kernel.org>; Sun,  2 Feb 2025 17:08:04 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738512484;
 b=VSeQZS5I4nITyezOSbsZInr6qEXLyB3iESShzyrPNyqDwzyVmoqVaKXDLQvXwpByZknM8
 uc8lyzrFt3PTnKNynpYbJrUBtW4bIuwZ14VlV1jk3HhUzGfMeonXwIJ9CdvxSt6ITBgvXIK
 fret76s+uMHNrMyQApX/qZto65SUGRs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738512484; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4A2VgP/niVHsikbpR6VqhacnmPk4pooFkJl3TZPcHNo=;
 b=kZzE1vNeDjnCQ/41dqb+C/MNhC+ZbNgJih9ZcKDAtyO1Al6E4bRzC0tM+FGvIhgJCU04b
 SSdFDxJpEofpRmWwWDZ644ifXBMw++ddE/XRIlPdgq/ImKwZeL2MTvgsuNoYPG/qRSQ6eXO
 043qGjdeI3eiqhKUsxEfWHy8/UYJoi4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2D6A6840F0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  2 Feb 2025 17:04:41 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738512281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4A2VgP/niVHsikbpR6VqhacnmPk4pooFkJl3TZPcHNo=;
	b=Os4zFcmcQOl04p1bSBA6BCVHqHlSun0rpy+uiTNtYKFmao8YCw3yqSMgux5QuSOtvqhaTa
	T+E4RXTV91Kco24x+LllnwKk6qfDO/UDQQOgn/C0HPCY3o9SV4nAa/lNc+rZ7MY09i8s8i
	VhduR/6lrrJMdP0ooOkfDe9sC0+5yEY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=a76w0AO+;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1738512281; a=rsa-sha256;
	cv=none;
	b=wpQwNRs+QVxq/M3ngzMoWMWoQoD2AG0ROy+en3znVjbE+pItLYcQ2GHocM66tykQpY6O07
	MZkqx3ee5/KBwf3Mn7bAdmiUMA5kTr/xL7IBAAG6T1R6xsbpX3MfRaVVhW7HOyMMbJ3ecr
	AoPejjApbabJnq1C2gXeCsSl54+sKVg=
Received: from sven-desktop.home.narfation.org (unknown
 [IPv6:2a00:1ca0:1d86:2efc::ab85])
	by dvalin.narfation.org (Postfix) with UTF8SMTPSA id D1AA61FFC7;
	Sun,  2 Feb 2025 16:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1738512280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A2VgP/niVHsikbpR6VqhacnmPk4pooFkJl3TZPcHNo=;
	b=a76w0AO+jyXBQCuAbzHUYEDll/27gS17PtpolKR1mzD0UL0gU/zb0mBv114rsGD8ptQl9u
	GcXYVe776hmHJYBmqGZ7B5q9q4suXI2DRM2WfR5hy9qAjpwwAhdLLLx/x5ILjNKK416IKJ
	vHGheu2G+Cf9MyLQRvubFYe7Hq6i0bY=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 02 Feb 2025 17:04:14 +0100
Subject: [PATCH 5/5] batman-adv: Limit aggregation size to outgoing MTU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250202-bitmap_aggregation-v1-5-6542a10e6fad@narfation.org>
References: <20250202-bitmap_aggregation-v1-0-6542a10e6fad@narfation.org>
In-Reply-To: <20250202-bitmap_aggregation-v1-0-6542a10e6fad@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2901; i=sven@narfation.org;
 h=from:subject:message-id; bh=UNsjzAvyrCK+RI3xQQEacYRYBfrE8644FEAbtApZa00=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDOnzp9fIM86fHdd6L3djYVnXtN2HFm8qFf/5lWXClfkGm
 hNX+C606ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBM5GMow/+K7F61xxLXVJb9
 6uJzd370gZn1162bWjK567+vMREyzQtj+B8zvc6O4YHNitVWwQ/bGY+ESj2bKHmx5FO+Q6rRE9k
 P9owA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 66D7JH5R5RTHCMW4AKTUL76GGNRNKW2I
X-Message-ID-Hash: 66D7JH5R5RTHCMW4AKTUL76GGNRNKW2I
X-MailFrom: sven@narfation.org
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/66D7JH5R5RTHCMW4AKTUL76GGNRNKW2I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

If a B.A.T.M.A.N. IV aggregated OGM was prepared, it was always assumed
that 512 bytes (BATADV_MAX_AGGREGATION_BYTES) can be transmitted. But the
outgoing MTU might be too small for these 512 bytes and the aggregation
size must be adjusted in this case. Otherwise, the aggregates will cause
unnecessary packet loss.

For now, the non-aggregated packet length is not touched.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 769d5ff779eb88de8b9d889bb3e4a3304875ea32..dbad6007871a97ee01f7295c005ab3deeff86efd 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -443,22 +443,26 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
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
@@ -466,7 +470,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	    !time_after_eq(aggregation_end_time, forw_packet->send_time))
 		return false;
 
-	if (aggregated_bytes > BATADV_MAX_AGGREGATION_BYTES)
+	if (aggregated_bytes > max_bytes)
 		return false;
 
 	if (packet_num >= BATADV_MAX_AGGREGATION_PACKETS)
@@ -551,9 +555,9 @@ static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_buff,
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
2.47.2

