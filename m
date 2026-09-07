Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE4EC79F9E
	for <batman-adv@archiver.kernel.org>; Mon,  7 Sep 2026 08:25:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7128D85900
	for <batman-adv@archiver.kernel.org>; Mon, 07 Sep 2026 10:25:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788769548;
 b=mQQJB5CRpa83/gp0ujv2CRo1ALG2AZdOwXkNFGIhESJMw6770DtDpUj1TuRBTgx4L8gWI
 PV60q0GSLrlDAw2o0ordHgx3+7LEGKDMXEumnQLFKIlTya2+SyfyU6Rv3kiGdZrpNUxQigV
 ICehRGrvdn60YT+Jk8kp3HTbblsmayc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788769548; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tGLTaECVpqUfSVRQGkJFUTj3HfISWwCWpMLjQze0xA4=;
 b=lesbZgpOIe3Bm7Ujph4tyh0VjiT4gj0WSinZFXnUIMYxZYpXjLwYEAidjWywwOR4H5JiL
 b1Qld0HE3o26N00OevYl++iQaJR5SzTsoqfRf79790tWnANg4DDabulvjlhxq69Mua2LjMB
 QMOR4htaVopOLhidcjx4Zxd9C0oPO9E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2A07A841D5
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 07 Sep 2026 10:18:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788769120;
	b=FEqYOAQWDjTJL/30RM9pAt2+WKqWj7fGl8bLvy4sHWOqZY2lnDeAHGNq4uvuD05tDHXNqC
	0MBN3lpa+OsSSR5IYPKhmlkwB5JWpCbjnoOlm+8vmzM+gxY1zlcr2mbQq4QQ0mu5cBLo3B
	EEoNJ7gSNi9YIHCi0ocKczFPC/bcXKw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788769120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tGLTaECVpqUfSVRQGkJFUTj3HfISWwCWpMLjQze0xA4=;
	b=GH8Q6fuU2/rzj8Y1OYP6BLK/uzle0H2FlqCyv8qkoQb+YWectA2xyfrCSgYUHNaUMQZVtf
	DlJa0C+PPKLPJMcKuG8peF4LFD8O/ELUr8BdhBh4aZZc4Chv7rZhTe1WZPVxcOZ8y8Fj5x
	v511ie+GkDRJTV1xyRQFB4hh0ihftXs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=XjsWQZZg;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 23.88.38.48 as permitted sender) smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
Received: from kero.packetmixer.de
 (p200300C59748d0d8C3747188E6Dfe6C0.dip0.t-ipconnect.de
 [IPv6:2003:c5:9748:d0d8:c374:7188:e6df:e6c0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 359C9FA2C2;
	Mon, 07 Sep 2026 10:18:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1788769115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGLTaECVpqUfSVRQGkJFUTj3HfISWwCWpMLjQze0xA4=;
	b=XjsWQZZgn0oicjBABbWO5CY0KavJAYkuV8xZ2Xs3jmRWQQuMuzxMx/2k7JqGRHUL+Lh3+S
	S3NN6sPzewShRPggRcfdrftmLT1fWOym4LFdb8oIFmee/v8Iup1mDxSCA3B3m7HpN/XCPe
	SXTcBQBZ2R3PFcgC3uqipMTzjKcrIwGzENzXDGFYo1wAeXvpp3nMSvXVLZS8Ri+XtNVUh/
	nOM3YonCWtxK3NvA739xQdSe1vB7YGy5lr3Auy+NvI8e10I8VVlZeAqKij3JqfJNy78NqE
	hIaVtAepT9IWMA9pzW1Dfsuqmjv9e9ZzS+HGvHzaQuIPNDJ10ksYxQ6Ux6tiDw==
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
Subject: [PATCH net-next 13/15] batman-adv: tt: clarify kernel doc for
 batadv_tt_local_set_pending_event()
Date: Mon,  7 Sep 2026 10:18:22 +0200
Message-ID: <20260907081824.2474040-14-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907081824.2474040-1-sw@simonwunderlich.de>
References: <20260907081824.2474040-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: UIJPD5YZDQ6E2ZIPR72Z7PHGSJ2MWQYZ
X-Message-ID-Hash: UIJPD5YZDQ6E2ZIPR72Z7PHGSJ2MWQYZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UIJPD5YZDQ6E2ZIPR72Z7PHGSJ2MWQYZ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The function batadv_tt_local_set_pending_event() is no longer setting the
BATADV_TT_CLIENT_PENDING because it must be done with the flags_lock held.
The kernel-doc must therefore correctly state that the flag must already be
set.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831135117.574836-1-sw%40simonwunderlich.de?part=12
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/translation-table.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translation-table.c
index 6c65d195f3756..12ea557cb8033 100644
--- a/net/batman-adv/translation-table.c
+++ b/net/batman-adv/translation-table.c
@@ -1422,13 +1422,12 @@ int batadv_tt_local_dump(struct sk_buff *msg, struct netlink_callback *cb)
 /**
  * batadv_tt_local_set_pending_event() - trigger events for TT pending removal
  * @bat_priv: the bat priv with all the mesh interface information
- * @tt_local_entry: local TT entry to mark
+ * @tt_local_entry: local TT entry which was marked as BATADV_TT_CLIENT_PENDING
  * @flags: TT change flags to announce together with the pending removal
  * @message: debug message describing the reason for the change
  *
- * Schedule the TT change announcement for the entry. The entry is kept in the
- * local table until the next TTVN increment so that a consistency-check
- * response can still be answered.
+ * Schedule the TT change announcement for the entry. The caller must already
+ * have added BATADV_TT_CLIENT_PENDING to the @tt_local_entry
  */
 static void
 batadv_tt_local_set_pending_event(struct batadv_priv *bat_priv,
-- 
2.47.3

