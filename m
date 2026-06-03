Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED8FCD6E4A
	for <batman-adv@archiver.kernel.org>; Wed,  3 Jun 2026 04:20:40 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7530881E0F
	for <batman-adv@archiver.kernel.org>; Wed, 03 Jun 2026 06:20:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780460439;
 b=WXPidRDj4pQUZX3Z43Fi9rjU9vfN/V69yrqffRJ8n10pbKWevQ+6sQ2B69pE/lWxSMCTY
 6IU2rFPoEMkP1glN6zzvoq0qUraz4CiDsWkpHcCPRdXeoWh1jfmzqer216Fs+/S5Z4pBl+u
 DB1Tbf8A2EjAiyAgYcXP1M5WCyuFkuE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780460439; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=jfr4D+FK64Sb8LUh9B/6LYpNRpZIU2AD3zWoTGvqUO4=;
 b=BnWZkI0gnKOuD7/e5iiJ2IbXDX5osS3UCbgw99aTC3g4HXK4O3kgGZwQBM0GJptk/xQ6s
 Nzlo4IwYzUrPDQRXl667n8j7ONvxMz4Kaa2OIPuBRJOhVArC5Bt8z6wYa91YInxhDQiq4Ya
 W+HBRCqzJZb0WXgWhDOdWcO5oAKOmNo=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5559C82232
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 03 Jun 2026 06:17:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780460255;
	b=pr+3qETh/EepOXqzYZaD6jOb2WTpShLeZyHkjJ3vePZhwFyU6C8dEhDLhqzdd8xEa9+yW0
	V/uxW/BbFWc6tCMdewLRWVCHq3/OjSkP2ooF3iJpS2rfYhyDFwwAzMBvYd91awVHLuHmHZ
	SnjLeW4ythzcC2vl6loeEiLCs3a+ARs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=V6hQTonf;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780460255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=jfr4D+FK64Sb8LUh9B/6LYpNRpZIU2AD3zWoTGvqUO4=;
	b=Gh2GC5Duq5Q+K5t8CAZBsWFeCp6L0KKqrCmela7uqcB+GHQkCB/NMzFx642Wewa7awT1dx
	WIYDuMthKHO4VrkE3KDrtUaj6gC7VrV61qoUJQOisZ6rDnLXC7aLzOELgpv2RNcGCjzMEy
	sGbNHAsj2E32JAj46MaDONAJYS4aBuw=
Received: by dvalin.narfation.org (Postfix) id 4EF0720131;
	Wed, 03 Jun 2026 04:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780460243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jfr4D+FK64Sb8LUh9B/6LYpNRpZIU2AD3zWoTGvqUO4=;
	b=V6hQTonf8eou9wZuOteRASXUOXLwVIOArvxvEBEn2gxWm+phB7pHk5Q4ca3+7b2spAMpgt
	n9gbyV3Ktwlly956Ot5hPAu2wZVxly+scpigBwgOjCbPx9KKaiZ3mQrUhsE5izQL/q6WyW
	ndGXO3VAIL/cXVKvDjEgcirhD30JyEY=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v6 00/11] batman-adv: tp_meter: post fixes cleanups
Date: Wed, 03 Jun 2026 06:17:12 +0200
Message-Id: <20260603-tp-reason-missing-v6-0-7011620f93a5@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMiqH2oC/33OwU7EIBAG4FfZcBYDA0NZT76H8TC0QxcT2w3UR
 rPpu8vWg40hHv/JzPfPTRTOiYt4Ot1E5jWVNE81uIeT6C80jSzTULMABU6hNnK5ysxU5km+p1L
 SNMqoiVBHE01nRb27Zo7pczdfRKCFhlW8/szLR3jjfrmD981LKsucv/byVe/7//SsWmrZIZD3E
 Aan6XmiHGmpHz/Oedw7Vjgq55YCUslzj/2gPVg2oaWYgwK6pZiqgPOI1inlu+Yv9qCYpmKrggM
 gOlZKg28p+Ks41VSwKp0nDD6yY9f9VbZt+wYLIbyW6AEAAA==
