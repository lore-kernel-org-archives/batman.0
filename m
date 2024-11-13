Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9126D41C3E
	for <batman@archiver.kernel.org>; Wed, 13 Nov 2024 13:01:35 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5705983F24
	for <batman@archiver.kernel.org>; Wed, 13 Nov 2024 14:01:34 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731502894;
 b=0WI3Ehg5EBqAGtJskhWHvmITVvz7XwCUztfhhP/nN5cPVBrATvrcxwsmoKcnxawxUCevR
 Q9m2wMqsWUkQjQptrArHJm4nqvcGUm8Ak20HNZvtmL2Po5yEOT/CQ0Nw0bEfxxTZizUjSYK
 tji5R1Bu5z0KqF8L0hjz2dGXgnnvZMI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731502894; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=9sIZI/WV8nhbNfyJEUDND2yz+m6sbgKmtk/cQXv5cxc=;
 b=U6f0bs6I3xEY5WOTBB4Yig53f6ZoWOg1gxS13vZNgp8lRL5hx90l6rzGoD6QVkNg03FMV
 WA3EASi9tg5u//Ym/AvYW/2Kk1CuwyCzB2J+ylYmMdgpEEFU5VY3BKrjymPbvSjEgFyNm5v
 oIVurffDaHpvrso3kjhE6YZXahyTqgc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5F01C82841
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 Nov 2024 13:57:46 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731502666; a=rsa-sha256;
	cv=none;
	b=AD9xsVZjyDyDrKbLqvxI12ku5aorEm1RCviR9uCbaetPmrt5odU4Jjo1/MooM2AAz1kiSL
	8qRZd3wlJpIDUrY/ShjL5yIToNUDTRATmR1+y24q6CBGDcvokjPum5InX7jTe6VeZxfuwv
	T6JWCzcBlUGmblxuRe4JmZKQHBd2A1A=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b="DIW/gVc1";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::102f as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731502666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=9sIZI/WV8nhbNfyJEUDND2yz+m6sbgKmtk/cQXv5cxc=;
	b=mlg7GEXGokrrrliSXJRo679yoecewTnCQvohrN9YkUtosQn+fVTzc7jdNI5whJ0uVh3eDA
	dKwlb7mNTXKfp3YSQv3ZMd0QDGY0vPMoJ6JnVamJmhc47rfE/q1GWvvHWlTzb5O+B6+3vi
	8AOQtAIgO3+dktJ5pAnkaHQrsbT3wq0=
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e31af47681so5514815a91.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 13 Nov 2024 04:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502665; x=1732107465;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sIZI/WV8nhbNfyJEUDND2yz+m6sbgKmtk/cQXv5cxc=;
        b=DIW/gVc13h9zEPVPqjnzo6yMvCa1Btp7rvxmLtaeAgFpUySuZkWkuBV4+fbUKqgWMr
         v26fUgNQqWG3wj5RFW7VVtTjZnFXxVWLMJFwuioOCDw78WYHvYPOhhhf51IE7goy0Qfq
         B79qcQwM1l7JUNSgzleszap8Vk/EQZGTJbimmRAAwPb2PNqXGlxKXepZQKZ1AVAskkXp
         gs4sq1LrnK9XmXU721ajbI9rJ5Sm1tAJMtKRLs2xat9Vu7LI9Hg1ClZ4HtudRONVsp83
         pjPkF965EoMKa/pu1XI+PG0Hzs0QuydXo+lcxKi3Ix8hawDNENh1kz1QJdY4IEHj/9W1
         eKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502665; x=1732107465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sIZI/WV8nhbNfyJEUDND2yz+m6sbgKmtk/cQXv5cxc=;
        b=mDlYVMvWx3MobJTBQewJDVCTbPOuMnxYJkEfU7daPEDLsXwlQxftzhlN1+SRNy/z4c
         aqfxohjGU6NYHRmzpO4u7ULN6T1ZpGC4j20rcqN/AXUEzOUbPiGS+eHtQpEegdjIFKi6
         PN3HfE5Cu/5FlXMcPtBcWjxCPdTvmTMgfNJNtOMSeKlyDbQOYcpJFriYd84KcuPbncJ4
         kJ2BEqdzuk0t+dh8kKMxRW3ay0byF7jCN2guzC5UonOdeGbZYkibSflmol7RFXs4H53z
         sFBY5sBHX05Uwg7iXpAHn5vRQZfyIlKdh/TKnUhVfW9h4UICwbwyNskRjaSGDsX1lUv/
         FAlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOTtw1ZUvbxkE55f/etXxupRQZX2R6aDEg2EJGn/i+xt91ftKxINDAb0H4bolwwQPNrUXPkK2Nlqm/JA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxGsEQ+S+OT5Qov0A2kjKYVX10xK+c65ZQbCXeC2cIrpOtKbOWO
	hPiIPng6+e+sT5FLTNBAy01f99JD61qYVD3soE3aDdyDkqSAfoje
X-Google-Smtp-Source: 
 AGHT+IFBBLW/otzoU3VQWNkQ98rdfNz5WHNkXJFNuYVXzuqAWCzWf4F656wLCdVO3Ph+9deaw1I3JA==
