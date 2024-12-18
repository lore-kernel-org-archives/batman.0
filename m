Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2657E77187
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 13:21:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5DC9A8415F
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 14:21:09 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734528069;
 b=eLPLyvBiIKIkA2DYnx5/Vd4Uuhmi3tK9A53gqS72GiYq+LqzPUAYBkgLtQk5CEB3IFTHE
 zzimCBehQIYICKkHbkDoDE3qd8jBGHjZ21NAm0hCY9aZbGgpOSxzsywPynVwVPfqh9JnrUp
 DxoYMCjzTtVuqRo5bn1UbWfvDaX2/y4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734528069; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cEe2srsfNQuo3cFtk4Exr0i8mchzSjDC/1TEtzbMZ8U=;
 b=d9GVGm9Mk3cV0aU/yY5wMtqkAf0XybEwiTGIrGcelwmhEGEPZnT5wpGqOJWQ4l4bAnomy
 vz0uHmo7j3AfOOPvBb3LJgW8Iq1XwZWludfnIcpaIm8XJJc8tEwzckYtYz5jqHVrbHTmjnA
 qMk8mTUthxFmC6Mxhz6FhQvW1j93UP8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 23860833D4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Dec 2024 14:10:56 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734527456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cEe2srsfNQuo3cFtk4Exr0i8mchzSjDC/1TEtzbMZ8U=;
	b=yzhZ/YLm9VAkprWDat810ZNht6EdfoFFTFOB0gGxL5t1U5J84RLPwXD1ME6JcETs+nMVtC
	UpfgiMHI4Jfg5sNHj+JGFhQn/rnwbIil737qdcCVrTzec5aeq0lZ0UJslL9uOnmhWzsHZY
	hXD2x+R9anxVyUTEd2/qmt9gqAWFm7M=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734527456; a=rsa-sha256;
	cv=none;
	b=d2YmhwVATTy0pITRVNHKEDvIjznOd1i5Nuw1CatpvW9mtpNlDitL/MtLBvKgHFx7o7Lh2g
	vyLDYMLaP0i80gh4k+e0ouUGZBUVXsC1auN5rpUV/1ZZN4CnZv70lCFj4Fb0k2LKjp0Jkj
	0pWhhdc+DQXa9sLr4Rd62GdoIIg/2nU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=lF5bWKXF;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62d as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so23498765ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 18 Dec 2024 05:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527454; x=1735132254;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEe2srsfNQuo3cFtk4Exr0i8mchzSjDC/1TEtzbMZ8U=;
        b=lF5bWKXFlXZDeQnJfgBCw+zkOaoN1NjuipmD75lu1LN/to79ftPlGWYSHgr7+mg/CP
         373H5FFH5VZ0YOLpgtSP5gjqFN2+VnKBlm5M+ZRYf+N3+TedlzkiClhTDJBKo8j2isZZ
         2ojUxIs5sQrgT5TM0cSWNQ9mrH9sZ6EeUvT9EEvLu4BaeNOquV7N0T3WGoVLfQsnXAM6
         yz/fU/NIRvezMr0w5zyxknCDhEn1O/rvcNWzBbwx3WdUnN9v3jG70Ox/mwvjFEGz0sdT
         VwMoy3/IYox9z0LbkiiA1qXULpVWfX999xOhUxHjSfMtQULA/OS4as+o9YRnqS+IJv6w
         sxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527454; x=1735132254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEe2srsfNQuo3cFtk4Exr0i8mchzSjDC/1TEtzbMZ8U=;
        b=Nx64VX4vBxGjqLbUUAevENPkwpSsC2Rom8ctP1l8HbFhNmGs7nC9+rcTh5wu9wH+RS
         WII/qthsL47JWmJlKuZL6EXse8a63L3vGMUGQjRTq5rfsKeo9IJWOcX8GQNDeXM/aVXW
         dyKFdNvEfyOWva+Ic81oIqi3JQ4e7QEQOQHyx/lXIHy66lsrX/vpZ14OCRC/OQ/9j572
         QKeE5b9OblgWSs8cY+9/DOih4U7o5TMyypQUy1LVSb67znnOWf2FIxEEcMSwB92LMvVI
         lBT6pw0Iu8Rk68Xwm4FwICF7K66IppY0BYzwj1dsBnk8/F/prK0F0k5oMvpe2Q2pSTJd
         dT9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBhf0dnlWHSCQBaYbvTc4yjy1XaOemZdGuG94zVHZzb8M/Be75H3BOsgxX1f4/j6GCOA/qlfGz+vO6Tw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yy5daxgJirkTVtD8+ZALRrfGyORy7JfVYxkjxbe5qHJkUrZhTzu
	9zzDpiJd1GonqlJ0Ff7EDxjHMzHo4+DKkS7zMT+7kggxXlZ7xV5s
