Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E8B2C02180
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 15:24:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9C64F8424F
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 16:24:56 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736781896;
 b=1iAyF2Pr9GEDCVd2SO4yn7M3dCNvBMcZObexoVyvpuOIZ7bIA9y6TowJuYvumbGa2LbEq
 LmKapVX8ej+12syQ4uRmuybltxwhTP3zY17my+fnWmc1K25o/ArgpZXeUtTRsSkDKtxPsG+
 47T6xRdS03mnGYJK+v785/eR82aYq5E=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736781896; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=MlOA56xQJRVfhoUOrNRPIk7EOBdTk/e52r4/wRWgOdc=;
 b=PmnvZoIx7DzJy+wLMrKJX7ddxQ7+ADuYvE625ffxAhU2eivFh2FKZ2aCsX4RF7t6bszIG
 d/QDiA3qcmNqyEXa9SDUJMy6+aJ13lHo3W8Qy/GTgUTK6O6RVTpt++EQab1R9dxBzL26tBt
 0vD7G9QFpB59WI6On42qKrrM2foCWNs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A87D381B7F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 15:38:14 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736779094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=MlOA56xQJRVfhoUOrNRPIk7EOBdTk/e52r4/wRWgOdc=;
	b=QCO0IdR6FantZkvec5HyWkhNUai/8RwqgdB+lV2F12CHTqANpA5NfFxmWICi8Hs9erjiJE
	J5CLi661dCVbQ/D5GAB03MJbBBsWCngOYJxErsuePHvLFpUaMZLSgg2OF/RyxdZhqpHt0i
	pAXe0EZSfibJEkj7pEVrcreN0JUk47c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=aTYHKGCZ;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62a as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736779094; a=rsa-sha256;
	cv=none;
	b=kr8FM4Sn/XV9NICkIrwJmhkIcQWTy1l/f41MOw4zlLZQ2pF2n5oP0ogBa35YKCfdnjIwm8
	VPnIU+vAOz1x5X/epJc6OiSfPfUQNt92JB5lBkdzqPbrOaMRhRB0yDYaiNZQtNyFh9Jnau
	155glMm7uaFMU67oIwUO+vKY9AG3bA0=
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-219f8263ae0so71032595ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 13 Jan 2025 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779093; x=1737383893;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlOA56xQJRVfhoUOrNRPIk7EOBdTk/e52r4/wRWgOdc=;
        b=aTYHKGCZPjjE0U4VdmhfNwToQX7uFtKdUlDkyVNRwlGj7RjleQir8pT0AFT2PORst7
         37DuyhNrtLH9wG9B9QEJ3UrHBm6olG7PbmMuRR0YqkQlILmKRevOREhmW61rCYAAX0F9
         JLQFeUw9fC3+cZ0jQQbQiz8LTYE2f7/rY9Pq39zhO61ePVUwYcDyDnizO1yZrt/RmWb0
         XOpLOBbJZFZfo01cGYAs79AGxk38VkGPxMdtBz+Vl7ztNtYNrKiKl+gCA/w7tldKaNZe
         l8FHQHKc2mHAzBgER1gF2c7c1dLPlrOGNCI8kpDi6taaGTJH2aTTkYPECYF4w+jAu0mP
         bH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779093; x=1737383893;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MlOA56xQJRVfhoUOrNRPIk7EOBdTk/e52r4/wRWgOdc=;
        b=BF8tUu7Y1griQPKQB9CEw3x6WWcQ8REVkv7NWGeiuMe3iPmQK4Nu8D8AD7K1mDny91
         WIfXmt2wGZPXLrG9869cm61RITyYjlLeJMysBAyiCcyNJ/3QWx8AN0nup34iqQWV3qmq
         YvW2OwUDoadj3Bwo36WiSl/qDjS5+hJC+OavDhlWLoqaLrxL7nak4Lt8qYJiOaq7HeuZ
         NgJPgEQ87b48bbJEc6pSlIi/lQWcJH8iXZIgk/Xs2WfMeVfa8gCFx7+2opZnPUSfUw3G
         CJCYhVDayGosVYR39G/gFgFOrs6I4Wth+ubnbjT2DG0WeAhOMOGCrjc4Fy256hYS9I0i
         Gb3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTf2j27yX2OsULCOAAPeLGv16P51no5PPR4m6d+Lfch6Fmu7+NRAFvxVjxwKpBffiCIr9HUl72oifQAA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzkiJOcjVp0yYJ4xIiAhNQtX1GI+9AvCkj6dyrMegtERIbEIXVs
	PuIGCYr8hvYSgam7EUyUGNDfkOw1RT93fbc6zK7xgYyJ2lUenLkr
X-Gm-Gg: ASbGncsOFJEv7/3GymfkfRX3eD3Vr1rlXo3J6B1oaZUcu/28qFtmmBO+sSSZ6lf4HVZ
	vIBCC/mRq6eyapZyvK+LqMJH49a31iZ9dpQifRGe7PTo4UxToh+rqKp3T+GrkyD5/1qHybn5fju
	VXOxrlTpwB2Cm/I5IJZZJlAbhFVxAwswPdMdUWpTK0kuWPBUBlkEsXC+iqw/F4ornbaKWpJHx3K
	79g5pfLA3qFj+PS2o/CQ6PYeqFoc8KuaZuLSiJD1tTkGbs=
X-Google-Smtp-Source: 
 AGHT+IETQgOg7AunUSIVLfQXCmw6Miexgpzxtq5jBXEGmuKIo/a/YyzF3Hf0c0R30+3xPOc3lWG52w==
X-Received: by 2002:a17:902:bb8f:b0:21a:8d4c:a9b5 with SMTP id
 d9443c01a7336-21a8d4cab74mr209427215ad.12.1736779093022;
        Mon, 13 Jan 2025 06:38:13 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:12 -0800 (PST)
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
Subject: [PATCH net-next v8 04/11] ieee802154: 6lowpan: Validate link netns in
 newlink() of rtnl_link_ops
Date: Mon, 13 Jan 2025 22:37:12 +0800
Message-ID: <20250113143719.7948-5-shaw.leon@gmail.com>
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
Message-ID-Hash: CSCYZAL6H7FXW45Q2WCRZXDDCJXUCVCD
X-Message-ID-Hash: CSCYZAL6H7FXW45Q2WCRZXDDCJXUCVCD
X-Mailman-Approved-At: Mon, 13 Jan 2025 16:21:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CSCYZAL6H7FXW45Q2WCRZXDDCJXUCVCD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Device denoted by IFLA_LINK is in link_net (IFLA_LINK_NETNSID) or
source netns by design, but 6lowpan uses dev_net.

Note dev->netns_local is set to true and currently link_net is
implemented via a netns change. These together effectively reject
IFLA_LINK_NETNSID.

This patch adds a validation to ensure link_net is either NULL or
identical to dev_net. Thus it would be fine to continue using dev_net
when rtnetlink core begins to create devices directly in target netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 704bf9e3f097..ee318d46817d 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -143,6 +143,8 @@ static int lowpan_newlink(struct net_device *ldev,
 
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
+	if (params->link_net && !net_eq(params->link_net, dev_net(ldev)))
+		return -EINVAL;
 	/* find and hold wpan device */
 	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
-- 
2.47.1

