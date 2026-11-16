Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28A606A322
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=OCUVT2SY
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A0D5E8418A
	for <batman@archiver.kernel.org>; Mon, 16 Nov 2026 21:03:39 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794859419;
 b=UKgeFw+ft/e7BlCnK3Ej2PfpOOlXlq6MGE/3TSGgOdA5NbEpmHMispkDt2AIDxbLkrMjD
 BSRLuaNIzyN68mfSw9oBnHEqCBnPHDtI7en/e8V7fjg81pRkuDn+rr9KfnZ68UcksQzoJjV
 5qSWsjM/a2ZQcU62eJdpNfm68Vcnq58=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794859419; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=5U/ndscgks+okI0spMGQzx0ybk8eT3QuFRvX/yUk+8Y=;
 b=Gt94BprgB7DqFJtoBGDKXyDker3Rf4UBnWstDem0RiVEXwItD0rCv7LP279D9hCJ6CFO+
 CVwhCtUSt74mTovmd7tTcGJ/M2tfq07oW5f+bK9ReT5eN+gHkDT24BB1C1dcNug8AJTlfcV
 mij513Y8hqoOXz5GStLnUCmeK5QhqjQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 474E88040B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 16 Nov 2026 21:03:20 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794859410;
	b=YJ8Xvq4ZLUBVyVO0EyLCEYkwupv9n876Kb4+MdBwDd4Om05DgoR1I8/cOxVpBw0TWlYjN8
	kY1axCiIrVM9JiF0hoeSD5rRuTAD345bqQnzeCv+3Shsa8YmI0d4dANwQ4a98ZqDmXvAWa
	Lh3ZnNIV6BBfJckPg5I9hCEm0njDaIA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794859410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=5U/ndscgks+okI0spMGQzx0ybk8eT3QuFRvX/yUk+8Y=;
	b=JWAGdXg7mW/BD03R16+8Mpu5UnAWW9pYaCVr7HEt3LkP+9wJYZJXg10IQ2OhSIVryXIgiQ
	ihw98mKSQSFBsj7bhJbl/8j/LVywf5gd5SM+EGhOPSxZsLX7h8Y76uKiZRPFibmpJ6Uets
	q64IUhnwGUQ8E3MNDq/9ovOywOGU0Yg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OCUVT2SY;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id A6640204B5;
	Mon, 16 Nov 2026 20:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794859398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5U/ndscgks+okI0spMGQzx0ybk8eT3QuFRvX/yUk+8Y=;
	b=OCUVT2SY8uGX9DyACIyGnyixqP5Fl3dIDNLCtYl0lVcQKmyjKo1lEjhW5TLct9fuu6eujw
	+qyhzkQ5fF4k0DGAeUwZe+xADaFfzZh+Oab4x2gNQX7/kEo3xm2+dL70kKAkOlg0vtyFic
	OTq26o/ok5G7u/5Mo/Z8E2Ovts40zek=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v4 00/11] batman-adv: tt: shashiko 20260930 follow
 ups
Date: Mon, 16 Nov 2026 21:03:01 +0100
Message-Id: <20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHVh+2oC/3XOz07DMAwG8FeZcibITlen48R7IA7546zhkE5JF
 oGmvjtZQQIJevws+/f5JgrnyEU8HW4ic4slLqmH48NBuNmkM8voexYKFCEAyVqlaUv08ppmU2b
 2khunKjVZOwYijziKfn3JHOL7Jr8Ia6rxTbx+zcvVvrGrd/a+OcdSl/yxvdBw2/9u07ttDSVIQ
 KdpoFGfkJ6TycHU/v3jks9bU1O/rWnfUt3S7sjsJyQg/581/FgIat8auhUGHcaTm8DCH2td108
 u5xdidAEAAA==
X-Change-ID: 20261006-tt-avoid-unhashed-event-76bb5f66d115
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=sven@narfation.org;
 h=from:subject:message-id; bh=5CXZH5N3EIJiSBC/+DXHYv4dwX13QR3XDzxpDcKwzkw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFm/Eyv+qiT+22P2Z0HCgmvxLOU7ajKP85SKeV1aty2k4
 wmH4dnDHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJXLrA8Fd89StnzqRPZzYe
 kIi3lDy56rT3F0GJ8Jkzr9/kn/XzhJ4/w3+n84lG7T090yVEdihFWq/z/sBRZ2GxNt9t/mROpes
 TPzMDAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: K2ARJ52S5TBYIIJO2MLU3MBZX3OSTTLT
X-Message-ID-Hash: K2ARJ52S5TBYIIJO2MLU3MBZX3OSTTLT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/K2ARJ52S5TBYIIJO2MLU3MBZX3OSTTLT/>
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

There were various reports in the Sashiko report from

* https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%2540simonwunderlich.de
* https://sashiko.dev/#/patchset/20260930094558.3723766-1-sw@simonwunderlich.de

Some of them are about the rather bad locking behavior in TT and addressed
here. While looking at this, it was also noticed that the TT event handling
seems to be broken since the introduction of dynamic flag changes.

As Sashiko now already complained about the ROAM flags, i have added the
ROAM flags handling patches in front of the original patchset.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v4:
- only permanently modify the local TT table based on the "changeset" for
  the TTN
- Link to v3: https://patch.msgid.link/20261102-tt-avoid-unhashed-event-v3-0-f37f59c80b0d@narfation.org

Changes in v3:
- rebase on post-2026.4 patches
- disallow a removal of an ADD from the TT changes whenever this change
  entry was at any point a DEL
- Link to v2: https://patch.msgid.link/20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org

Changes in v2:
- add patches to handle ROAM flags differently
- Link to v1: https://patch.msgid.link/20261007-tt-avoid-unhashed-event-v1-0-01c763657916@narfation.org

To: b.a.t.m.a.n@lists.open-mesh.org

---
Sven Eckelmann (11):
      batman-adv: tt: unhash local entries with hlist_del_init_rcu()
      batman-adv: tt: refresh local entry in single flags_lock section
      batman-adv: tt: don't remove unhashed local entries
      batman-adv: tt: don't queue local events for unhashed entries
      batman-adv: tt: remove unannounced local entries via pending state
      batman-adv: tt: keep local entry unchanged when ADD can't be queued
      batman-adv: tt: requeue DEL of pending local entry after failed allocation
      batman-adv: tt: extract removal of pending local entry
      batman-adv: tt: commit only the announced local changes
      batman-adv: tt: avoid list_lock for unchanged local clients
      batman-adv: tt: drop ADD+DEL events of never announced clients

 net/batman-adv/translation-table.c | 867 ++++++++++++++++++++++++++-----------
 net/batman-adv/types.h             |  14 +
 2 files changed, 624 insertions(+), 257 deletions(-)
---
base-commit: a793cf82308e57a0e21c97e889c143cdbba67e5f
change-id: 20261006-tt-avoid-unhashed-event-76bb5f66d115

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

