Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2F8D49228
	for <batman-adv@archiver.kernel.org>; Mon, 18 Nov 2024 14:48:55 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EBA8183F97
	for <batman-adv@archiver.kernel.org>; Mon, 18 Nov 2024 15:48:53 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731941333;
 b=b4+9aCHVWo3qlbIlsbos+rpcUZKuoTbHtIhisTEY5j0U55QqTgjs0ymiwPlPZtC5SMhe8
 iX+dRpuz5PWSwMCcgkgQWwFayG8ZpgnPDrpQ3ilpOHb5crpkqKB+UOfei+Ga8utBYaRIiF/
 d1JrnP4Pw0e6tYqREVTwW3dAVV4ettg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731941333; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
 b=gJ+KhEYKofY4D54oNHeW7tORsBiAcL2aNyVL9lPvwLWWrVGi/my9xX6TLdf7qhS6/PlDQ
 0z3yhmZxvqadGtM0zGAzDBf+8qpBevmyAZ1xZKlNtgu3jQd433Cv7ittwVw5puSyodBDLJF
 35IyqlCxoPRNlfFeCVreA3GPalYsZCY=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 97EA18358B
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 18 Nov 2024 15:33:49 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731940429; a=rsa-sha256;
	cv=none;
	b=RFNQVVl0pUwHrfJRA8JDehh8WFuQGZ+XDYqw8Q4pZ4FpRQnaXNMswTGRvowPYv8DEXaBlO
	BjzRXVNIEGXZiSvLJ1Kbv6I/wOmPSqhozN193fh7Tp7QGOcSww5/6eS/6RFpntSVQ9A6Vl
	REORioos8JFj7yKgEseNZ6IwGBAoHCk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=iRVTte+A;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::1035 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731940429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
	b=0x6fxypNVy6RtX40fnU4bA7Gi9gIsx/LprT+rzIzIkvS+Lmgmcy6eWy/g0j5Zgbs5LzitN
	EFqhK54FZfUVxAuveB1EXer5yxa7vwIpmtNUXeEvI+zEHkwWE5xtIFgq/msIX7A6NG6QTB
	/AukHY+7JywMP6guLnekYz4PNST1Pr8=
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2ea4c5b8fbcso1041234a91.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 18 Nov 2024 06:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940428; x=1732545228;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
        b=iRVTte+Ac0VSw9Qn1OQOSnCxafE2URCu+6UrQ/k+nYLct6M07TbSo4RjeSe7/ToLqt
         gbb42D9ZovhVh4oNtttLB4k0BUcQWjgoc6enOVAOrb7YYnxM0/6p3tuw01iM+A7ypHGY
         JlT8KJn9/RyVuW7eKy7hCKW3SZyvuIYIFshjRpId8wZvuwbz6aKHQ3/lUE31qptxXnFs
         uzfRgrALabPZv8c9ujGJRiIenTXdLDj4Pe7seWIv07NeCEh/wk7Rm05zK/hRqwUaHzBH
         RPgpBalcmlTlWawRdW6BL04JAQVllo0RErMa5HsKzyBrJb4UA5yiGvhBAyS97AdjnmtZ
         6prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940428; x=1732545228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
        b=J++s7uQc0ReXkXFcOKfipDxgRlGBNwcSrJyHkRr6zE2oT98hzbOTerf4rgHLVOg8/e
         yMAGKRjb/p/BE7bkIxUgaBaqYAbQ82J8PIH+YVkf2zdBLe5m+IDeh8DdPozzNiHUdP2R
         DiUMm7SHKjS/bXqjrALx3CbMiwn0iDThOiEv+cQkB9hEi56ETLBNuKRTEsO7Vfu9a7BE
         Gyu8Aw1vFmL7myEy6HkIDeSvlPemG+rVxjcs/8WX5BiQbpn0+dMWZ9nd6psjjF1SjIme
         Tk/+kGm92N/Ds9aRclS1nvH2y/WVYLNGYysEybBsxhIUflcfo871OOAg0ATN8+I64mqK
         /sJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUA63oIzXBkrGjWvCqMNmG9J837v281ax6pE2d6PXHnP4GumEXeXoOyL0kXaRAkOkz9od5lxGs4JBZzUw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxMXQNcZB2gc3RPZZKX4P2BatprSdCqla/JazKL674UMl9Tx0/x
	uxSrfRmU3BdTETzSQzPfF1Zaf623JvrkVQMNZEL5uZJZnjfR4oQq
X-Google-Smtp-Source: 
 AGHT+IEB4OLbXUI9lGpusUMTTQj7CZMlri2szirQ6bOEHE+aXQRtMaJMjzV66+oDEF7uQxq+tjw2ug==
X-Received: by 2002:a17:90b:4a87:b0:2ea:7bdd:f320 with SMTP id
 98e67ed59e1d1-2ea7bddf3c1mr5084481a91.1.1731940427545;
        Mon, 18 Nov 2024 06:33:47 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:46 -0800 (PST)
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
Subject: [PATCH net-next v4 4/5] selftests: net: Add python context manager
 for netns entering
Date: Mon, 18 Nov 2024 22:32:43 +0800
Message-ID: <20241118143244.1773-5-shaw.leon@gmail.com>
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
Message-ID-Hash: CJPE4AMAN36YYMKWQ2LTETMXSLIUD37Q
X-Message-ID-Hash: CJPE4AMAN36YYMKWQ2LTETMXSLIUD37Q
X-Mailman-Approved-At: Mon, 18 Nov 2024 15:46:13 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CJPE4AMAN36YYMKWQ2LTETMXSLIUD37Q/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Change netns of current thread and switch back on context exit.
For example:

    with NetNSEnter("ns1"):
        ip("link add dummy0 type dummy")

The command be executed in netns "ns1".

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 tools/testing/selftests/net/lib/py/__init__.py |  2 +-
 tools/testing/selftests/net/lib/py/netns.py    | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 54d8f5eba810..e2d6c7b63019 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -2,7 +2,7 @@
 
 from .consts import KSRC
 from .ksft import *
-from .netns import NetNS
+from .netns import NetNS, NetNSEnter
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
diff --git a/tools/testing/selftests/net/lib/py/netns.py b/tools/testing/selftests/net/lib/py/netns.py
index ecff85f9074f..8e9317044eef 100644
--- a/tools/testing/selftests/net/lib/py/netns.py
+++ b/tools/testing/selftests/net/lib/py/netns.py
@@ -1,9 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0
 
 from .utils import ip
+import ctypes
 import random
 import string
 
+libc = ctypes.cdll.LoadLibrary('libc.so.6')
+
 
 class NetNS:
     def __init__(self, name=None):
@@ -29,3 +32,18 @@ class NetNS:
 
     def __repr__(self):
         return f"NetNS({self.name})"
+
+
+class NetNSEnter:
+    def __init__(self, ns_name):
+        self.ns_path = f"/run/netns/{ns_name}"
+
+    def __enter__(self):
+        self.saved = open("/proc/thread-self/ns/net")
+        with open(self.ns_path) as ns_file:
+            libc.setns(ns_file.fileno(), 0)
+        return self
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        libc.setns(self.saved.fileno(), 0)
+        self.saved.close()
-- 
2.47.0

