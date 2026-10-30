Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A4A606A320
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 13:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=Wk11/76Z
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 698BB8483F
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 14:56:15 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793368575;
 b=Gilt/EmADYbgLjUjGszaXDYYTQDt7fg6dX14pNl04dHGQZzlzcLZmBE8/b551Knn88SWP
 Nsdzez/OZyEV7PJoaiJBOMRcwlIm3/j4os6Xw3dyfEdhds0h5nGft8c5JRFvcKvUNTKht2R
 HmmzIV4hIql5CcRU5ToqUHx6qP1VltM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793368575; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=4Sdas4EDEWHsgNZKpqDTz51HIwTHhqSyCgWVHRMM+/8=;
 b=bJSV5qc5eb++smFKmlvpJtLri4D+Ro2NBbNDLkUjf7qq9ZhdfTQIs2oo7DvwJlg1IwDKR
 rfNqxn5AEK6kCWIBJKa28vZufk5XcwS163SJsfQNz23IGuNLHjuDDyTBe6tm/rxt3rZfGTu
 JxOHns6q2pBkCTuu9hms2CnXfDtabU4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E897184438
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 14:51:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793368291;
	b=vY4XsvkiVPQ5XlhcgOZP7V++tL0pEswew7rbDlXG3jtdvUumnvMqwmrLhQVarJKKj4yPzg
	t0tGyAT4MHzwuEIj3jvS/20lFOaeTv7FERmaemMJK4x/NuEthtavpNvifaG7MKrfXbVirz
	f5a8qTwnl/58TgkC6/Wi2ILTMH+FpwU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793368291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=4Sdas4EDEWHsgNZKpqDTz51HIwTHhqSyCgWVHRMM+/8=;
	b=c9viMVeQR9w5c0C+h5z7J3FWsUmf23+tbpfhfL7aZfhXsz31u5Qrwe6HCrSacksyjJdRC2
	dtsoAH+jQsEWyXsDXEPySR4H7gETWB8aroSiyTZQVCRzOF00z4V6NmNN7W9k8QPUOCsul5
	e1qZ71BGPcMkI74PGJuBy4A6qH6vYWc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b="Wk11/76Z";
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c597124FD839580C360D3ed6f6.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 3842FFA273;
	Fri, 30 Oct 2026 14:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Sdas4EDEWHsgNZKpqDTz51HIwTHhqSyCgWVHRMM+/8=;
	b=Wk11/76ZRA7BdAZGziY5W0a3IxsEs6b1Xi6FULgiN5ssnc5WryR3K2zLeQImYeJamPYrbY
	BIrd2LZZNE41jtr+3yfOz17UNpuB5e+OZBshy1uvWpNNqIEEXD2T7B7eb1z6AjfjCE2abY
	bIplPYB9oyxIlZwh+chJMcHKEcbCrO0j4pQjv51LjmLGiK0jAZGJBQDupI50hJuequHsXL
	KFPSSbltgNOezryeUEpHKLTCRrkILa+8XU7h0S5d9WqB/niEAok5f8/aKQ5yX8WCMPjAti
	PF7pgWK6gqGNKdDVG11BLJwe0eEunGB+4MntETvB/RiROjyQNAe4/LuloxvCfg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 09/14] batman-adv: tt: clear ROAM flag when re-adding a
 pending local client
Date: Fri, 30 Oct 2026 14:51:00 +0100
Message-ID: <20261030135105.2555887-10-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VIN5BBC6JSWOCKVQNH45QJ6HIEZPB64E
X-Message-ID-Hash: VIN5BBC6JSWOCKVQNH45QJ6HIEZPB64E
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VIN5BBC6JSWOCKVQNH45QJ6HIEZPB64E/>
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

When a ROAMING_ADV is received for an announced local client,
batadv_tt_local_mark_removed() sets BATADV_TT_CLIENT_ROAM, queues a
DEL|ROAM change and marks the entry as BATADV_TT_CLIENT_PENDING. If the
client sends a frame again before the next TTVN commit,
batadv_tt_local_add_existing() only clears the PENDING flag and returns
early. The ADD cancels the queued DEL, but the entry keeps the ROAM flag:

* batadv_is_my_client() reports the client as not served by this node
* batadv_tt_local_client_is_roaming() reroutes unicast frames for it to
  the node which sent the ROAMING_ADV

The ROAM flag is only removed with the next frame of the client.

Since BATADV_TT_CLIENT_ROAM is set together with BATADV_TT_CLIENT_PENDING,
it has to be cleared also at the same time with BATADV_TT_CLIENT_PENDING
when the client roamed back.

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 39b61426f1680..e13c2828da475 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -894,6 +894,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 					 bool *roamed_back)
 {
 	struct batadv_tt_common_entry *common = &tt_local->common;
+	bool readded = false;
 
 	tt_local->last_seen = jiffies;
 
@@ -908,8 +909,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 			 * flag can be reset like it was never enqueued
 			 */
 			common->flags &= ~BATADV_TT_CLIENT_PENDING;
-
-			return true;
+			readded = true;
 		}
 
 		if (common->flags & BATADV_TT_CLIENT_ROAM) {
@@ -926,7 +926,7 @@ static bool batadv_tt_local_add_existing(struct batadv_priv *bat_priv,
 		}
 	}
 
-	return false;
+	return readded;
 }
 
 /**
-- 
2.47.3

