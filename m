Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE67DD49228
	for <batman-adv@archiver.kernel.org>; Mon, 18 Nov 2024 14:47:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 30F9A83FF6
	for <batman-adv@archiver.kernel.org>; Mon, 18 Nov 2024 15:46:59 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1731941219;
 b=S4dt9YXiV0Qa7C91tu7CbZGbzD3NgSeG2wLTOReET1D/Uy702/cKgqvvzK696Dytixsy2
 Vp5of7sL3mQXvlrsbySSfjfrjur0kRDF86oEvslT7g394bpXoX+HyEbD9IeFz73Q9lK6tQa
 6YTXa4iycoOdSE7T8pXCtp1whiOQ/Ks=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1731941219; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
 b=ocrgKNbW1E8mFSPUJ23iPXk2xw/Sjt62VIwAVphe5hwLAvRpf4/uBhdK6pD1ji+bStb/T
 R60FbnQc2kM0cCr2U/Pu/hidxG/qADVYk5SPF/TKUD0CnCADweoEJg2nkuketo5y43bALLB
 ZultFLx5KKsoSmNSh9fSTb3cCvB1sCo=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id A166982F7A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 18 Nov 2024 15:33:23 +0100 (CET)
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1731940404; a=rsa-sha256;
	cv=none;
	b=MRvVhg6BJP1vgAJOYFktqnsVaI2T43ySqsbZBDBuZ1Ic3EktMJcjjQkYQvZyDiTHresp9/
	LrYP/SdYEAcncwQpYBp2roTp/0FCgD6BS0/m/2RoIJk30VMaJpwqsA+HJNZTlxqRLo/zRt
	GuizPjqA5/NyW/uU6eXp42dpnm6iW+U=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=QhehbPq0;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::533 as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1731940404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
	b=4Ic3Q7YaySdwQMt6IJIRDp0k3gUCRTekxe93kKNxqS2EliiqXE4dgyLy09FrehaEybtQu8
	qqwIK19fwdSbQ+6cXety8LDGTRiEDIgp7BzgtwBAtqxt87vzfJN65QoWS4nqQvSnD/JQVp
	SBKnggK6hl6D1wkeTCoVcbuoVzwpo6Y=
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7f8b01bd40dso2885165a12.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 18 Nov 2024 06:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731940402; x=1732545202;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=QhehbPq0Y675kTpqr58lkNRPcLry8wahnNru1q+Hm/SrrI1gJh6DYQFkd0/8dvcEJT
         nZvWBds+9mSKMquRB47+7dJo3f+54Xv/OFQguF6sIFn0jQq0NYduLQLACKmQpvj7ufi+
         VRfYcU/yVyWFnNsOKjR09CFUX6weXp3JhWa8OeZ+5CF/4eT8GjOR3krjWJu5FwKgpYo+
         iVOlRLqoPHrbYNKIBvwJPXgpVja2e5BXb66M4+2BjSYC5Se+piGcN3kONPwhSA/YpSIH
         J41MYqR8LMbL65H2M4YpbnrpAXvMk81HaoHp02YzBiBJtMV1vo7XsPef49xZF5sNeqBX
         Ft2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731940402; x=1732545202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrCaarQptqoPnVIGF6Rw6t9hI+Rf9ZxQVNSlbFD1HYQ=;
        b=lgooO8bEgKttEz7faNOy7AjSecxwSOYOT/COO7+mQvA9idfu/yGmy29RgHYC/YHKVy
         5Yt7P7QWf+FaJ6TqJDnjAfk3uwgFzMitGFppElf0JDNTLBH5vEmFZusopcM0PWTbwgBZ
         CkbpWZjahExbAKJnWIgExyAhI7bscDZp1WREpk9XpEsSEkv9q8cmzAn0SLZ1hgQW5Cg8
         4VKmfIgdc1Wa55OYZlKS+JOWUu9H8ho0zCn7dViz/BvllYFU8KSdGFBGtiACBXIKM3IC
         ANvudPSM0G3KPo5OL164VwMrAUBIvpDdAO/a5ksdVJcxS/RfWiN4LFoNkVJiMkK0bX6B
         9gBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3x9NFd4kU8GXqwqEM5/rQ1A3bY4F0gt7mtLd1pvMl/yD26Kypg8VVwYHe3UO9BNCmGXmGujEYEK3Duw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxT8b9EmODTF0CvfarbZKJhuOHsorfzeqnum7F5ubUyrZDUYqb9
	pVoF/w/+xbRV1O33k6Je14KBtbxTupdR2auoWsgF4meEwD5G9t8j
X-Google-Smtp-Source: 
 AGHT+IGzbRz7s9CT801paPWPDasO606/jlaO2UpnfJMF7tMlUetZpF6RTCqXaMFrG8I7wghYj9+EFA==
X-Received: by 2002:a17:90b:3c4e:b0:2ea:9ccb:d206 with SMTP id
 98e67ed59e1d1-2ea9ccbd33amr1559048a91.8.1731940401993;
        Mon, 18 Nov 2024 06:33:21 -0800 (PST)
Received: from nova-ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea81b0e2fasm1616926a91.52.2024.11.18.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2024 06:33:21 -0800 (PST)
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
Subject: [PATCH net-next v4 1/5] net: ip_tunnel: Build flow in underlay net
 namespace
Date: Mon, 18 Nov 2024 22:32:40 +0800
Message-ID: <20241118143244.1773-2-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241118143244.1773-1-shaw.leon@gmail.com>
References: <20241118143244.1773-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: XHCCGLE75WPPYPUALZCOMJSVFQYTWRQC
X-Message-ID-Hash: XHCCGLE75WPPYPUALZCOMJSVFQYTWRQC
X-Mailman-Approved-At: Mon, 18 Nov 2024 15:46:12 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/XHCCGLE75WPPYPUALZCOMJSVFQYTWRQC/>
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

