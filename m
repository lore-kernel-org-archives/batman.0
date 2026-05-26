Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C99DCD5BB1
	for <batman-adv@archiver.kernel.org>; Tue, 26 May 2026 20:06:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7990A83DBA
	for <batman-adv@archiver.kernel.org>; Tue, 26 May 2026 22:06:50 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779826010;
 b=vOA/RbNMFHqvCoz0qbpQOwezd+oZqjS6ABEdGsnMwCOhMWSMb4bjZND5IyEbmAGUMztas
 sK+1Q/4XU46pWAPhqq96xLJslNRITYqXaJclZDHaPl2yJOmG8CAirKNSI4rJ+I62Awd7MkH
 Qr3VPcdgZ7nBbF7j/hYnVkRSiT9Dl7g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779826010; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rIxT03KQp5QT84JPnmJBJ1noHlhUKtvzU2vsvA262Kw=;
 b=AQAD0wotXjUF6pv2XFquZ0P+p7om3T3NvszKc8/qNBfJtVeOa3fH0IxwFLB/IP0GN2BJ4
 UhD4WhRMzgEXkXZuZW8Zbimlz7H+EEMPjnHExRvvwfk747rL8xMsKwUGLhWs9oFsXdT23eT
 qWZRwbnkLTGaUREnDHMEygBwAQwCAgI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id AE07180DBE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 26 May 2026 22:06:19 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779825979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=rIxT03KQp5QT84JPnmJBJ1noHlhUKtvzU2vsvA262Kw=;
	b=GvpjFSPQdPUcg1Mt5Haq+rN7HhjTnHQ7PWJ9bcfj/S2WcVyjZJOJXSrycqmbKY3Tfi+b6t
	v+Ae7MvqgLcj3UI3kLp/CuYrLakp/SRifjQVqiITGmWr1OXMeZr3rT8ZawU7MJWEimN657
	+Yw7pvyPcaOhtmZ+qg1LBcGCWeUZm/g=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779825979;
	b=LhcrW7J46RZrqejBlldimmFijXbrZF/4fCogvZYvOGPCL3jLjMRQlqywCp6IR0psTYlmTv
	Q5WKQqBU7PCe7qcNgfN1aFAeRsnz0ujfguQ6oyZgW6VxPkiUz81J4l0k6jI6JI6jks24PE
	AfUOdOYAqdUCtt2OJ6J0mpif0TQke00=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=bkW8tcb7;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 0EAE61FDD5;
	Tue, 26 May 2026 20:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779825974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rIxT03KQp5QT84JPnmJBJ1noHlhUKtvzU2vsvA262Kw=;
	b=bkW8tcb7f2Fg7OINMkFsMEkn7w0/Epekxnc4kIderSzdxgYIJuU+NevdFAM1s8stPCojds
	zMWdriFHHQ18ZdCpa7+AgqoiplwYwcGB8MDJRSjEUe6B38HlD6YUKgagCNt13O/w1/zkxp
	+ssI2pV9ZNXuo3kqnrcqB/ft857Hlyo=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 26 May 2026 22:06:00 +0200
Subject: [PATCH batadv] batman-adv: bla: annotate lasttime access with
 READ/WRITE_ONCE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-lasttime-once-v1-1-8fa43079b5fc@narfation.org>
X-B4-Tracking: v=1; b=H4sIACf9FWoC/yWMwQrCMBAFf6Xs2UBdMaK/Ih426bNd0VSysRRK/
 71RjzMws5AhK4wuzUIZk5qOqcJ+11AcJPVw2lUmbtm3R/buKVaKvuDGFOG8HDhCTmcEptq8M+4
 6/35XClKkm+j29/YJD8TyndG6bpuQ1cp5AAAA
X-Change-ID: 20260526-lasttime-once-6a32cea79eb2
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5768; i=sven@narfation.org;
 h=from:subject:message-id; bh=ptGZkStfZH823K+Kw5fGAqbKxHkKSyKTPKY6yGFSKQ4=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmifw2Mzl/YM5+9aZf2r7KSxcoXFp8VjtstOmFBlcWro
 EdLPu2U7ShlYRDjYpAVU2TZcyX//Gb2t/Kfp308CjOHlQlkCAMXpwBMpEea4RfTCsWTeWk6Susb
 z1+NtG+7t/XEAz//1OcHlkbq+dy2U5zD8Id/WUazxZbgUu56hTkTK6SYS+8J7ah/0COcvHzN8QZ
 pBmYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: I4FRP44VS5HZFVLNNC7BY6EK2EUY4JS7
X-Message-ID-Hash: I4FRP44VS5HZFVLNNC7BY6EK2EUY4JS7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/I4FRP44VS5HZFVLNNC7BY6EK2EUY4JS7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The lasttime field for claim, backbone_gw, and loopdetect tracks the
jiffies value of the most recent activity and is used to detect timeouts.
These accesses are not consistently protected by a lock, so
READ_ONCE/WRITE_ONCE must be used to prevent data races caused by compiler
optimizations.

Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/bridge_loop_avoidance.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index ffe85401..7f643de4 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -512,7 +512,7 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 		return NULL;
 
 	entry->vid = vid;
-	entry->lasttime = jiffies;
+	WRITE_ONCE(entry->lasttime, jiffies);
 	entry->crc = BATADV_BLA_CRC_INIT;
 	entry->bat_priv = bat_priv;
 	spin_lock_init(&entry->crc_lock);
@@ -580,7 +580,7 @@ batadv_bla_update_own_backbone_gw(struct batadv_priv *bat_priv,
 	if (unlikely(!backbone_gw))
 		return;
 
-	backbone_gw->lasttime = jiffies;
+	WRITE_ONCE(backbone_gw->lasttime, jiffies);
 	batadv_backbone_gw_put(backbone_gw);
 }
 
