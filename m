Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718B5CC6B27
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 08:54:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B1AC584399
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 10:54:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791968068;
 b=fvB3aecz67Vn3r9HKCd+s/0rYC32H3HQ7WeCgO7UbvhVMqDOLeTe+GqHtE4VvH4DEXO6Z
 AvpL7byWscw8XaUTt2g2Lv6rYopbdme8vPm/iAXTd/MM941n/i1MFw7fFJ9wYJSXzKdUwId
 6t8iNJkBjBbhFwbiDNgX2fG1D/sCBWs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791968068; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sjjvCr+tGsAk+xgGRsCb6YyxAX/BeNP3FxuXx/GlVAo=;
 b=27Ta/tQRpOER2c0BzEsloF3pLWLMY5LfradLpPUPN5N2i7oVFtG8H6gpsnU0WUQMc2HH4
 GI91iNL6VRr9EDROZFM6lP2XG+i8xUw15Qc+SkwrPUTiW9RXiNY9GIfAZli1xY+vL+pxZ6K
 /Bt3Qw8wV5ol+5CR3NekMyvqso6edCI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9DFEA814BA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 14 Oct 2026 10:54:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791968058;
	b=Ubor0UH8ftCJVTO1wLUhbjA1TxgQnul7fIvcfAPCoeegICs9lUF6OCaxok/Unbc7RFb/PS
	oagJAJKFkwOZxr27gQ4EzI4n3k809uqdDZly5HsGNM7QB14a+GqXPyyDNTOTab/KHOK+L7
	I2Dpzm0zUorZl576BYjo/BZi0A2zAqg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791968058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sjjvCr+tGsAk+xgGRsCb6YyxAX/BeNP3FxuXx/GlVAo=;
	b=y22UGvgX0ag8h0hDQnHjtcM981A5oRp29We1MBWpKP2bJDBpUwGGW58NgcNXqxuTwmU0Hk
	Jh2+yLgiC89RyaazcnjnR2+EnGCKjIjx+AygDbryaA0rCyg5u5pXKEAj2luw3EMJGA+ZFD
	4ZVUO3olQnJLMXDPrFado1oM1twHvqg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=kY9053Hq;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 6DC1A20EF2;
	Wed, 14 Oct 2026 08:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791968057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjjvCr+tGsAk+xgGRsCb6YyxAX/BeNP3FxuXx/GlVAo=;
	b=kY9053HqqAyC4MaQ0xCNZZv5P3dbS6atoeC1pU5ScXmK9rVV+ipKEHRFN6tY7vVGw45wby
	+icn6/iJhi5ys/7FU78vwXmEDr51BK3LSSI3PpAdh0m+RnpD5CPfqiZbOqXMR0SG0v9yfa
	iEoTmRhzcXPfcbmg4JQKm0MlT6J6ozw=
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Oct 2026 10:54:04 +0200
Subject: [PATCH batadv 3/4] batman-adv: split fragment forwarding into
 lookup and forward
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-skb-ownership-v1-3-4b83b9206b65@narfation.org>
References: <20261014-skb-ownership-v1-0-4b83b9206b65@narfation.org>
In-Reply-To: <20261014-skb-ownership-v1-0-4b83b9206b65@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7128; i=sven@narfation.org;
 h=from:subject:message-id; bh=GO9fsMywXIh3ikv/3B99Yfjjp8xGDTny5+9+HJrVoOM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnnfW/uM1nzpK+c1TY5R7b0zNTGq1atTUsPax5kkMVL
 NVWcph3lLIwiHExyIopsuy5kn9+M/tb+c/TPh6FmcPKBDKEgYtTACay+jsjw+OvbzPFPvNlZNvY
 vzlz/rW14NkznJs/d85/L3X+Wthh62qG/9XCGsKTn+iVnvw8uY75qvvtpUmm5zrPTH0hnK+46qN
 hHzMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: R4XNMMTCY5XFCY5G63CKWFKSKB65R7VQ
