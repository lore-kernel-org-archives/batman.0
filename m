Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 446D1CD4F26
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 07:29:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 81FEC85837
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 09:29:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778570970;
 b=sMIOxHK+FhNbkaPhnyQwDFk5Oj2QcMVwpg4UywGe6W5wZm6v1j7Intw1DL2NrjkVpoz+N
 mSEtysLahJmmm6uJtXPa5MOKIcYuiRrKzWZYcDARd5I1Xlwc4rZGSy6N6DXQOpL70OFIRfZ
 Nih6RcHrwWanYoy0zR0jPCxRLWYNLgg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778570970; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=eN+fBC4ZOpY7A2RJf8ufRp0jFwFuM7oDlr2FHpPnDrE=;
 b=NgrKvW5jfF3PMwUYuMUeqWsoHpmgs0V6irbHGfq2P/5BM5KYtM3mfq/tls0GPX6IOwPJz
 Is9YrbvmDH51HUHyyNNe9IlQS30ef3L0wTQUtBRM24TOvtFKE8Mu7/h8BDt+gQYJVSy7teQ
 rUbz9APy/PuQeoaFlZ++aGTrva1JYCc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 25B0981AA0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 May 2026 09:28:57 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778570947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=eN+fBC4ZOpY7A2RJf8ufRp0jFwFuM7oDlr2FHpPnDrE=;
	b=eitGEojCFVruzavsf0jYHPPE2/s91TKQjTc1lZrS2B5w6J048lECiY/vuUeQBe7wxq13M+
	wQwCVW+Vnr71Bn+3qvs9aeLD9Sy28vhRtaCTfA7eaISzZR+M5j8d/o+FPFD3OrKh3Gv3Z5
	t3YjjcJI+N7VrTF0D82+79NjSwTTGcE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Y1Dqtkr+;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778570947;
	b=r1YCojYQ4mQN+fAGZEwvBnjclx9pQVe4NYnx11Ur38JRKr1t0pTuS38TUz4R6zzyh4TdZV
	t4+L15hDMkT1Yk+Hp+DzWeLaEkQ+utO3r1xOzTEhatMvQ+9DUzqnVQ9yuaz6EMwBsoOHGL
	b2AJQr8v6Aq/jb+UlFUe5jAcXDGIKjQ=
Received: by dvalin.narfation.org (Postfix) id D43FE2035D;
	Tue, 12 May 2026 07:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778570935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eN+fBC4ZOpY7A2RJf8ufRp0jFwFuM7oDlr2FHpPnDrE=;
	b=Y1Dqtkr+mYGwZnuKrzWzqTxUKi02kR3Z70BXgMVktmXU/IzafxxUNeFAKuy7Aj9kZ9qqt7
	BlP+cYdBwBg41VDRYHopj7qC6p3gc5YN2YZ7zeRJhdNlX9urOPC5hbagORgH3d4Mwas1t6
	mlUIOWYHkHF2/wtNGujs024HaJjqfBc=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 12 May 2026 09:28:52 +0200
Subject: [PATCH RFC batadv] batman-adv: bla: avoid double decrement of
 bla.num_requests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-bla-atomic-request_sent-v1-1-0b207bccf9ef@narfation.org>
X-B4-Tracking: v=1; b=H4sIALPWAmoC/yWMQQrCMBAAvxL2bCAJVKpXwQd4FZFNutEVTWs2L
 ULp3xv1OAwzMwhlJoG9miHTxMJ9qmA3CsId0400d5XBGbc1jXXaP1Fj6V8cdKb3SFKuQqnoSOR
 30aJpQwO1HjJF/vzOZzgdD8pjwW6Cy9/J6B8UyncNy7ICMNAeTocAAAA=
X-Change-ID: 20260512-bla-atomic-request_sent-feeb9f1a08c5
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: sw@simonwunderlich.de, Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3826; i=sven@narfation.org;
 h=from:subject:message-id; bh=8O0+fG1HmRwOPb5pwf9qZm8myzENbp6Eo8mc2DpvsRw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlM17ZGZV073BjyyOuKxyvTk3N7zu9bffTNP4tj5kHKN
 6L3ZG3d1FHKwiDGxSArpsiy50r++c3sb+U/T/t4FGYOKxPIEAYuTgGYyJEpjAz7EqSFTkTn3zY9
 z7G5yvtj2/6e2js5LnWsskG7TsiWLLzAyND3t8dXY/nBGrkJ3atyup5N4p6yZ2fwqXWvJ9yvnBQ
 aI88KAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JBRP36LAAPAATKIIBKI45IWYKGSNPJAT
