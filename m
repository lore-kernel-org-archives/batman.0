Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66494D49228
	for <batman-adv@archiver.kernel.org>; Mon, 18 Nov 2024 14:49:32 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EB2E1841F5
	for <batman-adv@archiver.kernel.org>; Mon, 18 Nov 2024 15:49:30 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731941370;
 b=IyJE1j5OXZQuan0D6MM0UjfnCSVW8P4ZQt2O2N/SyS8fk9Bnq52Rt54k5NuozOAC8GxvF
 V1PmynS19QmfMaxhqzkBk01zZgGjFJLYDyiAJCWHl/rUQzg9jA/aFKFANSXrDbVqZpE/aiO
 GZlTZQoIy4G1Rx0ryiGNjmUvY16evWA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731941370; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Mad+mOcno2P0CIpC5U9uxqbBM+RxeN4q/RBh6+yxx1g=;
 b=QZDJFb1iWMpr6gmaeVEm+VQG2/uNFLVs0nKOm/dPaOQ73AbS0jm7fXpydPaMRMFUJnoBg
 +D578XYRLZ8r3HfTsEnVmSnh36uVvNqoSVQU+ci1Kof/BTL0IpiblPhGwrItD3qa1+zFwH7
 27VYtHGYtoqkMwRSUK7GtK74l7sAeu4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 4F5CA83AE4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 18 Nov 2024 15:33:59 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731940439; a=rsa-sha256;
	cv=none;
	b=UTNcEZP9Q9OcAvjfGlHnLKw4I9hDVF/3MmOZZgQtmXL9fKe1CUcfS/9MHsytovL0S9fIC6
	zK5naL0mfA0hrt7V0PZIHNZLHtwJ8s3A2FjFRveU9a48o5J9cvs0NFQISVPQrgNq90vkKe
	tahx8/KDshkYRclkoP084MJ63hvHXeQ=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=BAFwlVxW;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::1031 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731940439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Mad+mOcno2P0CIpC5U9uxqbBM+RxeN4q/RBh6+yxx1g=;
	b=HxVsx6ldVNiqRYE2NQ34UBz2NmDuS/vS/DmCrMsqXdsBRfjRlv5S3hpWw5hf9b43e0Psoa
	OyrPuOY2uwAtonK2dWf4Bzk3zKWEfXOylYa5ATZ/ZYeDKdXvt94R8hn6DhS1VZ5HLn/cIE
	8R/82ZCzdqsrDgP5qHvADM1Vw2Aue2A=
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ea68cd5780so912369a91.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 18 Nov 2024 06:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940438; x=1732545238;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mad+mOcno2P0CIpC5U9uxqbBM+RxeN4q/RBh6+yxx1g=;
        b=BAFwlVxW1N86hPxqlFX704SwiX+IXfnyU3r8Ct3P85An2rN2XHBHwI6b3uVR5mfp2m
         9y4CFqbDY4VxxRG+1N7rkihPU4s4PxwFWnMBOF/gkHRS2J4OhVB4Skw933VVsikAtkkB
         uHvBTGrMaewKrwcUNr5+EJTaKNJX+AgKbnezpx3P+RCIUqn5Px7O8vbweoz4dNc+vXJb
         or+oRghaITrwpOFscflq4rhmFmq2TgHAS9e7diUfpjePF2NJTe5bbaY4860fRcOE88aI
         HiikyWbUwp/GqgypveATlaKDfpUSM0Et3AoySaqWJiiIsnLhTCYMD2JD4i7I9s7qQJIu
         gkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940438; x=1732545238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mad+mOcno2P0CIpC5U9uxqbBM+RxeN4q/RBh6+yxx1g=;
        b=WwIwk29ApDf+sdpRhJS2eoLB+kTCYIN0OuE9RrXhQAoGUJXNQO8oWvGCKxkoxCN1Ex
         lwwPlGT5SVAPM8+q9ydG2sOuanl5S0g3WKmvfvpcMT4UeOPD++pt35yst6vtKj4crLt2
         hjdMmTXS8sP9X4hWylKJn3zBMMZm+3JaCOPj5sjkxSSs5GAXkINwJAI7yr6DZSvEOkt8
         qYV8QH7tf4kawkpmmtabXcpv8ByZFm+hWXYFr2DpZr97fw75vMkKU1uWIXpQceSbhwOb
         GEgexB7hQcw7bjbs0cr88xOSB4gnrkazA+Gi2mOWhzSM2aiHrvPw+unOfJiUQQqlTiJO
         gG6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO80YsuWBTueHrZq8ZGAJUNwcLUvIxfaOeMsrLzDJMwjYdGZFvv9hHavKwJN1uqnLF+A4zqNQ44uM58w==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YyTWWXEmMCqnNgTXrepAIl8Zc6LluyVirU0T6H1JFhAQib3wjPL
	N0FRe4e3ZmIQrgIEQeykB0LiAQh9pFI1HTZrasY/q3b5APdY/nE7
X-Google-Smtp-Source: 
 AGHT+IF3SrGnsKmrF4jvHwe9jv6er3cYNAFkQ6BmUOZb81V3DDpEwoq4AchAw0/egZEddY1NEy8bEw==
X-Received: by 2002:a17:90b:3887:b0:2ea:98f1:c172 with SMTP id
 98e67ed59e1d1-2ea98f1c2a5mr1425759a91.7.1731940436264;
        Mon, 18 Nov 2024 06:33:56 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:55 -0800 (PST)
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
Subject: [PATCH net-next v4 5/5] selftests: net: Add two test cases for link
 netns
Date: Mon, 18 Nov 2024 22:32:44 +0800
Message-ID: <20241118143244.1773-6-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118143244.1773-1-shaw.leon@gmail.com>
References: <20241118143244.1773-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 7V4VX3PKNJQOUPZU6J7752V7CRXNOKNZ
X-Message-ID-Hash: 7V4VX3PKNJQOUPZU6J7752V7CRXNOKNZ
X-Mailman-Approved-At: Mon, 18 Nov 2024 15:46:13 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7V4VX3PKNJQOUPZU6J7752V7CRXNOKNZ/>
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
 tools/testing/selftests/net/netns_atomic.py | 39 +++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100755 tools/testing/selftests/net/netns_atomic.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 3d487b03c4a0..3aaa7950b0f0 100644
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
index 000000000000..d350a3fc0a91
--- /dev/null
+++ b/tools/testing/selftests/net/netns_atomic.py
@@ -0,0 +1,39 @@
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
+    ksft_true(rtnl.async_msg_queue.empty(),
+              "Received unexpected link notification")
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

