Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A29BC021AA
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 15:55:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D59538426F
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 16:55:32 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739980532;
 b=lzYVuhxEiD4C3xlTO9L+KrjQauXY1IFvjU4s+KI5P7CvMTC32prO4hop2GjVQPTpp5WUt
 wdpb41BvyOXpuVTjGhxtLdA+ZbuARIfk+Ors84gv+2sBnd8XRk/10CuGQEACDm352ZwVDsW
 zxU57tbLJSeoKqU7ToazwWwTeQoaR/k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739980532; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=h02RoEg/neSt/B+WrRVdIe6OiEkHR+ibxktqvHMDB4Y=;
 b=ZLDtGP3HWg335tDXuFDPA07LFdXXmULVMCwwxMvM9KcJTlsNDpxFbU7FuXLgfnVY5QTC8
 bq1m0RYm7CiRJqB3XXP9a67L5tohfYU6yi2RGjVUrirmf7icCIbaz03mVGSNbfuDa0hxycU
 qYFocfmvLDrEHa5I0pfwxtaoMlJ79WE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 61BFC8111F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Feb 2025 13:52:43 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739969563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=h02RoEg/neSt/B+WrRVdIe6OiEkHR+ibxktqvHMDB4Y=;
	b=ufHNjgUxLgx3iC5FLlvt491VXO5gqAi7fabU50ZOoJenXkWmqc4KjudXn8LYuhDWeBO+Wh
	gFucDbTCNu5BbxNU2BYcJWyMUoZcH34mDUGfbbUEmzpqLhEG0WrtlRGOgomEV8hijEtAUd
	u8NB08Td8A+KqgO2H5DhoB1jjTV+urI=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739969563; a=rsa-sha256;
	cv=none;
	b=1mQ/+Ov1z5oy4e+ERlHUQEelDjzwvZ4muZjuRr//q6fA5DG6o5yYWifhHn3F0AieG28fuz
	r5djNXw0E5x8bdaMuWPy17jk34erf/nLRBNYgz0tY9FarGawI7WQZO7+Z3ea10hfpiTIGF
	F+FDNSh+6i5GJHpebe32JlKg6p0SWeA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=bD2W1DFd;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::1034 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fbfc9ff0b9so10127193a91.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 19 Feb 2025 04:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969562; x=1740574362;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h02RoEg/neSt/B+WrRVdIe6OiEkHR+ibxktqvHMDB4Y=;
        b=bD2W1DFdaY1x1M/kQqsCpclZFC6ZDIhD4jl7iOi351wwnwWualJgc98rW25awqqmzs
         3kYIoFv3Rc1dn8NHoU/fnUPhyQXKQKW9e4AjIw4NWKQ/4T2y7YTo98PhlZsX/0aPbD8k
         3U3Q0nkjm4GoeRah7XLMN4kBPPTUJQU7k8JycwiTtg5GI9Qa9zuB4YTTBLjWbbc5UO1J
         wjrC+zmr6ht7vP6WD/arCsAB1/zH4CS3uADfSu+kYy1VHzIwLl4b8FnYdioaEG3Q5IOr
         9eF54WKjV6d3oS/QeJt6US9tRFkCMbU3GgEPAzLYNSfUtZioxha5aMxP2wN8zNjBaky+
         6Hlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969562; x=1740574362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h02RoEg/neSt/B+WrRVdIe6OiEkHR+ibxktqvHMDB4Y=;
        b=Etllzn+5AQ0BoSBfYg9HUlDbPmmP9Sna+cLhOIHYS8DF8vPcW/vjc3TfoQ8RzNtkUq
         7VdvZGjvNu73qiLS7hT3m2S+MUx+gaNeMV4o022mSjpHW2VTG+zVuB77/mMQUNQjCR39
         kg5b3O6pN3NovaCxiUw/Zq16eWKkLDBPwX+MdgwZlqjkM2EmuuUWOAba3OZ8wiJ2v2wv
         uY+FokX0cUqEUPvnC9niVEWlEhgoW2301QotfcHjyoh84bPMzZGD/a0Pu2YKmo8QwFbs
         wdxhEvsv9p20XwgJetLZbfmAVuGv5P7lGQ1cTX+oI/dvs+hMogVLB31Jsw65kJkGVQ2r
         8onA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvmsa+igr2+MLcqq+ZffMarFdmR0omCCWwooHbAJ//a3U4n9fTTNXCNwTG3T0UIydIV+LOI+5hhaPJPw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yx2uxHc6hu1cHUNa1CeRHwlwY7wIgE37h2D+zQ0A8GmVk/jl6Is
	uKuUwx3a+HbssyYv66py+TKoXXE59gkBhvqSxhh+fGNKsM3yrUcm
X-Gm-Gg: ASbGncuHejUkav/jDxGSA9lHPz33olEIHWwr1J4BNCtpmgix1H7MDeOYYPbR+bgQ5m8
	3uXpmB/pvymZ7d+kUWMDiILPkApR90DqmZblRy4QfSoAyzPydBAQavwfaCkh5ayN7Y5Uz0pYlys
	jTMz33LKkHCYQOZ1bpqIZH4YQg+FHOQQ6wY+CtJbSKgS8MopLBMUUFIAoJon2F7veyUCIQgIi34
	BUTrgxJ3rBKOOTZNue0r5DOzuCKrvqo/SrzEhuuAXUCkK9cjRE9TQAobKOBM4dSL09BqdQMvExY
	0lfaHA==
X-Google-Smtp-Source: 
 AGHT+IHPqeS3VaEOgvZ8Tx3PUVaGMIEIbKpPjORqTeM6yeMS+BbAs1PKrGLT5/zDq05f9NI0VnGgXw==
X-Received: by 2002:a17:90b:2887:b0:2fa:1a23:c01d with SMTP id
 98e67ed59e1d1-2fc40f26600mr24663034a91.21.1739969561721;
        Wed, 19 Feb 2025 04:52:41 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:41 -0800 (PST)
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
Subject: [PATCH net-next v10 12/13] selftests: net: Add python context manager
 for netns entering
Date: Wed, 19 Feb 2025 20:50:38 +0800
Message-ID: <20250219125039.18024-13-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: RZ5LZLAGIUHDH4YDE5URMOPG6U7GXE4I
X-Message-ID-Hash: RZ5LZLAGIUHDH4YDE5URMOPG6U7GXE4I
X-Mailman-Approved-At: Wed, 19 Feb 2025 16:43:08 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RZ5LZLAGIUHDH4YDE5URMOPG6U7GXE4I/>
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
index 729457859316..8697bd27dc30 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -2,7 +2,7 @@
 
 from .consts import KSRC
 from .ksft import *
-from .netns import NetNS
+from .netns import NetNS, NetNSEnter
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
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
2.48.1

