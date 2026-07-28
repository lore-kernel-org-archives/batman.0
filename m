Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456ABC53219
	for <batman@archiver.kernel.org>; Tue, 28 Jul 2026 22:22:58 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 407788321B
	for <batman@archiver.kernel.org>; Wed, 29 Jul 2026 00:22:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1785277372;
 b=YlEjl8gOhRaRYuTrFTEqkF6Kw6mTz9qcm+zFmZkc1LXzof+Z5gvyzju9LBmPENTHNAEX+
 WcdlRnjughgQJAdpyfeyz+CXwjyKc4uvfJG/3iFqF537KHeGsTP+6JNrpoduu68/zdt0gB5
 ouNbkUBIT1W2j8CFbbTNEvTgnLsrILY=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1785277372; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=xrfOy2vV/JiOtss7SqyCbDZv4xn9FrZJhC39W708LDg=;
 b=N9iUekPNHwz8lYhNeDyEDPLzc4X1DzwNDPpvqgGXQpOZW14xM044RVu/di8jzml0877Q4
 YCxZaDgSlhyztU8mglBdMssLbWDtcrSQpY4EwxlIjC7+VA2k9sq+xOHdIWwS44GI3xop3A3
 Ea2SUs6tAv4rGIeo+Kh/YR4vbKbbIu4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with UTF8SMTPS id 481A083704
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 28 Jul 2026 19:29:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1785259758;
	b=YjfHgTR6sLXavG/ze1FACiWcWcEqSc8oBQq98bJXR6bcZ16QF7alnBt7MtoVeOd+bftZNi
	yzGEF/PzKvdWZ++NRCoo60gkrNQNiRWH/Wa6fsB5jZBKdDakU3VvfQAGnxqX8CZSc/+IeV
	UyJXqC4oHY3nNLsLk02mt8vYo/DW6CY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1785259758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xrfOy2vV/JiOtss7SqyCbDZv4xn9FrZJhC39W708LDg=;
	b=lBFpoe7exncESf5c4SCq2beqK070jUg/ExBbwRJ0TPJ/9qI4XNIOVK89ZffqWQiiHtmO+s
	wdcnOi+oYZZ6jgwK0Wt8se4CPxKgeFk5RzKvYaxFFeiaSKG63nPEkm1Guud2dCspD5weXl
	qbDY8ykPJdbAkiOO6+ok3M1YZrGlwQI=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=rG14iE5h;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 4EFBA200C7;
	Tue, 28 Jul 2026 17:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1785259753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xrfOy2vV/JiOtss7SqyCbDZv4xn9FrZJhC39W708LDg=;
	b=rG14iE5hyqH/i+2ioUDATByp1kBPvgRaBpAh+HbECs9VrLIvKrHqLbfMWSpxcL050N9P17
	d3sUHc7HrGqYqciSNiAEnIMNFEEl7lF2MM2dlV7HKzGQp9xd37xsGvHhCPJPlghCkAMMh1
	aAFyQ+7yXWwh+SL7xi3J2uvYL0/Xa6w=
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 28 Jul 2026 19:26:18 +0200
Subject: [PATCH 1/2] alfred: import batadv_netlink_policy from batctl
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-bugfixes-netlink-v1-1-d338671f316b@narfation.org>
References: <20260728-bugfixes-netlink-v1-0-d338671f316b@narfation.org>
In-Reply-To: <20260728-bugfixes-netlink-v1-0-d338671f316b@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8750; i=sven@narfation.org;
 h=from:subject:message-id; bh=tjNOEOOQY06SiQRM6qsAkEHAraai22doUrRjmO/28HQ=;
 b=owGbwMvMwCXmy1+ufVnk62nG02pJDFkZz6zleScdK4yuqurOP+I8s8BEc9Ueo+8STuybxC9qt
 09Yddqso4SFQYyLQVZMkWXPlfzzm9nfyn+e9vEozBxWJpAhDFycAjCRhx2MDAd3ey8UK1vziO2x
 /dWEjlXLk99u5WB8rLY+6s656U7dfgYMn9l5dt+Tl/GcLVT4waZl7YWi04ffu3tweFYy9r6oSQ5
 lAwA=
X-Developer-Key: i=sven@narfation.org; a=openpgp;
 fpr=522D7163831C73A635D12FE5EC371482956781AF
Message-ID-Hash: MTPQ2JH2OMSAA6LSO5Q5DFHKGC475Z7W
X-Message-ID-Hash: MTPQ2JH2OMSAA6LSO5Q5DFHKGC475Z7W
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MTPQ2JH2OMSAA6LSO5Q5DFHKGC475Z7W/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

