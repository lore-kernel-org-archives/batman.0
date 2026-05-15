Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C82DCD4F25
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 16:04:46 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5881585E40
	for <batman@archiver.kernel.org>; Fri, 15 May 2026 18:04:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778861084;
 b=xb8DZBUg+KJtp+XEsMiWDEyO7qsnlbPVvLkDQU07dqwSVBQZthC+vfnY/qBPSns/yfsEC
 wvS6SmLYOKXITGQUAKOQ7QCuZLEWH5SmLu9tg2nWOs3gkWrNfkR/6qmUXd+Uxfrxig4ZfFw
 lTcpdnQo2P3qgV0E+9dgocqmhVb7OXE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778861084; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qkw7JcNHg8L47kR6Okb4Edyxqi32RMGCre9k3zoQml8=;
 b=HyKxAOYSr2u84ZjGw9tDgT7F9XYO1xnbU/BxX9ZAmxYOCISg1zik4JYL2MerghJQcNbC5
 /UQjWtJP2CpoG+C8Dr2PpAiZ3oSJHAdGJ/c3bGHDj6+Z8/GPIRY43r86g8UevhCfMwLj0ef
 i1iH5GTKB2BGwxxpkaYjhGYBFjnzI70=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DC7B985A5E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 May 2026 18:01:31 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778860891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qkw7JcNHg8L47kR6Okb4Edyxqi32RMGCre9k3zoQml8=;
	b=BiecQPwR0F+NFsKtE0DDpCwJyMUxYcRMQLsXob2c3EGsq/jm+hoNGdgzir+0NFB1/3sZKb
	PLDzzBrXbXcg0g5yumwDMk8oQHCvcPZ86xnF5Jnw938tgM/wT3q5ABvOSG/WZ7amQ4plS+
	K6CCRrqbq+QOGmZ6j48ywtY0EjV0sFw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mS9o+HKM;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778860891;
	b=rEc0qA9VFRZHQ5bsJIG7gWAg8Y+am4H53TCHK/HRDww70c1XoYD+WQ5mIu3N1PzCz1Qmww
	X5aGCZmMzqEIW0C1Rk28UV70g5E2p2hxtuOsBFtgUgNawaSTTAUdocjvCs7nvWeQ9mbWaj
	MKNQksxc3YeHoJC5zH+XxuDzBvVN/rw=
Received: by dvalin.narfation.org (Postfix) id 809061FD98;
	Fri, 15 May 2026 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778860891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qkw7JcNHg8L47kR6Okb4Edyxqi32RMGCre9k3zoQml8=;
	b=mS9o+HKMB2fhJ8rhOBYgrhGljxZa7nHLTgS059vYihtGT9rf0bNQwOliu0WBB3Dw9jqkFP
	MfXrDGC1cITdCkwWOhdkLbD+vtWzRkJvWVGwNvX47n3erb1RpTZfoxMFaUozJvSURFJt1G
	XlNudg9j6XzJM75+qbnZZicGCoRwsc4=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 15 May 2026 18:00:13 +0200
Subject: [PATCH batadv v3 4/4] batman-adv: tvlv: avoid unnecessary OGM
 buffer reallocations
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-yuantan098-bugfixes-v3-4-5a5a91924562@narfation.org>
References: <20260515-yuantan098-bugfixes-v3-0-5a5a91924562@narfation.org>
In-Reply-To: <20260515-yuantan098-bugfixes-v3-0-5a5a91924562@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Yuan Tan <yuantan098@gmail.com>, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=15658; i=sven@narfation.org;
 h=from:subject:message-id; bh=EfP8EhNgYcdxidFv/eltVHTNatujtJMdk0++b3B0k5M=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnszubfzndIVEYGatv/tsx43Zagabspp/X9XJcnAhHy0
 YIeDKs7SlkYxLgYZMUUWfZcyT+/mf2t/OdpH4/CzGFlAhnCwMUpABPRuMHI8Eqs/cjta//nHFig
 2TpfJLL5b6J6Z6/LsiWmtmw3lqdt2cnwV3ah/5e9fy4umcke+2Clzr5bUfM5vR0/hprcnHjnCYP
 9OS4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: FCNLU7V2OGBQXT6EFKJ4CYYAE32FHE5O
