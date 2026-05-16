Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE06CD4F25
	for <batman-adv@archiver.kernel.org>; Sat, 16 May 2026 07:17:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0D66185E38
	for <batman-adv@archiver.kernel.org>; Sat, 16 May 2026 09:17:31 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778915851;
 b=Uxq/tQ1uxYA0T7RVb3ySzt2E3fuu4bNHJJpUkXJKzrJy3xmeIH9EAekCE/0HRjuBCOY1X
 Ip1nsyPaguwpSTuOBbM/dWGOADB6Z6rgs61YiFJHM8atF6sbdwqllicKvXCoUZsyRGpD+fP
 4Ad/scOdiBznA7/JBcDhnq4VLcV8m94=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778915851; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=S58MzU/aIO68hl+fTsU4ROHcGfhuw+Rds7CH3LyI9j0=;
 b=cpfyYKSJ7UrgNIELCjFdQxMWif1lU6fDeBbJ9ZDlQob/VvbWdZF8UOFXdt+Tm09fqF1vq
 kNTJfjb9FmykCqQR4LhFB51O1eI/BPMlIQuydUYAgFnqKHMgIff+53fpbxhQBCosUFj1a2t
 3VztyJxOWgSdMvfcXb8g8sHYiSxgfs8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2971785DA2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 May 2026 09:15:08 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778915713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=S58MzU/aIO68hl+fTsU4ROHcGfhuw+Rds7CH3LyI9j0=;
	b=cGudwMIvpAUy3pzdaO9A+ggjinZVZvmU60MgeIeeu+nFjRR82LMxvzMSxTWcTr70KIv9pM
	YUutwmsxWAfrwApWd86NmKn/uO5HgSw9KF8S5D8sR6sFHGTeMc2P0ZJJQebJXmIUd4HV2j
	WO1cMitlQJx3b10NxKrCZPenDYS0cE8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=btDSBdcT;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778915713;
	b=Wfpq0gf7J5Yj1zYSx8tDWl45EOWeuOhycB5cnNJzUnqqqy2Lx4/HJzoYM2Ae+a/Wh4yiXg
	F0J1s99KrBNpmR+x22yeMIEEp4lbUjsgUotME31OIeKvdvno7aLkI/eIooamM7uJdRFgX4
	hGyllZ7DWOeaUgBEht9bIzpkHfc9x6o=
Received: by dvalin.narfation.org (Postfix) id CCDA721EB6
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 May 2026 07:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778915707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S58MzU/aIO68hl+fTsU4ROHcGfhuw+Rds7CH3LyI9j0=;
	b=btDSBdcTnRTQIuteZrx3EOsbLArDw9e+5yVEcWMVos/AlrL2bh0s1QZ7alvNfyxdAAlvvs
	9WIucG0qIna/hYlNV0GZCoLmqv3YXqLg4xsUFnP0wKteptMwNRpQ514BsCMb3MxO/t/lwr
	/iePosDY4N9qmU5wA4sHyaoXk0EL1ME=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 16 May 2026 09:14:57 +0200
Subject: [PATCH batadv v4 2/4] batman-adv: tvlv: abort OGM send on tvlv
 append failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-yuantan098-bugfixes-v4-2-9b5743d147bd@narfation.org>
References: <20260516-yuantan098-bugfixes-v4-0-9b5743d147bd@narfation.org>
In-Reply-To: <20260516-yuantan098-bugfixes-v4-0-9b5743d147bd@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6662; i=sven@narfation.org;
 h=from:subject:message-id; bh=L0AxJaYzT+4WM8z2BSP2DWNIq7xnqF1dC3rTg4XOxk8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkckkU8Us5r0+7fejR7/mPnzbPtVNoO/zojJDvtsXyIw
 cb7bTUtHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ9Pkx/PdQt5/SFBtec0mA
 d59CaK+dSSWPs9c263VqPZ/zjmV94mNkmL29sVL+zDOWm/O5Jv3tfX+RuTfiYnB1Ea/Shib7L4G
 VrAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: S6MO3QG3XNUGWCIDVRCCWIG3IWWTK7S4
