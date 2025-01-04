Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC34E77188
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 13:20:20 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 5DEEF8429F
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 14:20:19 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735996819;
 b=cXLozL/b1PL2BxlNW0WktRq0CjZsDaHyJpBbCdJRBw5Lz4OYN40myOa9/SXXEKrbPbWHY
 nkahBEw3KXWzHiWKHNzdf6iwZArSfDkFXmhtVkCuMzjOwiEkUtJTNQ93nikgeEQuFkxBnF2
 i7Lx6qmNAyqt4xy8PEIDzdlsXoiXx90=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735996819; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
 b=QyYin6KnkLD2B/Vkqwz0GJCW7ZImpUgpCtCneu/ee/tb2lAUp4+zkScB+uk8mH9eJg99o
 mSTkYswFAE5CSeXn6WQkeduvYme3kI4ZrmtWtb9SmGLVIcAzn6hOy/fHDpUNIiAr67GNWhG
 Wlb/9CNrl7dqVmp+VZuP/8l+thGBa7U=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 7E38E83FA3
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 13:58:20 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735995500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
	b=h8QtwIC1c0DtjQmWEqqr0Hg7ic+2TNFZ7OgTakzUb22/710b4T0iKFo7xazOg7nlPOR1R8
	ACu6OVRAoPJCcOa3eJ+9TN85kgwJW1IcYeh/jBqOYdITOyJ8KpJDWnp+TObFYJzO7xuHE4
	LrBqwZwgW599XAJiEiv3ohX8bRt05Kk=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=FLka7kEZ;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::631 as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735995500; a=rsa-sha256;
	cv=none;
	b=1+3V6I5JeL2iUtWyD7yLh6MvEqlQfc73vZrkx+V3pSs24ZqfuOypWrOUmuV3AE3f3NczB6
	Bh18WVmuJePHqsHbMuIkZi9dErz50/HpeDB41kIC/FWnwdSD+w9CcMwk3nwqAMI7epHawE
	nnDzx9sB61P8a+Ea/w2Fu+fftwaNEco=
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-216728b1836so164388285ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 04 Jan 2025 04:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995499; x=1736600299;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
        b=FLka7kEZccZaFhOp3VCltlf/eAYEw5ZNr0c1Xam91bcIOYZ0M/u9UXEaBkHX0SNS2v
         2T9W4gaX0VDC7qPwEqOwXUBOi6bMD43vcbU7JQEJ9PhU6cFE2aedNEmWiDkX4x+aIGYH
         yMiZqb/SexICWOX3vNRqzuFRMJLPCsoLASVUocTgSdDB9/APnltCkmCRv+lSBNZMafrX
         +k5+2KfBVA4E98iPNEU7aFEnvVd9D88Qxpa5WFyTIbmhV9I0t2OOlbNEqT+Q+jnrOgid
         wBpMdWyHPhPH4y5r61SrheOZ1DwglgR2kMGE0sKuqGBEcWM2H2+NfMzEhVDzVGdTZAnH
         0CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995499; x=1736600299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWtx/GpPr8Y7UYus5aPINKHxwSB0EzMFBw6o16b+Q3k=;
        b=YMv7a+5r90gbDd1/EOTz/ZAku0xI8pFySs26wUzRutrXHGclRQF2ah7f+ga83OjD/q
         kM81YeR/QtLegXhbW1cqBbaYI6vmi5DTNOBJDKnU6xK2JvKzGyNNYKwWFJPuMc6IeC+K
         XSqtZV7nR1HiR+fP2a9nYRKpLnNXIek+EoY8NXUuzN5BersK060jaHCVRCDna1MaV4lR
         epUtnPXSqKldb4Jej93i1ZybSR663YvQiD44vEDQr1h3gliJuMpMVYmGa16q9r5m9jm4
         60KKOFuVVXkdFHqnaZYWFlV2Xtj1MLBDG0YUo11egetD1slxgBk9okbYSijsiLh0ogQ2
         6IQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4CKmJgSqFfWyoPXZv0+bM1zE/6WRM50xGqHGZ+KQiXpmm/ivT2UcAXLVtx6kJt9hLq0h7uNuiReWwhA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YyQ5Za4QS1rovKCumunHv8cOoHMaTOxnBrhm80hSSnIXVDFW/eH
	XLsWGpWGWW4EhpHPuv8moylmcJi+K611aWGBlH+6f7hmgDo+8Vvs
X-Gm-Gg: ASbGncunA4j0Em54VLn1drHicZxu+CJU3uViiArA4lkL+OhcFFIkyF93fxPOfMlUStM
	cgya6JZA1etH7GgVnvIE6opzatC9cU3H9BOt6EiVtVFXEsEfNmNyyoCsTJaImUoHMqWdoKkwHb9
	oJ/fdglS971Nm6tDEJqjdfqmKSjlVKsSxTxSjaK9T+rB74JAZI6ZOeXdZ2aBo7SCPZ81kK7mE9D
	bEs5JKMoIj/z3pWpbfi6OYL6HmshuRHKI7yAxADoiVcDL0=
X-Google-Smtp-Source: 
 AGHT+IHIkI4kgOvJJQ9O4vOvA6fRMUVnhOi23ydvn4IOYZv1bvM67hPwcmTlhhKLeOZA8Exp/2drag==
X-Received: by 2002:a05:6a20:4394:b0:1e1:b430:19c6 with SMTP id
 adf61e73a8af0-1e5e04600e3mr77828034637.10.1735995498951;
        Sat, 04 Jan 2025 04:58:18 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:18 -0800 (PST)
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
Subject: [PATCH net-next v7 04/11] ieee802154: 6lowpan: Use link netns in
 newlink() of rtnl_link_ops
Date: Sat,  4 Jan 2025 20:57:25 +0800
Message-ID: <20250104125732.17335-5-shaw.leon@gmail.com>
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
Message-ID-Hash: 6N7DCJNV4STIW5GKKPASS6UMCPUAQZGL
X-Message-ID-Hash: 6N7DCJNV4STIW5GKKPASS6UMCPUAQZGL
X-Mailman-Approved-At: Sat, 04 Jan 2025 14:17:48 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/6N7DCJNV4STIW5GKKPASS6UMCPUAQZGL/>
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
 net/ieee802154/6lowpan/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index c16c14807d87..65a5c61cf38c 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -143,7 +143,8 @@ static int lowpan_newlink(struct rtnl_newlink_params *params)
 	if (!tb[IFLA_LINK])
 		return -EINVAL;
 	/* find and hold wpan device */
-	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
+	wdev = dev_get_by_index(params->link_net ? : dev_net(ldev),
+				nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
 		return -ENODEV;
 	if (wdev->type != ARPHRD_IEEE802154) {
-- 
2.47.1