The batcl policy is more complete and is cleaner formatted than the alfred
version. Just import then new one to keep them in sync.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 netlink.c | 277 ++++++++++++++++++++++++++++++++++++++++++++------------------
 1 file changed, 197 insertions(+), 80 deletions(-)

diff --git a/netlink.c b/netlink.c
index fe5e749..d2cccfb 100644
--- a/netlink.c
+++ b/netlink.c
@@ -27,86 +27,203 @@
 #endif
 
 struct nla_policy batadv_netlink_policy[NUM_BATADV_ATTR] = {
-	[BATADV_ATTR_VERSION]			= { .type = NLA_STRING },
-	[BATADV_ATTR_ALGO_NAME]			= { .type = NLA_STRING },
-	[BATADV_ATTR_MESH_IFINDEX]		= { .type = NLA_U32 },
-	[BATADV_ATTR_MESH_IFNAME]		= { .type = NLA_STRING,
-						    .maxlen = IFNAMSIZ },
-	[BATADV_ATTR_MESH_ADDRESS]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_HARD_IFINDEX]		= { .type = NLA_U32 },
-	[BATADV_ATTR_HARD_IFNAME]		= { .type = NLA_STRING,
-						    .maxlen = IFNAMSIZ },
-	[BATADV_ATTR_HARD_ADDRESS]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_ORIG_ADDRESS]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_TPMETER_RESULT]		= { .type = NLA_U8 },
-	[BATADV_ATTR_TPMETER_TEST_TIME]		= { .type = NLA_U32 },
-	[BATADV_ATTR_TPMETER_BYTES]		= { .type = NLA_U64 },
-	[BATADV_ATTR_TPMETER_COOKIE]		= { .type = NLA_U32 },
-	[BATADV_ATTR_PAD]			= { .type = NLA_UNSPEC },
-	[BATADV_ATTR_ACTIVE]			= { .type = NLA_FLAG },
-	[BATADV_ATTR_TT_ADDRESS]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_TT_TTVN]			= { .type = NLA_U8 },
-	[BATADV_ATTR_TT_LAST_TTVN]		= { .type = NLA_U8 },
-	[BATADV_ATTR_TT_CRC32]			= { .type = NLA_U32 },
-	[BATADV_ATTR_TT_VID]			= { .type = NLA_U16 },
-	[BATADV_ATTR_TT_FLAGS]			= { .type = NLA_U32 },
-	[BATADV_ATTR_FLAG_BEST]			= { .type = NLA_FLAG },
-	[BATADV_ATTR_LAST_SEEN_MSECS]		= { .type = NLA_U32 },
-	[BATADV_ATTR_NEIGH_ADDRESS]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_TQ]			= { .type = NLA_U8 },
-	[BATADV_ATTR_THROUGHPUT]		= { .type = NLA_U32 },
-	[BATADV_ATTR_BANDWIDTH_UP]		= { .type = NLA_U32 },
-	[BATADV_ATTR_BANDWIDTH_DOWN]		= { .type = NLA_U32 },
-	[BATADV_ATTR_ROUTER]			= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_BLA_OWN]			= { .type = NLA_FLAG },
-	[BATADV_ATTR_BLA_ADDRESS]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_BLA_VID]			= { .type = NLA_U16 },
-	[BATADV_ATTR_BLA_BACKBONE]		= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_BLA_CRC]			= { .type = NLA_U16 },
-	[BATADV_ATTR_DAT_CACHE_IP4ADDRESS]	= { .type = NLA_U32 },
-	[BATADV_ATTR_DAT_CACHE_HWADDRESS]	= { .type = NLA_UNSPEC,
-						    .minlen = ETH_ALEN,
-						    .maxlen = ETH_ALEN },
-	[BATADV_ATTR_DAT_CACHE_VID]		= { .type = NLA_U16 },
-	[BATADV_ATTR_MCAST_FLAGS]		= { .type = NLA_U32 },
-	[BATADV_ATTR_MCAST_FLAGS_PRIV]		= { .type = NLA_U32 },
-	[BATADV_ATTR_VLANID]			= { .type = NLA_U16 },
-	[BATADV_ATTR_AGGREGATED_OGMS_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_AP_ISOLATION_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_ISOLATION_MARK]		= { .type = NLA_U32 },
-	[BATADV_ATTR_ISOLATION_MASK]		= { .type = NLA_U32 },
-	[BATADV_ATTR_BONDING_ENABLED]		= { .type = NLA_U8 },
-	[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_FRAGMENTATION_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_GW_BANDWIDTH_DOWN]		= { .type = NLA_U32 },
-	[BATADV_ATTR_GW_BANDWIDTH_UP]		= { .type = NLA_U32 },
-	[BATADV_ATTR_GW_MODE]			= { .type = NLA_U8 },
-	[BATADV_ATTR_GW_SEL_CLASS]		= { .type = NLA_U32 },
-	[BATADV_ATTR_HOP_PENALTY]		= { .type = NLA_U8 },
-	[BATADV_ATTR_LOG_LEVEL]			= { .type = NLA_U32 },
-	[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_MULTICAST_FANOUT]		= { .type = NLA_U32 },
-	[BATADV_ATTR_NETWORK_CODING_ENABLED]	= { .type = NLA_U8 },
-	[BATADV_ATTR_ORIG_INTERVAL]		= { .type = NLA_U32 },
-	[BATADV_ATTR_ELP_INTERVAL]		= { .type = NLA_U32 },
-	[BATADV_ATTR_THROUGHPUT_OVERRIDE]	= { .type = NLA_U32 },
+	[BATADV_ATTR_VERSION] = {
+		.type = NLA_STRING,
+	},
+	[BATADV_ATTR_ALGO_NAME] = {
+		.type = NLA_STRING,
+	},
+	[BATADV_ATTR_MESH_IFINDEX] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_MESH_IFNAME] = {
+		.type = NLA_STRING,
+		.maxlen = IFNAMSIZ,
+	},
+	[BATADV_ATTR_MESH_ADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_HARD_IFINDEX] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_HARD_IFNAME] = {
+		.type = NLA_STRING,
+		.maxlen = IFNAMSIZ,
+	},
+	[BATADV_ATTR_HARD_ADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_ORIG_ADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_TPMETER_RESULT] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_TPMETER_TEST_TIME] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_TPMETER_BYTES] = {
+		.type = NLA_U64,
+	},
+	[BATADV_ATTR_TPMETER_COOKIE] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_PAD] = {
+		.type = NLA_UNSPEC,
+	},
+	[BATADV_ATTR_ACTIVE] = {
+		.type = NLA_FLAG,
+	},
+	[BATADV_ATTR_TT_ADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_TT_TTVN] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_TT_LAST_TTVN] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_TT_CRC32] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_TT_VID] = {
+		.type = NLA_U16,
+	},
+	[BATADV_ATTR_TT_FLAGS] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_FLAG_BEST] = {
+		.type = NLA_FLAG,
+	},
+	[BATADV_ATTR_LAST_SEEN_MSECS] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_NEIGH_ADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_TQ] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_THROUGHPUT] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_BANDWIDTH_UP] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_BANDWIDTH_DOWN] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_ROUTER] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_BLA_OWN] = {
+		.type = NLA_FLAG,
+	},
+	[BATADV_ATTR_BLA_ADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_BLA_VID] = {
+		.type = NLA_U16,
+	},
+	[BATADV_ATTR_BLA_BACKBONE] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_BLA_CRC] = {
+		.type = NLA_U16,
+	},
+	[BATADV_ATTR_DAT_CACHE_IP4ADDRESS] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_DAT_CACHE_HWADDRESS] = {
+		.type = NLA_UNSPEC,
+		.minlen = ETH_ALEN,
+		.maxlen = ETH_ALEN,
+	},
+	[BATADV_ATTR_DAT_CACHE_VID] = {
+		.type = NLA_U16,
+	},
+	[BATADV_ATTR_MCAST_FLAGS] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_MCAST_FLAGS_PRIV] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_VLANID] = {
+		.type = NLA_U16,
+	},
+	[BATADV_ATTR_AGGREGATED_OGMS_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_AP_ISOLATION_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_ISOLATION_MARK] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_ISOLATION_MASK] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_BONDING_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_BRIDGE_LOOP_AVOIDANCE_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_DISTRIBUTED_ARP_TABLE_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_FRAGMENTATION_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_GW_BANDWIDTH_DOWN] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_GW_BANDWIDTH_UP] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_GW_MODE] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_GW_SEL_CLASS] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_HOP_PENALTY] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_LOG_LEVEL] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_MULTICAST_FORCEFLOOD_ENABLED] = {
+		.type = NLA_U8,
+	},
+	[BATADV_ATTR_ORIG_INTERVAL] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_ELP_INTERVAL] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_THROUGHPUT_OVERRIDE] = {
+		.type = NLA_U32,
+	},
+	[BATADV_ATTR_MULTICAST_FANOUT] = {
+		.type = NLA_U32,
+	},
 };
 
 int missing_mandatory_attrs(struct nlattr *attrs[],  const int mandatory[],

-- 
2.47.3

