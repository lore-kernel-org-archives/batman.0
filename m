Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29204C02183
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 15:27:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id A058B842B1
	for <batman-adv@archiver.kernel.org>; Mon, 13 Jan 2025 16:27:34 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1736782054;
 b=G+/C526R4Mja4RztzJHj1TBqpd/sAz+XWAvwrleTStNk9VlYNga9uibde+3rUqfR+Mz1S
 6CfNZm2G20dszkjfaEHcYcBly7J7flA+CcCDzPkzykwt+RDL/1/ACt+O7E7kw8w84n0y3hi
 D/+1X0DZtcl3U81GY/G85lIGW49PeW4=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1736782054; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=n79rk6b+8xqMmWjuAyko0er+FR6QjAQIxOU32J9enis=;
 b=lDmqhjUOnb1yYEj8HIrKbonA92dHNzi0c+qXHvtDio3iLgOj9x+LVQVYp2unzEPvGh4BI
 UgzVmOovvSVlbTfTFsHV6gzZRBmmw3gx4lC57mBFDZ87MoL7d6XuIJQEdm9jcUtogLKjIaH
 dAxPexXvZ4r2Tr3Bm/Rs4xS5PjuOlmc=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 381D181D91
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 13 Jan 2025 15:38:40 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1736779120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=n79rk6b+8xqMmWjuAyko0er+FR6QjAQIxOU32J9enis=;
	b=SEgIs38tPiZSlyk4NqoTVvRlRzaC0Fer329XEbZMsG7bWen/vQMUYrIE2y8HZNTRK+/SP9
	ufT1aOmYKV0tria/omURrIpC53SGWbIFqNuWEWCxCs69IEMop23C07dgaR9SyspkeDh2Va
	2/6WTsjRy3uPk66DWhwf++qqSTrTxD8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=M5E6GGdt;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::630 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1736779120; a=rsa-sha256;
	cv=none;
	b=HDxTfH/QbP0NzmdKe4uMLiQsgFpforIXmcMsQekEBT/oReEkYmnjZaG8pqn8cwL47eck9l
	gPbPFHzawzxTiYtbaZDhPRba3/RoBxYuBZycCBFF58WU1No4DZj2SBdRad2DarDo4r5WNZ
	+sELhuuK9D2j0mqP/3uXQOjQX8Ld3ao=
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2166360285dso75937405ad.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 13 Jan 2025 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736779119; x=1737383919;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n79rk6b+8xqMmWjuAyko0er+FR6QjAQIxOU32J9enis=;
        b=M5E6GGdtVkdzoLsVSncTNmEMaezhrgYZhND29MxHZBy2Q3ePS2Yw3Dz+4A/DRTh4tB
         60Xe9oqch7hs0sqvGYgjuutbfzyTTD4OIs91jGAivAQ4e9E162k6mfea1UcNjWLiW4VS
         0EZ/zbf+y7BC/y6kuF6hTU9zNjjgeMJHBKsp9eYF2w26qX9I5EzqnHGOwVLABGG17AOI
         9tS3w/bgzldQ4jTNGktG7zpcyAh7ZiRrvZWS37/9VIxUDb4LNPdfDr6gkoG6XZxuuKcI
         qIWQysFpJ5LGjTdVQG1xfvLBKwiT64gsW4FDSl9qZmBdS7VoEUAy/rZdrroQrOw9ntDy
         o8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736779119; x=1737383919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n79rk6b+8xqMmWjuAyko0er+FR6QjAQIxOU32J9enis=;
        b=lnEd34PwickP790LcCVVMMZzK0azrmh/qqmq9QbDqa53HXN+svNSA3g7TyxDeE7yJl
         +Oh0kD/Ycy3uETt+ER8D+aSIYgBtis+mOKS7XFlNC7hr9pRkqnSQU7Um/GGvoh9kPSPQ
         6ndW9sTbQ8ZRZNDDrq79tq5x6nZzh0UVNJSm3b+3KsVNLVriyp12UC3jrZaIBpvmcH79
         4P6OdTKgX2nhqtHUjHFuNePuvCi9UvXP5SEiXPY1ZuWYfFaFMpaVCyDGAo6nbAjlOxkF
         uXSNQ1RhztZezcIwYp/Cine9kzuUFXJXKs6fYvQL/LXEpnKCdQbvW9mN9Z4LIvlcAssc
         dZsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjR0SBmkCdKj9PRpKs5b2pnFEyUlxHKabz9GTpMGu5kQSZui398W/W7hHdtknYUUNJBYg8TbMVfhHw3w==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YwX9cDmbJ50J9QWWanGT0gKh1UYSdKPSmVFm7454QwhRWBBWxuc
	Ni0yF8WVruBa5SB64eaP03UpRBVlfMk6XMTolR/xrK5QJooh1nqv
