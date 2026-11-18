Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05B4606A338
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=mzBzd5+X
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 76EEC84494
	for <batman@archiver.kernel.org>; Wed, 18 Nov 2026 12:42:43 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1795002163;
 b=CwSR9JBoCHHBT6rQA85C86ZeBKUrbTjzpa7vF3lvSByNIxMzF1RoTlacqjCWSNyozuuVF
 rmcMxpoD5lLXiJKExKY9wzs4U8UtvPynyY+8Dccw0p6Jw/STgvgWgbWGHfs0fhUltWxXTnH
 ctkMlb3f3UgBfBXOW74i+zB84p8xPuA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1795002163; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=pVFqZu9FgrRhYp9C8h3S4YMrSMnBITSK03BKNO8XIm4=;
 b=YEZoWIn4d/wFXuqjQmDUunjy9ztriElx/3eNKhUk8hi/EUgSSmW7Gc41iXtnNf+AQYi4S
 xD+gfqwXd1wISFmuGrvHYC8ms0vWf/sjm83Snr+zwzzLgB5q2xXvPBCVveflLARkxSorGqn
 E4z5qWip7yinp2dGKxyxNFjRGKeJd3A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id B39F1806CB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Nov 2026 12:42:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1795002123;
	b=Rs14gCoUkYDD/oLuuoTWWs0SPTrHn0b/byMurDWJ3PZOfh8kEr3ZDNOHPhn1P0Kp0Bh140
	KCHGiqCwy/0FEB1izo0VvA/l5LGs4LsZFp4rTGhiI1UCXCID+zDuba8YQdNhAdHmzUiiXu
	AhwJPcQx09sv9MUs3XUt5Hy+hSQvtSI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1795002123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=pVFqZu9FgrRhYp9C8h3S4YMrSMnBITSK03BKNO8XIm4=;
	b=vLEvTt3t5vwMCpDBMCMBKfmOCy26mAn13nSu9EBNdPOERFBTBixa6wZr+18P669h562rXA
	yd5CqIVtX/TD3u3kpKdbDmqhGPAm/tUMv9ac8zIevP/4ocC+W7jXfT3S/T9mfUThbhn4Lm
	oP5VIZ1znMmgC5di8/lIu/bvs3xaEzw=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=mzBzd5+X;
	dmarc=pass (policy=none) header.from=narfation.org;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org
Received: by dvalin.narfation.org (Postfix) id 25CA21FE9A;
	Wed, 18 Nov 2026 11:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1795002121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pVFqZu9FgrRhYp9C8h3S4YMrSMnBITSK03BKNO8XIm4=;
	b=mzBzd5+XDg3RUgb1o0gf8X/YaMPta11qnzm2393ItLQvz+Njir2eiM2ROH70R/Bv0jCWA/
	5djcXjqO4hj5KyvwYdv6TC2pdeRliNYjzZ68L0sTUhw5TI8W7Xb/fWUgiKPmrLhQ/v27qw
	k+2jCmp3TXuvKR6m6LiLaLnshGDc8Qc=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v5 00/11] batman-adv: tt: shashiko 20260930 follow
 ups
Date: Wed, 18 Nov 2026 12:41:50 +0100
Message-Id: <20261118-tt-avoid-unhashed-event-v5-0-bce9ead803e6@narfation.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP6O/WoC/3XQzW7DIAwH8FepOI8JQ4B0p73H1AMfpmEHUgFFq
 6q8+0g2adXUHG3Zv7/lOymYIxbydriTjC2WOKdeyJcDcZNJZ6TR95pwxhUwpmit1LQ5enpNkyk
 TeooNU6VaWSuDUh5Akr59yRji1yZ/EGuq8Y2cfvrlaj/R1ZVdJ6dY6pxv2wkNtvnfNL2b1oAyy
 sBpJZTUR1DvyeRgar/+dc7nLanxR2vct3i3tBsQ/QiKKf/MEn8WML5viW4FoYM8upFZ9tQaHiz
 Y/2gbujVwtz4WRuDiv7UsyzdPrKB3wAEAAA==
X-Change-ID: 20261006-tt-avoid-unhashed-event-76bb5f66d115
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4752; i=sven@narfation.org;
 h=from:subject:message-id; bh=0f8aBjgPbnHHEybOnhGdlzA3uTQBKRxCv1INPFpi2ew=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFl/+xl+39W/WLuPXbLGX1J7a95fwat/Y3ZqzQ7fdaeh+
 uvV4krFjlIWBjEuBlkxRZY9V/LPb2Z/K/952sejMHNYmUCGMHBxCsBEtjky/C94Ed55W3bFjCVP
 n+Wcu+R3191AfsGBXQZpypdibr2NKlzHyLBKr8dv35/pqiLr3px5kyMmIvxuvY7vTd6dlrm6r88
 8X88LAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: E4SDW6R5M7XVFIVGFHIVF22GYL5TMXS7
