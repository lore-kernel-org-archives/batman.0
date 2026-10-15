Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23F8CC6B2F
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 06:32:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C951584605
	for <batman@archiver.kernel.org>; Thu, 15 Oct 2026 08:32:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1792045932;
 b=VMYZk2ntErQgTZ6L5h5anjj/sDibAdiZ9AKJOa2ZFglo8hLa7k504Zz1OXOCKLDoPJTMA
 dgzpAtRsvPnvqAWiutLu1bF2NiPCkE7XzGx7k/OqIJPfpaXYwm0uRKFeBzDVYKpMlkynQ0H
 k6PCL91Vf8AVmctwXnKTz08vkuQ8j+4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1792045932; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=2ndhOSVGP6TmruvqiXughdllk0NWVomr3RzaTVfvDPw=;
 b=y3rj9lF2U2avlrWkC5eR8SURD97abc5iZBVNIIxxRvK+EtTDogWpfAp3BH4RJm1ygcjMI
 ZN7ffhu9r81gLnZVLujZbzTJe8yBXlmGOHlNUp0at7VtziyKLI+R0k3O/++4bOuROTyYqtC
 oq2C7ctVo3d5ps4egqlsgVT45eTShVg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 04F548429F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 15 Oct 2026 08:31:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1792045894;
	b=CaGMHbiaidKweP9B3d8JEY+6Mb5/T+JsF8LBrEDaZp6jviwhWL0uLz4I4sD5JPbj9FLeYE
	O55snmjhT58eNupKJYTAifn7R/Z0Yt0kMo7fUJdIxMDi7jJPjpNIHPHOZadIP7Are0Nn09
	0Ubde7m1tzdtKYKiRwOvWWcQ0XzUHlg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1792045894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2ndhOSVGP6TmruvqiXughdllk0NWVomr3RzaTVfvDPw=;
	b=KbOVU/h+6H5zJO1HSMLepwTCJkPSTe/nB3A9l60J02gYJEQ6OU1vYEs1aI+Awp39Lk6oO1
	lPXSGeSET9zY2ELV4PTYMA7cd5ydLvBWkHSoIIMJzamdGNxIyA4hXQPKubpIRkt0mq9VYo
	TS1uP5BgAb5acqW8bkS+JgblRi4WwdM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=hkSjESV2;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7F7A82064A;
	Thu, 15 Oct 2026 06:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1792045883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ndhOSVGP6TmruvqiXughdllk0NWVomr3RzaTVfvDPw=;
	b=hkSjESV2JaE5kBqJesHV/hA3HvFTOXLi8vHAYhSEaBFBYvRGF38sU9kQrtgqnaDW8m9ah5
	YTDb0SwIMJdahkhUSvtQLLOIsbgoLQmU3DYtspQNDEcD+NbYXNNsr1SaPfbMyiAsXWwepu
	uRWlmHORoGb1zWi/hucnD9cByy+2iuw=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 15 Oct 2026 08:31:01 +0200
Subject: [PATCH RESEND batadv 1/4] batman-adv: never consume skb in BLA rx
 and DAT incoming snooping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-skb-ownership-v1-1-8bb03bba6701@narfation.org>
References: <20261015-skb-ownership-v1-0-8bb03bba6701@narfation.org>
In-Reply-To: <20261015-skb-ownership-v1-0-8bb03bba6701@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6567; i=sven@narfation.org;
 h=from:subject:message-id; bh=5dXHCdFfZNjkddRCzew/8K/seHMepd92facPbGFh28s=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkXinVs/M4pHJgXfVl8e7rDpIL9xufm7LgmdVDUvsTQs
 +Y014S/HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJGC9l+GczPTUlskKVOWGC
 8/GnqeuzDCcz5TXrX372TrnPdqVQrRojw/5CmUkHe1edm1TrsiqfUz94jgrPc6O1B+8tLgtfdcz
 qAhMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: N7R46R5257UOUI4TO3W5GJOBEV4RVHZ5
X-Message-ID-Hash: N7R46R5257UOUI4TO3W5GJOBEV4RVHZ5
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/N7R46R5257UOUI4TO3W5GJOBEV4RVHZ5/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_bla_tx() and the outgoing DAT snooping functions return true when
the caller has to drop the skb, and they never free it themselves.
batadv_bla_rx(), batadv_dat_snoop_incoming_arp_request() and
batadv_dat_snoop_incoming_arp_reply() look the same, but they freed the skb
themselves when returning true, and only then.

So callers had to know, for each function, whether "true" meant "already
freed" or "free it now". batadv_bla_rx() and batadv_bla_tx() even had the
same kerneldoc text.

