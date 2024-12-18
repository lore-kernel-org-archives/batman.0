Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E20E77187
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 13:19:15 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E8B2C841D8
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 14:19:13 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734527953;
 b=Vzxs+nbP1Ap7MESAOjHGKTG95skWQ8X3b5tCwxxdZPGDNzG8c3ASrEOCcTHDxa7gs/rOM
 Sp8a1IkHJIeqbHdNyC7o6UKVWdMgAbVg1nL4DStNtLoJ9DvmGp0e3l7++imFCWfCRLI1kFk
 nXhgUE8WK+yglByTz9A7JekyMIYtuDk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734527953; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=VEdGbFyA09FJ7+QqmmCxpz6A7u+HUg5+S5fgAXCQeJc=;
 b=nRvOe1w+vsPJVZBXE0g7Go3TE+VFw+Eztb2CdbBqmAUVsCA/AKFSV9gVsc787HD1DTngJ
 bTTU1iuBfkXbMipUNfdHL/sQodM8A/4FHYHjVzF6L1TnZJLZeMLQ2aVG86IrfjrKYnADfja
 6yx0tQulS6bw3AzHEPoI6stL0ElOqSo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F106D83F2A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Dec 2024 14:10:39 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734527440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=VEdGbFyA09FJ7+QqmmCxpz6A7u+HUg5+S5fgAXCQeJc=;
	b=cudeNvv0UMSWhhY76r9Lqf33tzXTGuxzJrQTmqxZeBXUQTy5lPFFpBYPRDKh+YYHzgFaBh
	Vjz/iCH45pF7DKulQDHtkcVVQIz/8RnTgRbNvvjazo5DqhnprNYFlER2Q40dyv90UhgEgV
	1i098mC14oNIHhC6W3XfW8UbqyhIG3Y=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734527440; a=rsa-sha256;
	cv=none;
	b=REZKgzbENWzI/psZxwCuKPjHnynxjlTjzCM23XGLN+yx4P5PiyJC+0MGPm633+hRK5Of+5
	bckdvsCSSLGMsFYw+P/XQN7twkaqdc/PImh9aG0gprzVbP4UZGHJH/8fEDf/XrXxX6yzF9
	MvarlPh3ki87+FJ7VofwUAUvrz4nN88=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b="EwKih8/A";
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::1029 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee51f8c47dso4481173a91.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 18 Dec 2024 05:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527438; x=1735132238;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VEdGbFyA09FJ7+QqmmCxpz6A7u+HUg5+S5fgAXCQeJc=;
        b=EwKih8/A8aqGo0PEqQCO3zBWCKerF+184F6+mkba0rVSSK5BzmIXAYzDnFKTZj37Hq
         CdVdXZqJEorwMj1Fvu5ivLORR4RhEaYwjY8G+3StS4TlgkDmdLqKCoWPBL8AKOnZTUGK
         4V3Fk0UdU23lYRIgwLNcFhR2KjK+0fbLa8v027o7caCHlUJcyvRNXAoObRWX0Mq+/KJh
         cU9lbWQ52LDRvBaZbHCpguIr//lTIqqBPcNMSBWVJb49wlYRU5z442wMNrHLYHCsXJjh
         dcNNIw2cAr2DyJszxFo8GlwSZWhU8Wv0ohGYJo2aab+pSOOJ0TeMWxT19LLDystybN9F
         WhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527438; x=1735132238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VEdGbFyA09FJ7+QqmmCxpz6A7u+HUg5+S5fgAXCQeJc=;
        b=gwKxBR/ThF5MdLCZ4OG9VP80Oet+5S4bKeIAvucRT8JV78boMpnLPRwKRrv6WDyHYV
         W3TbXtjIJ/stEYUoKzdLs/gZ07ytec0TMeoWHGygPjCRdJqoYwu8eWquIXXzgUfg6laG
         /HZ5ZZH6vM99mQlYqTKuO3IWn+doiSw6P+y9ZWSzRpSEzGs6Azqv1RgLkLiI5bZXoZck
         1zFd+8bHL9k38EhyeuynGQ4DlXNTSRHYoy38Z/E/9Ukf5aqUM/TypZEf8THpsnwk4GVo
         t6xU+4rE1pl2vkDNRWQx5+hRxPn/LXnMLZ7H8jscap6gerHNKP0HHPid+dEXS/RCuRbD
         pr0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeeL3LkOrZBk7BZiJQRTaHi2MsGmP5UjrMVZqyavYgyBDFz5TIBgH5Uz2XnlaSlfZ5Dz6ciGrKD3Y+Vg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YybnAdcz6mKj0ciAcXABBpiOc391D9xk45HS5yjG2YtPa10kqQv
	XksnzrOWpYUkKD8QWR3FlvmrX8gI5TSpr9t7pAC6cP/QM7jEsvSt
X-Gm-Gg: ASbGnctmWNPO8Bbs7xXJAsI/CNU/y69H1txbAI4IdwXxhPDc9YtxJmG5P6LO2njlvs3
	LoXuayRpw/o6W6USr1wvVqZvmxbtB5B35cQVoSfPagiSIjrj9E/tFFqb+Vgk+UVm1J/nVZFPthg
	QI74fmBVTMqcoErH6ohcF/oHoCGEiMtSwEnH8STsxarekuihLIK4sXuAd7Q5hziir4WcDeDkUQF
	tq4oEtB8sEHo0Uvpz1i8EcoDCOOWxJxnWQW3eIQ3CH2TYU=
X-Google-Smtp-Source: 
 AGHT+IH6m2w3HOgAGhkzn76085OHsWsSUyL1uFaSoqu4LH4xby0CPd4muKbobH9sGAmWFqgh4Hldug==
X-Received: by 2002:a17:90b:53cc:b0:2ee:fd53:2b17 with SMTP id
 98e67ed59e1d1-2f2e934616amr4153078a91.29.1734527438446;
        Wed, 18 Dec 2024 05:10:38 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:37 -0800 (PST)
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
Subject: [PATCH net-next v6 09/11] rtnetlink: Create link directly in target
 net namespace
Date: Wed, 18 Dec 2024 21:09:07 +0800
Message-ID: <20241218130909.2173-10-shaw.leon@gmail.com>
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
Message-ID-Hash: NEMVSJEQ5Z3RTGSK6JWP46IL4ZMKLW2M
X-Message-ID-Hash: NEMVSJEQ5Z3RTGSK6JWP46IL4ZMKLW2M
X-Mailman-Approved-At: Wed, 18 Dec 2024 14:11:51 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NEMVSJEQ5Z3RTGSK6JWP46IL4ZMKLW2M/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Make rtnl_newlink_create() create device in target namespace directly.
Avoid extra netns change when link netns is provided.

Device drivers has been converted to be aware of link netns, that is not
assuming device netns is and link netns is the same when ops->newlink()
is called.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index e33ef8a0a6d6..ce5bea096bac 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3776,8 +3776,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3798,11 +3798,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
-	if (link_net) {
-		err = dev_change_net_namespace(dev, tgt_net, ifname);
-		if (err < 0)
-			goto out_unregister;
-	}
 	if (tb[IFLA_MASTER]) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
-- 
2.47.1

