Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9D0CA5FEC
	for <batman@archiver.kernel.org>; Sun,  4 Oct 2026 10:09:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D08F844AD
	for <batman@archiver.kernel.org>; Sun, 04 Oct 2026 12:09:21 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791108561;
 b=bwOYk4CoJfA+v2WA+cZ45LLi9SX+vrOiO4XEWUpKrnac4yiOKkOs6qndzt+fzpGbo8XvH
 v2phFz2qK5KsbkILvdAoDJ2fv6Sb5xqXg+jVf4YcKnK/GDGZinb9T3eK+mx6KGGkF9i4uJV
 vu0V2+NbX4l4eLgwRtSt/RX0Sn1Oycg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791108561; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kxDQE7N74T9DXrmtrjl68SceKJcGMaQDj1VgALRW72g=;
 b=t5T7Jo5+MBQUfwTAoHZC79HAXReFjBDuu2nkQBOu1la+dFP7sGe1I35gEsPlW5QIso7zW
 vwqETI6pNVZX8mu4KjjVtimor3wXXZw96oRf5+JvYH+hQWi9dYxlmLJ72DtJ/Wn7CR6Uv7u
 Z82O8NOIhy+zPZaAQRM52CAgjJyTPBM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 2C3E480F1E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 04 Oct 2026 12:09:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791108552;
	b=chX/H9EiSJrASyxu2tJYtf6Jp4YS2KAxPBn4Zv0pWlkaqBhCr2TGuC4wLdSA/ASYh0XWcZ
	Pi5BQGzjQtvGbqP9SswgPf58kJwinTHci+YKALGL/qpb8UpbOZeQM/5yRLL61Kon1LmTRn
	Qn8Pub56jrMh3Dci8PO7ILqB8DHjG9A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791108552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=kxDQE7N74T9DXrmtrjl68SceKJcGMaQDj1VgALRW72g=;
	b=eQZzWF+ZakOR/cZ6eqTCKUgjXlqQiHPWerjN5gMW1zDuzElXGyCSpQilR+h+J5Mf87M39j
	WM+WF16tF62B0dWGSv0M4fo1CU7oIUblYW0uxSS5DsTuskDKNqz2+nV8+fSPdGPoINr8Qa
	aNGNpS9tCRuWoth77DetMGuJhvPw5io=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=0vL22zfo;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id DA8282046C;
	Sun, 04 Oct 2026 10:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791108541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kxDQE7N74T9DXrmtrjl68SceKJcGMaQDj1VgALRW72g=;
	b=0vL22zfovBJFmZJivHkshKzYUW/pvwI5Ww0rM6Pul6G1pbLY/U7J+THcDn/mUGkE0wz9K3
	4loUpCGArVlV03ewGypG19MDjslCoG0+BVYimRPX8TIGatcyaE79RfPuT+2ddYjgZFfWGy
	QbqKWCfk1Y+PM7PTzejoCE9NloDfEPQ=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v2 0/9] batman-adv: annotate jiffies members with
 READ/WRITE_ONCE
Date: Sun, 04 Oct 2026 12:08:35 +0200
Message-Id: <20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKMlwmoC/31OSw7CIBS8SvPWYqASsa68h2nMKzxajCkNUKJpe
 ndp3bubmcxvgUjBUYRrtUCg7KLzYyH1oQI94NgTc6ZwqHl9FpxLZjCxF8b0mKcCiflREyMlsdE
 nS50VUKJTIOvee+0dOkxoMrQ/Pc7dk3TaOjfn4GLy4bPvZ7H7/09lwQSzSkmjJCfZXG4jBoup/
 D760EO7rusXS+mwQtYAAAA=
X-Change-ID: 20261004-dat-last_update-once-e74a9c3febf1
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2123; i=sven@narfation.org;
 h=from:subject:message-id; bh=8EeKQAGtSYWXMFWzBAAQL51BAiIDr6bimo9CXVNE4HA=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmHVLc0/UjZ960+Z41UZO0TmVvvHjcbsnms36LOIvR01
 tfmPNdbHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJaOkw/OGfuH+P+RFzt2kM
 dR8mpexxChLbyn/m/O/DP+7Z2i7cIrOXkaHztX8Rl+cmpca0F/a8QV9bPhZluDzROC1wcULyW0N
 5NRYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: XYVXHOQIMR6PZBCM7FR4YCASC4VK237I
X-Message-ID-Hash: XYVXHOQIMR6PZBCM7FR4YCASC4VK237I
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XYVXHOQIMR6PZBCM7FR4YCASC4VK237I/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There are various members which track jiffies value of the most recent
activity and is used to detect timeouts. These accesses are not
consistently protected by a lock, so READ_ONCE/WRITE_ONCE must be used to
prevent data races caused by compiler optimizations.

To avoid an underflow due to an non-strict order read of jffies vs
members, use jiffies_delta_to_msecs instead of jiffies_to_msecs to
evaluate the delta for netlink.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v2:
- add patches to adjust more places to follow the same approach as shown in
  the DAT one
- Link to v1: https://patch.msgid.link/20261004-dat-last_update-once-v1-1-f774d740e498@narfation.org

---
Sven Eckelmann (9):
      batman-adv: dat: annotate last_update with READ/WRITE_ONCE
      batman-adv: bat_v: annotate last_unicast_tx with READ/WRITE_ONCE
      batman-adv: bla: annotate lasttime with READ/WRITE_ONCE
      batman-adv: tt: annotate last_seen with READ/WRITE_ONCE
      batman-adv: annotate originator last_seen with READ/WRITE_ONCE
      batman-adv: annotate neigh_node last_seen with READ/WRITE_ONCE
      batman-adv: annotate hardif_neigh_node last_seen with READ/WRITE_ONCE
      batman-adv: tpmeter: avoid underflow in reported testtime
      batman-adv: tpmeter: avoid underflow in rtt

 net/batman-adv/bat_iv_ogm.c            | 16 ++++++++++------
 net/batman-adv/bat_v.c                 |  8 ++++++--
 net/batman-adv/bat_v_elp.c             | 10 +++++++---
 net/batman-adv/bat_v_ogm.c             |  7 ++++---
 net/batman-adv/bridge_loop_avoidance.c |  4 +++-
 net/batman-adv/distributed-arp-table.c | 11 +++++++----
 net/batman-adv/originator.c            | 14 ++++++++------
 net/batman-adv/send.c                  |  2 +-
 net/batman-adv/tp_meter.c              |  4 ++--
 net/batman-adv/translation-table.c     | 15 ++++++++++-----
 10 files changed, 58 insertions(+), 33 deletions(-)
---
base-commit: 4fa5cbac90fa7b8936779b4313debb3d89701c59
change-id: 20261004-dat-last_update-once-e74a9c3febf1

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

