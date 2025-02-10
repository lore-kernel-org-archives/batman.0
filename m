Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B4EC02198
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 13:36:21 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9937B840E8
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 14:36:19 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739194579;
 b=x8vPGeg0gkT/NHCdbOdOueC9gtJKlIeHb4ogTa1uyZ1+xu8YFSdeXvcqIzP9l98oSMTEA
 m+jwCEUgZxa8ftNuHcKU7NUUOnkTLTQIJH9gUDL3bsFWLDG7sAs24KaGMFrr5mc2172hxL3
 eusGjudPZVW7OvrCPmAdAkB3ZkNDeO0=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739194579; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Y0kuY/qnmLWcTpq+Gs4oe5wYG4aWX3Vy2rs59JLm5Zc=;
 b=w/DYQvuUE+z8l2zCFGlhUbllM3mJIRWRZ/VFkih2/VrjECnGUt8bQ3xap368nhbUPULdL
 DqglrXWFg2mQ6AA0GV/iJbTnssY05uwmEDJQUOGgQvV6urPshpWLADYh1PrNxPYNJc4u3g1
 3lb9iRWbDM2KVi++BKctcIK/abT5Dt0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C659D80EC2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 10 Feb 2025 14:30:18 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739194218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Y0kuY/qnmLWcTpq+Gs4oe5wYG4aWX3Vy2rs59JLm5Zc=;
	b=OWq+UsN8kw0RIV0+DQQXaeyZ0NSHBVdBZAm8DqapLo/Sq6eoWtRcv8rnVA+n+EnR3EAyj0
	EILs1M0jIbV2q3557GbXSKLeaT/+s0Nnk7xb8vsxd6PRFmvIT39dUT/5x/zn3qKvCzqx+G
	/VQEnCcIuJSWY2L9PfOIb9TXK3QsM/Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=ai9XsAmL;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62c as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739194218; a=rsa-sha256;
	cv=none;
	b=rFWddM/6PAIk6hURcGclk9dM8u+fbn9ioVBys0kdh7S6L02kchIO5mqMDpHogio4eZvLbw
	8kJOib1MZW8bk/bbf6lV75unnZnKv2CjQ5lfNgFsChf/aGRTm5JY7cp8p2PHoG/alBUdCJ
	JY1rsOxWcCmP5JfQHznuts/TkSL7gwI=
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21f62cc4088so40062315ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 10 Feb 2025 05:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194217; x=1739799017;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0kuY/qnmLWcTpq+Gs4oe5wYG4aWX3Vy2rs59JLm5Zc=;
        b=ai9XsAmLecAe7UA3B8tvDcGcojsrYuzOul/sk0FPBocqH85sVLbEX/qmiUJksRnVo+
         sp6S8SDqc8RvnKnsOzX1TnZFhmN/iIQuiw0KRdVMVeTBvVhdmAK6zDeic2J5PEIGjkm+
         Jh4cfL0MIIG9g39VHspiVnM71rZqBYp8rYJQqCFhaJbE/UhEbZVHOdyvc+YC3OGhLEjT
         A40agdPE6kr5mfup0mTvdh0R9mUkDg6wpcvb5mSzxLtV/i6jGncS45UoGQomzFjo1Elq
         HIXFntpDCddf6g4l5mcCdDwcc87HyxtzTBtYvjHIyrlDaA52dBEvlhl5AQ0x7ZMJRNpJ
         8w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194217; x=1739799017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y0kuY/qnmLWcTpq+Gs4oe5wYG4aWX3Vy2rs59JLm5Zc=;
        b=FzsLT/u2yCarSozlFl9hiOagw/ptTDxI5TIYBrLScTFygRhWWNeFE07yJPv2RAbtgX
         V1V/9ncJNf8pP7qvJOnqwwG3AXOc0YflJ98A0cIAQc11rcm2iOWTsmfG5Z32/hHgbxnP
         UMCA2KSGjC7xqRX3HMCYxjb/2UjimHUXF34hEA1cTwWrMx2txvO8GpdX5p3vTRprVpzF
         CoqhQyAAH9yW9B4qj4JQK/GwNJPsGgelQfPXp7mtAAbR2n+MA0G0eADJ8QYhlkXhQJTV
         PR54m2uKZM3Bm99pIRb3p5S+JjK2r2g3Ywl1MJWEJaKjx0OK1r+O88kaz8iOasTlQTDw
         DbCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMp+7BE3yRYm9m/xm+3qNi53Mjk/2CexaqHQm8qUr94ijA1eO5cGuPT+u5gnunwznlBHqpfvzyEAnzbQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yxm6m9cq3fSCgBze7wTd1/O6PjYXN0rA9uTFC7tWczccNvbW01a
	rBkLMXQaqFbGlKIXQE99+91ojcSwmKb3ekzzRTgWmyBWg22o4ubT
