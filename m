Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15619CC6B2F
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 06:33:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 703F4824B5
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 08:33:13 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792045993;
 b=zs5DqjY/FytQRFPFacxgXDy5wqb6h7+NXNQFwm4bDvYwLRyIkIYE4ZZu2e7//Y2shMCgd
 rmPmadsqlMaCYzC3jQ8P1gf5tsOx8oZV2wLncvscEDBVZVFdCNCJdWiGUEYCuGgWi7XVBF1
 ZxaPzS0JhNaonHemwox9ILDFys7rlPg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792045993; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sjjvCr+tGsAk+xgGRsCb6YyxAX/BeNP3FxuXx/GlVAo=;
 b=g941zY8KSXpx5ONdVw4aBMKkxVa3Uo6FA0ipkkxRskVvdZvo5O31kmETYwKb9AsmJyTLJ
 2cg2l7trwlyScDytwzkQdeC2sWsPfT15+YlOOPkqivoTya/L79JbO/HulK0r1XNr9iUQJnC
 cq6+i0+Vs6cJHD2l4pA0eZL7y8UqBKA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8799D81E9F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 15 Oct 2026 08:31:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792045900;
	b=VgE/pNCpW82LvJRoyzceM8cko39Zt38KMkPe3jsFc07A+Z5GrV0+wCPw1QN9gA/jJfmrnP
	a3Rdgbu2yJn4aOmDtOAcaDK8Pzty1LM2kZC6p62PBn8cmlmd0IZeKGfUAX7+UmOgUH7Yl3
	Nv4sFA8kbE6M+SNnK5g2r5ur/z2eReY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792045900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=sjjvCr+tGsAk+xgGRsCb6YyxAX/BeNP3FxuXx/GlVAo=;
	b=Xe5AWfeL+opVfQoseOCjvnRx8o4Z3QjNl8Lksog4Wo8gtNMdq4098zdrAIleiLeOlpIQ/z
	dR8qr/jQG7M+2wkq1GzbjKl7v9Ty79YlzIJooI4n38HOpmYGpE4B6ZA//dMPd4nHWMehfP
	E2ycLjpE91+cDd/RIUqmfk8FxwuC7cQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=cSQwdteV;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id EE03320320;
	Thu, 15 Oct 2026 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792045890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sjjvCr+tGsAk+xgGRsCb6YyxAX/BeNP3FxuXx/GlVAo=;
	b=cSQwdteVHTIMTKKNhf4q1W4kHRaQcGDihO31/STZ7JqGr+OG7vZWuyMCLoju1oaPgh9g9G
	4irR0n6XsMSc62mq+7qxD9y8xUHtZlGgSMmYcFmEKFdnHnEhMIim2ZOPnUZYCUH+QecfHA
	cd0WpQ0d9soe6okk01l2gYuyUQ7/vtA=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 15 Oct 2026 08:31:03 +0200
Subject: [PATCH RESEND batadv 3/4] batman-adv: split fragment forwarding
 into lookup and forward
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-skb-ownership-v1-3-8bb03bba6701@narfation.org>
References: <20261015-skb-ownership-v1-0-8bb03bba6701@narfation.org>
In-Reply-To: <20261015-skb-ownership-v1-0-8bb03bba6701@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7128; i=sven@narfation.org;
 h=from:subject:message-id; bh=GO9fsMywXIh3ikv/3B99Yfjjp8xGDTny5+9+HJrVoOM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkXinXe9b6+OpW79Me2NbMT8+uaRYJzkvQS53PIOlrkC
 rs8uVjeUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjIf2OG/5H+V3bv0GTa264o
 VrH++eLXgeae7Dbq3EYfRa6kqanPEmH477lYNlH16abOyZbbFNk1b/i46uax3BYT7zlzTugS4/y
 PvAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: DBILXXZSBN2BOXOZJDJA2JGP3VDTWZ5E
X-Message-ID-Hash: DBILXXZSBN2BOXOZJDJA2JGP3VDTWZ5E
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DBILXXZSBN2BOXOZJDJA2JGP3VDTWZ5E/>
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

