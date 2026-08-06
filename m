Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21536C55ABF
	for <batman-adv@archiver.kernel.org>; Thu,  6 Aug 2026 07:45:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ADE808427A
	for <batman-adv@archiver.kernel.org>; Thu, 06 Aug 2026 09:45:30 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1786002330;
 b=DptQ6Z9m5L587F/GqHOOrO6Ft/22uRJvxk4YVJtzPVl5b61XOmStQkstsbLhYwRA95Zf7
 HMs2UBKN5H66raEGBWugWB46CYmEyhS0OG4cFRRqlR/j+kRD0l/mB5S7QafzOLxZ/HKXqzS
 zxXI3WigESwJr7I9Xr2T5gO1HlUAXa0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1786002330; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zYvCdjuOH1vATqd1p3bKrxMCuiCXEdyz9cYFfemGdUM=;
 b=PQJigWosL90wWm0xttigOkPAbFhGpTdrEzjG8DtEjkqwVq3HZP9YUtC0inaEAMvUSfClY
 uW7h8NiN4iLaiCoGNtw+mSAOnXpiHfC2h0tEJaAMNhQAZyt2Gs2YXCQhAies5ZpnUUjhloC
 WNKQq3caYofLCQH491lWHBpzIVtFh60=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 548DD8424B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 06 Aug 2026 09:42:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1786002163;
	b=bqOG21jgPABBR5CCDHRXyzEhpm8q1C9GxBbohYsDMKrAo/VxgxOa19/lqAxgrp8u1ld1kS
	wKTcY1DFyrD4bQdFEe1/miseNQ+vuEdyKz1Ws5t+jAdh7IcTtFsYZiJuAH96uIYJocJhno
	JbHFPAcn5e6zVD3YWGALuqErfmav8qE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1786002163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=zYvCdjuOH1vATqd1p3bKrxMCuiCXEdyz9cYFfemGdUM=;
	b=JmLgCONaIvFWazoNTp0MLk7Sw9KSG7beaTHzEZzoQpUS1J2BJ+l8XX4yK6/FFdQh1mNG9T
	WXQd5yho9vieNy+Wc3chbhTcNk8W9h1PR81zjQ8cZ3Y+qM7FExt1uBocz00BG5eiB+UYYv
	YsZvewddALMCLuV++ubcUteXFBOq+Bc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="2S0WFU7/";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DE32C200D8;
	Thu, 06 Aug 2026 07:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1786002159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zYvCdjuOH1vATqd1p3bKrxMCuiCXEdyz9cYFfemGdUM=;
	b=2S0WFU7/X5U2k5k1NRELyVipkj7ryrnXW9urhMNo+WcnqRbmovCBEUIyFwCPbA8VgRtPZj
	0iJOTorXGkSUHqQTEEhbfvNLIEZxJrQW/nHWfQobEtm4jKMW67n98k7UdiG8eqfsx7V7ZN
	F5CiJi6/Oh0aTrcQ4ZFCbaASKF6FqgE=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 06 Aug 2026 09:41:31 +0200
Subject: [PATCH RFC batadv v4 6/8] batman-adv: tt: transition NEW local
 entries only under lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-tt-fixes-v4-6-c2fc871fe807@narfation.org>
References: <20260806-tt-fixes-v4-0-c2fc871fe807@narfation.org>
In-Reply-To: <20260806-tt-fixes-v4-0-c2fc871fe807@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2947; i=sven@narfation.org;
 h=from:subject:message-id; bh=2P/qNkAlvRtr1nCaYVyTbKVBMX+k2v0Y1/cg66NkoAA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFklVqtZfh37UZS4YUf7tztt0kqNS2vjXr82XdZx+9+v8
 LX8br2bOkpZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT8eNjZLi7bv9nsX8h6+d0
 JkgX8ESK3jU+bvy32XJNjKal2wa2k/MZ/te2/Mxni7lw4CF3yxXG1I9qgjHKi9dwSyr/i/LnuaB
 RyggA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: Z53NNIEVZLFZKNLYKDOGRI4EWAGMUWSH
X-Message-ID-Hash: Z53NNIEVZLFZKNLYKDOGRI4EWAGMUWSH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Z53NNIEVZLFZKNLYKDOGRI4EWAGMUWSH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The batadv_tt_local_size_inc() must never be called for an entry which was
already removed from the list. Otherwise the removal from the hash cannot
correctly determine if the batadv_tt_local_size_dec() needs to be called or
not.

This assumption is broken by the use of rcu_read_lock() in
batadv_tt_local_transition_new() because it might still see entries in the
list which were already removed by a different context from the list. If it
then increments the size counter, nothing will reduce the counter again.
Simply because the removal (responsible for the decrement) already
happened.

Over the whole time, the actual hash list spinlock must be held when
transitioning NEW local entries to avoid list manipulations.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index c4105171..fcdccd52 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -382,6 +382,10 @@ static void batadv_tt_local_size_mod(struct batadv_priv *bat_priv,
  *  given vid
  * @bat_priv: the bat priv with all the mesh interface information
  * @vid: the VLAN identifier
+ *
+ * It must only be called when removing the NEW flag of a
+ * batadv_tt_local_entry while it is still part of the bat_priv->tt.local_hash.
+ * It must therefore be checked under the specific list_locks[i].
  */
 static void batadv_tt_local_size_inc(struct batadv_priv *bat_priv,
 				     unsigned short vid)
@@ -495,8 +499,12 @@ batadv_tt_orig_list_entry_put(struct batadv_tt_orig_list_entry *orig_entry)
  */
 static u16 batadv_tt_flags_get(struct batadv_tt_common_entry *common)
 {
+	u16 flags;
+
 	scoped_guard(spinlock_bh, &common->flags_lock)
-		return common->flags;
+		flags = common->flags;
+
+	return flags;
 }
 
 /**
@@ -3985,6 +3993,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
  */
 static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct hlist_head *head;
@@ -3995,8 +4004,9 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
 
-		rcu_read_lock();
+		spin_lock_bh(list_lock);
 		hlist_for_each_entry_rcu(tt_common_entry,
 					 head, hash_entry) {
 			bool cont = false;
@@ -4016,7 +4026,7 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->vid);
 		}
-		rcu_read_unlock();
+		spin_unlock_bh(list_lock);
 	}
 }
 

-- 
2.47.3

