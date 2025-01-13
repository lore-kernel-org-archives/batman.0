Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0044C02180
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 15:22:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C8167834A8
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 16:22:02 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736781722;
 b=r9Jar5rPzxGMMPpP4yx1zS6goemamchqvS+1TBzwCY1wUQc28Z0u7tE/Es9I0yl+Op0ww
 9OBERFxrpsEeuo/G1FzqaigCmXVjccoxukwjYfRGg/GvcbDvFqVzstrcz9OXzd+HgByXzAK
 at3uVqWHV1JeXCOqjxhuPtgluJ9ehh4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736781722; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=1beorUTBDb9d2ovAB2s5mK/OAF8szMbbImDZC22QQM8=;
 b=4HR5/TMp1Pv8+8fPQ4gJd3UKse/t/bXGj4h/7Gs22M7HTrhOhrygXkqrkfXvCYnfPtQh1
 d62rpaeHY0yVDWA5stZDOYVy0Xp8b+K1iX0VeORIMLdaRKbDCFSApei3s+I+9GVhUyZHvos
 hyr4tdkNgf2ilcipq2N7OEVpXWuPvQo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BB29481027
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 15:37:39 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736779060;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=1beorUTBDb9d2ovAB2s5mK/OAF8szMbbImDZC22QQM8=;
	b=mz460oZuzuAYaBqR150IUKqlcm6mc94pwbRbiegaylcSIcZiWsKvex6w8fMmL0K3KhGNsn
	lazHE04polXZvZy9k2f/bX13VAKk7052IKkQlZv1/kidEmwHF5qu22D8NtNGWKOFgMqr1o
	rytRjN1U6jgTy4i9ydRFHOA2HGr0784=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=TfagiTFh;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::635 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736779060; a=rsa-sha256;
	cv=none;
	b=rpzWgwcgoymr51NziS8kAOPzoThvicztWhCrtxah8tLZShrUn7r7Ck8MHEW5w8pwOiMi2c
	b5usi7lca3Lzvv12NfKjstWLy8FCHGpM2B1sjkIScqC/RanNOuE+kkDrLxIuZjqsyhxxBb
	idVt/AAlSkeLns8AfiMWpjbVecPmdy4=
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2166360285dso75900955ad.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 13 Jan 2025 06:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779058; x=1737383858;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1beorUTBDb9d2ovAB2s5mK/OAF8szMbbImDZC22QQM8=;
        b=TfagiTFhr64NKt4dxZuZ6xxXrKSRbwnMU9X+aZOBtntUBwS2SnHpZL+Pq45AtfEGCt
         FXVzM/Vj3YGi4zIEpG8krXjrnZKxk4siQOzpzHrtpF+pNrLCngxy5dtbQMDqKtVojy3p
         2rzk1oMlC6e4qeuUlKYUJ6cJyhx8VcYloCv+rQXudzVbHXn7RB8ybFr9BYABDPWo/XeJ
         Gthv5U/cIwm152a3DALGtUzIt4gN+qpDMZzdNKdaQlTJtUdBh7BUVmuslo7ugNQVzt5M
         6Dlb6v9QjoU/atp2aPoxY/FNCtbCBeiW5P8Kvrt+CrTTqHi3GcgqOJ/hP+5yOY12tYHO
         KttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779058; x=1737383858;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1beorUTBDb9d2ovAB2s5mK/OAF8szMbbImDZC22QQM8=;
        b=AStdnwz2+cxnu/1JRyCajN0/cFYQ94Vm2B2X7wT9treWQRWu9owY8B/t2FabSiRZ8n
         edN4h1FkyG/ujBFhHui4Vgg4RIHkabOgPk75lcQAwqxV10TbBt/I6DqiqJvMk7AyfywB
         0czIbDt/YQf0CchXd+WCKNx8KHqUHs311A8GWaqU8wB/dpYrMldtDmfR0KHTVYuGmgR/
         C+PooIf5HRVB3AoKpdwchC4+VD04QIPh04z9B0Da8MORSbpHp7fBo6o6GgXR0Qhblh2y
         AY9q9v8WgpDcHIHSTjodb8dPI13Ue7DF4gzMsUWr+UNpFpqL0BrW3YqaZRDSbN9jasBS
         QQUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVDXaONmCqd45z2ERC+nlT03MV5knAi/CwBcnE7m+s59/uX9J0F3PIJMIxua8AnGf9ditaz8OuvbCAgg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YyiIU7+VbeYtRvdvZh5gRWFn7KXDnc6CcOMQ7Z810IG56fe1cqB
	ej6V4HAqrTrpQUYklF2Xgx97iGM2z0Bz+3OYr2xDN2LRbGZw9Jru
