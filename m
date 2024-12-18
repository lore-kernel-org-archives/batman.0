Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8886EE77187
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 13:11:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B1B7B83FA4
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 14:11:57 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734527517;
 b=1WIB2hAzzCQ7c4lDTb8qjFBJrTtYEnnaTYux3eu90xhfww2s789SHznYNLLwiuctMWYnZ
 kbG5OyLnRclDB9orA2leFowu3dO8Fb4zIvDNYSwIIwQD85dbFqZDVOElWJq1R0/C012XEDw
 YJU2+V2UwgQV6U0BrWFWHsG6//Lowcc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734527517; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=6llrxywd5dEoVM0OKwihGrkHHqwNftGWmdHiygXfmj8=;
 b=eYIZwMngKNq0qWoi9tED6a9y99dx99iy5Fof0khhgxxtaIA59ehPCpbb7QoFM2Enap74r
 A8p918wjwVTq/nTzho3yhEePTpwBnfRMHBv+Q7xAc+tJogVTXvuOYFt2AhRHaD7fd1xeJWU
 7BvQfSiZtnDyRA2t4qDOZ68SO+ZNxG8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9A73E81686
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Dec 2024 14:09:26 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734527366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=6llrxywd5dEoVM0OKwihGrkHHqwNftGWmdHiygXfmj8=;
	b=Pl32XiSA9SAqD/9RzE+HY/rs8uiq/+Z9QThqmNXuNSM/cJeZr9XV0Za88H/fLpFZJ8hotX
	Vodu4o+V1qVMrBxvLBz7alGzWtalocP7i3S38AUCLjcuoGE2kilwQKjmB6YhzJc4FybGGm
	hFB6qY1wGq3n5YK7sB2mp1bQ3AIIBZs=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734527366; a=rsa-sha256;
	cv=none;
	b=SNI9NVwItWy1OgII5yL18uL5hxrhFu3H64qOWuQqQS1GxTGkejyqaFkJ8kQ6PSY+r5U66M
	NPrq2/2xacGK4g9AVAXkA8CNG5A/TxisKxla5Aa7mQXT6hNU/Y9nOxMyVpaKXIWD9G71W0
	Y2Jm1oGTEDpm9nO+AxUPPexzExV+0f0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=FhDDX8yz;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::434 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-72909c459c4so4537811b3a.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 18 Dec 2024 05:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527365; x=1735132165;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6llrxywd5dEoVM0OKwihGrkHHqwNftGWmdHiygXfmj8=;
        b=FhDDX8yzlzUhUc1OFIQ5ZimIJLIVCMjyL9dukgHhh8MeUyy/L6mzs5/micQBf+QKvR
         wEYXs7+PGz9AHO/TETIkiUYirYqH/OVBWDZtYLjy+84iJcJzB3vKqvzNPpo6bOuIQdc6
         W28i8PXn1DQvB3ZEknlA5eaO5nNI6CXLwAx2ozj7FwYWM0kCeGixCn55+rPkWUaPkq76
         anthF36Dg1SNZwAyXp+/G0ZDv9HbmzNDqlAyhlmwmBgnCJX3C8/GgBD8xMQKmboJrx6k
         r47NKr9lYrGMq+4wndq7Z2RwtaS+K+igQRx2OcccG7GDB8PeqghemXPncL/OomSDfVio
         HxRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527365; x=1735132165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6llrxywd5dEoVM0OKwihGrkHHqwNftGWmdHiygXfmj8=;
        b=Kd4jcvcQUXuOiWntniJckJ/yiflH4vzWcZMfXF5tLa9eGtu8CUKA7L7VQBJB338O/5
         807+Wp8cA5PchBKrfvqXoZW5nV4y1Hn7s44m1PF7uLVFPBPgl7UjAZrFhi07fXvTl2ol
         bmwq6Ybo5IS6XCICSgdMmkssz3958R/AlVD/reredQjMi0nKqkFiaBcjR6DKyNHk8+gL
         ePwStMKNooD2IMKq5VMahvbZkgNJWQfOAT51whe+3FSfldw2MexBYkgF5INNOPobbhFU
         nhzTQJE5Vy0QWxxTiEbPqA/3wDCUiRDaKzUT/LCh00igbYuS1HKq7yjWXSde7lW6bTtP
         8Vdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHFmaINeFQgph6d5i3BXr3AlqtWFlWR81HGYRTTV65lPGOdYD3G7uF9+SZWEvg7R09UWOsZUdd4cdDnw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yy7tW7M+EsoJ7Ehtls43FKxXgFx2OC75np0FkY36rfaza0x/wFh
	newIhvc3icwwBaqXUsB3T0yk3AkE29BNPLZ/j5w4nkopX0qOn/BV
X-Gm-Gg: ASbGncvOR+cah+xDdlsso18lPPkATCnPOLp0oito+CVkCLGlJtk5iluDwPoRIw8zD+s
	zKcpD34m8RCbDpZ4pi1n7L/o764Hv1X2yV0GDPPT9Phdci3hniDv0zG0eWY/bjxf7hq7ySjklLM
	dLkVpktlBsg7nWEPO8J1cBNqS6EMGXQVhrJeMKmehV5lQ9RLWeE/SkU1BZ4/3YIoSf+FuJuVwR8
	ToHn0HRfiZ/OOOWW3nUC4zhAqLO/XanUmAH9AUPgX1TcRw=
