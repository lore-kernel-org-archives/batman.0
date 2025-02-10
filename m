Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68F4C0219D
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 13:39:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 3B28184320
	for <batman-adv@archiver.kernel.org>; Mon, 10 Feb 2025 14:39:11 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739194751;
 b=F2HuKKhlopN0m/YCv1SsMKALKmxGAtm9+RtXcWDkl/CZZz6KmGEbuQoguFgM3YPdjjqSi
 p9KmKPAJ0V7FJHxbY2MBKJErr5hrkx9T3WXzbt1qQ3oLHcNcSuS+rnHOsxHmUsppwgZKxJ9
 qYJFw2+GX72BSLckj5vi7p6KDI31u90=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739194751; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0tN6LBIpl7aUsxZAQ1nC9Mvrd+HBX5wlThy/HCxYMvw=;
 b=bujgMXh6wetFHlsNLjK/1FT5bjsUDf7BkseHrIPkc/dgv8ZdB+xJDuTz/7FlKeHoLKKJL
 8LpcRQ1CyylMBTreJn4iacWemuBhEg1RyLbs4BU/nJHL61wLNtQMgkJLum8UF3h9wpl/5qj
 oYanhCSmT0x/Cw1tRUgaFTxsf7mMFX4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id EB67783E3C
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 10 Feb 2025 14:30:55 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739194256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=0tN6LBIpl7aUsxZAQ1nC9Mvrd+HBX5wlThy/HCxYMvw=;
	b=1Dhh74QS0K+I/f+cVO1LHTX/JP/tkKTdFaYwQxWjpaHhiaDEb2NhR0mnRyHpahfUzNVBkl
	Hdv1JLLcnUWIShGxf3Fkx/pNv02AcntMmR1151iX8IEddM9nclUBhihVjC/w6aXbaJG4a1
	Y6SigXltbejE2uOVRQysitfxv6tMTv4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=KCbuiDWF;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::632 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739194256; a=rsa-sha256;
	cv=none;
	b=OLC8PiN8wQPumjWHLTkLEp23H8/XqdOmY8sp4mXHtNRgGF272aj2YYamWmWvLee3cx1aIT
	7NCtDRy2qAGDna9/z7Av7x5Jo67m/YQ7idNCuKs74HjeqJH24DDfztuPNlo/L62BF3fXKH
	PmRPpaMzJquWe5XmMRilPUEdQ60Aq8o=
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21f2339dcfdso68365355ad.1
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Mon, 10 Feb 2025 05:30:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739194254; x=1739799054;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tN6LBIpl7aUsxZAQ1nC9Mvrd+HBX5wlThy/HCxYMvw=;
        b=KCbuiDWFeMmWk2/1BEiJOAS5vtxrp2wEWGR0JblJfTM/vyxg/ZjbBgR/D7cR0oaUrg
         o13I5JsN4wnoqwcjIxaON3gGW4yaS90An1RmmU7lH2LNkV32xCtaMsOodP6BSTfhdCP6
         JjolJAVZF6qfb6DsvWBw5nwlztDFiDnQ9cCSlS9drA7JHMwx3QnmmMrNgX1xY90oviSc
         Bh4kbK8tIk5CP/ZFlA+gThXC05dYwnhU2/h+n0RPO4TT88lAEG0cHlkJKbWKLI893X0j
         mi3OPMuWstaU4Qsnjp4INfrpMaEXBqSDqHgVdLASRDkmiwI4YHDDhEvuWEyxgLi7xdOR
         nqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739194254; x=1739799054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0tN6LBIpl7aUsxZAQ1nC9Mvrd+HBX5wlThy/HCxYMvw=;
        b=dTrPD0+e/8s0uSvr5IMa7Vi4mcu//7U/+EeFsnEyhahrzJq1faYg6ezA4f1OVAqOjS
         EgsQLuLDpNcl7nK8ojoT/sKPM0sZnsFM85eqReDxQvhB+s+EtffZlHT7APPqXhKv6f+J
         EeAt0QG2PKKaq4LHu+ESdTjKwr07fXN2QMQ889WLxvWb+dKIoCwJb+LaYWqmCmxJkqpo
         xZ4lUQ22EeedqFQwO3FG/NkX9FKPz6j82l9s98PXq7Jb5S05lC1LrFnii57e1KXH0NCK
         v/dTVEmQox62KafQnxNecy2kYCQ2YzP8QTz7hC/YmRa922H8/B09Q45YRBr8QF6b99P/
         IF0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFYeIwX5pEWYaUXXZvBRnw8YDAiu63yxUGzbNG4OuUQ1RocVQ1NrY+Pub8G4R3fXusgX45by7p4yvl2Q==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxmVtuar+Cx+UD4vLcLX7T4YIXXBEPewqa/plNeLETzijs2J889
	aNfHSeIcUVreVgtRzJ3E4QijVMrf4vFksH4v+GcR308gZsQoZea+
