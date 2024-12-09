Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1260EE7717D
	for <batman@archiver.kernel.org>; Mon,  9 Dec 2024 16:48:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3CDFC83F04
	for <batman@archiver.kernel.org>; Mon,  9 Dec 2024 17:48:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733762881;
 b=GHu6CbMg//1M0vSP3k7xZQoR4RdbBTVbKYd53KXneGyybBgKYufCCHHwq2kIafu/VTneF
 J3ZG5rFqzCNq3mGKCTidQkWaASGFUnwjndkVLFls1n6zqhcAeOAtTm0QGmdNx5+dYaq8Dur
 bEU8HqBUC/4E/DmxKN47+kWnsIRonnE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733762881; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OAhPp2pGpsvDTqVI2eQ221kABd4Y8/kh7k1mWyeQzTw=;
 b=yq2bnwrGL7ZBFDI3x8LmoofQ6MABTGFTI6UP0iDYWw6uakx/iGchOv4oNj6X38/iurB/7
 CUDNcnSHK1+PtKFSc2Ujl6WtJkGiFmYHi1HwM59uWc8+aKUXN3DTvG1AJEcO+pV6bbTfXgh
 Vl/pXByHA8SiNJI47Lxj1MbDSYCk7sg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2065780262
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  9 Dec 2024 15:02:30 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733752950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=OAhPp2pGpsvDTqVI2eQ221kABd4Y8/kh7k1mWyeQzTw=;
	b=i99jm8Ds72y+w+VxHu8ZdpuMUHZemtXKDgp5FSZkqEUYpUz9g5I4xoNBNAEVAMrudhw6a8
	UgqrqjkyH2Q3ik+2yPlzc4Ax4j0jVC2vfFxLrINL1rOj0FO9BolTXQBejEC0CF61HAwOyJ
	U6op/8A70tCWvdZm8pLDgwtGeViiHPw=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733752950; a=rsa-sha256;
	cv=none;
	b=A5e2ohSiKxhiyNmBwKA1t6TbCQqx0KDp48SJpMhKZrvNmIgruFD8jflCSEDh5aTBGV7fXk
	pJJgKhvbisbF/pGzidnqhMKksQVnhgcSIG0ZCUpokEHv3vza/YaoTnbYXyqybpiO8i25Ds
	UN6p4IrBgwde/Fh42zewIGVJ+RbmXFU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=hodHT4DQ;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62e as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2165448243fso9430885ad.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 09 Dec 2024 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733752948; x=1734357748;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OAhPp2pGpsvDTqVI2eQ221kABd4Y8/kh7k1mWyeQzTw=;
        b=hodHT4DQbztXO7LrI/5AG4lda0vdKf1h3YkAg8oMVViC/5VZ6x1lAnL8k4RLkjlCnQ
         eXES5XvxF1DKynH2moc3OwX6WeTlwJupIAb/MVHC4a2YQb1jFz0aOijl21aYLzRzOEmj
         MX78gpQS3mvEM2KB8jHgF89pdWuMY/PdRdv8iWQnJmYQt2uP+Jwehkvu38uIUa2CWDhG
         e8rqLXnIiEU2yGhp+jsdxjNXvSSsZ8HmGYHUhScUe82pgqOiU4H+YQsm4RcRmLhtFlbQ
         6J2PfVJbee+spwQSjIWRavSu4zDH9FfloWNpl7kDNNXTLcqoRvjooTj2Q4MBppZgsUGh
         g7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752948; x=1734357748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OAhPp2pGpsvDTqVI2eQ221kABd4Y8/kh7k1mWyeQzTw=;
        b=hMr6QkJ9h8fHcduObDUG9KVn+7SivAq9jWgZ+H6kNOd/q0kzjdCUf7nGLY7V+H5lQ6
         UlnZpUHAXPCIJTGKzckfavlbpwLUunNwHPk3bLM7jrdjYjZFNnqx+evA+uYinKgtdFFw
         MJO77WkitRb5AHG2pdgaB48U4NDfM0lkqWKVafdBzrsSI51jwWWNZyRYTRVByEI5uQtU
         TtWo37HWGmiH0ZsIJEMURW7oIwTLogHr9xcNZJyF5JhZakDbcQ7j9misd40Nk5kBHWiu
         wa/6Nd4lMZFn6tqVHGQ++ZiP6NhoirSBcMOOTIR4Xhn/FCmyvxD/ZaZxLmJkRr5F54vc
         r1MQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0tOsWAAWmS5sgw6qQTOuxFOYne3Oqo4+KEYGgSU98BZ4qZhUUmVwNa+gK8AFZAU9ABNHCp5GWWGTaMQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzpXS7gH3svcSixhgLxJcpqXCyyVVx154Q0sO+UbuzIXqpR0bHt
	8UrMyLN1GknDWNF40zqsKTqvATuaPKEVK4AJA1QLFzDdDSjLprWh
