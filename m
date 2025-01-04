Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FE75E77197
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 13:18:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 35CE58403B
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 14:18:35 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735996715;
 b=nxmupHF5afKeOx1TgFhXcAej2rOQ1BZqhTn8kjqFPbOocGL8r5Thrw4XLyFDOTCMghXXL
 kDI7oPGkFNWMH/2L3bvoVbTCweKdkYwjqZ/eorkqrztOkTjQQDUiF9cQh4ts1klHf+BEed8
 n/JiBoDiOeVtB7dW3I1xaTaJ6EwnEGY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735996715; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=R0y9nB6XisXA1oDe7UDcZLSsAyAYhl+7T93j9PgZqLs=;
 b=hG3F2iYrWUI1gaP8T4VmVoQ8WzX6U+HUD3z0Zukzbrh5VEOqbqyEDcLHJXn00dDxEhxkr
 u5nBk8qtzMP8UZwNxTlabz6uqZdOOCJ/Z8uY8bCPWdz5jfETt9dyw+D/SvxqrEMkqaKSZRG
 lnCj/1NqgpX7InkPJRNiJZx4uGPRGJs=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EC7FC83CD1
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 13:57:55 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735995476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=R0y9nB6XisXA1oDe7UDcZLSsAyAYhl+7T93j9PgZqLs=;
	b=NCZ3pBpyIADPB0UncpnOZwuiJIXStoJRkRqS3+kPdiffs5LmtXHjXtDDT41im02NXVGYYz
	gExQhNP8r+2lLluH8sKXk0XGC/HfF++ugSwIqFN7vss0Fe7e1Zk8pcM2q63ZmF67WngXNy
	ezMTL/qWoF5i7hp9I0kBgXiOvz8FOe8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=lStHkl89;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::102c as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735995476; a=rsa-sha256;
	cv=none;
	b=26JWrcwKkKt+BITe1bQjFEoCmo5mVPA1ow1A+kJBep/f8sdHEH/u6dRUOgi1igbLdPMWib
	Rf5BIJhF2999sF3ubbyu7g2vzS52OWohVlhfE/o7JHitIQHRz3tWt6LYtWzObwQ4X2T4Cq
	7vg2ACv6Mgn4YfBgqDi0s4FTdAHnJ9M=
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so18829267a91.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 04 Jan 2025 04:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995474; x=1736600274;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0y9nB6XisXA1oDe7UDcZLSsAyAYhl+7T93j9PgZqLs=;
        b=lStHkl89wgqWlJQa8pkWOdB8fO+p6DgQjPPiy+W5elpx1B9sN86YrwsJ+SHeY7o2gV
         OncvWWay1QidyjZffXowbpMsobUVoV9+wUvLkEMjRuY9bLTRcirA2VxWGtIowpPFPR9L
         MuHkJx2cpUx0GWkAbFUUkw3es+cc7mekW1Um9J5cM9WbNb13c0j7IqohizNVtiw7gPu0
         KKGGehEPsLw0PpMQFlii368ElzUngrCt+Xoxh5L3SHTfOVbVr1FX7kWvXj/5COmMgh0F
         VKGDwxJLfwQcqpGoi9aF2a1gpvsEceODRnSqYjjk1YXiaPN/L4typ93pAJu+UMOP3ZGH
         Hikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995474; x=1736600274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0y9nB6XisXA1oDe7UDcZLSsAyAYhl+7T93j9PgZqLs=;
        b=FStWLCicrVyJILKkmpO9odGaH/RGguwxMwqL1+uOc7hWv0Uo01gSCjattavVkuVSL1
         eB2+gIFAZQMPgAzM10t0WwIxbZIuhZgJHkb5Qf+ZMmidKRMUPmji6xVFgaE40iYjAl2J
         6zM6O/i3VVC+oUgofEPsZ00bTIzzMMiIwNDCgkonnZJDcv9GtpoSVp2vUj5xTuTHrETn
         QNeb8Gg1MNlzyM6lQxUJcNUiT46FWJTLeORphqJZrPbXX6MrqSqTXnejez53ZwP0I9uS
         PlWhhoz4FRfvkONr68gtJPURD1ciqKZLASSOqh5amvQXMg411ktpkZlR12rLgbSEgaro
         KTMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeFhlasDyQ/Qpd5fJRy64Njf9Zd+tSU9xVz4WnBzXmNULXJ6XMEHIY5XRxi1Kegi265O6DaSdtkAUqrA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yze+TRYm1OSpjp89pSckzp72YvUw+ju4ggTtUMju/0m0dQNT7jM
	FHnOq0/VSgXAuZ6fpWXCbmqbUYVhMROMBSM1jq67+HOLH0TN0LyU
X-Gm-Gg: ASbGncvJyqjNzkd/Qe6QNtlwF2orgbHturZQGeSyaV+5NxY3qgmcGZdFc90r4MTdZ8q
	DD8x5/UzWY+MyKjSBwHTqnsqw/C9CiJHD4gArE3X5Bcwl1WZ+8InGtBtWMKFo/MXNUHuatFPKoM
	mSDDUW0vOKNnfa6OtFOpYc7MMU33Pv17EZ7HJZ3xVVym1K2X+ywLIxeb6lSul3qMCKpk+ETREoQ
	fMHjAg96OQt8dq6hQCdAb1GCHXu8v0+yNm3iu03GKHsXzU=
X-Google-Smtp-Source: 
 AGHT+IFUA9yMRsjxfnRxzsse9+CSmxwl7XAkA4eYuGkgQjijZt7M7pM04aasIYGaynTW3Vzrs9d/kg==
X-Received: by 2002:a05:6a00:22c2:b0:725:ef4b:de33 with SMTP id
 d2e1a72fcca58-72abdbe4de8mr66912486b3a.0.1735995474274;
        Sat, 04 Jan 2025 04:57:54 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:57:53 -0800 (PST)
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
Subject: [PATCH net-next v7 01/11] rtnetlink: Lookup device in target netns
 when creating link
Date: Sat,  4 Jan 2025 20:57:22 +0800
Message-ID: <20250104125732.17335-2-shaw.leon@gmail.com>
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
Message-ID-Hash: N4I5HBTFXOGC3SILBYM22B4J2JFHGVFM
X-Message-ID-Hash: N4I5HBTFXOGC3SILBYM22B4J2JFHGVFM
X-Mailman-Approved-At: Sat, 04 Jan 2025 14:17:48 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/N4I5HBTFXOGC3SILBYM22B4J2JFHGVFM/>
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
index 6b745096809d..f65bd49da541 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3852,20 +3852,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
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

