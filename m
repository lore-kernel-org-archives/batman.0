Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6345C43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 07:29:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 62F5F8084E
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 09:29:03 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782631743;
 b=vB8BxtXBIu14POc1dFApEuH+XVhAFTH3e3mGqhH9Q1XCB1BD5HNHfxkTav51dHl6tMLfZ
 BnTP7+w3f5AxPpOz3fR6e8/mgE66p11VJSUPL9KdlDfOwSr+TmM/WmLm59upLu9SOg5Rwz8
 Alwx35OVwnlJu/ul0W/fPwA51eW6rWk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782631743; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+SwMoy7GsN+2J4J2oBIPUa0NipcClM3IF4tgWEiss20=;
 b=svMHgiDE+kBvRM+8fQhBHc9PLUfOmdWAcct6ASeGNLaJk8nMRufJIZTtdvZm+12MA3Jbq
 zQ8o3ifl7eCRECKlM2eRb490uqJG/EcIJXp+/ZUY/PiB6OZXv1oW74CwtOzYMAOQd8ey56z
 16Wb6I/DQ8TIE+uUMgqvqYTK2k7vWjI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id F21FA807CF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 09:25:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782631552;
	b=bYBTN+lgBAhTIVJ4rhIJfEL27vo69LRjmIfdotoaIabmkAqr3B7tr7wEioiT8g4vSFKCKB
	KkCC3zGsc8hjMTM76BhxeULwMGV9vIEtk+fw1ezstGEjLPPWpBURKdyAsOmVjXl3+SBFbW
	H+5dubUPXDuxY5UEgdF4seAz5AfYnis=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782631552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+SwMoy7GsN+2J4J2oBIPUa0NipcClM3IF4tgWEiss20=;
	b=ftBNcamm+SpunYE1Rk7DLMICetDOWi6bzcKFvzFy/dxVYPzwFMiUM3EweDAxkVvLODjn8b
	UoqWNBbDLG/iETzJARlVD+Ayjs2ZxTKLYXvmmK7D3NzAvBGdx6qZi5EKjj6IBHKCapd27O
	iCuztIWVqtVajXMiEI//hNZPLE8mpvo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=iEHOH3rR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B0A432031E;
	Sun, 28 Jun 2026 07:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782631551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+SwMoy7GsN+2J4J2oBIPUa0NipcClM3IF4tgWEiss20=;
	b=iEHOH3rRqfD9lNYx0Hnk4DCzeuDAWQGRT8B7ZVapgktBjPhKEWKs+N6u+0b2sQaA2ieWVj
	8ZQIhfyVxVdaMlWFzJ5nPDnpnj6gpD+UJIJ4AVv8B6Tva1yq/BK6mq1FwwSBZIxiue2KFj
	yozol7NnKxhmEVwdokYM3xwVjq0xIDM=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Jun 2026 09:25:38 +0200
Subject: [PATCH batadv v2 5/5] batman-adv: annotate functions which may
 reallocate the skbuff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-skb-post-realloc-v2-5-59a58f5a471b@narfation.org>
References: <20260628-skb-post-realloc-v2-0-59a58f5a471b@narfation.org>
In-Reply-To: <20260628-skb-post-realloc-v2-0-59a58f5a471b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9863; i=sven@narfation.org;
 h=from:subject:message-id; bh=0nKFgbzE2LxDcraPAqRUSP5icj1j5iwmyJGmyEJN2nk=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkOZwoNwo71be3f6S/w7mPMTF6BlLZDMZvzOwsKXv7v2
 JXoamTeUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZhI1g2Gf9be1+JX6M2MLzP8
 V+5T4jm18ZqAbZLvZvVs6T+n3L7nvWX4X3q8pKJBx7nnc9LsYMOGjVMXbHdt6MzbEyt4VdZL+lw
 9NwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 42HPN23GX35CUFACN5H6LRUH6RVV47XO
X-Message-ID-Hash: 42HPN23GX35CUFACN5H6LRUH6RVV47XO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/42HPN23GX35CUFACN5H6LRUH6RVV47XO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When a function is called which reallocated the skbuff, it is necessary to
reacquire the pointers into the skb data. Otherwise they might cause an
use-after-free.

