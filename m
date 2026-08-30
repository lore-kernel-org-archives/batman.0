Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735B4C61DE1
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 15:22:42 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DDF9080452
	for <batman-adv@archiver.kernel.org>; Sun, 30 Aug 2026 17:22:40 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1788103360;
 b=nJiQ4SCQ/qP0DPLZkqERGQXIsloZNtIuDhPAyaofMOV+k+eVck6O2vH8XIGgHltKMgVMm
 xHJTZqEF7VKeO1uH6jMqo7Jrs33+xSma/PSYq2wTfNeTBQT/s6p5/JFdbirpWYPA9uvoGyN
 6ZFeCY5xvzBQIWSCNv5GB0pJXuuIwgo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1788103360; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=65xrEMAr9lf48NiTd4gIs8Z7U75bYLN55uGfH6ye2xA=;
 b=Lsfq+BiN1JAl0FKXsCx4YMUkuQtE8psF4QnFQd9N4zUhcF64fI+/NuWuaKZU+eBfA4o/u
 oP9EUTd66wiNfEkWtq3n0yp4VO/h4SbfKaiWZmS+QX71pch5QswhcY49l153pzPSdmJOdkO
 zyN/KYwLZ7REz3FhHD8ayUcDsDJdGVM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 29E2080393
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 30 Aug 2026 17:21:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1788103321;
	b=TwXdT7Jv1LNDGjUrSgauDx5c3BwPSgBAxXK5SDcqutuaMBlX6MER+QmztNbqSQH+cGqpiX
	k0RssHSgZIPYJO3iWo/o+izSoP1qEdWqjoCdupsiDZinmpKK5Ojx5YoxleHUro4FApuMM7
	D8sMCFPHRawnEb5IMYPe5ASgWM8OVsM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1788103321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=65xrEMAr9lf48NiTd4gIs8Z7U75bYLN55uGfH6ye2xA=;
	b=XaYgwoBEl9lQzvBDeiTFtIbO/CY9yMCA/Uw27J2szonx/nVmqn+mXk+dCc4xEyIv40jo0S
	p3I4S8nUFRKjOfClaTqD8yXViAEYh9PljtNoYdEyccX1LWLSrnEYwMHbpQmq/ZdA0ztOEh
	Kq8IoaSPP1jaChnnt37ToHmPGIRjX8w=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ArLgmio+;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id EA84020131;
	Sun, 30 Aug 2026 15:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1788103305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=65xrEMAr9lf48NiTd4gIs8Z7U75bYLN55uGfH6ye2xA=;
	b=ArLgmio+WqGkTcHd6pFykOMMhMgrXXy20lAZMRNcem76YBx/SxnWzB//lwILHFE0sM0z8R
	rBK0CWOOy4hCXV2WEyInnX6ybRZSDbzWNrJGncafwHb2EZDxse/KM7SwkyuB0QQJvWHE/C
	urvrMnv+PBFygrvm9AolESFoLAK71Kw=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v6 00/20] batman-adv: tt: atomic sashiko fixes
Date: Sun, 30 Aug 2026 17:21:37 +0200
Message-Id: <20260830-tt-fixes-v6-0-a56568a15041@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIFKlGoC/23OTU4EIRAF4KtMWIuhqylgXHkP44KfYgYX3QaQa
 CZ9d5l2IdFeVvG+R91YoZyosKfTjWVqqaR16YN6ODF/tcuFeAp9ZiBACT0LXiuP6ZMKj96C0wD
 kXGA9/p5pf+jpF+ZstaGx1599+XBv5Ou95568plLX/LX/2aY9/7++TVxwJelMCBgQ8XmxOdra7
 3tc82WvbvCLjZADho6l0V6a6HX08gjPI8YBzx0DOiEcopFaHGE5YjVg2bGH6I2eIhmhjzAOGM4
 Dxo5NP5lMDMrM4S/etu0bkZpLWbIBAAA=
X-Change-ID: 20260730-tt-fixes-fca2b722ebbd
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5153; i=sven@narfation.org;
 h=from:subject:message-id; bh=et/I0/bSOh6AKpujGsK+wXS4Zq/P6y4OfuzxJ+qFTME=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFlTvFodnRfPcz+ezPvig8OEbTJP7mYX3duRxPrYufHr8
 wLl2//TO0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQATObuakeH/jWcKBy9lGts6
 acZsuNEWvbTKLiDnGNuSDebTuRkCfaUYGVpydzPbamkrHPsRkic5l0lg3jwuweR5E2KVxfcFP09
 25wQA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: LBJTSHMDGHU44AM4BYO7H7VGD2OUK7MI
X-Message-ID-Hash: LBJTSHMDGHU44AM4BYO7H7VGD2OUK7MI
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LBJTSHMDGHU44AM4BYO7H7VGD2OUK7MI/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

