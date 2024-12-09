Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C053E7717D
	for <batman@archiver.kernel.org>; Mon,  9 Dec 2024 16:48:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7B44F83FB1
	for <batman@archiver.kernel.org>; Mon,  9 Dec 2024 17:48:45 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1733762925;
 b=mezACcZ8jl2Kz2G1PsZxx5mfWyH2HIE+dpkbiGOm7u713mIpGSQi9IOCAc9cIlSJbcVUw
 8TzIwzwfUjuPshgy8PPgVNTH+qkkSSdLozHzygLU8pI7CRcDJJ6HEl6rzjVfIv3buU7R/kE
 hee9XwRCdMmq0/1eD1RjtqnvODrG+cE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1733762925; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=93uG6ogDA0suRI92nCq7Qt11rTzcUQ+bpSh6BVGj6ZI=;
 b=sC+/mVfHo1SZXppN9RO63PaApq7F8GsQpHR9koJPhN4vV8nU/WwK6ncWncEtu8Oe9cnr7
 bWReTes/9d0S7UhjxbIb022q+rXoAF3vyEmYeNOGupSXYXkowLBIENvUh5UiBosUe1Qikx+
 5Ae648ViIRay6UZHmhpqUbX91We35pM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 0559B82F27
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon,  9 Dec 2024 15:02:38 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1733752959;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=93uG6ogDA0suRI92nCq7Qt11rTzcUQ+bpSh6BVGj6ZI=;
	b=eVY7i8cyft3SPFjI4xfUUg274SeMvPrIruq4Do4OEUuWrBLiwzNuWLda3beN6lusLoisX+
	wOGJ9jWi6LNreL+6tAXk53N2TZNYeWMrt8obxiL4DPMXCdMjP26OdHLXpPeyH+Y8Iz2aTc
	rXm22QeLBFVisdfMYkZ4XyTySuPvYnM=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1733752959; a=rsa-sha256;
	cv=none;
	b=SBRmsCsCmyV2+bfbkbn4Z6WEe3E+1QF6NQi3zSJm8P0R0ABe7TGh0WClO8HiZbOr0LD0zy
	oYY71W8cr43OvN0xdbul4ieqMXpZuk8EQot9xzGDkaO3hKw34o4D5ofJMm719ARADe/Xsu
	/hAtRLyj886xhD/ohKDkO6o14O6Byhk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=JR7I++ZT;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::629 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2163bd70069so13581815ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 09 Dec 2024 06:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733752957; x=1734357757;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93uG6ogDA0suRI92nCq7Qt11rTzcUQ+bpSh6BVGj6ZI=;
        b=JR7I++ZTNh2rYVaN3sTPkRFVD2vCtCOK2UgjYrXdu+dS6cxPv1EwJJoEO48DUw+MqC
         WsYHMC8F0CkiT1DVw9mbgrWARib6wQ/YY2EPEhR9PTa4TWYgMea6edL48m8N5/c397/H
         t//u3faNGFQxG8/CYfndAeT253peTSwmKcm/97JVpSxlxeTWLUJAk1aeYhiIwExC7vrt
         XtLuY2XmCE4HiIHEd7l7/OrCddu8kHNa+Luq7LvtKJSeQfkvAmvt9FeWkvbZjraNbfSI
         cVxLVq+jLkobcKz0mp6lCzoap/DNk5XuF1F3xshe1y35xcMCFK2rSwUNa5w6Zl1eAQhN
         uASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733752957; x=1734357757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93uG6ogDA0suRI92nCq7Qt11rTzcUQ+bpSh6BVGj6ZI=;
        b=KM76j0WGwwJQ7V8bQzRq8y5U/mbpqQlRUApzD/oNPpBd1C+zEMaAP81ioa/zXIM5fV
         UfQ7qRc7CSslhoR/Z9t/8mjexYtMAWH7pP78hw9fegsf4IH6V8EuhHDI58XXVWIQKjbE
         FEcopAeCVaJ8ExyA+zmQBDkEDCkqbLtOcxIW/fA1bUkuPXF4+R9IDCMpYQIDDXLzAa65
         PPppyUYs98HqJY2SyiaGz+6naQGc777pAovkfUlmSCVXbE4pmQoxSgsRxSOD0jgTy+a6
         K7Bf1wny6Qlhx36JantJldtVjJcGj7Tl9G+LxwbYaJ0TX2Ggo6P8uFTrdUBD5o+L2J5R
         jjPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh+qCUEO32ye7a4qvAaWmjAy/D9MqJ2ZLtDDXOwEBneEquoKe4kl19n1IezTc9qySZA6CHCHaiyDKUPg==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwW3cEriYsCzTVkzjBdAvdhU2nWnq4perE3luqxiOxNc0eYyt1x
	qt5Zh4UBzob7WdvETKdzz1P3fO4AvaqWZlT2AXDGcDxTQWXaE8sX
