Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E1DC02198
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 13:40:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id DA9088423C
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 14:39:58 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739194798;
 b=N5nF/Lhj9Dy9GBsjkbhUaji/eLJoCCoWzmsyf90PtYRXqh8KIWq2xLrrHg97WMU7zIajv
 g8d1L3iWeomxdOJxk+7oFqTmzyDa+iA8JWjZ/OqbR0l0/uv+JIKQYLMp1r1rkaBdrluZi9n
 EHTq+HISZ2M+iqCTRKxa7Rts1i9FEBk=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739194798; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=pJKz1g6voDImT0UUTo/s+cF5fKbKW++euQC6BW/L/6A=;
 b=L2ouowNtoHCaNfVV8KfKQRmqQRONpHI4Fuhx0RFP65FrF55EidBwsuLUk+PNSNY2CPRU8
 YraK5DXSD6ARzGFHTBFDV4KQbjUGcR6ILTCuxomxQiss9NNgdA+o59LKK2lOo2/TBc0ocUk
 7Sn7Oe1kz7ZJJjS8qw7XI6CGAOP9Tqo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AA31583E3E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 10 Feb 2025 14:31:04 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739194264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=pJKz1g6voDImT0UUTo/s+cF5fKbKW++euQC6BW/L/6A=;
	b=pWu6ADYeG5SVTQgKBivsOyNsOUck383uDhTpCxrlrlPp6rWG2lsCjbYx9yaTUs+KdQQzp1
	ey1Kos92BoOkodLITU8lNj5NNzlc/qqaR144Nmi6kdFShoiSgvlBENiHsHFh/4h+uZXWDW
	93zMJ7K8ysDwCrpjbQJEi0JU2Ywgxr8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=Kcx6iR2P;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::634 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739194264; a=rsa-sha256;
	cv=none;
	b=FSaPqlVS1wof6S0rJC9ty/aNvnlCpw97Z0Gvr8ZGkZ4/xQZA3Fj6Hcf+nzBCbhvaRgVDWr
	+tSlNChq/n/zL+KPa2j5pvt8JFwXxa6VL/qwvVqGEhW4gl/f1Op3w6xMw0XXJQheGPN9Ch
	/sg/Ao185mR5V1pGBq7hfzT5hZn1vUA=
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21f7f03d856so26114095ad.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 10 Feb 2025 05:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194263; x=1739799063;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJKz1g6voDImT0UUTo/s+cF5fKbKW++euQC6BW/L/6A=;
        b=Kcx6iR2PGHPsp9A+mJPJpsx17E1L9nAPlYJQ41+uRX21CJ5rKMNpecE6RA1OOrjcGK
         xOg/2BcXY+bO6e99i9CBjxOTPNYG5BnnJ+IwcTGfE4oxpAjS42wBnkCe0RgZEy5aPMgt
         VuA5YoEyCm+o/okKxOLB2vLBXwHptuQiqcJ34+iGyldrtmxRJCPkwSzYagA0fARHxRT1
         o8h33nY6IFn9K/uFAs2r6mc/NPwnWujDru/1OzOBideknsEfjad+52Is53bHQ3b3KUSw
         A+CRo/fVPQw1ZQUck3O0yZSCzLi2fHDPoSpw7LOZiFs6BXZV3aZMJY0PTWQb0LmYi4rd
         Ca/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194263; x=1739799063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJKz1g6voDImT0UUTo/s+cF5fKbKW++euQC6BW/L/6A=;
        b=RgbeofHsckpbHlgaI8bTqwBxKQWZocuX5KBhrgmytWiUn5wKiUHB/uwznLlVjrF3WJ
         /pL2tgSRreaJDNbN9O7UFpy5h3VkGk7RjAyabL1LWpf/8msBQEZ4g1kMTkcbwRX5QPkt
         tf6g+j7HGski2NQ6fl/CpQ2lZGuF3Fc5E7xRI2WlSLpMO+N+PZR9zh1adlBheSkphkZw
         p5Hs9HCfLAzuDbnsJ9lRsWnRM+IJiqVtXSITSS4YD9T7IpMLMCtWR2ux8zqRpG1R9Yxr
         nX1ys7y3fH+VgZ+gsGJFFvUzp6amj3pOfhjM/exS9cpZLAlh3OLS5t3PHU643ssxF6m4
         GBiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDRj2AiBNvNgTudFQhpaKjMplz4xXdh6yZ2uvh2zXLJHL53NyAX6WkxBxr17TqE612UlDGJfUEKYO4Ug==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yz1dzbspLrAsR1Vyyha2G7cYmtG3JgulHXwbdhi7uZ4da8574Uk
	2OC2HwtdvXx6Cg0Ntb3FNW3bJSPipiTFHg45rS7W4smBHb+kmSJ7
X-Gm-Gg: ASbGncuYACxUl6KdGAcPRNI457i6962MgrRN1dklvxcL0/QBjo0ZhG8+7shC8ameVRw
	j28KRcWcM6JAsF0NLMOJP/6ibM0X2n428NoQ7Dd8zl+V3JPTi/uFBPszEfPAvBLbtC/DDi335ub
	cbv5S4CbKLM6I7CVBT8IatH9sBgi9VPJVm/esuX8QSOQyNVtMgRTdDeNYkwze2zkqzSaeVGr0nW
	usVVe1jvHdstp8Zurjmx1SH0bCFDv/E0B+07F4JBi2AzxGqrrwXq77rfpw0esyDLXueF8u+ONx7
	eh1ZxA==
X-Google-Smtp-Source: 
 AGHT+IGNFjsW8yGSZG6C2tbCv5/JZ09OmB3LKkjVhY7agbUhlCe28tcl+Qcya8rlcfYhnDrE2/S9OQ==
X-Received: by 2002:a17:902:e946:b0:216:7cde:51a with SMTP id
 d9443c01a7336-21f4e72631dmr249984615ad.28.1739194263028;
        Mon, 10 Feb 2025 05:31:03 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:02 -0800 (PST)
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
Subject: [PATCH net-next v9 05/11] net: ip_tunnel: Use link netns in newlink()
 of rtnl_link_ops
Date: Mon, 10 Feb 2025 21:29:56 +0800
Message-ID: <20250210133002.883422-6-shaw.leon@gmail.com>
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
Message-ID-Hash: HR45NO5XGWW26KFIML2X4KDNS6PDYVXV
X-Message-ID-Hash: HR45NO5XGWW26KFIML2X4KDNS6PDYVXV
X-Mailman-Approved-At: Mon, 10 Feb 2025 14:36:12 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HR45NO5XGWW26KFIML2X4KDNS6PDYVXV/>
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
2.48.1

