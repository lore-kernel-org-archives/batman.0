Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A57AE77188
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 13:22:44 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E2640840C0
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 14:22:42 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735996962;
 b=ql+UulJOPzN80E98QZ0GgyZNKqiOfQsmWFxCB67AVMNfNaGnz2XxGrhpvxVZ9gXRAj9d6
 qDjn0+OdXd2to3fhBDrszb8WyroyjGnIe/7bbTiL3fIzA89kFjOcm3jX/stq2qo35ls25af
 2GyI9fzK+UZE2wTwXgN5K5X+CJcMOqI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735996962; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Ce6VaPIVkPoT/BnqzSEc4rQsuMP37QI18aEevx41SAs=;
 b=bDziRdqLDOAExcldWt5tHYtTZDbIvXap41/pTxCJpQZ6zEQ5y/+4a8aJlZbqZLq1akH3p
 Prjn1Ox9xhssUmbuVGkzOFVbiGpT1yL+E3reXFmctiYbetqn7UY9nVYauPdspjwaeoL5x2N
 cd+8FIGuJ7xDkhGljL+lyIdSjONE+Zc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A966A83FC0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 13:58:52 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735995533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Ce6VaPIVkPoT/BnqzSEc4rQsuMP37QI18aEevx41SAs=;
	b=u0QnujbfasyCyZ1GF8DlRYs+76fE/ymwuhFHJFfNuu/7bAS1cBvL2t3f7gMUrvRnxrdxFn
	fN2uJL9kkHinR31dpgICC/7PUUGe3xA387RARRXNYshk8EY9hiNJOgyvQn+rFjn/853q9n
	I9NceaMiaOszcW6MEK1OclUdYJsUWZM=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b="kB/OaqJr";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::634 as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735995533; a=rsa-sha256;
	cv=none;
	b=b3LOlxrobZcR8X10TOd4QKeviIkd2bKDhCU+nrcgiqBR6bS3gRfljRQl70WwW0J4yrkWJA
	drWhLci42TAkrb5BjOPuZbWR0LtPM0XwSIW8fLgUrAmRGzvOMMy0SjEnH6rDAImOiTdmXt
	V2w87XXPRvPo7dbEzGhsIHSR0A4rHvw=
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21654fdd5daso171277035ad.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 04 Jan 2025 04:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995531; x=1736600331;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ce6VaPIVkPoT/BnqzSEc4rQsuMP37QI18aEevx41SAs=;
        b=kB/OaqJr7X35pqrhsWr6UlkSrCJoX9OrNnm0J+F5J9IsbBbdViTKNaNxIfYSc7OuG0
         AcTkk39oS3tm+pZGTzmJpScAIQq4RFfXVM/gxBdVvDERAfCKwUt8xTSfrv5zf4jIIU1N
         mpyEO8/cELBcsxd0HDvBnHLMpcQtUJfwxePeuQYUpb6zvJ05qMtrzVNEg58cQem42hSa
         KOqtmT1CkJLAvC6S0s6ZA1vL7mQEfIeub9DEZFYVwYuoJYLRMpGjKHulqBZsr/UwWns/
         HlBdsrsz/R0K67nZb+0Th0BB19oX1n68MWnQwmRUV7FJswdqSiZx6mFw6oVSQnmvw/at
         DFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995531; x=1736600331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ce6VaPIVkPoT/BnqzSEc4rQsuMP37QI18aEevx41SAs=;
        b=ZJchAFXGwXhOGHWsicetPrx+odCXtpRaJsbhoyZ+h38BulIuJBNu+vIwjVR7acPRIE
         4BUWDCWPTSozm905ZRnqmV3HHTr7b5r+mKyWdpzKrU5Yq2MhRIV62fx+LXiXpl53/pFP
         nsiTXvA6F16T2ioP3RHYF40+OtL0sgQq8Bw+gZ6iXhrOz/EpM6MHOxzxu/vAYpuVVgW/
         yOlkTVMU7A3Cn97lqHdRCFz+rNU6SQImhu+l9ozQhvrawj2gG1jOfxPJqwS1izAvFY6u
         du+0NcH8/o7ueqF9DhRAeWarUiDbKYXkWQ7+/DVYAJ+OUMFVdyHBKSsMsfnIFQUfZJ9C
         bT2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW/oIXQkrOJGEzFeRPPQ/X/o4EEy5/o9kZ5GcOsU+izGxz0daOhDtCoYg1451nWmPpX/ZJ9w5A1JbPNQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxU8YocsatLBtEtJ72JBG/wcz6ADWA1a8bIHFd9YzDkYuvFcoV3
	Gw4Rj23wwCppEqGbeDU+xHxrphsVL80rCAgXXdNtXOFWXvGCroZQ
X-Gm-Gg: ASbGnctuvhdxqkek6iLzEIquW7628IVXN+UhabwGWyrf6rTNVC35vvWvLtc25GTPwee
	ZheuEaW4kE4fJBeaEdHw5w24lfmdQOEGh1R68SJSLGvGwl2aBZQoiOL74j9PKTo49+zpwLt0iAO
	/DBPoiJ7c0gsdAn4G1yDsQ/PRY+W0p5vsAdgv4zfWHQxjtETewXgUmBdgIwsviz8Q+5hm9ea/qr
	PyTbuxv4wYdyr4F3paTTrzXFOE9+Fp1csGu6rbFLNFOauM=
X-Google-Smtp-Source: 
 AGHT+IFpOYXqaI1R+HGOEzzxslPytJ/PM+OYSeZsg4xs6ImgmD2P2d6ce4kFlhBJ9qWXqvAf2AhpWw==
X-Received: by 2002:a05:6a20:1596:b0:1e1:9f57:eab4 with SMTP id
 adf61e73a8af0-1e5e04609b4mr80108339637.16.1735995531119;
        Sat, 04 Jan 2025 04:58:51 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:50 -0800 (PST)
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
Subject: [PATCH net-next v7 08/11] rtnetlink: Remove "net" from newlink params
Date: Sat,  4 Jan 2025 20:57:29 +0800
Message-ID: <20250104125732.17335-9-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250104125732.17335-1-shaw.leon@gmail.com>
References: <20250104125732.17335-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: P4PDPSHDDTJ2MKLEHZDNWJQ4MHSSNCA7
X-Message-ID-Hash: P4PDPSHDDTJ2MKLEHZDNWJQ4MHSSNCA7
X-Mailman-Approved-At: Sat, 04 Jan 2025 14:17:48 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/P4PDPSHDDTJ2MKLEHZDNWJQ4MHSSNCA7/>
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
index ed970b4568d1..04fc0e91af42 100644
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
@@ -82,7 +81,6 @@ static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
  *	@extack: Netlink extended ACK
  */
 struct rtnl_newlink_params {
-	struct net *net;
 	struct net *src_net;
 	struct net *link_net;
 	struct net *peer_net;
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f902b8a5189f..a2246bbaf2bc 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3758,7 +3758,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	char ifname[IFNAMSIZ];
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
 		.src_net = net,
 		.link_net = link_net,
 		.peer_net = peer_net,
@@ -3787,11 +3786,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	dev->ifindex = ifm->ifi_index;
 	params.dev = dev;
 
-	if (link_net)
-		params.net = link_net;
-	if (peer_net)
-		params.net = peer_net;
-
 	if (ops->newlink)
 		err = ops->newlink(&params);
 	else
-- 
2.47.1

