Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD854CD98CE
	for <batman-adv@archiver.kernel.org>; Fri, 12 Jun 2026 13:05:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 331FE808EC
	for <batman-adv@archiver.kernel.org>; Fri, 12 Jun 2026 15:05:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781269521;
 b=EgsMwnsFtMh4xBPfoYPt0xxcA5ZY0Q7yFLGG5cvNG0pze/WP7x2bc2V/IIZbAkg89sF4b
 MoSfbs8LmXfePLqd2KtagBvE8IAFrrBSVw6Elg+oGV6XtlmSZRrNhiPojeRFNspAokJXmGo
 qIDlteqORUfSUNj8H0SlrXG7VF58kxM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781269521; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=YnAjdmQoJFL4JbO9LBqxhbITDyGw18+zTBj2xflzwkQ=;
 b=oblWvbjfsLBiYDkeNvWD87EUvgTZFqrxFz0nnrqQiiT1tNFOxD6BksPXe/9FFdtvB3mIi
 sZ6NPUxVJ/iR2YkHFUNEzxIoAUbQ02iQf0qgtEZMCxnslhW5yCMV9fLamYeX87CeYAoHwX4
 dIVeQcm5kUAgwwqW0lIllgbwwqCAfEM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 8AD9E80DBB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 12 Jun 2026 15:04:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781269469;
	b=XzmVqrdBgxXlKw4OZL5KlfazCd/TeSshcHHxxyzuHLGe70+Ql/ThxuQ23IMkeubpQYgwxR
	+AOfvYSY5zrFTsY6m9MZkUP3IvEBLz2aM9ef8hhJfW971qVrwglINsVM0njGjbBezx1Q9u
	ohIUD+m5Xws6np5aSWYAskDJ1N/qdWU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781269469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=YnAjdmQoJFL4JbO9LBqxhbITDyGw18+zTBj2xflzwkQ=;
	b=i1N0e9tYXPcF186mpjF5YS+8oZ+2o2X5XFhwdThIMVlAaKZSM4dJRD3bGLsBa3dxu5xdh7
	228ALcUG9Qyi1mZv0YrSPSU7ZfO0QkkWtG5xdBG4x5fCMEDen1RlxZum2eaBRgUp5mzeS6
	8GhgzrPfRGCIyvJGOziDh1IY39wUedo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=YWmt8WX2;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 5003E200FB;
	Fri, 12 Jun 2026 13:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781269469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YnAjdmQoJFL4JbO9LBqxhbITDyGw18+zTBj2xflzwkQ=;
	b=YWmt8WX2VLnwDRn/ZMX46CyNo28FQKvX5VPY8coOw7TYNXVs+ssYwHTTrcXuRIAJv94HfD
	oi6/iF6ONitm80056oh/IbtS7HZVBQkL/GVg0GIV7R6JP0jGzXCW6aHfFyLG/qTsizshZZ
	CZ8QSv3fu7c4pIkOQLsrE1rvhI7WW4M=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 12 Jun 2026 15:04:23 +0200
Subject: [PATCH batadv 1/3] batman-adv: frag: ensure fragment is writable
 before modifying TTL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-frag-ttl-v1-1-6b2f4dd9d5b6@narfation.org>
References: <20260612-frag-ttl-v1-0-6b2f4dd9d5b6@narfation.org>
In-Reply-To: <20260612-frag-ttl-v1-0-6b2f4dd9d5b6@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3749; i=sven@narfation.org;
 h=from:subject:message-id; bh=WDRsCT/Eg46VugyNZkILzF9yKyVIlLC5fXAP+0oYUHg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFk6zDd2xD39dmBn9qYA/j7H7TXqV58/PD+lgSM7tXPXI
 nktQ5PYjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEJnMx/GKKXvrN9byfgcm1
 U5c7E8908Ky/+KorL/F4+Zv5UV+Vbu1gZGiKLuCYrpujM0/2dOJBxWu/L094u+xSzzshXd248wz
 9IpwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 7BO7JYBENUXLNWLAR6QMAL5GUXMG7ZN7
