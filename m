Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0BFCD8CA8
	for <batman-adv@archiver.kernel.org>; Sat, 13 Jun 2026 21:33:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 52496841A4
	for <batman-adv@archiver.kernel.org>; Sat, 13 Jun 2026 23:33:55 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1781386435;
 b=FLVEVncsP9zUwn8OACS77Pah28/QY0FcLZNo4hJwKgtrgB3nJKqHwqqwa0BwpCwKDTVx4
 s+X6XHkM+PpUi90QEGih5CSrri1DEMCTYX3Q5vNDLG8OxgDrEbSHoutEUZ5grNhITckhbJM
 LJMDJk4LX9F+CE2s3aLVSkHwdmqc9Ew=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1781386435; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=puLtiZeoIjP4ZaV2vIYMZ/WAVkToVud8oT6yTS28r+s=;
 b=z06kr6+Hvc2q6butUb4kYZTYCDTZYD3jmzRM0lhw2e6EIXdrllA8RjWS48uzv5MUywGUL
 lMc6trQmNrF4FA6dSdtVUi3lyWTM6k1Py9qlK4ZWNQ+co+pVHbSZgdccKbaMvt6pYSnwqsF
 6XOxXGwxnDEJILPLo+jPbw2ttx/eXe4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5B32C811A3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 13 Jun 2026 23:33:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1781386411;
	b=WDHby3bicXHqVFJFpeEPsTQ+0xKZnoEZdJL4hfjfAu5QZECRJqgZk5Zcqw/vmi+euIWBBA
	J/5BJ33oL9wMAkSKH/ak1KIgFCEjTcYkk2iToiou14IFgW6O/k1mw6AaUVfQPEjfoEi5Lf
	bKHn/t2oWwGlD9eaX2ik6P+PYD3V7Gg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1781386411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=puLtiZeoIjP4ZaV2vIYMZ/WAVkToVud8oT6yTS28r+s=;
	b=RTXTXpbdLYzPsZhL/gwdUDFt6NLORatVplI0d50JHSokN2tWe2QZKijFOhwnw9Smp4+5ks
	Aoi2bCfNKbCG89G10QDAhcZfGVXMxo4djs40X+luJig/XI4DyCh2GIEz+0woKI8VAMZwKJ
	NA81HXSxTm1tV5JrZgs/d0utuxbn0lU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=DumBfl4Z;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 5A1571FF27;
	Sat, 13 Jun 2026 21:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1781386400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=puLtiZeoIjP4ZaV2vIYMZ/WAVkToVud8oT6yTS28r+s=;
	b=DumBfl4Z5f51uE9EW0R3vkjodtMOEPEZCgepr+8htGm1Ms2CEvSr3gePubg2NBfvcQQDWs
	DAME3806Lzb34Va0A3JYbkWKlvs0jwp3g9fyyEqp1L+pEkcegnm9wZY0E04qMYvj4LqV6o
	5dapx3jviajzTui5m3XwucvyTZWIET4=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 13 Jun 2026 23:32:57 +0200
Subject: [PATCH batadv] batman-adv: tt: track roam count per VID
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-tt-roam-vid-v1-1-72c702ab5bdb@narfation.org>
X-B4-Tracking: v=1; b=H4sIAIjMLWoC/yWMQQrCMBQFr1Le2g9NLA14FXGRNE/9gq0kMQild
 zfV5QzMrMhMyoxTtyKxatZlbmAOHaa7n28UjY1hezv2ozlKKZIW/5SqURydG6yjZTBoxSvxqp/
 f7Yzgi48Vl7/P7/DgVPYVtu0LTpKJXHcAAAA=
X-Change-ID: 20260613-tt-roam-vid-7e77427e2eb1
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3299; i=sven@narfation.org;
 h=from:subject:message-id; bh=WDJTQ5HbsNig1V/y/i5M+BlJZYkTGMYf3V4IGyo9yd0=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm6Z+b+Usm7mj67ISBLe8nVEt2MDEdWmwtfnM8Lzdu78
 A7Hx7j6jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEKnYxMnxoOiB96O/mOdeu
 Hp4R+/R6gMlP/5Ilf2f3//aXP7Kuz+kDw2827f9TF2T4HjTwsdvb49n44fG9hcIz47Ukb7b5L7m
 +NoUBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 4Y6MNQPN6EZRGUJISMOJI7K6SVD7TEP7
X-Message-ID-Hash: 4Y6MNQPN6EZRGUJISMOJI7K6SVD7TEP7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4Y6MNQPN6EZRGUJISMOJI7K6SVD7TEP7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

batadv_tt_check_roam_count() is supposed to track roaming of a TT entry.
But TT entries are for a MAC + VID. The VID was completely missed and thus
leads to incorrect detection of ROAM counts when a client MAC exists in
multiple VLANs.

Fixes: 580d7919f19e ("batman-adv: add the VLAN ID attribute to the TT entry")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 9 +++++++--
 net/batman-adv/types.h             | 3 +++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 884bb0c0..4a9f876d 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3487,6 +3487,7 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
  * batadv_tt_check_roam_count() - check if a client has roamed too frequently
  * @bat_priv: the bat priv with all the mesh interface information
  * @client: mac address of the roaming client
+ * @vid: VLAN identifier
  *
  * This function checks whether the client already reached the
  * maximum number of possible roaming phases. In this case the ROAMING_ADV
@@ -3494,7 +3495,7 @@ static void batadv_tt_roam_purge(struct batadv_priv *bat_priv)
  *
  * Return: true if the ROAMING_ADV can be sent, false otherwise
  */
-static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
+static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client, u16 vid)
 {
 	struct batadv_tt_roam_node *tt_roam_node;
 	bool ret = false;
@@ -3507,6 +3508,9 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
 		if (!batadv_compare_eth(tt_roam_node->addr, client))
 			continue;
 
+		if (tt_roam_node->vid != vid)
+			continue;
+
 		if (batadv_has_timed_out(tt_roam_node->first_time,
 					 BATADV_ROAMING_MAX_TIME))
 			continue;
@@ -3528,6 +3532,7 @@ static bool batadv_tt_check_roam_count(struct batadv_priv *bat_priv, u8 *client)
 		atomic_set(&tt_roam_node->counter,
 			   BATADV_ROAMING_MAX_COUNT - 1);
 		ether_addr_copy(tt_roam_node->addr, client);
+		tt_roam_node->vid = vid;
 
 		list_add(&tt_roam_node->list, &bat_priv->tt.roam_list);
 		ret = true;
@@ -3564,7 +3569,7 @@ static void batadv_send_roam_adv(struct batadv_priv *bat_priv, u8 *client,
 	/* before going on we have to check whether the client has
 	 * already roamed to us too many times
 	 */
-	if (!batadv_tt_check_roam_count(bat_priv, client))
+	if (!batadv_tt_check_roam_count(bat_priv, client, vid))
 		goto out;
 
 	batadv_dbg(BATADV_DBG_TT, bat_priv,
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index c1b3f989..3de3c1ac 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -1961,6 +1961,9 @@ struct batadv_tt_roam_node {
 	/** @addr: mac address of the client in the roaming phase */
 	u8 addr[ETH_ALEN];
 
+	/** @vid: VLAN identifier */
+	u16 vid;
+
 	/**
 	 * @counter: number of allowed roaming events per client within a single
 	 * OGM interval (changes are committed with each OGM)

---
base-commit: c7518adb8b6ebdc481f6ed1fc42c7f45099806af
change-id: 20260613-tt-roam-vid-7e77427e2eb1

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

