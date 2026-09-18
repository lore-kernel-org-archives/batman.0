Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CD5C982D7
	for <batman-adv@archiver.kernel.org>; Fri, 18 Sep 2026 22:56:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7452684182
	for <batman-adv@archiver.kernel.org>; Sat, 19 Sep 2026 00:56:10 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789772170;
 b=Ubb/dGkGYmJVE3sag2NbKkTc9ubIYkx1vnmDUW5W30m39lhyBF0vC0UXx9Rk419KCR6CK
 Q9zbmVxzekTvPvCIXIZYkeulxdBEd6A5Cbm3Jbu4wIV3S0sRh6plhMmZrs4n+6uKYlbenBW
 NLxe/9e3Zi4bSMcEK2Td2FP/6DWWpzM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789772170; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=n0JDRUm9FmYG7coXioGGTpyYC7qcqjdo1PcM01E2X1E=;
 b=GYdyqI4rCmj2DNRQ5fUKRkwLlqQVO2NiYVGRVH7uc5Gg/b06dgHxd6iGFcR//8F8X0gyu
 UMF0jOR0feU5mk2/WB2yDoD9vJsWhhfqIx8gYpAKdbT8vEwQLCxmQjHFoi2li9h0fbZiYrU
 9qcou4EaJ5rNLXRPvHMcQQgkGXzf92A=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D954381233
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 19 Sep 2026 00:55:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1789772160;
	b=f5J0aOOCPcF1XcVxiVfCEy9oOF4uXG9h+ALsAvhslEVwDgbCTuLxRJpkrmM+Qn+oUp7H11
	mxJGJaFwQxXY8OX/qFgPQNLfw2jvgo/y98PNldx/M+og7Br+JwoUfO0hDIliNIx/uodACV
	w8pN7T+4cYEz38U75CsxbJO+H6gVp5g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789772160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n0JDRUm9FmYG7coXioGGTpyYC7qcqjdo1PcM01E2X1E=;
	b=MkdiB17q33kdEkQplcuouOBtGGIYsh+/yLBquXvDyiQUpr93gKJYBi6snCmJbHVwCQ62qB
	emNe/nuccHL7KFBW4vbnoK1d730d64RAdsITrUMWSe8X2U9pWBnJfF2lCXas7m19zI4rUz
	l59o4BFlf7r9u4Agz28tQ9LtHYrkAVE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BFCC028731;
	Sat, 19 Sep 2026 00:55:58 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [batadv,v10 0/2] batman-adv: increase DAT DHT timeout
Date: Sat, 19 Sep 2026 00:55:46 +0200
Message-ID: <20260918225549.31315-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: EHUCCCIU5OVXLSIKF5T3QGK4P5BELUMO
X-Message-ID-Hash: EHUCCCIU5OVXLSIKF5T3QGK4P5BELUMO
X-MailFrom: linus.luessing@c0d3.blue
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EHUCCCIU5OVXLSIKF5T3QGK4P5BELUMO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This patchset increases the DAT DHT timeout to reduce the amount
of broadcasted ARP Replies.

To increase the timeout only for DAT DHT entries added via DHT-PUT but
not for any other entry in the DAT cache the DAT cache and DAT DHT
concepts are split into two separate hash tables (PATCH 1/2).

PATCH 2/2 then increases the timeout for DAT DHT entries from 5 to
30 minutes.

The motivation for this patchset is based on the observations made here:
https://www.open-mesh.org/projects/batman-adv/wiki/DAT_DHCP_Snooping

In tests at Freifunk Lübeck with ~180 mesh nodes and Gluon
this reduced the ARP broadcast overhead, measured over 7 days, as
follows:

- Total:           6677.66 bits/s -> 677.26 bits/s => -89.86%
                   11.92 pkts/s   -> 1.21 pkts/s   => -89.85%

- from gateways: 5618.02 bits/s   -> 212.28        => -96.22%
                   10.03 pkts/s   -> 0.38 pkts/s   => -96.21%

Also see graphics and a few more test details here:
- https://www.open-mesh.org/projects/batman-adv/wiki/DAT_DHCP_Snooping#Result-2

Regards,
Linus

---

Changelog v10:
- PATCH 1/3: removed, already applied
- PATCH 0/2: cover letter: removed test time period and "v5" reference
- PATCH 1/2:
  - fixed kerneldoc in batadv_dat_hash_free(),
    replaced "bat_priv" with "hash"
  - added missing kerneldoc in batadv_dat_snoop_incoming_arp_reply()
    for is_dht_put
  - rebase to current main branch:
    - adopted new bat_priv kernel doc description,
      "soft interface" -> "mesh interface"
    - adopted variable rename from soft_iface to mesh_iface

Changelog v9:
- PATCH 1/3:
  - fixed typo in a comment: ENOENT -> ENONET

Changelog v8:
- PATCH 1/3:
  - fixing / cleaning up includes
  - fixing function kernel doc titles
  - fixing bugs introduced in v7 in the error handling of
    batadv_orig_dump() and batadv_neigh_dump(), using a goto
    pattern with more explicit labels

Changelog v7:
- adding PATCH 1/3 to add the batadv_netlink_get_softif() wrapper to
  reduce the amount of duplicate code, both in the current code base
  but also for the next PATCH 2/3

Changelog v6:
- removed renaming+deprecation of BATADV_P_DAT_CACHE_REPLY in PATCH 1/2
- small commit message rewording in PATCH 1/2

Changelog v5:
- rebased to current main branch
  -> removed now obsolete debugfs code

Changelog v4:
- rebased to: acfc9a214d01695
  ("batman-adv: genetlink: make policy common to family")

Changelog v3:

formerly:
 "batman-adv: Increase purge timeout on DAT DHT candidates"
 https://patchwork.open-mesh.org/patch/17728/
- fixed the potential jiffies overflow and jiffies initialization
  issues by replacing the last_dht_update timeout variable with
  a split of DAT cache and DAT DHT into two separate hash tables
  -> instead of maintaining two timeouts in one DAT entry two DAT
     entries are created and maintained in their respective DAT
     cache and DAT DHT hash tables

Changelog v2:

formerly:
 "batman-adv: Increase DHCP snooped DAT entry purge timeout in DHT"
 (https://patchwork.open-mesh.org/patch/17364/)
- removed the extended timeouts flag in the DHT-PUT messages introduced
  in v1 again
- removed DHCP dependency

Linus Lüssing (2):
  batman-adv: split DAT cache into DAT cache and DAT DHT
  batman-adv: increase DAT DHT timeout

 include/uapi/linux/batman_adv.h        |   5 +
 net/batman-adv/distributed-arp-table.c | 337 +++++++++++++++++++------
 net/batman-adv/distributed-arp-table.h |  13 +-
 net/batman-adv/main.h                  |   3 +-
 net/batman-adv/netlink.c               |   5 +
 net/batman-adv/routing.c               |   7 +-
 net/batman-adv/types.h                 |   7 +-
 7 files changed, 288 insertions(+), 89 deletions(-)

-- 
2.55.0