@@ -714,7 +714,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 		ether_addr_copy(claim->addr, mac);
 		spin_lock_init(&claim->backbone_lock);
 		claim->vid = vid;
-		claim->lasttime = jiffies;
+		WRITE_ONCE(claim->lasttime, jiffies);
 		kref_get(&backbone_gw->refcount);
 		claim->backbone_gw = backbone_gw;
 		kref_init(&claim->refcount);
@@ -736,7 +736,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 			return;
 		}
 	} else {
-		claim->lasttime = jiffies;
+		WRITE_ONCE(claim->lasttime, jiffies);
 		if (claim->backbone_gw == backbone_gw)
 			/* no need to register a new backbone */
 			goto claim_free_ref;
@@ -769,7 +769,7 @@ static void batadv_bla_add_claim(struct batadv_priv *bat_priv,
 	spin_lock_bh(&backbone_gw->crc_lock);
 	backbone_gw->crc ^= crc16(0, claim->addr, ETH_ALEN);
 	spin_unlock_bh(&backbone_gw->crc_lock);
-	backbone_gw->lasttime = jiffies;
+	WRITE_ONCE(backbone_gw->lasttime, jiffies);
 
 claim_free_ref:
 	batadv_claim_put(claim);
@@ -858,7 +858,7 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 		return true;
 
 	/* handle as ANNOUNCE frame */
-	backbone_gw->lasttime = jiffies;
+	WRITE_ONCE(backbone_gw->lasttime, jiffies);
 	crc = ntohs(*((__force __be16 *)(&an_addr[4])));
 
 	batadv_dbg(BATADV_DBG_BLA, bat_priv,
@@ -1253,7 +1253,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 						  head, hash_entry) {
 				if (now)
 					goto purge_now;
-				if (!batadv_has_timed_out(backbone_gw->lasttime,
+				if (!batadv_has_timed_out(READ_ONCE(backbone_gw->lasttime),
 							  BATADV_BLA_BACKBONE_TIMEOUT))
 					continue;
 
@@ -1334,7 +1334,7 @@ static void batadv_bla_purge_claims(struct batadv_priv *bat_priv,
 						primary_if->net_dev->dev_addr))
 				goto skip;
 
-			if (!batadv_has_timed_out(claim->lasttime,
+			if (!batadv_has_timed_out(READ_ONCE(claim->lasttime),
 						  BATADV_BLA_CLAIM_TIMEOUT))
 				goto skip;
 
@@ -1494,7 +1494,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 		eth_random_addr(bat_priv->bla.loopdetect_addr);
 		bat_priv->bla.loopdetect_addr[0] = 0xba;
 		bat_priv->bla.loopdetect_addr[1] = 0xbe;
-		bat_priv->bla.loopdetect_lasttime = jiffies;
+		WRITE_ONCE(bat_priv->bla.loopdetect_lasttime, jiffies);
 		atomic_set(&bat_priv->bla.loopdetect_next,
 			   BATADV_BLA_LOOPDETECT_PERIODS);
 
@@ -1515,7 +1515,7 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 						primary_if->net_dev->dev_addr))
 				continue;
 
-			backbone_gw->lasttime = jiffies;
+			WRITE_ONCE(backbone_gw->lasttime, jiffies);
 
 			batadv_bla_send_announce(bat_priv, backbone_gw);
 			if (send_loopdetect)
@@ -1899,7 +1899,7 @@ batadv_bla_loopdetect_check(struct batadv_priv *bat_priv, struct sk_buff *skb,
 	/* If the packet came too late, don't forward it on the mesh
 	 * but don't consider that as loop. It might be a coincidence.
 	 */
-	if (batadv_has_timed_out(bat_priv->bla.loopdetect_lasttime,
+	if (batadv_has_timed_out(READ_ONCE(bat_priv->bla.loopdetect_lasttime),
 				 BATADV_BLA_LOOPDETECT_TIMEOUT))
 		return true;
 
@@ -2014,7 +2014,7 @@ bool batadv_bla_rx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 
 	if (own_claim) {
 		/* ... allow it in any case */
-		claim->lasttime = jiffies;
+		WRITE_ONCE(claim->lasttime, jiffies);
 		goto allow;
 	}
 
@@ -2116,7 +2116,7 @@ bool batadv_bla_tx(struct batadv_priv *bat_priv, struct sk_buff *skb,
 		/* if yes, the client has roamed and we have
 		 * to unclaim it.
 		 */
-		if (batadv_has_timed_out(claim->lasttime, 100)) {
+		if (batadv_has_timed_out(READ_ONCE(claim->lasttime), 100)) {
 			/* only unclaim if the last claim entry is
 			 * older than 100 ms to make sure we really
 			 * have a roaming client here.
@@ -2361,7 +2361,7 @@ batadv_bla_backbone_dump_entry(struct sk_buff *msg, u32 portid,
 	backbone_crc = backbone_gw->crc;
 	spin_unlock_bh(&backbone_gw->crc_lock);
 
-	msecs = jiffies_to_msecs(jiffies - backbone_gw->lasttime);
+	msecs = jiffies_to_msecs(jiffies - READ_ONCE(backbone_gw->lasttime));
 
 	if (is_own)
 		if (nla_put_flag(msg, BATADV_ATTR_BLA_OWN)) {

---
base-commit: ec9f686b42917e9b67725d7245b50de72f59fa9e
change-id: 20260526-lasttime-once-6a32cea79eb2

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

