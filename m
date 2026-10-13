Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5DDCC6B12
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 18:08:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F032B83176
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 20:08:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791914892;
 b=WldVFWLL4UxoS6zTLcH9OQqMQy1qB9Nk9XTBYIka5E/EfiCXE9eKY7wMqlJiudMA39rMg
 QDwfdwLU41Yadq7tV0pqkffRh7Fr0PF1CtJI/nZGFhDebDFKpE8mprErCJAvJSjsWslWcIV
 aMZIkZJQVQR+bXvy1p2ArGXlnyS6c+I=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791914892; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=TDLxJbl4ybQgUUVh8ulxtgcBk9csSZwLWI4tleNEjBo=;
 b=Q/PyH5MZ792cCR+ATU7tlBldKpLG24Mjz1ZXQHhPFSIZaqK+rnwN/rKRZHPBBbEuKwB7f
 bRAeC1Sg9hERFAnbo8lqJ/skRRRqvo4qKM9SMQj3/S7mCRCx06hK/BWgoIw0BG67eC1KCEo
 7UOgz9Sfzp8U+IIoW06+jKKHcXBuQPk=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 65BB980FDE
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 20:07:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791914881;
	b=mu/g7gk2cLpXk4AVTw8u9wsiJJgPu9ceuJ3MfEV3GwnG71XvIUVNutzZRoXEAF7GhiFfnp
	1ve9vnvnG8lXt0CyzzSz7VwJzWzXBRBtG7Br6TKvluRhJJeDisH0h+G6E8+0b6zRKGuUHV
	s8YJaHEoDVkut2a/7YjodWqBPMSMNEQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791914881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=TDLxJbl4ybQgUUVh8ulxtgcBk9csSZwLWI4tleNEjBo=;
	b=wZ1atph8Jn+piAzuQht+C9sNmHrMnDD7GYRcCnDDwj6L3U7FhOwO+E5Mynh9PcSSOXGgqz
	SDIrQ4Y45C6pRtD93+1gaGjZaW3vUn81Yu9MQ3k0BEV5T4UT0vC/taJG4m57MXAxbTH/af
	816zYSl03E7se6b9jAUMWkai0fC+wFI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=muks1ihR;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 55DEB1FEC5;
	Tue, 13 Oct 2026 18:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791914870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TDLxJbl4ybQgUUVh8ulxtgcBk9csSZwLWI4tleNEjBo=;
	b=muks1ihRsMF5SJxPSdKyGGtWx69gcME5UbiturjOqyL1GIJfjqOU6yD1C4zfvC5I3E3Agj
	yrSQloC2NRb7wF7pqfd+hT0lIk6uptUu6Y7GUppAf/Z0AN9dZ/EaYiznACDCRwamqS6zsF
	/w9iV58Ua61EUGicgdZ2OFF2xnkhe14=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/4] batman-adv: minor scalar types cleanup
Date: Tue, 13 Oct 2026 20:07:46 +0200
Message-Id: <20261013-simple-type-cleanup-v1-0-8a31d7e82eb4@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHJzzmoC/yWMQQ6CMBAAv0L27CYtAjV+xXBYyqprsDbdQiSEv
 1v1OJPMbKCchBXO1QaJF1F5hQL2UIG/U7gxylgYalN31tgjqjzjxJjXyOgnpjBH7BxZ17bOnUw
 DpYyJr/L+XS8wUKZxgf7vdR4e7PN3Cfv+AX/Bd0t/AAAA
X-Change-ID: 20261013-simple-type-cleanup-67a175577804
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=sven@narfation.org;
 h=from:subject:message-id; bh=JgXMbgo1dL9vbnkU12F4ANl2a5yhPsImzpIqUrks0+Q=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnniotVmII0E510lx0Rdl9xqHLdlpSz/nI6WX+V3nD9+
 tZvXu7YUcrCIMbFICumyLLnSv75zexv5T9P+3gUZg4rE8gQBi5OAZjIVS6G/6kuBgf3K0lIvonu
 m+n82tiuRPRF8L6VF+/fL2VJTlm8/AzDP4X2P7pSrQLrnlbwK55x4q04vlTsZ8aLlYz3NUJ5Jsk
 3swMA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NM334UYMZBLXLSCRLL262EOM6YY2IQWU
X-Message-ID-Hash: NM334UYMZBLXLSCRLL262EOM6YY2IQWU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NM334UYMZBLXLSCRLL262EOM6YY2IQWU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

While looking at the reference counting and annotation with __must_check,
some odd choices about the return types, missing const values and
int-as-bool problems were found.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (4):
      batman-adv: use matching return types for bool and void functions
      batman-adv: mark read-only MAC address parameters as const
      batman-adv: use bool for boolean flags
      batman-adv: mcast: document the value stored in is_routable

 net/batman-adv/bat_iv_ogm.c            | 14 +++++++-------
 net/batman-adv/bat_v_elp.c             |  2 +-
 net/batman-adv/bridge_loop_avoidance.c | 15 ++++++++-------
 net/batman-adv/bridge_loop_avoidance.h | 11 ++++++-----
 net/batman-adv/distributed-arp-table.c |  8 ++++----
 net/batman-adv/distributed-arp-table.h |  3 +--
 net/batman-adv/hard-interface.c        |  2 +-
 net/batman-adv/hard-interface.h        |  2 +-
 net/batman-adv/multicast.c             | 20 +++++++++++++-------
 net/batman-adv/multicast.h             |  3 +--
 net/batman-adv/multicast_forw.c        | 27 +++++++++++++++------------
 net/batman-adv/originator.c            |  2 +-
 net/batman-adv/originator.h            |  2 +-
 net/batman-adv/routing.c               |  4 ++--
 net/batman-adv/translation-table.c     | 25 +++++++++++++------------
 net/batman-adv/translation-table.h     |  8 ++++----
 net/batman-adv/types.h                 |  2 +-
 17 files changed, 80 insertions(+), 70 deletions(-)
---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261013-simple-type-cleanup-67a175577804

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