There were a couple of sashiko reports regarding the
batadv-next-pullrequest-20260728 PR. I went through the TT code and tried
to handle them and at the same time already predict what else sashiko might
report as next. I needed to change the batadv_tt_local_remove() hash
interaction as preparation for the related NEW flag (and counter) handling.

And the netdev maintainers rejected this approach (for now). I had to
re-add the atomic_t code parts back in this patchset. But since the netdev
maintainers didn't like the atomic_t implementation, everything was changed
to atomic_t with the help of scoped_guard() or spin_(un)lock_bh (when the
routine used "goto").

This version of the patchset also includes the cleanups and swithches to
scoped_guards (when appropriate). The original cover letter was:

While working on the flag protection changes, it became apparent that the
current code is hard to maintain. Too many gotos with large sections which
are hard to crasp; because it is unclear how these sections are interact.
To simplify everything, sections which are handling a single task are
extracted in separate functions. This makes it cleared what the input and
output of each "section" are.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v6:
- keep roam_at access always in locked region
- use WRITE_ONCE/READ_ONCE to reduec number of times we need to use a lock
  for a simple read
- drop flag modification from kernel-doc of batadv_tt_local_set_pending_event
- document special case when batadv_tt_local_size_dec can be called without
  the hash list lock held
- Link to v5: https://patch.msgid.link/20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org

Changes in v5:
- keep all batadv_tt_flags_get changes to "batman-adv: tt: use protected flag modifications"
- remove to non-RCU iterator in batadv_tt_local_transition_new() after
  switching to locked iteration
- remove RFC patch prefix
- integrate the cleanup patches which depend on this patchset
- Link to v4: https://patch.msgid.link/20260806-tt-fixes-v4-0-c2fc871fe807@narfation.org

Changes in v4:
- fix setting of BATADV_TT_CLIENT_ROAM batadv_tt_local_add_roam()
- move the roam_at setting in batadv_tt_global_del_roaming() before the
  setting of the flag
- don't unset BATADV_TT_CLIENT_NEW when avoiding the
  batadv_tt_local_size_dec() - it is simply not needed
- new patch: fix lock precondition for batadv_tt_local_size_inc() and
  document it
- clean up mini-helpers to avoid goto. precondition for using scoped_guard
- switch routines with goto's from scoped_guard to spin_(un)lock_bh
- Link to v3: https://patch.msgid.link/20260805-tt-fixes-v3-0-25b00b558470@narfation.org

Changes in v3:
- switched to spinlock_bh due to rejection atomic_t by netdev (and
  potentially easier code)
- switch back to RFC
- Link to v2: https://patch.msgid.link/20260804-tt-fixes-v2-0-487c48fc7fc4@narfation.org

Changes in v2:
- rebase on main
- add "batman-adv: tt: use atomic flag modifications" and "batman-adv: tt:
  simplify NEW flag transition code" because they are reverted on main
- add patch to extract the roam "add" code in a separate function
- make the "simplify NEW flag transition code" patch independent of atomic_t code
- Link to v1: https://patch.msgid.link/20260730-tt-fixes-v1-0-64e9e525d555@narfation.org

To: b.a.t.m.a.n@lists.open-mesh.org

---
Sven Eckelmann (20):
      batman-adv: tt: remove only the entry which was looked up from the hash
      batman-adv: tt: extract code handling a roam on add
      batman-adv: tt: simplify NEW flag transition code
      batman-adv: tt: drop unnecessary cleanup goto in helpers
      batman-adv: tt: use protected flag modifications
      batman-adv: tt: transition NEW local entries only under lock
      batman-adv: tt: don't uncount never committed clients on pending purge
      batman-adv: tt: decrement count for committed client on local_remove
      batman-adv: tt: look up wifi state of incoming interface in helper
      batman-adv: tt: extract allocation of new local entries
      batman-adv: tt: replace forward gotos in batadv_tt_local_add()
      batman-adv: tt: extract refresh of existing local entries
      batman-adv: tt: extract update of dynamic client flags
      batman-adv: tt: extract allocation of new global entries
      batman-adv: tt: extract merging of flags into existing global entries
      batman-adv: tt: replace add_orig_entry goto in batadv_tt_global_add()
      batman-adv: tt: extract removal of the superseded local entry
      batman-adv: tt: extract marking of a removed local entry
      batman-adv: tt: extract immediate purge of a local entry
      batman-adv: tt: drop the cleanup label from batadv_tt_local_remove()

 net/batman-adv/translation-table.c | 1113 ++++++++++++++++++++++++------------
 net/batman-adv/types.h             |   11 +-
 2 files changed, 747 insertions(+), 377 deletions(-)
---
base-commit: f3c33e7fcb7e88cc099b783faf26f0494b774571
change-id: 20260730-tt-fixes-fca2b722ebbd

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