X-Message-ID-Hash: FCNLU7V2OGBQXT6EFKJ4CYYAE32FHE5O
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FCNLU7V2OGBQXT6EFKJ4CYYAE32FHE5O/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Both OGMv1 (on the primary interface) and OGM2 unconditionally reallocated
their packet buffer on every transmission cycle, regardless of whether the
required size had changed. This meant a kfree/kmalloc pair even when the
TVLV payload size was identical to the previous send.

Introduce struct batadv_ogm_buf to encapsulate the OGM packet buffer
together with its current length, allocated capacity, and fixed header
length. This consolidates the separate buf/len arguments that were
previously threaded through each call site.

In batadv_tvlv_realloc_packet_buff(), the capacity is rounded up to the
next power of two so that small growth or shrinkage in TVLV data does not
trigger a reallocation. When kmalloc fails but the existing buffer is large
enough to hold the new data, the oversized buffer is reused rather than
returning an error.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 37 +++++++++++++++---------------
 net/batman-adv/bat_v_ogm.c  | 30 ++++++++++++------------
 net/batman-adv/tvlv.c       | 56 ++++++++++++++++++++++++++-------------------
 net/batman-adv/tvlv.h       |  3 +--
 net/batman-adv/types.h      | 31 +++++++++++++++++--------
 5 files changed, 88 insertions(+), 69 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 8889d465..9e56376b 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -194,14 +194,17 @@ static int batadv_iv_ogm_iface_enable(struct batadv_hard_iface *hard_iface)
 	get_random_bytes(&random_seqno, sizeof(random_seqno));
 	atomic_set(&hard_iface->bat_iv.ogm_seqno, random_seqno);
 
-	hard_iface->bat_iv.ogm_buff_len = BATADV_OGM_HLEN;
-	ogm_buff = kmalloc(hard_iface->bat_iv.ogm_buff_len, GFP_ATOMIC);
+	hard_iface->bat_iv.ogm_buff.len = BATADV_OGM_HLEN;
+	hard_iface->bat_iv.ogm_buff.capacity = BATADV_OGM_HLEN;
+	hard_iface->bat_iv.ogm_buff.header_length = BATADV_OGM_HLEN;
+
+	ogm_buff = kmalloc(hard_iface->bat_iv.ogm_buff.capacity, GFP_ATOMIC);
 	if (!ogm_buff) {
 		mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
 		return -ENOMEM;
 	}
 
-	hard_iface->bat_iv.ogm_buff = ogm_buff;
+	hard_iface->bat_iv.ogm_buff.buf = ogm_buff;
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)ogm_buff;
 	batadv_ogm_packet->packet_type = BATADV_IV_OGM;
@@ -220,8 +223,9 @@ static void batadv_iv_ogm_iface_disable(struct batadv_hard_iface *hard_iface)
 {
 	mutex_lock(&hard_iface->bat_iv.ogm_buff_mutex);
 
-	kfree(hard_iface->bat_iv.ogm_buff);
-	hard_iface->bat_iv.ogm_buff = NULL;
+	kfree(hard_iface->bat_iv.ogm_buff.buf);
+	memset(&hard_iface->bat_iv.ogm_buff, 0,
+	       sizeof(hard_iface->bat_iv.ogm_buff));
 
 	mutex_unlock(&hard_iface->bat_iv.ogm_buff_mutex);
 }
@@ -233,7 +237,7 @@ static void batadv_iv_ogm_iface_update_mac(struct batadv_hard_iface *hard_iface)
 
 	mutex_lock(&hard_iface->bat_iv.ogm_buff_mutex);
 
-	ogm_buff = hard_iface->bat_iv.ogm_buff;
+	ogm_buff = hard_iface->bat_iv.ogm_buff.buf;
 	if (!ogm_buff)
 		goto unlock;
 
@@ -255,7 +259,7 @@ batadv_iv_ogm_primary_iface_set(struct batadv_hard_iface *hard_iface)
 
 	mutex_lock(&hard_iface->bat_iv.ogm_buff_mutex);
 
-	ogm_buff = hard_iface->bat_iv.ogm_buff;
+	ogm_buff = hard_iface->bat_iv.ogm_buff.buf;
 	if (!ogm_buff)
 		goto unlock;
 
