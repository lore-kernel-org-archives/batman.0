Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD72C021B0
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 15:43:22 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4A1088415C
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 16:43:21 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739979801;
 b=GZAG5V8SkLq2J0LponLWJTy4Qr0LoUq6mm6JwRQpk7r+HRC0arxWcPtCLbP/sZ7xhVnCJ
 jKpFouCkPNIhMnNOTTYf/Pzjs/PomXKADePoTrKVXSFM1vttX1sgYEoHyY6ogSLmomQ730e
 3uGBEOIhtMrC9FafKCDxOuRvkh6ovSA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739979801; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=wOEjIz3jfJx7EGKo7QwRt3VtLNoT+pQ4mVUjPRekXyI=;
 b=Vv25NLBwJkHGiMW2+/uy7ZUfoZiQpmtkqbZZlOPeiaDrcAZqoxRhunPnqBtKSQNx/zUmY
 PCsziO4t/YWbVEJ9REi8vvL8E59Pey+lVlXv7XeJfbDmRmTsa0htLK76bB1Lpe3GIW4Hj0D
 aHGBKFGMD/c2VdoRzb3nkRG9xjX0mhU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B0E318266F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Feb 2025 13:50:55 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739969456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=wOEjIz3jfJx7EGKo7QwRt3VtLNoT+pQ4mVUjPRekXyI=;
	b=w4mhD0SGyKAGbBYTO+Q4z2ZsUNDpNHEAhAy6bmizkCGMgLXwZuTPIJJo3BPBVweqjgMCg1
	K404Qjehx0GKNQIOuoRTcmiwP2UmumEJh/Wu/wy3ijmTahQXH3cr3+N3jS4yA8B7lZcvUj
	tkmDqrHP8rgsppNgCF+m2T8cw6RtPt0=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739969456; a=rsa-sha256;
	cv=none;
	b=xJkpCFhN4F09iTKn8ux/SpqBfP4QIpdgtJfn6fyQG3enft++BJYC5actf2DoHRAEI/+Pk2
	3yd1PgS2nSTg8DdBkeSYcqRarkXw1tpWQAAKwsr50caARPf+23SVFcif9q0YgUkwlv6La9
	v1Fg8qPoFIZOEC6Jn56X4yXdTlEkRRE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=Nvvd3dpa;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62f as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2211cd4463cso68120915ad.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 19 Feb 2025 04:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969454; x=1740574254;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wOEjIz3jfJx7EGKo7QwRt3VtLNoT+pQ4mVUjPRekXyI=;
        b=Nvvd3dpa67aDGXq4CSfEGQCdGKDLLlnbO9O5r2qBdF2l2MdeWIupylB3qEiZ/9yDLU
         sF9jDl7OXp+vF4cReVj9CKQbrRGmLzNYovhz2W/XyzjwpyhGOiUnx3jRWD4opt47mFEj
         wcJV0X6aWPd9HFZRAYTGmsKSLEe268YpK1OxtiNjeZPuciu+C99xk+6EH5Y0Q72MbG25
         DtY4shNkboKvbtQTKLdRjgxNd6dLqcUfeLs1kPdATZlCHV2UAKdyYMKLdpWiJrEiAn/+
         v5vLZOR8IgMIErzMCjK2Ei5ckiFU8iy2qjRRIhyB+l6PNcOK49CWMM7DwMP/jtoJlhe3
         O3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969454; x=1740574254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wOEjIz3jfJx7EGKo7QwRt3VtLNoT+pQ4mVUjPRekXyI=;
        b=ZKBYjP1SzHGqeVH2vgAoCVlLNa+5JIrDLUCfs0isRHmrgI8crFHqQIsoKqhNljtAVa
         aqxIam35V5JhyGmFdl/r+Fx9Ge24nuL7DHuttsE1JayNVrKM+4rkATUnldG7dFqeGG+3
         4zIQwYoGHvhhG0l0qD2NsSatqHCxZuv0Lrq0KXep/OOBk9axYjXBSW6yYnATb6mIFdxY
         b767rkVw0lJ4eoNj8GHbSb5oxSxxFM7f1sFy1rFBJ8x/AKDFMOpy387hZ2ZN0PZLmQ6Y
         ZZ3UTvNhlgl9AQZoBH7YNLsWHHrI6Q9Cm7Q/mXcaFjmy3WuYQg9CdxvVp4+MNP3apqng
         dfgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbq7zkJwIe9SIDaaNNm/BLds7nd8m6pcdYFPYmEz3pyAuv7zorU5B904onMN3Wscfm0UvXHh5/PciCjQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxBpNnWF0PyDLiGkSBFFusw4spBs1LTjiooHaD2Y6OYOH0Wz1Rb
	vIG5Af/7tKx7w4DGBrvb9cT+l6GcTFZKIGb4DuiHi42KNsQDbvqD
