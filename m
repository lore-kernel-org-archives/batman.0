Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826BDE77187
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 13:15:57 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EF60C83F00
	for <batman@archiver.kernel.org>; Wed, 18 Dec 2024 14:15:55 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1734527755;
 b=eDITCFfPJzCnrTbtH21ZCjN3ynGUsFll/Zim5c7zW/WTfrgtFGUuCF97g/idO1ycn/gSl
 H6bVdcSkO00KLbz+co6tn8sUl3zPNe7LPXM6iBIgGtoVVQC9D9E5YlgHw+/Yr5d1igYdWYR
 B+gNY/NfYYVXMYbkgT6HwJQKg+eYZI4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1734527755; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=duDRQNaydM9MnygAgym8Q8/9ko+la+IiXsEzlSyfpMg=;
 b=dgDLzHyX+jECF+i60sComb5Cd/OmFYmbnn+34CCgr3AM34wrUSK0NMyyU/u5efb3/rWef
 o9ffDNKRH8p7ml2iSxEO8wduBapu3E0FI5hxxd83UhrPkgVYUckEwpGRXU7dHQFS0c9rm6S
 OnsrVRnGPX3SqjaSf1N783idaacCt9A=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 8655183E75
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 18 Dec 2024 14:10:07 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1734527407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=duDRQNaydM9MnygAgym8Q8/9ko+la+IiXsEzlSyfpMg=;
	b=Yj0SyVHaU9UmcPNERxIDsRNrObZu9jPgnW1P7g2XSpJ2Si8jaQypWNlzcCgERhQ9rxoFyh
	RDylG/SE8AYRl0fRWLQ5/dZ7JR1I0BlQzssvbMcRhZK6k9TPRuEVd53b5rpBYsyD32orRT
	IMqpWB9lLiPV81behaGe3ABW9kHK+tQ=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1734527407; a=rsa-sha256;
	cv=none;
	b=BrY20UF7EFhN2mKKPMK5sFqn1PKWp09E9uQ8Kw1wZe/uZ129To3ReoMnA0NKQ4duxo9K7k
	qyTAFBJcYnK8uCgEk+v35/nZk1KLLOuBJNo4f13LfderX6e/UoFXy8zw7YuOytG2JH7cWN
	yunKJ1oC0NxgaNmx1wisOqqaQzu/ckY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=IGGdOOP0;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::42b as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7242f559a9fso8248066b3a.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 18 Dec 2024 05:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734527406; x=1735132206;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duDRQNaydM9MnygAgym8Q8/9ko+la+IiXsEzlSyfpMg=;
        b=IGGdOOP0HwTcnniApwF9oXAyX6df/mZrWnXAqraS+Ia20gFLZtg6OFTQGD8IuCnaaA
         9vCqXtkKN8zxDuP3YUnOH/IirCeOBWOSSuzEJYQjdPwVteiD2oXTRNmf31Ms1MRsDsbO
         pwEKky3STDwqNejYe9Ekdleq0olgEwgiT64H3HYzDKohBA5+D3WLqXyI10apM5xgfSCN
         dqIJbSAIUXDrZlHXoyn4HNhc1C7EAdE5ebGd40B4eUUFdQGJvBKP6MH7PRkb3tlBBCsk
         1z+naBBFx5XkBTvULQnM+eN7n6ZTVt77I9umX+rftMIMfUoMJGTcHOp3PUSXYvcPNVSq
         6FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734527406; x=1735132206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duDRQNaydM9MnygAgym8Q8/9ko+la+IiXsEzlSyfpMg=;
        b=tiz9NShneEOT4Ve7Ix37gXQkGzLmSrsshNx83mzLSdhNtZOseqd9ulXIgp37UztdAO
         WlxBi22MbAO2udIHGQJ115wdJb7zU9oiIgt+2qpPjyMcKgaFeVRM5E2vRU+/WDuf3jEh
         BGaMuamrss3Ssn/WsPIQ2IpQG/tetF0IPLu97M0NuBk+hIwoXBy2CCFkfUIMzQR6wLLI
         h2rFtiSPXbf9nFtpOrndRLEubI655qY2XtES40svCMUrxrOIglo/J+FX1yv5NuTOHbza
         ouWZiBls2D56d+cvLgDVnVlCwBIN0OO4gBLuXlk8kontjHKxhDAm3EXRKx3VNwx27x7d
         JXQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKcK4i6whLUWhbbMlt6ZgkOP61TGgU2S6QnjhgcmgvreaPafF11PzpMs6WuU1a4ePLh9mHhsZnRNaslQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yw7Quk4mZ9lluz0VYS3EaqJhxUHHMgLEYEGIeT9PCPIrIWf+ilM
	15POcLBcSrMLInVrPK2m9UlITG+Zkd1KeJaMv7x9zrXKYKUXlo5I
