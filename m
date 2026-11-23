Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B54C606A31A
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 17:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=fSbzlS85
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B422984877
	for <batman@archiver.kernel.org>; Mon, 23 Nov 2026 18:21:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795454462;
 b=m6jDWL2KGZxPkrTznMc2RQvUSUn66a3PEK+2hL+TibWKajAV/TSSGaUrrf3Pnf9sKBBrN
 WfnYAL7OyPTgsLFERQ5MtoTEWRj7AZhKOgbqdR5BSCcQXUwdzdwdpOLaKx7fEMVY6OilIab
 U/3KfwbPaRTl5S2po4GfhGjZZTX9PWc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795454462; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=61uMj0sUvajsGIc4hbK6/2n/ENBq0us5BtBioYyKYo4=;
 b=IciJw9xqrEO2Mzr1HGTAhjVwvQ0D1sW0HlIEo3ZJORWeY7/1yn2FoTyhkRO+S52hQv3EM
 k786NO3muQvcmKoLmuUkBPPa9XfAmkmepkQV+ePdycS7r/upqS8f7LkEnIwVf+S4VRzNRnf
 dylcpe29mxOYauEoL7GMgJjh2T6nd+s=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 0E12284459
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 23 Nov 2026 18:18:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795454324;
	b=XUZKaTt+/5dsq2SPRSn2hHBHM2Qt0HUe64/rY8+pgjJw/XHfCwDgv4ajleX5a5l1jYFR8F
	GycaKI7coXAUWa1UdCxerwQXQDo6y7zivCNBYcz/WJC7U1l7a+ieo7XGL/5VSlJEXQzrKw
	8lBwRYcsH6MWdJpLGWZCskFs9YurQCU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795454324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=61uMj0sUvajsGIc4hbK6/2n/ENBq0us5BtBioYyKYo4=;
	b=K8V1W1MFNTcPSXTW0Qb3H8Y9CUpcZ7mnW6iquAdbM+gxL4WfqA4fBHdsJJzVoqgPfoJ2/V
	5SRvxwgLe/eyMeZKX00Ec6ve9zTiDtO7SvLLCis51hGSbDmeiaCzG1J7D1Z0quHdzaQ1c1
	1uCHw5LKv9HiBbxPi2MXXkXt5E43ZJY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=fSbzlS85;
	dmarc=pass (policy=none) header.from=simonwunderlich.de;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c59714c2E05A704819B6bA2DB4.dip0.t-ipconnect.de
 [IPv6:2003:c5:9714:c2e0:5a70:4819:b6ba:2db4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 5D2D7FA264;
	Mon, 23 Nov 2026 18:18:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1795454313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=61uMj0sUvajsGIc4hbK6/2n/ENBq0us5BtBioYyKYo4=;
	b=fSbzlS85KrQN9fPaljyZS+1AuCfu3UbGT3TvUSyCGP9qaY6ZjaIdIviO0gCFvLiase7sGl
	QGgIR4xGFLXqJ+JIxgH97bh35tLfArWdKdLCR6wB2h6pKYRNWf/h+efsb0XhWYK86dFKej
	A7Gpa/jiQeKRTEw8/uXdYwJCD10zTo6yDXEorm9TGVkq5+8DZWleXuUm0tvV//9SBoy2QT
	t/b1MTS+D/1XxrX/Atux+Hs0ffuLFflMe70Km3IhDGhlJR2E51cgLkac8T+V/sMiXjshZn
	4r4z/TSe1ZuWsHkLLDeLjqn1NcJDED9ssSiETi7kgwTyA/CLuHCrxgWAtUbizA==
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
Subject: [PATCH net-next 02/15] batman-adv: mcast: use mla_lock also during
 mcast_free
Date: Mon, 23 Nov 2026 18:18:14 +0100
Message-ID: <20261123171827.3294525-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123171827.3294525-1-sw@simonwunderlich.de>
References: <20261123171827.3294525-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 24F3KTYQ3NI4ZWPSJJRE6UBIRFT74CIV
X-Message-ID-Hash: 24F3KTYQ3NI4ZWPSJJRE6UBIRFT74CIV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/24F3KTYQ3NI4ZWPSJJRE6UBIRFT74CIV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sven Eckelmann <sven@narfation.org>

While it is technical ok to not hold the mcast.mla_lock when calling
batadv_mcast_mla_tt_retract() in batadv_mcast_free(), it is more clear to
always require the lock when calling batadv_mcast_mla_tt_retract(). This
strict + simple rule will later make it also possible to check the lock
requirements automatically via the LLVM/clang CONTEXT_ANALYSIS.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/multicast.c b/net/batman-adv/multicast.c
index 415981fe6dc6..703f61955083 100644
--- a/net/batman-adv/multicast.c
+++ b/net/batman-adv/multicast.c
@@ -2184,8 +2184,9 @@ void batadv_mcast_free(struct batadv_priv *bat_priv)
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST_TRACKER, 1);
 	batadv_tvlv_handler_unregister(bat_priv, BATADV_TVLV_MCAST, 2);
 
-	/* safely calling outside of worker, as worker was canceled above */
+	spin_lock(&bat_priv->mcast.mla_lock);
 	batadv_mcast_mla_tt_retract(bat_priv, NULL);
+	spin_unlock(&bat_priv->mcast.mla_lock);
 }
 
 /**
-- 
2.47.3