X-Gm-Gg: ASbGncv84GPHWdrofBY5RaHYUFeqYBN4mr7Qb5tDCcLDA/SnjU2pLM0c+N/PV+8KN9U
	ZKSuI9/VVAEGXfphCoqxAAaQYiJ0sZf97LTqY+Am9vsZMuPZZuGWHjzoX8R9EZTf1gXo74yTrsd
	c8jXZLDxdlA7fTan8R9HSndANyBRi7APEart5ahixT3owGEZYTg5LINc9RTklkA1Z03P7FELk6f
	Houw4fVYS9vjp7Szs/t/2fmvCi8HxKsuCSUNw0N1dDCEKE=
X-Google-Smtp-Source: 
 AGHT+IGW2ivQBr6ib7m/cmjzjnkogelPQGpBxwq3iWWAr6K+/MU6YNZqq3IUhKj+TIVnGpc4fMVSow==
X-Received: by 2002:a17:902:f985:b0:216:6c77:7bbb with SMTP id
 d9443c01a7336-218d70dc242mr29804885ad.17.1734527454469;
        Wed, 18 Dec 2024 05:10:54 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:53 -0800 (PST)
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
Subject: [PATCH net-next v6 11/11] selftests: net: Add test cases for link and
 peer netns
Date: Wed, 18 Dec 2024 21:09:09 +0800
Message-ID: <20241218130909.2173-12-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218130909.2173-1-shaw.leon@gmail.com>
References: <20241218130909.2173-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: WFJNJTXTDQID47LTKATOOU3KRHG5I7FB
X-Message-ID-Hash: WFJNJTXTDQID47LTKATOOU3KRHG5I7FB
X-Mailman-Approved-At: Wed, 18 Dec 2024 14:11:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/WFJNJTXTDQID47LTKATOOU3KRHG5I7FB/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

 - Add test for creating link in another netns when a link of the same
   name and ifindex exists in current netns.
 - Add test to verify that link is created in target netns directly -
   no link new/del events should be generated in link netns or current
   netns.
 - Add test cases to verify that link-netns is set as expected for
   various drivers and combination of namespace-related parameters.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 tools/testing/selftests/net/Makefile      |   1 +
 tools/testing/selftests/net/link_netns.py | 142 ++++++++++++++++++++++
 tools/testing/selftests/net/netns-name.sh |  10 ++
 3 files changed, 153 insertions(+)
 create mode 100755 tools/testing/selftests/net/link_netns.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index f09bd96cc978..cc6665212304 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -35,6 +35,7 @@ TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_so_priority.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS += netns-name.sh
+TEST_PROGS += link_netns.py
 TEST_PROGS += nl_netdev.py
 TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
 TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
