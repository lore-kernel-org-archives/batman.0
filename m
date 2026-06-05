Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C2D9CD6E5D
	for <batman-adv@archiver.kernel.org>; Fri,  5 Jun 2026 07:22:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C467083E70
	for <batman-adv@archiver.kernel.org>; Fri, 05 Jun 2026 09:22:34 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780644154;
 b=sTzi5FQUmlmKy2bLN2qfMLZ4cHbkrG+Uij2E0flqUzX4xhDYNX7HVXptqUs9YbM/pjEJp
 lrK0P3zgCbo9mCyoyW+E0y1goA7l/X14dAMfJuKsfLM5NyfNrrbvpMGIoqe91DGva0pxK4Y
 sNBS0hwadCfzTa6GVlsnaHvXvxCgCO4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780644154; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=GMORY68y61x7YxYlF+M8ex7S25F3TE7zGYk45tfFhIo=;
 b=ahuSIPzIoXweVjCI9kgDrGfuG317QiKn0MIRE7d773D5193iMZGmkQ0J3CfjPkx/Wf9pD
 GZUcDKukesMKyNM0flYeFm/0tjdFza4fxz78GC5YK41hZVDx0jYiqXkmK3DEt7uxo4xCZP1
 dVdnTMaM0PVCeccz9ZuEc6TjJaoVpRA=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0B19B81067
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 05 Jun 2026 09:20:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780644016;
	b=UfFVMtrDGFtUj7YMe7Wxdbsu/j1eplfskN3oVUWQxp2KPnCtdxjfH8DjREZM56iBGzJQLX
	EdLSgL7tEdmodsIJZwnobUA7oFhADIEp+SqGddl88sEyVSpfkf0LqkkwyWMBTGPM46FF4D
	xCED8BBKy5oVCWJ3ytYr/4mg7guVo3g=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=cXBNq0Ea;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780644016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GMORY68y61x7YxYlF+M8ex7S25F3TE7zGYk45tfFhIo=;
	b=xhoHFTSZRphRRiP7rr9bsWJbXfcrwfRsLqkn3d2LqIX7nd49C5PZ7v2cQjygFCb7pC4RWj
	Rr0mY900+0JwBM/cxvli2/MiJOFe56n+IOQe8uElwGoU4x8u+afrrZkeC3uF/jXzkdTxZG
	onC4AtKNqpl0npxb6WXEUP6P6uFrPy0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1780644009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GMORY68y61x7YxYlF+M8ex7S25F3TE7zGYk45tfFhIo=;
	b=cXBNq0EapxrU8iHPDLsl+B+vEPW1yjT49Yf9HZ9UzfW5E+7JKW5Mbw/jVY7/km8GqWmje3
	cESEqihQPhMuYk3a581JrlktxmktXj5QmyKHD4HnPQ1oo701G547ifzJRhevVjCTcxY7OC
	Sp0F3NU0nm8DNmKVme4leBWhjxFf48f7KGPh+QLiGoR2R+TtazA0KgWzUIXBpFjxB0sl/f
	irvmwWhE5Uy3IaImqydrLanRPkl1gc3esRMW4OmwPyUmL4z9F3amqOxVp5/S1qLWisllHF
	YPqHjtS7E+uwy7CyM2gvgVSVKE1tWSE6X4RD6lRiuYw16/gtcjMAkXh+d4QnjA==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 01/11] batman-adv: tp_meter: initialize
 last_recv_time during init
Date: Fri,  5 Jun 2026 09:19:55 +0200
Message-ID: <20260605072005.490368-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260605072005.490368-1-sw@simonwunderlich.de>
References: <20260605072005.490368-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6LSQZTROZYZK6NCXS3IBJEXTVG4ZSAUX
X-Message-ID-Hash: 6LSQZTROZYZK6NCXS3IBJEXTVG4ZSAUX
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6LSQZTROZYZK6NCXS3IBJEXTVG4ZSAUX/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The last_recv_time is the most important indicator for a receiver session
to figure out whether a session timed out or not. But this information was
only initialized after the session was added to the tp_receiver_list and
after the timer was started.

In the worst case, the timer (function) could have tried to access this
information before the actual initialization was reached. Like rest of the
variables of the tp_meter receiver session, this field has to be filled out
before any other (parallel running) context has the chance to access it.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/tp_meter.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 978e32d94e6c3..cc72468ca2abe 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1511,8 +1511,10 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 
 	tp_vars = batadv_tp_list_find_receiver_session(bat_priv, icmp->orig,
 						       icmp->session);
-	if (tp_vars)
+	if (tp_vars) {
+		tp_vars->last_recv_time = jiffies;
 		goto out_unlock;
+	}
 
 	if (!atomic_add_unless(&bat_priv->tp_num, 1, BATADV_TP_MAX_NUM)) {
 		batadv_dbg(BATADV_DBG_TP_METER, bat_priv,
@@ -1539,6 +1541,8 @@ batadv_tp_init_recv(struct batadv_priv *bat_priv,
 	kref_get(&tp_vars->common.refcount);
 	timer_setup(&tp_vars->common.timer, batadv_tp_receiver_shutdown, 0);
 
+	tp_vars->last_recv_time = jiffies;
+
 	kref_get(&tp_vars->common.refcount);
 	hlist_add_head_rcu(&tp_vars->common.list, &bat_priv->tp_receiver_list);
 
@@ -1587,9 +1591,9 @@ static void batadv_tp_recv_msg(struct batadv_priv *bat_priv,
 				   icmp->orig);
 			goto out;
 		}
-	}
 
-	tp_vars->last_recv_time = jiffies;
+		tp_vars->last_recv_time = jiffies;
+	}
 
 	/* if the packet is a duplicate, it may be the case that an ACK has been
 	 * lost. Resend the ACK
-- 
2.47.3

