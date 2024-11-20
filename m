Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E778FD711D1
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 17:49:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3DFA884241
	for <batman-adv@archiver.kernel.org>; Wed, 20 Nov 2024 18:49:19 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1732124959;
 b=gKxGKu5KWaBCdjE1nPLxAuGHeSosJN+KngrKFdcIlfSEiHSChaAYvH7SDAOGLk63nzY5i
 AlA5o3lNkLb2UQNzwPLq+JE4QLVMtU4ntnycPJWILw8PcZt1aoiduhEwjhsQkL4oTK/a+Lx
 GfuZy9rFT84aV79R5cLePqdoXz0ovqU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1732124959; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=uuDta22mMh3/kW6qGm+GdNvL9ScEBCVkLdZ9wYo6+Fg=;
 b=nSBWBty0gfB20SYLRSIMpyvOppoEzUUmON2+vdOO4FR7euX61sk034evGy4GoBDPjorIV
 4Bl1SBPwlJ7hkQ/j8sCw+bfSM8TZyAAWcVfON26o9nBCDvT5/sCbfZ3dyy1RVSkU+SJAx8A
 J60zxdeZzeXZ/vzo8IlzPKjQtsGFteg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B97AB82A30
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 Nov 2024 18:48:33 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1732124913; a=rsa-sha256;
	cv=none;
	b=bcAHbfweRJe+4YCv9UROtESlg7i6AM24BP33YKtRsA248YB1bxm/LKfK10q9a8rZ24j+uE
	bhsFatcUU6uVgds8jYCXr5MYz/5+PeXa9XQgeQBGY64noooTyu/Rhys5tEN3E8WfMWC3cw
	Bc5DW3zIw3BYp61OTE0QV9oG0sA9fLQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=jWkZJZ4e;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=XacohgpQ;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.vzze7575m03lk01=lje6e1cb93f7=hm1e4at9iifgls@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.vzze7575m03lk01=lje6e1cb93f7=hm1e4at9iifgls@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1732124913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uuDta22mMh3/kW6qGm+GdNvL9ScEBCVkLdZ9wYo6+Fg=;
	b=CC3SoHjajAu3NMqRiVatX7IVt1rRp9lV1Qz/tyDn3UuhQX6r6XBG7/bEiHSm9ynFvdGYYd
	VKPzlan8ACAogLWAIpk1lrxdrwMKtMiAF7MQCD04/0PCw4UAS/10EBO1GHJjJiERr4ToYh
	i9czusdmQGVrR12nzgWKj4xZyKSPKgI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1732125813; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=uuDta22mMh3/kW6qGm+GdNvL9ScEBCVkLdZ9wYo6+Fg=; b=jWkZJZ4e3omDdavf6wijoKs6Ad
	YtUXjRYkUmR77Map20xtzjHhhsmdntGdUouzK2F+ESZAX3habL0JbR+rAc+0HUOY/xGoHTa5SqmDc
	ECglkT0evqdlZBjqbOtUIBIipRwGI76xtFNPv4pGHPxYLrTEsvq7J7psmEvmXVTkbSHJqM5/hGYHw
	RRnPIpJS7bBWHMMFqfgbN4FQtztTZVy94jLTwF3yo3l8aqnqihe1zauPZzA42iykaruZma1c0YgYd
	Z7kvp+ljzbfkeLXcyvOYWHqIkjVlSMiOiPnb5e+nGsazL2A/JyVYWeiSrz+AxP9kVDKv40R8lwROh
	KYOAoNKA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1732124913; h=from : subject
 : to : message-id : date;
 bh=uuDta22mMh3/kW6qGm+GdNvL9ScEBCVkLdZ9wYo6+Fg=;
 b=XacohgpQ/wVMaDv+jqY3O4qisJ5q9W7mm71C18ZEvCa4bav/zPhtq+dG/LZCzcaxODBG3
 RAKneiH7Jr7ghBwrn+iTeqj8BY2Ss41T3FSn4mmN3YY4XxgMPXX+khd74O1mY0XFa/UtGF6
 IaWe2uAAMnbvI8EkB/duz2SYgBlVopQ55uJNnVfmLb4U8fEiv3BZQNn3lNzPaotm/akqKdX
 jSG2+xYzMEksUR1Rk0YZrpmBVzlFZ0/MhqfLgvlL15esZhidimK5IRJWngQZo8kd3dXOvro
 9seq+I0tw1wU58kkis+Ezf0UVgIS/ZkeiOFf0Vm0lY5Pq1G+3u6Ct0VFGqLQ==
Received: from [10.176.58.103] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tDooa-TRk32O-RD; Wed, 20 Nov 2024 17:48:32 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tDooa-4o5NDgroiyp-qs1D; Wed, 20 Nov 2024 17:48:32 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 2/5] batman-adv: Remove uninitialized data in full table TT
 response
