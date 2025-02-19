Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFDFC021AA
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 15:52:02 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 72ED28422A
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 16:52:01 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739980321;
 b=eQb3gMG0m7Bjmy1JP3VFYgv9vSex5Pgp1CcQiMo8splLGEDGGKjfl6NrapEc8f/eNQHOD
 pz9Y0tEQ3UdoLXCQrXrT3wxZg50UUfDJFwX+RvCUA2T1oKYWgxGnCgReL3W/PnILcb6bi82
 qY9a2Cb5afNXQ/NuDD6aXcQhckaJWcE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739980321; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
 b=kmWj2KvQpqsjKBomvrm9s2G8oznl0YkGMiL8bZ/DoQD38RQKbWRXmNJpvqxI62bS4oxXC
 V+AqC0fdUXhYnVnFsQiTtCoYoYiEpQ+RF8Yt7Ub+Bj3mTvIuJVS+QyNjiw/J+xryi8/AKIf
 3UyZw0h1A2NV7chh9Dcq+aBDm0YR70I=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5CB7583FC2
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Feb 2025 13:52:16 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739969536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
	b=2E6McuNs2zLyXYUSpy6QPSBtJTCdRxgFafNuqQGTgb5+7gWA05VusZXNGIECEHmRCZNuaE
	OcRT8p26FwIKMVqMVM7tu5IZ0HtKyJvxg5Xhh1m5Q7GmD/fchqLL3jxe9GemVj5CSBP0Mb
	IXZk+BvWopjekihictIerszwDgz/8dk=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739969536; a=rsa-sha256;
	cv=none;
	b=ubqBwRD09YqGq4KcIPYZxK6K9FExwbfcIYV70e3c0T5Z3898Mshxh6Az9uJP4FE76v/3Qo
	j9+yNx7epMH3iG8pYzqm4Hxz3F/vxZXMXqUSip9WN2bBO/CccDGVJj/IoN1Tt0yv+32UR+
	qma/g3ndHJXWr7HHfkCMu8w5eZKGklA=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=gLBQ2P2v;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::631 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220c4159f87so88471375ad.0
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 19 Feb 2025 04:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969535; x=1740574335;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
        b=gLBQ2P2vMHJlUeM9+nZGlEZrqVJkL2rW9JLWxqdj/SyU9wjyBaYdibLPNqr/yF9CnU
         T2gz9iCPbK54rKEg94ZoX7rMNmb4rWfCwpKsFGl7Hcx6qkXaLz7HpFWxBj2zwHOv97Ej
         Pr1qJ0pKx9JiKtJW2YcA0iRlwu8ER5HIt1SWFdcVMKQSJgLxkk1DI1UvxK+egwyYSOFm
         TqklTl0kJJs7Dh+jEpj28K4v7ORYOcrKb6Astu8HkplVgNwmuqUsjim5CRZojqUV2w5l
         KsQFtxZ+re9Z4QhKzO2NcYCK9yCLQ/cNDd6DuN5f1Dv8RTX3UTQUHTo9qoc7FhJtQT/E
         jsDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969535; x=1740574335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PyZ7Oa5HQm/CyDGlUAOCpKikT+Z0UZAcxIZ482ECX9g=;
        b=wqpld5KBvM/odNYYkHJQ0s4Lz1fwBFLQk8Q4sX4B18cyzUhaoTAhRHlB0sAh4iGVhi
         q1oCbY5qCfjY95d/kwGUjyTvTk+1YgPR6z8MQJwba31jerufS994JVBtkOQKvCMy1dZt
         bNou/rI/6rXSwtZ+n2JNPYmiUBTm2NfK+a/Ew139rc3H57lkVUPeVRZSCWlzhiRM7Emr
         h5yOab9i/0JRRdPiw4+KYOcfkRqhcUFT9FbfZMl8U/G0B/q5ddf5GZFMGaNhiCbyqkFu
         6IvVMXXvyE65lQCIuWDhjInHO/DqWbJd0WOADcSYnoyYDvDqgfon43cZ/8yxRuQ62Klm
         Yanw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqJ4hNGgw2cj3xpN9M4q6DDAVWRfOm+yrLoSSs+BvDIY+Vx2QcC1WPYkhlWH8VUNo2rTfRc9CPCQHMQw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YzWqMBOj6ydyDIEYwAw7ZasCR80U+SlVwHs+OZlF0psOnQyhxNh
	mExCzPNjijCI9ugyH9pZBNQcMuLP6gX6ObE7ebo87dyu01wxp2ET
X-Gm-Gg: ASbGncv/UcvLbAZOFZ/g0rW1MBronzKaiDo3e6hfjA8CnRUyyIKzMZieznaQKtiEgWa
	RYox4LqJcp21CFmYdB4VbCG8SJdptidKwjGqMSnBKwlP16IFvLqB7u+cizWYP5BAs2gXimXO5D2
	taD/F5AtyCS0cWYblWaR3wYQIgVxnF6yD+fdLLT+781Xm4g7ddoFM0TfyT+YOPE0K7MOoKUJjud
	f+iEVjWhIezO5SJ7ZV/5TxkY3Ziw0QPhHlDUIeNI962zHtlORDaE/dXcut3XBYo98VQTfqZU1Ld
	bGs3/A==
X-Google-Smtp-Source: 
 AGHT+IGEFP67zSY2isKHwZ8c/HiTSEQrpqN9J90h0hy0pUrJ6TwQBaUnsvMftR+A8p8DsBy8+Vg8gQ==
X-Received: by 2002:a17:902:d502:b0:21f:dc3:890e with SMTP id
 d9443c01a7336-221040255fcmr244598235ad.18.1739969534802;
        Wed, 19 Feb 2025 04:52:14 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:52:14 -0800 (PST)
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
Subject: [PATCH net-next v10 09/13] net: xfrm: Use link netns in newlink() of
 rtnl_link_ops
Date: Wed, 19 Feb 2025 20:50:35 +0800
Message-ID: <20250219125039.18024-10-shaw.leon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219125039.18024-1-shaw.leon@gmail.com>
References: <20250219125039.18024-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: shaw.leon@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: BUFQYZBXCUHWNZ57UIRQWZDJLZ2UA5TM
X-Message-ID-Hash: BUFQYZBXCUHWNZ57UIRQWZDJLZ2UA5TM
X-Mailman-Approved-At: Wed, 19 Feb 2025 16:43:04 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/BUFQYZBXCUHWNZ57UIRQWZDJLZ2UA5TM/>
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

