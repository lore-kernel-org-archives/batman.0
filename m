Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AA2E77188
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 13:23:18 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EC42884213
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 14:23:16 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735996996;
 b=2BemhDa8jtSiBcYzas5NeFZk6LUwqAvbk8feD4SRRPB+3A45iI4aSa5lM7zx7fw7e3GHk
 oGSoG3uzg3g3RL+HtHbc6fvHoKx5+uQLQlm4Jpo7epR/MXtEH58s+Nj0sa4tFIv4Sie9GwL
 0sAAViCZXYnYvR3Z/CU7PTPHw5Ue97w=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735996996; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=t7lhW/WxI9EK3nLn5yDY0MQG09nRFtNebbOyrqmZTug=;
 b=YgqGCQWdKaszEXYPazdJaIfXXE04CUKzYAoo87EjU7pAfkubR2ocMjq2QXrt2VwefmMkT
 ILMiIpMsnPF7HfOkZrfumt7FbEzXg4SdOip9hUEV1ZssFNqbHXeVMuOb2Jo3ISLgTDKxpUI
 pPIPuK1uZ+4Ga69rpUMbZctzVN7Vqz0=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9A16583FCA
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 13:59:00 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735995540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=t7lhW/WxI9EK3nLn5yDY0MQG09nRFtNebbOyrqmZTug=;
	b=n7g1qXRZ7qSBNnCYgdwJGVAmzzV432XJrhPEiaj5bxDqDrRBN48b/lJmqoCwO/7tvzwlQq
	EKYTGBOWAXJ0aS57t/5T+Z8FxQTcYG9X26hFc5bYAXaVxqXjX2X4/gZ8HdIl3TzSuvSGlZ
	ECc2KRIQnSIB/YcRja6YXfXM9dPySbE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=lrmUK9gn;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::62b as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735995540; a=rsa-sha256;
	cv=none;
	b=GtO0Vdmr3MD9Tbdc+R5AEqS5LZROEQLiaC6PmDhtK6qTNROAjG/0R/8bjYuyJAKU0M1hIr
	Y+qTo09EtbsoRAoMLEhcgNKRa7Ya8YxX9Y9/Q2SYZNiPNYS1mO9NaV6BUddgTssrG7GC2X
	frNCjQ92Nv/zjuWb8KhXaVBlWsZKTS8=
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216728b1836so164392745ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 04 Jan 2025 04:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995539; x=1736600339;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7lhW/WxI9EK3nLn5yDY0MQG09nRFtNebbOyrqmZTug=;
        b=lrmUK9gnTiXnuXHuIRICKSYUpBllK1+Ii/TUl6jBGhW91/SPdOk67kPm+KIoboYbof
         Z/0NgjeEyTylZDGqFu7itrNxQDlHnPaF3Z4XyCMECtz0bkYylY1X5+rfcVl8M/HntO6n
         VZYz4bZtPRdo8MuhpLNX3ueDCM0ZM75JeLFPnUoLaY0lqxHDbVpvl+7RvIWrbXUT5CX3
         c6UVRMMQUkIYTr7r5s/eYLs1GuGwhlktNahpYpJnWee4ZDz8Vkfh+oD+YtZwnWYSGfAP
         Q5YdBo6Nct4nqBtaDNASWrEnXVYcMiOzMr4tgeVxJ7+f1wvfIOsZljYxNs4L3vsFJuly
         p6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995539; x=1736600339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7lhW/WxI9EK3nLn5yDY0MQG09nRFtNebbOyrqmZTug=;
        b=WkqaEUKu8qcyPpdUrDHitdAvJiNnPYejxof7VzYesJrEjsYDgW+AJwP6mV0BDOmo3n
         ibbp1UY6Oj2tQxJRNGM0CEJB8Bberp3WQwe6oNntZ1ne9zM86WKr82akMV+tSbRQFAy8
         2hQ+fdqVgO8xrzCgr5Qmk0sfbCYD40F/BXEyNnc2VrV2F3rGxpeDX53/1aOVn9HPeoq2
         klOx864QSuveFs4L0n5LScNJM0OzLqiRmHinQMwCPzX3SzYF9MTSNoCQGKF4feCyHdwL
         ec9WGISEc8Bg4NdDj+oA0dAlpkwuztULNkfQB5fhm4F8c9L7PySPjtGcaoWcIdp92Vqb
         MpLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkRMcSGWmcaOPhBZSRV+GtoR0eNcLcjgv/07HY1AXsi40dzfonf5gomMXUPuzhURmAdgWN27kJQk2MOQ==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yxv5T7k7h2UPqAUHTkoY7/ROoOHaZFssYh00MAbKjBLuAtundsP
	gRKtGV1h72VW0Z4oFNG3/JtJh1eqMThuHzv5t0zYF3RMr+xpC7N0