X-Message-ID-Hash: S6MO3QG3XNUGWCIDVRCCWIG3IWWTK7S4
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/S6MO3QG3XNUGWCIDVRCCWIG3IWWTK7S4/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tvlv_container_ogm_append() could fail in two ways: a memory
allocation failure when resizing the packet buffer, or the tvlv data
exceeding U16_MAX bytes. In both cases the function previously returned the
old (now stale) tvlv_value_len rather than signalling an error, causing the
OGM/OGM2 send path to transmit a packet whose TVLV length field no longer
matched the actual buffer contents. And because it also didn't fill in the
new TVLV data, sending either uninitialized or corrupted data on the wire.

All errors in batadv_tvlv_container_ogm_append() must be forwarded to the
caller. And the caller must abort the send of the OGM(2).

Fixes: 0b6aa0d43767 ("batman-adv: tvlv - basic infrastructure")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bat_iv_ogm.c | 16 +++++++++++++---
 net/batman-adv/bat_v_ogm.c  | 26 ++++++++++++++------------
 net/batman-adv/tvlv.c       | 17 ++++++++++++-----
 net/batman-adv/tvlv.h       |  2 +-
 4 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 74ef7dc2..7ad26128 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -790,6 +790,7 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 	u32 seqno;
 	u16 tvlv_len = 0;
 	unsigned long send_time;
+	int ret;
 
 	lockdep_assert_held(&hard_iface->bat_iv.ogm_buff_mutex);
 
@@ -813,9 +814,18 @@ static void batadv_iv_ogm_schedule_buff(struct batadv_hard_iface *hard_iface)
 		 * appended as it may alter the tt tvlv container
 		 */
 		batadv_tt_local_commit_changes(bat_priv);
-		tvlv_len = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
-							    ogm_buff_len,
-							    BATADV_OGM_HLEN);
+		ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
+						       ogm_buff_len,
+						       BATADV_OGM_HLEN);
+		if (ret < 0) {
+			/* OGMs must be queued even when the buffer allocation for
+			 * TVLVs failed. just fall back to the non-TVLV version
+			 */
+			ret = 0;
+			*ogm_buff_len = BATADV_OGM_HLEN;
+		}
+
+		tvlv_len = ret;
 	}
 
 	batadv_ogm_packet = (struct batadv_ogm_packet *)(*ogm_buff);
diff --git a/net/batman-adv/bat_v_ogm.c b/net/batman-adv/bat_v_ogm.c
index e955b494..d66ca77b 100644
--- a/net/batman-adv/bat_v_ogm.c
+++ b/net/batman-adv/bat_v_ogm.c
@@ -269,10 +269,10 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 	struct batadv_hard_iface *hard_iface;
 	struct batadv_ogm2_packet *ogm_packet;
 	struct sk_buff *skb, *skb_tmp;
-	unsigned char *ogm_buff;
+	unsigned char **ogm_buff;
 	struct list_head *iter;
-	int ogm_buff_len;
-	u16 tvlv_len = 0;
+	int *ogm_buff_len;
+	u16 tvlv_len;
 	int ret;
 
 	lockdep_assert_held(&bat_priv->bat_v.ogm_buff_mutex);
@@ -280,25 +280,27 @@ static void batadv_v_ogm_send_meshif(struct batadv_priv *bat_priv)
 	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_DEACTIVATING)
 		goto out;
 
-	ogm_buff = bat_priv->bat_v.ogm_buff;
-	ogm_buff_len = bat_priv->bat_v.ogm_buff_len;
+	ogm_buff = &bat_priv->bat_v.ogm_buff;
+	ogm_buff_len = &bat_priv->bat_v.ogm_buff_len;
+
 	/* tt changes have to be committed before the tvlv data is
 	 * appended as it may alter the tt tvlv container
 	 */
 	batadv_tt_local_commit_changes(bat_priv);