X-Message-ID-Hash: 7BO7JYBENUXLNWLAR6QMAL5GUXMG7ZN7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7BO7JYBENUXLNWLAR6QMAL5GUXMG7ZN7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Before batman-adv is allowed to write to an skb, it either has to have its
own copy of the skb or use skb_cow() to ensure that the data part is not
shared. But batadv_frag_skb_fwd() modifies the TTL even when it is shared.

Adding a skb_cow() right before this operation avoids this and can at the
same time prepare it for the modifications required to forward the
fragment.

Fixes: 9b3eab61754d ("batman-adv: Receive fragmented packets and merge")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/fragmentation.c | 15 ++++++++++++++-
 net/batman-adv/fragmentation.h |  3 ++-
 net/batman-adv/routing.c       |  3 +--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 1e42cf99..f311a422 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -386,6 +386,8 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
  * @skb: skb to forward
  * @recv_if: interface that the skb is received on
  * @orig_node_src: originator that the skb is received from
+ * @rx_result: set to NET_RX_SUCCESS when the fragment was forwarded and
+ *  NET_RX_DROP when it was dropped; only valid when true is returned
  *
  * Look up the next-hop of the fragments payload and check if the merged packet
  * will exceed the MTU towards the next-hop. If so, the fragment is forwarded
@@ -395,7 +397,8 @@ bool batadv_frag_skb_buffer(struct sk_buff **skb,
  */
 bool batadv_frag_skb_fwd(struct sk_buff *skb,
 			 struct batadv_hard_iface *recv_if,
-			 struct batadv_orig_node *orig_node_src)
+			 struct batadv_orig_node *orig_node_src,
+			 int *rx_result)
 {
 	struct batadv_priv *bat_priv = netdev_priv(recv_if->mesh_iface);
 	struct batadv_neigh_node *neigh_node = NULL;
@@ -414,12 +417,22 @@ bool batadv_frag_skb_fwd(struct sk_buff *skb,
 	 */
 	total_size = ntohs(packet->total_size);
 	if (total_size > neigh_node->if_incoming->net_dev->mtu) {
+		if (skb_cow(skb, ETH_HLEN) < 0) {
+			kfree_skb(skb);
+			*rx_result = NET_RX_DROP;
+			ret = true;
+			goto out;
+		}
+
+		packet = (struct batadv_frag_packet *)skb->data;
+
 		batadv_inc_counter(bat_priv, BATADV_CNT_FRAG_FWD);
 		batadv_add_counter(bat_priv, BATADV_CNT_FRAG_FWD_BYTES,
 				   skb->len + ETH_HLEN);
 
 		packet->ttl--;
 		batadv_send_unicast_skb(skb, neigh_node);
+		*rx_result = NET_RX_SUCCESS;
 		ret = true;
 	}
 
diff --git a/net/batman-adv/fragmentation.h b/net/batman-adv/fragmentation.h
index dbf0871f..51e28102 100644
--- a/net/batman-adv/fragmentation.h
+++ b/net/batman-adv/fragmentation.h
@@ -19,7 +19,8 @@ void batadv_frag_purge_orig(struct batadv_orig_node *orig,
 			    bool (*check_cb)(struct batadv_frag_table_entry *));
 bool batadv_frag_skb_fwd(struct sk_buff *skb,
 			 struct batadv_hard_iface *recv_if,
-			 struct batadv_orig_node *orig_node_src);
+			 struct batadv_orig_node *orig_node_src,
+			 int *rx_result);
 bool batadv_frag_skb_buffer(struct sk_buff **skb,
 			    struct batadv_orig_node *orig_node);
 int batadv_frag_send_packet(struct sk_buff *skb,
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index cd4368b8..46ba1c47 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1114,10 +1114,9 @@ int batadv_recv_frag_packet(struct sk_buff *skb,
 
 	/* Route the fragment if it is not for us and too big to be merged. */
 	if (!batadv_is_my_mac(bat_priv, frag_packet->dest) &&
-	    batadv_frag_skb_fwd(skb, recv_if, orig_node_src)) {
+	    batadv_frag_skb_fwd(skb, recv_if, orig_node_src, &ret)) {
 		/* skb was consumed */
 		skb = NULL;
-		ret = NET_RX_SUCCESS;
 		goto put_orig_node;
 	}
 

-- 
2.47.3

