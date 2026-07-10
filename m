Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C53BC43458
	for <batman-adv@archiver.kernel.org>; Fri, 10 Jul 2026 20:20:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1A7CA83FB7
	for <batman-adv@archiver.kernel.org>; Fri, 10 Jul 2026 22:20:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1783714838;
 b=PzP7unjY+nVHcyXBPtcoKVTfpSYSYySuhCN4ac1Yc6ByVCnPQTfrmA0XpF5zhdnvL3dyO
 jwsRqLrL8qqCN22iiBBeMW+Xo7tYELneYRwehIJaF53+hvHUS1UMsukqqiuAash06uoK5d8
 3j3tMcQLc7v8F5yFnny0NQpmfSXZuf4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1783714838; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aM47CtHpF9NsdqAvAoGPQbP0IgygXroyR3Qq1oGk4MQ=;
 b=TXZxcSNW1xNVTcWeosNPt2U6wU9QBI9gP9qhM6updphRG2ov8Ibm0s8kk1caFuowUaPBU
 Y8Z76Kxs12600YUvfwrkOnarpsbSf4IBrsYMBQjUmsmGlfO6GKV3gJpGKZ1NkzqQqDUf9se
 R3i07LA33M625Ghw5qAPZTC3HEzL2vE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DA2C18103E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 10 Jul 2026 22:20:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1783714808;
	b=osOrsWXjY3TXz1GA7jcOdl/xcb6aoiOBlDqihFOzurzJh1wuntMOOOlIJz8qwSYPJw9DL9
	6+3rJsqHpZabYbc2mZte06NEHzyZk0AaOCjoacjTnbtktCKKt501C8ATW2gcyQNop4TeM5
	GoboHBNyf0YNcnjHbHnZrogtdwvRe5Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1783714808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=aM47CtHpF9NsdqAvAoGPQbP0IgygXroyR3Qq1oGk4MQ=;
	b=eOulPhKAsrDLkAFktenyxxax0wBO0CVCPrJlWGoyQuY8iLKRsadGHq6zKyrjJIa6qt23j2
	GdrxxXqruyqR0oabPqJPqJxecHwe11T/0MSN/lQAHrHFmxtDRE4lWmj72ow9sUt2scd9oj
	2xvgyiftcHNyVCy65xBkAYlkI49/GdU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=YP0QizeG;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3522220536;
	Fri, 10 Jul 2026 20:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1783714808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aM47CtHpF9NsdqAvAoGPQbP0IgygXroyR3Qq1oGk4MQ=;
	b=YP0QizeGLi+zce2k/Iahto5/yYRjDRYyLdlhXXb7G6MKqQGdDqYpNDYtiG8oZGU+fUPVx3
	/jExrqJ8qqCDLnaagjVgp+ozU9etDf8BgIkHzI5hK2uMsIJmszvWgCAgV1PD3vyq3rT+c4
	QDOp9sXElqi6muaLOQt3PtX91N9r3X4=
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 10 Jul 2026 22:19:58 +0200
Subject: [PATCH batadv] batman-adv: annotate functions which may cow
 reallocate the skbuff
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-realloc-kernel-doc-v1-1-3a45842b3a13@narfation.org>
X-B4-Tracking: v=1; b=H4sIAO1TUWoC/yWMywrCMBBFf6XM2sA0C9v4K+Iij1sdDalMahFK/
 92ou3sunLNRhQoqnbqNFKtUmUuD/tBRvPlyhZHUmCzbIw89G4XPeY7mAS3IJrU5DpNzyXEY2VI
 Tn4pJ3r/omYJffFrp8v/rK9wRl2+R9v0DAGql/n4AAAA=
X-Change-ID: 20260710-realloc-kernel-doc-87f99d90b802
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3668; i=sven@narfation.org;
 h=from:subject:message-id; bh=gJSyf/lH7n05Sp7hxP+irhdmdGMIhUuqPuhUNesbwSE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmBwR8ZtWc+dP8194v8ggOBXtnvM+bci9nCLB8W3+zWc
 aF36uSmjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBE3goyMuyrmT/zsYUDw3Pf
 96qnd+fdOLPoxTmVL80nmc49V695JDyRkeGEfpinzN8PVycYNMzQD7/munvu6TnTVn099XJu34a
 O0lh+AA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZVC636KUFLDUV3HU4ZX3FQREOU42WVUI
X-Message-ID-Hash: ZVC636KUFLDUV3HU4ZX3FQREOU42WVUI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZVC636KUFLDUV3HU4ZX3FQREOU42WVUI/>
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
 net/batman-adv/mesh-interface.c |  5 +++++
 net/batman-adv/multicast_forw.c | 10 ++++++++++
 net/batman-adv/routing.c        |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 20582fe0..f1bfe2a5 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -57,6 +57,11 @@
  * @skb: packet buffer which should be modified
  * @len: number of bytes to add
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * skb_cow_head(). Any pointer into the skb data (e.g. obtained
+ * from skb->data or eth_hdr()) before this call must be considered
+ * invalid afterwards and has to be reacquired.
+ *
  * Return: 0 on success or negative error number in case of failure
  */
 int batadv_skb_head_push(struct sk_buff *skb, unsigned int len)
diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index d8374ef5..ccd4ae15 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1080,6 +1080,11 @@ unsigned int batadv_mcast_forw_packet_hdrlen(unsigned int num_dests)
  * Tries to expand an skb's headroom so that its head to tail is 1298
  * bytes (minimum IPv6 MTU + vlan ethernet header size) large.
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * skb_cow() / skb_linearize(). Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be
+ * considered invalid afterwards and has to be reacquired.
+ *
  * Return: -EINVAL if the given skb's length is too large or -ENOMEM on memory
  * allocation failure. Otherwise, on success, zero is returned.
  */
@@ -1123,6 +1128,11 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
  * that signaled interest in it, that is either via the translation table or the
  * according want-all flags, is attached accordingly.
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * batadv_mcast_forw_expand_head(). Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be
+ * considered invalid afterwards and has to be reacquired.
+ *
  * Return: true on success, false otherwise.
  */
 bool batadv_mcast_forw_push(struct batadv_priv *bat_priv, struct sk_buff *skb,
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index cd290a7b..5193e370 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -172,6 +172,11 @@ bool batadv_window_protected(struct batadv_priv *bat_priv, s32 seq_num_diff,
  * @hard_iface: incoming hard interface
  * @header_len: minimal header length of packet type
  *
+ * Warning: This function may reallocate the skb data buffer via
+ * skb_cow() / skb_linearize(). Any pointer into the skb data (e.g.
+ * obtained from skb->data or eth_hdr()) before this call must be
+ * considered invalid afterwards and has to be reacquired.
+ *
  * Return: true when management preconditions are met, false otherwise
  */
 bool batadv_check_management_packet(struct sk_buff *skb,

---
base-commit: e8d6ecd5b27bf4ab6dfef96e01cd0057065ed396
change-id: 20260710-realloc-kernel-doc-87f99d90b802

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

