Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089F9CA5FED
	for <batman@archiver.kernel.org>; Tue,  6 Oct 2026 18:51:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4929284205
	for <batman@archiver.kernel.org>; Tue, 06 Oct 2026 20:51:02 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791312662;
 b=bglsW43oMgQZuxRRXT5if/uw4pdWLhpXjQq7lAKtYrv261q2GXyeOHhV7kCMM9hGFLVpg
 AbO/xDdyHZkEa8Csuds0JiSTC+7SmzY5BwAvk4Y6ZlH6GhRXfmc/1YuYDV74hS9h+cWlKSy
 V3jbDk5b23O9Ixt3cUNweviB0E29MmM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791312662; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=34smdi15sD2y7TaOxG7Bz/ZpdO9nnVRWQJsk7WkqkkA=;
 b=rRExhc03adVlIIL2ND1dE2TGkE1cjJAWdr+Zg0VhEupypVhOkGrtCNAdMp6vHuszxyiwJ
 g6KpmYwtQkmnP5gRPeLq5+fMtT1/xsIKCu25mUgYTh5yu/8616Xxj7rN9eKwhpnF7dKKBwQ
 lPJvNNaWVNEsV5nDRXh7Dd3H9aPYZoE=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8E5FC80C33
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 06 Oct 2026 20:50:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791312653;
	b=tQqW+QtFIY7t85jG4udC2ECxEQtgcxlHLd1ysbxj0AVJp+F9usNQENA2Da90yKpmSoJHit
	PtqI/avE7ifPSdzeuHv0L/ZwO0uGqS4REZYFU18bLCGWNKU358NySSOl/N/f8kIhUNB4u8
	Qo2XQ41LngPsfGCZ8QLKC6SKwEeAync=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791312653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=34smdi15sD2y7TaOxG7Bz/ZpdO9nnVRWQJsk7WkqkkA=;
	b=WRZ2QiOWCJvmq+t9y+XLCqWHBH8OB4mevx0GiLfqM2Y4hOV/m5dRQanvunlTd/3m7Fc2TI
	WE/z9WVRic2NQTZihAV274NU/z1Zfpv3MuwYigfTLZWCzmrTw5Ld+JHgAOBYmc2fK1xa+q
	YfLRpgVENxJT6h6AUpT12HSiTYw5chE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 64EEE23473;
	Tue, 06 Oct 2026 20:50:42 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [batadv,v14 0/5] batman-adv: increase DAT DHT timeout
Date: Tue,  6 Oct 2026 20:50:31 +0200
Message-ID: <20261006185037.27163-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: FOYV633YTPPOMRCP4YMXMHQY5NJIJZ4N
X-Message-ID-Hash: FOYV633YTPPOMRCP4YMXMHQY5NJIJZ4N
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FOYV633YTPPOMRCP4YMXMHQY5NJIJZ4N/>
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
concepts are split into two separate hash tables (PATCH 2/5).

PATCH 3/5 then increases the timeout for DAT DHT entries from 5 to
30 minutes, the main performance enhancement and goal of this patchset.

PATCH 4/5 and 5/5 are some small tweaks for a few unnecessary DHT additions
which we can now detect and avoid.

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

Changelog v14:
- PATCH 2/5:
  - remove wrong @hw_dst kerneldoc for batadv_dat_dht_get_self_reply()
    and batadv_dat_forward_dht_get()
- PATCH 5/5:
  - remove an extra newline in batadv_packet.h
  - fix compilation with DAT=n by adding the new flags
    argument to the batadv_dat_inc_counter() stub, too

Changelog v13:
- PATCH 2/5:
  - remove .validate for BATADV_CMD_GET_DAT_DHT again
  - moved BATADV_CMD_GET_DAT_DHT to end of batadv_netlink_ops

Changelog v12:
- PATCH 0/5:
  - added mentioning of PATCH 4/5 and 5/5 in the summary
- PATCH 1/5 (was: 1/4):
  - fix triggering of the "ARP request replied locally" debug message
    by changing the batadv_dat_arp_self_reply() return type from bool
    to int, ensuring to (keep) only trigger(ing) it when netif_rx()'ing
- PATCH 2/5 (was: 2/4):
  - consistently use a "cands" variable name for the candidate array
    instead of sometimes calling it "cand", sometimes "cands"
  - add missing kerneldoc for batadv_dat_forward_data()'s "cands"
    function argument
  - renaming batadv_dat_check_self_candidate() to
    batadv_dat_cmp_self_candidate()
  - fix unprivileged DAT_DHT netlink usage
  - add netlink .validate (and .resv_start_op for compat) for
    uniform netlink ops
  - adjust batadv_dat_dht_get_self_reply() to new
    batadv_dat_arp_self_reply() int return type
    (also avoiding an automatic type conversion from int
     to bool by that)
  - fix memory leak / missing orig_node put in
    batadv_dat_forward_dht_get() if one self is a
    candidate, move orig-node put from batadv_dat_forward_data()
    to separate batadv_dat_candidates_free() function, called
    later
  - revert "update local DHT on DHCP ACKs received via DHT_PUTs, too"
    from v11 as we never send DHT_PUT messages with a DHCP payload,
    sashiko.dev seems to have missed that these are always ARP Replies
- PATCH 3/5 (was: 3/4): unchanged
- PATCH 4/5 (was: 4/4): unchanged
- PATCH 5/5: NEW, avoid superfluous DAT DHT_PUT additions to local DAT

Changelog v11:
- PATCH 1/4: NEW, simple restructuring in preparation for 2/4
             (no functional change)
- PATCH 2/4 (was: 1/2):
  - update local DHT on DHCP ACKs received via DHT_PUTs, too
  - added self-candidate checks (batadv_dat_check_self_candidate()):
    - update local DHT from/on own DHT_PUT if we are a DAT candidate
    - (try to) reply to own DHT_GET from own DHT first if we are a
      selected DAT candidate
- PATCH 3/4 (was 2/2): unchanged
- PATCH 4/4: NEW, avoid superfluous DAT DHT_PUT if self-candidate

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

Linus Lüssing (5):
  batman-adv: move local ARP reply code to subfunctions
  batman-adv: split DAT cache into DAT cache and DAT DHT
  batman-adv: increase DAT DHT timeout
  batman-adv: avoid superfluous DAT DHT_PUT if self-candidate
  batman-adv: avoid superfluous DAT DHT_PUT additions to local DAT

 include/uapi/linux/batadv_packet.h     |  16 +-
 include/uapi/linux/batman_adv.h        |   5 +
 net/batman-adv/distributed-arp-table.c | 887 ++++++++++++++++++++-----
 net/batman-adv/distributed-arp-table.h |  26 +-
 net/batman-adv/main.h                  |   3 +-
 net/batman-adv/mesh-interface.c        |   4 +
 net/batman-adv/netlink.c               |   5 +
 net/batman-adv/routing.c               |  18 +-
 net/batman-adv/send.c                  |   8 +-
 net/batman-adv/send.h                  |   3 +-
 net/batman-adv/types.h                 |  31 +-
 11 files changed, 807 insertions(+), 199 deletions(-)

-- 
2.55.0

