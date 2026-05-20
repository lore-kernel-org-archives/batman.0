Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCA39CD4F3C
	for <batman-adv@archiver.kernel.org>; Wed, 20 May 2026 11:59:14 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 68C3283F94
	for <batman-adv@archiver.kernel.org>; Wed, 20 May 2026 13:59:13 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779278353;
 b=bjvtNnCUYToSOuVl9mMQSvVjz0GV7OqGe9UMfb3msJoA5Cgwh9OhwsxD/lQugbfIvhQwh
 apd2kyYkWxOCv0nr6zXojACH0iEl36UAyGqdzU7Pa+UI8EW4tcF+HvEA8R5IwiI2UHrmxlP
 zNpJCkld26Nd/SdgiRGk/SBlx23rsdo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779278353; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VICMVO0Qn5I2jNrf8UyRCEpSmXvVIwvSF9ANzWZQvI0=;
 b=NmY/UQnyDXl11ecEEsThLGfSIJAvSxtIr5qUMb4x399IVR9wCiwz/NE6cxTNtdbQlesVa
 K8KgzWCLJnq6AZCJKYLM+3DU7WY5Twhv01p8rM6rPWvuX2/uZTOPNPuVDDtO68/ivWUpCtN
 hYSySeCpXJdlhmpUIWkw7HM1a31BYpE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F15C081B9D
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 May 2026 13:54:38 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779278084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VICMVO0Qn5I2jNrf8UyRCEpSmXvVIwvSF9ANzWZQvI0=;
	b=U3gMCZDmJdT0HCaCPYeTrdul2zBCVxHBaV+hIAsIGgTOErIy/4g8dFExqm0t6Ri72lf6y/
	0Alv0BS6e+jE21MYQYM3l7HIYf4U1kGhY0AYdr2qjf6k39LohIrsGXzjp1ooWcMaGOICfQ
	ZlBApKjLVhwaek6dqNC6P4SIVNb1e/U=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779278084;
	b=isX9RWO6fCCqC7/Uxjcejy3Ufrk1g1KTeEgM+XrGnJX+RzhVFhP8cF3fzTogZovsMfWMJ7
	GifJ3MO1QKO5wKJkbOAa3P9y1K3MN96olNeGcK+N0W2NkpZo/pvVUbpIbyoTvliG+H6FA2
	HUG+3xw24BWxEsmboyu7nR8+fc4eYeU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=doep+AuU;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779278077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VICMVO0Qn5I2jNrf8UyRCEpSmXvVIwvSF9ANzWZQvI0=;
	b=doep+AuUZfWjiLEffB/51cKZFYGfBJUj812Ae1XG42+7eY13BZwQo7aqZvWJOeJ4DLRmcm
	SIPNnm7Lv5Av71GXY2NT5bpVY0dPnD0e97qgDVDw166OwcE6y8+zGHabfTndc69chH99By
	qCRQ5+tGf27Pl+e0b6BIzUdJIZaW9CVCWL67GMfj/kjrEiPGn25DHpCq2ly5FXPGoqHy3u
	yWetZNZwv2ZjguL+1fh/0oleh6y7Ie4NeNuz2b3b4Ax0xU+oJZjb6diZjioqvphnEYG43/
	kYohpse/lK0FwvelxKuyESL30FVNBDgs8Z7WBDQ6vDLzgnBUl/hTlZvAHZ7egw==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 01/11] batman-adv: fix batadv_skb_is_frag() kernel-doc
Date: Wed, 20 May 2026 13:54:12 +0200
Message-ID: <20260520115422.53552-2-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260520115422.53552-1-sw@simonwunderlich.de>
References: <20260520115422.53552-1-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: S6DMYCMZ7FMX2VXMA36VLIQNFN3LVQ3O
X-Message-ID-Hash: S6DMYCMZ7FMX2VXMA36VLIQNFN3LVQ3O
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/S6DMYCMZ7FMX2VXMA36VLIQNFN3LVQ3O/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Sven Eckelmann <sven@narfation.org>

The kernel-doc comment for batadv_skb_is_frag() contained two errors:

* the function description referred to "gain a unicast packet" instead
  of "contains unicast fragment".
* the Return section omitted "merged" from "newly skb", leaving the
  description grammatically incorrect and inconsistent with the
  function description.

Fixes: bc62216dc8e2 ("batman-adv: frag: disallow unicast fragment in fragment")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 4a594aa2ebf66..e9553db423491 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -305,10 +305,10 @@ batadv_frag_merge_packets(struct hlist_head *chain)
 }
 
 /**
- * batadv_skb_is_frag() - check if newly merged skb is gain a unicast packet
+ * batadv_skb_is_frag() - check if newly merged skb contains unicast fragment
  * @skb: newly merged skb
  *
- * Return: if newly skb is of type BATADV_UNICAST_FRAG
+ * Return: if newly merged skb is of type BATADV_UNICAST_FRAG
  */
 static bool batadv_skb_is_frag(struct sk_buff *skb)
 {
-- 
2.47.3