X-Gm-Gg: ASbGncuqLvGfhKLQIML/P5mX7NMm8+C+XrN5GtU4tDwCNLNETfkEF8lFQj4bRUMNcEd
	DsPYEGK+Dmax44pkNdofwLyIvwZhQZ/ZzLlnNQK2E+uHatrVg6sn6D5e/tAR7TjbrGRkHTuuUi8
	mPkHC44Q3oH2sbXj996QSaHd54oxJCsTQ0bHQ0dymyMqFEVGMBAtIfRXN+ADpQCwnywItFBudIV
	lbd3QxzH8cjgCyIXWJ7Hj5yB7ARiKiCZI/TwAtvpO7e6Pa2h5HCKZUwnIFSLuZ0gX97siiXPDUX
	/ErqbQ==
X-Google-Smtp-Source: 
 AGHT+IEH5QCCl4lI0axSO2k1baOf7QV120615EUg7vMmek14klRWGmTSu58W64P2a3hO1mcauSS1MQ==
X-Received: by 2002:a17:903:2309:b0:215:a04a:89d5 with SMTP id
 d9443c01a7336-21f4e1cf038mr233204165ad.2.1739194216829;
        Mon, 10 Feb 2025 05:30:16 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:30:16 -0800 (PST)
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
Subject: [PATCH net-next v9 00/11] net: Improve netns handling in rtnetlink
Date: Mon, 10 Feb 2025 21:29:51 +0800
Message-ID: <20250210133002.883422-1-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: FEK474KISXSKVZC64HZ3MRFDLGUZCLKF
X-Message-ID-Hash: FEK474KISXSKVZC64HZ3MRFDLGUZCLKF
X-Mailman-Approved-At: Mon, 10 Feb 2025 14:36:12 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/FEK474KISXSKVZC64HZ3MRFDLGUZCLKF/>
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

Patch 01 avoids link name conflict in different netns.

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

- In lowpan_newlink() in net/ieee802154/6lowpan/core.c:

    wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));

  Looks for IFLA_LINK in dev_net, but in theory the ifindex is defined
  in link netns.

And thanks to Kuniyuki for fixing related issues in gtp and pfcp:
https://lore.kernel.org/netdev/20250110014754.33847-1-kuniyu@amazon.com/

---

v9:
 - Change the prototype of macvlan_common_newlink().
 - Minor fixes of coding style and local variables.

v8:
 link: https://lore.kernel.org/all/20250113143719.7948-1-shaw.leon@gmail.com/
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
 drivers/net/gtp.c                             |  10 +-
 drivers/net/ipvlan/ipvlan.h                   |   3 +-
 drivers/net/ipvlan/ipvlan_main.c              |   8 +-
 drivers/net/ipvlan/ipvtap.c                   |   6 +-
 drivers/net/macsec.c                          |   9 +-
 drivers/net/macvlan.c                         |  21 +--
 drivers/net/macvtap.c                         |   6 +-
 drivers/net/netkit.c                          |  14 +-
 drivers/net/pfcp.c                            |   9 +-
 drivers/net/ppp/ppp_generic.c                 |   9 +-
 drivers/net/team/team_core.c                  |   6 +-
 drivers/net/veth.c                            |   7 +-
 drivers/net/vrf.c                             |   5 +-
 drivers/net/vxlan/vxlan_core.c                |   9 +-
 drivers/net/wireguard/device.c                |   7 +-
 drivers/net/wireless/virtual/virt_wifi.c      |   8 +-
 drivers/net/wwan/wwan_core.c                  |  16 +-
 include/linux/if_macvlan.h                    |   6 +-
 include/net/ip_tunnels.h                      |   5 +-
 include/net/rtnetlink.h                       |  40 ++++-
 net/8021q/vlan_netlink.c                      |   9 +-
 net/batman-adv/soft-interface.c               |   9 +-
 net/bridge/br_netlink.c                       |   6 +-
 net/caif/chnl_net.c                           |   5 +-
 net/core/rtnetlink.c                          |  34 +++--
 net/hsr/hsr_netlink.c                         |  12 +-
 net/ieee802154/6lowpan/core.c                 |   7 +-
 net/ipv4/ip_gre.c                             |  22 ++-
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
 50 files changed, 494 insertions(+), 179 deletions(-)
 create mode 100755 tools/testing/selftests/net/link_netns.py

-- 
2.48.1

