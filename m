Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5904FCD4F21
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 19:53:48 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 940B0857AE
	for <batman@archiver.kernel.org>; Tue, 12 May 2026 21:53:46 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1778615626;
 b=OvDUmiHm2GwzQTyOYSN6J51vL477oydyYZEKxkObJwjch8nr3IoxA2Jr6OtjNoDXw3m8Q
 AkpAhT0DUVK/6ZyanqwAsF0sb213GHMS767waKTNlgYAfrkK5LNRzuJ5hLarBFm5DnbhF2w
 MVyKTZpGsFxbobmeFjELejNwGXwj1BE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1778615626; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ifn4Ob6GuK/BTRRzDpZh6pU4tAeDXYMuq6G/B6IY+Rg=;
 b=hYP015/Y9ZSw9mDRWAaAmlOe2hdgfR2rOcgrS6ypZqQH51VZy6rTc696jUtavMfIiqIF8
 wISZg7JRZ4QMw7SYpwrBlfFNvFrtuGz+aiVPxZoYLmdr1ca5yIULnTEoaLThjRux0ZqIUgE
 vd0AGT/sh65CeACAaNy3GxYQuEAiACQ=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 43A3E80575
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 12 May 2026 21:53:13 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1778615603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=ifn4Ob6GuK/BTRRzDpZh6pU4tAeDXYMuq6G/B6IY+Rg=;
	b=tsyvOn/FjI/Lt0+cGlAVZxt0iIfo3Ll09b4rGme1l0XGpTKbHgkRVJxEzFxmuKziYeNrH3
	MEYy7cKW4J6iZEFEj14n8q01hjpVa9iluVbwWLdw3H6UEnFDpDm1F1j2/Q5rYPEgBNfyMl
	BK2SWpEh/1ZxW3KvGkWF9Ntt29qOHyE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=Nfhhmhg4;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1778615603;
	b=OL4Fs8KaO8ksiXEzYdCuZVKyPGCD5WCeaxOlFAbC6BrO1A4vyFg5EntmIGVIWqqn2vMTQc
	Ws8DEFNuQycTPwPYHOMnlQDrTPTKWgvn+ROa4Gu1+u5pAs+teJsVIfXeYO6e5Sif3i7voj
	uTUj2bWWFbC780NRDdT55gwgc1Jt5a0=
Received: by dvalin.narfation.org (Postfix) id 449131FE70;
	Tue, 12 May 2026 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1778615591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ifn4Ob6GuK/BTRRzDpZh6pU4tAeDXYMuq6G/B6IY+Rg=;
	b=Nfhhmhg4Yey95MaG5t4OiWOrxMo7MEGjLDDoQ8/HSJ+P+RWxZMk1gBLBr0iKLEW+ZMMcfo
	Oub7J5kk9IF0C2aIWm5YYZYEpUif/T/uluhcRJ6e0+UipCtUasoxiwL9rjrvJOUB+XflP9
	o3LxFZKvt9PKvJNbWP5iTjlBeceZLaw=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv 0/7] batman-adv: replace non-atomic fields with
 (READ|WRITE)_ONCE
Date: Tue, 12 May 2026 21:53:05 +0200
Message-Id: <20260512-atomic-to-write-once-v1-0-76a4272fac0d@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGFA2oC/yWMzQrCMBAGX6Xs2YUk0BJ9FfGQn6+6gokksQql7
 260xxmYWamiCCqdhpUKFqmSUwd9GCjcXLqCJXYmo8ykRm3YtfyQwC3zu0gD5xTAR6s0bJz8aEE
 9fRbM8vlvz+Rdc3Ghy+7ry98R2u9J2/YFjgjdPYAAAAA=
X-Change-ID: 20260512-atomic-to-write-once-9801e8d6b58e
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2449; i=sven@narfation.org;
 h=from:subject:message-id; bh=oIQeXRjvFE1ACFCyDmMHduzRDgfh7zpbvK4siiHZ1/Q=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnMrUqOolN33p30he93t3JA6ZetZXf3/Fn60GWtokdhn
 oDIop6lHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJdExgZHhqKHMvuV8nddvD
 3Pmsa1u4EgpsHqzzuHhm1/M28VatvoUMfzg5bh38+Tv8pnLXljpGxZhCoeZTS17bOubzWu/N80o
 JYwEA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: JVMXZAE5SXBNX3BKOVR4L4QBSMP43W3A
X-Message-ID-Hash: JVMXZAE5SXBNX3BKOVR4L4QBSMP43W3A
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JVMXZAE5SXBNX3BKOVR4L4QBSMP43W3A/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Many fields in the batman-adv datastructures are only accessed as plain
loads/stores and do not require full atomic_t semantics. Convert these
fields to native integer types and replace their users with
READ_ONCE()/WRITE_ONCE() to avoid load/store tearing.

This was noticed while searching for other atomic_t code which
(incorrectly) does things like:

    if (atomic_read(foo)) {
        do_important_mutual_exlusive_thing();
        atomic_set(foo, x);
    }

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Sven Eckelmann (7):
      batman-adv: replace non-atomic meshif config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic hardif config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic vlan config fields with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic mesh state with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic packet_size_max with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic last_ttvn with (READ|WRITE)_ONCE
      batman-adv: replace non-atomic last_acked with (READ|WRITE)_ONCE

 net/batman-adv/bat_iv_ogm.c            | 28 +++++++------
 net/batman-adv/bat_v.c                 | 10 ++---
 net/batman-adv/bat_v_elp.c             |  9 ++--
 net/batman-adv/bat_v_ogm.c             | 13 +++---
 net/batman-adv/bridge_loop_avoidance.c | 14 +++----
 net/batman-adv/distributed-arp-table.c | 16 +++----
 net/batman-adv/gateway_client.c        |  6 +--
 net/batman-adv/gateway_common.c        | 14 +++----
 net/batman-adv/hard-interface.c        | 15 ++++---
 net/batman-adv/log.h                   |  2 +-
 net/batman-adv/main.c                  | 22 +++++-----
 net/batman-adv/mesh-interface.c        | 38 ++++++++---------
 net/batman-adv/multicast.c             |  4 +-
 net/batman-adv/netlink.c               | 77 +++++++++++++++++-----------------
 net/batman-adv/originator.c            |  3 +-
 net/batman-adv/routing.c               |  6 +--
 net/batman-adv/send.c                  |  6 +--
 net/batman-adv/tp_meter.c              | 28 ++++++-------
 net/batman-adv/translation-table.c     | 24 +++++------
 net/batman-adv/types.h                 | 68 +++++++++++++++---------------
 20 files changed, 204 insertions(+), 199 deletions(-)
---
base-commit: f3fe50814354e157a6740c818c9ba293ff7c2214
change-id: 20260512-atomic-to-write-once-9801e8d6b58e

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

