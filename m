Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F7EE77188
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 13:18:04 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4593E84047
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 14:18:03 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735996683;
 b=WGVKx3KWqhJvVYRfTtuRtLLCBy8yVSC6l1Ga6jxkm5JBTTOnRGbRTIe8RzNXVV1kUs5Jv
 vt6HXjE4rIxxQhjCRhn53Lv//2Dozftbed0fhYLZd0Qp6EBI1YyGY2v440kmB5iyO8Qdm3r
 tbGxjTzsUCjZ3S7b1Dwk20HQ+vsf7Zw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735996683; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=utMz9TCdnLzB+35RCtS5XbaQfGf7lVYnJhgTvLhC8qc=;
 b=F9oYXBuiwTvf7my7xmgIrU7hGbeymncz1h85yzZxFdMlHU73tpZhfm1po+lry6PI7uflR
 aK2L4JmuvoWXpyrTwmrTsx9Pdv37s5kL/Lq4I9qvlNOZJLqvKNc1WbvU6xlxebeBgEZCq9p
 aOJIFyShEBA14lRr1ITaJBzdra5wxZU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 010E580CE3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 13:57:47 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735995468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=utMz9TCdnLzB+35RCtS5XbaQfGf7lVYnJhgTvLhC8qc=;
	b=J43YMnpK9tp5pSeOjmR4pnNAw659KclVw6LjDL+XQnzJNXjiuizHCbb2q3kgMxdV75XwSE
	iGAksAamwj9+/eY0ZyhDRXsCa6RevpwSqV3aTEy2P9xRX9Z+iXHxO++2IKtvLF+jAVj+0w
	lQo8La6K59bLTYvIt6ntC5SzfVG6R0o=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=fUEaim7p;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::630 as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735995468; a=rsa-sha256;
	cv=none;
	b=wBGaqqKzzSa0/YEZZ9HTvtmOAqN1AR4Pb/Bi0IHI/A56XHnvK49G9gaVeeZ2NJqNZUrlJ0
	pqRocAIagApL4UUbJtcpY1+R5V5hyNv4ePjdLYyQAWr8GOzZSsu+ZKghtHu22Zar7R00gS
	ODyFwa3eqdSG6prga5OMxzAbmIt4hHA=
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2161eb95317so188669765ad.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 04 Jan 2025 04:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995466; x=1736600266;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=utMz9TCdnLzB+35RCtS5XbaQfGf7lVYnJhgTvLhC8qc=;
        b=fUEaim7pf5NeMPGyUO6oKiFiSrfG0xonD3lC61kNcopwKeeN8Pw9xZgzmfuir/LQVW
         SqtP7rPfdrQD2Qg8geTxEzzE/Ibnig5iMZ61htyaMh2qSYDEgGplNVRdiP4vlo55ppPf
         oW76kKO72fkxIKweKkNS+BWrVAeN29j3sLKi3oa5pxXXNKJGOrpqc50DSlsCQk5mRgjR
         m23F9l1taiAcgmDteH3pK3DSPQw6JVG5Zf432boLy5v++QaHuQKCkiIqdM8+hjv/NbcX
         1S6MOGmlXrHgxbdor7fgf53bEQXT0umlUZBdDju4mnX3tYZXOyUefedxHxgIJWE2aoIh
         b+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995466; x=1736600266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utMz9TCdnLzB+35RCtS5XbaQfGf7lVYnJhgTvLhC8qc=;
        b=uBsJYWKxuMbRJfqf2Lohmzub7JUr8daAgMWO1kKdLZsyzDR1O6w/iRkACfBBlvCXbE
         uhdT63vcrIIs6bqArAT8ue1cDExRzPvRZ3xSnYyEsM4UJldh7zXy2yvuhatvOhpy2BWG
         mCoct7XBKaBqTDolk3g7Vj8hKMj746Ho7LAfGLzUKCgz9E8RapTH2swu8Zt/1AGX/EGZ
         0wFcr/xxrapu/l0ZzOGMcwnyzahNdxcLK3jostKjWBAeHH25ucGUwCYD793AF5Qnu9hh
         1qcrPaOMJUVjL4ejwGOZWecU0YaCfC6U3xyp8kqtK/rlK6SUJ6HZFC3FQwkMdb5SQZhj
         t0qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs+jCjQjX/fgu6yc2PoGFQ4ZtN6Sijvw50VtMdpDkD0XWW2WLhahWwixSwNnRoZu/4f/BGoPTHDn+zEA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxroWUIsjG+LvrvWGscXbKyh7VWCnUr0ldnlVOQ0lFo9HufsbXf
	sxyuLpPgjlBWFQ3mVeMQ1VJWH7FSjpcfVyHP8F/aSS573AcR0K5o
X-Gm-Gg: ASbGnctcawQS3DBS2/2BEj9ufUgNZjXYr+j7YMIVfdfBlpX6i1rFlPc8JcdYccp4RYH
	RY6GHqeSAZt7txN2ReReq49yU51/1AZyxvcifYqJf774P9seYzSOkcP89ESRJVPXVIIf1+DXx6K
	Jy5M3/C611BqxXpfoQ0Akdfm8XSs0XPW6/4ZYPtaRCbD06+ejOMrCK0DVAAFvbwgiGlUsT19I0U
	wrn5UCyJzlkFJQhg0boUrmjD80CHWX+PfxMuUtpY4LsTTo=
X-Google-Smtp-Source: 
 AGHT+IGcOHb1dyLQmVkG8bow/TLK/QHadko/AX65rHfAErCpy6bKIwin2B23ApYOFwq4e4AHjEiARA==
X-Received: by 2002:a05:6a00:3a02:b0:724:bf30:147d with SMTP id
 d2e1a72fcca58-72abddb20cfmr61551219b3a.11.1735995466219;
        Sat, 04 Jan 2025 04:57:46 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:57:45 -0800 (PST)
From: Xiao Liang <shaw.leon@gmail.com>
To: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
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
Subject: [PATCH net-next v7 00/11] net: Improve netns handling in rtnetlink
Date: Sat,  4 Jan 2025 20:57:21 +0800
Message-ID: <20250104125732.17335-1-shaw.leon@gmail.com>
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
Message-ID-Hash: J232IHXUEY6TX26MQMTGANIUPMN7UTKH
X-Message-ID-Hash: J232IHXUEY6TX26MQMTGANIUPMN7UTKH
X-Mailman-Approved-At: Sat, 04 Jan 2025 14:17:48 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/J232IHXUEY6TX26MQMTGANIUPMN7UTKH/>
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

---

v7:
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
 drivers/net/wwan/wwan_core.c                  |  25 +++-
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
 tools/testing/selftests/net/config            |   5 +
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/netns.py   |  18 +++
 tools/testing/selftests/net/link_netns.py     | 141 ++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh     |  10 ++
 49 files changed, 550 insertions(+), 226 deletions(-)
 create mode 100755 tools/testing/selftests/net/link_netns.py

-- 
2.47.1

