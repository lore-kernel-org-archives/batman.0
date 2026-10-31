Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E789C606A31C
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=T725T2+b
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8FAD080498
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 23:15:17 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793484917;
 b=kLXG8976v+ldYPOUMPbVFAXM0tvAz0bSqb3qpNrylmqfsytOynJqorsjXFq9zHQELhxqm
 +SnbdwfedWlm9mknbd1jq3lj3rYc9SoBX+GOfQ8D0ITYLCLEqntuMor7m8WsvZN5yUKuIJf
 Zg5xz2PK2cfwe9wIPQiMr4lU1BN6TjU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793484917; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=eOxZzL4E+qzkrZ2tLrRFK/7Yq2oJK5eGE0an+cUrETw=;
 b=1i3vdNbWttzePSCJICT5A9qlJ4meCzJM05kvAbJnJq8G8A5WLTSjD30mq9RJUo+1+ZDt0
 Bi80wF7ooiCyQMzvLvBfHf4Ls1gGvGZRn/wfwCm7SUrcKlB7i7LfUHRkcJ68G0EsNNV8fb5
 TdpnEA9lYmhnEiR/kCa7YIoLvVuGfXM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6A552806E1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 23:14:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793484902;
	b=ANtu00wGgJUauEQwxE84S9uZuxDeAviV62pucNmrZKazVvkfL1ygpep9+XYB+EvgF4Sayr
	DMZKvgLCgSAaaEXpB1JUTMXATX+PBH50wT8ThopMMtCTcEGMg7UjwfG3PlJg1sjdTo2OXZ
	iamFnMuhuw5Tz2Fa2J8Pv/M3U8NDzX8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793484902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=eOxZzL4E+qzkrZ2tLrRFK/7Yq2oJK5eGE0an+cUrETw=;
	b=ed5+w2Ya/FjDqkj2JZswS1sspcwu9JjufOHtzMAZBdT2A64nEXYua2DX3z1+B1c54mIDnv
	8uU5SvKeXIupl4pHzNJT3VgTlKgVSRbIEem9fqSY2qghF3535ctCNJGztVJQokqvriWN4Z
	FeQ8+y123HGhn/DMUPRrGGiL2JXL5tg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=T725T2+b;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 7F4A620FD3;
	Sat, 31 Oct 2026 22:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793484890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eOxZzL4E+qzkrZ2tLrRFK/7Yq2oJK5eGE0an+cUrETw=;
	b=T725T2+bj/jDd7Dat/az8XFXduN7ugiX9DdQvRZsNkG+9waDjdPQlYEj0Md8U3gboOr4qB
	j4AV/4KToE0u5qifeyYCG3uMYGE62gZFrVJQWsNZuzdRK9WahU6hqjymNGoni2mW0wuyxM
	e6U5Ml9aT/FXf5nk6b3CQI/IZi+HLzU=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/4] batman-adv: minor scalar types cleanup
Date: Sat, 31 Oct 2026 23:14:45 +0100
Message-Id: <20261031-simple-type-cleanup-v2-0-2c8f42edbc90@narfation.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFVo5moC/32Oyw6DIBBFf6WZdWkAH5iu+h+Ni1FHpbFIAEmN8
 d+Ldt/lvTn3sYEnp8nD/bKBo6i9nk0S8nqBdkQzENNd0iC5LAUXGfP6bSdiYbXE2onQLJaVCoU
 qCqUqnkNKWke9/pytT2gwYBeh/vl+aV7UhqPyIEftw+zWcz6Kk/+7FAXjrMJMdIoqSU3+MOh6D
 On1bXYD1Pu+fwGoteaF1AAAAA==
X-Change-ID: 20261013-simple-type-cleanup-67a175577804
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2056; i=sven@narfation.org;
 h=from:subject:message-id; bh=VJFFfKUR+Qb/bFwC9BdwWQQPRfu3xpvrdbtPp/MTIkA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnPMsJmvZ03sfq23x9LBd0zTMFSTKZSbNa3ZX5cjFKSD
 /9te9Ovo5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRpneMDE/WTXdnPsLhaHBq
 +6wjgo2hz4KrmP5adO37tMwp/5XAiqsM/0x7s7SUOZbfOlZZYOD6XD1BOdhYg519Qfdh7jstk1K
 cmQA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: KZMO6TARFLTDI7KT6AWWHRVQG3CESRQD
X-Message-ID-Hash: KZMO6TARFLTDI7KT6AWWHRVQG3CESRQD
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/KZMO6TARFLTDI7KT6AWWHRVQG3CESRQD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

While looking at the reference counting and annotation with __must_check,
some odd choices about the return types, missing const values and
int-as-bool problems were found.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- "mark read-only MAC address parameters as const" also keep it const after
  casts
- "mcast: document the value stored in is_routable" update kernel-doc to
  only mention what a function actually stores behind a "return val"
  pointer
- Link to v1: https://patch.msgid.link/20261013-simple-type-cleanup-v1-0-8a31d7e82eb4@narfation.org

---
Sven Eckelmann (4):
      batman-adv: use matching return types for bool and void functions
      batman-adv: mark read-only MAC address parameters as const
      batman-adv: use bool for boolean flags
      batman-adv: mcast: document the value stored in is_routable

 net/batman-adv/bat_iv_ogm.c            | 18 +++++++++---------
 net/batman-adv/bat_v_elp.c             |  2 +-
 net/batman-adv/bridge_loop_avoidance.c | 17 +++++++++--------
 net/batman-adv/bridge_loop_avoidance.h | 11 ++++++-----
 net/batman-adv/distributed-arp-table.c |  8 ++++----
 net/batman-adv/distributed-arp-table.h |  3 +--
 net/batman-adv/hard-interface.c        |  2 +-
 net/batman-adv/hard-interface.h        |  2 +-
 net/batman-adv/multicast.c             | 18 +++++++++++-------
 net/batman-adv/multicast.h             |  3 +--
 net/batman-adv/multicast_forw.c        | 27 +++++++++++++++------------
 net/batman-adv/originator.c            |  2 +-
 net/batman-adv/originator.h            |  2 +-
 net/batman-adv/routing.c               |  4 ++--
 net/batman-adv/translation-table.c     | 25 +++++++++++++------------
 net/batman-adv/translation-table.h     |  8 ++++----
 net/batman-adv/types.h                 |  2 +-
 17 files changed, 81 insertions(+), 73 deletions(-)
---
base-commit: 04071c46a5cb4fe3078ac44b48d11268ba275438
change-id: 20261013-simple-type-cleanup-67a175577804

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