X-Gm-Gg: ASbGnctMDjuIvzu6Di9kgOaovUQeyOsLex3sP0ZFKB9AXsO3h+T2OQj5WiUgwgCjp0q
	4jhkCH88yCxJ5HMn1sUcGrlX/IhKjMe9RMnG/Te2PnJO1L3/MGcd4mLUs3+qoF0OYqIBq3VmKMM
	UH8tMq+/dlXTJx85nUtd41tNb5lNuHyKcHMAglMlPQJI5b69rkywFRWz54MXyYLeq+KDFWORSd/
	3Upa+k8Q3GqSt3GZ9od8XJo67kre6gc74jsjPUAIzNUzvc=
X-Google-Smtp-Source: 
 AGHT+IHLCiFk9BrspEkmn14rTTpjbLwBW8SdPWZM+0IkwauKRrd0EY+n9DzEaoNgd6USL3r4X9FuKw==
X-Received: by 2002:a05:6a21:99a4:b0:1e0:e027:2eaf with SMTP id
 adf61e73a8af0-1e5e048adf7mr83019375637.19.1735995539121;
        Sat, 04 Jan 2025 04:58:59 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:58 -0800 (PST)
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
Subject: [PATCH net-next v7 09/11] rtnetlink: Create link directly in target
 net namespace
Date: Sat,  4 Jan 2025 20:57:30 +0800
Message-ID: <20250104125732.17335-10-shaw.leon@gmail.com>
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
Message-ID-Hash: SUILLEOMISOF6XYPWW66TPAJCJMGRNMK
X-Message-ID-Hash: SUILLEOMISOF6XYPWW66TPAJCJMGRNMK
X-Mailman-Approved-At: Sat, 04 Jan 2025 14:17:48 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SUILLEOMISOF6XYPWW66TPAJCJMGRNMK/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Make rtnl_newlink_create() create device in target namespace directly.
Avoid extra netns change when link netns is provided.

Device drivers has been converted to be aware of link netns, that is not
assuming device netns is and link netns is the same when ops->newlink()
is called.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
---
 net/core/rtnetlink.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index a2246bbaf2bc..e8126007eb00 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3776,8 +3776,8 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 		name_assign_type = NET_NAME_ENUM;
 	}
 
-	dev = rtnl_create_link(link_net ? : tgt_net, ifname,
-			       name_assign_type, ops, tb, extack);
+	dev = rtnl_create_link(tgt_net, ifname, name_assign_type, ops, tb,
+			       extack);
 	if (IS_ERR(dev)) {
 		err = PTR_ERR(dev);
 		goto out;
@@ -3798,11 +3798,6 @@ static int rtnl_newlink_create(struct sk_buff *skb, struct ifinfomsg *ifm,
 	err = rtnl_configure_link(dev, ifm, portid, nlh);
 	if (err < 0)
 		goto out_unregister;
-	if (link_net) {
-		err = dev_change_net_namespace(dev, tgt_net, ifname);
-		if (err < 0)
-			goto out_unregister;
-	}
 	if (tb[IFLA_MASTER]) {
 		err = do_set_master(dev, nla_get_u32(tb[IFLA_MASTER]), extack);
 		if (err)
-- 
2.47.1

