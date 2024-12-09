Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF10EE7717D
	for <batman@archiver.kernel.org>; Mon,  9 Dec 2024 16:50:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6A82D840C1
	for <batman@archiver.kernel.org>; Mon,  9 Dec 2024 17:50:50 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733763050;
 b=Wb6UCFdMyWdRWDaDA2imhNcAeKOutEEOaZ2tdMTD454Ul1k70VM3P5FrRJFWjV/5W5ypH
 NCGIY3Vq4KcxaenX9GDkWK5GqzEznRRwT7GqwIYHQvyKghs9rc6sa0gZU/0Ox3PEK6HsbuB
 ACAqU4ZSeKtWv1oT3+7fBw69kbwh3FM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733763050; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
 b=JvVGWorxSeHahVyS1o2/32k+QpeDApRY/GwuOYABOTFCZeqDVuvrIX8AB5oKwamb+7bRs
 sglJ1XfTIMLAZcOx6f+x9p7IEEo5aWGXLclBloyctgcv8OEUg3aN/NHVat+ANcotluwTuRK
 Nmt6wlEkuR5nTJ6csjHKeyy9fGNWs/M=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9ADB583BDD
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  9 Dec 2024 15:06:07 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733753168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
	b=Hn2MT2gghIOaLBEHpNtEK2S1Dt0c21rroJtYJ0kB/KaKmqCyFqYM45uRy1hEh51s+rDvNG
	W5YMSsO98fHgzAOBfiHWszk2DVBWKi7q+Z/j/g6m5/FM2RBQ3vJ+EeHw9u4w5aJ5y6PQvT
	kyBwHbxH1lFdaN/caAP48zb3WeAgAXI=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733753168; a=rsa-sha256;
	cv=none;
	b=AAJP+Bsvx19aCAwzEcG1AM9SMxW3+dn9W6aaPGn4cSUC2H4Ss0GbpVoDEE6mz7lfI/K8FP
	qHh9FIkRFFlvi9DgaxyHHcj/D/7KLoAQA+w5McJSnkGpoqH2KKnTFVs+VKB1+0iEsA2fo7
	1nAN623saVIplz/8M3Rq5oDsVQ/G/Io=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=lvjHixRr;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::632 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21631789fcdso10136175ad.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 09 Dec 2024 06:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733753166; x=1734357966;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=lvjHixRr83t4n0I1yB9IsWliO0R/teIEkd5RMNQA6SZR5EF9vwOOZzOd0ChVstLxAk
         7lVHcPthSiBM7lzn78EXWYRQilJJKMLhd5heI7IVMiawoh/BIDRgPp+SgQsAC8aNJ4b8
         hoktwckKN/zX+XZMn1nQYDWhjUWGKqnp8e8zXBjtCY2Eh/zTQK55rOq1khWxuHj4jmSs
         7BPZ5zxOyRue5BgeKEgdy1Ee6qQkX5J/ukjkAz8CwHSksahet8VLIj/DSVVYSsFWyBTI
         xu8XyefRHAk5lDHqVaM+yZ1w35trbcjfkM9vepHIw0uodjCWwTmmAPbCvSvhmHvqF2X/
         Q4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753166; x=1734357966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=UIRPdYZ4vEM4Mjjojo8JbdSokG4pH+EL1RPowteShtcoOG4BuZ+M3hKalQnfrjeKw5
         VWgtNIp59sjr/yCBwJ+jKdCy0RT3WlSiGGlHID3d20lf8sFcMRwluqIdNT1X5yWZUmB8
         iYoNL3vOXBAKDrJVUyUrWiKObAA/DRelJf+JNhGrl3YbrNFSv974F2Oc438K7t2CppIg
         4OLNglDVKDnEShhxjToqOce171yJztiFWPUBEN/9BsWYX5afva9JbCZH7hEZgeA41+lu
         /dFErh4KJaVwaY/A0InjQXQrxt9uv4gPqJxehEP0wkkY9aB4Y1vanpllwMPsW+zM6WM/
         nBkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAD2ZvadJztS1RK/v6r1Zs8Fw0wnzWTmJTlVmcNOOhPdn7kB/2+2ffwG7HdFCk/+Hs3x8UxUjvmIw1Dw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YymyqN6eOBQxI+pmArDqRUBvqI7etgEJq56h6LXVeAQES48FL8x
	tAAbX/T82t6Mbi/Xk8yM/hVPcm4lKC6EEPLcLv17MQ+JyujIEajL
X-Gm-Gg: ASbGncsIdONHT4DmkwRNAsyTT5HZ62y+rycORd5SRBxLe+Gdgj5GKg86/SnKD7HnQHi
	UP/w+0RPopxSFBcc4RSK4sICZ9DYoZ0cS4idmcOtSfnijhsVtB0pXWEWKZjV+fPmbUh8edMlY3K
	dcEzXnW3CqnItpKWWS8YYyKOusxummbhoxu1OPDneZWW1aKgF7XOetsu+iCa0tTeQaiLNSxYZV4
	s30228J9cLI/dOMdQ/SwsEHESx21XtD4zJe+2dOz8wtLwQ=
X-Google-Smtp-Source: 
 AGHT+IEgO+eAsdpey+DR5/LF2b2LrxgYAnjIwOd9wPEert31MRK25WTtIv1pjQ5j1prur61gIiJ4iQ==
X-Received: by 2002:a17:902:c949:b0:215:58be:334e with SMTP id
 d9443c01a7336-21610b3539amr198169675ad.10.1733753165835;
        Mon, 09 Dec 2024 06:06:05 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:06:05 -0800 (PST)
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
Subject: [PATCH net-next v5 4/5] selftests: net: Add python context manager
 for netns entering
Date: Mon,  9 Dec 2024 22:01:50 +0800
Message-ID: <20241209140151.231257-5-shaw.leon@gmail.com>
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
Message-ID-Hash: S3MZCAE55R6O3545M7UCLUTYYXYKWGZZ
X-Message-ID-Hash: S3MZCAE55R6O3545M7UCLUTYYXYKWGZZ
X-Mailman-Approved-At: Mon, 09 Dec 2024 17:47:40 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/S3MZCAE55R6O3545M7UCLUTYYXYKWGZZ/>
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
2.47.1

