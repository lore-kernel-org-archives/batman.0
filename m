Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E4BCD4F3C
	for <batman-adv@archiver.kernel.org>; Wed, 20 May 2026 12:00:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D89D683D8A
	for <batman-adv@archiver.kernel.org>; Wed, 20 May 2026 14:00:00 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779278400;
 b=bJ5ymovogS6ebyoJ2T/XL2ObEbR4lNHJtdaP06KY73lN6Y+M5q/WZY4DnE8RniB/8GxKD
 THJuIn1psS0Xo1kQcKtwgYANCjoWo7ApTA/oVUuGBUPxUYoMPxTBa/wPrm5cvZv+eqcAbgu
 HsZjO3AfMMG1lxLiaC6oEutheJQpNYc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779278400; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8BixBb1DIhQ8qq6hCCdb7nigjWog786sWdT3/VpFGno=;
 b=c+b75rwWD03wJYWPo6dPGVF/YhB3UvR/jhSzd0RU38+/kWdbYYb0mGX/Bdp5AnSneRs87
 M6qIcXDfs1XIRfxzPbkwRcqIY9R7TsxUESdE8KX4TxptL8E5z7S9JA0ZIHlMOSnZxA67i0U
 2lLgekA5QRFTcBRKJuApzEHBHRiDjQU=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass header.from=simonwunderlich.de policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=simonwunderlich.de;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=simonwunderlich.de policy.dmarc=none
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de
 [IPv6:2a01:4f8:c17:e8c0::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 001638236A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 20 May 2026 13:54:38 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779278084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=8BixBb1DIhQ8qq6hCCdb7nigjWog786sWdT3/VpFGno=;
	b=gvyMwZMPJHchf8URWToPeCZIC3MDAZg5V3vHE18srsoVSoaRg6ZIppB+fYdH2Y11MQG2UC
	ESUTIaXZ8GDQxLckMfJV4dXXytZRh5cemZONQqrJRUiJMPTGhJfpey/5cHKAekFu8ECrl8
	nK20PFZycTeSzUGkywwFSLf+9bkcTSI=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779278084;
	b=xipiK4uNZZSQg8y+YUIRGq5NL4u12PeufvwwNWesABAaM7I+viKRgC9fCkJFY866wZoYnc
	BFurGqFV5fvDeZhadMrHk3x55ruYqvgGnuNopvHS3WDxa+QhWNIArLN2BHsM2l6JA5OXxw
	qYYAJusIIOmKlRAejvgLRGOLL4i8k3w=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=simonwunderlich.de header.s=09092022 header.b=tbQ7oyOt;
	spf=pass (diktynna.open-mesh.org: domain of sw@simonwunderlich.de designates
 2a01:4f8:c17:e8c0::1 as permitted sender)
 smtp.mailfrom=sw@simonwunderlich.de;
	dmarc=pass (policy=none) header.from=simonwunderlich.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1779278076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8BixBb1DIhQ8qq6hCCdb7nigjWog786sWdT3/VpFGno=;
	b=tbQ7oyOtYkDHUCzAk1OGQdUYb+JvSVaIGTi0L5ZdtPVNam0zWxZ7TCtWG8E9jmYvMSo+VM
	aasRqmqW7h5U4RP9nlUS9InTsoka5oddjwgGsVNxbfxL1XyzsntVAAUrvDtM9Zv0uDBJLo
	B51Jktwg1JlRVFlJiENydCWgC4/6RI0WI8xK7ewRpy+m3jAB0ah2Ue++sLrde114Vc4QKN
	tJ28+am++SFu0L+FAHTTqJjHKDQhWKkG6w6muuVYRt0Am3CujbvN9UN0ugEsjN8/lpKCoy
	hX3bZ4WOGoiidJqJH7T5jcnlsufswGEHO7u3kL9cKKUoG6BPsQ2UHL9qhVPNpg==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 00/11] pull request: batman-adv 2026-05-20
Date: Wed, 20 May 2026 13:54:11 +0200
Message-ID: <20260520115422.53552-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OZP4M36YHYIOEVM56BHRNRARGHWTI2NA
X-Message-ID-Hash: OZP4M36YHYIOEVM56BHRNRARGHWTI2NA
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/OZP4M36YHYIOEVM56BHRNRARGHWTI2NA/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Dear net maintainers,

here is another round of bugfixes for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit d5487249a81ea658717614009c8f46acc5b7101a:

  batman-adv: tp_meter: directly shut down timer on cleanup (2026-05-15 10:41:55 +0200)

are available in the Git repository at:

  https://git.open-mesh.org/batadv.git tags/batadv-net-pullrequest-20260520

for you to fetch changes up to f80d3d98d2ff78d9e2fe5d68b1f45948c4f7bd24:

  batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface (2026-05-19 10:43:54 +0200)

----------------------------------------------------------------
Here are batman-adv bugfixes, all by by Sven Eckelmann.

 - fix batadv_skb_is_frag() kernel-doc

 - BATMAN V: stop OGMv2 on disabled interface

 - BATMAN IV: abort OGM send on tvlv append failure

 - BATMAN IV: reject oversized TVLV packets

 - tp_meter: fix race condition in send error reporting

 - tp_meter: avoid role confusion in tp_list

 - mcast: fix use-after-free in orig_node RCU release

 - BATMAN IV: recover OGM scheduling after forward packet error

 - bla: fix report_work leak on backbone_gw purge

 - bla: avoid double decrement of bla.num_requests

 - bla: avoid NULL-ptr deref for claim via dropped interface

----------------------------------------------------------------
Sven Eckelmann (11):
      batman-adv: fix batadv_skb_is_frag() kernel-doc
      batman-adv: v: stop OGMv2 on disabled interface
      batman-adv: tvlv: abort OGM send on tvlv append failure
      batman-adv: tvlv: reject oversized TVLV packets
      batman-adv: tp_meter: fix race condition in send error reporting
      batman-adv: tp_meter: avoid role confusion in tp_list
      batman-adv: mcast: fix use-after-free in orig_node RCU release
      batman-adv: iv: recover OGM scheduling after forward packet error
      batman-adv: bla: fix report_work leak on backbone_gw purge
      batman-adv: bla: avoid double decrement of bla.num_requests
      batman-adv: bla: avoid NULL-ptr deref for claim via dropped interface

 net/batman-adv/bat_iv_ogm.c            |  82 ++++++++++++++++++++-----
 net/batman-adv/bat_v_ogm.c             |  59 ++++++++++--------
 net/batman-adv/bridge_loop_avoidance.c | 109 ++++++++++++++++++++++-----------
 net/batman-adv/fragmentation.c         |   4 +-
 net/batman-adv/mesh-interface.c        |   1 +
 net/batman-adv/originator.c            |   4 +-
 net/batman-adv/tp_meter.c              |  99 ++++++++++++++++++------------
 net/batman-adv/tvlv.c                  |  28 ++++++---
 net/batman-adv/tvlv.h                  |   2 +-
 net/batman-adv/types.h                 |  52 ++++++++++++----
 10 files changed, 299 insertions(+), 141 deletions(-)
