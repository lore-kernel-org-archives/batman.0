Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B391A606A334
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=Blcz3VYM
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 342F585772
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:19:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794647951;
 b=D7m7FYqFF5h8QjNQK3Pq+wqcyQ2qBjlFpsvSvMVoUOK253CkNrJOCyslxfoOs6iQ+RUCo
 HGrk09brv67UQ2TZKbyqKuhlQUPgN3JdN3ZUWqKYKZ2JwYqhGrqKuKas1YQFqmHFI6U2Hb9
 SnrJlLcPxzsbeSujeNBaQKMymOVyboc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794647951; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=vfa0AsOKduV86UNfepDSvCQLv6EBZg4lBd1rkjOjpf8=;
 b=QYs3MFC5Yhi74LBr1WAZV1P/Ql99C6E/WZkzEcHQcSimdY44K+YL60fbXNOeirAYXF9oa
 Yo+B/5q9EJ9VNvrBmdOmZmv272XKH0FJ3PN+3mG1CQgkN+vwtFwq0VoGQXn+JJVgmmAcMOI
 eaBJ13Lr09B/8gGretinMHlP2+jgsr4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 188D382269
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:16:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647773;
	b=AhG5a5AhhqIoZ0Gf637wU4xKcLN5KDz6UqebEoYfUieGngHwRVCRPDoY7IDYhgIoVXMKAD
	R5GP4ANhHAC7vxyWBaHc2ZAPdN94+B1hx7bFsk+FxeVqqFaa23vrSQpRCG9RsIxILGgemD
	5E9fXC18BVkVHcOZSBhm4t69ZuZiJ+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=vfa0AsOKduV86UNfepDSvCQLv6EBZg4lBd1rkjOjpf8=;
	b=h20nintilAXNpR3dOH+9aFV6v7J3s+/4u7LYFdo7nSndJS3TGZurYRdcXwYHSl+31yrwP8
	C7J0/dRbpKi4ZIki7shUwSFvpk86sQ3wMQPkv38A5/1+mEE0MzdtfBfPFdnhdPTTb3axKy
	ohvn4wAnV4p/aLVfmeTFt9ZlMtZ3uWU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=Blcz3VYM;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de (unknown
 [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 3B648FA265;
	Sat, 14 Nov 2026 10:16:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfa0AsOKduV86UNfepDSvCQLv6EBZg4lBd1rkjOjpf8=;
	b=Blcz3VYMkICeQxeKnZl7JUVCGUCK9tBEdRd8cz5dsOggZwzkQGpFl0JiCUcnxJgLa/EhCg
	VkDWjS3EYtH41zDMKW/BpcXBOZQPrylYPdWju9dy2B71KB2YDIFV/rLQYMp3SN3xPlgUmU
	TjTP1fhbMgsLS2iUnZX8kIJxV62QbZq7y/UY7YSfde+7+NQlL9qP49dDTlNmPCounuL6hU
	dLZXYvze5Z1bk8qYHpyEQ51Sr+RV/qrIWeLW4oj9mwxb/cLVcpJSLUiJFWxWApYOrO+Bi1
	L+l6iI2w5RTqSCOle8/Yh3OI3LcKIMUBzC1sEwEygt2i+nAbglhNbdjPsZrS1g==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 14/15] batman-adv: increase orig hash generation when
 purging originators
Date: Sat, 14 Nov 2026 10:15:55 +0100
Message-ID: <20261114091556.3336038-15-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114091556.3336038-1-sw@simonwunderlich.de>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: C5KKBJ7J2NE3Z5FIUKC4R7UM4ZWYME5O
X-Message-ID-Hash: C5KKBJ7J2NE3Z5FIUKC4R7UM4ZWYME5O
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/C5KKBJ7J2NE3Z5FIUKC4R7UM4ZWYME5O/>
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

If batadv_mcast_flags_dump() is preempted during a netlink dump and resumes
in the middle of a hash bucket while batadv_purge_orig_ref() concurrently
removes an originator, the dump offset will be shifted.

Without incrementing the hash generation counter, netlink won't set
NLM_F_DUMP_INTR and the userspace will not be informed about the
inconsistent dump.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-83da443f-ce69-4393-a29f-e02b70d1ec96
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/originator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/originator.c b/net/batman-adv/originator.c
index 391d97bc938b9..f85ad961f8a9b 100644
--- a/net/batman-adv/originator.c
+++ b/net/batman-adv/originator.c
@@ -7,6 +7,7 @@
 #include "originator.h"
 #include "main.h"
 
+#include <linux/atomic.h>
 #include <linux/container_of.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -1290,6 +1291,7 @@ void batadv_purge_orig_ref(struct batadv_priv *bat_priv)
 			if (batadv_purge_orig_node(bat_priv, orig_node)) {
 				batadv_gw_node_delete(bat_priv, orig_node);
 				hlist_del_rcu(&orig_node->hash_entry);
+				atomic_inc(&hash->generation);
 				batadv_tt_global_del_orig(orig_node->bat_priv,
 							  orig_node, -1,
 							  "originator timed out");
-- 
2.47.3

