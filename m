Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CB0C021AA
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 15:44:09 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id CC0EE84252
	for <batman@archiver.kernel.org>; Wed, 19 Feb 2025 16:44:07 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739979847;
 b=n258WFzyjtKugO1crGUNbqhAGv005pmZ2rIh+eR+/bAOBPbdHuDMhSKZQwVEmwpa+FE50
 TcLwFE36kqfLLgfdZ6BDRD6PG60fbOXojdsiZwivRslQB8n8mmbIfnHnQ2Cce3/UDPLVncx
 RRICFzC2rcu0qy/rSW8wvw8ZUYDfXC8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739979847; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cUZVG0cQpX36tsrgh/ArNurrF9hV9SVnXTfgFQUKvso=;
 b=lbT9xLapvirddjVC3tbJfc/qHW/LFuCU9ySIQryKrIN5GOu5Fny5ftoCFDIeCPK/I4lyY
 Uh+GP1pvxoUh22GOxrZRkPwzNWtFEyaZKK9+AobZkK+Av10785QcmxBRB0ZfHBCu/KOzIXc
 kGUiHjncbgbY/M4TPNCRnERgWQ+5wJg=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 80B5882D5E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 19 Feb 2025 13:51:04 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739969464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cUZVG0cQpX36tsrgh/ArNurrF9hV9SVnXTfgFQUKvso=;
	b=DRj911ruBPzP/vY9jtZpaOD78tRQDqZ/qpqUKPgg3unSb5EsQDjKV+V5AMcQVizIPWXERM
	lh4HcOGjjdKJ83S+yP2rzIxpfBiGKzaobYgYLCsjjhcqznPg0MAXYFAkrag14e+BuC09LA
	Dp7kVqiQ5yg1SBIRiRryareN8LJlWlc=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1739969464; a=rsa-sha256;
	cv=none;
	b=pyEdkv4Z5BA7qVF4id9jLyimKEkqwNa65y8kwCn82m4YVuVdyVMLo88fLloNa0QBwLm1TD
	RF2cogxJh8mQ9qROaqGmlEunzCUJwlIypwHlqoYS9Gq82MFGSqdDnwszSPVzwKIFYHa/YL
	enSJqak/bKvHqeiOQNTriZaSSeXB36E=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=DBUkNdfN;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::630 as permitted sender)
 smtp.mailfrom=shaw.leon@gmail.com;
	dmarc=pass (policy=none) header.from=gmail.com
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22128b7d587so61215865ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Wed, 19 Feb 2025 04:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739969463; x=1740574263;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUZVG0cQpX36tsrgh/ArNurrF9hV9SVnXTfgFQUKvso=;
        b=DBUkNdfNrr4njMVOyKTyTmyWcFT94JEXT8GRnV9bI/slnuFo7LFRzPQvnd623EEm86
         CI9Z5RN0IePWzaVM9mINhm9DQ5XnXy0H7AyMZl8/tz3XlmrkyJDgUnVDzUpnZaXNQj7L
         8tK9quQcsksxFL3D+d8hM9g4AiJ5o64BoV95hnuVht3w2R8lsZiMOL7/NP1wZisU470Y
         A6sqqQfsCV3HjlA1T9UKDXpeug7dmqGs9vgkTVmgNQQWSvwUSIWNm3uTSWM60zUJvg7Z
         X+IuetQp2ZIbtLJuQyO+eGGKPU8PvFPAmw6ZxWk9vIa8zkfjs+ThCtwDubHRLz67N7g9
         DWsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969463; x=1740574263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUZVG0cQpX36tsrgh/ArNurrF9hV9SVnXTfgFQUKvso=;
        b=loXgytf1pbd0cUcgMv/gIU6kFMCFOoDAW+p0BLRL1eD7wY4O5SQQoYRZ/iNaLWJaGm
         AE7jBomnDeAIUOcAMgpzigtEdCiPpWL007y6CFO4Jm6ssNXfKQZjpub/UADUj0ESWFhT
         HO2m2hB+OV+49QEaaLDWsAsZwVVX8xpWYgn8iqFV0CeSnk2cktTGoPYHmzSVeyh8Ssm6
         TkoR8fn3iId7nYlhjsHvVn0WZn90nRijEm86kDR5giNkc8WRHSQTqDPekzve9qNmcn+e
         Hlwo0u46MZGTSEtcvu4mjf1TP3gxK7mRFFvUuka9iAlofe53XEtHIOQ0ochAXiS97aa6
         GABA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6oUe7ZtNFwRSZQb/cHYZni57bQP1fdrKBJxR1VXT0eY84Ltw5tWJbYcHtTzLwRY4iiErYwl3vAwDzhA==@lists.open-mesh.org
