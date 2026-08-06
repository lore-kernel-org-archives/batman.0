Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9E78C55ABF
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 07:43:50 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 76A7484290
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 09:43:49 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786002229;
 b=CC735+mAeN+S5sW/rVhF0rTEt3swUdDRubVZeCv0IMFb/px3TlFNnmiccC9oOSR8Q4Ih3
 VGpQwWEdaiNCrZJgHtAP6kZQArofHl3pXEFXAo0/pANpJ3FECwpcFWmh6/x1Jc7YxxQ0PZ7
 BMt2GTlt+HXScI0Kw2wFJtyLFVq5uo8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786002229; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ySyPelc7Z0vx8SSFi15BU5TocuNea9dhUMNWabrGkDw=;
 b=jZDZW54QNRKH3uvgHz2yaMStmhgNPchNV524HFLV10nLp3A8BRkVm5uzThADAbLWz3K3n
 Kbalv8Rupt6+mXUBiIM5kZ1GlhryCPz+mlxrcoIMmh6PfT8hnbJokgOLvCKerGmaDJ6kq3h
 0TjIt7Tn95b7OdZv2LbjZtSY7ZFY/l8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3542784227
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 09:42:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786002131;
	b=Jyd7UgkOP3GQEHIZFkRRxC16B41WmtWiR135ocoVSQ/XKw6AbvRqtpndoELWs+swLGC8mB
	jZZ30pBXXefoenChCOEyNmtel+ubDBn1jNjfFlf6fiDX+Uh8SCnp07epK6Gmy1GZepRAqv
	ovN+p2sr5TUOWO7KaQgRLMubQR8ENt4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786002131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ySyPelc7Z0vx8SSFi15BU5TocuNea9dhUMNWabrGkDw=;
	b=EBQTdvFONZGsiKDVxOCgSYNZhDCtwbnOW9WTyyfB6YJgGcOrozMKkBapnkz0+kvRVh9hUI
	n6eCpbSUacW+VeRYzbqeQ494BpfguvMl8lZbkh7OWJYMbVI6xvoI78Q3NGvwK6orRLn+hc
	BIAZ99O9/NC+DuisZGlXAyvGv35mRwU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nRAzn4xX;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id C0E5F20590;
	Thu, 06 Aug 2026 07:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786002126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ySyPelc7Z0vx8SSFi15BU5TocuNea9dhUMNWabrGkDw=;
	b=nRAzn4xX+sSyg8JxOLrN5tYX4Hx8WQtf7+ibCgPsPwm/E9tJFkA1eNFRzap3XlxTR67YfJ
	D7WUyePmxgY8RLk03JauhUTTXq1U+CjbKuv9+JJOKwaePhRc88O5TkHN6X3oMNV5HIOiSH
	tlIv8J9JqSU0pfqUJBCH4rwlnCLutKM=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 09:41:28 +0200
Subject: [PATCH RFC batadv v4 3/8] batman-adv: tt: simplify NEW flag
 transition code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-fixes-v4-3-c2fc871fe807@narfation.org>
References: <20260806-tt-fixes-v4-0-c2fc871fe807@narfation.org>
In-Reply-To: <20260806-tt-fixes-v4-0-c2fc871fe807@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2662; i=sven@narfation.org;
 h=from:subject:message-id; bh=hGkYlfEMJKwYcVg2ekLUL+5O8TOQCG+hggRkrQOAtAo=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFklVqs92LTkQxsfyyUfSeDekHfZk+Pjua5fsdL1lzZ9U
 b/mJL+2o5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRr8oMv1lSv982PhN5r2FR
 4xXTFZWv/3O33Hx7UUFVjuGt6LHJYqsY/het6WlOEpLLM/v81+PQDgcGLaW/WovOcL24+K3thVe
 nJhMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: 2WRN7KHUIR66QDMLSWDSZSKSDTWPGZ7E
X-Message-ID-Hash: 2WRN7KHUIR66QDMLSWDSZSKSDTWPGZ7E
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2WRN7KHUIR66QDMLSWDSZSKSDTWPGZ7E/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The function batadv_tt_local_set_flags() implements support for various
flags and to set/unset them. It is also possible to decide whether this
change should increase the TT size or not.

But in reality, this function is only used to transition tt local entries
from the NEW state and count these entries. Remove the rest of the code to
simplify the function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 2a1d8963..5f0f7fb6 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3868,15 +3868,11 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
 }
 
 /**
- * batadv_tt_local_set_flags() - set or unset the specified flags on the local
- *  table and possibly count them in the TT size
+ * batadv_tt_local_transition_new() - unset the NEW flag on the local
+ *  table and count them in the TT size
  * @bat_priv: the bat priv with all the mesh interface information
- * @flags: the flag to switch
- * @enable: whether to set or unset the flag
- * @count: whether to increase the TT size by the number of changed entries
  */
-static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
-				      bool enable, bool count)
+static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 {
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
@@ -3892,19 +3888,11 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 		rcu_read_lock();
 		hlist_for_each_entry_rcu(tt_common_entry,
 					 head, hash_entry) {
-			if (enable) {
-				if ((tt_common_entry->flags & flags) == flags)
-					continue;
-				tt_common_entry->flags |= flags;
-			} else {
-				if (!(tt_common_entry->flags & flags))
-					continue;
-				tt_common_entry->flags &= ~flags;
-			}
-
-			if (!count)
+			if (!(tt_common_entry->flags & BATADV_TT_CLIENT_NEW))
 				continue;
 
+			tt_common_entry->flags &= ~BATADV_TT_CLIENT_NEW;
+
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->vid);
 		}
@@ -3977,7 +3965,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 		return;
 	}
 
-	batadv_tt_local_set_flags(bat_priv, BATADV_TT_CLIENT_NEW, false, true);
+	batadv_tt_local_transition_new(bat_priv);
 
 	batadv_tt_local_purge_pending_clients(bat_priv);
 	batadv_tt_local_update_crc(bat_priv);

-- 
2.47.3

