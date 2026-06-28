Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDAF3C43458
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 07:28:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5DC8184215
	for <batman-adv@archiver.kernel.org>; Sun, 28 Jun 2026 09:28:19 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782631699;
 b=1j+ChBgw2vYzAjXfgm6+TxV9jw21FyD9f4bqQ3P+EdpKN7nMJVLTjXQkPKuHW7+TOHVKU
 AEorcR0uZXknNXn3gPQ8FZjKDUVGKl/a4xpRSiv0x7RVGCWIjzdV5iWPVJF7DEMkGAjXr+c
 TBevv4YKYc6ogIgPeWY1TRmgrcmNwNQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782631699; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+v5GHeJ8Xq+4r3jWACHSCRs3pya0uPFhL7hHG/MwnaE=;
 b=Hr6SLuqmD+7lgG91PR/oZKke2NZCd9Rx6UD5/v1tw/QVvf9r5vwvEc2wzbvBodmxQyn3H
 psX7hc9S30msRfxJugkFKtltzGJzYVLZdcLrqnU6XeRvb1KkIQhTEswB3mWnVgnmnEWQt+G
 x1AoyH3qiTHWeeWvEoS0IYct+c+NvO8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 18D6F807CF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 28 Jun 2026 09:25:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782631551;
	b=lx8wG94AVw71LUL91YF17Q28ujzw8vgdYJ5e+NNxdSs6sHCMjib58KySSIg1sdAjvnwvcT
	y1+IfrW/BBIywZC2JCzm1+6X92Aa5KCyfxJlm5ZqlV3vGgdYy051FffY1h6QCvBPVnKSiz
	cMTOre+LY9wPA/C5yFpxtEMTwA85Swk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782631551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+v5GHeJ8Xq+4r3jWACHSCRs3pya0uPFhL7hHG/MwnaE=;
	b=EpksWV9OOKVPJGD/RGrR49Sfax7gmr3422QhFyoEAUO6FzRuTbkkBp+wN3YG6bJQgke3nF
	VT5wLATWHpQBzfPeOqHBUIxW+924VLzBXFL0ziXhOV/P5e5pq2bXObBM9nC4dkhLZlS078
	v2VuCBjsHzDA5k6ZmUSXYHGt88GZFxU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Pcd9XuTZ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id B311820685;
	Sun, 28 Jun 2026 07:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782631545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+v5GHeJ8Xq+4r3jWACHSCRs3pya0uPFhL7hHG/MwnaE=;
	b=Pcd9XuTZIWuz8czel9ZD44jO51fSpFqQUjTH6l0mD/8BODcmjSk4y8G3edBTPDZJWpxlzP
	d0EYvTW7kqcK0UnoAYVlC0hv4qlu7gZCTnD9T2d4zWOAalDSjsKSqoX3waPVDZNiWJOPkY
	1rFhqzADTHj7S04uXq4Z2h3WQuzdWIk=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 28 Jun 2026 09:25:35 +0200
Subject: [PATCH batadv v2 2/5] batman-adv: gw: acquire ethernet header only
 after skb realloc
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-skb-post-realloc-v2-2-59a58f5a471b@narfation.org>
References: <20260628-skb-post-realloc-v2-0-59a58f5a471b@narfation.org>
In-Reply-To: <20260628-skb-post-realloc-v2-0-59a58f5a471b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=sven@narfation.org;
 h=from:subject:message-id; bh=srSg8nm7Hu2neHQ9t5RGJ+pAi6pcKkFX024GD7Gcvzs=;
 b=kA0DAAoWTQ93K9MU9csByyZiAGpAzHCjBftHc/VKCR7i1cF4o9cCHQ1FQogpj9aQkV3HCbXf5
 oh1BAAWCgAdFiEEvNRvz7MH7R/zlvHFTQ93K9MU9csFAmpAzHAACgkQTQ93K9MU9ct4DgEA8e8T
 a3xvf96RuU29/rouUvnNsq/buG1jCilx29uDHjoBALHy6tZhpzcy9btVlu2g0I+sTbpp/wd8IN0
 ygzAmEhEO
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QZCRVURTWFNL7I7PPGIX4HBC45PEYH3I
X-Message-ID-Hash: QZCRVURTWFNL7I7PPGIX4HBC45PEYH3I
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QZCRVURTWFNL7I7PPGIX4HBC45PEYH3I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The pskb_may_pull() called by batadv_get_vid() could reallocate the buffer
behind the skb. Variables which were pointing to the old buffer need to be
reassigned to avoid an use-after-free.

Fixes: 2d5b555644b2 ("batman-adv: send every DHCP packet as bat-unicast")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/gateway_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 2e51cfe8..bc69f2ba 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -688,7 +688,6 @@ batadv_gw_dhcp_recipient_get(struct sk_buff *skb, unsigned int *header_len,
 bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 			    struct sk_buff *skb)
 {
-	struct ethhdr *ethhdr = (struct ethhdr *)skb->data;
 	struct batadv_orig_node *orig_dst_node = NULL;
 	struct batadv_neigh_node *neigh_curr = NULL;
 	struct batadv_neigh_node *neigh_old = NULL;
@@ -697,10 +696,12 @@ bool batadv_gw_out_of_range(struct batadv_priv *bat_priv,
 	struct batadv_gw_node *gw_node = NULL;
 	struct batadv_gw_node *curr_gw = NULL;
 	bool out_of_range = false;
+	struct ethhdr *ethhdr;
 	unsigned short vid;
 	u8 curr_tq_avg;
 
 	vid = batadv_get_vid(skb, 0);
+	ethhdr = (struct ethhdr *)skb->data;
 
 	if (is_multicast_ether_addr(ethhdr->h_dest))
 		goto out;

-- 
2.47.3

