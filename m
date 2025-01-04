Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3482E77188
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 13:22:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7B56E842B1
	for <batman@archiver.kernel.org>; Sat,  4 Jan 2025 14:22:09 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1735996929;
 b=u0yVjqVIa0rrVuAd60e2PA7HzZ+2eqIvTF6xSmxkovUoVwCdc28wpSU6JOiEs1jrNg5xc
 HBa+SymtcG4TH1k0b8b76NMlIqC6X4B/ASYR9c5BJAQthImHQ/QQKD2Qo0bqE3gyXMirNoT
 p6n0xAqiriTLL0Addv48G8o1HepKX0A=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1735996929; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
 b=TCdsmRzccGjhdlxvOfHjRRVjaljno3BoG2QCx/Zrxf3Ek2giMJtFEG2ozXk03uyPX8w+0
 iwS6FKgNyk+jpJwaKDXpxVif/OZZ6xQwmULKS7DwZvbG7N18sZRumCiOGbTtLLp+GH9DpcX
 X7rJlLgGh+EmUyAujQyAdOe7YoZUtO4=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=pass header.d=gmail.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=gmail.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=gmail.com
 policy.dmarc=quarantine
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9C9A383FBC
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 Jan 2025 13:58:44 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1735995525;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
	b=bzB5nrW+Ed0g1QMg/2wQaKhHBqfwK/9Z7wiwqn40GD9vWoMNgkX0HklsZgOGibHqAJUNs8
	qjxsqBzMug81iNH0EmxiyJ0SydDNfHyjVFO8B9kW2seaVVpU0StKwFrcwafjwTIbrJF6jy
	tB2fKJlIXpDZwqvlvQqwSr3m5ff//KY=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=gmail.com header.s=20230601 header.b=EC5xIZPR;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (diktynna.open-mesh.org: domain of shaw.leon@gmail.com designates
 2607:f8b0:4864:20::630 as permitted sender) smtp.mailfrom=shaw.leon@gmail.com
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1735995525; a=rsa-sha256;
	cv=none;
	b=lKUkZnQPYecVDciRKOcJ22v7FdyE94uOSCE/jL+Z90Tf4L+zY3OSy5gUgi4tRo1xkvV57+
	S423eV8IcQZ7dUMX/veQKKdJKl8YVaO7MUd9pjnlmUlXALjsQcHNMBryUOnJWUJRxfYjrf
	KhChClIOBPJAjTTXr5WwK8+6g3sOpA8=
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2164b1f05caso180036625ad.3
        for <b.a.t.m.a.n@lists.open-mesh.org>;
 Sat, 04 Jan 2025 04:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735995523; x=1736600323;
 darn=lists.open-mesh.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
        b=EC5xIZPRUyzShh1WMcrFqyq1o5JDUf7o77Z7X5NIdREx+FGrLBxoGWOZiBllyXDIq7
         JiVB6Je8dOjS9w4pnVaEM56hPZJhW8L8S2rtAT/MaXeyZ+hSlFH/Z8cjjZhL0OzkNHyK
         pyrl7C5SqrxzA/6TFuAf8ivVBYu6AcTzRK5ds13kJOT4Ez4qIQJm2dSnvT0HBYRJj3gw
         ew3VxZmhPPBB/kMJlnWfo70AQrSfTZycHDyxUsHKWeF1tRqKOiYUKu/P1tMwSwXBiE4m
         IUH4YieKJsQrN66zxmSAH50EV7VqCz3P/FYUbZPHvkz9DR5hkZoZuEOCOfcjf323w9cX
         EnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735995523; x=1736600323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXH8tUP/h7NPxTwhkU8DrmHX10k3nPXxIbmClQOEn5A=;
        b=SsNbmPa7nXk7F2HIcTyuH3Sw27kLY0DQnJKXj3EfcNLjWEs3HuUB30qbHjhsD8yZaf
         4Bdq2/Xsoep050cAVe8qtAV7HfacQ3AvsF/HygSbPnq0Ta4CngO5R8UUNBDRyWt7aiBf
         yjh6gzQ40cB6gD1ZP0AKNja0OifuWNXpBaIpKjF9/Kb3DWG2U0xN1xrF8/6VycW8sMEg
         JlIT0dxV/ufGBPvnDNFrgpxoXOxe3ggkNC03kjcaoghR71NmOhQrArkm8yWjUfIgxJgZ
         mBwZJiKR6+0B0wkzcJvDgDbSbC7lenEEULVSHKaRQ190akiCeD6y+pl9cwpwUb4fyq4H
         NkKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWglnMPI56YDRIVZ9/9b6knuXkAV8eiR4rHx4WKhnOcooO2XUh9Wk0SFU+MmWU2Vemjc/CsXBfIrVydzw==@lists.open-mesh.org
X-Gm-Message-State: AOJu0YxjO8CYgDir0TkTQ0U6jx/DSMuhhdO1al2hRdHngb6xMWuU+oh4
	jSLHBHLwkOhYpwUqIYbPZofFSy9fTJL/AXlUOLu0lsgWOlDg+GFh
X-Gm-Gg: ASbGnctUwivmCDE7d+GZSpzpf2E/33rA+XdJU9C6g9lmBKTZEwxpKmpp4ktSvgnKpQv
	+31biSFUFp7rufiOTalofYIvbng4Sqj91P/tzP586FxLdigRuwQAdwyu79LmpBgU1xWKbOAME3N
	ydUBvmX/ICIuS37LQU5nh3VPqjuKxi4c8VuNNx7fpo8J+lRa1rcZ2fygOzwrYFVKJPTcd64aWgH
	ToTEfOq2Z2NpNgauHF774lc5SKCCuTE478ZdseBUC1juOc=
X-Google-Smtp-Source: 
 AGHT+IHa35PYbmCu1uOx6CEp/EQWjQpZHigmf2PgIvsgkyK5+Nfa2PQvUpv4CIvsSLNsXb9/anYWIA==
X-Received: by 2002:a05:6a00:cd6:b0:729:a31:892d with SMTP id
 d2e1a72fcca58-72abdd9603cmr90325957b3a.8.1735995523087;
        Sat, 04 Jan 2025 04:58:43 -0800 (PST)
Received: from ws.. ([103.167.140.11])
        by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad830349sm27761344b3a.47.2025.01.04.04.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 04:58:42 -0800 (PST)
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
Subject: [PATCH net-next v7 07/11] net: xfrm: Use link netns in newlink() of
 rtnl_link_ops
Date: Sat,  4 Jan 2025 20:57:28 +0800
Message-ID: <20250104125732.17335-8-shaw.leon@gmail.com>
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
Message-ID-Hash: EZVQUYFDFIY4PWAJG22Z3RKVV3NLZXX5
X-Message-ID-Hash: EZVQUYFDFIY4PWAJG22Z3RKVV3NLZXX5
X-Mailman-Approved-At: Sat, 04 Jan 2025 14:17:48 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/EZVQUYFDFIY4PWAJG22Z3RKVV3NLZXX5/>
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
index 77d50d4af4a1..d1198c63dd23 100644
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
 
@@ -819,11 +818,12 @@ static int xfrmi_newlink(struct rtnl_newlink_params *params)
 	struct netlink_ext_ack *extack = params->extack;
 	struct net_device *dev = params->dev;
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
@@ -852,7 +852,7 @@ static int xfrmi_newlink(struct rtnl_newlink_params *params)
 	xi->net = net;
 	xi->dev = dev;
 
-	err = xfrmi_create(dev);
+	err = xfrmi_create(net, dev);
 	return err;
 }
 
-- 
2.47.1

