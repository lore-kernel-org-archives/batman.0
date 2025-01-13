Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16351C02184
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 15:25:56 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 779B683704
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 16:25:54 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736781954;
 b=Ger+Ojj028LgrY7oGjHhrJ46LZNPbwPYJ4DS0h9kgdGla9PqG8JdnfUWyGiPK7xXj5ZW8
 ksyl8XxGgqyU0Ceff/OClZlXJEGeV9SGhXbu2ysSERw8I7TJqSvqi6CUsIymp9wuCt3ltyv
 qS0GsCn0lPX2dasVmljhomc/fVC+yf4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736781954; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=v2hr3iCsVwpwP1Nzlez7XTECQN7gMZZquvojvDybmoY=;
 b=PuyBVPQ3X+hS8sjHRj1M9et/czRcco1rpmPZbHHxq0J/EZRsztLSZylLooSiOWj3A6hOM
 FriXsWjWuCcfEiqTrsTTEGJTF6QfUjSPdm47ADOQhNlnSl6t+k9lnkfx6X26eS4iG3WV5vd
 B00HL6yzRB7LmtOqa4l02W08V/oxB7A=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 49CFD81C02
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 15:38:23 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736779103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=v2hr3iCsVwpwP1Nzlez7XTECQN7gMZZquvojvDybmoY=;
	b=QJVtjwFZAh8QVr0/PDaIy40zMPlwbtcu3vd4cAWmVw1oTs328BjqAGRg80dGinqFI7VOJM
	gL9GfsrWR1T9EJ75emMBwMPMY6BfRqEUMQWNOO2S4k8WvXfMkG1rKEckhAu+E7UGXvzQV8
	A8DOzbIU6eFk4J/C6euANR5Yzl/3CHo=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=PWsOSHVk;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::632 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736779103; a=rsa-sha256;
	cv=none;
	b=cX3R36qDfEn9RsvbqB6Z+7P61gTgtuevfSadbhe07qW9Hgn36KWW7ocZca4TJ/C5ZwPUb5
	PshuLEb2yGUJubRu03q/wT3yKlcnEbW8+C4SDm33nbvbae42pDNbM0T70R22ySxEt4UweG
	g2t6I/fvUpTgtcipXM9NBxpfcnCULAk=
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21619108a6bso75041665ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 13 Jan 2025 06:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779102; x=1737383902;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2hr3iCsVwpwP1Nzlez7XTECQN7gMZZquvojvDybmoY=;
        b=PWsOSHVkjQS1V8m5Bo7JMjegOYvzCn1/EpAaDZgJsPUTIU5vioSbdWCXw1BcIrWzPG
         TJCJNtJjBS5xRcpmK44GHdgrTAzQ08AMwPk7T7bf7q+C9CdxJbIYSirGUcmIpIO82A4n
         NqqP7UqSV6L8JjRvjjVeR4KKbvdu0ZYt6jue0wb10YPUw06IsCEcfuaLTmowA3Pfb7SK
         JWOkSSpbVX2uSF/yoVGiSl/WsBUx55hGgvXbsRbmTb8CSjY/ZgmMQDEQXVXUcylIcNpf
         An3MKbjm1VL5Wxje1DSM+TQ96KqYm0MEOzEKMNZFRaY4s1KwhKGfWUNbPLyZFwznrg/R
         s3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779102; x=1737383902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v2hr3iCsVwpwP1Nzlez7XTECQN7gMZZquvojvDybmoY=;
        b=BQvGlN9z5Xm9x5mdoXJfTdzC5awJUGeCLCsvnl4PUtR/IsqCoVVwO/c6dkfFZC2DYU
         j15b0iFoh7i3Lt1eNt62mc+k6X4JBauZpNQELDzTgXPgTghmRigd8P92le5LfuJUc4Qp
         nsRd4CzbKok/MKOBGb5RQlj1EfJj4ICrMbZ1D0fRSfXdfWaOaP6iouchk+qkmnZ22yxU
         UQwR8PIpI9wJ1stdw+e7IwO0zfg1n+6KE/PZH2elEb1V2YoPAeyKSH1j3/HfWTd0h2+Q
         LXYkjDRFg+JGJu0/LBN8IatDvihBjDej8K/2wVp4Mw6BnZ7iBlZ0W8SovQvK2hkPtJAq
         aB3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1iV46m1WYiPsjTRsnCZ8L9hycySKAoKb5FFioxT98mIkSaRMex2KhfiZfhO1nXss1WibB2h/NSm0dDg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzvYMzUCSA1Hv6sSFbCjC55MNC5VEyLCS6apYUxKcxjKbATot46
	gmnU+od4r2ehD04VwGrTW5GbtlA6hjY5ukImowtF4KMhN2C/CjCh
X-Gm-Gg: ASbGncsLq62P2WxOGxhCrfZFRiDwPNzJGAQC+4hqfk9WvCBQNIg5TeXgLO4rW11wR/L
	dTVXy5DsGIXBoteg/Xc4n8KHRJTAp9mjwGNUppG6eDEyrE/EpPohAEMb+siM9HsrBWFjdBwEpCs
	No5yC7Cg4eU1GMPGEDpU/goB3CyCmCn/ayd6jUnaaHxUC6QZUpVNRdYVV7RTjqqq44kyPq4kg/L
	HGhPF8ZvO0czZAfVAlerdZsK50Edfmb5NQx/YbrfexUbVo=
X-Google-Smtp-Source: 
 AGHT+IGv14RrhPbpKFC9/J2BufZTu7MOaWM0c1rsX2Y4WR5iS1cGRY2j7eRCHAjKSVADaNJCQQybTw==
X-Received: by 2002:a17:902:f685:b0:215:b473:1dc9 with SMTP id
 d9443c01a7336-21a83fdf10fmr312977815ad.46.1736779101666;
        Mon, 13 Jan 2025 06:38:21 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:21 -0800 (PST)
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
Subject: [PATCH net-next v8 05/11] net: ip_tunnel: Use link netns in newlink()
 of rtnl_link_ops
Date: Mon, 13 Jan 2025 22:37:13 +0800
Message-ID: <20250113143719.7948-6-shaw.leon@gmail.com>
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
Message-ID-Hash: 56RY54WT2N4BB5DVZ4V7DDL672MNCVA4
X-Message-ID-Hash: 56RY54WT2N4BB5DVZ4V7DDL672MNCVA4
X-Mailman-Approved-At: Mon, 13 Jan 2025 16:21:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/56RY54WT2N4BB5DVZ4V7DDL672MNCVA4/>
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
index 4e8c310769ad..51113e981229 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1409,7 +1409,8 @@ static int ipgre_newlink(struct net_device *dev,
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int erspan_newlink(struct net_device *dev,
@@ -1429,7 +1430,8 @@ static int erspan_newlink(struct net_device *dev,
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1703,7 +1705,7 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
 	struct ip_tunnel *t;
 	int err;
 	struct rtnl_newlink_params params = {
-		.net = net,
+		.src_net = net,
 		.tb = tb,
 	};
 
diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 09b73acf037a..618a50d5c0c2 100644
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
2.47.1

