Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F827E77188
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 13:24:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D5AFA842A9
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 14:24:07 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735997047;
 b=uhAIaAnuRFGYfHraiNrff9CMlKdU36SvYKkbFw/Ydg/VBfFy1WXo4ikdJQBncQ8wu/woR
 3yQMUvk/+CqW0O3P5jWkPtuzB9HBl2Su+3UIL66lYdEwtkANDHi+i/9sk3f2BYgrzNBY/aN
 6yQL2eMJKxMVkzrxHvDTFXJGsBG/hF8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735997047; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
 b=f8Z5fzVnukvarjTovcMWzoAe1+LvlHu3NWwL4RUneWC31Jxog7LdFwZRwsuy76my7yB2O
 IldzsXTOyWyjEzR7wuJaIkwf1i6Es16AjZxn3H6j2A5oR+W6RO4yhgBddk2ysp5oN7T7Diq
 emZfHmjMZzAdNQe4fZawvb/rYaj3n+8=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id B159E83FCC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 13:59:08 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735995549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
	b=MQtLgaHxKKatlZ3viObt6jC7To0JdxTsu3hlsNn1I1Wbm2xnEk171cHxPIT5uNMcAe68gZ
	NLnDnv9SEz1u8/CumgVJUWvYUx3W7jM9op0ntIkK9qj5NmQtX3t5W+KlBiPlsG/zsgq3Q3
	500kX/IDPSuYg5+AOoVFXchalLCP3BE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=FGJNtLJj;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62e as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735995549; a=rsa-sha256;
	cv=none;
	b=09hNPUrxqeIoMknCwrh5FGwzPgRhgHuEpo5vSoPWtQZ4jK2iQSu9EkqJemDDShM4EVuHOo
	02izvkVXCoPegtwRb0w5hOyGzpHvXhNkK4ycx8VGWSWQXGxlu3Q6c+xsHVUKuTYrF/42M9
	veLV3WywbKNWRqDMJx89LbPw0VKtwqI=
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21675fd60feso241716325ad.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 04 Jan 2025 04:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995547; x=1736600347;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=FGJNtLJjNkeeEzfVBpiWO6dGXV/Rn5c96O9WF3qPHd8QudarXA3cFZ5vIGAtQCEj91
         RNAbrUeJDqC4YU25Hw+2MHMtazP97R1x55nJS4pqGBblSMlo65wA77oa31A6rQX7jxx5
         ql70g/FZiUXg3/OILXXGrEXzd5QVcABPL4dS76wvNrJlnkjnLvqqF2Q/KBr8CsuH1IfT
         tCRkfEws19T74jBWPDnA6qR7CDEJ4pN3XhbM9UY+8XxJkiOGuc9A7cR4Ff8R8JGyStZE
         C+VcmI+TJj8gFzG7oAH0DGvGYORkFebqmR0ES9drzFJWkucmSvNxvC0PgP3dFdOxkRsj
         jyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995547; x=1736600347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=cLwLsPBpOO5CfODq4RNYcuo4LAjSlaHeXNidYLq9/qnS90/yUi3oewGpmG3SfI0T/S
         m4Asl7wXdMx+q9ol5ve8ROxlMxq3nyAn8GaDmyoRGepdCwL28p2rrQGJkMIfUejKAyIi
         MTKmqyXOrl8L4GwEFUPrHjcEOu6h1Ep1pVNTJAb8yAIEaOd6SsWPBl7+7GTO2tgbegGj
         c94oBmTfeXrcxSQwBZehKrKzs5anD1uSvnu3CQZP93cEORhBAbrOpldNNFXqE44A9jC1
         Vji5uclEzQ5rgT5iOW18V8Hgp9cVy1N2TbN8se6Vu72MuVXzPyYiWCiMgGL0qyRWoXkO
         e0XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyIjjp/Ge6cFEjpnS/p4NQ6wECpUfXvxDfAA8ymjEV9lWfAq60NH3ChVBrwpDvX3D9va2eyvP4SqqbQg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YyJyrzschT6ttXPM3LXQ5eiA+/7ECz86qQEKxaDXO9yUyh2v+7o
	mU+8UXNkvGNTEFYyWIOUEqKB2l5H5Mqp/1KWbSGriqTdhXbN+hw6
X-Gm-Gg: ASbGncvJX8StWaIRB6AMeyNabhVNVlKN8wyAYjLnlA1NJ/na6bF/cDzRZYunksFQTnx
	Vfk2yyJZNRM/miyEogCYrL57QHyBZqmezpmFCgAlRjWDFC6IwiIu2fUNMvP6cFepwNFbhjfhx6o
	W6be6ZXqmmrm8C4sVrY/23MC7OoSFUGcS78oMmjjVRmmvQUi5PWjbQBZmssW+9haI9/WdNc79w8
	LpLsV2BpNP+TIybeoIf45EG1Kby013hgHZBeEl9L6e04WU=
X-Google-Smtp-Source: 
 AGHT+IGUseWUHEPuZ2azBnIbXH4/rAn+CSEtKsSSu9kCqJsAhEDYnxH1YaaDUJFfNwCRIx8vP1I8ew==
X-Received: by 2002:a05:6a20:2d14:b0:1e1:dbfd:1fde with SMTP id
 adf61e73a8af0-1e5e04a3427mr79059917637.27.1735995547161;
        Sat, 04 Jan 2025 04:59:07 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:59:06 -0800 (PST)
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
Subject: [PATCH net-next v7 10/11] selftests: net: Add python context manager
 for netns entering
Date: Sat,  4 Jan 2025 20:57:31 +0800
Message-ID: <20250104125732.17335-11-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 6EO5PO2K3BWPXFHKKTPFCGRQ52U6O7Y4
X-Message-ID-Hash: 6EO5PO2K3BWPXFHKKTPFCGRQ52U6O7Y4
X-Mailman-Approved-At: Sat, 04 Jan 2025 14:17:52 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6EO5PO2K3BWPXFHKKTPFCGRQ52U6O7Y4/>
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

