Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A18C79F9E
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:22:31 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 552C684726
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:22:29 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769349;
 b=WKlA8BbKmUhOWnT0H8vYyooLfDf/jfj1hA97NZzEkJlQKtoET6OO2igf3pTlWk1E7EV9S
 IE9Nka0kp7BDeKHu3ntkv5v/kQPPl5LNwr9WHmnHTJ7lWR3F327zLADKva8xNvFF/Mjia0P
 QE6pJGDGISmjbWQEOek/xszjacVHLEc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769349; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=mBLXy+zjOOc3JiDODVHxTk5L18GWZI/4gMrt0AqIkKY=;
 b=PyXEwEgTH1aH+DPr21ELP0iEMjThh+qUuJK3DsjKiBXVMbf2H7usazyUJE2dDlizSYdRe
 45ZAOHU057zh71UR5tfrLOdtEH/l7Q/v1PuoIP5Ww9+mXl+qBteFUowUI8bqee9pAk9mCmo
 9B5H83iUMS0Y2SC72Fz09fHIixq2k7I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 39F678419D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769118;
	b=eEU1BYtcXumh/6C/CG593pyi6TsCD0h94mctzkbDIdPL3zuVCQlHgvoRmu41uUV40L27Z6
	begxReI7v+Ig6/XFqw2LoJvpVRrB/mW/HV1d/3w5lkYmXNM2ONoHGitGaqLFbftcwQrGxt
	yEZ+sjb4zRQRlHSJ0hXF9sVcI8DGjPM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=mBLXy+zjOOc3JiDODVHxTk5L18GWZI/4gMrt0AqIkKY=;
	b=OsZfHppLiIeW9plOJWpz9zZQcVlklWqE3RUzIqAsIQ4H1wYAYLvL65B/wwwx6wHi0Oq77j
	GBeHrqJ2AWmHYoSRwJGJViY/Bq/NxwFjcPb0P7FaUVm0dMLkOMNgwhADSfvnXVGoRQjy/N
	GwXwnUXlNOmsG51oqwMeUVQapZhBjh8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=r+uj+8Qu;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59748D0d8C3747188E6DFE6c0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 6E057FA2BE;
	Mon, 07 Sep 2026 10:18:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mBLXy+zjOOc3JiDODVHxTk5L18GWZI/4gMrt0AqIkKY=;
	b=r+uj+8QuIZyqAIDt3YdpdFY1WuARyWrg888AYY2ZjXAcpwuf8zZ74WWx3wtWSCe8FduV9t
	UbcQXR94bK1CeyKsw6szubCcGVxhA2VQXQOKwEZeCaMbM4q0mqb5oIC1m+anWDAuutl9uX
	nCVJSjYpsEn4a87v6yzJiN2bw3pHZGSnsfsMWEiA0XKhowbPzlK9DLvOH1e5h4UOoSzTO8
	gBDFQ3J814SaMWyU1NZMmSPHw5UfkAtZ3p7x7pcLQ+poTNtembQsRVBSMkSDFlB4Udg/NU
	2TRUPQVqlTNf1YrWElcgvJan5a/ToTuyWj5QCQS1Xm+80vVO9EZFUx/KKsCbCQ==
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
Subject: [PATCH net-next 09/15] batman-adv: tt: extract removal of the
 superseded local entry
Date: Mon,  7 Sep 2026 10:18:18 +0200
Message-ID: <20260907081824.2474040-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BIA7GOAAXWBMNFFFQ3OWIC4MUPNHZSXE
X-Message-ID-Hash: BIA7GOAAXWBMNFFFQ3OWIC4MUPNHZSXE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BIA7GOAAXWBMNFFFQ3OWIC4MUPNHZSXE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

A client which was announced by another originator is no longer a local
client. The code which drops it from the local table and takes over its
WIFI flag is the second cleanup stage of batadv_tt_global_add() and needed
its own goto to skip over the multicast case.

Move it to batadv_tt_global_purge_local().

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 61 ++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 760acc7be973e..b3e45fb5e9dd4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1832,6 +1832,46 @@ batadv_tt_global_orig_entry_add(struct batadv_tt_global_entry *tt_global,
 	spin_unlock_bh(&tt_global->list_lock);
 }
 
+/**
+ * batadv_tt_global_purge_local() - drop the local entry of an announced client
+ * @bat_priv: the bat priv with all the mesh interface information
+ * @tt_global_entry: the global TT entry of the announced client
+ * @flags: TT flags announced for this non-mesh client
+ *
+ * A client which is announced by another originator is no longer a local
+ * client. Remove it from the local table and take over the WIFI flag it was
+ * tracked with.
+ */
+static void
+batadv_tt_global_purge_local(struct batadv_priv *bat_priv,
+			     struct batadv_tt_global_entry *tt_global_entry,
+			     u16 flags)
+{
+	struct batadv_tt_common_entry *common = &tt_global_entry->common;
+	u16 local_flags;
+
+	/* Do not remove multicast addresses from the local hash on
+	 * global additions
+	 */
+	if (is_multicast_ether_addr(common->addr))
+		return;
+
+	/* remove address from local hash if present */
+	local_flags = batadv_tt_local_remove(bat_priv, common->addr, common->vid,
+					     "global tt received",
+					     flags & BATADV_TT_CLIENT_ROAM);
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		common->flags |= local_flags & BATADV_TT_CLIENT_WIFI;
+
+		if (!(flags & BATADV_TT_CLIENT_ROAM))
+			/* this is a normal global add. Therefore the client is
+			 * not in a roaming state anymore.
+			 */
+			common->flags &= ~BATADV_TT_CLIENT_ROAM;
+	}
+}
+
 /**
  * batadv_tt_global_merge_flags() - merge announced flags into a global TT entry
  * @tt_global_entry: the global TT entry to update
@@ -2042,26 +2082,7 @@ static bool batadv_tt_global_add(struct batadv_priv *bat_priv,
 	ret = true;
 
 out_remove:
-	/* Do not remove multicast addresses from the local hash on
-	 * global additions
-	 */
-	if (is_multicast_ether_addr(tt_addr))
-		goto out;
-
-	/* remove address from local hash if present */
-	local_flags = batadv_tt_local_remove(bat_priv, tt_addr, vid,
-					     "global tt received",
-					     flags & BATADV_TT_CLIENT_ROAM);
-
-	spin_lock_bh(&tt_global_entry->common.flags_lock);
-	tt_global_entry->common.flags |= local_flags & BATADV_TT_CLIENT_WIFI;
-
-	if (!(flags & BATADV_TT_CLIENT_ROAM))
-		/* this is a normal global add. Therefore the client is not in a
-		 * roaming state anymore.
-		 */
-		tt_global_entry->common.flags &= ~BATADV_TT_CLIENT_ROAM;
-	spin_unlock_bh(&tt_global_entry->common.flags_lock);
+	batadv_tt_global_purge_local(bat_priv, tt_global_entry, flags);
 
 out:
 	batadv_tt_global_entry_put(tt_global_entry);
-- 
2.47.3

