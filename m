Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A17ACA6007
	for <batman@archiver.kernel.org>; Thu,  8 Oct 2026 14:31:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 04D39842B3
	for <batman@archiver.kernel.org>; Thu, 08 Oct 2026 16:31:47 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791469907;
 b=3UTm8thx2m3jqjSJXyUuQ9w7S6Fl+2f3DA5xEFzEUg7BQdkwun9CdsN5eJamXoYf4rsYA
 JdWkUyOg5I6cBWdqYaP+0C4p18VOA2BKeFFBUBqrNjzUhE+x/OSnTvKESiHDLhFOmqapeTu
 UyCa/lduDvNXvxjrPF7lYwouKX+Ilb4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791469907; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=+60+tNcKIANPZCz6ZmrjvQVlbtzjhSY6Y53pKv/rBrM=;
 b=2FxXYvFcI1aqhmDH67QPaTM0+4DixXMEPWKoUkV0ADJgYUu22srbPXtWT6CPh+SKV7JjU
 p3TyP6tHYY4M1NrzWyamo0fWCm/NgrxnOKNFczY4/BGbCAnjGEWr6FBvQCdEyu751aoNsT0
 sWA23rI8YZp3XRektgg6m5ar9XZL9VA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2077281E84
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 08 Oct 2026 16:30:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791469838;
	b=cYfdwgIfDt9jmU+I3X8PwB94hWll0XUnO0j7xeX++ziTq3C8Uxrp2eztQJ2tcNzynCKeZL
	usdIY/5r9OsXmxGcOaVTaWeclzJWmJPbB0FkpOzuDY9FWpyuSl+UIL2HwXtqeOB4ukjll9
	LFP+iDmIF9rTXGaVDcB7uuJWVtnHKnA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791469838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=+60+tNcKIANPZCz6ZmrjvQVlbtzjhSY6Y53pKv/rBrM=;
	b=QVOvRVU+d/SVSmn/mozKTvKOP1F/vHJjdfhXG8KifWTjL4TS4CMcqvMOZJzA47B/BVDZgb
	1sf7ngSR+kIZpooDTGe0QLLzOMVvA9Qt54MXlGCliYREMWtnquAmF9MqP2jmw3OUMoAzch
	7WmbPF6egMs+pgyzPYflxkPhAA5G8fU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b="W/os3iO9";
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A3DFE204B3;
	Thu, 08 Oct 2026 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791469826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+60+tNcKIANPZCz6ZmrjvQVlbtzjhSY6Y53pKv/rBrM=;
	b=W/os3iO9qEmmYjoWKLn/r8srSNv8lj9f+YXKyshSuJcxseixeybET+L89zWrANHB0lgvyd
	A6gSHkkCirKNPRYLi4KjSe3SfjgRFEdOBeN3rtPuHG6kgjYYU8YXAFr5YyNFUB47xshXqm
	Lqc06IYIAowJaCN+fn04H/yXo/z1UWk=
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 08 Oct 2026 16:30:06 +0200
Subject: [PATCH batadv v2 1/8] batman-adv: tt: only transmit local ROAM
 flag together with DEL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-tt-avoid-unhashed-event-v2-1-7c4eed81606d@narfation.org>
References: <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
In-Reply-To: 
 <20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3659; i=sven@narfation.org;
 h=from:subject:message-id; bh=2AjblGIHugelBiyPTOFfyonffvQU12ulU0yFvtTQ49g=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnHV3wo/nDghc1nZdlj60Pn+hxz+Tb1/vr49zoTtizL1
 t0a4Ch7taOUhUGMi0FWTJFlz5X885vZ38p/nvbxKMwcViaQIQxcnAIwkagYRoYn2tO15CNq/PkV
 GNsOVD/xXdbsEtKgfNs66mbOzsQPJ1YwMuwsLnm/V+6qOk+dzFJ71oS1U+5tWpKjzXvk1umCLeu
 013IBAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: ZJSG7OSQFQPVBO6DAIZZMYQSOB734474
