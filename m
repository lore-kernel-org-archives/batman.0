Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C4DD41C3F
	for <batman@archiver.kernel.org>; Wed, 13 Nov 2024 13:00:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 19A5D83B82
	for <batman@archiver.kernel.org>; Wed, 13 Nov 2024 14:00:48 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731502848;
 b=YANTBI4RHwBg661azQJViCrgLolJqVElBp2DOdSeNkUbbfOy4fIPIqe3PJW3v8jVrecgh
 /dh/8X/mwAeHezbI8OfQPgBr27Voj6om38Ev8aiqWzUDRq+8wmKAhwMM3V4FQBnqkK/+/sk
 X+bB/Tjy2cvq9QBPFoDHDBj1VFs4mL4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731502848; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=16RIG7XtmkaIMsGLfFdWcl8EYTUAA5lDQMgC+uoAVXA=;
 b=HlU0bkww3XSID+P8m1nYaiPlXB6ctXnfsEVnW9m48pwTihrFaXUEfo74uaBBUDBNpReo9
 52cRIfYgaHdgFh0gepJV/J81qzkyoU0TbCQuwTHtiOE+V+FUxb2/kJW8W0EKTLAEnFzsSqo
 n6HBmbh9TwHhI4h0ndVTKPMctYy65S4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3220D825C9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 Nov 2024 13:57:38 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731502658; a=rsa-sha256;
	cv=none;
	b=DCiT0d+JNkleGf481q6dIQjf1xLUCg8fQAWfw9oL3WMYocqn8YcUq6PQd25B8RvewOU2A7
	qvqGZYQnrFpBV37WOldVUF2gnVPkQCtKEVdgK3x5oipni07jnXvlrjJ6iXewmT9+D6WMRT
	w+TBXuAQTCILgTe8pXzLCskKWTqjh6c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=OsUw9JT+;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::52a as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731502658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=16RIG7XtmkaIMsGLfFdWcl8EYTUAA5lDQMgC+uoAVXA=;
	b=rAT6RZ08O152HtCccAwaS4Ueu1TQDa91/2h4dUnwTbnaly2GTDlcSs2M5hjuX50UdeCQf6
	jdChWoi4iIU0pvCeAoEeYFnTLp/K5HkOGjh6Uhgi5xpVgeI9ylLOZxANHxKKkAzTVE2D0V
	kkGBCTjw34/yBYqLnws9qPmNS885kkY=
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7ea7ad1e01fso535476a12.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 13 Nov 2024 04:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502656; x=1732107456;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=16RIG7XtmkaIMsGLfFdWcl8EYTUAA5lDQMgC+uoAVXA=;
        b=OsUw9JT+YCgR19G6R+69y1HMoiVby3RXAOwyRIGfNgRcTxYRCIGcTIBrOgb+5C9U4L
         nUq63ZYyrJWmvUDekuS7Ffe2ur9tMyyXmyI5//HQ8aFHLUXX+gSIIieiNpn8ljHuFyJs
         CAoOlhTwWC1jfn4DQ9NDqD3h/evlbgW54FzqhnBImId71D2fCV9C1W5lM5x1LoKLHJLh
         RC+q8w9i/jjjFHbgze7L8K+isQmW7pHfkmJUBTUkDd9jn17VR/44wRVT4AsGjaRnR00X
         trMX14hMQz9uxfiD9vizR9KAbBAgYNTrGFXxSwUxypKK0cyGccIiYbQVNkWUurXONwN4
         Em0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502656; x=1732107456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=16RIG7XtmkaIMsGLfFdWcl8EYTUAA5lDQMgC+uoAVXA=;
        b=iSGnDNc0z/co3zG6ksCHQa5eIyPB1mg5jUz3UZ1PsPmWGBGm79rPQuy66GHo4nKE4f
         +an88NPxYIHO/nOPC0BM7DLI8YfyEeQVV0dI4gqIHthL5HAO/OV8baOq2XvnqVhK/oSV
         3sj6fJA/5TS0wJsraMdUz8TrJE+O8mUKDo9OIE9OWMYbEhBuO5KlAEVivQ0Ivxy384Rm
         /ep+XLAYOVibaINmxUJ3NIg7J871GLOOQbdYHJRnkN22PhUJYtfm87V5X47IMvAuMoPN
         4tirG8Q7FeJ7i6ZYJ+B2fwIOAqitkBaCq61PeK74ZR4Gi/yQwOFhoye6/utNWPq4RoVX
         VUGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkyPT1pYkM+eUt2DhrzjsRjr4DWizGm/MXUdxi7NPkhF/zuZ+PRDbBAXKE2M0dGhB8yhSCnWJgQ/qB2Q==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwGKoAaTAeEqavc4YRnzVtNcVFlw6B2E8Bqdqu13i30Qo8uh3kU
	gNePgl1nHkVSMrbt1iTMlIutilNTLLxRBQiKUPjDt1XxK9cr9UpV
