Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2001AC02198
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 13:42:43 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 934EE842DF
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 14:42:41 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739194961;
 b=usMeDNJQbZjdIarVHRV65aIzxXdsIKgVfeuHQObuAk8O1Xoua9M0JGXmc26Cg+uNtT76p
 pAc5v83M0tfCLp0X+nknMpIyRXS4LdXp+/BHo23aBiXEr20ra6k/fqaVoaIom4ufiSccHY1
 qWFsqOMGSPqVlLJOtx1hqt3PTrSy8js=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739194961; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=JIWpuyrhnho0qabV5ShFTJH6UcUC2BreOZhovgVT2xw=;
 b=ws8ylo1FgQ6vmUNFeRHUnNu3uPRK5TskpRQLbOIxIOIaJBKd9JEXetgFhPGqDGjph6Ix/
 TIMJ+eFX510o8hOyG/V43dblSWzsWogl4qxJyXVrEvQjY7W2yDlZEZhtNnETyKJuqkeUMZ4
 xQwFMCi8v3aqhiSQ3REGrWuNLBGQkCE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 84BCB83F11
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 10 Feb 2025 14:31:31 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739194291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=JIWpuyrhnho0qabV5ShFTJH6UcUC2BreOZhovgVT2xw=;
	b=Qg64kcdkhDb4w+01G7lBnt1owoW+5jYQPhNl5rkGKZtdIBqCYC3OBqs0GC3LhiEtEDNv6Q
	nBKQeR4MqSzMb/Iwbhk8eztMkU+0Kh/DKUPoJEfQ0rO1Z4RLiDdOUX8HbLN3r7AJI36TZD
	YWHvty3i9RcUkW74MYoC62lAZ5Axfns=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=XkPMtp2Q;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::631 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739194291; a=rsa-sha256;
	cv=none;
	b=GPWp23vDxCjsCTev3nV5DZ4TROjsDK+LppvZRTwqbcgRw1rWJLf2VfIDeP5gIHZrj5QVPe
	+Uh5ZKp92HyGtfou2AjCtSVMzzlCaEqI1QQXxvj41SP3kUtEySIwc67dMiegC08+pzoc8f
	WNA1gtlRhZNcAzgnEWCFOTTMiFckv1Q=
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21f6022c2c3so35479505ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 10 Feb 2025 05:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194290; x=1739799090;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIWpuyrhnho0qabV5ShFTJH6UcUC2BreOZhovgVT2xw=;
        b=XkPMtp2QmSaL+mozX3wUDLsS5pHrcg/A0Kv27G7mu05L74mHKxKn7y7palxx9dLpPG
         TiG/SZru2QwtvLfrhLuD59VE50RpCpdwB2p94My3OYHz9a95Pr3XynUm4joBQfbot0XA
         Fk/uDu4AJW18kJY0peAmSruAPz8OM23vxNNLczIniqsfx0Y/JJimejrEN7MgJUPVRLZs
         4vQv9SoayrF3YQHwJIGX5mxg5Rh2LLZR9VNthtkOST48ZujKJ4DiC3gS59DrZ41C6gn+
         +QxoSMQzjX7XGf/Bgzhb/AmuxlqTzgdaOMZTHG+OlOWxjNhMxXn6sfKKzY5LYuVnIm/h
         hBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194290; x=1739799090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JIWpuyrhnho0qabV5ShFTJH6UcUC2BreOZhovgVT2xw=;
        b=bZi8P8tZYbnuHKNX296E/eSy2Bksn+9/8HIqejtyIFCazhnrwWuuhLWCANg/0k4c+m
         DSr3JTZvSXO5Qn6pIGDAW5eLPmC9mZBNlVAJVvSQuHO0ndq2qyOd0fzr2l6boECpcbFN
         tFHohPqaFvLz+KQikvkCABwFoq00ayz6gF/lEBHStDQPUGT9mBFJBc0Leh3kK7Ov9Gc9
         ynFZXfBPOwgdh1Ugf7kk+gAJztRUQFTuQ8rTvMcxOazl/slj4KVAc+0uv1xzs7bA7KBE
         yWJHTo6bkWrk+bqLTHVpdp2wPAdr6w/cuj9KmbODDH+9Pl5UMBSJvVHFSk5E8LNts/bY
         +6rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4OnvFHEiiV9ov2xh7yJUkieGvSRkBANlomH3yB2ZtQEyQDoM2SVDXWlqddQYj3DCf71OU0rha72DLVw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YynPv7+b6+WAFwDcCRSmR8L5ntjlr2YIogVnS/ZcRIhmBLkntJ0
	ExY2xQE0eCJNljafkYZueWyeSIxDIgoEfAIceVAfP3k0MMO1kaLD
X-Gm-Gg: ASbGncu/P/C/BK9F75vDSHJiSHHVef1e/YgA/re+TPDN+dLagSthJulHcBfQVMV8F9Q
	JEAuBi8ESMGtjJQY+pSfGv3ctF0vWtAlBQV8fF0WvZXQhfzN3yWqXZGzHfbqSgUyX8ZK2aPDCcj
	NO1qaOpsd/u9HnqtVt/5EbpbrhIvJtEij6bxbbD/JltUD/dIvB8B5+bvbtjwIsdK7pCDn+OGl8D
	nijs9B9/aet4dhOToHJUo5siRMaAwNdzrTqmyQBqFKnLgL0JRroNouIEWRb32it+dTuGiWQYEKG
	98HR4w==
X-Google-Smtp-Source: 
 AGHT+IELdC20KTjI7AEzrj7SsYJqrzU0cpR4bU0xmzWBFbAdZdANoU6evRtqtyIIyxHfa7kTbn7qJg==
X-Received: by 2002:a17:902:f60f:b0:215:6c5f:d142 with SMTP id
 d9443c01a7336-21f4f7a257fmr230770855ad.20.1739194290046;
        Mon, 10 Feb 2025 05:31:30 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:29 -0800 (PST)
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
Subject: [PATCH net-next v9 08/11] rtnetlink: Remove "net" from newlink params
Date: Mon, 10 Feb 2025 21:29:59 +0800
Message-ID: <20250210133002.883422-9-shaw.leon@gmail.com>
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
Message-ID-Hash: N5FO4UNLBCKSOMUBYTIS6QR7UZLO3WM7
X-Message-ID-Hash: N5FO4UNLBCKSOMUBYTIS6QR7UZLO3WM7
X-Mailman-Approved-At: Mon, 10 Feb 2025 14:36:12 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/N5FO4UNLBCKSOMUBYTIS6QR7UZLO3WM7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Now that devices have been converted to use the specific netns instead
of ambiguous "net", let's remove it from newlink parameters.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/rtnetlink.h | 2 --
 net/core/rtnetlink.c    | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 00c086ca0c11..dd51240431b8 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -72,7 +72,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 /**
  *	struct rtnl_newlink_params - parameters of rtnl_link_ops::newlink()
  *
- *	@net: Netns of interest
  *	@src_net: Source netns of rtnetlink socket
  *	@link_net: Link netns by IFLA_LINK_NETNSID, NULL if not specified
  *	@peer_net: Peer netns
@@ -80,7 +79,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@data: IFLA_INFO_DATA attributes
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 7e98f3cd102b..e9af0775fa6b 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3797,12 +3797,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 
 	dev->ifindex = ifm->ifi_index;
 
-	params.net = params.src_net;
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(dev, &params, extack);
 	else
-- 
2.48.1

