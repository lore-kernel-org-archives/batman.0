Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2F6BCC6B29
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 08:56:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id ED56E84284
	for <batman@archiver.kernel.org>; Wed, 14 Oct 2026 10:56:40 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791968200;
 b=cXlJ3KCer19sjDPSho/fK0tmbeL42lg2rPrzUp0mZ1TpkkUTcH4d2iE7H4j5JsWh1t5EQ
 73aZ+wh3kQvj+4HnPq6hbyOXhg1a4Oy2zy0PK+I7pqOjVM26kT4tQIr8BqoS5uCVhqiLS/+
 gr87LNwdR8F2ZEi8kOE9c/PMwtHlvMs=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791968200; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JcwiVcQoi7L4vnWJIs2xInsjxnXxDPWHeDyVDGXeGIY=;
 b=A96tDDFoSwO4S8Pt2rwilsu4l/b+q0LXMlNzZ1o1JaU4p6BCPPTEIpgn/Ub3vSHvAJf4i
 aXQvyOatgFg8uMahejldVrNh3OL/OgxgYouV7Z5PZqGffCnd2rIgH+NvAHfBQx4yluAD1OO
 4PsoxwLjZqEmGPe9bCRnbexVS7ISGuc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id D3DE783764
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 14 Oct 2026 10:54:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791968066;
	b=rf21HpHhebmycnFRIuUOYrn8P9b+yQkCQ2bRFVNZuxhJI8i8J5V+aYal3u6y9mraAebFPx
	92RB0YOkyiT9zWDPVF3xclQTDXAFi4XGArxl2H/PwSyUBmPVpT80jJ49d0s/i4Q+Jh/N+a
	IN9RhH7+F0MuS0ciNRlCtNi32YiPr50=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791968066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=JcwiVcQoi7L4vnWJIs2xInsjxnXxDPWHeDyVDGXeGIY=;
	b=MQPbyMcF6MMfjfWrUXNb5Vy0X03OstdiZa7kUrynkKwlvZCIbVR2cwNc5/7G2aW2z+HlSh
	phiBPfjnm4xk7SuG9wGnJNeQ5WYrdu3thEnWFoZQcVkMUr3BR61M3I0Af29IJmUujLZtKd
	CDgRlscfo6Kqk7r5jIkrmF7KCOjPNlE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=zttGHKa6;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4C11720411;
	Wed, 14 Oct 2026 08:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791968051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JcwiVcQoi7L4vnWJIs2xInsjxnXxDPWHeDyVDGXeGIY=;
	b=zttGHKa6GeUHGQuXyNKh6dJ1JU3yuX0QS6VYOtMX1+W7j4ue0P7A5sA4Eh3Pq3pcgMqZWW
	hZxEPg1XQw+HiklWsdedypyP0A7i2MnAVzg2uQeNMxKyVU+8mz7SGEX9lb4kgeRMNQNPfq
	5tlLvHvT0E56WwCwPkqJ2XK8krI+/cY=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/4] batman-adv: avoid mixed borrow/consume-skb
 functions
Date: Wed, 14 Oct 2026 10:54:01 +0200
Message-Id: <20261014-skb-ownership-v1-0-4b83b9206b65@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACpDz2oC/yWMQQqDMBQFryJv3YBJIWqvUrpI4le/hSj5agXx7
 qbtcgZmDgglJsGjOJBoY+EpZtC3AmFwsSfFbWaY0lhd6ruSt1fTJ1KSgWdFTaWt6WobGo/czIk
 63n+/J7xbXLvh9fey+pHC8p3hPC9rrUsKeQAAAA==
X-Change-ID: 20261013-skb-ownership-e97162f86c9b
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1511; i=sven@narfation.org;
 h=from:subject:message-id; bh=WPCWoOoV15WRvOuLjUhZfpvUUawefv+vROoPFTA/34c=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnnnfUfhB5mWzF500r+2e+/Nc34JbQ6p6N0/bJD2w0mn
 j0rMPFRXUcpC4MYF4OsmCLLniv55zezv5X/PO3jUZg5rEwgQxi4OAVgIkb9jAz3/x419lhynNn6
 p4BczQKV7+tj6/NtDYKD/d7cj+w9unAqw3/nzY1GTXXL3nhLV5s4ltgsNY69stC/b8sHoblMt2w
 qZvEAAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: BF22FPRLCPUPGXDMTLACVSIVGZ4BQGK3
X-Message-ID-Hash: BF22FPRLCPUPGXDMTLACVSIVGZ4BQGK3
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BF22FPRLCPUPGXDMTLACVSIVGZ4BQGK3/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

In the past, batman-adv was changed to have a strict distinction between
functiosn which consume skbs and functions which just borrow them.

Unfortunately, this concept was broken in various places. As result, more
and more bugs were introduced which are related to skbs which were
accidentally leaked in corner-cases.

Modify the functions to ensure that they are belonging to exactly one of
the two strict types.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (4):
      batman-adv: never consume skb in BLA rx and DAT incoming snooping
      batman-adv: always consume skb in batadv_forw_packet_alloc()
      batman-adv: split fragment forwarding into lookup and forward
      batman-adv: document skb ownership of always-consuming functions

 net/batman-adv/bat_iv_ogm.c            |   4 +-
 net/batman-adv/bat_v_elp.c             |   6 +-
 net/batman-adv/bridge_loop_avoidance.c |  13 ++--
 net/batman-adv/distributed-arp-table.c |  10 +--
 net/batman-adv/fragmentation.c         | 107 ++++++++++++++++++---------------
 net/batman-adv/fragmentation.h         |   9 +--
 net/batman-adv/mesh-interface.c        |   6 +-
 net/batman-adv/routing.c               |  31 ++++++----
 net/batman-adv/send.c                  |  31 +++++++---
 9 files changed, 122 insertions(+), 95 deletions(-)
---
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261013-skb-ownership-e97162f86c9b

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

