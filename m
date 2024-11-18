Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C077D4921D
	for <batman-adv@archiver.kernel.org>; Mon, 18 Nov 2024 14:46:25 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B6B0183E74
	for <batman-adv@archiver.kernel.org>; Mon, 18 Nov 2024 15:46:23 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731941183;
 b=4NLiFm1ANGfooQC4z2HvgscRE370MgJtCuzOkj1DQ01lz+LQKFgysA5UzS5kdSg1bBIdb
 YcHNMZilSJM3SDPz5F2ZaYNJIpGq/Jt43ziYTdrOPje55BaTfnMyrpDPGxnqzPq1XWYBElV
 dUFiUyF0iHslOgqVfGD1+ZRoXA7w6i4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731941183; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=hNYrzSG3D47KB6oeOVj5/5Bj4MnSM/SMkHnb6rGgzb8=;
 b=FLxfnJ4BtDu7lPDkYB/0sxSM2D/p2WDt+xjzjvAHzVR6TOeJu784AMbTBFrLwPk0Wb5cS
 0Qg+ByU0XSyNXYze+jHKt0Y9m37HsNMvBzoaVOvZKS6rfBAmbv4OVCN+1PDaK1LpgcUQ4LN
 kra7LXod1bjSLz+zLBF4gBKEZpuakq0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0E08781EEB
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 18 Nov 2024 15:33:15 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731940396; a=rsa-sha256;
	cv=none;
	b=IvtH4/R0pGivUrVLRZYTUf9vOOL9lAXUfy7C8ScFKJRIFVG1bDRxNyC9thTxFZzp6k6Yuw
	NxIszlV1M30ewJAdPmK4w11fi7bO++p8ODkmIx7TGHcLOdSr8DaLuH6kzr6lbhSWd3PJB/
	CCJhFxyEjBaT/OdAS8pFCnS6P/CxpfU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=iNW7vlre;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::1031 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731940396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=hNYrzSG3D47KB6oeOVj5/5Bj4MnSM/SMkHnb6rGgzb8=;
	b=vuCKtf9yMcKGthiOsV41HNmQFQX0u2s8j2/p5PVCF3VfL3XI1BLk/3IC74bRiBQo1inWd8
	a0rOhbSCOvyTEC+vje9fBiHpQFHhDH8G6vel4JRSxQukAI8RUWoNLX/v+LCEvWkIHDCNVM
	N9uGfO3WXWQx+fILe3fLeh5FHHNmm90=
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ea78d164b3so833022a91.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 18 Nov 2024 06:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940394; x=1732545194;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hNYrzSG3D47KB6oeOVj5/5Bj4MnSM/SMkHnb6rGgzb8=;
        b=iNW7vlrez7CcmJIcOdBR/tWr7VQK2JNXzhR4ND9wG2K0YcNFOT+6C+D7VBQdwaeL3/
         ZTw9kLrzUwWWCOR9EQAJa2yPo3JdIvDb0q2bZZzp0pYz2EIxZmmLn74sIIv7ssBJCnbf
         zTX8cvBoWl40lTXDi4kUvmNtOzDXuy91aK1lzkUP9ULCsru+u1trOJ2uAm89I0xzS9KD
         KtXYsSedYkLaaxD4ncj8kVw/3r2T1BbyiEOwu7iR+uMwMWh9fJn8M0Oyux2Hq7x2suYT
         IBaRBNrr3GKRFhyHKtpiBvYW2kAVlo47I7pBx3sELi81WOJ9p9MFz9cfB151vovc9JV6
         /b/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940394; x=1732545194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hNYrzSG3D47KB6oeOVj5/5Bj4MnSM/SMkHnb6rGgzb8=;
        b=iHj6Pef2fUADRq0naEVil9ToBqws28VPIwj7azKZBYTeAWXgfCOOaZ4WCN8woGQIrY
         OM55H4dlti6IKM/m31XoUoX3dqafrC6AwKcbuSoAzx+Q1GbUA0iQ44m1enSkLsTETymQ
         j8BOvlE9wb6eWT1bscblLhDkfZihUAnjFIMkRjx0INDBiXc12u8OhmSdkMSlY5pliPYW
         d4owMMjMN30ZguKSlyjrmT4675AwUdOnUcj6lkOGLleWKVieVeccANtm/PyLX/9CKlE3
         khm+EuX/qCARAc2S2ZGI3HtwJ9owuOwlR8LUUkr4JfVYtRbQYE3Ih8wiKPdophkztejG
         cejA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXONPankSn7J6teaWuIZGnT5OOUcsUgEpU3K0cFsUPV1FI7/IZR76KbLgoxcLI/ro70SNb0zTPYbPKGWg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzVre6jrWbJpm06ElBwUnrKIX1tmMh3MqmmcRPqaUVCp0S/bF4x
	KZl/MGjRwV1AQefI0kLEEaWQe2o/l/qB/2YhkjZnrWQNogsP69Mu