-	tvlv_len = batadv_tvlv_container_ogm_append(bat_priv, &ogm_buff,
-						    &ogm_buff_len,
-						    BATADV_OGM2_HLEN);
+	ret = batadv_tvlv_container_ogm_append(bat_priv, ogm_buff,
+					       ogm_buff_len,
+					       BATADV_OGM2_HLEN);
+	if (ret < 0)
+		goto reschedule;
 
-	bat_priv->bat_v.ogm_buff = ogm_buff;
-	bat_priv->bat_v.ogm_buff_len = ogm_buff_len;
+	tvlv_len = ret;
 
-	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + ogm_buff_len);
+	skb = netdev_alloc_skb_ip_align(NULL, ETH_HLEN + *ogm_buff_len);
 	if (!skb)
 		goto reschedule;
 
 	skb_reserve(skb, ETH_HLEN);
-	skb_put_data(skb, ogm_buff, ogm_buff_len);
+	skb_put_data(skb, *ogm_buff, *ogm_buff_len);
 
 	ogm_packet = (struct batadv_ogm2_packet *)skb->data;
 	ogm_packet->seqno = htonl(atomic_read(&bat_priv->bat_v.ogm_seqno));
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 8129a3f9..46ed61db 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -8,6 +8,7 @@
 
 #include <linux/byteorder/generic.h>
 #include <linux/container_of.h>
+#include <linux/errno.h>
 #include <linux/etherdevice.h>
 #include <linux/gfp.h>
 #include <linux/if_ether.h>
@@ -306,9 +307,10 @@ static bool batadv_tvlv_realloc_packet_buff(unsigned char **packet_buff,
  * The ogm packet might be enlarged or shrunk depending on the current size
  * and the size of the to-be-appended tvlv containers.
  *
- * Return: size of all appended tvlv containers in bytes.
+ * Return: size of all appended tvlv containers in bytes (max U16_MAX), negative
+ *  if operation failed
  */
-u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
+int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 				     unsigned char **packet_buff,
 				     int *packet_buff_len, int packet_min_len)
 {
@@ -316,6 +318,7 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 	struct batadv_tvlv_hdr *tvlv_hdr;
 	u16 tvlv_value_len;
 	void *tvlv_value;
+	int tvlv_len_ret;
 	bool ret;
 
 	spin_lock_bh(&bat_priv->tvlv.container_list_lock);
@@ -323,9 +326,12 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 
 	ret = batadv_tvlv_realloc_packet_buff(packet_buff, packet_buff_len,
 					      packet_min_len, tvlv_value_len);
-
-	if (!ret)
+	if (!ret) {
+		tvlv_len_ret = -ENOMEM;
 		goto end;
+	}
+
+	tvlv_len_ret = tvlv_value_len;
 
 	if (!tvlv_value_len)
 		goto end;
@@ -344,7 +350,8 @@ u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 
 end:
 	spin_unlock_bh(&bat_priv->tvlv.container_list_lock);
-	return tvlv_value_len;
+
+	return tvlv_len_ret;
 }
 
 /**
diff --git a/net/batman-adv/tvlv.h b/net/batman-adv/tvlv.h
index e5697230..f96f6b3f 100644
--- a/net/batman-adv/tvlv.h
+++ b/net/batman-adv/tvlv.h
@@ -16,7 +16,7 @@
 void batadv_tvlv_container_register(struct batadv_priv *bat_priv,
 				    u8 type, u8 version,
 				    void *tvlv_value, u16 tvlv_value_len);
-u16 batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
+int batadv_tvlv_container_ogm_append(struct batadv_priv *bat_priv,
 				     unsigned char **packet_buff,
 				     int *packet_buff_len, int packet_min_len);
 void batadv_tvlv_ogm_receive(struct batadv_priv *bat_priv,

-- 
2.47.3

