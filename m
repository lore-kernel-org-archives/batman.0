Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC73D41C3E
	for <batman@archiver.kernel.org>; Wed, 13 Nov 2024 13:04:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5E1A38402E
	for <batman@archiver.kernel.org>; Wed, 13 Nov 2024 14:04:27 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731503067;
 b=TMqhDfGPhqt+mt5QeZ3fgnRTG1T9UVZlRNkFz0zqyimLEGgUTjvQf+rtMZikSDiC8eexJ
 77GR7KTxaak0eZmBv71SIffg41gJOb1CDv2ZSn4kTdm45u8zz1U08ZFtpaHWCy+j1wo5NIB
 eZAlPgcOoczJLwJisAW0HTl/OXOre5E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731503067; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
 b=ZVK8ArLnQR8q+GHL+G+i0kbxFnNAnUkEvqrdhb12fS4M9vlH99kbsG2ZQ4QoRDEVLq2cL
 gHsXpxJ55VdFgbMVo7wK/kKvBI+mWKRmlKdet7Qqicbx64WduzxywVXmzrpgKTLaw9lvt67
 fpZP6+zobtXtk8ZaQ3XIQv35y/hiHTs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5AA9C83324
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 Nov 2024 13:58:20 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731502700; a=rsa-sha256;
	cv=none;
	b=wqnsAfB5qP8rqvhxLu4heCfxb30vlyaC3e2jvhh3quprqbjezl9nMePdmvUZieBm5++TOp
	9tYyY0PUPNJzYPeZeZpwfEBreRKN2x8sTNC+a3iXRi6oTpAZjCXeVSgoBSMSxETkJ21Nu6
	9NhhZy9hXYDga2vip9VZwuEyW8Y1lcU=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=cVW4AJpG;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::1031 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731502700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
	b=T2TfZWCsiQQtKMRIYTk/eZScyQe62qjfePMCGN1kKSGBXUBW6OtG0hVPCSxwPBupmMvBTj
	Y9Rb0S8AodD+5SzVRwcnQtw4gPa2cnYmwkKy4inOIsDSNCp5+iWcRRc/Nte477tb34Cs0F
	mtGlnw57SjCKntO2ueJoOW3/zL9MqZ4=
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e2b549799eso5439563a91.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 13 Nov 2024 04:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502699; x=1732107499;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
        b=cVW4AJpG0FRX00wwAbBO5miqps5iTLEC5/Vs4HWPonYJ7HLTFB63uhKYdd1qw7gFZu
         NK9cMykciQxl8vkWvOzX2qhzxAsoWUw+ss8xGoVAZAJI+blid9rDxlwENGOfFy4mKn+l
         UrWKcm3Bi02JJSuCajqNkQgN2SsAeh4DsyfglDQEzgpt0ZM30lvOpY0S38y2up3a4Ukk
         eYvO5zXo2mtTgpszfWI/DdtEtT1HoPTCPQ1GyIWK+kb5Nky+JNDLQFkuu6DMF/ZMnorm
         WgKcyIFK5/vZHE46MrfGvdZ/Yw1u5BMyC7pLIziTFVa9n6N7MUOqkUHFUge9JNHnFBjt
         b6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502699; x=1732107499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dFTsOSdSHxPXXC/kmCtPA19UOd1z5UErpUP4tQUDFm4=;
        b=XwigVkUlJO3Up7OO5JNSjB0rD/8Kmk9Do8tgKmJkHzQYLZi15T23EsYttcStWa+ZGM
         P9XAI7yBm+KradWfHhlMuWA8twc9w4TPI9VXfCuoSLCmgsadG8qsvYyMo5POu+rywPKA
         xQbox+guCtnHiTGVbYJb35Nr2QwGsnZQeQOkjvOZd3vM4vwD4geohPXTT0ShosBWL+mG
         25NoI96tYBZwk9zz0Uj1tOM5wbrymX5yl7bmcC8/uFh3cFuvE/t5c7c1JezT0/lQ/sPe
         RzeiuHXLL8oA06EzQJCvDHdBl20oB+lgjsflbd3KTENAzldKJRFo74RmcO3tqlBkON+S
         qx4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd1U0nyCdC2ySmPKq3lYEjFLFxnXiqc7n1RbP4DIYGB+AT1R4p6olBTB2CiBww2R9tt6yVkMCrhh/C4w==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxrTmuXFi+jSRJoNAmd+B0CIyCl+Gr9EMsVmIV+NKBCUxbM53Ql
	J0oyEeMQvbPTm//cPE7F56SLLdAMcfmaKePoGF7UkWc//N2zfyFw
X-Google-Smtp-Source: 
 AGHT+IG3aP3jfG+H+mqTGfWaQF6eC/hcm8KAxQSToRubUMwTZod3v43r/5qYZbnllxo9jc+4RsAB2Q==
X-Received: by 2002:a17:90b:1810:b0:2e2:cd5e:7eef with SMTP id
 98e67ed59e1d1-2e9b1773411mr26583707a91.27.1731502698852;
        Wed, 13 Nov 2024 04:58:18 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:58:18 -0800 (PST)
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
Subject: [PATCH net-next v3 5/6] selftests: net: Add python context manager
 for netns entering
Date: Wed, 13 Nov 2024 20:57:14 +0800
Message-ID: <20241113125715.150201-6-shaw.leon@gmail.com>
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
Message-ID-Hash: IWAQHIVSK3Y3GYHZIVR4FFIQQNUVAYHX
X-Message-ID-Hash: IWAQHIVSK3Y3GYHZIVR4FFIQQNUVAYHX
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:00:42 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/IWAQHIVSK3Y3GYHZIVR4FFIQQNUVAYHX/>
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

