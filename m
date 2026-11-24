Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FE3606A31E
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 21:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=AuPQHv1X
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A241183183
	for <batman@archiver.kernel.org>; Tue, 24 Nov 2026 22:12:16 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795554736;
 b=M0bvZixoQcIBACnB9kXlCmClh5g1Iiz3CoM5ZQG73+Cu71gh3/z1GbXLv4J5ouAzaB2d/
 5CFPF68Z1YAYPbc+qCVfd1VPZ4NIxE+sYfIgPzyEizDbl8mtOHxxBrzxGv+VA0MnvfXYcy8
 igLb+JFAenBQM+muyOiUQfGGf0KVB6I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795554736; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=x/UOd6CpOD85vI7gaZrqQ7oeEgwk5sw+S1QYH2qodYM=;
 b=tAaDYL5DvItzhxjOIgaEnXFqrkGkiZbtlJ8Dh0Wx3EhlEraCr8VzFmlfvhPM1BMTkzrSi
 ofMY0Dxf000JYPkYt8As+0d0dQHV5I8GXp8nPXapkwklLgZgUnEdo3CKTMTZsEc3O50BH/z
 bBfkpSU/cGzUrnEsIP8d1C4Xpjk9XqU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B783580F6A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 24 Nov 2026 22:12:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795554729;
	b=Dm2wpIAz4o0MisDrZtpr2mPhq6kcN5aBG9v9OVZ5uacAoMTgZ/Ljm9vFpLSFu5YsERCRPP
	sTr41QhweOjKLEhvn5ndjE/yqG2aub9LnQtCUcubSPaJv7Scvpm7udqfBGHrsigRnotcLB
	VVrBQGf9fnwk+kFOzAXFksetAS9jsWw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795554729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=x/UOd6CpOD85vI7gaZrqQ7oeEgwk5sw+S1QYH2qodYM=;
	b=K5vMbf36lN6E3FHWuGhX1OIG1HMO0pETNIZjNfqnHJzLSFHYfyKj0c4zL9hJH/CG3DrDX3
	dGRlqIzCsHZf7yi412XWnwP+FqXwavvl//PsMYtMLkHEC4rwcpl6JLiREyfOd+rlOnUlS7
	mVSFPVzF6hdYZY4qmrtzWFZ4GOHU9WE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=AuPQHv1X;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 12D8D2014F;
	Tue, 24 Nov 2026 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795554729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=x/UOd6CpOD85vI7gaZrqQ7oeEgwk5sw+S1QYH2qodYM=;
	b=AuPQHv1XfQCwZs5auiuLibj2Vdy0JifpKVYUtdp1WZHkCCIrqtcxvBFirCjagHqKWUmXTF
	1bJZaVp6N6Gm+tOWvhtXc6PXEiCNf7HfXee5tuBoY97pOUrceOCKpb26lTyXEsWt8DRy3P
	QUbCLlSdJFQfujSUE2r+afz3MC6NCG0=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/5] batman-adv: sashiko kernel-doc fixes
Date: Tue, 24 Nov 2026 22:12:04 +0100
Message-Id: <20261124-sashiko-kdoc-2026-11-24-v1-0-27282884274f@narfation.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKT9BWsC/yWM3QqCQBBGX0W+6waaRVR6lehif6acBDd2TALx3
 Vvr8hw4Z4NJUTFcmg1FVjXNcwU+NYijnx9CmirDnV3H7Foyb6NOmaaUIx2WmKl6N7TcDYGl7yN
 q/Spy18/vfEXwi08rbn9v7/CUuBxb7PsX6tQw2oMAAAA=
X-Change-ID: 20261124-sashiko-kdoc-2026-11-24-284168b1e77c
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=sven@narfation.org;
 h=from:subject:message-id; bh=AaUKoZQj6YPxDUnXY5KTpKTn+gW0L+ctUq5HCKhWsB8=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDNmsf5f+ZeHvM1JfUx6tP1t95+HIgJpzOn3bNqmFZnb3z
 a2xWqLYUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZhIvjEjw0dDURYmg+2Mjaek
 LyyO435nvuTBNdmX4my1Ume8AkQfRzP8U5ItDHK/XL5aUmpNVJrgrI1Jt5ZIh4V5N79t0L7xIXM
 3OwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: IOWQBZKVLGUSXLN6YF3B3OYIEQBGRBDS
X-Message-ID-Hash: IOWQBZKVLGUSXLN6YF3B3OYIEQBGRBDS
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IOWQBZKVLGUSXLN6YF3B3OYIEQBGRBDS/>
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

The Sashiko report for
https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261123171827.3294525-2-sw%40simonwunderlich.de
contained a couple of complains about the kernel-doc. Let us just fix it
directly.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (5):
      batman-adv: tt: sync requirements of unhash helpers for local entries
      batman-adv: tt: clarify uncounted state of new local entries
      batman-adv: tt: mention purge of pending clients as concurrent removal
      batman-adv: tt: document immediate removal of unannounced local entries
      batman-adv: unify kernel-doc about refcount of returned objects

 net/batman-adv/originator.c        | 20 +++++++-------------
 net/batman-adv/routing.c           |  5 ++---
 net/batman-adv/translation-table.c | 27 ++++++++++++++++++---------
 3 files changed, 27 insertions(+), 25 deletions(-)
---
base-commit: b76921870912bf2543c1f4c7310fbf18da610acf
change-id: 20261124-sashiko-kdoc-2026-11-24-284168b1e77c

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