X-Change-ID: 20260513-tp-reason-missing-f1aa51f3f374
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3246; i=sven@narfation.org;
 h=from:subject:message-id; bh=2/qckDXqBKPfDkVs9P759t7c9Pu6q9VTpAxi4PdXE7M=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFnyq04zux74+SFQzMR558d6xW1c0ydP0QuasL210Lruh
 3nmt1k3O0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATubGH4X/I9ky3R+79gnrr
 lv+5xmtx8virwzdfPDwTsWtONfuE45Y3GBn2tawKtHuUYCdx4Wr6fH9Vg5QdujHd95fpPPxuvvm
 n1wZmAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: U7BA5LM6PTYMTCC754BBABGFEGVLD4DV
X-Message-ID-Hash: U7BA5LM6PTYMTCC754BBABGFEGVLD4DV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/U7BA5LM6PTYMTCC754BBABGFEGVLD4DV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

After most of the problems regarding the role confusion were fixed, we
should use the opportunity to split the variables completly. This can
prevent some of the confusions and at the same time reduce the memory
consumption significantly.

Since the sender variables are separated from the rest, also clean up the
congestion control code. Make sure that everything is in short blocks which
ensure that the reader is aware of the locking and the results of the
calculation. Which also means that the actions (sending) are extracted from
the congestion control code.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v6:
- add patch to initialize dec_cwnd
- add patch to fix fast recovery precondition
- extract the batadv_seq_before handling for fast recovery into a separate
  fix
- add patch to finish the tp_vars initialization before adding item to the
  RCU protected list
- Link to v5: https://patch.msgid.link/20260601-tp-reason-missing-v5-0-78a5b8fe6e67@narfation.org

Changes in v5:
- drop accidentally added static (in-function) reason variable
- add patch to handle potential divide-by-zero in batadv_tp_update_cwnd()
- Link to v4: https://patch.msgid.link/20260531-tp-reason-missing-v4-0-5d2556e00128@narfation.org

Changes in v4:
- rebase
- add patch to fix unacked_list order
- add patch to initialize dup_acks explicitly
- extract batadv_tp_avail fix to separate patch
- split congestion control variable patch in "locking" and "structure"
  patch
- Link to v3: https://patch.msgid.link/20260521-tp-reason-missing-v3-0-26855460087a@narfation.org

Changes in v3:
- rebase patches
- fix receiver cleanup "put"
- add patch to cleanup the congestion control locking
- Link to v2: https://patch.msgid.link/20260519-tp-reason-missing-v2-0-9c5cd1824e3b@narfation.org

Changes in v2:
- fix send_result kernel-doc
- rebase patch
- add patch to avoid role mixup in search functions
- add patch to split sender and receiver sessions
- Link to v1: https://patch.msgid.link/20260513-tp-reason-missing-v1-1-752a882bd61a@narfation.org

---
Sven Eckelmann (11):
      batman-adv: tp_meter: keep unacked list in ascending ordered
      batman-adv: tp_meter: initialize dup_acks explicitly
      batman-adv: tp_meter: initialize dec_cwnd explicitly
      batman-adv: tp_meter: avoid window underflow
      batman-adv: tp_meter: avoid divide-by-zero for dec_cwnd
      batman-adv: tp_meter: fix fast recovery precondition
      batman-adv: tp_meter: handle seqno wrap-around for fast recovery detection
      batman-adv: tp_meter: add only finished tp_vars to lists
      batman-adv: tp_meter: split vars into sender and receiver types
      batman-adv: tp_meter: use locking for all congestion control variables
      batman-adv: tp_meter: consolidate congestion control variables

 net/batman-adv/main.c     |   3 +-
 net/batman-adv/tp_meter.c | 739 +++++++++++++++++++++++++++-------------------
 net/batman-adv/types.h    | 145 ++++-----
 3 files changed, 513 insertions(+), 374 deletions(-)
---
base-commit: bba80ddd693e6d82a0b1f456511904cfefd5df24
change-id: 20260513-tp-reason-missing-f1aa51f3f374

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