X-Google-Smtp-Source: 
 AGHT+IG1llNssb9d3itpdlPx9GEqMX+Zp38UcErZg9PjxNGttUHCL6O3wsgZQ/zCnjJA57EpkRZP1g==
X-Received: by 2002:a17:90b:2789:b0:2e2:bb32:73e7 with SMTP id
 98e67ed59e1d1-2e9b1f844damr30704968a91.15.1731502656393;
        Wed, 13 Nov 2024 04:57:36 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:35 -0800 (PST)
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
Subject: [PATCH net-next v3 0/6] net: Improve netns handling in RTNL and
 ip_tunnel
Date: Wed, 13 Nov 2024 20:57:09 +0800
Message-ID: <20241113125715.150201-1-shaw.leon@gmail.com>
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
Message-ID-Hash: GNVBFC5C7QIVWOHZMBDCET2XY3GMBQMA
X-Message-ID-Hash: GNVBFC5C7QIVWOHZMBDCET2XY3GMBQMA
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:00:42 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GNVBFC5C7QIVWOHZMBDCET2XY3GMBQMA/>
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

Patch 1 from Donald is included just as a dependency.

---

v3:
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


Donald Hunter (1):
  Revert "tools/net/ynl: improve async notification handling"

Xiao Liang (5):
  net: ip_tunnel: Build flow in underlay net namespace
  rtnetlink: Lookup device in target netns when creating link
  rtnetlink: Decouple net namespaces in rtnl_newlink_create()
  selftests: net: Add python context manager for netns entering
  selftests: net: Add two test cases for link netns

 drivers/infiniband/ulp/ipoib/ipoib_netlink.c  |  6 ++-
 drivers/net/amt.c                             |  6 +--
 drivers/net/bareudp.c                         |  4 +-
 drivers/net/bonding/bond_netlink.c            |  3 +-
 drivers/net/can/dev/netlink.c                 |  2 +-
 drivers/net/can/vxcan.c                       |  4 +-
 .../ethernet/qualcomm/rmnet/rmnet_config.c    |  5 +-
 drivers/net/geneve.c                          |  4 +-
 drivers/net/gtp.c                             |  4 +-
 drivers/net/ipvlan/ipvlan.h                   |  2 +-
 drivers/net/ipvlan/ipvlan_main.c              |  5 +-
 drivers/net/ipvlan/ipvtap.c                   |  4 +-
 drivers/net/macsec.c                          |  5 +-
 drivers/net/macvlan.c                         |  5 +-
 drivers/net/macvtap.c                         |  5 +-
 drivers/net/netkit.c                          |  4 +-
 drivers/net/pfcp.c                            |  4 +-
 drivers/net/ppp/ppp_generic.c                 |  4 +-
 drivers/net/team/team_core.c                  |  2 +-
 drivers/net/veth.c                            |  4 +-
 drivers/net/vrf.c                             |  2 +-
 drivers/net/vxlan/vxlan_core.c                |  4 +-
 drivers/net/wireguard/device.c                |  4 +-
 drivers/net/wireless/virtual/virt_wifi.c      |  5 +-
 drivers/net/wwan/wwan_core.c                  |  6 ++-
 include/net/ip_tunnels.h                      |  5 +-
 include/net/rtnetlink.h                       | 22 ++++++++-
 net/8021q/vlan_netlink.c                      |  5 +-
 net/batman-adv/soft-interface.c               |  5 +-
 net/bridge/br_netlink.c                       |  2 +-
 net/caif/chnl_net.c                           |  2 +-
 net/core/rtnetlink.c                          | 25 ++++++----
 net/hsr/hsr_netlink.c                         |  8 +--
 net/ieee802154/6lowpan/core.c                 |  5 +-
 net/ipv4/ip_gre.c                             | 13 +++--
 net/ipv4/ip_tunnel.c                          | 16 +++---
 net/ipv4/ip_vti.c                             |  5 +-
 net/ipv4/ipip.c                               |  5 +-
 net/ipv6/ip6_gre.c                            | 17 ++++---
 net/ipv6/ip6_tunnel.c                         | 11 ++---
 net/ipv6/ip6_vti.c                            | 11 ++---
 net/ipv6/sit.c                                | 11 ++---
 net/xfrm/xfrm_interface_core.c                | 13 +++--
 tools/net/ynl/cli.py                          | 10 ++--
 tools/net/ynl/lib/ynl.py                      | 49 ++++++++-----------
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/lib/py/__init__.py  |  2 +-
 tools/testing/selftests/net/lib/py/netns.py   | 18 +++++++
 tools/testing/selftests/net/netns-name.sh     | 10 ++++
 tools/testing/selftests/net/netns_atomic.py   | 38 ++++++++++++++
 50 files changed, 255 insertions(+), 157 deletions(-)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

-- 
2.47.0