X-Gm-Gg: ASbGnctYd1VUAL7uC8LlcRYvO2qq23N5XS8aci6fuD3AZi+/kq7JCBzpYNep17fQMMD
	oovZ6eAsg/Th2/N1NWB8yFx1Trn8XAq3tXLeguug/DYlFkH9u3pSwC8F/Fqirn0UHw7PS0QYNDo
	z6xfcb8Drb++2PvVNCdtlbBeQHX4kRk5OPXYHTpKBpUurvnmxCcwtYaD9VTUMSpz4F9xgevnRW/
	byySTZyuJlpSzsVO+Q58OEUF6bYu9uPxLCuvypeTt/qOx5YsaI54w5bH/R8LNonm90fXarHKLG9
	+wqPbA==
X-Google-Smtp-Source: 
 AGHT+IGTzmUs09YpyFPrUkefpGaoWuBh2+9iqLpiW9iEBwyuEmzG/kObjhneqUPTdxqOS7kfr/mohA==
X-Received: by 2002:a17:902:d58b:b0:216:2426:767f with SMTP id
 d9443c01a7336-221040cec77mr301871725ad.49.1739969453951;
        Wed, 19 Feb 2025 04:50:53 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:50:53 -0800 (PST)
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
Subject: [PATCH net-next v10 00/13] net: Improve netns handling in rtnetlink
Date: Wed, 19 Feb 2025 20:50:26 +0800
Message-ID: <20250219125039.18024-1-shaw.leon@gmail.com>
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
Message-ID-Hash: CVIBIODQ6W5Q5ZMEL7QYSV2BM6RYY4PW
X-Message-ID-Hash: CVIBIODQ6W5Q5ZMEL7QYSV2BM6RYY4PW
X-Mailman-Approved-At: Wed, 19 Feb 2025 16:43:03 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CVIBIODQ6W5Q5ZMEL7QYSV2BM6RYY4PW/>
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
 - Patch 03 ~ 09 converts device drivers to use the explicit netns
   extracted from params.
 - Patch 10 ~ 11 removes the old netns parameter, and converts
   rtnetlink to create device in target netns directly.

Patch 12 ~ 13 adds some tests for link name and link netns.

---

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

v10:
 - Move link/peer net helper functions to from patch 02 to 03.
 - Remove redundant tunnel->net assignment for IPv4 tunnels (patch 05).
 - Initialize tunnel->net before calling register_netdevice() for IPv6
   tunnels (patch 07).
 - Coding style fixes.

v9:
 link: https://lore.kernel.org/all/20250210133002.883422-1-shaw.leon@gmail.com/
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


Xiao Liang (13):
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Pack newlink() params into struct
  net: Use link/peer netns in newlink() of rtnl_link_ops
  ieee802154: 6lowpan: Validate link netns in newlink() of rtnl_link_ops
  net: ip_tunnel: Don't set tunnel->net in ip_tunnel_init()
  net: ip_tunnel: Use link netns in newlink() of rtnl_link_ops
  net: ipv6: Init tunnel link-netns before registering dev
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
 net/ipv4/ip_tunnel.c                          |   7 +-
 net/ipv4/ip_vti.c                             |   9 +-
 net/ipv4/ipip.c                               |   9 +-
 net/ipv6/ip6_gre.c                            |  26 ++--
 net/ipv6/ip6_tunnel.c                         |  18 ++-
 net/ipv6/ip6_vti.c                            |  14 +-
 net/ipv6/sit.c                                |  20 ++-
 net/xfrm/xfrm_interface_core.c                |  15 +-
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   5 +
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/netns.py   |  18 +++
 tools/testing/selftests/net/link_netns.py     | 141 ++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh     |  10 ++
 50 files changed, 486 insertions(+), 181 deletions(-)
 create mode 100755 tools/testing/selftests/net/link_netns.py

-- 
2.48.1