X-Received: by 2002:a17:90b:48c8:b0:2e2:c40c:6e8a with SMTP id
 98e67ed59e1d1-2e9f2d5da7amr2684315a91.26.1731502664731;
        Wed, 13 Nov 2024 04:57:44 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:44 -0800 (PST)
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
Subject: [PATCH net-next v3 1/6] Revert "tools/net/ynl: improve async
 notification handling"
Date: Wed, 13 Nov 2024 20:57:10 +0800
Message-ID: <20241113125715.150201-2-shaw.leon@gmail.com>
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
Message-ID-Hash: VHJ6GZOJD2INDEBBGTEJEG6FAHU32HKE
X-Message-ID-Hash: VHJ6GZOJD2INDEBBGTEJEG6FAHU32HKE
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:00:42 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/VHJ6GZOJD2INDEBBGTEJEG6FAHU32HKE/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Donald Hunter <donald.hunter@gmail.com>

This reverts commit 1bf70e6c3a5346966c25e0a1ff492945b25d3f80.

This modification to check_ntf() is being reverted so that its behaviour
remains equivalent to ynl_ntf_check() in the C YNL. Instead a new
poll_ntf() will be added in a separate patch.

Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
---
 tools/net/ynl/cli.py     | 10 +++-----
 tools/net/ynl/lib/ynl.py | 49 ++++++++++++++++------------------------
 2 files changed, 23 insertions(+), 36 deletions(-)

diff --git a/tools/net/ynl/cli.py b/tools/net/ynl/cli.py
index 9e95016b85b3..b8481f401376 100755
--- a/tools/net/ynl/cli.py
+++ b/tools/net/ynl/cli.py
@@ -5,7 +5,6 @@ import argparse
 import json
 import pprint
 import time
-import signal
 
 from lib import YnlFamily, Netlink, NlError
 
@@ -18,8 +17,6 @@ class YnlEncoder(json.JSONEncoder):
             return list(obj)
         return json.JSONEncoder.default(self, obj)
 
-def handle_timeout(sig, frame):
-    exit(0)
 
 def main():
     description = """
@@ -84,8 +81,7 @@ def main():
         ynl.ntf_subscribe(args.ntf)
 
     if args.sleep:
-        signal.signal(signal.SIGALRM, handle_timeout)
-        signal.alarm(args.sleep)
+        time.sleep(args.sleep)
 
     if args.list_ops:
         for op_name, op in ynl.ops.items():
@@ -110,8 +106,8 @@ def main():
         exit(1)
 
     if args.ntf:
-        for msg in ynl.check_ntf():
-            output(msg)
+        ynl.check_ntf()
+        output(ynl.async_msg_queue)
 
 
 if __name__ == "__main__":
diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
index 92f85698c50e..c22c22bf2cb7 100644
--- a/tools/net/ynl/lib/ynl.py
+++ b/tools/net/ynl/lib/ynl.py
@@ -12,8 +12,6 @@ import sys
 import yaml
 import ipaddress
 import uuid
-import queue
-import time
 
 from .nlspec import SpecFamily
 
@@ -491,7 +489,7 @@ class YnlFamily(SpecFamily):
         self.sock.setsockopt(Netlink.SOL_NETLINK, Netlink.NETLINK_GET_STRICT_CHK, 1)
 
         self.async_msg_ids = set()
-        self.async_msg_queue = queue.Queue()
+        self.async_msg_queue = []
 
         for msg in self.msgs.values():
             if msg.is_async:
@@ -905,39 +903,32 @@ class YnlFamily(SpecFamily):
 
         msg['name'] = op['name']
         msg['msg'] = attrs
-        self.async_msg_queue.put(msg)
+        self.async_msg_queue.append(msg)
 
-    def check_ntf(self, interval=0.1):
+    def check_ntf(self):
         while True:
             try:
                 reply = self.sock.recv(self._recv_size, socket.MSG_DONTWAIT)
-                nms = NlMsgs(reply)
-                self._recv_dbg_print(reply, nms)
-                for nl_msg in nms:
-                    if nl_msg.error:
-                        print("Netlink error in ntf!?", os.strerror(-nl_msg.error))
-                        print(nl_msg)
-                        continue
-                    if nl_msg.done:
-                        print("Netlink done while checking for ntf!?")
-                        continue
+            except BlockingIOError:
+                return
 
-                    decoded = self.nlproto.decode(self, nl_msg, None)
-                    if decoded.cmd() not in self.async_msg_ids:
-                        print("Unexpected msg id while checking for ntf", decoded)
-                        continue
+            nms = NlMsgs(reply)
+            self._recv_dbg_print(reply, nms)
+            for nl_msg in nms:
+                if nl_msg.error:
+                    print("Netlink error in ntf!?", os.strerror(-nl_msg.error))
+                    print(nl_msg)
+                    continue
+                if nl_msg.done:
+                    print("Netlink done while checking for ntf!?")
+                    continue
 
-                    self.handle_ntf(decoded)
-            except BlockingIOError:
-                pass
+                decoded = self.nlproto.decode(self, nl_msg, None)
+                if decoded.cmd() not in self.async_msg_ids:
+                    print("Unexpected msg id done while checking for ntf", decoded)
+                    continue
 
-            try:
-                yield self.async_msg_queue.get_nowait()
-            except queue.Empty:
-                try:
-                    time.sleep(interval)
-                except KeyboardInterrupt:
-                    return
+                self.handle_ntf(decoded)
 
     def operation_do_attributes(self, name):
       """
-- 
2.47.0

