Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E468DC61DBE
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 06:19:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 1483A83C2A
	for <batman-adv@archiver.kernel.org>; Sat, 29 Aug 2026 08:19:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1787984342;
 b=AcHWX3/t5T/eWVonhjc66j9NBhFZUkF2v8MEoULuLF8KQ+i/hXZXn5yPPQWBL3Amv1x2c
 kCwtN3V9LsJsp1Z1gT7DPX+NU0aru998QtP9pg4MGdPXI0VmyArdC51j1m3YIFxtdbTC84w
 uOCqScRdYQkjez92NduzIZRhhNPoe9g=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1787984342; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=S5AfOjZMuU/sru4N5fhAlw1Vn7CM5l0Kt2WU7Lz6rDQ=;
 b=jAEZzvywvPB5yTOyn62s4KWPrRg1G3SBWSc4rxrfPpNBDZf/eXb1OxdgMk6MMAzuTxsHj
 GHb/sVPkshhO63IOoWU/iQtT50taWYl5h4FnCFHTr8SGPTyWUJeTJuR5kDdfBooG2EQAn+/
 7+2sM5plUJPOpo6xqZlmDvMyXl/N/S8=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 90ADA81669
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 29 Aug 2026 08:18:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1787984333;
	b=RmU90siVm7DsfeqvgUFwTAQrUfT+lViX7kebHtFTgLyjgeML32A23MyFV41DbNLGMy6s4h
	73hO5M2dUVseOOMjynvvM5YuSQ0yrIFWszsiNRo71/x0qmhDET+EXyjzxirKdxEhe0JGx1
	IpvEcu4bYdM4L9OHphV3Ar7xnX0rkAc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1787984333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=S5AfOjZMuU/sru4N5fhAlw1Vn7CM5l0Kt2WU7Lz6rDQ=;
	b=sxGApwahynJCfRg9nYUGHW5dUXUI8RSPlSrCOKiUjIJGv9hFXFA0RcwFJlo91iSzhhjSgv
	c1GwqPU6CtliTp0P526CVBtnU/84rmLoJ3vz4Q5mtw2w3BiAmMMpcK7VEcsE2jmN3UWuVK
	VQKwP2Lbr1N/yO8hZspTUCwxQNrNv9k=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=PlKIv0Tb;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3FC571FE24;
	Sat, 29 Aug 2026 06:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1787984318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=S5AfOjZMuU/sru4N5fhAlw1Vn7CM5l0Kt2WU7Lz6rDQ=;
	b=PlKIv0TbEpOClObGswdI2XFkUgmmSRnpE27uCQ560bEZYEZkAoS7+avtz2zct675MitPMi
	2CQxqiImhDYMYu42wXfiUHop0tIw2kbCPhGydX3cRaEbmpsshbgzruu1iwULx4G/ejERt9
	mgs48HggkE7gq6PzMkhP7uSO/oJxfbs=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH batadv v5 00/20] batman-adv: tt: atomic sashiko fixes
Date: Sat, 29 Aug 2026 08:18:11 +0200
Message-Id: <20260829-tt-fixes-v5-0-88fce8fd683d@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKN5kmoC/23OwW7DIAwG4FepOI/JcXBgO+09ph2AmJYdkgoYa
 lXl3Uezw9DWo/H//eYmMqfIWbwebiJxjTmuSxvo6SD8yS5HlnFus0DACfQIshQZ4oWzDN6i04j
 s3Cxa/Jx4X7T0u3C22LmKj5/3/OU+2Zd7zz15irms6brfrMOe/19fBwlyUvzChDQT0dtiU7Cl/
 e95Tce9uuIvNqA6jA0ro70ywevg1SM89pg6PDaM5AAckVEaHmHV46nDqmGPwRs9BDag/+Jt274
 BZrPl6nUBAAA=
X-Change-ID: 20260730-tt-fixes-fca2b722ebbd
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4718; i=sven@narfation.org;
 h=from:subject:message-id; bh=a/CDJwkURqMqrYWU9beR/5+TbhQss/berWpJkLMmVxw=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmTKld3NIQdnSw+4RWT4p/AEypHviq+dmX69dH9TKjjC
 a8+n48xHaUsDGJcDLJiiix7ruSf38z+Vv7ztI9HYeawMoEMYeDiFICJ7C1kZGhNuz3xyN1HOTbf
 NqVE/nomXnb4aOJd0wOuJZPX1T+SVhJh+Gf7Sp7xiNWXQ1a7D5hJc8yfl/l1a5eLxLGjn9/ttE4
 rM2UHAA==
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MC6P6RYEDAM6H2ZPCEIFEVOWIHJV7OK7
X-Message-ID-Hash: MC6P6RYEDAM6H2ZPCEIFEVOWIHJV7OK7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MC6P6RYEDAM6H2ZPCEIFEVOWIHJV7OK7/>
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

 net/batman-adv/translation-table.c | 1100 ++++++++++++++++++++++++------------
 net/batman-adv/types.h             |    8 +-
 2 files changed, 736 insertions(+), 372 deletions(-)
---
base-commit: f3c33e7fcb7e88cc099b783faf26f0494b774571
change-id: 20260730-tt-fixes-fca2b722ebbd

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

