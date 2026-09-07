Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6765BC79F9E
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:23:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 00C328493C
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:23:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769379;
 b=ryUhmWBL5rBYOp9WQbhEyUxonzErFE7cLcEMGwU6x+kYdU4gD6VFP54FTCxlgMCKrV8Xy
 Y6G6X7mG/VHpaHRjcVwuEVw3bgf1yT//mVG+6feW4Ql4Ix+yv507WHAfVrPGS2xODRUO8Az
 QJOQMDL6L7zV9ZzmnyyyXbQNnsfLGrQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769379; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=iYYAL99fI+3xs+LRvqt1S/0lzPOfMPpCYz8ivw1Xc+c=;
 b=X0tvT/O6ngvN/czZ9TJjLE8I9l00hJanImxE01kya7tNMRoZMub90kJw4HUkxe5sa6xZH
 K40SfK75ZtnXtbOJGxMH8gMNgJoxNtBdoSvNEE9jtWmskje1iZOTFt+qd99TSdjTrwl7Ci3
 +VRg7u4cLmrAZ60docsfvxwEIJNBp4E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 79F52841D4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769118;
	b=ipyHeBEx1ltO2Jo9L5r2dGafRH3sBYjOLXPozh7grLLKBqpOb89yO1sKt+2zpRume4vzPm
	+/Q/wOsR8hF9CLf2HhUgMEFPdHBLEw5lWbiTHBP5BLKAiV4d9npsjbiiPBWZxFIPiNBBzz
	3C5epzdc+M9kRo6arQixrW2BCNxMNGY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=iYYAL99fI+3xs+LRvqt1S/0lzPOfMPpCYz8ivw1Xc+c=;
	b=KKYPp4M9ssIiuF+I0jvc/ZBR5x6nq/IaaaX0mswGJ1C/gBVoD5rdVwYAHbOfWJVxYu5DDb
	IGO474kaVB4dDtgioWMZfJlxdi2NYGOJfJR4V4brDQYfVsbaKZ1zLe+GK14i+VOjL5uteo
	SIA5zqLHdpXZ/nBX4yp8jlIfBGEvcl8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=VypMkJim;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59748D0d8C3747188e6DFE6c0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 088D6FA2BF;
	Mon, 07 Sep 2026 10:18:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iYYAL99fI+3xs+LRvqt1S/0lzPOfMPpCYz8ivw1Xc+c=;
	b=VypMkJimVaiqgFJMVlNNzCF3ON4gWs4eDXO9e75F+RuXVUaR19cfEs39ASRxWU9X9o190j
	g+2MA9AqIicgf5kBKb3xOYUtK2PtfHOkZddTowpyjynisnBFbZAZq5Lt8UKmrjjarPwDop
	f65IyrcoweHxKh0s3rbQCyfW+DhPUwR5NeYlHLJj6aZyC4oFjt1d3jdjSIvNYyfZLwITgY
	1CLgKqDeNJT0UPDYZAkLmKsIEjy53zJqMpoMp2AqUdWoWkwM+sEuxlOgA7vptY++aKflNU
	sa3sdCqzZnkV0w/sP4gnhIEwQmuTinX5aaSM+VXZGlsWcSO14at4L8t47nzF3w==
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
Subject: [PATCH net-next 10/15] batman-adv: tt: extract marking of a removed
 local entry
Date: Mon,  7 Sep 2026 10:18:19 +0200
Message-ID: <20260907081824.2474040-11-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RJYJGEMUHFSSWX2DXE5ZUQBD74DH5FLS
X-Message-ID-Hash: RJYJGEMUHFSSWX2DXE5ZUQBD74DH5FLS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RJYJGEMUHFSSWX2DXE5ZUQBD74DH5FLS/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The first locked section of batadv_tt_local_remove() does three things at
once

* it snapshots the flags for the return value
* it marks the client as ROAMed
* it decides whether the entry has to survive until the next ttvn increment

But this complex locked section is in the middle of the function and cannot
be written as scoped_guard() due to goto's in this routine.

Move it to batadv_tt_local_mark_removed() and report the decision via its
return value. But leave the batadv_tt_local_set_pending_event() flag
assembly outside the function because it has no locking requirements.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 48 ++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 13 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index b3e45fb5e9dd4..f5b753ed1ae1a 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1443,6 +1443,38 @@ batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
 		   batadv_print_vid(tt_local_entry->common.vid), message);
 }
 
+/**
+ * batadv_tt_local_mark_removed() - mark a local entry as removed
+ * @tt_local_entry: local TT entry to mark
+ * @roaming: true if the deletion is due to a roaming event
+ * @curr_flags: pointer to store the flags of the entry before it was marked
+ *
+ * Return: true if the entry has to be kept in the local table until the next
+ * ttvn increment, false if it can be purged immediately.
+ */
+static bool
+batadv_tt_local_mark_removed(struct batadv_tt_local_entry *tt_local_entry,
+			     bool roaming, u16 *curr_flags)
+{
+	struct batadv_tt_common_entry *common = &tt_local_entry->common;
+	bool pending = false;
+
+	scoped_guard(spinlock_bh, &common->flags_lock) {
+		*curr_flags = common->flags;
+
+		/* mark the local client as ROAMed */
+		if (roaming)
+			common->flags |= BATADV_TT_CLIENT_ROAM;
+
+		if (!(common->flags & BATADV_TT_CLIENT_NEW)) {
+			common->flags |= BATADV_TT_CLIENT_PENDING;
+			pending = true;
+		}
+	}
+
+	return pending;
+}
+
 /**
  * batadv_tt_local_remove() - logically remove an entry from the local table
  * @bat_priv: the bat priv with all the mesh interface information
@@ -1467,26 +1499,16 @@ u16 batadv_tt_local_remove(struct batadv_priv *bat_priv, const u8 *addr,
 	if (!tt_local_entry)
 		goto out;
 
-	spin_lock_bh(&tt_local_entry->common.flags_lock);
-	curr_flags = tt_local_entry->common.flags;
-
 	flags = BATADV_TT_CLIENT_DEL;
 	/* if this global entry addition is due to a roaming, the node has to
 	 * mark the local entry as "roamed" in order to correctly reroute
 	 * packets later
 	 */
-	if (roaming) {
+	if (roaming)
 		flags |= BATADV_TT_CLIENT_ROAM;
-		/* mark the local client as ROAMed */
-		tt_local_entry->common.flags |= BATADV_TT_CLIENT_ROAM;
-	}
-
-	if (!(tt_local_entry->common.flags & BATADV_TT_CLIENT_NEW)) {
-		tt_local_entry->common.flags |= BATADV_TT_CLIENT_PENDING;
-		pending = true;
-	}
-	spin_unlock_bh(&tt_local_entry->common.flags_lock);
 
+	pending = batadv_tt_local_mark_removed(tt_local_entry, roaming,
+					       &curr_flags);
 	if (pending) {
 		batadv_tt_local_set_pending_event(bat_priv, tt_local_entry, flags,
 						  message);
-- 
2.47.3