X-Gm-Gg: ASbGncu5s/2C7uufsayPk+Z+DF/ORiFfHc4XH90HXwsPnfNL4V+NUgc5eklVEoFNE0c
	lK6uCZpeJnNgKrViqxmDjxJ5jYXMMQQG0Xsy/5eYsoHi7fZxjQszlfQisQqi02Uxk9XyufnkCRH
	W2JjMWWOcHRawLwpQ+fg0FfebOYc7y6LOcZHPijjp2DD+kIKpemQ0Xnhut8Zs1v6M4Gr++25ZYz
	z8rlXLV86x/XQ/ZbW7R4/U1DAddKeBlohMFbtTmiMs72xw=
X-Google-Smtp-Source: 
 AGHT+IEziqjANISe8V7T1b1Vo9dS8nge43qoErTxjCtNhfTplDp9qnHGPIzO4tjQCtyFccSJFTBRCw==
X-Received: by 2002:a17:902:e74f:b0:216:4122:925f with SMTP id
 d9443c01a7336-21641229442mr90363145ad.14.1733752948110;
        Mon, 09 Dec 2024 06:02:28 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:02:26 -0800 (PST)
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
Subject: [PATCH net-next v5 0/5] net: Improve netns handling in RTNL and
 ip_tunnel
Date: Mon,  9 Dec 2024 22:01:46 +0800
Message-ID: <20241209140151.231257-1-shaw.leon@gmail.com>
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
Message-ID-Hash: SPH2LXMIJ6YCOWXYSLAKGAX4AZKUCIY4
X-Message-ID-Hash: SPH2LXMIJ6YCOWXYSLAKGAX4AZKUCIY4
X-Mailman-Approved-At: Mon, 09 Dec 2024 17:47:40 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SPH2LXMIJ6YCOWXYSLAKGAX4AZKUCIY4/>
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

v5:
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


Xiao Liang (5):
  net: ip_tunnel: Build flow in underlay net namespace
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Decouple net namespaces in rtnl_newlink_create()
  selftests: net: Add python context manager for netns entering
  selftests: net: Add two test cases for link netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  | 11 +++--
 drivers/net/amt.c                             | 13 +++---
 drivers/net/bareudp.c                         | 11 +++--
 drivers/net/bonding/bond_netlink.c            |  8 ++--
 drivers/net/can/dev/netlink.c                 |  4 +-
 drivers/net/can/vxcan.c                       |  9 ++--
 .../ethernet/qualcomm/rmnet/rmnet_config.c    | 11 +++--
 drivers/net/geneve.c                          | 11 +++--
 drivers/net/gtp.c                             |  9 ++--
 drivers/net/ipvlan/ipvlan.h                   |  4 +-
 drivers/net/ipvlan/ipvlan_main.c              | 11 +++--
 drivers/net/ipvlan/ipvtap.c                   |  7 ++-
 drivers/net/macsec.c                          | 11 +++--
 drivers/net/macvlan.c                         |  8 ++--
 drivers/net/macvtap.c                         |  8 ++--
 drivers/net/netkit.c                          |  9 ++--
 drivers/net/pfcp.c                            |  8 ++--
 drivers/net/ppp/ppp_generic.c                 | 10 +++--
 drivers/net/team/team_core.c                  |  7 +--
 drivers/net/veth.c                            |  9 ++--
 drivers/net/vrf.c                             |  7 +--
 drivers/net/vxlan/vxlan_core.c                | 11 +++--
 drivers/net/wireguard/device.c                |  8 ++--
 drivers/net/wireless/virtual/virt_wifi.c      | 10 +++--
 drivers/net/wwan/wwan_core.c                  | 15 +++++--
 include/net/ip_tunnels.h                      |  5 ++-
 include/net/rtnetlink.h                       | 44 ++++++++++++++++---
 net/8021q/vlan_netlink.c                      | 11 +++--
 net/batman-adv/soft-interface.c               | 12 ++---
 net/bridge/br_netlink.c                       |  8 ++--
 net/caif/chnl_net.c                           |  6 +--
 net/core/rtnetlink.c                          | 35 ++++++++-------
 net/hsr/hsr_netlink.c                         | 14 +++---
 net/ieee802154/6lowpan/core.c                 |  9 ++--
 net/ipv4/ip_gre.c                             | 27 ++++++++----
 net/ipv4/ip_tunnel.c                          | 16 ++++---
 net/ipv4/ip_vti.c                             | 10 +++--
 net/ipv4/ipip.c                               | 10 +++--
 net/ipv6/ip6_gre.c                            | 28 +++++++-----
 net/ipv6/ip6_tunnel.c                         | 16 +++----
 net/ipv6/ip6_vti.c                            | 15 +++----
 net/ipv6/sit.c                                | 16 +++----
 net/xfrm/xfrm_interface_core.c                | 14 +++---
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/netns.py   | 18 ++++++++
 tools/testing/selftests/net/netns-name.sh     | 10 +++++
 tools/testing/selftests/net/netns_atomic.py   | 39 ++++++++++++++++
 48 files changed, 385 insertions(+), 211 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

-- 
2.47.1