Date: Wed, 20 Nov 2024 18:47:15 +0100
Message-Id: 
 <0368cc2fc6c7719a40a52eeab3c1c6458fc3ebe4.1732124716.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1732124716.git.repk@triplefau.lt>
References: <cover.1732124716.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: 73t7InSWz92z.UIDbskFXiClb.Vh1pAwcTlJQ
Feedback-ID: 510616m:510616apGKSTK:510616sceH-Ee0K2
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: 4QVLTEANU3QH2QWS3DL663IGVTGGMJAW
X-Message-ID-Hash: 4QVLTEANU3QH2QWS3DL663IGVTGGMJAW
X-MailFrom: 
 bT.vzze7575m03lk01=lje6e1cb93f7=hm1e4at9iifgls@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4QVLTEANU3QH2QWS3DL663IGVTGGMJAW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The number of entries filled by batadv_tt_tvlv_generate() can be less
than initially expected in batadv_tt_prepare_tvlv_{global,local}_data()
(changes can be removed by batadv_tt_local_event() in ADD+DEL sequence
in the meantime as the lock held during the whole tvlv global/local data
generation).

Thus tvlv_len could be bigger than the actual TT entry size that need
to be sent so full table TT_RESPONSE could hold invalid TT entries such
as below.

 * 00:00:00:00:00:00   -1 [....] (  0) 88:12:4e:ad:7e:ba (179) (0x45845380)
 * 00:00:00:00:78:79 4092 [.W..] (  0) 88:12:4e:ad:7e:3c (145) (0x8ebadb8b)

Remove the extra allocated space to avoid sending uninitialized entries
for full table TT_RESPONSE in both batadv_send_other_tt_response() and
batadv_send_my_tt_response().

Fixes: 7ea7b4a14275 ("batman-adv: make the TT CRC logic VLAN specific")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/batman-adv/translation-table.c | 37 ++++++++++++++++++------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index f0590f9bc2b1..bbab7491c83f 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2754,14 +2754,16 @@ static bool batadv_tt_global_valid(const void *entry_ptr,
  *
  * Fills the tvlv buff with the tt entries from the specified hash. If valid_cb
  * is not provided then this becomes a no-op.
+ *
+ * Return: Remaining unused length in tvlv_buff.
  */
-static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
-				    struct batadv_hashtable *hash,
-				    void *tvlv_buff, u16 tt_len,
-				    bool (*valid_cb)(const void *,
-						     const void *,
-						     u8 *flags),
-				    void *cb_data)
+static u16 batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
+				   struct batadv_hashtable *hash,
+				   void *tvlv_buff, u16 tt_len,
+				   bool (*valid_cb)(const void *,
+						    const void *,
+						    u8 *flags),
+				   void *cb_data)
 {
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct batadv_tvlv_tt_change *tt_change;
@@ -2775,7 +2777,7 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 	tt_change = tvlv_buff;
 
 	if (!valid_cb)
-		return;
+		return tt_len;
 
 	rcu_read_lock();
 	for (i = 0; i < hash->size; i++) {
@@ -2801,6 +2803,8 @@ static void batadv_tt_tvlv_generate(struct batadv_priv *bat_priv,
 		}
 	}
 	rcu_read_unlock();
+
+	return batadv_tt_len(tt_tot - tt_num_entries);
 }
 
 /**
@@ -3076,10 +3080,11 @@ static bool batadv_send_other_tt_response(struct batadv_priv *bat_priv,
 			goto out;
 
 		/* fill the rest of the tvlv with the real TT entries */
-		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.global_hash,
-					tt_change, tt_len,
-					batadv_tt_global_valid,
-					req_dst_orig_node);
+		tvlv_len -= batadv_tt_tvlv_generate(bat_priv,
+						    bat_priv->tt.global_hash,
+						    tt_change, tt_len,
+						    batadv_tt_global_valid,
+						    req_dst_orig_node);
 	}
 
 	/* Don't send the response, if larger than fragmented packet. */
@@ -3203,9 +3208,11 @@ static bool batadv_send_my_tt_response(struct batadv_priv *bat_priv,
 			goto out;
 
 		/* fill the rest of the tvlv with the real TT entries */
-		batadv_tt_tvlv_generate(bat_priv, bat_priv->tt.local_hash,
-					tt_change, tt_len,
-					batadv_tt_local_valid, NULL);
+		tvlv_len -= batadv_tt_tvlv_generate(bat_priv,
+						    bat_priv->tt.local_hash,
+						    tt_change, tt_len,
+						    batadv_tt_local_valid,
+						    NULL);
 	}
 
 	tvlv_tt_data->flags = BATADV_TT_RESPONSE;
-- 
2.40.0

