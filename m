Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC163C79F89
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:21:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 65802845BF
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:21:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769318;
 b=uY+kL+HD0ZNejJl7VMdAdZOvToGyrfqTLcJTpBUBtBMIvB2GLFD4GiEgyk4lgF7psz1wc
 78sokjBoEBTUilvQWu34iTRJRRxmrJDq7HBawpSzbVSyN6EhAIw/o3+F9qNJAtYdWVjoyIa
 qZZkF3YdDHErXG9r9ckJ+nNPAQtRLDM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769318; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mKTh3S1osAd3oOzeSAiudKpVE9EbyXDX/gnbfTiEcb4=;
 b=yETu9bPOLSiso4MhR9xoXKW1h+1XhUVvOW7y/MDXd0arolkP7H5AGJUHwedl0lXQS+XyO
 ljjBdXuy1XN9LrDWsXeltNp2NN2gvNBrj4G/24L3zTSlaVsMpitYP0ogaMnX1mPZtcFe/PP
 epdpcVFXxD26LldJpMUM5CyZWHbU2TE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5D0B5841A1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769118;
	b=ChaF/7lwmxE+51bDSrAI+9r7KwkF13Q14I/4YG5mDE4Bz0hfdbKKczaCblb/bXkNgc5anS
	+0QA0J3IdvI1ioEKOE1Z+jl9TvmGaYQIiRz0pBQDM7NxLxiGpVyoBkFyHMoZJMZAEZgMNN
	/1SBPXCS2+IjDEVbMADiM9y5qv5nVZU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mKTh3S1osAd3oOzeSAiudKpVE9EbyXDX/gnbfTiEcb4=;
	b=nBBMjTL0DKDpIqQSzSoYb2EtLMxFazwZWxrQgTebgfKehCVm9R2APl7WRdpHIVrbSIyiLh
	mG4y0JV4IORzAPGNBnVnYsKMNFxK0HwzaGKySISISqRr874qNiobLxg3LeVj2oP3s6AJZY
	pVA8+QfvcVf4LWUkhHHWx+cNK1FOFRQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=l2JkpWJw;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59748d0d8c3747188E6dfE6C0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 9C8C6FA2BB;
	Mon, 07 Sep 2026 10:18:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKTh3S1osAd3oOzeSAiudKpVE9EbyXDX/gnbfTiEcb4=;
	b=l2JkpWJwQNRqT54ITMJWDjN76T+Q+nUXZajHv50P2N5O0gnx79kuT+mj8FmRm6iFHvFO1W
	v3NtdQ0RpyLFk0BfWTPyGY9H3msr3peB856KrzYcxr87SwcWFLek0HIh60m1FKxEpShPSB
	M9kGEtPtjQTcbu1dv+/JfFk/oQFwVwu72BMySA+Vcm/OQGFLkLSt8ongxaDBAJbgCMaJNH
	efSzn4SsTx78W/ouLNsYYKOoC7XHAKgysGviLYwh5XwwmCGi+16G8l0CFOvsEZifh0bk0F
	mfzGZjzVMJkpviGjBistbzKQT261vEEpMPLD4EijCm2JUxe8ZCQzBOpf53xwFw==
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
Subject: [PATCH net-next 06/15] batman-adv: tt: extract allocation of new
 global entries
Date: Mon,  7 Sep 2026 10:18:15 +0200
Message-ID: <20260907081824.2474040-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: P7YWE4GFQT4O43WVTYVBUIOWNX3NOFHA
X-Message-ID-Hash: P7YWE4GFQT4O43WVTYVBUIOWNX3NOFHA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/P7YWE4GFQT4O43WVTYVBUIOWNX3NOFHA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The code which allocates and initializes a brand new global TT entry makes
up a third of batadv_tt_global_add() and only needs the tt_addr, vid and
flags arguments. It is also the only part of the "new entry" branch which
does not deal with the global hash.