X-Google-Smtp-Source: 
 AGHT+IEgW/YjRV6I5AmJ/mBzBZGEWBcDxNEAGQpANYhMnRAlvyIjyPQThvC+SjMr0Xf12bRSa0kQgg==
X-Received: by 2002:a17:90b:52c6:b0:2ea:5dcf:6f74 with SMTP id
 98e67ed59e1d1-2ea5dcf7122mr6227597a91.3.1731940393805;
        Mon, 18 Nov 2024 06:33:13 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:13 -0800 (PST)
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
Subject: [PATCH net-next v4 0/5] net: Improve netns handling in RTNL and
 ip_tunnel
Date: Mon, 18 Nov 2024 22:32:39 +0800
Message-ID: <20241118143244.1773-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: VHSHK52C4MEGXWKHUDXMIMTLYZNW26XV
X-Message-ID-Hash: VHSHK52C4MEGXWKHUDXMIMTLYZNW26XV
X-Mailman-Approved-At: Mon, 18 Nov 2024 15:46:12 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VHSHK52C4MEGXWKHUDXMIMTLYZNW26XV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This patch series includes some netns-related improvements and fixes for
RTNL and ip_tunnel, to make link creation more intuitive:

 - Creating link in another net namespace doesn't conflict with link names
   in current one.
 - Refector rtnetlink link creation. Create link in target namespace
   directly. Pass both source and link netns to drivers via newlink()
   callback.

So that

  # ip link add netns ns1 link-netns ns2 tun0 type gre ...

will create tun0 in ns1, rather than create it in ns2 and move to ns1.
And don't conflict with another interface named "tun0" in current netns.

---

v4:
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


Xiao Liang (5):
  net: ip_tunnel: Build flow in underlay net namespace
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Decouple net namespaces in rtnl_newlink_create()
  selftests: net: Add python context manager for netns entering
  selftests: net: Add two test cases for link netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  | 11 ++++--
 drivers/net/amt.c                             | 13 ++++---
 drivers/net/bareudp.c                         | 11 ++++--
 drivers/net/bonding/bond_netlink.c            |  8 ++--
 drivers/net/can/dev/netlink.c                 |  4 +-
 drivers/net/can/vxcan.c                       | 11 ++++--
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 11 ++++--
 drivers/net/geneve.c                          | 11 ++++--
 drivers/net/gtp.c                             |  9 +++--
 drivers/net/ipvlan/ipvlan.h                   |  4 +-
 drivers/net/ipvlan/ipvlan_main.c              | 11 ++++--
 drivers/net/ipvlan/ipvtap.c                   |  7 ++--
 drivers/net/macsec.c                          | 11 ++++--
 drivers/net/macvlan.c                         |  8 ++--
 drivers/net/macvtap.c                         |  8 ++--
 drivers/net/netkit.c                          | 11 ++++--
 drivers/net/pfcp.c                            |  8 ++--
 drivers/net/ppp/ppp_generic.c                 | 10 +++--
 drivers/net/team/team_core.c                  |  7 ++--
 drivers/net/veth.c                            | 11 ++++--
 drivers/net/vrf.c                             |  7 ++--
 drivers/net/vxlan/vxlan_core.c                | 11 ++++--
 drivers/net/wireguard/device.c                |  8 ++--
 drivers/net/wireless/virtual/virt_wifi.c      | 10 +++--
 drivers/net/wwan/wwan_core.c                  | 15 +++++--
 include/net/ip_tunnels.h                      |  5 ++-
 include/net/rtnetlink.h                       | 34 +++++++++++++---
 net/8021q/vlan_netlink.c                      | 11 ++++--
 net/batman-adv/soft-interface.c               |  8 ++--
 net/bridge/br_netlink.c                       |  8 ++--
 net/caif/chnl_net.c                           |  6 +--
 net/core/rtnetlink.c                          | 29 +++++++++-----
 net/hsr/hsr_netlink.c                         | 14 ++++---
 net/ieee802154/6lowpan/core.c                 |  9 +++--
 net/ipv4/ip_gre.c                             | 27 ++++++++-----
 net/ipv4/ip_tunnel.c                          | 16 ++++----
 net/ipv4/ip_vti.c                             | 10 +++--
 net/ipv4/ipip.c                               | 10 +++--
 net/ipv6/ip6_gre.c                            | 28 +++++++------
 net/ipv6/ip6_tunnel.c                         | 16 ++++----
 net/ipv6/ip6_vti.c                            | 15 ++++---
 net/ipv6/sit.c                                | 16 ++++----
 net/xfrm/xfrm_interface_core.c                | 14 +++----
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/netns.py   | 18 +++++++++
 tools/testing/selftests/net/netns-name.sh     | 10 +++++
 tools/testing/selftests/net/netns_atomic.py   | 39 +++++++++++++++++++
 48 files changed, 377 insertions(+), 205 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

-- 
2.47.0

