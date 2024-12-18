Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4274E77187
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 13:17:30 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3BC74841F5
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 14:17:29 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734527849;
 b=lRWEg33EGzAcz5DWXXEb7xgMzERNpnQtquzozxKTLA340pmexZJAl5cvtO3DUqp3qUrmz
 AxJj6b1V1CzfUN3hnwtgCZqAQx2a4pBJgF1jadp/dpkOuEWhIAurkGitS8T60DjBNKvdBFv
 Gj1wICBLsTZaeqNVnejxKikvNH/oaMg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734527849; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
 b=XWldbc27BmIHzlBtbMvAG2f4rCxfziMyg8JOf2OfW35NJnVQWW4e/Kl2IqGg4ltjTwyAA
 N4FZkfCMzUZ6Z5n+gD7Cnj8WqRnbczuh7C3Gra1y3nPdDpzlw37NkehL7TKThG5C/WqiM8T
 kPWiXsXgVF+UxDwB6brIosP6Fv0LcJc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E14DE83F15
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Dec 2024 14:10:23 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734527423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
	b=1XYFB26AquXuqDt2J8WZlWY22VlcWL+kk18iNe2X2Pd87q7dbvYuO3JQjoC/GrKjgB0dOx
	zLy1pqdBOirX/eja3oFWf/qIA8SvfY73aUHuJb7vMcHU/r6irOD02Vlsf/EJ5+H6MSy72u
	VqdhX+MsuqgL96w9XGk22IWFkLXBlAk=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734527423; a=rsa-sha256;
	cv=none;
	b=Z8NojMDVoQhPm5SFjZ+c8ZlMHgWAxBT9etFskgaYsSDsGbF3allFWAktLBNdsMNGsnPmOw
	RPXNS2ROHHbTYNSndTQyRTiFYj86o7cXOtB2jCZvkfRkoU4KPA4iYArOsSgBAikkpU2wpj
	mAgosh2+s8QjAKLXtHGI5hfXWvprt+I=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b="HLq+j/J8";
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::42f as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-725ce7b82cbso7449324b3a.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 18 Dec 2024 05:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527422; x=1735132222;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
        b=HLq+j/J85pHxDp2x8UhLuOjAeu1uiNJ8xku+4yUIDqOjVQptY5pZ7Odoi31ML4TBXq
         2VMzUDFAqakhixeaW5SPZJhgsi8RvY2Rtj4/+3JTFjdg4a4eMruEAkDvZwf7xEn8h7HH
         5+7YRpfNsvHot9kp5xhL5PWkIy4O1p1MxRA6aNcbiI8klOZAFhLfM3CW+E2kQ6hEaAsS
         zCgNWxXIkO3KK4YHNRbneinYE45at+vsQkMw8M1EnvO6Ud9GkhWFBsWDTiiGbCN6Sgi5
         mZLmHoBIPH7yXoXujnKTz97BTADy0s+KRulGdp+Yu9vtKuHa6PZDJZpY+7KHwiMKAoNb
         K8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527422; x=1735132222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
        b=QZ1CVjWag2Vkrif396c+ymVN220jlDlnvl72U89JZKo3QtD1pXX8+hzg3k4SjTR0iF
         dJGjtERCFtpLQmH7bclwYzWAD9o9HVKo04iT83SoBwZ0TjgDWUKgV06FOeQonRyetRii
         i9YhaNTeJ7fDyJcFhpRdsSK594GBPk57G3GW33wXGrQn4/efjmxG4Bl2cP3gmivnuiIV
         iQ3KAaLs9gL0drpZWx4G0B4kYq0u3yqrZYAYlUXMDExiQTFpPwKd3vsC+WxHf98Y03d9
         yiBIv4DahDot2g/8kunHnG805iWiOPBI1prPSCGecY8m/9py4EkKoqlTeT7D/ykPGWiI
         cpLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG3Yqq3iqFE5fIKKPAZ9ArGW4HGQ5grru59MO/c5gsA6B6E17SyD3R3KspVmKpAo/8rl+VaWGwg1PbuA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yyty3Kdf07H8faREn4i6os937q2ghJitdchRELrZtUPSWueao/d
	ssDRkIoS4RrRARgMh3bViDAmVLzTeRsyzx9Xj4+SwT5CKOUR50HB
X-Gm-Gg: ASbGncsD5ePCDXNn4rMKmRzhSd/TMxw4PvvxPrMhlQKK3XyrM7drtg5QvswUYhAp/i4
	GeNns7H+7tB5xsa5K+vMTutbiFA8m7PqStbzj8spDXaVWQNoxQ2cYLkIy9EiPW/68Hj/K6E/WaM
	eNsmJD44WiosxfFkwnVIERRcWvcWgMHrcp3xGHafYDtG8bAPTvdg4lYk5q2c4RxZj2i+ybFsKvB
	wajCPuJ3yE1/rnLYT2CecmAhy+5AWy4i2LsfvzHZcqflUc=
X-Google-Smtp-Source: 
 AGHT+IGLrMJpewCg9a6Mvczs3iBMMwjIWUW57/cgClFku2ou3JPxqZ6yK8d+Q9sS8i4XncDR+dfRig==
X-Received: by 2002:a05:6a20:12c6:b0:1e1:bee3:50ea with SMTP id
 adf61e73a8af0-1e5b47f94bcmr5116348637.11.1734527422239;
        Wed, 18 Dec 2024 05:10:22 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:21 -0800 (PST)
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
Subject: [PATCH net-next v6 07/11] net: xfrm: Use link netns in newlink() of
 rtnl_link_ops
Date: Wed, 18 Dec 2024 21:09:05 +0800
Message-ID: <20241218130909.2173-8-shaw.leon@gmail.com>
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
Message-ID-Hash: ZGMMU7WB4PMS7WDAOL2OCOYULQKFL4TJ
X-Message-ID-Hash: ZGMMU7WB4PMS7WDAOL2OCOYULQKFL4TJ
X-Mailman-Approved-At: Wed, 18 Dec 2024 14:11:51 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZGMMU7WB4PMS7WDAOL2OCOYULQKFL4TJ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When link_net is set, use it as link netns instead of dev_net(). This
prepares for rtnetlink core to create device in target netns directly,
in which case the two namespaces may be different.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/xfrm/xfrm_interface_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 77d50d4af4a1..d1198c63dd23 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -242,10 +242,9 @@ static void xfrmi_dev_free(struct net_device *dev)
 	gro_cells_destroy(&xi->gro_cells);
 }
 
-static int xfrmi_create(struct net_device *dev)
+static int xfrmi_create(struct net *net, struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
 	int err;
 
@@ -819,11 +818,12 @@ static int xfrmi_newlink(struct rtnl_newlink_params *params)
 	struct netlink_ext_ack *extack = params->extack;
 	struct net_device *dev = params->dev;
 	struct nlattr **data = params->data;
-	struct net *net = dev_net(dev);
 	struct xfrm_if_parms p = {};
 	struct xfrm_if *xi;
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
 	xfrmi_netlink_parms(data, &p);
 	if (p.collect_md) {
 		struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
@@ -852,7 +852,7 @@ static int xfrmi_newlink(struct rtnl_newlink_params *params)
 	xi->net = net;
 	xi->dev = dev;
 
-	err = xfrmi_create(dev);
+	err = xfrmi_create(net, dev);
 	return err;
 }
 
-- 
2.47.1

