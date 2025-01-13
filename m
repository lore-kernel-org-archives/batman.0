Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E49C02183
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 15:30:03 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 689FA83C51
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 16:30:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736782201;
 b=J1rG8A7AFM704AAhy27bA4B1AWbn6Poi9KKxEDpazzvL9/44Rj/YtJelCEzJUIyG4ei9l
 kpOkM7UE1Y6Od30ey/sHcnkAL3IwaGmbolMJ1H6TgFEulzLQT6Pedn//PlNM8OAhUlxtOCA
 mlb5n9hokbug1Y61H64cy98VAycJTC4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736782201; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
 b=KaFYOLmZ8j3TWGp+SUhfmMjm0erANwwVSe6eOd5LKWbPEXlESgoK2LUXZf6QdeQ0PdxTM
 p5SoB7/lIqGDA+k46Z0kjKbGDqFlAkN9TQM2SYp5+pGQKhU1C9AjjtDGznYBPrBgUZ5hyC5
 HkOu7NZyjv15aSobMESUNCCE2pNDY04=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 1951B81AD7
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 15:39:06 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736779146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
	b=ZTd8LOUgR9itkNFHv/m6Nju+SoHMnbe+R47LFxg1x6yq7SzqUWHOqrzSFeL1CjKK+TbEwq
	mHssLcqgaxrEfWlcak9m16Fb11S/U1+1RauPMDBUVcLVKlMRZjL9XdmR1+C8skGqCBbh/E
	dKgYxADCpvLS124ogMzbYsc0XtDGbG8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=mWK9trvf;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::633 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736779146; a=rsa-sha256;
	cv=none;
	b=Vm+CBtS4R3PszkfXJ7LukTam8x7a3pOK4VnlKxVhXN1iQw/2PlEfbdH5pBrKrqRSMWU0P2
	KQ/CfsxpT3oqOi1FNPBTzFxUTwZ6trPflNpfNXxHvHNPaD8/GxiBh/Y5rzUpbDNChMZxrD
	If8YYgbYb4/1mvc6p5Vi/UJKMAAVf4U=
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21634338cfdso59145365ad.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 13 Jan 2025 06:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779144; x=1737383944;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=mWK9trvfg0LchzT1PdcZZmgYQ7D9PqNnbuMgUHIvqvJ0HtZdwuA8JqUJg/Nunmgzn9
         zergjnldV215gjuaNgOP0mqJLRTStmYDl6xP7LsxnZDZaQQI7PAumQQcaXZS7QBOR7hT
         FTZPALztDNttbuqhsD1IA4Y0ZHEI3ftQpD6B2tIt8LDcMOI02KlqVrlbWCUy6oFBcXFL
         fU9YJmeox9/AdB6CmzGTiVceHCklHHJOmcVvyu3zDRoHjiW6KSpcntGMwifxbNuwFU/1
         ncK7t7kfTB3RQRjXkSULvtFUrZPpC19JXLEU+0UueZF5hWXMWmShsE8JP1GhW+ykyg39
         x5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779144; x=1737383944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/aVoxIsj2NaHZxO0wthneclpZNQFTaEi7bz2gcdad0=;
        b=FsX8Sfj+5MtokdxX8bdvCgl7LfS9UzSxZWreH2m8x1FYT2aEtWoCJQ/gBQWXozdKM3
         e9qnejNxHrS7kGmA5sm8sA9ZCTxUvxeXYBWF1GcPUB48QYh3rrLTixLFx/UfPC6NRHHE
         k7R6M/yQyGgjfQwDl44H6hF4QBgB6SjboqAFXIqEp1OO7UWuRq18IUVFJy3M4IiXJ4z/
         RyNebgmscQMI5Zq83qwssNFDHZTz8/FkkB+prx/Naj9QMJ/gdJBna3UXi7mVVSYAADFw
         HxJyYJqKWzsp+CM3Kv0vTuhmK8ywrm7qYjJ+WNZSJn/IN4NvQKUfAouwxZoT5qGrsWKp
         apcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQwXzAuo2CmceANmrZ7l4Z/pTYAXa6W1cDJZl7jeX2RtUstrQ6Kf0S0mMw7s7XuCA1JayEch2gNlEScg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YymaEB7WoOrzMvjqThGXUhtKo+PQBjim+AiMZcMRtg2zLoTO0gE
	fwNCoF6lAhYKBgO6PRkOjVFm+QrwvUZK3C13udN2vMI1eqQIuowW
X-Gm-Gg: ASbGncvwraolNmLkmX6rvHvUiuvYs+qG3WMfacuZhZCUz7319FVdxuLEE6MUFsom1FP
	e+Bo4dUDtGpRxzgJcSr0YB8dWvt7TUEbqyKjaKXeiCGHuco/9DEtGeNCR9sYdWTlsbqTaGOsAA9
	86SmG7MOrQADlHxkqMvu775w/IJV1lBAnEuUA/kstV151cz+Q0J5/IH/zWeWpsz1AskKrabILxm
	m5ArtALGvbxHuPWTmis8xzM1DT95janTN3WdmUMNl0yQWQ=
X-Google-Smtp-Source: 
 AGHT+IEL9Q/TeE8X83a4D73J5c4BnqISbL2nsMzkDnt4Xq2JHmNtTfGl7cYLX08uLNv4xfpjIcH6KQ==
X-Received: by 2002:a17:902:f685:b0:216:5002:7341 with SMTP id
 d9443c01a7336-21a83fde2bcmr322676685ad.44.1736779144551;
        Mon, 13 Jan 2025 06:39:04 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:39:04 -0800 (PST)
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
Subject: [PATCH net-next v8 10/11] selftests: net: Add python context manager
 for netns entering
Date: Mon, 13 Jan 2025 22:37:18 +0800
Message-ID: <20250113143719.7948-11-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113143719.7948-1-shaw.leon@gmail.com>
References: <20250113143719.7948-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: D2QFU7N5Q7K2U4YPFMWKFNB4QB2NKPQ2
X-Message-ID-Hash: D2QFU7N5Q7K2U4YPFMWKFNB4QB2NKPQ2
X-Mailman-Approved-At: Mon, 13 Jan 2025 16:21:58 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/D2QFU7N5Q7K2U4YPFMWKFNB4QB2NKPQ2/>
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

