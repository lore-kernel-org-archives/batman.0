Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88856CD8C8C
	for <batman-adv@archiver.kernel.org>; Sun,  7 Jun 2026 11:58:39 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 2C227808AE
	for <batman-adv@archiver.kernel.org>; Sun, 07 Jun 2026 13:58:38 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1780833518;
 b=bNoQ3gtVNgwo3cgseT+GkWvNmvt4ShAJCOovwqnQLGpDTs4925QsczStW91/r+mWzaPpo
 UUPAyIGKv4BoV5Gtuaymh+c0i593JQU7SOnoyoW4HOnSZ7+LTRfJCAw/z/5Wq4AQtL4WGbE
 WkOYkaAI8YehAoXVT2yL2wQI/SqxZag=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1780833518; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Fk19Py/rv2T5DWrlh1lXQ3FKfVoClL8SaSYNWkFdpEo=;
 b=aK91uybl4iFpGhRry2xSjpPrzO1KGhJD/Kb9vx+41CWPXKUyPRqfuNBg+RsaaZMbzP2au
 1hvb+fO1iXeCJVh6Y42H8olbtiQhaDQZ45XmMSbjTleCw/J/+P+GJ3y7iobHZ7bB2pGCXpK
 o9KrYBz9KyDVJpmRdxAtQrq1jZZRrEY=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 13C85842D4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 07 Jun 2026 13:54:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1780833283;
	b=28RrhiXTcX40k434ghi9WLlUHmQB1JcshaefMhfLn/TMqhemCQb+2dPNpu9/cWYnYBiacB
	D1C2htr8KMbMVnoCXvzjyEO0le1gCGWJMH1sqmmJ4U7YPe3TKwDtx89SURDoUaVwLDquoo
	j5Nc62bNdzfwjm1xoFYaJl/Z7RpHPQo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=J59GDobK;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1780833283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Fk19Py/rv2T5DWrlh1lXQ3FKfVoClL8SaSYNWkFdpEo=;
	b=ZZYXDHE2QYmNsfkgvyNVNQffMce6nsDt+4bgvegW2PAi2TqIxnrJTSPaBHqi1CXmkQH8vt
	7ig7sSJeutFUS6pYEiZTOS2eF0Z6QRVgjyA8GnUT/jM4MlFxLGOTye79P0tFc7maPXiQrI
	zdmzByP13Snvj22EljBQo48uDgtlpKg=
Received: by dvalin.narfation.org (Postfix) id 103051FDF9;
	Sun, 07 Jun 2026 11:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780833271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Fk19Py/rv2T5DWrlh1lXQ3FKfVoClL8SaSYNWkFdpEo=;
	b=J59GDobKcnLTnlNCfy4KI+DX6QzfLnu1RmZ3xS1QdUmQAEmgrZGtOvvoUCdnQOfQ+aEb9G
	0CAc/OOWO+MuMJv7KrBdYFM92hzyY1K4YqfCxWfWVjXiUMkmOOkgCOMnH3k3BP6jWD15Nv
	4cZIncOUf/Rue31I/TjWlKMICD+q4ew=
From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH RFC batadv v4 0/7] batman-adv: drop global hard interface
 list
Date: Sun, 07 Jun 2026 13:53:54 +0200
Message-Id: <20260607-drop-hardif-list-v4-0-ade2931db295@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANJbJWoC/22QwU7DMBBEf6XyGUeOHccOp0pIfABXxGFj7zaua
 FLZbgSq8u845oKA4+xq38zsnSWMARN7PNxZxDWksMxFdA8H5iaYT8iDL5pJIXuhVct9XK58gug
 D8feQMh8d2VZ66AfvWTm7RqTwUZGv7OX5aZ+NkMGv7O17nW7jGV3esfuS4nLheYoI1UmMste6A
 0LQUigrBQFS62nsBgtktFIwjNo3relMb40WXXMKubkkNwUijMfbHFaMCTmBy0v8bGbMu9FU4hZ
 Zu66y5qu1eqH+1lolF1yTGaxsHSiljjNEglz+0yzxVLus6iek+weiCgSFJ7DO+F7I35Bt274An
 he/kYMBAAA=