X-Message-ID-Hash: R4XNMMTCY5XFCY5G63CKWFKSKB65R7VQ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/R4XNMMTCY5XFCY5G63CKWFKSKB65R7VQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_frag_skb_fwd() consumed the skb only when it returned true, and
passed the receive result back through an out-parameter that was only
valid in that case.

To ensure that the forwarding functions either borrow or consume the skb,
split it into:

* batadv_frag_fwd_neigh_get(): borrows the skb and returns the next-hop
  (with a reference) when the merged packet would exceed its MTU
* batadv_frag_skb_fwd(): always consumes the skb and returns
  NET_RX_SUCCESS or NET_RX_DROP (instead of using the out-parameter
  "rx_result")

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 105 ++++++++++++++++++++++-------------------
 net/batman-adv/fragmentation.h |   9 ++--
 net/batman-adv/routing.c       |  15 ++++--
 3 files changed, 72 insertions(+), 57 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 493af309..9025d5f6 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -385,70 +385,79 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
 }
 
 /**
- * batadv_frag_skb_fwd() - forward fragments that would exceed MTU when merged
- * @skb: skb to forward
+ * batadv_frag_fwd_neigh_get() - get next-hop for fragments that would exceed
+ *  MTU when merged
+ * @skb: received fragment
  * @recv_if: interface that the skb is received on
- * @orig_node_src: originator that the skb is received from
- * @rx_result: set to NET_RX_SUCCESS when the fragment was forwarded and
- *  NET_RX_DROP when it was dropped; only valid when true is returned
  *
  * Look up the next-hop of the fragments payload and check if the merged packet
- * will exceed the MTU towards the next-hop. If so, the fragment is forwarded
- * without merging it.
+ * will exceed the MTU towards the next-hop.
  *
- * Return: true if the fragment is consumed/forwarded, false otherwise.
+ * Return: the next-hop neighbor (with increased refcounter) when the fragment
+ * has to be forwarded without merging it, NULL otherwise
  */
-bool batadv_frag_skb_fwd(struct sk_buff *skb,
-			 struct batadv_hard_iface *recv_if,
-			 struct batadv_orig_node *orig_node_src,
-			 int *rx_result)
+struct batadv_neigh_node *
+batadv_frag_fwd_neigh_get(const struct sk_buff *skb,
+			  struct batadv_hard_iface *recv_if)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
-	struct batadv_neigh_node *neigh_node = NULL;
-	struct batadv_frag_packet *packet;
-	bool ret = false;
+	const struct batadv_frag_packet *packet;
+	struct batadv_neigh_node *neigh_node;
 	u16 total_size;
 
-	packet = (struct batadv_frag_packet *)skb->data;
+	packet = (const struct batadv_frag_packet *)skb->data;
 
 	neigh_node = batadv_orig_to_router(bat_priv, packet->dest, recv_if);
 	if (!neigh_node)
-		goto out;
+		return NULL;
 
-	/* Forward the fragment, if the merged packet would be too big to
-	 * be assembled.
-	 */
 	total_size = ntohs(packet->total_size);
-	if (total_size > neigh_node->if_incoming->net_dev->mtu) {
-		if (packet->ttl < 2) {
-			kfree_skb(skb);
-			*rx_result = NET_RX_DROP;
-			ret = true;
-			goto out;
-		}
-
-		if (skb_cow(skb, ETH_HLEN) < 0) {
-			kfree_skb(skb);
-			*rx_result = NET_RX_DROP;
-			ret = true;
-			goto out;
-		}
-
-		packet = (struct batadv_frag_packet *)skb->data;
-
-		batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_FWD);
-		batadv_add_counter(bat_priv, BATADV_CNT_FRAG_FWD_BYTES,
-				   skb->len + ETH_HLEN);
-
-		packet->ttl--;
-		batadv_send_unicast_skb(skb, neigh_node);
-		*rx_result = NET_RX_SUCCESS;
-		ret = true;
+	if (total_size <= neigh_node->if_incoming->net_dev->mtu) {
+		batadv_neigh_node_put(neigh_node);
+		return NULL;
 	}
 