Move it to batadv_tt_global_create() and let it return the initialized
entry.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 76 ++++++++++++++++++++----------
 1 file changed, 51 insertions(+), 25 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e0bcef1eba935..d475f8efd44d7 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1832,6 +1832,56 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	spin_unlock_bh(&tt_global->list_lock);
 }
 
+/**
+ * batadv_tt_global_create() - allocate and initialize a global TT entry
+ * @tt_addr: the mac address of the non-mesh client
+ * @vid: VLAN identifier
+ * @flags: TT flags that have to be set for this non-mesh client
+ *
+ * The returned entry is not yet part of bat_priv->tt.global_hash and has an
+ * empty originator list.
+ *
+ * Return: the new entry with an initialized reference counter on success, NULL
+ * otherwise.
+ */
+static struct batadv_tt_global_entry *
+batadv_tt_global_create(const unsigned char *tt_addr, unsigned short vid,
+			u16 flags)
+{
+	struct batadv_tt_global_entry *tt_global_entry;
+	struct batadv_tt_common_entry *common;
+
+	tt_global_entry = kmem_cache_zalloc(batadv_tg_cache, GFP_ATOMIC);
+	if (!tt_global_entry)
+		return NULL;
+
+	common = &tt_global_entry->common;
+	ether_addr_copy(common->addr, tt_addr);
+	common->vid = vid;
+	spin_lock_init(&common->flags_lock);
+
+	if (!is_multicast_ether_addr(common->addr)) {
+		scoped_guard(spinlock_bh, &common->flags_lock)
+			common->flags = flags & (~BATADV_TT_SYNC_MASK);
+	}
+
+	tt_global_entry->roam_at = 0;
+	/* node must store current time in case of roaming. This is
+	 * needed to purge this entry out on timeout (if nobody claims
+	 * it)
+	 */
+	if (flags & BATADV_TT_CLIENT_ROAM)
+		tt_global_entry->roam_at = jiffies;
+	kref_init(&common->refcount);
+	common->added_at = jiffies;
+
+	INIT_HLIST_HEAD(&tt_global_entry->orig_list);
+	atomic_set(&tt_global_entry->orig_list_count, 0);
+	spin_lock_init(&tt_global_entry->list_lock);
+
+	return tt_global_entry;
+}
+
 /**
  * batadv_tt_global_add() - add a new TT global entry or update an existing one
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1883,35 +1933,11 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	}
 
 	if (!tt_global_entry) {
-		tt_global_entry = kmem_cache_zalloc(batadv_tg_cache,
-						    GFP_ATOMIC);
+		tt_global_entry = batadv_tt_global_create(tt_addr, vid, flags);
 		if (!tt_global_entry)
 			goto out;
 
 		common = &tt_global_entry->common;
-		ether_addr_copy(common->addr, tt_addr);
-		common->vid = vid;
-		spin_lock_init(&common->flags_lock);
-
-		if (!is_multicast_ether_addr(common->addr)) {
-			spin_lock_bh(&common->flags_lock);
-			common->flags = flags & (~BATADV_TT_SYNC_MASK);
-			spin_unlock_bh(&common->flags_lock);
-		}
-
-		tt_global_entry->roam_at = 0;
-		/* node must store current time in case of roaming. This is
-		 * needed to purge this entry out on timeout (if nobody claims
-		 * it)
-		 */
-		if (flags & BATADV_TT_CLIENT_ROAM)
-			tt_global_entry->roam_at = jiffies;
-		kref_init(&common->refcount);
-		common->added_at = jiffies;
-
-		INIT_HLIST_HEAD(&tt_global_entry->orig_list);
-		atomic_set(&tt_global_entry->orig_list_count, 0);
-		spin_lock_init(&tt_global_entry->list_lock);
 
 		kref_get(&common->refcount);
 		hash_added = batadv_hash_add(bat_priv->tt.global_hash,
-- 
2.47.3