@@ -782,10 +786,9 @@ batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_iface)
 static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 {
 	struct batadv_priv *bat_priv = netdev_priv(hard_iface->mesh_iface);
-	unsigned char **ogm_buff = &hard_iface->bat_iv.ogm_buff;
+	struct batadv_ogm_buf *ogm_buff = &hard_iface->bat_iv.ogm_buff;
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	struct batadv_hard_iface *primary_if, *tmp_hard_iface;
-	int *ogm_buff_len = &hard_iface->bat_iv.ogm_buff_len;
 	struct list_head *iter;
 	u32 seqno;
 	u16 tvlv_len = 0;
@@ -795,7 +798,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	lockdep_assert_held(&hard_iface->bat_iv.ogm_buff_mutex);
 
 	/* interface already disabled by batadv_iv_ogm_iface_disable */
-	if (!*ogm_buff)
+	if (!ogm_buff->buf)
 		return;
 
 	/* the interface gets activated here to avoid race conditions between
@@ -814,16 +817,14 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		 * appended as it may alter the tt tvlv container
 		 */
 		batadv_tt_local_commit_changes(bat_priv);
-		ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
-						       ogm_buff_len,
-						       BATADV_OGM_HLEN);
+		ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff);
 		if (ret < 0)
 			goto out;
 
 		tvlv_len = ret;
 	}
 
-	batadv_ogm_packet = (struct batadv_ogm_packet *)(*ogm_buff);
+	batadv_ogm_packet = ogm_buff->buf;
 	batadv_ogm_packet->tvlv_len = htons(tvlv_len);
 
 	/* change sequence number to network order */
@@ -839,7 +840,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		/* OGMs from secondary interfaces are only scheduled on their
 		 * respective interfaces.
 		 */
-		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff, *ogm_buff_len,
+		batadv_iv_ogm_queue_add(bat_priv, ogm_buff->buf, ogm_buff->len,
 					hard_iface, hard_iface, 1, send_time);
 		goto out;
 	}
@@ -852,9 +853,9 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		if (!kref_get_unless_zero(&tmp_hard_iface->refcount))
 			continue;
 
-		batadv_iv_ogm_queue_add(bat_priv, *ogm_buff,
-					*ogm_buff_len, hard_iface,
-					tmp_hard_iface, 1, send_time);
+		batadv_iv_ogm_queue_add(bat_priv, ogm_buff->buf, ogm_buff->len,
+					hard_iface, tmp_hard_iface, 1,
+					send_time);
 
 		batadv_hardif_put(tmp_hard_iface);
 	}
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index d66ca77b..104e165e 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -268,10 +268,9 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 {
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
+	struct batadv_ogm_buf *ogm_buff;
 	struct sk_buff *skb, *skb_tmp;
-	unsigned char **ogm_buff;
 	struct list_head *iter;
-	int *ogm_buff_len;
 	u16 tvlv_len;
 	int ret;
 
@@ -281,26 +280,23 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 		goto out;
 
 	ogm_buff = &bat_priv->bat_v.ogm_buff;
-	ogm_buff_len = &bat_priv->bat_v.ogm_buff_len;
 
 	/* tt changes have to be committed before the tvlv data is
 	 * appended as it may alter the tt tvlv container
 	 */
 	batadv_tt_local_commit_changes(bat_priv);
-	ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
-					       ogm_buff_len,
-					       BATADV_OGM2_HLEN);
+	ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff);
 	if (ret < 0)
 		goto reschedule;
 
 	tvlv_len = ret;
 
-	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + *ogm_buff_len);
+	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + ogm_buff->len);
 	if (!skb)
 		goto reschedule;
 
 	skb_reserve(skb, ETH_HLEN);
-	skb_put_data(skb, *ogm_buff, *ogm_buff_len);
+	skb_put_data(skb, ogm_buff->buf, ogm_buff->len);
 
 	ogm_packet = (struct batadv_ogm2_packet *)skb->data;
 	ogm_packet->seqno = htonl(atomic_read(&bat_priv->bat_v.ogm_seqno));
@@ -446,10 +442,10 @@ void batadv_v_ogm_primary_iface_set(struct batadv_hard_iface *primary_iface)
 	struct batadv_ogm2_packet *ogm_packet;
 
 	mutex_lock(&bat_priv->bat_v.ogm_buff_mutex);
-	if (!bat_priv->bat_v.ogm_buff)
+	if (!bat_priv->bat_v.ogm_buff.buf)
 		goto unlock;
 
-	ogm_packet = (struct batadv_ogm2_packet *)bat_priv->bat_v.ogm_buff;
+	ogm_packet = bat_priv->bat_v.ogm_buff.buf;
 	ether_addr_copy(ogm_packet->orig, primary_iface->net_dev->dev_addr);
 
 unlock:
