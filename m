Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1921BC53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 14:54:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1BAC784518
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 16:54:32 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785250472;
 b=MdT5gd0DZY0goBuUGqW+46Wcs5KundAxmXaSR7t4DO2z9k3+Jv89L8plyNFYqI+74z5aZ
 1+Dh5BDN8JZFUmKYWfO5DufbCb319KoaNoFDyxooEhUWEywrTckZhnMjA6580o7fmZsJ3PR
 1gGp/2iq5sZDZuXAsg51RCPf/bG9QOs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785250472; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=m7FQaHnW8F+Df8CwvCMNaD1Q40CWCi8+sPu8uSFkUVc=;
 b=U00In3H61ziDZPqtlF2ufrQPp1z7b8uFkv25cpKMvy9q0H5xEeHedl00t8oE6DjMg4kvH
 C7xcXM36CpfWJb8jBXy8Jh2qoWUlf7IY6ZBI4ypd1GFihfmVYWS8cTMsPxMYr9wdMVw8yNG
 wAXID7Qcp50aPvcs5Zu5bIdrE7uI5xM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 16B7D846EF
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 15:39:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785245970;
	b=CdPy/1+5VcAgCtTL0QPy+kuYwBOX7Jd+OKC4cxFfZeA+iDmzLR9Yawu1tUjQ7URjYR3s2T
	yzfSJx4l+kRCbxLZ9psDHz0ISmD7YPDElHl60LVjYYm+j9CtyTLNKPwYUI2qqrR5+kaCEL
	Ur2qoC54uF7cFsSOEZbIuw4xqGYYL7k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785245970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=m7FQaHnW8F+Df8CwvCMNaD1Q40CWCi8+sPu8uSFkUVc=;
	b=ZcqXuI2GEaTl4PUAbVqjTiKloUMtkW72C924AWORzLYseS/au0eeMS+CueShIayq5MIDw6
	WMmVIzDvVFywe7XMrD/uUEPi8qDP2E7+zQlEQhh5JciF+k28CEIBGWFY6hYdsIdpILMkOv
	j6Txtn371DA+DL+Rr2xaSEr65hiaVVI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=MY58UjiF;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59717eaD808F168C97E5563A8.dip0.t-ipconnect.de
 [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id C7551FA1AE;
	Tue, 28 Jul 2026 15:39:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m7FQaHnW8F+Df8CwvCMNaD1Q40CWCi8+sPu8uSFkUVc=;
	b=MY58UjiF1gchB4RUoxohYcRSaUPKoHOxzATlVNYO6jt6ykpNMd5rgE38/D8NxH7AOI8e7k
	bOnTHFjHinksciAEHNtj78med3YMnQN3zloQ+wBnHPZSjqxfpQ5M4Auh3ib4x18+IUv4he
	t7jPa+x5nRK0buldDUlgZhtv23nYuXzp2iOrdRpfHdgNmXLuUCexke9kpQkuiq/cz6kzSZ
	orq56eTJrcSEEW0KjETBkBXxuyKPhpu2uTF/lxt6l7iGeFT4pqPeEQJW4m+bjH4ow1rvt0
	nUjAH8TIUT5AQZFRLRy9ZXsb2uXQZMGjh6wZtyA4bGdu+fSoK8zHV+9HJkHn/Q==
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
Subject: [PATCH net-next 15/15] batman-adv: tt: simplify NEW flag transition
 code
Date: Tue, 28 Jul 2026 15:39:18 +0200
Message-ID: <20260728133918.643267-16-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: MUOVNT6SW7KEAVR6LL5TTVXMQOMSQYRT
X-Message-ID-Hash: MUOVNT6SW7KEAVR6LL5TTVXMQOMSQYRT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MUOVNT6SW7KEAVR6LL5TTVXMQOMSQYRT/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The function batadv_tt_local_set_flags() implements support for various
flags and to set/unset them. It is also possible to decide whether this
change should increase the TT size or not.

But in reality, this function is only used to transition tt local entries
from the NEW state and count these entries. Remove the rest of the code to
simplify the function.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 37 ++++++++----------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 5295e3a59906f..5e10e6bb7bd6a 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3853,15 +3853,11 @@ void batadv_tt_free(struct batadv_priv *bat_priv)
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
@@ -3882,27 +3878,12 @@ static void batadv_tt_local_set_flags(struct batadv_priv *bat_priv, u16 flags,
 			entry_flags = &tt_common_entry->flags;
 			old_flags = atomic_read(entry_flags);
 
-			/* the old_flags value of the atomic test-and-
-			 * set/clear decides whether this entry counts as
-			 * changed.
-			 */
-			if (enable) {
-				if ((old_flags & flags) == flags)
-					continue;
-
-				old_flags = atomic_fetch_or(flags, entry_flags);
-				if ((old_flags & flags) == flags)
-					continue;
-			} else {
-				if (!(old_flags & flags))
-					continue;
-
-				old_flags = atomic_fetch_andnot(flags, entry_flags);
-				if (!(old_flags & flags))
-					continue;
-			}
+			if (!(old_flags & BATADV_TT_CLIENT_NEW))
+				continue;
 
-			if (!count)
+			old_flags = atomic_fetch_andnot(BATADV_TT_CLIENT_NEW,
+							entry_flags);
+			if (!(old_flags & BATADV_TT_CLIENT_NEW))
 				continue;
 
 			batadv_tt_local_size_inc(bat_priv,
@@ -3977,7 +3958,7 @@ static void batadv_tt_local_commit_changes_nolock(struct batadv_priv *bat_priv)
 		return;
 	}
 
-	batadv_tt_local_set_flags(bat_priv, BATADV_TT_CLIENT_NEW, false, true);
+	batadv_tt_local_transition_new(bat_priv);
 
 	batadv_tt_local_purge_pending_clients(bat_priv);
 	batadv_tt_local_update_crc(bat_priv);
-- 
2.47.3

