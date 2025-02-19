Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5753FC021B0
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 15:49:06 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id C778F841FF
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 16:49:04 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739980144;
 b=EvPxwCOTjShFtx9BoB4+gktvkSqfX08ichEE2Y8ZQY1MUlxtAEPcemEOTWEFmhgGafZZ/
 Vf2OOj02ScyXr0AlQJuvVXZVecMSRkC/Da6eRcTzqy77qEdF995s3Fn2qqSdB+lcplO+gV8
 d8ACxh2En0HEQrhZX+9ymQIf7cCMn4k=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739980144; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=Y8g2ZzjSkLAnV2rJAeqcq6uVgaF3+M6uyZFMb8BU5Wo=;
 b=CPv4wYr3FqVlmyzzps1/IpxWt4OtlJX+qcVJUYAAUgSCdpqQRVBHHnfIwmW6NOMlhnYlT
 c4k6JWOVRUXzKUSQk/jH5ECJhU8SgkljbLFQX/9moQS0Lri5UzRjpySsi926NKg/A7UEGbD
 gXgAZPXucDh49ggOPdY2K1zQlQ/zuNc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id CB33783F96
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Feb 2025 13:51:49 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739969509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Y8g2ZzjSkLAnV2rJAeqcq6uVgaF3+M6uyZFMb8BU5Wo=;
	b=kjQE155F+Z0Tk/EFovWBmTwETG39TYLLGtgL5J3v2AU83CLlxYbw9rGMhGPchpV3qmsetW
	Y8U3hqJIlIbCP8gtsLvsbGUDksDoxcRSBBHOzWNUI3Dl8rRVC7z6a+rY18tc100umkXmz4
	Hzg7eKcco3WbzahVv+FSf9xJCJSpVGQ=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739969509; a=rsa-sha256;
	cv=none;
	b=XpL+8Ynl34wqR7AnXke5OWyXUkJASpAM848ULmoXhB/1/CwRvx9whfKxDt7pd3fFVDExVh
	EYy3LuvknpOe0RbkRBpIq2UMu704ZiNQFrDySDVMo8g879elyT+7QUMvEAkC8geIuFAkYy
	ITb6wto94uBFqeNlSNct0P0ymwzclhk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=DaTAYdgw;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62c as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220c8f38febso123996835ad.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 19 Feb 2025 04:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969508; x=1740574308;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8g2ZzjSkLAnV2rJAeqcq6uVgaF3+M6uyZFMb8BU5Wo=;
        b=DaTAYdgwXR8uLQ/FjQokojZy21I6xFd6O13Z5fiLlkeQfOxs9AhRAxqnuNjoGO9M6K
         5iFlOzdysb9StthqAqZODkOth01XMgKSCVauXYo8NPFiNnsAjPXnHNMizCbx32jmwY+z
         /+b6kri3Ln95bFdwwakpM9YXLZqHA8DVXpMhZut0PkkfnHMUAITNA/4MFPBlhs+OfxlA
         CvMZZU8xF5ieMA5fAm8q53jkr/mBLoM2joByq12Jh8YkNv18pOF9gK1p2Pb5uR1Du64A
         /rWbetrg9zXo1G8Ty4YwcJzN7stIb253LNoqLeQxnAQ4INl5Ktx+DpEg4gzywLHl9K/z
         sR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969508; x=1740574308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8g2ZzjSkLAnV2rJAeqcq6uVgaF3+M6uyZFMb8BU5Wo=;
        b=bZdIsHU9+o9d61llNISFkX8e/8YHuHs4C+XDV6dfoAjjJl3sy2KHUo5N++5OUW/iMH
         mCp2fp0swvDya/bPC/eNu9bBWE6ZDbRh/mraYUPzlOYhG5RfU+/s4Tf0ry5/1GUaQ/LN
         gz5maCTDUeNwsxNFoO7UDstZ7jFVEAiXHwWzJ2pEsYAT7Cqv+D9e00OwKpk/W6sNNf/f
         Xwn8cwBld/zmQvwlgjI2XtZej68UMuNFa7Em+S0XiVEdplwkNQ/epHDBNVgcKc+mN0Pd
         2Ua8oC/oFMFGsh0HTSokDgHcfTCoFYBQJAi9hX/O52yRL7JgNNdjRPNAajDTxJybCHEu
         nJPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGjyvcMW5nhNSVn69gKF5BGGV6klBiXDiUYjSQLrL7/HgJZoV3/gwvbnOWF5kZDeoenmmiucOvR5Oiug==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzYFmW1HIBaq1kP++xOvWoD8jfqgiwx2N/mK0bc75g2samL9UMn
	SCwFG1II3oa70OMYP7A3A8VOhqylNdbJax7i7X881r8F+QXqgEK7k8TExYMOIAM=