But is hard to identify such case when it is not clear that helpers are
actually using skb-reallocating functions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 10 +++++++++
 net/batman-adv/distributed-arp-table.c | 40 ++++++++++++++++++++++++++++++++++
 net/batman-adv/gateway_client.c        |  6 ++++-
 net/batman-adv/main.c                  |  5 +++++
 net/batman-adv/routing.c               |  5 +++++
 5 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index fe2618b5..bf9593ca 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1087,6 +1087,11 @@ static int batadv_check_claim_group(struct batadv_priv *bat_priv,
  * @primary_if: the primary hard interface of this batman mesh interface
  * @skb: the frame to be checked
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if it was a claim frame, otherwise return false to
  * tell the callee that it can use the frame on its own.
  */
@@ -1820,6 +1825,11 @@ bool batadv_bla_is_backbone_gw_orig(struct batadv_priv *bat_priv, u8 *orig,
  * @orig_node: the orig_node of the frame
  * @hdr_size: maximum length of the frame
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull() and batadv_get_vid(). Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the orig_node is also a gateway on the mesh interface,
  * otherwise it returns false.
  */
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 7221d569..f1066db8 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1064,6 +1064,11 @@ int batadv_dat_cache_dump(struct sk_buff *msg, struct netlink_callback *cb)
  * @skb: packet to analyse
  * @hdr_size: size of the possible header before the ARP packet in the skb
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull(). Any pointer into the skb data (e.g. obtained from skb->data
+ * or eth_hdr()) before this call must be considered invalid afterwards and has
+ * to be reacquired.
+ *
  * Return: the ARP type if the skb contains a valid ARP packet, 0 otherwise.
  */
 static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
@@ -1139,6 +1144,11 @@ static u16 batadv_arp_get_type(struct batadv_priv *bat_priv,
  * @skb: the buffer containing the packet to extract the VID from
  * @hdr_size: the size of the batman-adv header encapsulating the packet
  *
+ * Warning: This function calls batadv_get_vid() and may therefore reallocate
+ * the skb data buffer. Any pointer into the skb data (e.g. obtained from
+ * skb->data or eth_hdr()) before this call must be considered invalid
+ * afterwards and has to be reacquired.
+ *
  * Return: If the packet embedded in the skb is vlan tagged this function
  * returns the VID with the BATADV_VLAN_HAS_TAG flag. Otherwise BATADV_NO_FLAGS
  * is returned.
@@ -1201,6 +1211,11 @@ batadv_dat_arp_create_reply(struct batadv_priv *bat_priv, __be32 ip_src,
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the message has been sent to the dht candidates, false
  * otherwise. In case of a positive return value the message has to be enqueued
  * to permit the fallback.
@@ -1300,6 +1315,11 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the request has been answered, false otherwise.
  */
 bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
@@ -1367,6 +1387,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
  * batadv_dat_snoop_outgoing_arp_reply() - snoop the ARP reply and fill the DHT
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: packet to check
+ *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
  */
 void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
@@ -1414,6 +1439,11 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
  * @skb: packet to check
  * @hdr_size: size of the encapsulation header
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the packet was snooped and consumed by DAT. False if the
  * packet has to be delivered to the interface
  */
@@ -1817,6 +1847,11 @@ void batadv_dat_snoop_outgoing_dhcp_ack(struct batadv_priv *bat_priv,
  * This function first checks whether the given skb is a valid DHCPACK. If
  * so then its source MAC and IP as well as its DHCP Client Hardware Address
  * field and DHCP Your IP Address field are added to the local DAT cache.
+ *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull()/batadv_dat_get_vid(). Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
  */
 void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
 					struct sk_buff *skb, int hdr_size)
@@ -1865,6 +1900,11 @@ void batadv_dat_snoop_incoming_dhcp_ack(struct batadv_priv *bat_priv,
  * @bat_priv: the bat priv with all the mesh interface information
  * @forw_packet: the broadcast packet
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_dat_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the node can drop the packet, false otherwise.
  */
 bool batadv_dat_drop_broadcast_packet(struct batadv_priv *bat_priv,
diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index bc69f2ba..0dfbd3f5 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -679,7 +679,11 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
  * server. Due to topology changes it may be the case that the GW server
  * previously selected is not the best one anymore.
  *
- * This call might reallocate skb data.
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_get_vid(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Must be invoked only when the DHCP packet is going TO a DHCP SERVER.
  *
  * Return: true if the packet destination is unicast and it is not the best gw,
diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 9a9d882a..95ad4f41 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -612,6 +612,11 @@ void batadv_recv_handler_unregister(u8 packet_type)
  * @skb: the buffer containing the packet
  * @header_len: length of the batman header preceding the ethernet header
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull(). Any pointer into the skb data (e.g. obtained from skb->data
+ * or eth_hdr()) before this call must be considered invalid afterwards and has
+ * to be reacquired.
+ *
  * Return: VID with the BATADV_VLAN_HAS_TAG flag when the packet embedded in the
  * skb is vlan tagged. Otherwise BATADV_NO_FLAGS.
  */
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 7d9a2b59..cd290a7b 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -871,6 +871,11 @@ batadv_reroute_unicast_packet(struct batadv_priv *bat_priv, struct sk_buff *skb,
  * @skb: the unicast packet to check
  * @hdr_len: length of the unicast header preceding the payload
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * pskb_may_pull() and batadv_get_vid(). Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: true if the packet may be processed further, false if it has been
  *  consumed or has to be dropped by the caller
  */

-- 
2.47.3

