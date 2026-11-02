Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A895606A327
	for <batman@archiver.kernel.org>; Mon,  2 Nov 2026 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=XsskYxvg
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CECF6844E8
	for <batman@archiver.kernel.org>; Mon, 02 Nov 2026 22:15:49 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793654149;
 b=AEcQlqwdn51rsK/1T9AHySfKBfOeF6ZM6QmA0v9CdDTtkMbIEPTVbptUWohc6mViONqUC
 vq5hL3/lnKT125GwC9UgVT5Zrsmr8ao5rJlym/vg7au5NeZaXdaDFhmSs2IuA7KKLsn+MUv
 if+ZbdYRjTeYdr0bchh6auJlV8o29Ds=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793654149; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=fgeKZXtA5yVvVujtoapiMyN0Uhj5JVtBvT0lPhp8Ug8=;
 b=MMpyBwpUlk9eFKEfxDhNqxeq0kNA5AEYcaI5C801vaHsO6WbyzvECQno7I0piOTxhpxaS
 ocnJNiALv8VK2b3NTb/MXSc3HuFtzCCXZKnNzTJtUl7dRFEKg3m6pg5BHPpFQVd5iXTSvOU
 cxu7kC2wF1YljqOuHEhIZZe40mmlbWQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 6058781677
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 02 Nov 2026 22:15:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793654134;
	b=imvQWiBYEW3kXyRjdWrkUVEraGNa4WdgC3vinfj0C4+Cmj1JwgoJ27/0Msthbh5+Vax07N
	sibmc9JXUXjGyDXyPQl4sVr8nxwtoR3uhP3jW2QApxe3jsk67keXT7QhBSq18V2UwiXrGS
	4ERImPCsaWHO+xWz8hmMPVePtNPPQ1Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793654134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=fgeKZXtA5yVvVujtoapiMyN0Uhj5JVtBvT0lPhp8Ug8=;
	b=Tn0Wlbm6uEQtJCE0rvg8kNwrM5LCJbmSYFJiocfMLlbbP3nDSaOGaKYvXuyqvsq4mwTQj1
	ehGij1HwH7Tk8Zg10H0Mv1e9j6QJiomVN9EIvHIoDFtTDgN71xy5IuvehZ0Iffm5cPawJe
	tJuF5rtggkeeBczMO1XSARMXdiXNNIE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=XsskYxvg;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D882D21E3E;
	Mon, 02 Nov 2026 21:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793654123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fgeKZXtA5yVvVujtoapiMyN0Uhj5JVtBvT0lPhp8Ug8=;
	b=XsskYxvg1+KmaTwJBfcrgO7fwf/9EO6EPeAUkHBLhHd6WNClE0DFqWUICV2qRq/+L+wcyc
	+Ryyi8XVlMIoaiVr28yrVkozCSqL2Ex5gShapQqYuODZgwlfXcFbW+DGcUXi6abxfd0g4i
	XPPbbp/ERdOJwp2dmHwvDa4+MxEe1v4=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v3 0/3] batman-adv: tt: shashiko 20260930 follow ups
Date: Mon, 02 Nov 2026 22:15:15 +0100
Message-Id: <20261102-tt-avoid-unhashed-event-v3-0-f37f59c80b0d@narfation.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGP96GoC/3WOyw7CIBBFf8WwFgOtHaor/8O44DEtuKAGKNE0/
 XdpdWFMuryTO+fciUQMDiM57yYSMLvoBl9Cvd8RbaXvkTpTMqlYBZwxoClRmQdn6OitjBYNxYw
 +UQFKNR2A4bwh5fsRsHPPlXwlSiZpMrl97nFUd9RpwS5N62IawmudkPna/9rEpi1zyijjWkANj
 ThxuHgZOpnK+sMQ+tWUq19Wu82qCkvoI6JpOTAw/6x5nt+qVFOQKAEAAA==
X-Change-ID: 20261006-tt-avoid-unhashed-event-76bb5f66d115
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1730; i=sven@narfation.org;
 h=from:subject:message-id; bh=6RCvw1CVA5FPF/nv4f8PDI+8YT+pCGcIW27q+uPRZng=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkv/qY3q5fvWFvjlm/pntAS9FzGz6by5TXnr59+8JoIr
 Jn31aqno5SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjAR3XKGf0anLrssvnGX81ro
 SzEmy0cvlL9of15svGfmjObkg/LLU4wZ/hl6LUxqCEhOkVkluv4N689qhZDmlHmSf2P+ckQEGd+
 v5AMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: QXEJISYTUWG6ZWC2AFW7LP7I5IFJTMJT
X-Message-ID-Hash: QXEJISYTUWG6ZWC2AFW7LP7I5IFJTMJT
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QXEJISYTUWG6ZWC2AFW7LP7I5IFJTMJT/>
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
Sven Eckelmann (3):
      batman-adv: tt: don't queue local events for unhashed entries
      batman-adv: tt: avoid list_lock for unchanged local clients
      batman-adv: tt: drop ADD+DEL events of never announced clients

 net/batman-adv/translation-table.c | 385 +++++++++++++++++++++++--------------
 net/batman-adv/types.h             |   8 +
 2 files changed, 252 insertions(+), 141 deletions(-)
---
base-commit: f28aa9098da379a65d6a014fb081a4ac6dc4e36a
change-id: 20261006-tt-avoid-unhashed-event-76bb5f66d115

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

