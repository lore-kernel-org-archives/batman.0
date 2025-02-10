Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08EDAC02198
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 13:43:28 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A015D840E8
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 14:43:26 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739195006;
 b=zlya8MyXbL1RqfoDwh3AYxJ1ilUsRfoOVp3HmVQC/kpVs6Sus3qWEqRvshLaqp5pR3fkF
 ZgGO/6cugh6E+VJJebWGlHetjNqsE6TKj1LOq1FdEyg2kiVv4vfCAM8L9eTrrPWEqI4mk2V
 bTtEU7XWUGSsY6WcVEVa6BmUMvAOAAA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739195006; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=CBYzKh666wM3wi72dCVNRA5e881/bj/k98p0ZebqkRo=;
 b=Y0EbgRmNrFFfHF6KYrv2OZCAAqxjUHU4MBIwtLbSVv2iRyohHiSTI1aStHIoii8Ko2zop
 +vTu46jZqSrsBMZ7+BxxWyhhmJHLpGSS11+MQAdvBwpcdFft17yPCSUmD8HEfeiOqKWhZVY
 c9nnXv9p1uDmyN6RY1xYgZ2wkE0e8V4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A1C3183F50
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 10 Feb 2025 14:31:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739194301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CBYzKh666wM3wi72dCVNRA5e881/bj/k98p0ZebqkRo=;
	b=lmaWq0PnM/lhjlDFNSKOfI7iJaVn/17lzn+LQuAt13rJi47TbVwSPQcgXF3xPWxOokyVUg
	E0mVJArvqKNim/N2VzfI0Lv3dgNUnlt325UPVt7V0P0RzkN78o44Zrhk46gyL9n5xAu8Vj
	mZEq2Js18tZAlCO/0tLofyMt5QxIRlE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=HSKBMePc;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::633 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739194301; a=rsa-sha256;
	cv=none;
	b=2MNlJz+DD0DKd4TSZFjAGGPUV8u4JTM4xjOVeLO69b49hMhAbrvcGJkHZzms7SH/PaDt2X
	ehZ1wdu6LTOMuRy4w7Oi61qCzAdbn6hTeaJCAXsf5EN/n96XuCLYat1k0Ad7gJD5aaqSy2
	Wq4SSzk+jUXeAXjars83lBSpvVopjCU=
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-21c2f1b610dso106812995ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 10 Feb 2025 05:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194299; x=1739799099;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBYzKh666wM3wi72dCVNRA5e881/bj/k98p0ZebqkRo=;
        b=HSKBMePc6X0/r+Ohwnv/xLsy1k15SKFwkYZ3FXftthcb5jyEBe+FfBRDBqPhigDArf
         Sup+dJn5n+UHxwuZSow7pObrvPoMR9RPggzwCNn7lfdL2rSO/gnr2a4QB508V4RqRE6j
         BU8P7zzI3n3pZ+r+RU+rRDVwQcf0bxQlFXtei98vdFe52zMwxFInb7UJ3U6xQHKfHb0V
         MSek12f+XB9W99uoSZ/hjwmWgRYT5EFQjMK+zz8Lm9uCVWbw4VUHA1keaJsxx0pilQzF
         DPkomYgtzsHbPoRKKVkqMFFeELQjYNYFtD8uTK2dxmoPh9K/62oLy9PNnd1o8fRmVyM8
         AtSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194299; x=1739799099;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBYzKh666wM3wi72dCVNRA5e881/bj/k98p0ZebqkRo=;
        b=n8Lj4BrC7n7ABab6hIb6sN/NHNTjhYRV/nl4mJobNxOLKCh15PjcquMYMntb09oox8
         tpZ+Fja2CfwWwzC/H2FjEQCzPitpX23xL6NVWFdcjyYcRlJ8fwUJVDosPgKczfx8aQFG
         15yOYruGmJKWk1fb215CIfUmDvql/2RCvmp850XgCxqLnbUcT832fRbgwP6H3clmZcoL
         eE4GqvLlVct4sOBXu2fjvgU/Vni/eqfyoaKH/0zLh4HBJy3Zs9vBGrU3sEoMXg2t4f08
         aI/OcvDh5iP/JgBcftyeyuztKVOyU60P+64LEcwGMajJbZt4w2A1MH0ndzpTnINkwNub
         GaWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUJI6JLsYQ3JH9R5DhDBY3B+NjILTwz1vUH1CfNrWy/k8xvzUAg5ORjZnqU6mqqsyciGCWnmdXhCHH6A==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzqSlUqv8QAZiLx2tMGwbvrKT3ETX1IEABdICcGCV7UAqBHwrKn
	onAh/pkW7dfKyzVMnY5In0gRFng3iZ4Pd3iyJ0cOXgDLOwibIGWr
X-Gm-Gg: ASbGncsY0LpnWTWMja6L46iai9SW6KILrcuZy1Ffeo7iAfG11AHH/DA6uVxZlnJA8u4
	n1bvtF8WDEsU0HLIrAHT17tgMVZ4hkiFeI8y5ll8pemvIah0gY5VQGYZ6toNXJyLmIDq8iiMs9U
	9Ub9qeliiUQf4/2/Qy6OYMufRFP90hLrHx1YuWK78nqn4nyc8d746FZSimgTq8TfFa9U2NHC7un
	yabJO6v0qGjntYWROrxfHXw2FTQKAVCeHC7R8ZdIaisTt8aejt5eeirqR3tZqUIz6eACb1JDAdL
	2cerjg==
X-Google-Smtp-Source: 
 AGHT+IEvqpw8e2KYvbqgEmvCDFUuCXdsu3E3xccl+ty2yNtqbZtpph7stG1AFKdWtDXwqVY0rqWqig==
X-Received: by 2002:a17:902:ce06:b0:20c:6399:d637 with SMTP id
 d9443c01a7336-21f4e78de85mr276877915ad.40.1739194299072;
        Mon, 10 Feb 2025 05:31:39 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:38 -0800 (PST)
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
Subject: [PATCH net-next v9 09/11] rtnetlink: Create link directly in target
 net namespace
Date: Mon, 10 Feb 2025 21:30:00 +0800
Message-ID: <20250210133002.883422-10-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210133002.883422-1-shaw.leon@gmail.com>
References: <20250210133002.883422-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 7IG75WLY4UZS23MWPQUXLF4V5KJS53UT
X-Message-ID-Hash: 7IG75WLY4UZS23MWPQUXLF4V5KJS53UT
X-Mailman-Approved-At: Mon, 10 Feb 2025 14:36:12 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/7IG75WLY4UZS23MWPQUXLF4V5KJS53UT/>
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
index e9af0775fa6b..a11b2c1f0985 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3788,8 +3788,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3809,11 +3809,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
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