X-Message-ID-Hash: JBRP36LAAPAATKIIBKI45IWYKGSNPJAT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JBRP36LAAPAATKIIBKI45IWYKGSNPJAT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The bla.num_requests is increased when a no request_sent was in progress.
And it is decremented in various places (announcemnt was received, backbone
is purged, periodic work). But the check if the request_sent is actually
set to a specific state and the atomic_dec/_inc are not safe because they
are not atomic (TOCTOU) and multiple such code portions can run
concurrently.

This can be avoided by atomically replacing the request_sent state while
checking the previous value. Only if the previous value was not actually in
the correct state then the atomic_dec/_inc can be performed on
bla.num_requests.

Fixes: a9ce0dc43e2c ("batman-adv: add basic bridge loop avoidance code")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Please consider this as a note what might have to be done. This is
completely untested.

Especially think about batadv_bla_purge_backbone_gw - the old code confused
me a lot and the new one might therefore be wrong.

See
https://sashiko.dev/#/patchset/20260510-bla-cancel-work-v1-1-3654903495ef@narfation.org?part=1
---
 net/batman-adv/bridge_loop_avoidance.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index cec11f12..cc9ed2fb 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -544,9 +544,10 @@ batadv_bla_get_backbone_gw(struct batadv_priv *bat_priv, const u8 *orig,
 		batadv_bla_send_announce(bat_priv, entry);
 
 		/* this will be decreased in the worker thread */
-		atomic_inc(&entry->request_sent);
-		atomic_set(&entry->wait_periods, BATADV_BLA_WAIT_PERIODS);
-		atomic_inc(&bat_priv->bla.num_requests);
+		if (atomic_xchg(&entry->request_sent, 1) == 0) {
+			atomic_set(&entry->wait_periods, BATADV_BLA_WAIT_PERIODS);
+			atomic_inc(&bat_priv->bla.num_requests);
+		}
 	}
 
 	return entry;
@@ -649,10 +650,8 @@ static void batadv_bla_send_request(struct batadv_bla_backbone_gw *backbone_gw)
 			      backbone_gw->vid, BATADV_CLAIM_TYPE_REQUEST);
 
 	/* no local broadcasts should be sent or received, for now. */
-	if (!atomic_read(&backbone_gw->request_sent)) {
+	if (atomic_xchg(&backbone_gw->request_sent, 1) == 0)
 		atomic_inc(&backbone_gw->bat_priv->bla.num_requests);
-		atomic_set(&backbone_gw->request_sent, 1);
-	}
 }
 
 /**
@@ -873,10 +872,8 @@ static bool batadv_handle_announce(struct batadv_priv *bat_priv, u8 *an_addr,
 		/* if we have sent a request and the crc was OK,
 		 * we can allow traffic again.
 		 */
-		if (atomic_read(&backbone_gw->request_sent)) {
+		if (atomic_xchg(&backbone_gw->request_sent, 0) != 0)
 			atomic_dec(&backbone_gw->bat_priv->bla.num_requests);
-			atomic_set(&backbone_gw->request_sent, 0);
-		}
 	}
 
 	batadv_backbone_gw_put(backbone_gw);
@@ -1249,7 +1246,7 @@ static void batadv_bla_purge_backbone_gw(struct batadv_priv *bat_priv, int now)
 
 purge_now:
 			/* don't wait for the pending request anymore */
-			if (atomic_read(&backbone_gw->request_sent))
+			if (atomic_xchg(&backbone_gw->request_sent, 0) != 0)
 				atomic_dec(&bat_priv->bla.num_requests);
 
 			batadv_bla_del_backbone_claims(backbone_gw);
@@ -1507,8 +1504,10 @@ static void batadv_bla_periodic_work(struct work_struct *work)
 			if (!atomic_dec_and_test(&backbone_gw->wait_periods))
 				continue;
 
+			if (atomic_xchg(&backbone_gw->request_sent, 0) == 0)
+				continue;
+
 			atomic_dec(&backbone_gw->bat_priv->bla.num_requests);
-			atomic_set(&backbone_gw->request_sent, 0);
 		}
 		rcu_read_unlock();
 	}

---
base-commit: 57c6af492c1948145db835bb3ea2980472558298
change-id: 20260512-bla-atomic-request_sent-feeb9f1a08c5

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