X-Message-ID-Hash: E4SDW6R5M7XVFIVGFHIVF22GYL5TMXS7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/E4SDW6R5M7XVFIVGFHIVF22GYL5TMXS7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_NONE,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There were various reports in the Sashiko report from

* https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930094558.3723766-2-sw%2540simonwunderlich.de
* https://sashiko.dev/#/patchset/20260930094558.3723766-1-sw@simonwunderlich.de

Some of them are about the rather bad locking behavior in TT and addressed
here. While looking at this, it was also noticed that the TT event handling
seems to be broken since the introduction of dynamic flag changes.

The source of truth is now the changes list. Only entries inside their are
applied (NEW -> included, PENDING -> deleted) in the local table. This
avoids a desync between the announced TT changes and the submitted local
table. But it also means that an entry which was added and then gets
directly removed cannot be dropped directly from the local table. It can be
that it is in the process of being committed and therefore must be marked
as pending and then be handled in the next commit phase. A situation which
caused problems in the past because TTVN and change list were completely
desynced.

Of course, this also causes headaches when it comes to error handling. When
a delete needs to be queued, and the allocation fails for this change list
entry, we still need to get this somehow in the change list. Otherwise the
entry would stay forever as PENDING in the local table. The entry is
therefore marked as del_unqeued and the next purge run will reattempt the
queuing of the deletion in the change list.

This makes the transitions well defined but looking at the full graph for
too long causes headaches. I will submit these graphs as reply and would
recommend only to look at the "main" (normal cases) and specialized "rare"
graph for the corner cases.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v5:
- annotate functions with locking dependencies: batadv_tt_local_event(),
  batadv_tt_local_unhash_pending(), batadv_tt_local_commit_change()
- return false in case of an event allocation error in
  batadv_tt_local_add() to avoid forwarding traffic for this client
  https://sashiko.dev/#/patchset/20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123%40narfation.org?part=6
- a client which was PENDING -> DEL was in changelist and then reappears
  between the changes list splice and the batadv_tt_local_commit_change()
  must be marked again as NEW (in batadv_tt_local_commit_change()) to make
  sure that an ADD is send again BUT it is not yet part of a full table sync
  https://sashiko.dev/#/patchset/20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123%40narfation.org?part=9
- correctly explain the del_unqueue handling during a purge (which keeps
  the entry in the table until the DEL was actually queued)
- extract code to unhash local table entry table size adjustment
- Link to v4: https://patch.msgid.link/20261116-tt-avoid-unhashed-event-v4-0-42c6bb518123@narfation.org

Changes in v4:
- only permanently modify the local TT table based on the "changeset" for
  the TTN
- Link to v3: https://patch.msgid.link/20261102-tt-avoid-unhashed-event-v3-0-f37f59c80b0d@narfation.org

Changes in v3:
- rebase on post-2026.4 patches
- disallow a removal of an ADD from the TT changes whenever this change
  entry was at any point a DEL
- Link to v2: https://patch.msgid.link/20261008-tt-avoid-unhashed-event-v2-0-7c4eed81606d@narfation.org

Changes in v2:
- add patches to handle ROAM flags differently
- Link to v1: https://patch.msgid.link/20261007-tt-avoid-unhashed-event-v1-0-01c763657916@narfation.org

To: b.a.t.m.a.n@lists.open-mesh.org

---
Sven Eckelmann (11):
      batman-adv: tt: unhash local entries with hlist_del_init_rcu()
      batman-adv: tt: refresh local entry in single flags_lock section
      batman-adv: tt: don't remove unhashed local entries
      batman-adv: tt: don't queue local events for unhashed entries
      batman-adv: tt: remove unannounced local entries via pending state
      batman-adv: tt: keep local entry unchanged when ADD can't be queued
      batman-adv: tt: requeue DEL of pending local entry after failed allocation
      batman-adv: tt: extract removal of pending local entry
      batman-adv: tt: commit only the announced local changes
      batman-adv: tt: avoid list_lock for unchanged local clients
      batman-adv: tt: drop ADD+DEL events of never announced clients

 net/batman-adv/translation-table.c | 910 ++++++++++++++++++++++++++-----------
 net/batman-adv/types.h             |  14 +
 2 files changed, 667 insertions(+), 257 deletions(-)
---
base-commit: a793cf82308e57a0e21c97e889c143cdbba67e5f
change-id: 20261006-tt-avoid-unhashed-event-76bb5f66d115

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