X-Message-ID-Hash: ZJSG7OSQFQPVBO6DAIZZMYQSOB734474
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZJSG7OSQFQPVBO6DAIZZMYQSOB734474/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

BATADV_TT_CLIENT_ROAM is part of BATADV_TT_REMOTE_MASK but on the wire it
only has a defined meaning together with BATADV_TT_CLIENT_DEL: the
originator no longer serves the client because it roamed to another node.
Such a DEL is only relevant for events (non-full table requests).

An ADD carrying ROAM is processed (by accident) by the receiver like a
ROAMING_ADV:

* a newly created global entry is marked as roaming and is excluded from
  the global CRC. but the sender includes it in its local CRC
* batadv_tt_global_purge_local() removes a local entry of the receiver

But such a behavior doesn't make sense for non-ROAM_ADV because a new TTVN
is meant as announced commit of the local TT table of a node and should
therefore not be used not be used to create a temporary (roam) global entry
in a node.

At the moment, such an ADD with the BATADV_TT_CLIENT_ROAM flag set can
happen due to two mechanisms:

batadv_tt_local_valid() copies all flags of the local entry into a full
table response. It is not synchronized with batadv_tt_local_mark_removed().
An entry which was marked as ROAM|PENDING by a ROAMING_ADV is still part of
the current TTVN and is sent with the ROAM flag set. When the requester is
the node which sent the ROAMING_ADV, it then marks its own (new) local
client as roamed back to the old originator and drops it when it is still
NEW. Other receivers will detect a CRC mismatch and request the full table
again.

The same can happen for an ADD change which is queued for an entry which
(still) has the ROAM flag set. For example when only the dynamic WIFI or
ISOLA flags were updated.

It is not triggered by batadv_send_other_tt_response() because
batadv_tt_global_valid() is already taking care of filtering out
BATADV_TT_CLIENT_ROAM entries.

For the two problematic announcement mechanism, only send the ROAM flag of
local entries together with a DEL.

Fixes: d46bf9e69b31 ("batman-adv: correctly pass the client flag on tt_response")
Fixes: 2443ba383c7d ("batman-adv: roaming handling mechanism redesign")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/translation-table.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index e46040fd..40f2138e 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -696,9 +696,17 @@ static void __batadv_tt_local_event(struct batadv_priv *bat_priv,
 	ether_addr_copy(tt_change_node->change.addr, common->addr);
 	tt_change_node->change.vid = htons(common->vid);
 
-	tt_change_node->change.flags = flags;
 	del_op_requested = flags & BATADV_TT_CLIENT_DEL;
 
+	/* the ROAM flag is only meaningful for the receiver in combination
+	 * with a DEL. An ADD with ROAM would be interpreted as a roaming
+	 * advertisement
+	 */
+	if (!del_op_requested)
+		flags &= ~BATADV_TT_CLIENT_ROAM;
+
+	tt_change_node->change.flags = flags;
+
 	/* check for ADD+DEL, DEL+ADD, ADD+ADD or DEL+DEL events */
 	spin_lock_bh(&bat_priv->tt.changes_list_lock);
 	changes = READ_ONCE(bat_priv->tt.local_changes);
@@ -3395,8 +3403,12 @@ static bool batadv_tt_local_valid(void *entry_ptr,
 	if (tt_flags & BATADV_TT_CLIENT_NEW)
 		return false;
 
+	/* the entry is (still) announced. A ROAM flag of an entry which is
+	 * pending to be removed must not be transmitted. Otherwise, the
+	 * receiver would handle it like a roaming advertisement
+	 */
 	if (flags)
-		*flags = tt_flags;
+		*flags = tt_flags & ~BATADV_TT_CLIENT_ROAM;
 
 	return true;
 }

-- 
2.47.3

