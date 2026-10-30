Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE6C606A31A
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=X7LUlO71
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id AAC0C83C3D
	for <batman@archiver.kernel.org>; Fri, 30 Oct 2026 14:53:37 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793368417;
 b=amEs7dPEQfvJjLkL9UVyJhB4nqP0KNjLeIbvMX2CHRj+wVrMK60m92976MSQhja5oSZor
 a7RXqj+Anj+Ekw+Ui8dZozMGORn5LywTED30Va/iRJkRmS3CURGMHvTfaJ4TqBuj3uihqDN
 JlbX4llzCVMJSyVGntyz3KEj9mNX6VU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793368417; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5VFfE+Ja1v7fq+LdBxrDTp1pJJQrK5P+CsSeA/Arnmg=;
 b=kud7xEO/W7UEPDuksK1e/Abo+wqXQdeJzOzn6RxNjj5ZxwobmgJqxj/RBFnGdzO+DsDAO
 mOGKMndEjCcq9kfza+JdWgqzJYKCldtTmEAkNJZ6cUL48/d0H7D/k7ZU9ARUuI10/q2DtwB
 36yr2jAw0lVv0u9MSmfvkUgoX9cblWM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id E526D83E9B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 30 Oct 2026 14:51:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793368281;
	b=hPOyDudbaOKautElEqanyrkx9NBVoiD72fsXDCK/MhvRWt8zKRUXs2hY66j1EFMOTwKhRB
	DQrGSQ9qBo/2qAvO2FT26GIZTfJ0a9yK8eJEv2LA7dUhkSBi5AIKYWfWFIaE8r6KBtLklz
	eOaiLd9qAXSOcPysGVuwRVN57l9FoN4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793368281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=5VFfE+Ja1v7fq+LdBxrDTp1pJJQrK5P+CsSeA/Arnmg=;
	b=qX+wbT439Nelmaa7HtfmAKI2kFnlmgGkHE23gppre8OyRAZVzUU+LOxnWvpj3eGEfKiEnA
	XmhYMq1g40T7DnFC5zccIbyqor6TIOtSuO61RgGaUNiQp2crXbOOkwsZXcO5SybXCcOjGu
	GTmpSe+dtLqtp3+qnXtCWxQ13j68vJU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=X7LUlO71;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300c597124Fd839580C360D3ed6f6.dip0.t-ipconnect.de
 [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 67A5AFA2EE;
	Fri, 30 Oct 2026 14:51:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5VFfE+Ja1v7fq+LdBxrDTp1pJJQrK5P+CsSeA/Arnmg=;
	b=X7LUlO71Okd/VctZ/Rom2MH1z5Hg9fQtbTRyNlFWxrh5vqFG7vOnGEoooD1G4qgui064f0
	PjDCDwKSjX3K1Gitg0XyzLdXsN2hffGzJCwai4p/atXFoSEdmCHwg3kLyLVx871FTZOQs1
	50ePOaxiISuCi93OlNeMTdV4osz6zqw1G7C9Enaw+SLvR1Uo5QJz5APPBBJkNPRmmLZVdc
	W/tTFpmKiTEjduTCyjEMLiVl1UJLLN+hIUM2BxtQmBdQBSZlVydB38KBa22gtPrcqMNQIV
	7/bpUNmQV9ORrA7PqDqCIP+07aTH7EeEkcyL4857TO5Qmh+dG+Fh2NA/mmvCbQ==
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
Subject: [PATCH net 11/14] batman-adv: tt: ignore ROAM flag of received ADD
 changes
Date: Fri, 30 Oct 2026 14:51:02 +0100
Message-ID: <20261030135105.2555887-12-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AOYWYAMVDOPFBKW72BEAAQZTCJUKVNGV
X-Message-ID-Hash: AOYWYAMVDOPFBKW72BEAAQZTCJUKVNGV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/AOYWYAMVDOPFBKW72BEAAQZTCJUKVNGV/>
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

A received TT change (OGM diff or full table response) with the ROAM flag
but without DEL is handled by batadv_tt_global_add() like a ROAMING_ADV:

* a newly created global entry gets BATADV_TT_CLIENT_ROAM and is
  therefore excluded from the global CRC. The sender has it in its local
  CRC and the receiver has to request the full table again
* batadv_tt_global_purge_local() removes the local entry of the
  receiver. The receiver's own client is considered as roamed to the sender
  and frames for it are rerouted

The ROAM flag only has a meaning together with DEL. Drop it on reception to
keep it from populating the global table with a temporary ROAMING entry
which is not part of the CRC - and therefore causing a CRC mismatch.

Cc: stable@vger.kernel.org
Fixes: 068ee6e204e1 ("batman-adv: roaming handling mechanism redesign")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 0df51523dcf0c..247cce95c09f4 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -3941,21 +3941,30 @@ static void _batadv_tt_update_changes(struct batadv_priv *bat_priv,
 				      u16 tt_num_changes, u8 ttvn)
 {
 	int roams;
+	u8 flags;
 	int i;
 
 	for (i = 0; i < tt_num_changes; i++) {
-		if ((tt_change + i)->flags & BATADV_TT_CLIENT_DEL) {
-			roams = (tt_change + i)->flags & BATADV_TT_CLIENT_ROAM;
+		flags = (tt_change + i)->flags;
+
+		if (flags & BATADV_TT_CLIENT_DEL) {
+			roams = flags & BATADV_TT_CLIENT_ROAM;
 			batadv_tt_global_del(bat_priv, orig_node,
 					     (tt_change + i)->addr,
 					     ntohs((tt_change + i)->vid),
 					     "tt removed by changes",
 					     roams);
 		} else {
+			/* an announced client cannot have roamed away from
+			 * orig_node. Only a ROAMING_ADV is allowed to add a
+			 * global entry with the ROAM flag
+			 */
+			flags &= ~BATADV_TT_CLIENT_ROAM;
+
 			if (!batadv_tt_global_add(bat_priv, orig_node,
 						  (tt_change + i)->addr,
 						  ntohs((tt_change + i)->vid),
-						  (tt_change + i)->flags, ttvn))
+						  flags, ttvn))
 				/* In case of problem while storing a
 				 * global_entry, we stop the updating
 				 * procedure without committing the
-- 
2.47.3