diff --git a/tools/testing/selftests/net/link_netns.py b/tools/testing/selftests/net/link_netns.py
new file mode 100755
index 000000000000..c4b2ddf201ff
--- /dev/null
+++ b/tools/testing/selftests/net/link_netns.py
@@ -0,0 +1,142 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+import time
+
+from lib.py import ksft_run, ksft_exit, ksft_true
+from lib.py import ip
+from lib.py import NetNS, NetNSEnter
+from lib.py import RtnlFamily
+
+
+LINK_NETNSID = 100
+
+
+def test_event() -> None:
+    with NetNS() as ns1, NetNS() as ns2:
+        with NetNSEnter(str(ns2)):
+            rtnl = RtnlFamily()
+
+        rtnl.ntf_subscribe("rtnlgrp-link")
+
+        ip(f"netns set {ns2} {LINK_NETNSID}", ns=str(ns1))
+        ip(f"link add netns {ns1} link-netnsid {LINK_NETNSID} dummy1 type dummy")
+        ip(f"link add netns {ns1} dummy2 type dummy", ns=str(ns2))
+
+        ip("link del dummy1", ns=str(ns1))
+        ip("link del dummy2", ns=str(ns1))
+
+        time.sleep(1)
+        rtnl.check_ntf()
+        ksft_true(rtnl.async_msg_queue.empty(),
+                  "Received unexpected link notification")
+
+
+def validate_link_netns(netns, ifname, link_netnsid) -> bool:
+    link_info = ip(f"-d link show dev {ifname}", ns=netns, json=True)
+    if not link_info:
+        return False
+    return link_info[0].get("link_netnsid") == link_netnsid
+
+
+def test_link_net() -> None:
+    configs = [
+        # type, common args, type args, fallback to dev_net
+        ("ipvlan", "link dummy1", "", False),
+        ("macsec", "link dummy1", "", False),
+        ("macvlan", "link dummy1", "", False),
+        ("macvtap", "link dummy1", "", False),
+        ("vlan", "link dummy1", "id 100", False),
+        ("gre", "", "local 192.0.2.1", True),
+        ("vti", "", "local 192.0.2.1", True),
+        ("ipip", "", "local 192.0.2.1", True),
+        ("ip6gre", "", "local 2001:db8::1", True),
+        ("ip6gre", "", "local 2001:db8::1", True),
+        ("ip6tnl", "", "local 2001:db8::1", True),
+        ("vti6", "", "local 2001:db8::1", True),
+        ("sit", "", "local 192.0.2.1", True),
+        ("xfrm", "", "if_id 1", True),
+    ]
+
+    with NetNS() as ns1, NetNS() as ns2, NetNS() as ns3:
+        net1, net2, net3 = str(ns1), str(ns2), str(ns3)
+
+        # prepare link netnsid  and a dummy link needed by certain drivers
+        ip(f"netns set {net3} {LINK_NETNSID}", ns=str(net2))
+        ip("link add dummy1 type dummy", ns=net3)
+
+        cases = [
+            # source, "netns", "link-netns", expected link-netns
+            (net3, None, None, None, None),
+            (net3, net2, None, None, LINK_NETNSID),
+            (net2, None, net3, LINK_NETNSID, LINK_NETNSID),
+            (net1, net2, net3, LINK_NETNSID, LINK_NETNSID),
+        ]
+
+        for src_net, netns, link_netns, exp1, exp2 in cases:
+            tgt_net = netns or src_net
+            for typ, cargs, targs, fb_dev_net in configs:
+                cmd = "link add"
+                if netns:
+                    cmd += f" netns {netns}"
+                if link_netns:
+                    cmd += f" link-netns {link_netns}"
+                cmd += f" {cargs} foo type {typ} {targs}"
+                ip(cmd, ns=src_net)
+                if fb_dev_net:
+                    ksft_true(validate_link_netns(tgt_net, "foo", exp1),
+                              f"{typ} link_netns validation failed")
+                else:
+                    ksft_true(validate_link_netns(tgt_net, "foo", exp2),
+                              f"{typ} link_netns validation failed")
+                ip(f"link del foo", ns=tgt_net)
+
+
+def test_peer_net() -> None:
+    types = [
+        "vxcan",
+        "netkit",
+        "veth",
+    ]
+
+    with NetNS() as ns1, NetNS() as ns2, NetNS() as ns3, NetNS() as ns4:
+        net1, net2, net3, net4 = str(ns1), str(ns2), str(ns3), str(ns4)
+
+        ip(f"netns set {net3} {LINK_NETNSID}", ns=str(net2))
+
+        cases = [
+            # source, "netns", "link-netns", "peer netns", expected
+            (net1, None, None, None, None),
+            (net1, net2, None, None, None),
+            (net2, None, net3, None, LINK_NETNSID),
+            (net1, net2, net3, None, None),
+            (net2, None, None, net3, LINK_NETNSID),
+            (net1, net2, None, net3, LINK_NETNSID),
+            (net2, None, net2, net3, LINK_NETNSID),
+            (net1, net2, net4, net3, LINK_NETNSID),
+        ]
+
+        for src_net, netns, link_netns, peer_netns, exp in cases:
+            tgt_net = netns or src_net
+            for typ in types:
+                cmd = "link add"
+                if netns:
+                    cmd += f" netns {netns}"
+                if link_netns:
+                    cmd += f" link-netns {link_netns}"
+                cmd += f" foo type {typ}"
+                if peer_netns:
+                    cmd += f" peer netns {peer_netns}"
+                ip(cmd, ns=src_net)
+                ksft_true(validate_link_netns(tgt_net, "foo", exp),
+                          f"{typ} peer_netns validation failed")
+                ip(f"link del foo", ns=tgt_net)
+
+
+def main() -> None:
+    ksft_run([test_event, test_link_net, test_peer_net])
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/net/netns-name.sh b/tools/testing/selftests/net/netns-name.sh
index 6974474c26f3..0be1905d1f2f 100755
--- a/tools/testing/selftests/net/netns-name.sh
+++ b/tools/testing/selftests/net/netns-name.sh
@@ -78,6 +78,16 @@ ip -netns $NS link show dev $ALT_NAME 2> /dev/null &&
     fail "Can still find alt-name after move"
 ip -netns $test_ns link del $DEV || fail
 
+#
+# Test no conflict of the same name/ifindex in different netns
+#
+ip -netns $NS link add name $DEV index 100 type dummy || fail
+ip -netns $NS link add netns $test_ns name $DEV index 100 type dummy ||
+    fail "Can create in netns without moving"
+ip -netns $test_ns link show dev $DEV >> /dev/null || fail "Device not found"
+ip -netns $NS link del $DEV || fail
+ip -netns $test_ns link del $DEV || fail
+
 echo -ne "$(basename $0) \t\t\t\t"
 if [ $RET_CODE -eq 0 ]; then
     echo "[  OK  ]"
-- 
2.47.1