@@ -1050,12 +1046,15 @@ int batadv_v_ogm_init(struct batadv_priv *bat_priv)
 	unsigned char *ogm_buff;
 	u32 random_seqno;
 
-	bat_priv->bat_v.ogm_buff_len = BATADV_OGM2_HLEN;
-	ogm_buff = kzalloc(bat_priv->bat_v.ogm_buff_len, GFP_ATOMIC);
+	bat_priv->bat_v.ogm_buff.len = BATADV_OGM2_HLEN;
+	bat_priv->bat_v.ogm_buff.capacity = BATADV_OGM2_HLEN;
+	bat_priv->bat_v.ogm_buff.header_length = BATADV_OGM2_HLEN;
+
+	ogm_buff = kzalloc(bat_priv->bat_v.ogm_buff.capacity, GFP_ATOMIC);
 	if (!ogm_buff)
 		return -ENOMEM;
 
-	bat_priv->bat_v.ogm_buff = ogm_buff;
+	bat_priv->bat_v.ogm_buff.buf = ogm_buff;
 	ogm_packet = (struct batadv_ogm2_packet *)ogm_buff;
 	ogm_packet->packet_type = BATADV_OGM2;
 	ogm_packet->version = BATADV_COMPAT_VERSION;
@@ -1083,9 +1082,8 @@ void batadv_v_ogm_free(struct batadv_priv *bat_priv)
 
 	mutex_lock(&bat_priv->bat_v.ogm_buff_mutex);
 
-	kfree(bat_priv->bat_v.ogm_buff);
-	bat_priv->bat_v.ogm_buff = NULL;
-	bat_priv->bat_v.ogm_buff_len = 0;
+	kfree(bat_priv->bat_v.ogm_buff.buf);
+	memset(&bat_priv->bat_v.ogm_buff, 0, sizeof(bat_priv->bat_v.ogm_buff));
 
 	mutex_unlock(&bat_priv->bat_v.ogm_buff_mutex);
 }
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index cc6ac580..b5758f69 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -16,6 +16,7 @@
 #include <linux/limits.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
+#include <linux/log2.h>
 #include <linux/netdevice.h>
 #include <linux/pkt_sched.h>
 #include <linux/rculist.h>
@@ -266,32 +267,46 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 /**
  * batadv_tvlv_realloc_packet_buff() - reallocate packet buffer to accommodate
  *  requested packet size
- * @packet_buff: packet buffer
- * @packet_buff_len: packet buffer size
- * @min_packet_len: requested packet minimum size
+ * @ogm_buff: ogm packet buffer
  * @additional_packet_len: requested additional packet size on top of minimum
  *  size
  *
  * Return: true of the packet buffer could be changed to the requested size,
  * false otherwise.
  */
-static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
-					    int *packet_buff_len,
-					    int min_packet_len,
-					    int additional_packet_len)
+static bool batadv_tvlv_realloc_packet_buff(struct batadv_ogm_buf *ogm_buff,
+					    size_t additional_packet_len)
 {
 	unsigned char *new_buff;
+	size_t newcapacity;
+	size_t newlen;
 
-	new_buff = kmalloc(min_packet_len + additional_packet_len, GFP_ATOMIC);
+	newlen = ogm_buff->header_length + additional_packet_len;
+	newcapacity = roundup_pow_of_two(newlen);
+
+	/* nothing to reallocate */
+	if (newcapacity == ogm_buff->capacity)
+		return true;
+
+	new_buff = kmalloc(newlen, GFP_ATOMIC);
 
 	/* keep old buffer if kmalloc should fail */
-	if (!new_buff)
-		return false;
+	if (!new_buff) {
+		/* continue to use oversize buffer if new data fits */
+		if (newlen <= ogm_buff->capacity) {
+			ogm_buff->len = newlen;
+			return true;
+		}
 
-	memcpy(new_buff, *packet_buff, min_packet_len);
-	kfree(*packet_buff);
-	*packet_buff = new_buff;
-	*packet_buff_len = min_packet_len + additional_packet_len;
+		return false;
+	}
+
+	memcpy(new_buff, ogm_buff->buf, ogm_buff->header_length);
+	kfree(ogm_buff->buf);
+
+	ogm_buff->buf = new_buff;
+	ogm_buff->len = newlen;
+	ogm_buff->capacity = newcapacity;
 
 	return true;
 }
@@ -300,10 +315,7 @@ static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
  * batadv_tvlv_container_ogm_append() - append tvlv container content to given
  *  OGM packet buffer
  * @bat_priv: the bat priv with all the mesh interface information
