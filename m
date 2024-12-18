Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B22E77187
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 13:20:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 6E49383FBE
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 14:19:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734527999;
 b=dqG844KdMTHEwYQQPt4JiXlt2MHK4tjujpe7/tikHFWBRqPc8VyGPc3HJ0koYMA0fGjoG
 5lX0rt1CFnc8CnHwMK62S3K5nLd0TsEUMvKOhcXqjynMSrz6j6+0Tl8N3DoMASbMzAp8W9Z
 R4dllHPOg4CYRFb4WuPphINGejLePIY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734527999; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
 b=fr41ihmMzYfqURobyhf1I3V1YYMSb/SblgfRh8gwpALrnNIIrIub73rnTjhOJTbW1sPOR
 5kALjnNFPNHvtpGBB99xQAue+ngwjU79d0n0YKR0mmtPI/OodgesV2JCX9a288YyRQLo7+I
 qD8TOZ312Ly8SwVvK/2pRK9lo+n9VN4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EB483833D4
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Dec 2024 14:10:47 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734527448;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
	b=0M7We+N73GvmcSLSF1edHse/5DfoVv2tawykpRO2yfCg6gQrXecpZU0dWh4gMmWZoznu9J
	kqxN23jQcu/iZ8yfLcsrkA/ZsshlvFd144IDBW8cpatMPtQloE7+NRPB/vmxm3IHcGpGVh
	brxfJhQUgTniGPO7Ld78dj7AZWiDPWs=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734527448; a=rsa-sha256;
	cv=none;
	b=Hq515R8AW9VJnCtu7YVzmaUfMZP2XET8oNu/qNB7iM97rqLXIxZFPXt6Z7kGkKy6/nfOaq
	NKppv9OeKM0gXL5stShi1WrMlxHJIKUOmMErc3UGrYWSD9HoHLKVHQy7qUZAC65q1aOqp4
	7pdnyYP1uBmuGnQksDUiEOucvhkSk5Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=leT6IRwt;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::429 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-725d9f57d90so4834039b3a.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 18 Dec 2024 05:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527446; x=1735132246;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=leT6IRwto4pOz7UOHX0y+3sds7Lwi/gfogHZmUHZcNn3AKZjYLko2GmPuHsW6LDLhi
         3NEvePlj1egDyTI4Ul4l+66XNzjVLxGr1rcnnbD9ffvTYd5d1zose5ekRJ7NJjpJ4/ab
         JwZtJSFKtfn3VXczwKVwfRl2On5KF4Qzoi3c9nqujyBMkKCFwqqCGu9fXCCmqy22hnFQ
         egploYbKMl/NugDz8q7Yaks2gc/7zJFQaqCIXvmgigDSBm8NCoYds3eWuROQAAe3wSgx
         iBNmmvzHmzpskddUa2DxIrSOLQqpOKuTw8eG4Km+3qb9W1u0gKTxYIJXD/j8RzILngPU
         uMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527446; x=1735132246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=hPvm7SGOh3btBHpVnbPeXPw+VfTIzE3emlg13Y7M3CHnhfyjC3zkh0NyBEAdf5BTV6
         Z7MkRaEk4lHtKTMsPKHW1xCdwGE//BZDtmykH8rr9p0fqsnwL/TKF7O823mKTDaGngCk
         P+zkKlebtuPcHBtqT6ddc/+ww1fJpbeKJebQRn5OB2C8cm89FPJaOQ4KkRLC5nTJA2lL
         OuCJ+HjYWIvP/eZj48DgS6MZn5DZs8gEAfN7PhO++jrtYSx4NrzWOmTVw8uktOlQmpOY
         UT5i3gzD9smryu7Tj+YkHxW/gcMQKeRbqf2T8piNM5VdSlPCyG6k3GuYTZDIJsCNojE+
         /o6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW84LIFFYtV6H7QAILeezlAZvbvDrGTrAShA2zfvRMdqVR5MDg86Emig0XKcU6NJJ7E71nkR+/FGcfGBA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yx7UenT6ha4Qtg6Eorj3TaEalt7SZT9yUgRZUUOhF7s1bDyU8B+
	9/4G2wQ8xgXAWQI7Ngzc0D6l9N5eGtDNRMnO2M5a8N7Yu3ucdidN
X-Gm-Gg: ASbGncvEB05mkL49HFwdYHyPqw1NXhoWKh+Qj2IJDFpEaSaxvX58/k6ynMBrewkOi+W
	s+IejJSUlwYICXaZW2PTOzLxY6d3Uy42YHC8aPJGCheDnoh0qudG5S2RI5DlsQjFu4IsyNXgEvX
	rBUCtSaUrXFwOv0UubAkt+Mz223e1T3/js97DqTcVFfoV9VEmgWihNExyMAMRgjEw/Md0NLo2r2
	ktArQn7TGea/dMVXKM6YjNEtKk3UqTW1Z2RlXeqm4ihSQY=
X-Google-Smtp-Source: 
 AGHT+IFJSba0hMYoxDtWWfQo3+fMH+6cNLxoIt5yunX4KkQHyaeVCZq9fnVPYHJO8DT42j8sEsCrNg==
X-Received: by 2002:a05:6a21:6f02:b0:1e0:dcc5:164d with SMTP id
 adf61e73a8af0-1e5b47f3b12mr5217374637.8.1734527446438;
        Wed, 18 Dec 2024 05:10:46 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:45 -0800 (PST)
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
Subject: [PATCH net-next v6 10/11] selftests: net: Add python context manager
 for netns entering
Date: Wed, 18 Dec 2024 21:09:08 +0800
Message-ID: <20241218130909.2173-11-shaw.leon@gmail.com>
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
Message-ID-Hash: DTPE5L6JJ27PRQ3ZYXIGGOUTGDXJ4VBH
X-Message-ID-Hash: DTPE5L6JJ27PRQ3ZYXIGGOUTGDXJ4VBH
X-Mailman-Approved-At: Wed, 18 Dec 2024 14:11:51 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DTPE5L6JJ27PRQ3ZYXIGGOUTGDXJ4VBH/>
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