X-Change-ID: 20260531-drop-hardif-list-bcf812da69dd
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>,
 Nora Schiffer <neocturne@universe-factory.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4148; i=sven@narfation.org;
 h=from:subject:message-id; bh=HPv1hUNuWeA/HsT3oSmD9BC81w8/E5BFHc7p9QU7xMM=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFmq0TfrJh5p7SwwO7V/w+EXJ8qN9/TMLdeKd36T9OZsU
 h/TsTP7O0pZGMS4GGTFFFn2XMk/v5n9rfznaR+PwsxhZQIZwsDFKQAT6X7NyPB3RYt91fWavh32
 kwPDFH+VSLzb2mNSbbnn16ofVz9VemkxMlyYMUVw5u1mB1GfJIvd4bXlosznC9Ksus4ekLHgamv
 N5gYA
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: NZVO5MSUFLFY2DUPSYBC6PTDOIKDUSUV
X-Message-ID-Hash: NZVO5MSUFLFY2DUPSYBC6PTDOIKDUSUV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NZVO5MSUFLFY2DUPSYBC6PTDOIKDUSUV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The global hard interface list was used in the past to provide and sysfs
(debugfs, procfs) based configuration interface. This requirement is gone
after it was switched to generic netlink and NETLINK_ROUTE. And after the
wifi-flags cache was introduced, it is also no longer used to get
non-batman-adv attached interface information (for ap_isolation and
re-broadcast configuration).

But this odd net_devices list (batadv_hardif_list) stayed and caused some
headaches:

* memory requirement increased (useless) for each network interface of the
  system
* massive increase of various ethernet operations due to the O(n) nature of
  this global list
* the code had to handle switch of a batadv_hard_iface from one mesh_iface
  to either NULL or a different mesh_iface

Just get rid of it now and start to simplify the code around it.

This RFC is on purpose not Signed-off-by because I just want to restart the
discussion but didn't discuss this with the original author (nor documented
the changes in each patch in detail). And it is also not meant to look like
I've reviewed the changes and Ack it - this is unfortunately something
which I have to do again with this rebased version.

I will later post an range-diff which contains all the changes.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Changes in v4:
- rebase
- don't double-netdev_put in batadv_hardif_enable_interface() error path
  (just let batadv_hardif_put()/batadv_hardif_release() deal with it)
- add patches which cleanup the code after batadv_hard_iface->mesh_iface
  became immutable
- Link to v3: https://patch.msgid.link/20260604-drop-hardif-list-v3-0-e0dfa8c7d602@narfation.org

Changes in v3:
- fix return kernel-doc for batadv_hardif_enable_interface
- drop merged first patch
- really switch to RFC
- in merged batadv_hardif_enable_interface (as intermediate step), only add
  the hard_iface to the batadv_hardif_list when hard_iface is really
  initialized
  + this list is dropped anyway with the patch "remove global hardif list"
- stop setting "mesh_iface" to NULL on error. it is now only important that
  the hard_iface gets unlinked from the mesh_iface
- first drop the batadv_hardif_list before removing the "safety" state
  BATADV_IF_NOT_IN_USE
- Link to v2: https://patch.msgid.link/20260603-drop-hardif-list-v2-0-5f79821ca333@narfation.org

Changes in v2:
- rebased
- submit as RFC to get the discussion started again
- drop already merged "batman-adv: store hard_iface as iflink private data"
- switch from kzalloc to kzalloc_obj
- update author's mail and name
- fix reference counting for batman_adv_ptype
- Link to v1: https://patch.msgid.link/0b26554afea5203820faef1dfb498af7533a9b5d.1747687504.git.mschiffer@universe-factory.net

---
Nora Schiffer (4):
      batman-adv: only create hardif while a netdev is part of a mesh
      batman-adv: remove global hardif list
      batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
      batman-adv: move hardif generation counter into batadv_priv

Sven Eckelmann (3):
      batman-adv: drop NULL check for immutable hardif->mesh_iface
      Revert "batman-adv: v: stop OGMv2 on disabled interface"
      batman-adv: iv: drop migration check for batadv_hard_iface

 net/batman-adv/bat_iv_ogm.c            |   8 +-
 net/batman-adv/bat_v_elp.c             |   9 +-
 net/batman-adv/bat_v_ogm.c             |  33 +++----
 net/batman-adv/bridge_loop_avoidance.c |   9 +-
 net/batman-adv/hard-interface.c        | 155 +++++++++++----------------------
 net/batman-adv/hard-interface.h        |  10 +--
 net/batman-adv/main.c                  |   9 --
 net/batman-adv/main.h                  |   3 -
 net/batman-adv/mesh-interface.c        |  13 +--
 net/batman-adv/netlink.c               |   4 +-
 net/batman-adv/originator.c            |   4 -
 net/batman-adv/types.h                 |   6 +-
 12 files changed, 75 insertions(+), 188 deletions(-)
---
base-commit: 385b248dd4e46c4ce022adeb1b13e547d1954901
change-id: 20260531-drop-hardif-list-bcf812da69dd

Best regards,
--  
Sven Eckelmann <sven@narfation.org>

