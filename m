Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50BEC0219E
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 13:44:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3D92284280
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 14:44:12 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739195052;
 b=DwVCCGtndtL9emYNVwgA4nGAnLhEFNVq2qCd+pwoIi8GyFTWMVfG3hAV+zbgN7WLXF1tm
 lKhXHls6ZFD1PFJ9LyQ5a7gTSKXH9S0q6FqP6m0sk7tpuWD/ooUfR00JJtRqb0cBNMnqqqd
 nC1/MtaHuA62J9AJvow6bF2zkDDushA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739195052; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=8ke0PFn5ns0UuVrqND5gWG1VnmGxHj7kcjuhyXJXO0M=;
 b=vT7vQumSigh/1IQdn8au+5XikmQDTSAGrDEwUJ5vStmVEQcjsEi64yB/V1kZgZzVLwu/b
 IqwaBlmHJsDlrOJk3KIVXYh02K+s4LFDg6CKQ6Orh18x/Ysk0NiBVu+iY8H4r3KDq8iAIUP
 2foToF0andcJyUc6ruJzTJG48USFKiE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B815383F53
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 10 Feb 2025 14:31:49 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739194309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=8ke0PFn5ns0UuVrqND5gWG1VnmGxHj7kcjuhyXJXO0M=;
	b=GfJzyG7Wzb/8e+3HD3DagVK2pU9tpqEjnJuCexOEt7ngBTQ/aGLEqpTHAf1P51SMJ25fWR
	K0euFgoS65tX1SY0GfVuzODWShHWRpFz3Rq7T3RaFUhmAPiKVJH0DxiSnrS3tNkOHuSKXz
	nEvXB9zBem9N6QkW/97eyJBfOpTVlBs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=Hajw2fSD;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::102b as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739194309; a=rsa-sha256;
	cv=none;
	b=2Iqz5j3z7shmrbNC0vIpnp662/HoMF8GVTexWjZRdD7LXeuOF8hveJhnch6F+bQcMWhu5J
	PXs4oXFhlYagOGtogjTNMHd9H1tK7f9qRLHpdWOELaBF0RY4PHZ56rOMUKHU+KZhnlbZ0G
	ORSVrIHPuQko5e5pP8ojBWawh3jDRaQ=
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f9b9c0088fso6828283a91.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 10 Feb 2025 05:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194308; x=1739799108;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ke0PFn5ns0UuVrqND5gWG1VnmGxHj7kcjuhyXJXO0M=;
        b=Hajw2fSDNxWt6+AGsbREMVNGQ3vb5v4ZIhTMpyW+aCRrH63FOd6Xvw9KNchynzwo9+
         wiwusI2II/OXzYmZdRdP3bvMouDb24phBzIG/33md0m0+Xhq72JuJ0G2WheQEFbFInyM
         qnJhcj5UC9w9qyiYvQte9X/JAbs8cgFc9FJfNt+Lv1DaL4cLg9U+/kuJ6/spNmeN05Tq
         gYOaqfUJUNrPVRbFEEn1hP26bVfW4EQ8Y45Y45rBEPIM+h7Kn03cMWCYd5LmIbQNYgNr
         OqS5NSrVoPZtx2nMIqnCC1A9eiCwtqZbUc3Isya7JGs5WOdc8WxLgK6mGLCAQFedaUAp
         BtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194308; x=1739799108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ke0PFn5ns0UuVrqND5gWG1VnmGxHj7kcjuhyXJXO0M=;
        b=sKSV0MHmQGhOAbGB1JgoHtiept/HQmO8ZcYhybwb2e8x2uhcBRXbiui6Onj2LUkT4W
         7uq8KbLGphiH2mw3LX8wxM46BSbBceDpJ8aFKOP7tpYM6tsIZy2l1rJ6D2SHCNH4VMDs
         xjwauJZXfb/8+Inj43CT35oOOBg/neEpBIJN5FfTw0e7Q1U+vh4SE4j8tE78fKH6ydBH
         zxOVpedulseHcCwyCAZre//D/VPYA+rJpWWv/PEy8v9EV+RNVHbyWmJF7CXdVRyeBZg+
         t8PzW9t8kAm/aeWqwpEp9+IiZonsm3v9SdCiVhJdO8fvKpmpES6SRqDT3Ux0G9cGIjxB
         YTQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF0RdOz98loTTO099CtlgBp8XtnmD+o+WyqnSLP3PzadMr4OMPcKnMgJKOUoZNa4H91Y5ZOizhCiVV3w==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwDUDdEbWvaN/OHn5wia4nkVRNJvhV+RdA8O4CBoDV7xULCk+5d
	sB3CjoltXM0WjrZWvQLLFSEOWS+OQs8bemPbjpuZUVS/OAdCFqvr
X-Gm-Gg: ASbGncsDnBUXH8R+clO1a7tBagXTxtaYriMlR363dgcA96MYFKKJg4nPECeAT9osY3A
	s8ni0nkBmqFkdI//io9O9MQN66kOzAXI5949bXLojLcd2Q73VZKH4UOKLUdOR/JgxZRJArXPzrx
	VdYrI8ev6kPuiN0mSwl0bDN/FZg8z7R8TJnZYpx5SW1P6npb4ZZPFbWgUjqrbHrntn529xh1mRv
	2l2phGrV2s33HdFdbpxK6rqdu8RvxTO7aqf15GN2CKuwHk5T6+P4728LNYqoJVu0gaS+cLv9Eh2
	ZT6v8w==
X-Google-Smtp-Source: 
 AGHT+IFPiBsnnOAy2e8DGACZaeMc4ZZCgfCsAVv3/+u7QA91zVdRjIX/zkP0E7/3XIVhHqlMh6JYtA==
X-Received: by 2002:a17:90b:350e:b0:2ef:ad48:7175 with SMTP id
 98e67ed59e1d1-2f9ffb7ba83mr30255082a91.15.1739194308152;
        Mon, 10 Feb 2025 05:31:48 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:47 -0800 (PST)
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
Subject: [PATCH net-next v9 10/11] selftests: net: Add python context manager
 for netns entering
Date: Mon, 10 Feb 2025 21:30:01 +0800
Message-ID: <20250210133002.883422-11-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133002.883422-1-shaw.leon@gmail.com>
References: <20250210133002.883422-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: PXFLW2XIHTB4JVAMACSSIDHRJAD7K3JD
X-Message-ID-Hash: PXFLW2XIHTB4JVAMACSSIDHRJAD7K3JD
X-Mailman-Approved-At: Mon, 10 Feb 2025 14:36:14 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PXFLW2XIHTB4JVAMACSSIDHRJAD7K3JD/>
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
2.48.1

