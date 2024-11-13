Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEC8D41C3E
	for <batman@archiver.kernel.org>; Wed, 13 Nov 2024 13:02:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9E46483FAF
	for <batman@archiver.kernel.org>; Wed, 13 Nov 2024 14:02:18 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731502938;
 b=lEH/EN4gPK5f9OfHDGBAO4GEe6zXvImsHb8D+H8UPwq3zWcSR1Se0zWrYy8JGaVxzLzPP
 pfY1pLWiJE86vUnYrh9yX5aJcRQS9yOGywY1m8r1hPJ8x1Eg+Hdff0WjwcWUY2oMO+cWxp7
 HFqLCP4R5MZvC2T+AjAp31iHFYagHpM=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731502938; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
 b=yGDrMLNnDFlRqUDI4hx2baXZlkqO+qkdv9HIsLcDvtQU2CLc3QYwgqtciHeYAsYUfygLj
 2AvimlNcOvnijdXvUS49fhBCw1o+1K6vPoCOARzJcSn7DNLJrt71Pn2c62aPmtfHdnVo0uW
 fLrSxA5uQcSwZoIWaidnvsIuBMaJqRM=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AC23481865
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 13 Nov 2024 13:57:54 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731502674; a=rsa-sha256;
	cv=none;
	b=Lve/f6+zfkmFSZPRAjPPRjg0nzR2Mc6jXsA1ysF1Rqmiovt6T2wWgDvqk33SHTXthTxtAP
	pHT1VpFulTSeV3vd/wHY/rcWGZZA7nhTj+cAw/suq1/wpnViXAL9VbAmq9u1oKXOS3jnwn
	uOIQy1lyfiyGQwyHYC+NtXJL9b0Ys2c=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=UVNIWq+5;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::1031 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731502674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
	b=ScjaBlYjwMgQRvBr35rMO5x+baoc3Fc2TeB52JnMhNXy93NkdaOhubr3suwUZPZo1xi48Y
	Csrd8A4wCTyPQOXqz1vJCkJNNua0v6W6zO/kVss6vCK6uipyMXSBgIkJ0ngO6fsBsBCaB5
	cWRqSrwEsOZrWdMmWkMPQN7fUGODSrg=
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e5a0177531so5402940a91.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 13 Nov 2024 04:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731502673; x=1732107473;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=UVNIWq+5PSVQbtaV5WPPbQgctyZzJdwpzbO6Hts6MrYR7m2+e3kSzEgGfogPbWTMB5
         30sUYJQ0etb7mABowPaQm9Qr+ix4yGwDQZq5nPmGRLKsD0J+1bILn8bM9jxX/ytdzFS+
         DSHddanTL+Z2p2aqBiZSHFk2i3uzMv8oFDRxc5RO18aPLnaOPbiPt0k9G8oiqAz7BPfR
         7/jRiPotDVnjws+Wgq84Muvw/BFL0gGKiTlhMzF+Tb4heNux50NGzqWA057zTbPQy+EK
         ACANRAZhExQKDxFRdBV8SId+8P44Sww1byMJKrKMa8XZ6WilaZaJWAtddwVGOeSizLZk
         nyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502673; x=1732107473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=tIOoB7lnD86p6Xu8j7sqJ40VVs23/utyLhntDArg1wSOpg5mXyUrWgCkpdI0ylngjS
         Kpa6+u5kFqLct5Yt3jeyyFH6hyz/rK8komFCg57WTF3BY98x72MkSZZWxyrtyWS8Xj9D
         rJFGO/72F8E0p0VqHGWFo40CW0eWHNXNAGfkK6zr5+AWKIqiHpU/3fJ+GWkRjGujcwC+
         nX8+mqNynJQtZOLHg2gxoPQqIP0C1TKZONbKDsmX0x0YceSd8V5InHA5FZw1LWAFe/YE
         8jlV/PsV0KCIAUuy3mK9tdt6SxJGWsPD4GfV9ToXbCCkMwQTdGWH1i28HvJRb/f+lxXy
         DxYg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKc3PaWTgoCY4FNRWIY7ZNkcH3mqskLNqjQhBF9KJtuNfx6rheqPmCP9bmufKXqYB9rVbIdBRiqXBKew==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwLm4KV6uLZho9O66gNLQIzUSpL8vN92tuMcIh4fipYBmcNjEDN
	eRjaHx1953+7YBpCKRrAqo3kVAYmAAudz0JZKAH7x9EApC1G6W2M
X-Google-Smtp-Source: 
 AGHT+IGJi6Tp37K+i8d+pRtqcGbSCXzQQJQiHEkYvBXRMyT+Ytmcy1PnetStqWOPaDWwW+msVvcvjQ==
X-Received: by 2002:a17:90b:38c4:b0:2e2:c6a6:84da with SMTP id
 98e67ed59e1d1-2e9b1799123mr24937176a91.34.1731502673070;
        Wed, 13 Nov 2024 04:57:53 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9f3f8ed0esm1398632a91.40.2024.11.13.04.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:57:52 -0800 (PST)
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
Subject: [PATCH net-next v3 2/6] net: ip_tunnel: Build flow in underlay net
 namespace
Date: Wed, 13 Nov 2024 20:57:11 +0800
Message-ID: <20241113125715.150201-3-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113125715.150201-1-shaw.leon@gmail.com>
References: <20241113125715.150201-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: 46PNTN253ZNETZ2J4X4L6G6QVPWZNVGB
X-Message-ID-Hash: 46PNTN253ZNETZ2J4X4L6G6QVPWZNVGB
X-Mailman-Approved-At: Wed, 13 Nov 2024 14:00:42 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/46PNTN253ZNETZ2J4X4L6G6QVPWZNVGB/>
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
2.47.0

