Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966CDC624C6
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 13:58:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1491684AEA
	for <batman-adv@archiver.kernel.org>; Mon, 31 Aug 2026 15:58:09 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788184689;
 b=zerI7G868svCwQWK+vPDBqjZSvwLJPHD+pnrcdfpl34HEs01kioAUy/YydGP2HglU3k+S
 jTX0/tnh+a3mlKzSh1Oqqd8eSoZBm6x8LiWzl/SMp8fAglBkuYupIEoFpS/Z2rIvmSspPyn
 ygXWh2v2s1bsGjArYGdEL49z9u0PqBk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788184689; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=j+fih36mn0rWJXnLxh9qzk4Rdn9Swqf0asTE0uYK2L0=;
 b=lqAb9WJ5Qd7KmKbE4jo+0ElNtTEnCdBLJpTsrWOBnoaejxXVRc+n4sGto7phCfq7JPQ/x
 NKTUwx0PZKxcHqOk3UDPhnekK5kLXzjqP4raDCfF3IvJinvajkiL0LmY91CfPJHtlf09t/r
 R8X202JqyuX+4xVYsSRiOqppQcf1My0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 9AE50818DE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 31 Aug 2026 15:51:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788184302;
	b=kjabgSf13lEphL0QGmO+JqA0NfDLTzXKSMJyk1Y4Ht7L3O+zdNHZsY5/w0MTETfCVCQsuR
	bL1I5zcweleqttbLq4PgiJnfIxTNKaVE4KmKG6tY0oxP1hzBqY1iWci29fG+sqpdGNvBrk
	oox+hoBGxo8zhUGST1lPxstoV/ThFP8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788184302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=j+fih36mn0rWJXnLxh9qzk4Rdn9Swqf0asTE0uYK2L0=;
	b=J4X1muwcs5Bd1JhCQWddNiNdmWc1uqq9eLrhcrflnC8ok24H6WsBBUGqOR9PMa0drCFRho
	55OyO2ie2sI3O8VTKfqEgKmWgyrOvyylDGoWVQC1jHSdFUUBEQaGKM9wpbdgD8PJ18kxn4
	Tc6yC55zMHOEsAIb0yYGNfvegGNZ90g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=WJyevspY;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c5970eEDD85F51f1fAa919d7a5.dip0.t-ipconnect.de
 [IPv6:2003:c5:970e:edd8:5f51:f1fa:a919:d7a5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id A0690FA6B8;
	Mon, 31 Aug 2026 15:51:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788184296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j+fih36mn0rWJXnLxh9qzk4Rdn9Swqf0asTE0uYK2L0=;
	b=WJyevspYEfY8Vot1fQU80G/zjwUd5yeT7S5RK7TUVIdntXdpdFFZIFJLb3/klWV90skPhF
	7SymHOqTyrZc8+EUWejd04iGcxiPiBDOquzS8ihn2oZMpGnq0FUiidu3NYb4+fBEs1LpcJ
	Ddfqww4O3ELo5Aef3im1QbghmmZ3sCa3eFjUy2YS70cOpBaAyrs3edUQCAMOxHep6ge5Wa
	R4XFgfhKavsoh4E9ktZgizfzOnzUEbVVQB6NxziFmKPbAGbUvtI+azACtVzlgWclihfh1B
	3yYl6qx9B/RacrkcdP+BUKmuBEHwgb1bU0JL4xzccYi1FZkUTyZ5Lkd4s488OQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 13/15] batman-adv: tt: transition NEW local entries
 only under lock
Date: Mon, 31 Aug 2026 15:51:15 +0200
Message-ID: <20260831135117.574836-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831135117.574836-1-sw@simonwunderlich.de>
References: <20260831135117.574836-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AHGQQEZE7NAGVGAHYACYM7DOBYD2ME5X
X-Message-ID-Hash: AHGQQEZE7NAGVGAHYACYM7DOBYD2ME5X
X-MailFrom: sw@simonwunderlich.de
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AHGQQEZE7NAGVGAHYACYM7DOBYD2ME5X/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

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
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 163f909623069..a870d9a97e329 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -333,6 +333,10 @@ static void batadv_tt_local_size_mod(struct batadv_priv *bat_priv,
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
@@ -3938,6 +3942,7 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
  */
 static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 {
+	spinlock_t *list_lock; /* protects write access to the hash lists */
 	struct batadv_hashtable *hash = bat_priv->tt.local_hash;
 	struct batadv_tt_common_entry *tt_common_entry;
 	struct hlist_head *head;
@@ -3948,10 +3953,10 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 
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
@@ -3969,7 +3974,7 @@ static void batadv_tt_local_transition_new(struct batadv_priv *bat_priv)
 			batadv_tt_local_size_inc(bat_priv,
 						 tt_common_entry->vid);
 		}
-		rcu_read_unlock();
+		spin_unlock_bh(list_lock);
 	}
 }
 
-- 
2.47.3

