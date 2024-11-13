Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85D3D41C3F
	for <batman@archiver.kernel.org>; Wed, 13 Nov 2024 13:05:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 28A0B83B4D
	for <batman@archiver.kernel.org>; Wed, 13 Nov 2024 14:05:32 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731503132;
 b=jWRF1S2383xMX9vOi7EeKE/GODKSPYIkEXEsQQquD4TmhwFZdz+9aRO5rkyDzidK0wcMe
 vV62hOT8CsG7/xvdoNW1VU8t0Un0ROnGjLk6khGNGVYyaXTmg1x/gxwmlMfgDY5ek4oRMV0
 F2e968fUYEdmSP/7H1acrFWhNQGsX0c=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731503132; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tqrrLk6+C692qIcVQOp9KatlJAZHjGryjisTBrwbzoI=;
 b=2B29YrIaLPfrPHfOuW5K3RDS+/hfL/VNggmtp0abxgkFc9ePhwxGWC9tVNxp3tyS6sAwz
 ggPHryPLcEdjqeoaSdR+HIj/Fb8itMM2lLh268FeslHWWYbP4lV1Rkz+pxIWHEi6XOk1gd8
 X2qx20PYuB+Ns7A8PYb2wxmsoVti5TU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C4F708357C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 Nov 2024 13:58:28 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731502708; a=rsa-sha256;
	cv=none;
	b=vRrXCqWJCqU7hTF+yGEhuH5rNHaQpxfGPNt+rTbNUQywFTUoojfCX2x4IvhC5b9Oktq77U
	urzodTr20k/63vuyiY2yrlJSi3bNe0UJPuHigC8R9RHNWcT5ZF2VCRyP/X3KPFWWBI1pdm
	2BAh8wtC8ZvmnWKOfqPEmh9JZs9ACpQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=K9XLUMzT;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::1029 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731502708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tqrrLk6+C692qIcVQOp9KatlJAZHjGryjisTBrwbzoI=;
	b=n1NxZFLQJsRlJWSdzjhFtFwiVkNjKprIpfbriNWQ2p/q0goj3Ql/wy8Pv6gj2w0w+nV4ws
	bGyR4GC1yzUFqkqU03VFYBZEuv3WHGtb9Ua6HfsYuBSlqCxpXyO97TuI9eBCt1vfplMp4v
	0hSb7Mbqlm557YrBDhY0Blo5PYo7ReI=
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2e2eb9dde40so5533428a91.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 13 Nov 2024 04:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502707; x=1732107507;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tqrrLk6+C692qIcVQOp9KatlJAZHjGryjisTBrwbzoI=;
        b=K9XLUMzTXsj4ZgXcgDNzqpW2DTxsdViWCH2h9KVXlmBLmhK23A81pivW1+h+embJjZ
         F9liJtVqUl1WzJl9n61TEr5Xbr/qIAK0SavKGjVB0j93ABhKpDzMn8XvFbMpXey/WryP
         pSFBTHtJqigRuhxPqbxRmzJG4cziHY7rZNlNm3YjzJ/7DI6FzKts51MVdnuqq8V/4Pg9
         ddfIhNQQ0BbDP0Owf+ECi7GrBYkNCCx9+EE3lCCUSICzdUfJpWgkNrIkrFUMxzbeF1BL
         krmZQq4HXCGhNjq2qv5A4VdkQkk/iP86PWv5NA+M7qYgIJXong/m7QtNnOgWr9tzq2zm
         pXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502707; x=1732107507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tqrrLk6+C692qIcVQOp9KatlJAZHjGryjisTBrwbzoI=;
        b=Euxltf/3XaFa+0FeW49RGv4FsOjpSGJljiiT2xo8vxj9ZtLocwhz/smbmyoOxAy3CP
         7xeFKjLN8m0OwtpxKKOl4qos53XKfcg8Hvs8dNdEOfmjLZI4wX1w/9xrwzJHbR1zTbtG
         /A96wowBfhncfNy/BDBsotS4nE9W9lLpFZ4axtZ4baHsMtc+illlG3JxtLY6i0tVkf/E
         GCfqsnmcu1xBVmQSevIb+lxGVquiHA2VPJcHzZG5gkTW9XP9buSsyE8mnz6PvXz1/Cqw
         iX0xBLA/BByAltS4xSJ4F/LvHh2gzh7Q2IO0rYLY4cywk6yXaMnpiDrx0wQIXJjYhnMA
         MIVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpdp48FywFde73ypzZejEz/bB9KQNKPlmUQJf6P5p5ifIOdVcbKE+VN8SJgMU9ZSztSYVMkoEFUJq9GA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwPpFbnYJ/iOjSVzha5JkBvHAtjlxkcOuo4YKyFtBrnpxQqVJEn
	AWd33r80mKwsvtHXO1kkHIFK7JfYeaC+ETLLbEa8MpzaZK+Gvvpl
