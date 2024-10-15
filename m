Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B0DCFC271
	for <batman@archiver.kernel.org>; Tue, 15 Oct 2024 07:42:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E992D83D29
	for <batman@archiver.kernel.org>; Tue, 15 Oct 2024 09:41:59 +0200 (CEST)
ARC-Seal: i=2; cv=fail; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1728978119;
 b=oeV05wlOkRBj31/eyJHWt7Ngvk2wbtLz8dEhLV5GEK+PfwV1CBNYgIX2qAM7wWf9UAE7t
 llkuFrs7ub12B5gM1N5/X78VkiwA6wsKI+pz/+C0PRrE9TAgQYvjQ/fkgZMHwNrUVJtq/Qw
 pGhBjkmGK1HhbsREuPzNIhr9VKJJocA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1728978119; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cOsPCl6XRS0JcnH2JfXCcShvWpdzVH1AtkG5g8awVGc=;
 b=DT+2vKVeiutmJzb14z3u+fR9VsSKqR9+ZiAirCwYPT70QOUW8ti9E8/HWJK9maGkLuFpk
 GwAOcLaoBe1i3fq4Ffz+LiYNvSiEo4mt3H7x9JBJ00n/LrJf7WCBGfR4qlnk6gKw5QtMck/
 FcF/U64oHR0fdOjWmPfjbw66XgIHN0I=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=fail (ARC-Seal[1] did not validate);
  dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=fail;
 arc=fail (ARC-Seal[1] did not validate);
 dmarc=fail (Used From Domain Record) header.from=simonwunderlich.de
 policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AAF7583B8D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 15 Oct 2024 09:39:50 +0200 (CEST)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1728977990; a=rsa-sha256;
	cv=none;
	b=j3i4kA/gqnitS6UHLD7ff2yN7krbos3HZsMNLcfVqHR/1owmCauYXdDIgjYjsRfF2JWNQf
	pfCExN9DcureBQThOJChLgwt8euX5wmJz7CY1hyMwOMhblxhRLjl2tfycbqLXhCFXipmRx
	8BhYI4scLyewniIQeccso0kHSjvKbJ8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1728977990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cOsPCl6XRS0JcnH2JfXCcShvWpdzVH1AtkG5g8awVGc=;
	b=RYAE0019fUIu47GdGGzRGccSZcKWHvyT+V88RSIrjj5+siP8iPG/9H7J2kzsJijmoQcsF3
	kSo8BvkPVLjt/YUiVYOkFKl2VUnD6UvFjaca+OuugICeAMZXaGonqUk90sHM5YI2H8HNIz
	+wGzbM11GfXBQmHv2zhrKc+V9TiV55A=
Received: from kero.packetmixer.de (p5480b09e.dip0.t-ipconnect.de
 [84.128.176.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 1223CFAA31;
	Tue, 15 Oct 2024 09:39:50 +0200 (CEST)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: kuba@kernel.org,
	davem@davemloft.net
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 3/4] batman-adv: Use string choice helper to print booleans
Date: Tue, 15 Oct 2024 09:39:45 +0200
Message-Id: <20241015073946.46613-4-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241015073946.46613-1-sw@simonwunderlich.de>
References: <20241015073946.46613-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VTRKJ4MZU52DGDFORW3WSHAC6Q4P64PD
X-Message-ID-Hash: VTRKJ4MZU52DGDFORW3WSHAC6Q4P64PD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VTRKJ4MZU52DGDFORW3WSHAC6Q4P64PD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The commit ea4692c75e1c ("lib/string_helpers: Consolidate string helpers
implementation") introduced common helpers to print string representations
of boolean helpers. These are supposed to be used instead of open coded
versions.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c            | 4 ++--
 net/batman-adv/bridge_loop_avoidance.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 74b49c35ddc1..07ae5dd1f150 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -36,6 +36,7 @@
 #include <linux/spinlock.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 #include <net/genetlink.h>
@@ -371,8 +372,7 @@ static void batadv_iv_ogm_send_to_if(struct batadv_forw_packet *forw_packet,
 			   batadv_ogm_packet->orig,
 			   ntohl(batadv_ogm_packet->seqno),
 			   batadv_ogm_packet->tq, batadv_ogm_packet->ttl,
-			   ((batadv_ogm_packet->flags & BATADV_DIRECTLINK) ?
-			    "on" : "off"),
+			   str_on_off(batadv_ogm_packet->flags & BATADV_DIRECTLINK),
 			   hard_iface->net_dev->name,
 			   hard_iface->net_dev->dev_addr);
 
diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 5f46ca3d4bb8..449faf5a5487 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -33,6 +33,7 @@
 #include <linux/sprintf.h>
 #include <linux/stddef.h>
 #include <linux/string.h>
+#include <linux/string_choices.h>
 #include <linux/workqueue.h>
 #include <net/arp.h>
 #include <net/genetlink.h>
@@ -1946,16 +1947,15 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	claim = batadv_claim_hash_find(bat_priv, &search_claim);
 
 	if (!claim) {
+		bool local = batadv_is_my_client(bat_priv, ethhdr->h_source, vid);
+
 		/* possible optimization: race for a claim */
 		/* No claim exists yet, claim it for us!
 		 */
 
 		batadv_dbg(BATADV_DBG_BLA, bat_priv,
 			   "%s(): Unclaimed MAC %pM found. Claim it. Local: %s\n",
-			   __func__, ethhdr->h_source,
-			   batadv_is_my_client(bat_priv,
-					       ethhdr->h_source, vid) ?
-			   "yes" : "no");
+			   __func__, ethhdr->h_source, str_yes_no(local));
 		batadv_handle_claim(bat_priv, primary_if,
 				    primary_if->net_dev->dev_addr,
 				    ethhdr->h_source, vid);
-- 
2.39.5

