Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F9E3C61DE1
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:25:26 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0B9648040A
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:25:25 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103525;
 b=LdPxMI7A+EmDTFwPcbHR0NJe+vSWOLL+uTDQUqqNZ8aYiufgF8MKns6GnZWN3+ofqYju6
 uHPAsRKegxLdFO1JOOqFLle2Fuu2X/J3oq0duAVHU4VEVNDQ9tfpoQjKYFaNNi1ha9vpMLh
 YZ3uYj01bBGg1XdZZDFzO1N0IfMFXuY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103525; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=EEW65Z7XgJ9b8KixOMhNB8UYdhfjOLjxDT68Sxv/Cio=;
 b=3jhSrbYPes8i0cczs3ymCfn7CBY1bOH5RErys6kcRmA9ibJtU9C3kk8pBkymedKLUl0Ff
 AYGD6+mMX9TEeBEVz7q4OlkxaNMGx0OpmHxx3c0uiYuH0ldcDULlI3xJ+vO3VpVBAatYkgZ
 q9/uJnfXAhD3lmvfwKg2hsBAfU5psTQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id DF55E8045F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:22:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103336;
	b=3PZu2LMrT46JH1gv4tvA8Wxas2s2vs0SCEgOUVesUWL52fuJmlzBXvAsfOsYr1uCGh2BwF
	ebiflECg+HMquvPXfnKEP6pVXCJFhWUspdYlgWLbh7IY/FHfatr+f01SSbk6aFE7xXMgLo
	CdmhM1bmAnE5++swt+wOtJ7dw1Z6aEs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EEW65Z7XgJ9b8KixOMhNB8UYdhfjOLjxDT68Sxv/Cio=;
	b=I/y/M14Yi5c5+vMDzihfp2EttNoD9gK8HzLbXOpXWxsOUkfaj1wSoBXuxRozVRwfGJcbYi
	4uxyc7JR3vJxvSotVZlblsPisO/TD+WPqL7JnQLUdNlAJs2nWmhiX2YEbAlT7Y1qHh09Ds
	Ip+msOgsVCjHks61w+r3YLpKYeQTiYw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=EqdcDfwp;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 832FC20131;
	Sun, 30 Aug 2026 15:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EEW65Z7XgJ9b8KixOMhNB8UYdhfjOLjxDT68Sxv/Cio=;
	b=EqdcDfwp4/7jbzNVDZ93Xi8WGU8vsjuQnXeQ5rq/o1VrAOH+dkYh7RUrTxzTotnQ2tCCPp
	QTreyCOEgyUb6ypYfx5cAOc2KHpJiuS8l2Xg+1Zbvj8DfzrnQ9WKf8K6xGR8YTBErg+bfN
	Nkikz9a+7rnJuqvqAxx6yVyDtRDqOwo=
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 30 Aug 2026 17:21:43 +0200
Subject: [PATCH batadv v6 06/20] batman-adv: tt: transition NEW local
 entries only under lock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-tt-fixes-v6-6-a56568a15041@narfation.org>
References: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
In-Reply-To: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=sven@narfation.org;
 h=from:subject:message-id; bh=Z6r+ZctuTMVyU41wke7AxueTX/B6KpvB2hLQcHLwlkg=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvNpu/fDYlb7vtG6IhY+7sX8K/+Kvz1q+V84OOSMv+
 8PAafe9jlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEPK4xMqxK6GBQY5lwhf2j
 Wp1Jal22PROn3yaRUztrkl54lm+YVc3IcOP8JIfCtZpHiux9vDQ9fp540m4vmBXo4XrS/9NqvUd
 HeAA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ETT5FPEGVWLHWM5IS75TL4AKI6UOXKP7
X-Message-ID-Hash: ETT5FPEGVWLHWM5IS75TL4AKI6UOXKP7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ETT5FPEGVWLHWM5IS75TL4AKI6UOXKP7/>
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
index ec72c391..534fbb05 100644
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
@@ -3991,6 +3995,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
  */
 static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct hlist_head *head;
@@ -4001,10 +4006,10 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 
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
@@ -4022,7 +4027,7 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->vid);
 		}
-		rcu_read_unlock();
+		spin_unlock_bh(list_lock);
 	}
 }
 

-- 
2.47.3