X-Gm-Gg: ASbGncvdELO5qAB7xQhDRjgFdJWSfF/GTZuGKCdPem05kSlNIuZNJ5j+f6DHvahgqUL
	rkLmXf2Wub12OCg66zlA5LeyqmIejKRBmR9K3vqKNXwKzMapuywuK/F0HQSXf/t/DN4HeqrUnDz
	/GD8zkrPI2XCiZXumdtcXn0iEURvCL/20p4Q7queYuW+FmHXkFdAwJoNsLmLz34vKyPisT9Lf1B
	jAztDE9AubEqWDQRPMV9OXIh5g64AUgwiwBLLXMoaQydybZTms5Gii79pdVM6zfuymUIVQOqbgB
	fH1dTg==
X-Google-Smtp-Source: 
 AGHT+IFYP0H8aiDg7L5uhsGsJLhgqrRsnWJTkGp9h+ijz9vj+qGa0NYcij3UcKBMYCMaV2Zll9Ie8g==
X-Received: by 2002:a17:902:ec84:b0:220:d532:834e with SMTP id
 d9443c01a7336-221040255d9mr276303305ad.19.1739969508267;
        Wed, 19 Feb 2025 04:51:48 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:47 -0800 (PST)
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
Subject: [PATCH net-next v10 06/13] net: ip_tunnel: Use link netns in
 newlink() of rtnl_link_ops
Date: Wed, 19 Feb 2025 20:50:32 +0800
Message-ID: <20250219125039.18024-7-shaw.leon@gmail.com>
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
Message-ID-Hash: PPVF36SB2ZCKU67HDHFWVJTVI27XN7Z7
X-Message-ID-Hash: PPVF36SB2ZCKU67HDHFWVJTVI27XN7Z7
X-Mailman-Approved-At: Wed, 19 Feb 2025 16:43:04 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/PPVF36SB2ZCKU67HDHFWVJTVI27XN7Z7/>
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

Convert common ip_tunnel_newlink() to accept an extra link netns
argument.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/ip_tunnels.h | 5 +++--
 net/ipv4/ip_gre.c        | 8 +++++---
 net/ipv4/ip_tunnel.c     | 6 +++---
 net/ipv4/ip_vti.c        | 3 ++-
 net/ipv4/ipip.c          | 3 ++-
 5 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 1aa31bdb2b31..ae1f2dda4533 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -406,8 +406,9 @@ int ip_tunnel_rcv(struct ip_tunnel *tunnel, struct sk_buff *skb,
 		  bool log_ecn_error);
 int ip_tunnel_changelink(struct net_device *dev, struct nlattr *tb[],
 			 struct ip_tunnel_parm_kern *p, __u32 fwmark);
-int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
-		      struct ip_tunnel_parm_kern *p, __u32 fwmark);
+int ip_tunnel_newlink(struct net *net, struct net_device *dev,
+		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
+		      __u32 fwmark);
 void ip_tunnel_setup(struct net_device *dev, unsigned int net_id);
 
 bool ip_tunnel_netlink_encap_parms(struct nlattr *data[],
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 1fe9b13d351c..26d15f907551 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1413,7 +1413,8 @@ static int ipgre_newlink(struct net_device *dev,
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int erspan_newlink(struct net_device *dev,
@@ -1433,7 +1434,8 @@ static int erspan_newlink(struct net_device *dev,
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1701,7 +1703,7 @@ static struct rtnl_link_ops erspan_link_ops __read_mostly = {
 struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 					u8 name_assign_type)
 {
-	struct rtnl_newlink_params params = { .net = net };
+	struct rtnl_newlink_params params = { .src_net = net };
 	struct nlattr *tb[IFLA_MAX + 1];
 	struct net_device *dev;
 	LIST_HEAD(list_kill);
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index dd4b4e5be998..011f2a5aab3b 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -1213,11 +1213,11 @@ void ip_tunnel_delete_nets(struct list_head *net_list, unsigned int id,
 }
 EXPORT_SYMBOL_GPL(ip_tunnel_delete_nets);
 
-int ip_tunnel_newlink(struct net_device *dev, struct nlattr *tb[],
-		      struct ip_tunnel_parm_kern *p, __u32 fwmark)
+int ip_tunnel_newlink(struct net *net, struct net_device *dev,
+		      struct nlattr *tb[], struct ip_tunnel_parm_kern *p,
+		      __u32 fwmark)
 {
 	struct ip_tunnel *nt;
-	struct net *net = dev_net(dev);
 	struct ip_tunnel_net *itn;
 	int mtu;
 	int err;
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index b901bee03e6d..159b4473290e 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -585,7 +585,8 @@ static int vti_newlink(struct net_device *dev,
 	__u32 fwmark = 0;
 
 	vti_netlink_parms(data, &parms, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &parms, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb,
+				 &parms, fwmark);
 }
 
 static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index a8b844bcfc64..bab0bf90c908 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -455,7 +455,8 @@ static int ipip_newlink(struct net_device *dev,
 	}
 
 	ipip_netlink_parms(data, &p, &t->collect_md, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
-- 
2.48.1

