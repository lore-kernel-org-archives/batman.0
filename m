Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF7DCD4F3C
	for <batman-adv@archiver.kernel.org>; Wed, 20 May 2026 12:05:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7B1ED8408A
	for <batman-adv@archiver.kernel.org>; Wed, 20 May 2026 14:05:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779278721;
 b=SNT+b55ZhHc7OlFLPWFE1QloREdKNBmPYw/w0nwOPVqFBzSnovuxBOpnvnx6colQ4zV6H
 bIUZ3x1YQrZ4A+EIOy5oTGpMn9no5q98t+pwlkGCnaTuY+eSlzmV0PjxRFbzzlTZpyaWD6t
 f8oAzE/rwwzhx1GGtWlEpYmMBBehJEU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779278721; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TMSBQ8vty5KjvQRWobUPtXD4d+KsnwJfeTiOE5MDdw4=;
 b=fCyP+9ou41Jhf1V4Fr0s5kFHRddp/V+hPo33Zvgz8ywGvFziVTSR+37j3pvzTNEEeDj4C
 6RV3Vx1Tn06H/KO0bzhuKCGvVdfpduGj639eu77BR6owlSZE7h6BrTlPAGVnUAG22Z9xBnK
 oYr7vdI5ZO2tQ+WbrnIamOwWrTWf6TU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7C0CB811CA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 May 2026 13:54:46 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779278086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TMSBQ8vty5KjvQRWobUPtXD4d+KsnwJfeTiOE5MDdw4=;
	b=YlGQ/xDD2uukqC81E8FE5QaAUQesbaA/CkXbFYp6VxJpU3Udhi+Ifdvwm0zp8NYxLvfD/G
	aAIozNnFmKrMhNzLCf2NYMLvJiiRHgftdq/iRpLgJljEh+XyPihHmmw6ipneE4DHbpv+ZN
	FEb7XBa5vGyfSwPQj6dT9XyR06H2uBE=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779278086;
	b=BOpHATkeLxdJXZGIjuZk49kWOxx4pi64RyAlJA0vd65eZkb2TL9SVOzeIuAJ/q4AfZaFSl
	tz9JkmzmsrguCF5BZtOip9rPXK8h2jvocwYdUc2eJjpvOmC9V4e87u7yxTJ8l9KCGpuTWa
	1cxPmXxEyn8S9pmN53yhUEYEn00STEk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=WmlK1rmA;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779278085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TMSBQ8vty5KjvQRWobUPtXD4d+KsnwJfeTiOE5MDdw4=;
	b=WmlK1rmAnMvhqs2bx78u4Dhvw8v6D2tlP3X/UNXu8ET8l13eZFRWzc15kEtWCn4DBbLSt+
	1WsyNqT0r/f2rArZpvQR5Qgm81/wqApw0r4wDaWE5zM/nntmewaqID1Fs8WtFr8bLRm7mB
	/Iqv4JhvN812Hgsv7Q71+Q5rpWY3lK5prACqHcGc3Ht/YQTy4pgI6+PDPeUxtKapJzEGqG
	Fjp4SX/qjvRtFle3lRoxKodEz9pxSap472+m7Oeb7t6QQyk4OTeD7B7PIjXz73aMCbb4Eo
	Qa4ModJBAKQhwqmd3V/KUxLXyYj227y368mhn1zEXSQ+hwdByzy5pWqplhOfiw==
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
	Ido Schimmel <idosch@nvidia.com>,
	syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 11/11] batman-adv: bla: avoid NULL-ptr deref for claim via
 dropped interface
Date: Wed, 20 May 2026 13:54:22 +0200
Message-ID: <20260520115422.53552-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520115422.53552-1-sw@simonwunderlich.de>
References: <20260520115422.53552-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CVYKBZ6IXVGHFHFECSTY7IPBMX3QD6AH
X-Message-ID-Hash: CVYKBZ6IXVGHFHFECSTY7IPBMX3QD6AH
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CVYKBZ6IXVGHFHFECSTY7IPBMX3QD6AH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

Without rtnl_lock held, a hardif might be retrieved as primary interface of
a meshif, but then (while operating on this interface) getting decoupled
from the mesh interface. In this case, the meshif still exists but the
pointer from the primary hardif to the meshif is set to NULL.

The mesh_iface must be checked first to be non-NULL before continuing to
send an ARP request using meshif.

Cc: stable@kernel.org
Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
Reported-by: Ido Schimmel <idosch@nvidia.com>
Reported-by: syzbot+9fdcc9f05a98a540b816@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9fdcc9f05a98a540b816
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bridge_loop_avoidance.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bridge_loop_avoidance.c b/net/batman-adv/bridge_loop_avoidance.c
index 1bef12e659cb2..ffe854018bd3a 100644
--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -356,12 +356,14 @@ static void batadv_bla_send_claim(struct batadv_priv *bat_priv, const u8 *mac,
 	       sizeof(local_claim_dest));
 	local_claim_dest.type = claimtype;
 
-	mesh_iface = primary_if->mesh_iface;
+	mesh_iface = READ_ONCE(primary_if->mesh_iface);
+	if (!mesh_iface)
+		goto out;
 
 	skb = arp_create(ARPOP_REPLY, ETH_P_ARP,
 			 /* IP DST: 0.0.0.0 */
 			 zeroip,
-			 primary_if->mesh_iface,
+			 mesh_iface,
 			 /* IP SRC: 0.0.0.0 */
 			 zeroip,
 			 /* Ethernet DST: Broadcast */
-- 
2.47.3

