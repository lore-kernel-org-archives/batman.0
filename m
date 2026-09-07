Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E264FC79F9E
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:21:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 832DB84316
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:21:27 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769287;
 b=TB96mTiKMh7QoQIhjYHHWwVn0DnoYgAk4bATAG9Sruxf0JOKMEEkk9vDvQ5Oocd3ZM816
 Wc8+j47X0niDgoo+r7pG+uX8iXFYvqJ2WvE3f6iquUjQH1fMX1uhK+THmLsXM7oQs4JlujI
 GkgM90YaN48IXYYnaUs1fMeHQyvASY0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769287; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=v9rQSC+FIYXUADrhMRF8yRSXEy/HeHKFN7qzVUBx+7A=;
 b=JMjFWNAaenWuG/hyVALNNhN33YMwZW8siF8wUHxVEOQVXvqz837mrOZ8W2FHJaUG8JMeA
 0vX7plIFs8VPEjDEZX0r6JPHey3ZhaDrJFv53z4MxTKcXsq1yP4+fHxDmXj6thL3AU09bsf
 T3mv21al2iMPZm67LTa+YJ0ZLFryHLw=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 3370880888
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769118;
	b=DVACvcei47B9kHaDw692rk3nqefStdRH/5TdWTzud3Ls7m+bKbpvcwRUHhqZdv/ssB/rTQ
	2t7Hvl7XECYarvz+UgeaDb9bkJrgTZJvY1q+AvrqUNKY2Ou1sj4jKUTVunaAa5N8FlJLvh
	yfgNsRC5mR1/qq7Wxmd7cZpxgT5OVqM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=v9rQSC+FIYXUADrhMRF8yRSXEy/HeHKFN7qzVUBx+7A=;
	b=GNyBQ+n4PEULu995Lk4ngNwLJNcgvcE8eJCa7auTcJzD4VGN0l43tXwUtDMm226EAKg99u
	jTctUkh8s3qcSBkQwQyLGUVaQuk32eqEp1X9/g9GELft3Ini/gR0xEOUagssRajSlG7SJ+
	/6Wvdf725Y6TgXkxYppnI6FCKs2AmSQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=rKMo3nDI;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59748d0d8c3747188E6dfE6C0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 0A7B2FA2BD;
	Mon, 07 Sep 2026 10:18:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v9rQSC+FIYXUADrhMRF8yRSXEy/HeHKFN7qzVUBx+7A=;
	b=rKMo3nDILbx7sTQ+U+lxWEcAQsbzz9lwWFwcPyuRroQz2EBH+Z0Cf9psWLkO/Z4KXScQAp
	PoaVpEikdbm9Y74Fs8bPwxsFl8K0ZNfZuFNPY/HdwIb8LwyiSVm9mjMVltCQV+TfQIEVuy
	GtMAfRbme4zZdU4WDifhat0IxVcTlutMqfdsi7nVVECN0GBqC2jKG4pkBhQkXA+9GBPNd+
	7XJlJyOHXRAtMjOAncZmlaaQbneysb1nolAHmgCJwg3Tf1alV/IGoVQjUQ/kJxIJg9RJ2/
	0fSXOJzhW15pN42YDUyjfdzE1thXx9wMQ1HEeHrA5TsO1qhf+LbnaN798v0vLw==
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
Subject: [PATCH net-next 08/15] batman-adv: tt: replace add_orig_entry goto in
 batadv_tt_global_add()
Date: Mon,  7 Sep 2026 10:18:17 +0200
Message-ID: <20260907081824.2474040-9-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: A5SUBBCIPQ556E6TZLNDBU7R3FLKNALF
X-Message-ID-Hash: A5SUBBCIPQ556E6TZLNDBU7R3FLKNALF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/A5SUBBCIPQ556E6TZLNDBU7R3FLKNALF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The "add_orig_entry" label was only used to skip the flag merging of the
non-temporary path. Which means that the code jumping to it and the code
below it are the two halves of an if/else.

Both halves now only decide whether the originator list has to be purged,
so turn them into an if/else and purge the list at a single place.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 67e4ade5ae997..760acc7be973e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -2021,15 +2021,16 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 			if (batadv_tt_global_entry_has_orig(tt_global_entry,
 							    orig_node, NULL))
 				goto out_remove;
-			batadv_tt_global_del_orig_list(tt_global_entry);
-			goto add_orig_entry;
+
+			delete = true;
+		} else {
+			delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		}
 
-		delete = batadv_tt_global_merge_flags(tt_global_entry, flags);
 		if (delete)
 			batadv_tt_global_del_orig_list(tt_global_entry);
 	}
-add_orig_entry:
+
 	/* add the new orig_entry (if needed) or update it */
 	batadv_tt_global_orig_entry_add(tt_global_entry, orig_node, ttvn,
 					flags & BATADV_TT_SYNC_MASK);
-- 
2.47.3

