Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07861E77188
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 13:21:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 88D4B840DB
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 14:21:06 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735996866;
 b=SB+Td4wdURVkyIbOWobvnAhDopFFim6wq1DOSQ9koVxgi1dd1Ua6xKaTlS2hQCq9DkG25
 7Pe/g3aOUGAMYCg/5xxBgjcGLoL3CwYOvEv0EDBPPkATf+wYkiUawh8kPhnLGYZjgu174VX
 asQ+x+DMkYXXWUEAiw0z+yuae8d7IqA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735996866; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=RCmZExhyz7cb3bxHLdfAhcPoFeVCTtasFkXOWH4Z1YU=;
 b=d+r1HsLdMI+UMz0zvzz+yree6bGuFG0NOS/P/Ht7aTdkG/CqVlkac6aSqN07DkiP/ci0E
 VaJDveggVZDLd8NyjWb3QYAYyfgCUCfwUcDelxBmfEAftxufeptm9N/ypd/T+IpkyAhxDMj
 /W6qbW98TfF7d0L3kAxVjsf0oTFEhlE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id D58FA83256
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 13:58:28 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735995508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RCmZExhyz7cb3bxHLdfAhcPoFeVCTtasFkXOWH4Z1YU=;
	b=3uWdQnMLXbCOMT1G5ZmItHkNSxxcVedJ4CNok7Djczf/IYH5Nrc9T5+he7zl4/zxAiJhZ6
	/0y7BXQ2yA7voRfB+ywcHkW7GUrFD3UeqThE5SuD/eJodaQf50Zk1ABjTpZqxtWNxiem1h
	S96uSjx/gWOQcsIAGNFcVkICufxJ2mk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=AwjqPE4D;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::632 as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735995508; a=rsa-sha256;
	cv=none;
	b=bryxm5/Bu6jOleO3NZS4owjn7f0URF9jn7GEaLgcxmXojJY7FAfsLF4hXXg1JMjdZF7OSI
	ISg1WpKpkUE3IPoGxonjDzEQe0n4GA/F4I2nDlsyOCDYcDteRiQj0JwAa8DjV0XHp3IqxX
	PmOx76p+cWrH7y+mcCLdCP68Ff7CdSw=
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21683192bf9so182162065ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 04 Jan 2025 04:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995507; x=1736600307;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCmZExhyz7cb3bxHLdfAhcPoFeVCTtasFkXOWH4Z1YU=;
        b=AwjqPE4DZTMuvW4xLVl63StJD12LzoIvSxBdd3DqSrAf52ZsgivuqINPwWPWrq5UDa
         2X5XA+K4RN3ud/XoFCn4CKYn0dFnWKBj6PVKfx+xETj6IGTZcxjLD9HnpfGuaTjzRSdH
         egnegu2ae9urGJATRaqAcjvqo8uuPCMu8EEvvzItA+czZS5c5D4z61E4UH+5jFDXi9rm
         1IXvjkQwSR5lEZ19uLXSqWdz56sJYahplX5g8b81J7yD+8nZNyyr32N3EAZj4UBGS0JL
         tBocRvS6sId5uwSaWCw+HMFnBeyUIVqe9UYyIy8I6gFnioQ7AFGQY9I0mkOjcfGg5yao
         W9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995507; x=1736600307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCmZExhyz7cb3bxHLdfAhcPoFeVCTtasFkXOWH4Z1YU=;
        b=reoQhIG7mdlAyW2ABOqS/LQBGOxjMSu/KD6ZZb5z/9KspjSe8AMaaIIZUNaVhJmihc
         ysatGXQW8imqtiAtbfMIRnHJinowylZ29rLSZfh4LzZIQ4aydEKKcy+izj0Ey3mlT2+P
         fo1fNEFhVKP3EdjoSSMR06mkzpLg03MNsB9Dlu6BzUWDTmOil/r8P1miT0tDHaMVvWH7
         9kByVcLLzL3qsj1K1tI+GqLGto16iwbp9LlaZgGvp3PD3jq2auyDlfskNwGBZf8DhjG0
         9hpM5NseDrYLkSNxWffc9mR9dAIQKN0pvEwubVK5edUydKgkDL5iT71Z0PDMNiihjGD3
         QKSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeWHkQQRWgpJq6wTg1RnoY2TOBlSUhr1u4ozfPvIcPFpemZkucWkT1WHQBaHjYBjn5Q3snnFNKzK9bvg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzLbc6XawnX9G+LubeeCT+vr9UklFQo8Uhm2QYbPyiBw7B8M8xS
	/1ivo5I9SHI91wfPntmxrwWF5SrvYwFZ2f9E4qqTrRXTdHDe8Cl0
X-Gm-Gg: ASbGncvZR3NiuDOy+EU8oeFPB85slP+P7HaFpaSnlHW+9e3oDpneTyWyHNypbkMIzgu
	kJUs2ZWvjkA3wcKZIWH5Ccrv2axPodMAqmh7AHlc3dHKZSXg7iUHy1NVkxzTJ6Dk2V1tH35Rz8l
	0wJGZFpeVIFjxiGn5p+qE2N6ZlnqwGGQJotAKO48crOhy76Db9GbbcKnKWlkvY7a3486FnuXQYW
	wg5oALlbIrxdC8A5WoVBr90t7lSqTJXn+Yb6QSjVIDej7s=
X-Google-Smtp-Source: 
 AGHT+IHhlUZ4hpFQ3a9b6BPvAGinyOtYhhp3nBXZboTqrJ2Is+5BNZ37AA3tsOk4lmwOGToWJ2idfA==
X-Received: by 2002:a05:6a21:3189:b0:1e0:d632:b9e0 with SMTP id
 adf61e73a8af0-1e5e046fab8mr87168448637.13.1735995506986;
        Sat, 04 Jan 2025 04:58:26 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:26 -0800 (PST)
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
Subject: [PATCH net-next v7 05/11] net: ip_tunnel: Use link netns in newlink()
 of rtnl_link_ops
Date: Sat,  4 Jan 2025 20:57:26 +0800
Message-ID: <20250104125732.17335-6-shaw.leon@gmail.com>
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
Message-ID-Hash: JN3WNGGFKOH76GTFLZ22VUGKWNNCGSIZ
X-Message-ID-Hash: JN3WNGGFKOH76GTFLZ22VUGKWNNCGSIZ
X-Mailman-Approved-At: Sat, 04 Jan 2025 14:17:48 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/JN3WNGGFKOH76GTFLZ22VUGKWNNCGSIZ/>
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
index 71eb651e2b44..d1b712b775b6 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1408,7 +1408,8 @@ static int ipgre_newlink(struct rtnl_newlink_params *params)
 	err = ipgre_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err < 0)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int erspan_newlink(struct rtnl_newlink_params *params)
@@ -1427,7 +1428,8 @@ static int erspan_newlink(struct rtnl_newlink_params *params)
 	err = erspan_netlink_parms(dev, data, tb, &p, &fwmark);
 	if (err)
 		return err;
-	return ip_tunnel_newlink(dev, tb, &p, fwmark);
+	return ip_tunnel_newlink(params->link_net ? : dev_net(dev), dev, tb, &p,
+				 fwmark);
 }
 
 static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
@@ -1701,7 +1703,7 @@ struct net_device *gretap_fb_dev_create(struct net *net, const char *name,
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

