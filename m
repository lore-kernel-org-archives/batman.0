Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBD8D4921D
	for <batman-adv@archiver.kernel.org>; Mon, 18 Nov 2024 14:47:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8A7F283FFC
	for <batman-adv@archiver.kernel.org>; Mon, 18 Nov 2024 15:47:34 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731941254;
 b=y7J98CjmFYMF3BLMThndNTgxANRO9hTiIPnJ+3auHj1nfCVjrkWYVdE5Sfn0NE3Jqnpz3
 MekcuWlby45TTQ6vtZyJiAZnJFdDj0Qfrd2D73FAhVjoN60MIk0ireJL+utPzmBeiNkdHSW
 dc2k+HwKPjm8hoKUbFHg/MtnT8aS/ko=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731941254; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=XYvUg1T5qt/avqeB8QMtp6GEfshi9DuIrKXfHc0mOQw=;
 b=35W1vcqBeWmnamzrKy9S9d2A46Cl+JVWOlFDNob+eb4mXKCdaG86DA1v2ki/0IMdsDn6K
 oDisf+Y5CNmC5cB5ck6IvMxWuIiu+hMK019mc86CjgK607uz+8scxN+IPScESIN4BSFsrfl
 iMlzvZ8M6/HuWSkhde9p+GX2NUnQjRQ=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EDE87831B9
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 18 Nov 2024 15:33:31 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731940412; a=rsa-sha256;
	cv=none;
	b=L6SdDzNpYYT3B6gOXWTUYpYvzu3vmfpPrRCkDnfUc4IHTRsnJC23lO7HekxLr+raCKi+dM
	j298inlBSTX247SDkWO0kPJ6nONpuH3DnohbM5kyQqW1/8aZUE/BONAgCy+44iTxdtpoHL
	eLaRiaQhIDw416hSiJG8ExKzxxjt19Y=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=LZsiIRUI;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::430 as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731940412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=XYvUg1T5qt/avqeB8QMtp6GEfshi9DuIrKXfHc0mOQw=;
	b=JcfIGzo25CF7evysjUUBOLEBXZdZTfaTHyftxoyPKDLX/cLdQj+4sWM3n7Rqxa/BePrCC9
	S5wyHPUPzgL6IDC51qKQxe2YCw641WG2n6sZFl71/Mex/SGsXcfoT2o+K8oJ5rY/PzuprR
	LPUWTW1sbOlRgtW/79JBNh7IaH1LDvk=
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-720b2d8bcd3so3066504b3a.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 18 Nov 2024 06:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940410; x=1732545210;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYvUg1T5qt/avqeB8QMtp6GEfshi9DuIrKXfHc0mOQw=;
        b=LZsiIRUIiodEGl27QHCQKdo/Tm7WUeqBL6wnR2Ey8ty+Kf/h1hbEZc9+jnRAkRHGwS
         SY8345fFTcd6+9WR90pRDezXv1ok70j6j7v5XCK3CFsEICfQ9jV2b6HMsgoFPs6xd0YU
         RR9PrFbl+Dd+c8N/iXW2s43NAsB1euyK4HIB6bPrwO7WAOL8sFpZBlj0wEXw9cpkLO/j
         NtarKuYLiea/nqCpGzWVj2gsScw0qh0i9D7D/HpKYvSesM+/6r6D79IyKS+DFAIBvrTd
         Kby9oYa1o7Di5lm7r8VDAoGec+u2yrd58ogcPt/EkA/AwIjQ+OypSllUxBMyUalXty+A
         mXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940410; x=1732545210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYvUg1T5qt/avqeB8QMtp6GEfshi9DuIrKXfHc0mOQw=;
        b=YkK2RrytS6QQiY2sFB/EnmBxHF2VVwJTvJDQAhMGwpOfZjQJHMOAIX80sBXE92xRei
         2wFv7dnwJq4um0Xo1i65bxF7qe4PYE1fQjJ6/KaIA8qds+berGsW1jfqJ4pNnLdPoTJw
         Vg1/PClU195sFreDbkLpef6Dx2imCDM9TpgBRajxjAXmKnMDp0DJvLoKH0f5e5o/0BPl
         41TAlDAnOIkC4wrZbjdkwp5OW7/9GCB0fGdRHWF4+GaUfBAHtVvAPRGrXlqwTFNTGtBy
         Z1wlXj3pdLgz8YsgH+wotwG4wFo5iTq+q7OvIcvpk+RbA9wPx3d6EsecQroFyGhn3Z6T
         HHrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV55cD+6gleF6n8XbfEfuUiQGuEeIYD/otm9WMqb97Hwvy7F6KFolYTIczFiVR9xL7X+x/6fYgMzFWiVA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxGCVcNl+k2xkSdtKMD7ZI/31qQdj7UZ/oifSJ2k0s673wtkJV/
	HnpPyQQSuqKugt6WP+548S4ECpqdlHYuiQlxEoVA6v4MOYyrSTdc
X-Google-Smtp-Source: 
 AGHT+IHPKnavfiiQCNCjr1NezmwMnBacyheV8zyl63QTPg6m3L868R+a4UJrSv5jLV5RsxhfHcRfpA==
X-Received: by 2002:a17:90b:2687:b0:2ea:3f34:f1a0 with SMTP id
 98e67ed59e1d1-2ea3f34f38amr9406817a91.30.1731940410205;
        Mon, 18 Nov 2024 06:33:30 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:29 -0800 (PST)
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
Subject: [PATCH net-next v4 2/5] rtnetlink: Lookup device in target netns when
 creating link
Date: Mon, 18 Nov 2024 22:32:41 +0800
Message-ID: <20241118143244.1773-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118143244.1773-1-shaw.leon@gmail.com>
References: <20241118143244.1773-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: GXKQA47427GJURTOJJAVLJJDRWHCPAAI
X-Message-ID-Hash: GXKQA47427GJURTOJJAVLJJDRWHCPAAI
X-Mailman-Approved-At: Mon, 18 Nov 2024 15:46:12 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GXKQA47427GJURTOJJAVLJJDRWHCPAAI/>
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
index dd142f444659..bc9d0ecd3a1e 100644
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