X-Gm-Gg: ASbGnculoHCknhtHamUlC/e8l7dc0Xlh3PoIJDz0O7CxvYlOr9eRIMp40lCD8OswjQu
	X+7zRO0MvbYe4VeAhlT0jewBCwikE3pRNtPyPlX9EZrQYXIkH6Imk0dmWoQIO6SH9+P14haUvyN
	FyLdujyTEQucg9gADm2Bsb0CoOQcFXC31gdIoU42VFHBM7Nm8HBVZVRhzIOTQPVZDglI+0LRjA0
	Lvqx1RkkOy2FvxrCRAE4NU08cmgjUiIWk8EwPCKbwHG27k=
X-Google-Smtp-Source: 
 AGHT+IF50iamtynxwVleVNAyS8mxO44RNkBtHV9bN/5WAHxvooRDGqm4UnZoDFbT5fV4mFafHkIg+Q==
X-Received: by 2002:a17:903:1206:b0:216:59ed:1ab0 with SMTP id
 d9443c01a7336-21a83f5d8c3mr269255565ad.27.1736779057926;
        Mon, 13 Jan 2025 06:37:37 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:37:37 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-rdma@vger.kernel.org,
	linux-can@vger.kernel.org,
	osmocom-net-gprs@lists.osmocom.org,
	bpf@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	wireguard@lists.zx2c4.com,
	linux-wireless@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	bridge@lists.linux.dev,
	linux-wpan@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v8 00/11] net: Improve netns handling in rtnetlink
Date: Mon, 13 Jan 2025 22:37:08 +0800
Message-ID: <20250113143719.7948-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: QA64FJUJ7W4Y7UGGCX2O7CP3P55XELGW
X-Message-ID-Hash: QA64FJUJ7W4Y7UGGCX2O7CP3P55XELGW
X-Mailman-Approved-At: Mon, 13 Jan 2025 16:21:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/QA64FJUJ7W4Y7UGGCX2O7CP3P55XELGW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This patch series includes some netns-related improvements and fixes for
rtnetlink, to make link creation more intuitive:

 1) Creating link in another net namespace doesn't conflict with link
    names in current one.
 2) Refector rtnetlink link creation. Create link in target namespace
    directly.

So that

  # ip link add netns ns1 link-netns ns2 tun0 type gre ...

will create tun0 in ns1, rather than create it in ns2 and move to ns1.
And don't conflict with another interface named "tun0" in current netns.

Patch 01 serves for 1) to avoids link name conflict in different netns.

To achieve 2), there're mainly 3 steps:

 - Patch 02 packs newlink() parameters into a struct, including
   the original "src_net" along with more netns context. No semantic
   changes are introduced.
 - Patch 03 ~ 07 converts device drivers to use the explicit netns
   extracted from params.
 - Patch 08 ~ 09 removes the old netns parameter, and converts
   rtnetlink to create device in target netns directly.

Patch 10 ~ 11 adds some tests for link name and link netns.


BTW please note there're some issues found in current code:

- In amt_newlink() drivers/net/amt.c:

    amt->net = net;
    ...
    amt->stream_dev = dev_get_by_index(net, ...

  Uses net, but amt_lookup_upper_dev() only searches in dev_net.
  So the AMT device may not be properly deleted if it's in a different
  netns from lower dev.

- In gtp_newlink() in drivers/net/gtp.c:

    gtp->net = src_net;
    ...
    gn = net_generic(dev_net(dev), gtp_net_id);
    list_add_rcu(&gtp->list, &gn->gtp_dev_list);

  Uses src_net, but priv is linked to list in dev_net. So it may not be
  properly deleted on removal of link netns.

- In pfcp_newlink() in drivers/net/pfcp.c:

    pfcp->net = net;
    ...
    pn = net_generic(dev_net(dev), pfcp_net_id);
    list_add_rcu(&pfcp->list, &pn->pfcp_dev_list);

  Same as above.

- In lowpan_newlink() in net/ieee802154/6lowpan/core.c:

    wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));

  Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
  in link netns.


Kuniyuki has a patchset to address the issues of gtp and pfcp:
https://lore.kernel.org/netdev/20250110014754.33847-1-kuniyu@amazon.com/

---

v8:
 - Move dev and ext_ack out from param struct.
 - Validate link_net and dev_net are identical for 6lowpan.

v7:
 link: https://lore.kernel.org/all/20250104125732.17335-1-shaw.leon@gmail.com/
 - Add selftest kconfig.
 - Remove a duplicated test of ip6gre.