- * @packet_buff: ogm packet buffer
- * @packet_buff_len: ogm packet buffer size including ogm header and tvlv
- *  content
- * @packet_min_len: ogm header size to be preserved for the OGM itself
+ * @ogm_buff: ogm packet buffer
  *
  * The ogm packet might be enlarged or shrunk depending on the current size
  * and the size of the to-be-appended tvlv containers.
@@ -312,8 +324,7 @@ static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
  *  if operation failed
  */
 int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
-				     unsigned char **packet_buff,
-				     int *packet_buff_len, int packet_min_len)
+				     struct batadv_ogm_buf *ogm_buff)
 {
 	struct batadv_tvlv_container *tvlv;
 	struct batadv_tvlv_hdr *tvlv_hdr;
@@ -329,8 +340,7 @@ int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 		goto end;
 	}
 
-	ret = batadv_tvlv_realloc_packet_buff(packet_buff, packet_buff_len,
-					      packet_min_len, tvlv_value_len);
+	ret = batadv_tvlv_realloc_packet_buff(ogm_buff, tvlv_value_len);
 	if (!ret) {
 		tvlv_len_ret = -ENOMEM;
 		goto end;
@@ -341,7 +351,7 @@ int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 	if (!tvlv_value_len)
 		goto end;
 
-	tvlv_value = (*packet_buff) + packet_min_len;
+	tvlv_value = (u8 *)ogm_buff->buf + ogm_buff->header_length;
 
 	hlist_for_each_entry(tvlv, &bat_priv->tvlv.container_list, list) {
 		tvlv_hdr = tvlv_value;
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index f96f6b3f..fc978385 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -17,8 +17,7 @@ void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 				    u8 type, u8 version,
 				    void *tvlv_value, u16 tvlv_value_len);
 int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
-				     unsigned char **packet_buff,
-				     int *packet_buff_len, int packet_min_len);
+				     struct batadv_ogm_buf *ogm_buff);
 void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,
 			     struct batadv_ogm_packet *batadv_ogm_packet,
 			     struct batadv_orig_node *orig_node);
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c8c3e806..8ddac312 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -70,20 +70,34 @@ enum batadv_dhcp_recipient {
  */
 #define BATADV_TT_SYNC_MASK	0x00F0
 
+/**
+ * struct batadv_ogm_buf - Buffer to construct an OGM with TVLV
+ */
+struct batadv_ogm_buf {
+	/** @buf: buffer holding the OGM packet */
+	void *buf;
+
+	/** @len: length of the OGM packet buffer data */
+	size_t len;
+
+	/** @capacity: size of allocated buf */
+	size_t capacity;
+
+	/** @header_length: fixed size header length (must be <= len) */
+	size_t header_length;
+};
+
 /**
  * struct batadv_hard_iface_bat_iv - per hard-interface B.A.T.M.A.N. IV data
  */
 struct batadv_hard_iface_bat_iv {
 	/** @ogm_buff: buffer holding the OGM packet */
-	unsigned char *ogm_buff;
-
-	/** @ogm_buff_len: length of the OGM packet buffer */
-	int ogm_buff_len;
+	struct batadv_ogm_buf ogm_buff;
 
 	/** @ogm_seqno: OGM sequence number - used to identify each OGM */
 	atomic_t ogm_seqno;
 
-	/** @ogm_buff_mutex: lock protecting ogm_buff and ogm_buff_len */
+	/** @ogm_buff_mutex: lock protecting ogm_buff */
 	struct mutex ogm_buff_mutex;
 };
 
@@ -1454,15 +1468,12 @@ struct batadv_meshif_vlan {
  */
 struct batadv_priv_bat_v {
 	/** @ogm_buff: buffer holding the OGM packet */
-	unsigned char *ogm_buff;
-
-	/** @ogm_buff_len: length of the OGM packet buffer */
-	int ogm_buff_len;
+	struct batadv_ogm_buf ogm_buff;
 
 	/** @ogm_seqno: OGM sequence number - used to identify each OGM */
 	atomic_t ogm_seqno;
 
-	/** @ogm_buff_mutex: lock protecting ogm_buff and ogm_buff_len */
+	/** @ogm_buff_mutex: lock protecting ogm_buff */
 	struct mutex ogm_buff_mutex;
 
 	/** @ogm_wq: workqueue used to schedule OGM transmissions */

-- 
2.47.3