X-Gm-Message-State: AOJu0Yz4vv9mjU3ExJpXus6UOOTOzbOhPx7szgMzPj9m017c4Dut+BUq
	xnLQxPjvbmXYleSzHpd3MtNHUgUrPxckWOZfi9rdZ1QvzpmalFfM
X-Gm-Gg: ASbGncswq1mrUQmomnjTuIOyA8EeFaee9G96r0rIF2DlteiZsoZNgPdjJ5alvSxspG9
	BnMC0sdqStTXLqK4AUDTvCYp18nBA0VIm8j7bPhw6meQsn7AoQ0HX+1vE08k6e1FXiYAg4QFq+Q
	azn0j7dTkKJKI9b4tQSInEgxECPjBJP1tQkxr6nxRE9a45YfypZmaxVKQQIGdtpBgBDiZdsPdr9
	in10kU7ajJLdhHiOcmfoyRa5FJqI+lSvVn9+SgC7zQxUp6VjPmVLBJeMSUSvNYq0U392a+L9THs
	adztHA==
X-Google-Smtp-Source: 
 AGHT+IGj+mvdG9uQ6taCs0F1tgau+Kd1RL6XlmFtErS9OY17fyECZArX3uy2OYbhVupliE/g/xkWBw==
X-Received: by 2002:a17:902:d2c6:b0:220:be86:a42d with SMTP id
 d9443c01a7336-22170777df8mr53655825ad.21.1739969462888;
        Wed, 19 Feb 2025 04:51:02 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d536436fsm103427175ad.64.2025.02.19.04.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:51:02 -0800 (PST)
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
Subject: [PATCH net-next v10 01/13] rtnetlink: Lookup device in target netns
 when creating link
Date: Wed, 19 Feb 2025 20:50:27 +0800
Message-ID: <20250219125039.18024-2-shaw.leon@gmail.com>
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
Message-ID-Hash: GLXZ4PMB5TXDMBTYDSRJ2QMQG4UUUDXQ
X-Message-ID-Hash: GLXZ4PMB5TXDMBTYDSRJ2QMQG4UUUDXQ
X-Mailman-Approved-At: Wed, 19 Feb 2025 16:43:03 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GLXZ4PMB5TXDMBTYDSRJ2QMQG4UUUDXQ/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

When creating link, lookup for existing device in target net namespace
instead of current one.
For example, two links created by:

  # ip link add dummy1 type dummy
  # ip link add netns ns1 dummy1 type dummy

should have no conflict since they are in different namespaces.

Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/rtnetlink.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index abe1a461ea67..0f3e2c6021de 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3867,20 +3867,26 @@ static int __rtnl_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
 {
 	struct nlattr ** const tb = tbs->tb;
 	struct net *net = sock_net(skb->sk);
+	struct net *device_net;
 	struct net_device *dev;
 	struct ifinfomsg *ifm;
 	bool link_specified;
 
+	/* When creating, lookup for existing device in target net namespace */
+	device_net = (nlh->nlmsg_flags & NLM_F_CREATE) &&
+		     (nlh->nlmsg_flags & NLM_F_EXCL) ?
+		     tgt_net : net;
+
 	ifm = nlmsg_data(nlh);
 	if (ifm->ifi_index > 0) {
 		link_specified = true;
-		dev = __dev_get_by_index(net, ifm->ifi_index);
+		dev = __dev_get_by_index(device_net, ifm->ifi_index);
 	} else if (ifm->ifi_index < 0) {
 		NL_SET_ERR_MSG(extack, "ifindex can't be negative");
 		return -EINVAL;
 	} else if (tb[IFLA_IFNAME] || tb[IFLA_ALT_IFNAME]) {
 		link_specified = true;
-		dev = rtnl_dev_get(net, tb);
+		dev = rtnl_dev_get(device_net, tb);
 	} else {
 		link_specified = false;
 		dev = NULL;
-- 
2.48.1