X-Gm-Gg: ASbGncu0eqZjVHwmxK0QxnoI+kOCDbkVlti3o+iQA/0oOw6vk0fh+hWbDM3TVIxB7uv
	+DjkXP37U/GrNpCIMsFCvy42DGx4J7KR5AdQmEv7eI65xkUA8Avz5Cx547Dvs3NAqSlA5HeUZVt
	fMdPD451RuZ9piel9yphjQhSGvrsmHGymYbfsO5prc+JADjtUpcpZHk/912QuBor8c1qGF//Asa
	pFHzLIqH4ZbF+OIe+Z9xmXTjAmbpq/hT8V/XduRYS9Fsgk=
X-Google-Smtp-Source: 
 AGHT+IGazeu03SiYco1yjo+DeQUEtizAzSGgMZznFsd/ItXTJBGhLqoPfMkABloEPy5ZTJeLHULJqw==
X-Received: by 2002:a17:902:cecd:b0:215:6995:1ef3 with SMTP id
 d9443c01a7336-21a83f3469cmr286693405ad.3.1736779118671;
        Mon, 13 Jan 2025 06:38:38 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f155e00sm54328715ad.103.2025.01.13.06.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 06:38:38 -0800 (PST)
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
Subject: [PATCH net-next v8 07/11] net: xfrm: Use link netns in newlink() of
 rtnl_link_ops
Date: Mon, 13 Jan 2025 22:37:15 +0800
Message-ID: <20250113143719.7948-8-shaw.leon@gmail.com>
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
Message-ID-Hash: CTSTM7UQZL36OMN6J4P75KCFYJO34NMK
X-Message-ID-Hash: CTSTM7UQZL36OMN6J4P75KCFYJO34NMK
X-Mailman-Approved-At: Mon, 13 Jan 2025 16:21:55 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CTSTM7UQZL36OMN6J4P75KCFYJO34NMK/>
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

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/xfrm/xfrm_interface_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index b7ac558025d5..b87a5c950833 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -242,10 +242,9 @@ static void xfrmi_dev_free(struct net_device *dev)
 	gro_cells_destroy(&xi->gro_cells);
 }
 
-static int xfrmi_create(struct net_device *dev)
+static int xfrmi_create(struct net *net, struct net_device *dev)
 {
 	struct xfrm_if *xi = netdev_priv(dev);
-	struct net *net = dev_net(dev);
 	struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
 	int err;
 
@@ -819,11 +818,12 @@ static int xfrmi_newlink(struct net_device *dev,
 			 struct netlink_ext_ack *extack)
 {
 	struct nlattr **data = params->data;
-	struct net *net = dev_net(dev);
 	struct xfrm_if_parms p = {};
 	struct xfrm_if *xi;
+	struct net *net;
 	int err;
 
+	net = params->link_net ? : dev_net(dev);
 	xfrmi_netlink_parms(data, &p);
 	if (p.collect_md) {
 		struct xfrmi_net *xfrmn = net_generic(net, xfrmi_net_id);
@@ -852,7 +852,7 @@ static int xfrmi_newlink(struct net_device *dev,
 	xi->net = net;
 	xi->dev = dev;
 
-	err = xfrmi_create(dev);
+	err = xfrmi_create(net, dev);
 	return err;
 }
 
-- 
2.47.1