v6:
 link: https://lore.kernel.org/all/20241218130909.2173-1-shaw.leon@gmail.com/
 - Split prototype, driver and rtnetlink changes.
 - Add more tests for link netns.
 - Fix IPv6 tunnel net overwriten in ndo_init().
 - Reorder variable declarations.
 - Exclude a ip_tunnel-specific patch.

v5:
 link: https://lore.kernel.org/all/20241209140151.231257-1-shaw.leon@gmail.com/
 - Fix function doc in batman-adv.
 - Include peer_net in rtnl newlink parameters.

v4:
 link: https://lore.kernel.org/all/20241118143244.1773-1-shaw.leon@gmail.com/
 - Pack newlink() parameters to a single struct.
 - Use ynl async_msg_queue.empty() in selftest.

v3:
 link: https://lore.kernel.org/all/20241113125715.150201-1-shaw.leon@gmail.com/
 - Drop "netns_atomic" flag and module parameter. Add netns parameter to
   newlink() instead, and convert drivers accordingly.
 - Move python NetNSEnter helper to net selftest lib.

v2:
 link: https://lore.kernel.org/all/20241107133004.7469-1-shaw.leon@gmail.com/
 - Check NLM_F_EXCL to ensure only link creation is affected.
 - Add self tests for link name/ifindex conflict and notifications
   in different netns.
 - Changes in dummy driver and ynl in order to add the test case.

v1:
 link: https://lore.kernel.org/all/20241023023146.372653-1-shaw.leon@gmail.com/



Xiao Liang (11):
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Pack newlink() params into struct
  net: Use link netns in newlink() of rtnl_link_ops
  ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
  net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
  net: ipv6: Use link netns in newlink() of rtnl_link_ops
  net: xfrm: Use link netns in newlink() of rtnl_link_ops
  rtnetlink: Remove "net" from newlink params
  rtnetlink: Create link directly in target net namespace
  selftests: net: Add python context manager for netns entering
  selftests: net: Add test cases for link and peer netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  |   9 +-
 drivers/net/amt.c                             |  11 +-
 drivers/net/bareudp.c                         |   9 +-
 drivers/net/bonding/bond_netlink.c            |   6 +-
 drivers/net/can/dev/netlink.c                 |   4 +-
 drivers/net/can/vxcan.c                       |   7 +-
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |   9 +-
 drivers/net/geneve.c                          |   9 +-
 drivers/net/gtp.c                             |   8 +-
 drivers/net/ipvlan/ipvlan.h                   |   3 +-
 drivers/net/ipvlan/ipvlan_main.c              |   8 +-
 drivers/net/ipvlan/ipvtap.c                   |   6 +-
 drivers/net/macsec.c                          |   9 +-
 drivers/net/macvlan.c                         |   7 +-
 drivers/net/macvtap.c                         |   7 +-
 drivers/net/netkit.c                          |   7 +-
 drivers/net/pfcp.c                            |   7 +-
 drivers/net/ppp/ppp_generic.c                 |   9 +-
 drivers/net/team/team_core.c                  |   6 +-
 drivers/net/veth.c                            |   7 +-
 drivers/net/vrf.c                             |   5 +-
 drivers/net/vxlan/vxlan_core.c                |   9 +-
 drivers/net/wireguard/device.c                |   7 +-
 drivers/net/wireless/virtual/virt_wifi.c      |   8 +-
 drivers/net/wwan/wwan_core.c                  |  16 +-
 include/net/ip_tunnels.h                      |   5 +-
 include/net/rtnetlink.h                       |  40 ++++-
 net/8021q/vlan_netlink.c                      |   9 +-
 net/batman-adv/soft-interface.c               |   9 +-
 net/bridge/br_netlink.c                       |   6 +-
 net/caif/chnl_net.c                           |   5 +-
 net/core/rtnetlink.c                          |  33 ++--
 net/hsr/hsr_netlink.c                         |  12 +-
 net/ieee802154/6lowpan/core.c                 |   7 +-
 net/ipv4/ip_gre.c                             |  24 ++-
 net/ipv4/ip_tunnel.c                          |  10 +-
 net/ipv4/ip_vti.c                             |   9 +-
 net/ipv4/ipip.c                               |   9 +-
 net/ipv6/ip6_gre.c                            |  30 ++--
 net/ipv6/ip6_tunnel.c                         |  19 ++-
 net/ipv6/ip6_vti.c                            |  15 +-
 net/ipv6/sit.c                                |  17 ++-
 net/xfrm/xfrm_interface_core.c                |  15 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   5 +
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/netns.py   |  18 +++
 tools/testing/selftests/net/link_netns.py     | 141 ++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh     |  10 ++
 49 files changed, 479 insertions(+), 165 deletions(-)
 create mode 100755 tools/testing/selftests/net/link_netns.py

-- 
2.47.1

