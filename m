Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F25FC021AA
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 15:54:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 36CDA8431B
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 16:54:08 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739980448;
 b=EFcCL2ou1l/n35QwhDhf6dkY8NAPTzjbOUfnt2tpPPdYBpeZB61nk2XaLGk74WKv5bWAG
 zDeHXwcvTc1n7NGw3e0O8hsswpcikbXIUIhrUsPp5RrQ5B21cBFJwNelp0N9GxLCHjTCw09
 VZ6cRauei0PO7ze7kjIzx4pn4vhlNvU=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739980448; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=14Wr2OB3TipJqOg2i3ltQmzAxlBlaCt+7msGZ+i4teQ=;
 b=s5OckJgdCXRtkJ6cD9JHRqlKhP7IZgG2hlbATTRH2tc38DkzfdU7pKBuJjbh2Lu6HkVhH
 e6ZBfi5WpK+ITHyOtELgymCzdtw5dd5BeZ7oUuA7SLvwqEBQnK5akEf/0wj/EVqlz23Qz0X
 GIF1iG0hyOMaPD1oPlkFG6IndjU90Yc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6C1C783FE2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Feb 2025 13:52:34 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739969554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=14Wr2OB3TipJqOg2i3ltQmzAxlBlaCt+7msGZ+i4teQ=;
	b=b2JIWE8zq8I2HVGkYDGm1SEXkU2+apex67kUwfptcrf3jx/fjgmvOM7MhJ/MNQtENfM8Sh
	6PmWJvWmRkTpjYh2bvzlX+YeF7FsTHYD0hq3W2onhRGQvNX8hSIR7SomUjU9hm94kIYi1+
	p7B0PD16TQ1WRiAVl1lfcm+PxNCIQRU=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739969554; a=rsa-sha256;
	cv=none;
	b=YZRP0MMxVQkgijGLd7cJ27ETaIYW69vFxIzlTX5vb5VSZatBjmVySjDp2Hpl0iolI6HURY
	FIoe9bj1Whn1fgh0nzAbLhWIMfbG3fg68TfA45KHnLvn4/uQj9lurULYz5h2QW5nLYSTSt
	WfMCHMCWLiFVp+YHvV9xyuZEbhbxikg=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=JuD3D5Hb;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::633 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-219f8263ae0so123024895ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 19 Feb 2025 04:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969553; x=1740574353;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14Wr2OB3TipJqOg2i3ltQmzAxlBlaCt+7msGZ+i4teQ=;
        b=JuD3D5HbQtzVa9SrOuIDW3QeBxMz+BI9fm5mlLoeyTZTqb6OgJSCacUu+t5ZW8hr0Z
         ORqjw90lFVX8sdxOoNgF4/bkCMZ2KVk9LDRNcpNajpaebfZYSGM+aLQvHo9Kd/UfsNZf
         khvpIstgeeibtYkG5Vg+ykfkWzj3xrge4ZRYEvw8hBiynPfAqISLLZSeZsMGek9Dxz/W
         WIHyuTnKSoR4eNu/AXpNhv9gARDVu2tuXAzy/bp2yKv2IKRaL0h4g6YXtwyuyfVOkl2R
         9bKr38OBg1aGtnKJfTEpbElt7+5IKFOyiB9l5qsh4jblpIf74HMo5c6wSpyt9q8yoVzy
         zIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969553; x=1740574353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=14Wr2OB3TipJqOg2i3ltQmzAxlBlaCt+7msGZ+i4teQ=;
        b=KsQ2ULT3UHNxnYgfKo7eYO5w6JclBvRUTMPtb5yiJnBxXLlC/L3szjTWX2Newpx9uP
         xqW/+1aiMtHI6qiDrqLwzERd8z6xestvsGTKKgxhDOIrF2fK8bDECHfYatlqFysMxvSw
         mJa6kZT+3d4sxzMfiq+921PRKuFqen9PIB/ZoHcskiQ338Ubm+Bzd0XpiiEReS3EF4iZ
         eiZp5aFnulvWQO+ybmD62Wx+vwHguV3L9q2QQGvT/4Yo5Vpg7jO16Rl3gtFYf97XBr97
         BPzifQS7+R4kf66xx8GD/o8y0XRCsI0BioeWkYSDAWm5qtvITRmh6NmpSW4Q8aBL24qI
         fxIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNWvUCU48VdH6PEIjjFaiSyaVnKEWURZ8/Og0hw5QntDcXa57jAhv6WLzoV6Tjb0ACLiEMWsq+u7ZLyw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxVhvHv2tNjN4umxbowRM4vOU3mqXgZ8p81zzqdfqlQ9oAxM3O/
	uFvZ3Uz1wNfqq7h93MyUdZiUiyOBKuNvodSyy8lWKOjU9zqv4AD5
X-Gm-Gg: ASbGnctI/rxvpfflCK5sTW82pc94IXefqsp+2AxoS47fnpNvtlIY7LO4J2KdoD+sYIz
	TJCYPmArVVaiYcC+dBhAMRbk8nfQ+fIv/qrab8t043Z/MwkqImED4PR9KNqxVlaiLzJ7aOrkc3x
	NdO5iX8jGyiS0uq0dTvLPLI7OXwi5kxVgWXk2AwwfR8Q/K5aCQOFxrLS/oW6cqMUWw5I5bDc8R0
	cTrwEuBt0Y5Jc/rm2F33cLgI8e7cHiGRUmtqaWKDcBE8Y4o2oU/OCmbRdS7Q3xaJ2UIV1hQVhl2
	PnoEoQ==
X-Google-Smtp-Source: 
 AGHT+IE1TMZXqzhrHhhVSaIMtrPumBVmrpPdtKnId51KbxVQ9NXXxJP9rSJ1kBfk/uhAUxck4sNSxA==
X-Received: by 2002:a17:903:1a2d:b0:220:c813:dfd1 with SMTP id
 d9443c01a7336-221040bd77bmr298031085ad.36.1739969552787;
        Wed, 19 Feb 2025 04:52:32 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:32 -0800 (PST)
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
Subject: [PATCH net-next v10 11/13] rtnetlink: Create link directly in target
 net namespace
Date: Wed, 19 Feb 2025 20:50:37 +0800
Message-ID: <20250219125039.18024-12-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: DEHYD6UYAICHC2IDSFZWD3ACY2OEVGZO
X-Message-ID-Hash: DEHYD6UYAICHC2IDSFZWD3ACY2OEVGZO
X-Mailman-Approved-At: Wed, 19 Feb 2025 16:43:08 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/DEHYD6UYAICHC2IDSFZWD3ACY2OEVGZO/>
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
index e980481bdd28..b52e610e157e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3789,8 +3789,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3810,11 +3810,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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
2.48.1

