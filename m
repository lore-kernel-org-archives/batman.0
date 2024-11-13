Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCDDD41C3F
	for <batman@archiver.kernel.org>; Wed, 13 Nov 2024 13:03:01 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 41845831B9
	for <batman@archiver.kernel.org>; Wed, 13 Nov 2024 14:03:00 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731502980;
 b=lZRau+R7omv22olAbTRP54lLFqsIfetbeszZQzfF+aeISpUk8ExRfjx7ihXVfznFBJqYP
 KA+zQCRlr0UPRiX+9BdFB9ou+X+lxy6mho0Hw5B1hLaK+h88BZrSrkRtLHDZQ5wBuVEtXWz
 N2bATkOMKw2PGl9Xt9l5nnDtnke0ZPw=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731502980; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=r30qTLZF8ANhBKyxqq0VyimbMaQgwK/VTM3BE1AEUlA=;
 b=yXOFkA7gVVSK/F73+e1533hqJNA+QrCdgfGyj02n9RNykkHFt2ZkyyvI6HmDAQLNUEqtM
 IOYLv+rqWnscgEdGdLauDLVyUQoC93axVlnZCoDKiT71xh+4aA+bcKVmaPvfX0QGz8c+guM
 N2A4SaKnY96Z5I0HgB2guHDtGU+Jbnw=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F000183002
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 Nov 2024 13:58:02 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731502683; a=rsa-sha256;
	cv=none;
	b=UUP4ZsGdVU78ELNntC9zNsbuNs1kALESRbnAnK4I379xzNMPtuFtYJ77AjuPsr3nGMeuL7
	bCV2tStHv9Ep6cEMtjnvr3rWZ3X31JjpLRKPS/yk7Fp98wTFhyjaXuHTezeq5fMwTumvD9
	sK9wXqwfUaODRMxaEyzGFpKtfT/K1F4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=eKw+btc1;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::1031 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731502683;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=r30qTLZF8ANhBKyxqq0VyimbMaQgwK/VTM3BE1AEUlA=;
	b=ujQbrLFkd49+zOQCEUmP5oiPVL3OAWFAPlHkzTbLqdKDpEetYYxuMrs23qrVFpVdKUdFHE
	lIIprtWsyKwu5eV21j02JTcvSzyz0uEwut6aZwZfucPWDKWvGW03awIFUMQwORORAnQ7Oz
	4SPFp8IjkC/LF3MxJt8YIG0ZKeUJ1tc=
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e2ad9825a7so5287514a91.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 13 Nov 2024 04:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502681; x=1732107481;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r30qTLZF8ANhBKyxqq0VyimbMaQgwK/VTM3BE1AEUlA=;
        b=eKw+btc1PQs6Wj5Ea4hkn5hgjz8iHapSvkIAPKrLFnY7DYBHQvfk/naSAIYYFryf56
         IQYLokoAQaBGh9bLXNZ+u2v9BQdaO+lrIGV6ad3otREgPV4oQevCG+mBOKoAPnSoOGRK
         AWyGbARU+lKH9HHceQAVimhO0ws1qTfxKyKXua/DQ62TDYa3x0DXJmrq4heHGgU9zGXi
         d3Dj+xE/Xujc6rTGgo9k+k6lZwjlsMfh3roISASQvAVFGLLg+vQINoHfPGE0cWajBwzX
         oHcRjGCfC1+DSrIzxqnHexh1hqpRh3SAxCufcCqWjFgCk8I7zyqsFVx1igEYOhcm1ADa
         kGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502681; x=1732107481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r30qTLZF8ANhBKyxqq0VyimbMaQgwK/VTM3BE1AEUlA=;
        b=tAz7yNC0FCVOymdkP20pdMZ1aanNgZZVZ+QyrDRKeIJnr7uav6U4fvtx4dki7Fs8Ll
         fQwH8A9u8i47kJsIfjJU053KVbtyyjhdptJ87chWvz/MbrydGFcSUOK6bvVqQuMqph3C
         hPta899afvpFTxJTqrFMfP/EdMrowlb+t2IPbDHF8eSwS4rEGxVXBh03p62MFl33vChM
         H2MNa1X6e9u7RlXMLhCqRv8eVi7eAU+CwzZEWIx8KuNatJgr6kFFKqN4aP4RiYdSqeAQ
         gg28+iYxBWjXqVVYQ1rCyDAIsuSq8lzWNlpRbieGjyxnx9XHurEwFGGgORmd3hEEWQPw
         re6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY2Z/RAmwveFyaFJjWDJW4aQk0mcxub7oawKIjLiaqbvGLgp1LrZ8LzLXkzRDH/+wP0A+A9QBMLvxr2g==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yyghf4Y4wGQTpALgUv19LBfdLA18o1sVP6V448KvznWY49X5pY6
	t47pPUZgH9JTCUVLrwKi3JZUNPproA2NZ916GFgIBKsq7XMo8wknubmcrMRGyf0=
X-Google-Smtp-Source: 
 AGHT+IGHbWu6TztKh6tN8Sp6Cv2pF+0T1uVgEKu2tiVbycxbLB+U4mJhCEtmHq5ke3dUIYABcOdsZA==
X-Received: by 2002:a17:90b:3907:b0:2c9:df1c:4a58 with SMTP id
 98e67ed59e1d1-2e9b177fdcdmr24476632a91.23.1731502681391;
        Wed, 13 Nov 2024 04:58:01 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:58:00 -0800 (PST)
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
Subject: [PATCH net-next v3 3/6] rtnetlink: Lookup device in target netns when
 creating link
Date: Wed, 13 Nov 2024 20:57:12 +0800
Message-ID: <20241113125715.150201-4-shaw.leon@gmail.com>
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
Message-ID-Hash: 2WFKQOVLS4IIX3VWAPDMCZWC4JGA7R6U
X-Message-ID-Hash: 2WFKQOVLS4IIX3VWAPDMCZWC4JGA7R6U
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:00:42 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/2WFKQOVLS4IIX3VWAPDMCZWC4JGA7R6U/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When creating link, lookup for existing device in target net namespace
instead of current one.
For example, two links created by:

  # ip link add dummy1 type dummy
  # ip link add netns ns1 dummy1 type dummy

should have no conflict since they are in different namespaces.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 327fa4957929..f573ace60234 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3846,20 +3846,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
+	struct net *device_net;
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
 	bool link_specified;
 
+	/* When creating, lookup for existing device in target net namespace */
+	device_net = (nlh->nlmsg_flags & NLM_F_CREATE) &&
+		     (nlh->nlmsg_flags & NLM_F_EXCL) ?
+		     tgt_net : net;
+
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
-		dev = __dev_get_by_index(net, ifm->ifi_index);
+		dev = __dev_get_by_index(device_net, ifm->ifi_index);
 	} else if (ifm->ifi_index < 0) {
 		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
 		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
-		dev = rtnl_dev_get(net, tb);
+		dev = rtnl_dev_get(device_net, tb);
 	} else {
 		link_specified = false;
 		dev = NULL;
-- 
2.47.0

