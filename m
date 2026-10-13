Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA126CC6B0E
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 17:31:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id F28EA8426F
	for <batman@archiver.kernel.org>; Tue, 13 Oct 2026 19:31:28 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791912688;
 b=VvRd4dofasvazobrEoA3UiLxCvH4FkOlgkckmDyTIgev/OrUulmfJC8FZIpSWE5OhfpGM
 Ayp/XEbBuoPoKrReUO5loDqg4z43uVoDAR4oY622mgJd5c/3ElJ2MNkOPTYqUOsSYbfWgKY
 iIxzbQ18gsoVi8CqsiXp/ISDafA8MBI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791912688; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=zRL2aYhthBAuVorO9KweRTgvvzEQ7xUodRBcxG4W3jI=;
 b=Xcbuz9JBCvw4wCfZEosKvyUS7el4nVR4Jb08aIcEEnO4kmWXiW+gGxiLFeXxfW75iYrWj
 lDRAXT93EWvre+GrqZI7DMDznhODi2UMHI1WEqQoq000cDHPcnIv5YaXTFtpsIhgJatXxiH
 E9Xo6tPPah5A1ckjLysH+X0pG5tdAaE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 7F24C80723
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 13 Oct 2026 19:31:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791912680;
	b=DNgXw99yGju+u02ZqE+YlxgAOYC91hLBI1uircfXCU+43R1EXskd0clzTl8x8O+D4Fvt8X
	x2FKndOS1mi305elG74XGvHKlNNI8wbIf9Tfev2+dWjhpK/jjJVd/ZI42V+j6HYm2aAcXT
	b3r/DwujR9gDgbT7sK12yDL09r594xg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791912680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=zRL2aYhthBAuVorO9KweRTgvvzEQ7xUodRBcxG4W3jI=;
	b=krjWkqCm8E/60myyLM7DJRrmnaIRK9qgXYMB9XzBHV9ggsVGYlG64WClKtGYCSiPql3Ieh
	wJ1ge2tW+KsD3S70SxdHZBMQQm/O7IyaRWxT7kpYbRzTJe6CITisKXnTfgnEuKYsgUdsOJ
	PORUUo+1TekLwLPdW8BOTOBDMLVWIsc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=AmsYObop;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 2C6511FEC5;
	Tue, 13 Oct 2026 17:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791912669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zRL2aYhthBAuVorO9KweRTgvvzEQ7xUodRBcxG4W3jI=;
	b=AmsYOboptj+m6ZjxepygJKvntX0kdNLD1SumjKnWW1dh5oD+X1VI4am+8F3C1Dg3ZbSpqw
	2tDwZK/iUXC2/kfr0SojoPyo+Fad78vVpEG6e7jth4PZfkqlfTrXm/fTBkD2wTMPznA6vY
	lN+EcucwLAFbi8UC+LMqoQ+D1kkYgrw=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/2] batman-adv: ensure well documented refcnt
 increase of returned objects
Date: Tue, 13 Oct 2026 19:30:37 +0200
Message-Id: <20261013-refcnt-explici-v1-0-05441b45da99@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL1qzmoC/yWMQQqDMBREryKzbsColLZXKV3EZKK/lFSSKIJ4d
 1O7fDO8tyExChMe1YbIRZJ8QwF9qWBHEwYqcYXR1M1V17pVkd6GrLhOH7GiPJ12944337Uo0lR
 +Wc/gE73Jxi14/fc092/a/Kth3w9pOC71egAAAA==
X-Change-ID: 20261013-refcnt-explici-fed1d94e8f43
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2271; i=sven@narfation.org;
 h=from:subject:message-id; bh=26xkCQke5FP3mZAjX0X8meODAcpe1O8vd2t8bFgVTRY=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnsq4efeFWdbR3YXl0Hfsq7U71dYz2/87ekMldE7cp1
 P7xuRl5HaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJuJQzMjxg6yrPerPP4cip
 OwEmxx4velR15b/e1qfqITnbHVcy5k5iZLi1YKvKxcgFFQ13OYzu2R6MzQz7sfnp1WDXxlp1vRq
 2ZVwA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NL53TTKGFTPGDTNTQFIK6YH6PVMLM3KZ
X-Message-ID-Hash: NL53TTKGFTPGDTNTQFIK6YH6PVMLM3KZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NL53TTKGFTPGDTNTQFIK6YH6PVMLM3KZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

While checking through the potential use of __guarded_by, I noticed that we
can/should mark some return of functions as required. To be more specific:
functions which return an object with increased reference counter.

If I remember correctly, this was also something about which Sashiko
complained at some point. But it was at that point about the kernel-doc and
not the __must_check attribute. All these functions have therefore now also
the (same) sentence "The returned object has an increased refcounter".

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (2):
      batman-adv: annotate functions returning objects with __must_check
      batman-adv: document refcount of returned objects

 net/batman-adv/bat_iv_ogm.c            | 14 ++++++++-----
 net/batman-adv/bat_v.c                 |  5 +++--
 net/batman-adv/bat_v_ogm.c             |  1 +
 net/batman-adv/bat_v_ogm.h             |  4 ++--
 net/batman-adv/bridge_loop_avoidance.c | 15 ++++++++------
 net/batman-adv/distributed-arp-table.c |  3 ++-
 net/batman-adv/gateway_client.c        |  7 +++++--
 net/batman-adv/gateway_client.h        |  9 ++++----
 net/batman-adv/hard-interface.c        |  8 +++++--
 net/batman-adv/hard-interface.h        | 13 +++++++-----
 net/batman-adv/mesh-interface.h        |  4 ++--
 net/batman-adv/multicast.c             |  4 +++-
 net/batman-adv/multicast_forw.c        |  2 ++
 net/batman-adv/netlink.c               | 38 +++++++++++++++++-----------------
 net/batman-adv/netlink.h               |  5 +++--
 net/batman-adv/originator.c            | 26 ++++++++++++++++-------
 net/batman-adv/originator.h            | 26 +++++++++++------------
 net/batman-adv/routing.c               |  3 ++-
 net/batman-adv/routing.h               |  2 +-
 net/batman-adv/tp_meter.c              | 20 +++++++++++-------
 net/batman-adv/translation-table.c     | 31 +++++++++++++++++----------
 net/batman-adv/translation-table.h     |  9 ++++----
 net/batman-adv/tvlv.c                  |  6 ++++--
 23 files changed, 154 insertions(+), 101 deletions(-)
---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261013-refcnt-explici-fed1d94e8f43

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

