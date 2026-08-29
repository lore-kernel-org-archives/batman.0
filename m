Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50905C61DD6
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:22:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B93CE83BA9
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:22:18 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984538;
 b=NGV3mYf/wpOs/F7a9wC+jszGhUyUtv2pSRjirXC5fWI34H6EbzjGh17M74qCSvSg7v0HO
 Jtw2gaFkOmGSK3pMkLMGdouMHiq5vflCPzU1h0l7dSQFk3f8JOgKIUT+hpd4vODzUxufYru
 urXhfNFSiA8qGVv61jSmNUGFaS8zSnE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984538; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=aqD3x6Lq08Hm4oqy8lTpmeJRp4nzJ0sCYLnlrj+peaA=;
 b=TBKcc05InPhC/jJZT4fLjvMGSaAQP9odeAufMPqd/N32VIzje52A4+ktAse+5b03YMCO3
 TH4B6ynd9S9MRxsenaqw1w6KPPrP4oFp01Zuf2Qyy4P1JylMbORb6EVwc/wztG/XMiGx43P
 qU0wmAnyJ7gno+0EeZamDP/WX3cwHpI=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 072FE8117D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:19:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984394;
	b=qnPfioRBXVERj+ZOcNoGnoge/flZzBTfl1DHkiHw1Y/L3J0pY30Lu632CO8UTLdL2wD9T8
	xrHP2sPp/3m9FHglpZ3IuvPP7sbmAIjCkYWbXQS4WaHcwNHHC4DmgT1a/QYs9G9YVOrGc0
	itDcGHGrrmchpjZT7pZ3niw12kFgjL8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=aqD3x6Lq08Hm4oqy8lTpmeJRp4nzJ0sCYLnlrj+peaA=;
	b=vdJfS0u2f5Gg7LPM+oD4Aa9BRJlES4GRd5SrDT14ANDjcYHz5JC7cAVwQUoLvTmi04dilm
	JxURf2rQVJT0hYCwSw5y2tdTo7f3JMdAi1/F/F6iiD3NBik/k0F50rD26TYzH9MY0DCp/+
	sABG2BMTdGBUCDpM5xooOjlVz8BTwU4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=fjn+NWSe;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 986D21FE24;
	Sat, 29 Aug 2026 06:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqD3x6Lq08Hm4oqy8lTpmeJRp4nzJ0sCYLnlrj+peaA=;
	b=fjn+NWSe7dj4pzvzHcSHlGR9oaVLoi2/7Q4gSb83BBRR3KzKUv9n+vFn0+qxv+bVxRpijU
	skiXi8mLhoFtS9Y0spfiBrwlm/om0SCPMahbbMikB51C3RZjsNbUVNJ9ArLdND6ARsFhe/
	TmI+jeXJMTHXeXhbwZ8KUE+uXIjfdro=
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 29 Aug 2026 08:18:17 +0200
Subject: [PATCH batadv v5 06/20] batman-adv: tt: transition NEW local
 entries only under lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-tt-fixes-v5-6-88fce8fd683d@narfation.org>
References: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
In-Reply-To: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=sven@narfation.org;
 h=from:subject:message-id; bh=lbLkasowWHOMbI5iD/gc2uUe5DBgV21o3ZoXfOo1t6A=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKtf4Wy2+U9wqySXDWbbpUu30wo9ep84psnX9PlH9z
 +dd/buJHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJBEkxMrwLu2Hd+H6Nb+c+
 9cyIonexmw7ecFv3fZG+r8EWNT3BljRGhh8WleINhgaWJuFNb0Rn8G/36HvOzZnL6MLZlnmVd8p
 XTgA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: RFB2TILSCGTFIFKLGSCO23LQUPUAALFY
X-Message-ID-Hash: RFB2TILSCGTFIFKLGSCO23LQUPUAALFY
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RFB2TILSCGTFIFKLGSCO23LQUPUAALFY/>
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
 net/batman-adv/translation-table.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 0513f899..431d1b7f 100644
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
@@ -3989,6 +3993,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
  */
 static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct hlist_head *head;
@@ -3999,10 +4004,10 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 
 	for (i = 0; i < hash->size; i++) {
 		head = &hash->table[i];
+		list_lock = &hash->list_locks[i];
 
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(tt_common_entry,
-					 head, hash_entry) {
+		spin_lock_bh(list_lock);
+		hlist_for_each_entry(tt_common_entry, head, hash_entry) {
 			bool cont = false;
 
 			scoped_guard(spinlock_bh, &tt_common_entry->flags_lock) {
@@ -4020,7 +4025,7 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->vid);
 		}
-		rcu_read_unlock();
+		spin_unlock_bh(list_lock);
 	}
 }
 

-- 
2.47.3