Make all of them only borrow the skb, and let the callers free it when
true is returned.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 13 ++++++-------
 net/batman-adv/distributed-arp-table.c | 10 +++++-----
 net/batman-adv/mesh-interface.c        |  6 ++----
 net/batman-adv/routing.c               | 16 +++++++++-------
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index a96f269d..a37d172f 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -1950,10 +1950,10 @@ batadv_bla_loopdetect_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
  *  * we have to race for a claim
  *  * if the frame is allowed on the LAN
  *
- * In these cases, the skb is further handled by this function
+ * The skb is never consumed by this function.
  *
- * Return: true if handled, otherwise it returns false and the caller shall
- * further process the skb.
+ * Return: true if the skb has to be dropped, otherwise it returns false and the
+ * caller shall further process the skb.
  */
 bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		   unsigned short vid, int packet_type)
@@ -2064,7 +2064,6 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	goto out;
 
 handled:
-	kfree_skb(skb);
 	ret = true;
 
 out:
@@ -2083,15 +2082,15 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
  *  * a claim was received which has to be processed
  *  * the frame is allowed on the mesh
  *
- * in these cases, the skb is further handled by this function.
+ * The skb is never consumed by this function.
  *
  * Warning: This function may reallocate the skb data buffer via
  * batadv_bla_process_claim()/... Any pointer into the skb data (e.g.
  * obtained from skb->data or eth_hdr()) before this call must be considered
  * invalid afterwards and has to be reacquired.
  *
- * Return: true if handled, otherwise it returns false and the caller shall
- * further process the skb.
+ * Return: true if the skb has to be dropped, otherwise it returns false and the
+ * caller shall further process the skb.
  */
 bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		   unsigned short vid)
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 74050bff..6a72c17e 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -1336,6 +1336,8 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
  * from skb->data or eth_hdr()) before this call must be considered
  * invalid afterwards and has to be reacquired.
  *
+ * The skb is never consumed by this function.
+ *
  * Return: true if the request has been answered, false otherwise.
  */
 bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
@@ -1395,8 +1397,6 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	}
 out:
 	batadv_dat_entry_put(dat_entry);
-	if (ret)
-		kfree_skb(skb);
 	return ret;
 }
 
@@ -1465,7 +1465,9 @@ void batadv_dat_snoop_outgoing_arp_reply(struct batadv_priv *bat_priv,
  * from skb->data or eth_hdr()) before this call must be considered
  * invalid afterwards and has to be reacquired.
  *
- * Return: true if the packet was snooped and consumed by DAT. False if the
+ * The skb is never consumed by this function.
+ *
+ * Return: true if the packet was snooped and has to be dropped. False if the
  * packet has to be delivered to the interface
  */
 bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
@@ -1555,8 +1557,6 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	 */
 	dropped |= batadv_is_my_client(bat_priv, hw_src, vid);
 out:
-	if (dropped)
-		kfree_skb(skb);
 	batadv_dat_entry_put(dat_entry);
 	/* if dropped == false -> deliver to the interface */
 	return dropped;
diff --git a/net/batman-adv/mesh-interface.c b/net/batman-adv/mesh-interface.c
index 41d14863..01f30fee 100644
--- a/net/batman-adv/mesh-interface.c
+++ b/net/batman-adv/mesh-interface.c
@@ -513,7 +513,7 @@ void batadv_interface_rx(struct net_device *mesh_iface,
 	 * not handle it, we can safely push it up.
 	 */
 	if (batadv_bla_rx(bat_priv, skb, vid, packet_type))
-		goto out;
+		goto dropped;
 
 	if (orig_node)
 		batadv_tt_add_temporary_global_entry(bat_priv, orig_node,
@@ -538,12 +538,10 @@ void batadv_interface_rx(struct net_device *mesh_iface,
 	}
 
 	netif_rx(skb);
-	goto out;
+	return;
 
 dropped:
 	kfree_skb(skb);
-out:
-	return;
 }
 
 /**
diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 6442f5d0..b4172a6e 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1109,11 +1109,12 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 		}
 
 		if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb,
-							  hdr_size))
-			goto rx_success;
-		if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb,
-							hdr_size))
+							  hdr_size) ||
+		    batadv_dat_snoop_incoming_arp_reply(bat_priv, skb,
+							hdr_size)) {
+			kfree_skb(skb);
 			goto rx_success;
+		}
 
 		batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
 
@@ -1351,10 +1352,11 @@ int batadv_recv_bcast_packet(struct sk_buff *skb,
 	if (batadv_bla_is_backbone_gw(skb, orig_node, hdr_size))
 		goto free_skb;
 
-	if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size))
-		goto rx_success;
-	if (batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size))
+	if (batadv_dat_snoop_incoming_arp_request(bat_priv, skb, hdr_size) ||
+	    batadv_dat_snoop_incoming_arp_reply(bat_priv, skb, hdr_size)) {
+		kfree_skb(skb);
 		goto rx_success;
+	}
 
 	batadv_dat_snoop_incoming_dhcp_ack(bat_priv, skb, hdr_size);
 

-- 
2.47.3

