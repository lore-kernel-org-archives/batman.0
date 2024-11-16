Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A48D68BF1
	for <batman@archiver.kernel.org>; Sat, 16 Nov 2024 21:34:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5D3D38415E
	for <batman@archiver.kernel.org>; Sat, 16 Nov 2024 22:34:47 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731792887;
 b=NqQ9HliP2brSMy2PSNN9+rERsaeow7sdqNZKDqYEHerIVJ6bh7bptm1+sVQrRsnwcupv3
 9HU8gZDXToBugxM702Jfb39YvFFPleu91YfMmtHtPJQ3cygQn6Lv8rZKxAknu9U8pdgtUxd
 XXf6cbxUM0xD9fnjyFKfuUaRRpuBmnE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731792887; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=uuDta22mMh3/kW6qGm+GdNvL9ScEBCVkLdZ9wYo6+Fg=;
 b=VvZ374Otnsvi/t5JMthXxhtzfzhcXVRXN5dqFooP/I5HCFluitfcIJTT6f1k67lK3EPHf
 CKUyT1XobK0+GsujQw+LuSLNm53mDV1WuLfBak/LXKl59srvTka47sGUiql0G93XgJSpW7j
 3nnOFuQATVQjXVsDSK2zgQVw/bIgUlc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail header.d=smtpservice.net;
  arc=pass;
  dmarc=fail (Used From Domain Record) header.from=triplefau.lt
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=fail header.d=smtpservice.net;
 arc=pass;
 dmarc=fail (Used From Domain Record) header.from=triplefau.lt policy.dmarc=quarantine
Received: from e2i340.smtp2go.com (e2i340.smtp2go.com [103.2.141.84])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CB39283597
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 16 Nov 2024 22:33:14 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731792795; a=rsa-sha256;
	cv=none;
	b=hKmTpo/bEYK+29ftKaDqz7xoPYz0mWSFBvhcdM+Ui1U7OFtsiwKMF5c27cLz0QHmmzV4lE
	9UONUrJdk+C3heVlZuKRpKIjfF57DHyYxJ7J2+j4AmZPc/GT8+im2XpLQvVtveWk/BQKpk
	xg1bH9/6f1pzxFiqqzsfha7GS43wIRE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none ("invalid DKIM record") header.d=smtpservice.net
 header.s=maxzs0.a1-4.dyn header.b=wRrwTKAr;
	dkim=pass header.d=triplefau.lt header.s=s510616 header.b=K4ypuHhH;
	dmarc=pass (policy=quarantine) header.from=triplefau.lt;
	spf=pass (diktynna.open-mesh.org: domain of
 "bT.4rsol2zghb5jkt7=9bnqja2rk49o=55h8uyuxhbcnar@em510616.triplefau.lt"
 designates 103.2.141.84 as permitted sender)
 smtp.mailfrom="bT.4rsol2zghb5jkt7=9bnqja2rk49o=55h8uyuxhbcnar@em510616.triplefau.lt"
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731792795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=uuDta22mMh3/kW6qGm+GdNvL9ScEBCVkLdZ9wYo6+Fg=;
	b=uecU6QR8gug20tqbprwaejCUgbW9Nplnel/e+Uc+RDikLr0YklBe6LUok+610wJiOcl1at
	439bpDZtJP9m0GlxxReJCj6tu39MesBvJEUm9/2XkXWBSYCNc5hDkWMm8eCvwqIY+O6tM2
	MtanwLEM8RjKDKqlrZINPvvBbUFPHlo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=smtpservice.net; s=maxzs0.a1-4.dyn; x=1731793694; h=Feedback-ID:
	X-Smtpcorp-Track:Message-Id:Date:Subject:To:From:Reply-To:Sender:
	List-Unsubscribe:List-Unsubscribe-Post;
	bh=uuDta22mMh3/kW6qGm+GdNvL9ScEBCVkLdZ9wYo6+Fg=; b=wRrwTKArRcGhrfeqh3VyELrUyw
	ZUfkiqsQozn6vlAM4JyglSGT8nbVv+Rs8QpBrCZWvJ5KS4sLVu91hfZnvX+7uIuL3xMmKginn2v2d
	/nFDB9STyhbbyyVoOZbIrF23hBohs9YS+ymXDgQM5xzluWqrzfzaksebeCy7xMPQm+E1dDuYDAnmt
	6KjraBvk+wnJMBNXTCebl8qzZ4iOfqndqYt8rXgwQOBi0xs5DsflENZJ5zc1ZK2AGEh50MtJNk4b4
	iK7Rx4Y4uujAnJbh7uJyV5tCdkngfuYQzscLZQNCYzJWn3MwbFk8E+KXd5dMxDkcsXrM7jjD30e3p
	v/RImzlg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1731792794; h=from : subject
 : to : message-id : date;
 bh=uuDta22mMh3/kW6qGm+GdNvL9ScEBCVkLdZ9wYo6+Fg=;
 b=K4ypuHhHl+AH7gLrPwNEKK29L6aFxgA36yI7PBgJd6i3cnCWE+yqGa1bmhljpS7sfw/XD
 QIjthA51jSutE9xHiee/C3YuDtzrHAZgceeNPgF3BxDjg5/RRTmUBGgyXo//Kfjy+fcf0CG
 BZLI3RMnx/aaA3VOv93nYAvLPSkqEHRQ1yGj92onmsL1aStaz3w6jToWI2vsPm7DzmekZbl
 AOYdeQTF9li6KDoAbFl2ur04GcAlw2qfH0JJLW/7GKUUQQb2izCFwe1Cv8ayx4hW9ALj3in
 JRXa/X+YR8bjAY/5NWs8pWnDquCdjr5kKI1vLTbjEKmXejLa8YbZTi8r1tRA==
Received: from [10.172.233.58] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94.2-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tCQPp-TRk3uC-UL; Sat, 16 Nov 2024 21:33:13 +0000
Received: from [10.12.239.196] (helo=localhost) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.97.1-S2G) (envelope-from <repk@triplefau.lt>)
 id 1tCQPp-FnQW0hPpSTZ-mYjE; Sat, 16 Nov 2024 21:33:13 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <a@unstable.cc>, Sven Eckelmann <sven@narfation.org>,
 Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v2 2/5] batman-adv: Remove uninitialized data in full table TT
 response
Date: Sat, 16 Nov 2024 22:32:06 +0100
Message-Id: 
 <0368cc2fc6c7719a40a52eeab3c1c6458fc3ebe4.1731792497.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <cover.1731792497.git.repk@triplefau.lt>
References: <cover.1731792497.git.repk@triplefau.lt>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Smtpcorp-Track: sMxJmqXPIHTn.G2UHnx8ot6Ja.efTBFAhwJui
Feedback-ID: 510616m:510616apGKSTK:510616sNo-S-f3w4
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Message-ID-Hash: BQ3QKOF6PW6MT47EM6O2WHTRSK2CXEQT
X-Message-ID-Hash: BQ3QKOF6PW6MT47EM6O2WHTRSK2CXEQT
X-MailFrom: 
 bT.4rsol2zghb5jkt7=9bnqja2rk49o=55h8uyuxhbcnar@em510616.triplefau.lt
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BQ3QKOF6PW6MT47EM6O2WHTRSK2CXEQT/>
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