X-Gm-Gg: ASbGnct4I9ftjzu0gt/r3DVPWUBVIiIOJyhoCKzsm2xdqR15c0dl4Dmzq1r7kBWDOzY
	YVXsxeQ4oL4y7+1LpTsEWlcFQifu1wWbn9L6s202YEb3w7O1uINB22PBNipoTWVS/2TPKzgzHku
	CdWs9Zy3xDR1SgQyenuT+aIbwhLo4NEp+wB7BSJdSob7sYg9b8GKuA2vJWaTW2YEvllYBTVm1En
	lC25K/c0Sx/x7WJC+ZvqyT6L46YhIFB2QB2Hb8BOn6bod+khAA3+nWixANb8qI28hb5PD2CnCZC
	woYLiQ==
X-Google-Smtp-Source: 
 AGHT+IF8gihjdkRbSU1HRP8R4mEppMkEAKGDChElxIvCxKcXV79FUInFhj/RnX7alUKIg2RAq5xNnw==
X-Received: by 2002:a17:903:46cc:b0:21f:6d63:6f4f with SMTP id
 d9443c01a7336-21f6d636ff1mr134607475ad.2.1739194253851;
        Mon, 10 Feb 2025 05:30:53 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f3653af3bsm78799445ad.57.2025.02.10.05.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 05:30:53 -0800 (PST)
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
Subject: [PATCH net-next v9 04/11] ieee802154: 6lowpan: Validate link netns in
 newlink() of rtnl_link_ops
Date: Mon, 10 Feb 2025 21:29:55 +0800
Message-ID: <20250210133002.883422-5-shaw.leon@gmail.com>
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
Message-ID-Hash: W7ABRS3UVA2GLRAX3IX6WCTU77DD2YTO
X-Message-ID-Hash: W7ABRS3UVA2GLRAX3IX6WCTU77DD2YTO
X-Mailman-Approved-At: Mon, 10 Feb 2025 14:36:12 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/W7ABRS3UVA2GLRAX3IX6WCTU77DD2YTO/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Device denoted by IFLA_LINK is in link_net (IFLA_LINK_NETNSID) or
source netns by design, but 6lowpan uses dev_net.

Note dev->netns_local is set to true and currently link_net is
implemented via a netns change. These together effectively reject
IFLA_LINK_NETNSID.

This patch adds a validation to ensure link_net is either NULL or
identical to dev_net. Thus it would be fine to continue using dev_net
when rtnetlink core begins to create devices directly in target netns.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/ieee802154/6lowpan/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 704bf9e3f097..ee318d46817d 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -143,6 +143,8 @@ static int lowpan_newlink(struct net_device *ldev,
 
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
+	if (params->link_net && !net_eq(params->link_net, dev_net(ldev)))
+		return -EINVAL;
 	/* find and hold wpan device */
 	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
-- 
2.48.1