X-Gm-Gg: ASbGncsvNzs/yaqc5UccwrK25aU1LcEXd4Aritb8bnIgzRGSiz2ribdZPgBW+bVh7Ps
	MC1rJfF/1Ce7niB3zrHRKeeTsd2LIBuyvNmsvwXo/3DuA3A4XS6gbKdOJmI7w3WauW0GboW2tRB
	qfqtYuSgQ16qF1rfP8ZRxjDYmCcK0saZvkTWB7jW55LWrxu1ICsFX27b8up30aa1XfLRhFsYfve
	/3bNuDScoMrLkkI9jJXc9h0U06EWrsWzYAZ2iO+MD6FLjU=
X-Google-Smtp-Source: 
 AGHT+IEJ2QVBGY2MGcE4mBFIU/c+dzWKa28cbDvoqfUFybFT/JmX0nfLyJJqRhwpUbbXsTp1UoSovg==
X-Received: by 2002:a17:902:cf08:b0:205:6a9b:7e3e with SMTP id
 d9443c01a7336-2166a0b59acmr8694095ad.56.1733752957447;
        Mon, 09 Dec 2024 06:02:37 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-216221db645sm49605645ad.46.2024.12.09.06.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 06:02:36 -0800 (PST)
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
Subject: [PATCH net-next v5 1/5] net: ip_tunnel: Build flow in underlay net
 namespace
Date: Mon,  9 Dec 2024 22:01:47 +0800
Message-ID: <20241209140151.231257-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209140151.231257-1-shaw.leon@gmail.com>
References: <20241209140151.231257-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 77L5J4PDMXETNFWNOPIVSO35I3TPDNAH
X-Message-ID-Hash: 77L5J4PDMXETNFWNOPIVSO35I3TPDNAH
X-Mailman-Approved-At: Mon, 09 Dec 2024 17:47:40 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/77L5J4PDMXETNFWNOPIVSO35I3TPDNAH/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Build IPv4 flow in underlay net namespace, where encapsulated packets
are routed.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ipv4/ip_tunnel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
index 25505f9b724c..09b73acf037a 100644
--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -294,7 +294,7 @@ static int ip_tunnel_bind_dev(struct net_device *dev)
 
 		ip_tunnel_init_flow(&fl4, iph->protocol, iph->daddr,
 				    iph->saddr, tunnel->parms.o_key,
-				    iph->tos & INET_DSCP_MASK, dev_net(dev),
+				    iph->tos & INET_DSCP_MASK, tunnel->net,
 				    tunnel->parms.link, tunnel->fwmark, 0, 0);
 		rt = ip_route_output_key(tunnel->net, &fl4);
 
@@ -611,7 +611,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 	}
 	ip_tunnel_init_flow(&fl4, proto, key->u.ipv4.dst, key->u.ipv4.src,
 			    tunnel_id_to_key32(key->tun_id),
-			    tos & INET_DSCP_MASK, dev_net(dev), 0, skb->mark,
+			    tos & INET_DSCP_MASK, tunnel->net, 0, skb->mark,
 			    skb_get_hash(skb), key->flow_flags);
 
 	if (!tunnel_hlen)
@@ -774,7 +774,7 @@ void ip_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
 
 	ip_tunnel_init_flow(&fl4, protocol, dst, tnl_params->saddr,
 			    tunnel->parms.o_key, tos & INET_DSCP_MASK,
-			    dev_net(dev), READ_ONCE(tunnel->parms.link),
+			    tunnel->net, READ_ONCE(tunnel->parms.link),
 			    tunnel->fwmark, skb_get_hash(skb), 0);
 
 	if (ip_tunnel_encap(skb, &tunnel->encap, &protocol, &fl4) < 0)
-- 
2.47.1