X-Google-Smtp-Source: 
 AGHT+IHxL0OHgUEQczY58g8XDBLqS8Ex4WTxtaZ2NUqH1g4R3asgqmGfw3HW/w2dfnMjfE/n2fJrPg==
X-Received: by 2002:a05:6a00:2313:b0:728:e906:e466 with SMTP id
 d2e1a72fcca58-72a8d2dc70cmr4546358b3a.21.1734527364845;
        Wed, 18 Dec 2024 05:09:24 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:09:24 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Hangbin Liu <liuhangbin@gmail.com>,
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
Subject: [PATCH net-next v6 00/11] net: Improve netns handling in rtnetlink
Date: Wed, 18 Dec 2024 21:08:58 +0800
Message-ID: <20241218130909.2173-1-shaw.leon@gmail.com>
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
Message-ID-Hash: PDPZOQIFLAIPE7INUBSWI5OTYVPX2OPI
X-Message-ID-Hash: PDPZOQIFLAIPE7INUBSWI5OTYVPX2OPI
X-Mailman-Approved-At: Wed, 18 Dec 2024 14:11:39 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PDPZOQIFLAIPE7INUBSWI5OTYVPX2OPI/>
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

Patch 01 servers for 1) to avoids link name conflict in different netns.

To achieve 2), there're mainly 3 steps:

 - Patch 02 packs newlink() parameters into a struct, including
   the original "src_net" along with more netns context.
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

---

v6:
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
  ieee802154: 6lowpan: Use link netns in newlink() of rtnl_link_ops
  net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
  net: ipv6: Use link netns in newlink() of rtnl_link_ops
  net: xfrm: Use link netns in newlink() of rtnl_link_ops
  rtnetlink: Remove "net" from newlink params
  rtnetlink: Create link directly in target net namespace
  selftests: net: Add python context manager for netns entering
  selftests: net: Add test cases for link and peer netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  |  11 +-
 drivers/net/amt.c                             |  16 +-
 drivers/net/bareudp.c                         |  11 +-
 drivers/net/bonding/bond_netlink.c            |   8 +-
 drivers/net/can/dev/netlink.c                 |   4 +-
 drivers/net/can/vxcan.c                       |   9 +-
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  11 +-
 drivers/net/geneve.c                          |  11 +-
 drivers/net/gtp.c                             |   9 +-
 drivers/net/ipvlan/ipvlan.h                   |   4 +-
 drivers/net/ipvlan/ipvlan_main.c              |  15 +-
 drivers/net/ipvlan/ipvtap.c                   |  10 +-
 drivers/net/macsec.c                          |  15 +-
 drivers/net/macvlan.c                         |   8 +-
 drivers/net/macvtap.c                         |  11 +-
 drivers/net/netkit.c                          |   9 +-
 drivers/net/pfcp.c                            |  11 +-
 drivers/net/ppp/ppp_generic.c                 |  10 +-
 drivers/net/team/team_core.c                  |   7 +-
 drivers/net/veth.c                            |   9 +-
 drivers/net/vrf.c                             |  11 +-
 drivers/net/vxlan/vxlan_core.c                |  11 +-
 drivers/net/wireguard/device.c                |  11 +-
 drivers/net/wireless/virtual/virt_wifi.c      |  14 +-
 drivers/net/wwan/wwan_core.c                  |  25 ++-
 include/net/ip_tunnels.h                      |   5 +-
 include/net/rtnetlink.h                       |  44 +++++-
 net/8021q/vlan_netlink.c                      |  15 +-
 net/batman-adv/soft-interface.c               |  16 +-
 net/bridge/br_netlink.c                       |  12 +-
 net/caif/chnl_net.c                           |   6 +-
 net/core/rtnetlink.c                          |  35 +++--
 net/hsr/hsr_netlink.c                         |  14 +-
 net/ieee802154/6lowpan/core.c                 |   9 +-
 net/ipv4/ip_gre.c                             |  27 ++--
 net/ipv4/ip_tunnel.c                          |  10 +-
 net/ipv4/ip_vti.c                             |  10 +-
 net/ipv4/ipip.c                               |  14 +-
 net/ipv6/ip6_gre.c                            |  42 ++++--
 net/ipv6/ip6_tunnel.c                         |  20 ++-
 net/ipv6/ip6_vti.c                            |  16 +-
 net/ipv6/sit.c                                |  18 ++-
 net/xfrm/xfrm_interface_core.c                |  15 +-
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/netns.py   |  18 +++
 tools/testing/selftests/net/link_netns.py     | 142 ++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh     |  10 ++
 48 files changed, 546 insertions(+), 226 deletions(-)
 create mode 100755 tools/testing/selftests/net/link_netns.py

-- 
2.47.1

