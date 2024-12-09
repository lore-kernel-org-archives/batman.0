Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F14E7717D
	for <batman@archiver.kernel.org>; Mon,  9 Dec 2024 16:51:38 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id B9FD083F7D
	for <batman@archiver.kernel.org>; Mon,  9 Dec 2024 17:51:36 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733763096;
 b=FoVUDBAypNxtVQDsrbYQSF6Ln2ejK4fbTMKgJ6mbaJIG37zhb/JVn9AsZn/PAEQSJSbhm
 s4qFUTS3rBR5BFnNv1+2Bt88wJfQk+HSUs0ZWe5Crz+zTm78OyPIM2EMAu4p6nPB8HpFSmm
 ZwuExKFOloHKTMsB3PXSJngPVt75ZsQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733763096; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IZacjWdb8RyenSpXv6Caz5kcIhA6mwKRd5G/S3r2hOU=;
 b=ZJT0LKkpDK1DIsRSeY5bkJcha7w+Dhn5aQ7yKtP8Nn9DsHG7VCHbBUy9IH65yuYogbpkY
 IN++dJQgfoNfCvTAMQRALr7/a4Eg7dEvQ180d7UcjK2fO9DwMCvNqK5bdldAkS/WK1a3+xi
 OuMmxuRfGFONvqDgB0WwZxw2ggMiO1A=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0F47683C01
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  9 Dec 2024 15:06:15 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733753176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IZacjWdb8RyenSpXv6Caz5kcIhA6mwKRd5G/S3r2hOU=;
	b=rl5ujaVS1OGMehztd+jUum3h0JVXa/+XNfkmS7RIwCmiDSMwUIp2PVvvp0D+jZFvw9K0RY
	udCICbADQQNT9V7+hUBqnkB34MW3p0kDuSchzaBkD7tyUB655DjcqfTcEQb1wUnAmvKuuL
	u9hL2HxreOup+cTDbQGqfbjL10QPQLk=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733753176; a=rsa-sha256;
	cv=none;
	b=lX52C25ae+YrxgV4UBIO9lY63XG7r5dU2ndqfYPUN8NWFe+v1z0UAQjUnBAh5UPRbcb59H
	MOYav29Oln+QEbikfuwVsJOG197EjtupykQk30CJm0hTab5d2c1OXJVs4Rqqc1zvPpeyAD
	QZ9gwexpBnMhrQJFAogD2A8gWXmjoVU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=XayYTEes;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::634 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2166651f752so4327835ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 09 Dec 2024 06:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733753174; x=1734357974;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZacjWdb8RyenSpXv6Caz5kcIhA6mwKRd5G/S3r2hOU=;
        b=XayYTEesNnx7dMRYDMAJzyJIbacyzfeDyBUSerr94HoKo/UO3uh84fCpUf+AJvIH7M
         n3YhUZoh9drL0Dx6aRuhP8sgsR/u0nJdt4ahWeAb2VZ3A0gZwInboo3kysoGONAr6xxu
         eOfgOZE2ehqR46tF9itHAcDQuWw9FvU8cGgT6MNjqlbWHrEvXarCg/0XPPdtOlqIQ6Ix
         nmVGEYanGiAw9wZf3whf9h3ZdKrPscISjTBYqKn3LU0DrNUdUHw/cet2BDvtfRA4AyJj
         5gCPSm4QTbWkp4z2uSLD0DpRDHvS6pcSs6uxL5PO594WZEuuvINuIRkZpVtzfVE7FGtt
         DAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753174; x=1734357974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZacjWdb8RyenSpXv6Caz5kcIhA6mwKRd5G/S3r2hOU=;
        b=KP4O0xbUPGjmGpCF4+dqUXa4OM1bxx9TmP5RTW2VFppB/0P1J0JkDxGGdfVmPLyfpG
         +VGYStFkjfYsiqS1QixB5fVDxowgaUGYpuJhacmDYnxu6DRkd3GmN8YAfx38Jy8KSN+V
         e34EJPR06xHvcNGf4rVd8jhJB5rctL7RlOPdUA0k19PkTxHCvUs2iu5cTH8elnPk8RLo
         uebKPLGJByJZoo7l3ninuTMGhcQECDgzNn+uLx6rm4phyFQsT4iOZc/JAbbZvartHsx8
         wwP3wmYIN8my8Y8JqdoKn13SBz+RZYdSTecEzvLlC3gMjU7e6fWS3x/pLG8rLoSHl2g2
         BdZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWBRDXFa67ahQGvDu9yGlxc70I9uFc7IzWhWMv802RR4KJpQ9Av6+Ag0e2TGFFcHsjtiBC/FascG+243Q==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxQAKUd7xZdzoQQzbQjZt9dhXgoviep9anoabYQvuvnOr5X+XSz
	XLNQG9wHmHg4Ut4XEl2owzmG+AVK/kMnBBQux+RQUvbVy5FnjFqs
X-Gm-Gg: ASbGncsjdy0llWtbPs55oL0qP54GnLM+RXlGTSxyfe+xbsctYXvTo1oGtUewvt8Tz2K
	yMjv/szWcPverpyL7XW3GEbc3qsVyXpwhAjQ7QIjhRr/7jNIEVeD+GIKiIpYCtsqjnJ/Q9zYYtB
	bISuqgtUP2PB4yEr3BpNZWfSK4ZECDYbSeT2RLjyl2VAnB/31aiTOwSfhH6CfS9QWhl3YM0JsDA
	CXKqc3hN1dNhAgf0gwe14PJSk0O8TiveoQcSVDio1FwhGc=
X-Google-Smtp-Source: 
 AGHT+IHmgSwYi0f3YPXZUnipKY4/LE+6y74m5MtL3Oj9+h7tdAHjZEgR2L+TFdRwx2htNJ1fIiOnow==
X-Received: by 2002:a17:902:ce8d:b0:215:a2af:44ca with SMTP id
 d9443c01a7336-21614dd2374mr177498285ad.37.1733753174431;
        Mon, 09 Dec 2024 06:06:14 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:06:13 -0800 (PST)
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
Subject: [PATCH net-next v5 5/5] selftests: net: Add two test cases for link
 netns
Date: Mon,  9 Dec 2024 22:01:51 +0800
Message-ID: <20241209140151.231257-6-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209140151.231257-1-shaw.leon@gmail.com>
References: <20241209140151.231257-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: BYCVHPNKHPSWJWDCQBD673O3GQVZ2ZII
X-Message-ID-Hash: BYCVHPNKHPSWJWDCQBD673O3GQVZ2ZII
X-Mailman-Approved-At: Mon, 09 Dec 2024 17:47:40 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BYCVHPNKHPSWJWDCQBD673O3GQVZ2ZII/>
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
index cb2fc601de66..f9f7a765d645 100644
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
2.47.1

