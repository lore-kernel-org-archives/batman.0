Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E84C43458
	for <batman-adv@archiver.kernel.org>; Fri, 10 Jul 2026 20:32:27 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id BAA0684000
	for <batman-adv@archiver.kernel.org>; Fri, 10 Jul 2026 22:32:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783715545;
 b=JZiADLgNN9RFqq+wr+Ibp4QAq6EayLShpE/tku38Ksdq49OPPBHk0eI9eaFW+dV6Rqp8L
 BaNDrdYjY8B3JJzNAakg/qVlFZ7h3MhNDEPzY2dJHEgVyCYuPH2Q/eNmGlvTkE/1u1+iaF2
 XsrrUfbD+7CZa8iB9XMcai2OTtJ8b60=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783715545; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ctU/GAFEI8TGfmIi6/D5cPnslnEYhGl6Uuqxxt1qJcw=;
 b=keb6Pkyhy1s/r9Iy5j/G8D7pPYo/9ZbEn5NBbeeYAvy4Ss9a7oVFW15drKFqzyYTxZg8s
 tIHVxNix5YHivVu4wGRuEWhc2Zaa0lUt8TgSMYSMi5Q0+ywkOqSOtLE/0jgaKvM3gKrU25R
 xFNFFxEXDtiZ1C724B3EvODJhTuCx8c=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 11FEF81405
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 10 Jul 2026 22:31:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783715518;
	b=ZgAUy3KPwJsGu2jXvF+u1054IrqlYtEvJSy1OhRsc5QU8Fo7XFHj74Q7fv1ewF6OYFky9R
	UvwnHGU/0QmzJQgKNfNUFkzQCJ+iGQK9v58qMMtvHYAV2rnEB3LUsNXzZGNvLR6AAGy1d8
	NWYflNQ5k8rT/CwBTSXf2h/yhoC5qIM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783715518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ctU/GAFEI8TGfmIi6/D5cPnslnEYhGl6Uuqxxt1qJcw=;
	b=yLFNy0qiPojxF9AL8OQ3YtUrP0XoVF3DUXOpQoUKJIMWB2E5PpAl7UUylWZNUqlnigIAJI
	04A0vJKaRXcpbNGby/sKrkZhvaxMbbdpzbr+Pdx09wd5BQpsgFqaIp2GH3HvwV1myZCBIv
	FxAZjJyxQX7V7VnclUx/HxP1aphjOQ0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=d4YfmX9L;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id F02A620536;
	Fri, 10 Jul 2026 20:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783715517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ctU/GAFEI8TGfmIi6/D5cPnslnEYhGl6Uuqxxt1qJcw=;
	b=d4YfmX9LqKjtjt/3yoeQouDS5z7OlXypEOb3v0+nNG3c87co0WMnBGSWD7RUmoMM1mKGMu
	acm6ahR6eEd+s8h1rXBQffdA54ypjqPSDgyKMiQCqIotdbUx3pkQmEbjXh0dJEJc+yVODj
	IDJfGt/62boSEu/yDnGJYEq79Yp4jnY=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jul 2026 22:31:38 +0200
Subject: [PATCH batadv] batman-adv: fix kernel-doc for functions holding
 ownership of the skb
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-consuming-kernel-doc-v1-1-159abdc5149f@narfation.org>
X-B4-Tracking: v=1; b=H4sIAKlWUWoC/yWMywqDMBAAf0X23IVE1Jb+Sukhj9VuH5uSVRHEf
 zetxxmYWUEpMylcqxUyzaycpIA9VRAeTgZCjoWhNnVnztZgSKLTh2XAF2WhN8YU0PnW2Nbbprk
 QlPSbqeflv72Bd6OLM9wPr5N/Uhh/T9i2HUhLxX2AAAAA
X-Change-ID: 20260710-consuming-kernel-doc-ab5015b1448e
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2625; i=sven@narfation.org;
 h=from:subject:message-id; bh=8ya1umFDOpvTzak3IxhxqPpkjPcYAHXIvhh5wQIEsBs=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmBYRs47wQwnBZwjtl+9F7j6ugP/zLEWT7dXdPBPfXQN
 t+E+kSujlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEjhUwMkzdPEljvt3Ku63y
 t1IUVXY0WUj8X81woeVHmtXCqBbDAy6MDDem6gZHCJ5Zc0n1w5FvCY8zb8+MmskxNS3vbPG1M7l
 7c1kB
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ESNZMSJ6UO7VXZXGWBCPITNP7A3XC7XO
X-Message-ID-Hash: ESNZMSJ6UO7VXZXGWBCPITNP7A3XC7XO
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ESNZMSJ6UO7VXZXGWBCPITNP7A3XC7XO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Most functions in batman-adv will take the ownership of an skb when they
receive it as argument.  Their NET_RX_DROP return value is only indicating
whether there was direct visible problem while processing it. The caller
must not try to also free the skb when such a negative return code was
received.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index cd290a7b..55a88431 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -263,8 +263,7 @@ static bool batadv_skb_decrement_ttl(struct sk_buff *skb)
  * @bat_priv: the bat priv with all the mesh interface information
  * @skb: icmp packet to process
  *
- * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
- * otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
 				      struct sk_buff *skb)
@@ -999,8 +998,7 @@ static bool batadv_check_unicast_ttvn(struct batadv_priv *bat_priv,
  * @skb: unicast tvlv packet to process
  * @recv_if: pointer to interface this packet was received on
  *
- * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
- * otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 int batadv_recv_unhandled_unicast_packet(struct sk_buff *skb,
 					 struct batadv_hard_iface *recv_if)
@@ -1138,8 +1136,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
  * @skb: unicast tvlv packet to process
  * @recv_if: pointer to interface this packet was received on
  *
- * Return: NET_RX_SUCCESS if the packet has been consumed or NET_RX_DROP
- * otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 int batadv_recv_unicast_tvlv(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)
@@ -1383,7 +1380,7 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
  * contents of its TVLV forwards it and/or decapsulates it to hand it to the
  * mesh interface.
  *
- * Return: NET_RX_DROP if the skb is not consumed, NET_RX_SUCCESS otherwise.
+ * Return: NET_RX_SUCCESS on success or NET_RX_DROP in case of failure
  */
 int batadv_recv_mcast_packet(struct sk_buff *skb,
 			     struct batadv_hard_iface *recv_if)

---
base-commit: e8d6ecd5b27bf4ab6dfef96e01cd0057065ed396
change-id: 20260710-consuming-kernel-doc-ab5015b1448e

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