-out:
-	batadv_neigh_node_put(neigh_node);
-	return ret;
+	return neigh_node;
+}
+
+/**
+ * batadv_frag_skb_fwd() - forward fragment without merging it
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @skb: skb to forward
+ * @neigh_node: next-hop to forward the fragment to
+ *
+ * The skb is always consumed by this function.
+ *
+ * Return: NET_RX_SUCCESS when the fragment was forwarded and NET_RX_DROP when
+ * it was dropped
+ */
+int batadv_frag_skb_fwd(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			struct batadv_neigh_node *neigh_node)
+{
+	struct batadv_frag_packet *packet;
+
+	packet = (struct batadv_frag_packet *)skb->data;
+
+	if (packet->ttl < 2)
+		goto free_skb;
+
+	if (skb_cow(skb, ETH_HLEN) < 0)
+		goto free_skb;
+
+	packet = (struct batadv_frag_packet *)skb->data;
+
+	batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_FWD);
+	batadv_add_counter(bat_priv, BATADV_CNT_FRAG_FWD_BYTES,
+			   skb->len + ETH_HLEN);
+
+	packet->ttl--;
+	batadv_send_unicast_skb(skb, neigh_node);
+
+	return NET_RX_SUCCESS;
+
+free_skb:
+	kfree_skb(skb);
+	return NET_RX_DROP;
 }
 
 /**
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index 51e28102..3c98a4f8 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -17,10 +17,11 @@
 
 void batadv_frag_purge_orig(struct batadv_orig_node *orig,
 			    bool (*check_cb)(struct batadv_frag_table_entry *));
-bool batadv_frag_skb_fwd(struct sk_buff *skb,
-			 struct batadv_hard_iface *recv_if,
-			 struct batadv_orig_node *orig_node_src,
-			 int *rx_result);
+struct batadv_neigh_node * __must_check
+batadv_frag_fwd_neigh_get(const struct sk_buff *skb,
+			  struct batadv_hard_iface *recv_if);
+int batadv_frag_skb_fwd(struct batadv_priv *bat_priv, struct sk_buff *skb,
+			struct batadv_neigh_node *neigh_node);
 bool batadv_frag_skb_buffer(struct sk_buff **skb,
 			    struct batadv_orig_node *orig_node);
 int batadv_frag_send_packet(struct sk_buff *skb,
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index b4172a6e..a6f532c6 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1206,6 +1206,7 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_orig_node *orig_node_src = NULL;
 	struct batadv_frag_packet *frag_packet;
+	struct batadv_neigh_node *neigh_node;
 	int ret = NET_RX_DROP;
 
 	if (batadv_check_unicast_packet(bat_priv, skb,
@@ -1220,11 +1221,15 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 	skb->priority = frag_packet->priority + 256;
 
 	/* Route the fragment if it is not for us and too big to be merged. */
-	if (!batadv_is_my_mac(bat_priv, frag_packet->dest) &&
-	    batadv_frag_skb_fwd(skb, recv_if, orig_node_src, &ret)) {
-		/* skb was consumed */
-		skb = NULL;
-		goto put_orig_node;
+	if (!batadv_is_my_mac(bat_priv, frag_packet->dest)) {
+		neigh_node = batadv_frag_fwd_neigh_get(skb, recv_if);
+		if (neigh_node) {
+			ret = batadv_frag_skb_fwd(bat_priv, skb, neigh_node);
+			batadv_neigh_node_put(neigh_node);
+			/* skb was consumed */
+			skb = NULL;
+			goto put_orig_node;
+		}
 	}
 
 	batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_RX);

-- 
2.47.3

