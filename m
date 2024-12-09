Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1CEE7717D
	for <batman@archiver.kernel.org>; Mon,  9 Dec 2024 16:49:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5532983F32
	for <batman@archiver.kernel.org>; Mon,  9 Dec 2024 17:49:27 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733762967;
 b=fqspohY7raNsdwZ2IGZJys3/6ImunDPdfJooT5lNnDU7Az2WI3WqfjrEUKzgma6H6GU+v
 lCEsSJoeP4+Y2IaylZnyYSWMJktdv3FH+WerYlJTNEj6BlV2t7UPwp6yWiVUDAsKp6sGASw
 KnkQA4SsfYmV3Fn+oN95e9eM+pP5zNQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733762967; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=gu2pXduYtokx49vUkdKLIncKvOPJKtJoZQ/PcO8iW+o=;
 b=yMqU8zNVVYv2b4toJCIsw0iwlYPQJOLtBguredAAaw9tSEQddMVZxy//EgEQ5btNKBLVb
 cWsAxCkDTbOdTqTMHL8WvHKEOKYozorMCh9dZurtC2ggZpQkgZIsv6pJHUrwJkRAyqFDJ4i
 NFH3riiXZGHdQZ9VMaI/RwmyIqmUls4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3239581841
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  9 Dec 2024 15:03:48 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733753028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=gu2pXduYtokx49vUkdKLIncKvOPJKtJoZQ/PcO8iW+o=;
	b=unOqurJo18KmsS4kcfGHa4We+DoCaCO79eu/PI1yYZtvkEQ7hDEHvzdKEsjgHAgZrkNhYh
	ngFo3QtzmW5B8KPSUzzQy1gAyOWHxCEdbmBkKi2ObN0hLZ3+SUVxT9CM1iktkZflTyoveq
	6bhXSuQHq1XhJgTper6JUgjCObgjtII=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733753028; a=rsa-sha256;
	cv=none;
	b=RbDOhjnuM6E6SWA0Suhlu78ag3grtUsGF6Hmd1pE4AX2YKG1cPFLF+g/IyGpxANYCXQXK2
	cGpFGFW3vlf4nR+ilGQueclGzS8Pmo3WsOX3r0YcWRlFlsy700QyT2Q2eFHaE5HSnC8iJJ
	xSE/d1DRT7W/u9Cyg3PZxV/670oKY5M=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=OIOVefwH;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::629 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-216585cbe1eso7949785ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 09 Dec 2024 06:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733753027; x=1734357827;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gu2pXduYtokx49vUkdKLIncKvOPJKtJoZQ/PcO8iW+o=;
        b=OIOVefwH0Hwr+DK1p9+jzs7Oy8C4BMjV3u27FWEbnsMt+xgSJmVe4aOebpJQLtdeMM
         +1QyISvLyuBuSDqvT+E3pONiN47tdcfbPcp+tk7vgeGX5lLSLOBMgeWC1zQEbIVBA58f
         XxYlV3UPe4yk0UIWWXQne7QGr4TXQ+INR2iVDMhWxCcyDqkvoXG84E2Byrr+SqKYTjHX
         n6ylDwTTf6S+3SZRdSXF0DKT0FZ1/1M8RrmLajbRGZMRoKqO5l4yFK71yBdabqTvSBFd
         wF0GNn0BqP2OUBIp2yhTQiZNo4li5zCPkaQkKUkNLOpj2KemsmAWyvqiSjCQ9fJSeOPB
         Qd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733753027; x=1734357827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gu2pXduYtokx49vUkdKLIncKvOPJKtJoZQ/PcO8iW+o=;
        b=lXLo0hfHIU9hYPxpBpmGkw4veJF/wReTnzMaVBik5ZFm7TILayA4SdCI/2wlIk/X9U
         qLpFPZKuobnUwfuqVmUpGOQw4V9T+VSx084YldziJYmr9eZULJ1Ocde3EBKCjxvd5GKZ
         x+xIleQKZuBU4SXr4F3T7MZVCHdJQ+VmzoBWA6zq0Xm2pmghoOBVOejQFTWvmJFXawkK
         txu03naYOs4JIQUVPnSG6b8yEHkfZ+4pm57FqnFqP/fA0ue7jwQd1P51Y1dTcikEM+ez
         +efFi4Zs7RaFKItB9Nx4eQZg21hVyqNNbE11w9ptUoVb+TkyU2NtC+6qnavpyc0ivtK3
         XxBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmr2RTGbCo0z6dpT1oZJHEAPuNLJ2LfL8tRo5GoxgxAZtPG418KdXPtIhXu+y8roEdWVA3zdkneVMuyQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yyq9C2tNtKj3VbBjagLiq4Oe+l03o6A0hx+ZxNey82dlAKK3p1G
	EARTWDj5d4+cQLL+SWeXBskjwhofMLp1Q9sgeORHz9SMrxEhP6Ru
X-Gm-Gg: ASbGncsksxCBN+Kvh0lqlgA6I/l9izXnehVsUDqTT7hv4XUFZMS+wADidrB+af+JhP5
	FpJRd2D7FtUUxeATDwkfyT8X0qHtVq+ioURxaLcqO4t5t5itvytuMP57eh5JNSlGoq+RhxLYi9s
	vq8rqHR9mhMn1LLiSe7KxuFxSMIGuh++f+mJxU/NAORcvXCFYD0GHuKpeA3In44kM3MKnxbHQb2
	JpbkcyYHOpmgqH+0VQATOPtwzotsMS93rKg1zxof6+SORA=
X-Google-Smtp-Source: 
 AGHT+IFvuzKQIZf1qkxZ4+Ci/Eeds3C/nB8ZqihF0Bnr/4C7RYL2k3LJsI5chnoI4Z2JG+UfbiRHQQ==
X-Received: by 2002:a17:902:e5c5:b0:216:393b:23d4 with SMTP id
 d9443c01a7336-21669f993b4mr7567455ad.11.1733753026559;
        Mon, 09 Dec 2024 06:03:46 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:03:45 -0800 (PST)
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
Subject: [PATCH net-next v5 2/5] rtnetlink: Lookup device in target netns when
 creating link
Date: Mon,  9 Dec 2024 22:01:48 +0800
Message-ID: <20241209140151.231257-3-shaw.leon@gmail.com>
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
Message-ID-Hash: 4TEJEDMORMFIIEGT4FLDSNJBWWS2AZLE
X-Message-ID-Hash: 4TEJEDMORMFIIEGT4FLDSNJBWWS2AZLE
X-Mailman-Approved-At: Mon, 09 Dec 2024 17:47:40 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/4TEJEDMORMFIIEGT4FLDSNJBWWS2AZLE/>
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
index ab5f201bf0ab..7855f81c917b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3851,20 +3851,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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
2.47.1