X-Google-Smtp-Source: 
 AGHT+IE/vtXg73mPc9UwMocIh3JnpJ4Nx9KNFh/J++F7E0J+l3pL2CaZbF6bhZwKtLiUviIv9q/4Rw==
X-Received: by 2002:a17:90b:3c12:b0:2e2:b2ce:e41e with SMTP id
 98e67ed59e1d1-2e9f2c78421mr3106773a91.13.1731502707231;
        Wed, 13 Nov 2024 04:58:27 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:58:26 -0800 (PST)
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
Subject: [PATCH net-next v3 6/6] selftests: net: Add two test cases for link
 netns
Date: Wed, 13 Nov 2024 20:57:15 +0800
Message-ID: <20241113125715.150201-7-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125715.150201-1-shaw.leon@gmail.com>
References: <20241113125715.150201-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: EW6CZU6Y26EOJMAWL5UKD4YF3LYG75PQ
X-Message-ID-Hash: EW6CZU6Y26EOJMAWL5UKD4YF3LYG75PQ
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:00:42 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EW6CZU6Y26EOJMAWL5UKD4YF3LYG75PQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

 - Add test for creating link in another netns when a link of the same
   name and ifindex exists in current netns.
 - Add test for link netns atomicity - create link directly in target
   netns, and no notifications should be generated in current netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 tools/testing/selftests/net/Makefile        |  1 +
 tools/testing/selftests/net/netns-name.sh   | 10 ++++++
 tools/testing/selftests/net/netns_atomic.py | 38 +++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 2b2a5ec7fa6a..4c15a115c251 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -34,6 +34,7 @@ TEST_PROGS += gre_gso.sh
 TEST_PROGS += cmsg_so_mark.sh
 TEST_PROGS += cmsg_time.sh cmsg_ipv6.sh
 TEST_PROGS += netns-name.sh
+TEST_PROGS += netns_atomic.py
 TEST_PROGS += nl_netdev.py
 TEST_PROGS += srv6_end_dt46_l3vpn_test.sh
 TEST_PROGS += srv6_end_dt4_l3vpn_test.sh
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
diff --git a/tools/testing/selftests/net/netns_atomic.py b/tools/testing/selftests/net/netns_atomic.py
new file mode 100755
index 000000000000..e6c4147ef75e
--- /dev/null
+++ b/tools/testing/selftests/net/netns_atomic.py
@@ -0,0 +1,38 @@
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
+def test_event(ns1, ns2) -> None:
+    with NetNSEnter(str(ns1)):
+        rtnl = RtnlFamily()
+
+    rtnl.ntf_subscribe("rtnlgrp-link")
+
+    ip(f"netns set {ns1} 0", ns=str(ns2))
+
+    ip(f"link add netns {ns2} link-netnsid 0 dummy1 type dummy")
+    ip(f"link add netns {ns2} dummy2 type dummy", ns=str(ns1))
+
+    ip("link del dummy1", ns=str(ns2))
+    ip("link del dummy2", ns=str(ns2))
+
+    time.sleep(1)
+    rtnl.check_ntf()
+    ksft_true(not rtnl.async_msg_queue, "Received unexpected link notification")
+
+
+def main() -> None:
+    with NetNS() as ns1, NetNS() as ns2:
+        ksft_run([test_event], args=(ns1, ns2))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.47.0

