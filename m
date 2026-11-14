Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9A4606A331
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=e474Cllx
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4320485BCF
	for <batman@archiver.kernel.org>; Sat, 14 Nov 2026 10:23:40 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794648220;
 b=MDayw1o7o4vpykz9XHZT5p3wcU3GE9n2GVv27MUFYwfHNsXTozQA+gwKhNFB9fHsa5t6A
 MFY2SPYsjEhFWMZDde7lVHwtg6BXXZtVRxTlwLKj8phhNsLhKGrxuFGO1BQ9q+BzG8ukj5n
 2MR+XeK1pioe4OHRrR7+k7AACxXzi9s=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794648220; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VeB0jYC6+zpSJAoBxeDUgpp5ixdXEAE72IDA3+gAE3M=;
 b=cVxP4eyAzcMqlOba50BUAG1L/oOpqajlr3ye1tTsA92ONR2UiQoC5/j5lhSvrJDgc0teG
 W6uZvdHypsOCmD1wXMpOtR6JhJJan6/ESiim93ZEO/r4O8uZgZOSkfnkwAfDYAnCv3fnw2L
 +aEv4LOjIc1gA+4soh1/cqqbLwUqaGo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 28BA98475A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 14 Nov 2026 10:16:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794647782;
	b=1GEF0YlUvRin5brNsjcc62gAmdLhaY+8ZfSxHjo8hq8taWA/KDjrHfrhVLSboCHthi4J4r
	57kFvkzhVWEMxlieZ30aV1r7lZAyTtocRThaSrn3NsQO6lzKM13Krthh3TheIOg+0AKNM3
	yMeOi/qGfjH9oVq0fU+grZy/r9Dj1T8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794647782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VeB0jYC6+zpSJAoBxeDUgpp5ixdXEAE72IDA3+gAE3M=;
	b=PHLhXR/Dnk9p7D6I7WSY8Juk7i62GEPDPHYWQohRN7pBR9e4IKfN/+SvPFiSELN1BAH8Zi
	xK8D1wINO4VUQJrI2JDbsFk1gHStVCIBiHPKmt6+GMda5uGCDtFaztjf9X3WTIGkkNGyAo
	D/xvwGxW/PYE0obA+9i64kH5HNgG1s0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=e474Cllx;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de (unknown
 [IPv6:2a02:3037:6ed:dd6c:838:344b:3152:2d5e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 4DE2AFA262;
	Sat, 14 Nov 2026 10:16:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1794647769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VeB0jYC6+zpSJAoBxeDUgpp5ixdXEAE72IDA3+gAE3M=;
	b=e474CllxrcR39m3gPVulcyvj/7YmhHLQVhpSzL6UofdzAruhudb5Hpx+/e9B3kYzIWdWJj
	afteiIijqvXeY8ad7F0tdYtdIMVRgFHnGxkAEgd1CIhr97Ywejmxa2+oJyX+LQwnSaUk2w
	O2sZWAz8chSqtaa7hpaXlPn0CxxKN8j5EGP3Mks//sEDYDB7OXv95ltV0EbaZjnWRt7cz0
	p6sJYrZeE4IpwpA7T2ljHLXSnFSi+cjYGspoymttUXvaOIk5mxrCAQR5Gt80tdrH+lnqGM
	qhN7hJuLPPIIxz2WigLQGOG8ClN/xR/M46v8bBXbL9OaPg9F1B4K6fr09ybMVA==
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
Subject: [PATCH net-next 12/15] batman-adv: dat: increase hash generation when
 purging entries
Date: Sat, 14 Nov 2026 10:15:53 +0100
Message-ID: <20261114091556.3336038-13-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261114091556.3336038-1-sw@simonwunderlich.de>
References: <20261114091556.3336038-1-sw@simonwunderlich.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: YMTUJOOQ6GHY2YT2ZK2YUQIJLHQPYZQE
X-Message-ID-Hash: YMTUJOOQ6GHY2YT2ZK2YUQIJLHQPYZQE
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YMTUJOOQ6GHY2YT2ZK2YUQIJLHQPYZQE/>
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

If batadv_dat_cache_dump() is preempted during a netlink dump and resumes
in the middle of a hash bucket while __batadv_dat_purge() concurrently
removes an entry, the dump offset will be shifted.

Without incrementing the hash generation counter, netlink won't set
NLM_F_DUMP_INTR and the userspace will not be informed about the
inconsistent dump.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-83da443f-ce69-4393-a29f-e02b70d1ec96
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/distributed-arp-table.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 37de9787104d5..d558d2300d607 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -248,6 +248,7 @@ static void __batadv_dat_purge(struct batadv_priv *bat_priv,
 				continue;
 
 			hlist_del_rcu(&dat_entry->hash_entry);
+			atomic_inc(&bat_priv->dat.hash->generation);
 			batadv_dat_entry_put(dat_entry);
 		}
 		spin_unlock_bh(list_lock);
-- 
2.47.3