X-Gm-Gg: ASbGncsSL4kBCjgQ7CX0W3jU+pRyrvxL4FCAydxf9nxoWzn+aW2JY0xJp7jzDl6xZQg
	xU04lmDmXJvL8N9IPSegiGMs085g+UWwlexvK6t6rOvhVF2NAvhWpj1V7dNVjLNwRfnK0rKl7Nt
	JkKTI30A8bs6JbMjQ0oHQzOa0PTHgo+1JDU7HR8DLQLfbl9Ucv1d+tO2pOMfETSe8jCxdPe5cED
	BKBrK9toZbnV71sj6JA2LJl8qGQFpIr1o9g3iehvuK6m0k=
X-Google-Smtp-Source: 
 AGHT+IHjAWByhkuRCvJpT02c4DgXI4s1gEBDobTpc14t8liBEMaFpl/IXfL3hYD82aWPv+sYgjfNgQ==
X-Received: by 2002:a05:6a21:c94:b0:1e1:a647:8a3f with SMTP id
 adf61e73a8af0-1e5b4824307mr5763308637.22.1734527405806;
        Wed, 18 Dec 2024 05:10:05 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c0f59asm7434754a12.67.2024.12.18.05.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 05:10:05 -0800 (PST)
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
Subject: [PATCH net-next v6 05/11] net: ip_tunnel: Use link netns in newlink()
 of rtnl_link_ops
Date: Wed, 18 Dec 2024 21:09:03 +0800
Message-ID: <20241218130909.2173-6-shaw.leon@gmail.com>
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
Message-ID-Hash: ZOA7K4KG4NDQ4DSRTVVB4VMU4LA77V7F
X-Message-ID-Hash: ZOA7K4KG4NDQ4DSRTVVB4VMU4LA77V7F
X-Mailman-Approved-At: Wed, 18 Dec 2024 14:11:51 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZOA7K4KG4NDQ4DSRTVVB4VMU4LA77V7F/>
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
argument. Don't overwrite ip_tunnel.net in ip_tunnel_init().

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 include/net/ip_tunnels.h |  5 +++--
 net/ipv4/ip_gre.c        |  8 +++++---
 net/ipv4/ip_tunnel.c     | 10 ++++++----
 net/ipv4/ip_vti.c        |  3 ++-
 net/ipv4/ipip.c          |  3 ++-
 5 files changed, 18 insertions(+), 11 deletions(-)

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
index ecad1d88dd26..bae80bb7839a 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1405,7 +1405,8 @@ static int ipgre_newlink(struct rtnl_newlink_params *params)
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int erspan_newlink(struct rtnl_newlink_params *params)
@@ -1424,7 +1425,8 @@ static int erspan_newlink(struct rtnl_newlink_params *params)
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1698,7 +1700,7 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 	struct ip_tunnel *t;
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
+		.src_net = net,
 		.tb = tb,
 	};
 
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 25505f9b724c..952d2241c9b1 100644
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
@@ -1326,7 +1326,9 @@ int ip_tunnel_init(struct net_device *dev)
 	}
 
 	tunnel->dev = dev;
-	tunnel->net = dev_net(dev);
+	if (!tunnel->net)
+		tunnel->net = dev_net(dev);
+
 	strscpy(tunnel->parms.name, dev->name);
 	iph->version		= 4;
 	iph->ihl		= 5;
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 12ccbf34fb6c..98752b4d28ad 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -584,7 +584,8 @@ static int vti_newlink(struct rtnl_newlink_params *params)
 	__u32 fwmark = 0;
 
 	vti_netlink_parms(data, &parms, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &parms, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb,
+				 &parms, fwmark);
 }
 
 static int vti_changelink(struct net_device *dev, struct nlattr *tb[],
diff --git a/net/ipv4/ipip.c b/net/ipv4/ipip.c
index 3a737ea3c2e5..c65c8b0e838f 100644
--- a/net/ipv4/ipip.c
+++ b/net/ipv4/ipip.c
@@ -456,7 +456,8 @@ static int ipip_newlink(struct rtnl_newlink_params *params)
 	}
 
 	ipip_netlink_parms(data, &p, &t->collect_md, &fwmark);
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipip_changelink(struct net_device *dev, struct nlattr *tb[],
-- 
2.47.1

