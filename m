Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE73CC54FDF
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 06:44:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C9CA4835E8
	for <batman@archiver.kernel.org>; Thu, 30 Jul 2026 08:44:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785393869;
 b=Af+0j0Gwo8flMc+1gg8D7chBgFmO5Gf/f1mMLd3lSK4C2rVtwBaQ85ttKDBqF1/TDim8s
 KE2RabhW7ykcHVAlOLQmy0Qr5JnjHLXQCSmVYnAU+lG4OK90b34TdJCx4BOMRBe2XVm5odL
 8jF16f0T1dhIGmnFiU9nlLsnu5WstmE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785393869; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=sF9Afm1O/2fOBc2HIWoConnw/GcHabvVGmtIUt2VXQo=;
 b=abCsiqI4zMw7YDorC1O1vNn0dpPiJRVKQdveDnsuPTrwmou3RJKbN6GZoLL4D3QMx4PUK
 ipKb+D/SEIIBUo1NlUW3JE2JmT08rlP9gyzsBMV+BVYMeE507mgydXRCawIsTybuH8KNJD6
 f8P7gym30l7YU4WUZPSU+QH2rfBwL7A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 798D080C1F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 30 Jul 2026 08:44:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785393850;
	b=xJKR9owy+XwSG7vjy0p4QQGrljdwkOR/vAsTEHV1uKxf+Zc0IWTfJq4h7XJaDjRPv52FHO
	iPpjUUB9KINKh/oh4HzeiQGgQ0AxFcQZYTvDxQBD0M3CMOTvSAIhHj81SB4c4jnBsKCbPo
	gcWaaNiMR7aaocPBqHQWIFmf8KtmY8s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785393850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=sF9Afm1O/2fOBc2HIWoConnw/GcHabvVGmtIUt2VXQo=;
	b=xPXtHHeGKhXCkMf8KC2H/wPuM7D33av3U9D92Po36CFrlLXfSyulX45hnYI6/90MILefeB
	x4tNwLy+7KaJebFJsXD6bwoAZn0UJB2ztkJaJD5j0mgQ15dNVQCXosgDNhssmoFui92pXQ
	Ou5oQMykpnfISvnQkI3MaTbRvGwGgi4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=LdLVXMF0;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7DA381FE7E;
	Thu, 30 Jul 2026 06:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785393835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sF9Afm1O/2fOBc2HIWoConnw/GcHabvVGmtIUt2VXQo=;
	b=LdLVXMF0HHTs7iiTphIa8b5as4FBbqPfYffXFTPDWxYZIDn+9LRyQU5zRhszeMEnC4SVUP
	LVwRQ7Wl8zuPg0fsW8c36r/5AWGNPAAQ6vWdlTgGz8gPX/tj2AQaesaB9w7zVYxqtPe1KK
	F7AiR4ju+TKCgxmNRCXBRU1WSaLYto8=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 30 Jul 2026 08:43:53 +0200
Subject: [PATCH batadv] batman-adv: correct NET_RX_* NET_XMIT_* confusion
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-rx_xmit_confusion-v1-1-ff684ec3db7c@narfation.org>
X-B4-Tracking: v=1; b=H4sIAKjyamoC/yWMUQqDMBAFryLvu4G4lVp6lVIkrmu7hcaSRAmId
 2+0n/N4MyuiBJWIW7UiyKJRJ1+gPlXgl/NPMToUBlm62PZsTchd/mjqePLjvL8Nt2KvTFRTIyj
 eN8io+Wje0bvkhgWP/x7n/i2c9iC27QdIDB41fQAAAA==
X-Change-ID: 20260730-rx_xmit_confusion-c7e08c22124e
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635; i=sven@narfation.org;
 h=from:subject:message-id; bh=lJ6znITSbhANJGjB1f79tIsTsyNE7BiLaTBbJbxrZDE=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlZn1bmpDs+ap3adDR77aRF1da9ymdZbp2aa1b1sDjw8
 49VcQ5zO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATSaliZLi11EE/c6qyZ+T+
 yjvhuxMigjadvr0nQdQl5IbTY7VbUt8YfrNeN/pifidi04J8ngUCu86F1FjGca9nucQ29VFqGvf
 shawA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: Y2IA3J7UHOHP4XD2LZIQS3KIVTP2LRO7
X-Message-ID-Hash: Y2IA3J7UHOHP4XD2LZIQS3KIVTP2LRO7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Y2IA3J7UHOHP4XD2LZIQS3KIVTP2LRO7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_recv_icmp_ttl_exceeded() is a receive function. It must therefore
return NET_RX_* and not NET_XMIT_*. And batadv_send_skb_to_orig() is an
xmit function and is returning NET_XMIT_*.

This doesn't change the behavior because both NET_RX_SUCCESS and
NET_RX_SUCCESS are using the same underlying value (0).

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/routing.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 15ef47d3..7e093420 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -341,7 +341,7 @@ static int batadv_recv_my_icmp_packet(struct batadv_priv *bat_priv,
  * For traceroute-style ICMP echo requests, send a TTL exceeded reply back to
  * the source. Other ICMP types are simply dropped.
  *
- * Return: NET_XMIT_SUCCESS if the reply was queued, NET_RX_DROP otherwise
+ * Return: NET_RX_SUCCESS if the reply was queued, NET_RX_DROP otherwise
  */
 static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 					 struct sk_buff *skb)
@@ -382,8 +382,8 @@ static int batadv_recv_icmp_ttl_exceeded(struct batadv_priv *bat_priv,
 	icmp_packet->ttl = BATADV_TTL;
 
 	res = batadv_send_skb_to_orig(skb, orig_node, NULL);
-	if (res == NET_RX_SUCCESS)
-		ret = NET_XMIT_SUCCESS;
+	if (res == NET_XMIT_SUCCESS)
+		ret = NET_RX_SUCCESS;
 
 	/* skb was consumed */
 	skb = NULL;

---
base-commit: 95b6f66b2659f617ce1937e790f48dc578ee014c
change-id: 20260730-rx_xmit_confusion-c7e08c22124e

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

