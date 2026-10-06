Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC31ECA5FED
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 16:48:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0E9BE83BB4
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 18:48:12 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791305292;
 b=HDiefXkvl9VctWvhNLOUykCGpZf7pBYk8NQ6BOtf657h0Jpgzy7PvLdVXmIaQKzn/mfeU
 G2mjsLbBhCucXesJ8SMdvY6Se9E9G/ZaIQhApHstF9mS1KXvdDfDBBGSupjQK1ihdyw4qIq
 hsLyvxcyt8AkYT38IsG50LdKlukwxUE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791305292; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=nkLylabT5yAjEt/MjxQYvwU/K3WV+OUh/PXt1WzFlxY=;
 b=U6ugVP0QZVWslEVqRyhW/dZXXmaaqTMf2dEg+Ucs6Qih2XgBnVpdNOqhonvbkgBXfpdCz
 3omB0mjpFcweqPrdwOon8WSjTQrNhwS0XLaEpCOG291ksanWgYInu5sqQP6/XA0O7U1bFM+
 I+gDvsSyBkqDboIOc1eEcxSJqyX/gZc=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 5D6B2810A0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 18:47:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791305283;
	b=xJ2UnBFv1zZvNphWz+6fziPvvXtukLlsbNwKK/vfweXUZLDOUl/hkXPMN4Sj5eFDi+IbaM
	4EGNv3S05aJauqAIOc7wBO0mBW8vYdSJiz9+ljiZz6lDDbm3GOzz7pCIYTd+hyY3xUWq1i
	skFuas+wERp4d28O+bpWZ6233+n26sU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791305283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=nkLylabT5yAjEt/MjxQYvwU/K3WV+OUh/PXt1WzFlxY=;
	b=OUeG+BEs/3mH4Au8n162vLxB1m8B32bSlXwdQG61qvxUYHWAuomWjwWzpTbV3RYldKviKk
	q/vekWJwwwaicsXK3+oFyDI9Iewbw4ZchKH7/G0OfF1sukNnxN1DVOuRyek1cBnJsJlE++
	PaE7tzOBWvWS6qTuYaaGXfwKOsNazbw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=o6ogHEIl;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 16DBE1FE24;
	Tue, 06 Oct 2026 16:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791305272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nkLylabT5yAjEt/MjxQYvwU/K3WV+OUh/PXt1WzFlxY=;
	b=o6ogHEIlbxYzvZpCtjSMGdnd3fcIZe+CIwyBf5e3OGiWvIfubClMyXLssW/d2F7c5PK1Cs
	NehO8ES0KixKFfy0zDLVW39BslPTt0EA4zbvJEqE3lzWfMUjVYPxNJGmlCJcOOgg8lwS20
	7hZSZntSoNzSCXm2fwL58ciCj5cen4k=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v3 0/9] batman-adv: annotate jiffies members with
 READ/WRITE_ONCE
Date: Tue, 06 Oct 2026 18:47:02 +0200
Message-Id: <20261006-dat-last_update-once-v3-0-316aefdd5f5f@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAYmxWoC/42OQQ6CMBBFr2K6dkxbGgFX3sMYM6VTqDFA2tJoC
 He34M6FcTd/8ue9mVkg7yiw025mnpILbuhzKPY71nTYtwTO5Mwkl0fBuQKDER4Y4m0a80gw9A0
 BlQrrprCkrWD5dPRk3XPDXpjGiCax62cfJn2nJq7Mtdm5EAf/2vxJbP3fqiRAgC1LZUrFSdXVu
 UdvMea/D4NvN02S/4AkcEDNhUSlRUXmG7Qsyxs4rwpaHwEAAA==
X-Change-ID: 20261004-dat-last_update-once-e74a9c3febf1
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2318; i=sven@narfation.org;
 h=from:subject:message-id; bh=beBYimoX7pVBSEYERCfucZDNRa8OqnsnC5fE37ZT7/M=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlH1TjV9uQVfGHhXv7xs9y9s7I7fr+5d3rOrgtmcZznv
 qV33Js+s6OUhUGMi0FWTJFlz5X885vZ38p/nvbxKMwcViaQIQxcnAIwEeVJDH8lpP8r3wuW/uj3
 4s3T+MOuYYwWbaaCW8zMe44fKsyeV8jJyHBzqpuXcmK24ufcM93PbI5s8pmdXOGb9cVLqJf3ac+
 GHj4A
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: UOE4TURUEISPN6RWEW62NPTXQIZTWMS6
X-Message-ID-Hash: UOE4TURUEISPN6RWEW62NPTXQIZTWMS6
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UOE4TURUEISPN6RWEW62NPTXQIZTWMS6/>
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
Changes in v3:
- rebase on top of "batman-adv: tt: improve pending/CRC handling" patches
- Link to v2: https://patch.msgid.link/20261004-dat-last_update-once-v2-0-ab012a4b18ed@narfation.org

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
base-commit: 0eaac0f4187bc9b69b41d90998fd7b93ab07e53e
change-id: 20261004-dat-last_update-once-e74a9c3febf1

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

