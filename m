Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81956C9830E
	for <batman-adv@archiver.kernel.org>; Fri, 25 Sep 2026 08:44:41 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A0026840FD
	for <batman-adv@archiver.kernel.org>; Fri, 25 Sep 2026 10:44:39 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1790325879;
 b=M2epK+lWFVXYhDmf2zjQSwgLennSyarq5a/1iK1XFPaTYRu/TF7eYxFEUrfHivL9vVa1Q
 WESWdUjnKpCJGuLwYeBFdddWw5B8UkZyvbSnPvLhSDHqJRGQ8KiMBCgZz9rSXZKRb6hI0li
 dE55I0hbgBxiaq4unfvjed/wqCFVSeE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1790325879; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=WpKcw9uVpzjpm8uNqjdtAhl2WWi6zfKfZIGFI6MIZdU=;
 b=tWN5Z8qKxJsfBBMKmSZQllHIUskdO+BN5j7t88+B7Xgi8HS2/g97/NJkXO6di6TPkRSUJ
 tNavl9OtzngVtvEdc6iV0eiPjW2yDY0K6DIY0K9jnZVU9C6enLdqt12SVYwDZl6/ygHjfpR
 d6B6L/XuIjRtVWiNTSkiwKS7JvStbxg=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=fail;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mail.aperture-lab.de (mail.aperture-lab.de
 [IPv6:2a01:4f8:c2c:665b::1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3136A82684
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 25 Sep 2026 10:44:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1790325870;
	b=py5Fueiim9PTe++Vq0qHK9k8s3MdezCtectJh9L9eyyAYSIwy/rZMrKWXdcloRyLmjKVwO
	Qzudb/votS7AbthpWfRCA1fyiXavc/G/1e0Bombxvg6vgNPZ/A0S6haFEKD5niGiw1Y8qb
	vo4v4uG4yW/bXexgOoCzfcRqDTAHQac=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1790325870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WpKcw9uVpzjpm8uNqjdtAhl2WWi6zfKfZIGFI6MIZdU=;
	b=y0LRv0zQt8cKtrquFSFKpMYSz0gmjY5G/obOj3sh6xevnTJOdsHPUBDNsdUeQMWMOsSWOZ
	BGustxyK86ZRHL1SbBvz+n6YlcGJWiNonASq2SW4E1W9vAydoSi2WeAU+FZolL0WeHKCe0
	4lQqIw2/GNHjINoYKw9oo+GigGU8cPU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of linus.luessing@c0d3.blue
 designates 2a01:4f8:c2c:665b::1 as permitted sender)
 smtp.mailfrom=linus.luessing@c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1AEEF233F1;
	Fri, 25 Sep 2026 10:44:17 +0200 (CEST)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [batadv,v11 0/4] batman-adv: increase DAT DHT timeout
Date: Fri, 25 Sep 2026 10:44:06 +0200
Message-ID: <20260925084410.27483-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Message-ID-Hash: LPLT6GD6UUUOGL6GVYMSZJHU2X5R3KWZ
X-Message-ID-Hash: LPLT6GD6UUUOGL6GVYMSZJHU2X5R3KWZ
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/LPLT6GD6UUUOGL6GVYMSZJHU2X5R3KWZ/>
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
concepts are split into two separate hash tables (PATCH 2/4).

PATCH 3/4 then increases the timeout for DAT DHT entries from 5 to
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

Changelog v11:
- PATCH 1/4: NEW, simple restructuring in preparation for 2/5
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

Linus Lüssing (4):
  batman-adv: move local ARP reply code to subfunctions
  batman-adv: split DAT cache into DAT cache and DAT DHT
  batman-adv: increase DAT DHT timeout
  batman-adv: avoid superfluous DAT DHT_PUT if self-candidate

 include/uapi/linux/batman_adv.h        |   5 +
 net/batman-adv/distributed-arp-table.c | 762 +++++++++++++++++++------
 net/batman-adv/distributed-arp-table.h |  19 +-
 net/batman-adv/main.h                  |   3 +-
 net/batman-adv/netlink.c               |   5 +
 net/batman-adv/routing.c               |  12 +-
 net/batman-adv/types.h                 |   7 +-
 7 files changed, 627 insertions(+), 186 deletions(-)

-- 
2.55.0

