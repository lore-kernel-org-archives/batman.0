Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DE2C43327
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 14:15:07 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2E10384432
	for <batman-adv@archiver.kernel.org>; Tue, 30 Jun 2026 16:15:06 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1782828906;
 b=tzBhISUzzh4cefhX3rrgbra11K1Z51w1UJ0wRYeeKa1OTCaN7FyR0e29ZKjXy+DDZdfG7
 FmEuYSYzbPKvNHPGPh2bafoE3jWvVxY3Tf4GYlxUNfqPjwkTGORJ2tZ5DE7PsC+AjnCJnG/
 vAokz3zZCah1Tk7HEbQme0QJj9fVif4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1782828906; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OE7kaThEXzmWHJ+vL8/Sll0PpMgBMOG7wZO9WyyOoi0=;
 b=HBuZtRav7acljETnkcHckJ9Vajkn3nTn0T1WFMxg7hMFCLtsPJ9rI6IDo1hMVWgjjZYvV
 Z3Wip3h4/Zh3BkIhDXM/uedjEQUwoqM34TSOnZ/ofvGQvfk1x6rmVw6VdBNYM9F6aNdVVwU
 lNkS/UtV/ABhOusCrNR+ALToIE5XTio=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CDB9481124
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 30 Jun 2026 16:06:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1782828393;
	b=typVZUfj7In8aRlOxjVzEcqad+nLh+djpdjHWkJC24B5sVAxPLKj4qBd4BzOyrQL09H5ik
	qDfWcqkIX2Z46+ToB0dBwantdqOYqYjzOBb/+F0rO+PWEjejQpoOfcWTe9gk5OgwYdpEfG
	WCZE1WxBzo2S2uIgJC6XgOz288AUpNE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1782828393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OE7kaThEXzmWHJ+vL8/Sll0PpMgBMOG7wZO9WyyOoi0=;
	b=I+cMqYzuSp/BdjTBaZaEN6SLw/1ojYJ1Ylv4SXyQGwJS3Fq5lRNdtz03f2sWmKHofOr7zh
	/ZWlpcXvJ8VF4gKIoK4Hhk/ojAypKUiwzM+ROPsAFn2LpbjRMI2vLI04P+I85QCjEv3JwT
	lLuyf554NE7+Sgtf2b+qudAP8mupjic=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=R78WvwtA;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782828392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OE7kaThEXzmWHJ+vL8/Sll0PpMgBMOG7wZO9WyyOoi0=;
	b=R78WvwtAhpCvWYI04JrJvK9a/3wQdA/xlEyEfxVDslavU/7H2wCDgFVkAN2AheZ/uanrQX
	yzHgTGr+/LMKDIHBZI1ZRNweenkZhHy82D7KPke+hT4q1a0fT/UG+Z0K0Jxy1kijgBHj0X
	6MY4uWrCw7/s+C3zh4OKtDUrJ6+9qijtkyZHVvrTHkU4KoL6FVrbsoCIN+m0Fuu+st6bCL
	OlxrmNImdhkq4JL4sm+IOP/C20iTAFlNZTrIiXBbMIvCFc9hwDkx4bYMs+E+95YxnSwUz6
	3Igq4U5uT84QUFCdpQuQuvXDWJJLah6WEDDbKBeM0H2DNeA4EYdlvnmpoE7aGw==
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
Subject: [PATCH net-next 11/15] batman-adv: tp_meter: simplify unordered ack
 calculation
Date: Tue, 30 Jun 2026 16:06:19 +0200
Message-ID: <20260630140623.88431-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630140623.88431-1-sw@simonwunderlich.de>
References: <20260630140623.88431-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: FI7GUW72DCZNXSCZ7SLSQTUBJITZM23A
X-Message-ID-Hash: FI7GUW72DCZNXSCZ7SLSQTUBJITZM23A
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FI7GUW72DCZNXSCZ7SLSQTUBJITZM23A/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

When batadv_tp_ack_unordered() goes through the list of unacked sequence
numbers and checks for now closed gaps, it is first calculating a delta of
the sequence numbers which could be acked. Just to revert this calculation
in the next steps to the sequence number which would be ackable.

Skip the delta step and directly work with the sequence numbers.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index c2eea7dbc4883..b7fee6e55f032 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1493,10 +1493,10 @@ static void batadv_tp_ack_unordered(struct batadv_tp_receiver *tp_vars)
 		if (batadv_seq_before(tp_vars->last_recv, un->seqno))
 			break;
 
-		to_ack = un->seqno + un->len - tp_vars->last_recv;
+		to_ack = un->seqno + un->len;
 
-		if (batadv_seq_before(tp_vars->last_recv, un->seqno + un->len))
-			tp_vars->last_recv += to_ack;
+		if (batadv_seq_before(tp_vars->last_recv, to_ack))
+			tp_vars->last_recv = to_ack;
 
 		list_del(&un->list);
 		kfree(un);
-- 
2.47.3

