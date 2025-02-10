Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C2EC02198
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 13:41:59 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id E465B8423B
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 14:41:57 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739194917;
 b=uz2c3yn6ZuyIK1UHgSvvAF8VzJx7SSkwC/cQ3gZRIEQ3JTmWeWDubkuRZKpQtNtFth2dN
 24rJIN7hec1pkoeVvPb7nvyusO3g79nDOE8YeqC3Yb7okxolzWqrBG8/RcHyV+/i9FOYm4B
 BGEP4aTPArMgWBqFTiDre76zKhsAifo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739194917; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
 b=3zP2d0TglxEGmY0V5F8o2ZvchZeZAEtI5VC2pX7UUVTkvIGb/N+SDoeiCbFyskOS4tngH
 Kei5gVDpMBMXHX+Eghnu5Dzox1mzxnWdFyp3fZfQSc7XJWgESKsCaVUGo+3BDYOW+pssd+a
 7dok4iOCE6lAA//c3IN6fRxDwExvakU=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6A90C8186C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 10 Feb 2025 14:31:22 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739194282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
	b=1ZnpaLcl5LxzH8Xcb1W7MUuBQiW0NNDTJ2fXJ/L+HJAHan2Stb4s8N/GszT4XUL1wkrqbI
	u5CWGif+p+7iw3MViZ0J6cR1SC3RmWoK2iwmW8W+ukBi+pKgZzeaDNcO0hNQgJaa1TQSRk
	FMoH+fRj2F1+1ANYAZxwM3qXsi3Gqew=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=DtusgSgJ;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62e as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739194282; a=rsa-sha256;
	cv=none;
	b=FdBW0htf7N0jMPk2VTdDBRVHJUgfT1MC+bY4ahFyiFBo4lVkBgGTSpr7dpFA9lyeTtYjLi
	k0veXOpOzQ4aP+oZbJlP5M04GMOb7PNPzj6q5XirAByVKv0ej4109T1VnsuqhDADzp0/gl
	mbi1wd/seGeAJiSW+qlAE/R3cE+SNp4=
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-21f55fbb72bso47190195ad.2
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 10 Feb 2025 05:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194281; x=1739799081;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
        b=DtusgSgJrjvEkaMeGJWpBrrOGMxpM2FbTGHjpIfMfWE+kmF5mD14ts2NAmvqKiutUb
         5glodz51DX5hlyrWQIN3kY2gb27fGNxufaBduPFOmB3hOsR+SgQKyQFa6gPLnlmEdDYc
         kED7WDL7bXQ4lGkrZS5DwVJeud+T0DXGOUOgDUTzEStW9WxP9Ht6/mukCZu5FTz6Q0OT
         XluCSMJUp0GNnSMic3Uuo+nzEoRxVCk7+/tINKrd438ioS0QoXMCkCqp09JmOuEphNCx
         9nKV2YIbexc853pZ/VXpHbFG5RQv6a7sXgaaJuXjreq3jIxLpncrwGhIXsHNmttrqrKg
         sPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194281; x=1739799081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
        b=u1o9UhJv/raxpGLEdx1TJJU5jmhkAL4B7F/x7K9AzsGTPSTfS3vqUDg0YL6pOox6U9
         hmknthftg6McWIQjO/uh4411qhq5nwYcdwaolChVGxqFp4BmJPRrweejA1yA/M1oPFWw
         VgHIPsx4OuvG1/nQbReu7psezhtcma0q0kkMA00GbXrjojEVIOaASJ92S3h2s2X3NI8v
         9c6iEhtDXVWYyoBXwNjaow85Q6lTU593tBbTU2opuF7MgW99qGR82uz5liA8gb27LCV2
         3zAPsCWvcRNibs/LlFffijfInN4BBx3jyxOwSils/uqNYo11VtKhRsUJBJaheM9TzE6N
         O3Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnwcEQgLRcOv7AiDbWJVbSb9Be+fGcF9/zjnV9VsyCnJQYaUyHRkSujp6wEdpq3f112OEtFYA762uC9g==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yw0yT4wxn5/tlomRwsJBVe4cddxWTuScxCUzcKdbp2qfOYj9H/t
	FtGpFsgxLQmc+v2xBHUv9IJJCdYiXdBcKWW9bAA0Gvs3an9MdUAV
X-Gm-Gg: ASbGncvzbGDmk40I+ahJz6jIcN4/zbK8O3IFjmjxJRNPQK4qH+4ZIr97670l13QFqRl
	t56DDFe6+siSdbiHVARdUvrtDiqNcmfBFyz4+AC86lHkLBuZN3PHwW/NxXDH25zmrIFAGbvUoC7
	r99lJ87si9UQ1hqLvwLxEgY/U9nH9xajtsKI8oGhhEIQ8Sv/VE4s8+iXKi/aau6eY1cZtzPd+hX
	tR2CNI4M9cTOG1ZrxVzYCEvMOmI0MyUSg5CBfFeIW0R60gpq1SAtlD7cN+X3+69la7jzcmV+VnK
	M34gnA==
X-Google-Smtp-Source: 
 AGHT+IHeusvrHP8M+FV2U5mrdVgA+KXf+BNwroimzhQyBeA1391Nd6kFx/ISaagEKEOW3Rex1VbPJw==
X-Received: by 2002:a17:902:c94a:b0:21f:8099:72e4 with SMTP id
 d9443c01a7336-21f809974bdmr103657145ad.28.1739194280801;
        Mon, 10 Feb 2025 05:31:20 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:31:20 -0800 (PST)
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
Subject: [PATCH net-next v9 07/11] net: xfrm: Use link netns in newlink() of
 rtnl_link_ops
Date: Mon, 10 Feb 2025 21:29:58 +0800
Message-ID: <20250210133002.883422-8-shaw.leon@gmail.com>
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
Message-ID-Hash: NHGVFLE7YLF2YMX6YDKUJK5OTLKZHM53
X-Message-ID-Hash: NHGVFLE7YLF2YMX6YDKUJK5OTLKZHM53
X-Mailman-Approved-At: Mon, 10 Feb 2025 14:36:12 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NHGVFLE7YLF2YMX6YDKUJK5OTLKZHM53/>
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
index 5659a6cadd51..622445f041d3 100644
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
2.48.1

