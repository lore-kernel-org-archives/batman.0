Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE3CC982CC
	for <batman-adv@archiver.kernel.org>; Sun, 20 Sep 2026 05:31:34 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id D0287840FB
	for <batman-adv@archiver.kernel.org>; Sun, 20 Sep 2026 07:31:32 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1789882292;
 b=PFJR4m0+WqxWVnKzba+L15wkkbjt3SHbfxiU/TFBK0BdyHDrTHIu30T9Z67htOqKHoLr+
 tUnvcpK3XPNXLvg1Q0D2B6GhEEtMO+6+pk3eVfkY6zwXbzm3C+NUrF6ETZOiRbn2pP4LmPf
 c4zA8NGCbTTpghsWi6BFbXvB8qjJVNA=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1789882292; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=uW/HsakILM4BTu9WVDkJIh5lipXXxrKv8v1jYeK8KV0=;
 b=WMrgKyf6vEA4oJe6nEeSYFfz+1SCh8uRfbjjuSZktb9zbvX3xWr9D/oc+chqMg45xYLmT
 2RGqBW49mUnpJ8mM8xf2s7sYTe3rqOOiypB377xga6khuuHR8m41Y/YSIp+/qp+vpNcsFuQ
 7vHy41pE9WQKJVUbS/S80DcXs0IqR1I=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=NXP1.onmicrosoft.com;
 arc=pass;
 dmarc=fail header.from=oss.nxp.com policy.dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=NXP1.onmicrosoft.com; arc=pass;
 dmarc=fail (Used Org Domain Record) header.from=oss.nxp.com policy.dmarc=none
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013020.outbound.protection.outlook.com
 [40.107.162.20])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E0DFD8048F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 20 Sep 2026 04:29:54 +0200 (CEST)
ARC-Seal: i=2; a=rsa-sha256; d=open-mesh.org; s=20121; cv=pass; t=1789871405;
	b=1cE+R0mWK7otaXJ0vYmHS+kkpVwCTOklca4h+BuBVwK/3ucA2UOAQse1SA9RhGX1/HCnyQ
	fJm3VMByiqnMSSRMIvGfSC7v/EIRHl8LXmK4yV9vIsD+ljVfhl1taE9xz/U6fIUbzP/VZP
	ADyYdmkoClqu8OpkPUEcs9vSOH/h8pE=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1789871405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=uW/HsakILM4BTu9WVDkJIh5lipXXxrKv8v1jYeK8KV0=;
	b=PrBtRY8CiBQHDF2nafDZToMOp7pfmTVxjZ/2CJv8k/p8KZCGZ5JSSPZYJgrGF/mQgBE1q/
	qfco68PKmljIdI9Qkstb9Gobl50qV3ZpSMlkcdT//rz/AKsAKipfO0TuHcLC9iEjRrQmOH
	598FMlTNlQLPLUyGrVJynhFEwbHvezA=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=NXP1.onmicrosoft.com
 header.s=selector1-NXP1-onmicrosoft-com header.b=THcY4P1C;
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	spf=pass (diktynna.open-mesh.org: domain of peng.fan@oss.nxp.com designates
 40.107.162.20 as permitted sender) smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JO+odjUs6fWw8XJLN4CJw5KjmEFQUaiHU81Ol7ufAI2qNHNzovhCoxuoYzn3pzy/XP7tAKl8n5UJVf4SL6ib/gA/4P2K2QU3ZnopMt8iLdVmdykh6SFYB01ESk04h5F+1WXbC4FC2sZMFqESfLMp79sJq7GF6TzxbGpow+KwEh1MQ9VCWNtoGxP8FYbMwiv1ArGUxZptu+TyaonCHPgFar11mwX4TBPbJdc9HpI7uDOvbIqHmzXtqwnNKVyP5azA3ugsShjMd5+6ijMFdSdJDixbgI87IKg3Peasr2R+QmLBFJCSJRv8La/3nKlhEhVvJ6BiybSOwnbub7Rc5F04jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW/HsakILM4BTu9WVDkJIh5lipXXxrKv8v1jYeK8KV0=;
 b=Gzqr97vQl9Ugb3DosIRSSCtPOtKLLxh18RXu/5Y/8IfPUCnrVdpUuVkrpY/vbGmvaHhLgmBpc2DFIPsZWE/oQStm45H4+Uqw4FpVLS2NP4c/MNsnzkzVfZQq99+chY6iQbGn/cSSNoosgDpOpsIV7MVr5htq9o+XbMaa5xDRcXJy4ziY9wYGeTjle0dpnqACOaanEsnv3cvILR+UlfZczX7s7fboxQ0DpfvpNPnr9vu5c/l6OVT+jSnDb+j31mKACCV3MQH/6NEAGg2rQAZUADxxXY8y/PjvoJQmNeLtHGsJapVlp6s9HQjWff3ZMWzE4dmGmrI216iqwJxr4+ieCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW/HsakILM4BTu9WVDkJIh5lipXXxrKv8v1jYeK8KV0=;
 b=THcY4P1CpX60xfY3i2ATC18OMhBGWrPNvbBuB2Gr3Mqs0gkw2tuz9rmfgKNz2TJI2KaHlpYgKaVnCONC0b9Ac1/ZlUfsMfjKS7+NB1cKb2ZZ3TBDDagMtZCulf1E6fVtxd/N1kJG/AgyDe6nalhULKkaTBZjscAEmPOXl8n0ludzkrAzOXq/rP82jd+8B6WWyeqwWZWKz6SP6lowwaipL/EPB7G4l2O61PvREesoeWY0z5uNRyFtLHh8zNKj6F41zW7J3KupS4ZuG2OEWeBIb8hm4h1OCS3EByYTx+fp0ZDVX//2ETsmMb5/HGDVM6R0zVDUIAyJ+NjGnqfq4t6u0g==
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PAXPR04MB9596.eurprd04.prod.outlook.com (2603:10a6:102:23e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Sun, 20 Sep
 2026 02:29:52 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0428.014; Sun, 20 Sep 2026
 02:29:52 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sven Eckelmann <sven@narfation.org>
Cc: linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>,
	b.a.t.m.a.n@lists.open-mesh.org
Subject: [PATCH] batman-adv: use assign_bit() where applicable
Date: Sun, 20 Sep 2026 10:27:21 +0800
Message-ID: <20260920022722.3145774-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI3PR01CA0005.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::13) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PAXPR04MB9596:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b9a99de-796e-4b6a-2278-08df16bf0d40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
 BCL:0;ARA:13230040|376014|1800799024|23010399003|19092799006|366016|18002099003|56012099006|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 
 NvvCjURX4WfCMr4oTvM3rqYe8tD+YXhRmb5EyrWsd5ebL7TIPxnBSolni3CUInTdv60++DgdLmFcW/VKQd91g2qB8sQ+EqbGqbdURYHG0Hdi74UOCfgBSllMgLwjJ19lTuP6k2YWysw1GUQsyNBIygB4hk54xF7JPpaK3wscTcGj2PmVYXk4as1ZwcAzriDOM+lsreXFSn3cw+SmyZUptDnBbktBdRtIBxRF/iGrJimVTvTGjbum4mbqnLS0RcSSr3AzOuH1YShnSgRP9JdHpvnixduraHcagg7BObe0d/DPcYCyca62cE015G6+ylqL+sLyYyjv1WT2gsDMMDMogOLPXnJFGEI2vmykRFJcnHA/NXERjzJAkscbY1mK79x3Yas6vmIKnQ/uDYYijTQii2+B1oDPYsf1Szj4PtXYAzMoK8nbKTda2MyRl/qdcMpmqyTDCIKoEZgOztxAyk0d+gHpXuHG6fC3uXHQkND5f9cDuZ2d+NZh3TdbyucWpypje3s8zVEmfifY2JM+xid5OoOVW5DnMNJIQD6eikD+9JuUNJHoUHN1BOvDorE8b1C9HKaqF7DWkpmK1pp9tkihdwD44yCnjhK89jF5y4ZUHxSz6CCfCpHxcqgYQhpasJ+s7wamKL0eKZE35/Wscbcj8IMIPa8b52ZgV1zzRUSi5S0=
X-Forefront-Antispam-Report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7874.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(19092799006)(366016)(18002099003)(56012099006)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
 =?us-ascii?Q?hHblEiwSI2YvJZ37zt5EekS5IbWRIv2cb2N5TsTjLYh/hbQxi8Er8n5U2Hwz?=
 =?us-ascii?Q?Me9OimLJDpG04NKvqI3zo1svdrT8GZScWMS1+qii2e8yYSt26yr8kdsUoInf?=
 =?us-ascii?Q?pX6LZMeO49MugMq0ppNE4L4Nkc7YXGncw5RsTPPId2SjsR0e0X/uZ4HRFfc3?=
 =?us-ascii?Q?C/Ju/+4hKRvLM2g6z4TvLIFggbrkhe3l+ss7Zt8tG/xy626cLB9nFOjuHQcx?=
 =?us-ascii?Q?6pdBGQGQyO1FVUUdQ/JKbenRuyWFSqzsmv0s/jctrm1y8QzlZzHqcA10MiD9?=
 =?us-ascii?Q?a1NEqjRt0kyQnh9Dt5QFjq136zkS0kGn2ik4YuoJAWllxXi8bCZWt7Tz4df+?=
 =?us-ascii?Q?aUR3R719zTV0g9gnBco0+ul+o5iexXJvZTbsjkYkeUY4TfGdm8Ld/a5AyF/m?=
 =?us-ascii?Q?m5WCb6IOwJdpjOvO5z16bxkff+JFJH+waYKzAkKyYbl8A0fJO++EvkKPDzSN?=
 =?us-ascii?Q?hQoaudzCYS2ZYldhDHkbQqUAAmxfgvtZqFqNeBntPqU0Nk2kKBw/bOLxNao5?=
 =?us-ascii?Q?3XceCIUbhXuMhXHZT4ndQPPSerrJ0FAuvZu39Du+61GV0dGxtrqzt0pyUUYe?=
 =?us-ascii?Q?D/lL2M/LGu5aQuJqPe1wRm9IoQWZ5p4Xv4cF0hzJkx2p/W1VvVDgd7dbzYXI?=
 =?us-ascii?Q?aveGOaPMCfcQ7GPuRsNmKtrGTUs0tOIHTl7bFFD3o0BgaoZZmCnPLqOWwldl?=
 =?us-ascii?Q?PXfkz3QRPEV7p2kUB9d+bpPlNkEmWd97Jrtian0Fif9fwlLyn4fMpxNeG94F?=
 =?us-ascii?Q?99UKVy/+IsMKQ4Y0Zl8/SfJOHMia8hh2Nhmy4LKH3S21mQQIlYlS2rQuUGy6?=
 =?us-ascii?Q?Wim84pTm6WuMrqOI36xZMrkikqEkJ0aqNBB4VkYnAVf+abk+QQOD+DE/QqQ0?=
 =?us-ascii?Q?DgpljcD6u487e6PUpY97FoRmP/RStiGs5B7EsZMMEiQiiDhLKbxXN4R3u5UX?=
 =?us-ascii?Q?ZEjXFoyMCrk1MjKA79xteTvR7kV4tLfs/fszZnFYUC9KzL30UUIrywSVs1o9?=
 =?us-ascii?Q?AwBtA/6yuahi/ahCvQ2ymGCUjgQuFB6l7Eh+oNKWjTJoQbtiof0hlcKmVf9t?=
 =?us-ascii?Q?PEHCAUl/rL95yK6P/yuSfDtU0W6zSQyn1URZm/D9/ZnRM/HHeJcTXGa84poc?=
 =?us-ascii?Q?TqIoi2R1ovjh7HVRLDNEEccaCt5X1fiA5EVBd0pVPt7gpG/RXmH/Z810lqEL?=
 =?us-ascii?Q?91qtg/a9VDmhFAU1dzNULTwB1ly9YYI9Mdi7/I5tTRKNfMab+GHh8GGtQTsT?=
 =?us-ascii?Q?5ITsSVmsFPe1m5jgcoJGKkQM+n22fNmKuNjU9k2f4qmnjX/08b2n0IFGIZJO?=
 =?us-ascii?Q?WqTc5lCLKoWAZ17vdRMhfwUrZ8ubILqcuC7/8jWd3hwxIYb52y4ZCE1KGOC8?=
 =?us-ascii?Q?rrS/1j6BoYmw0ptgelE71r8iuH+kOkpvagy3APJfDaQxt0rOBdZmICi0vbT8?=
 =?us-ascii?Q?9Xqjoi9d2w/KQYsN//nmOq5ybgbmv0Xlg+6729vRiTnRQgQe+b0EBWkv97l5?=
 =?us-ascii?Q?DZnGB7NqwHjqlm/4FWlKeqX6C9Nt8wEq8VDEj87B+tbpPP5oKD8YhX4Ih4Re?=
 =?us-ascii?Q?TLpdijF1B9zOV1UAcZVs3jdJHHzf6R4kGtZF0NI4jyTLsPGTH+t0xIWKeldm?=
 =?us-ascii?Q?ED+/6niK8Uv8WEmmQEmk/4jSZtShk9NLmbrBcIeBs3/upK2YK6bLhzwnF+rE?=
 =?us-ascii?Q?TFCwGi0AxrGfvSRtN9RIpyx6L/LpWev6rfHdreKco09A2khydIGP3w/Sha20?=
 =?us-ascii?Q?M+YT2NyfmcFURjG0zrQ5kxg8kQ3DjgqdEfHU97GZemXRn7z/rhRO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1b9a99de-796e-4b6a-2278-08df16bf0d40
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2026 02:29:52.7767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 UjT5q5HfozGGzoGOOewZFyTGOzukvnEX3BMae81zz8gcLHen69QRR4feMsA7YyQBnnu9UxzhhpP/Mb/7zFMqBe0s+OvBhw7EVM2V4OrtlgdjZVyGtxxsNdKVrG7uQIPb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9596
X-MailFrom: peng.fan@oss.nxp.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation
Message-ID-Hash: Q72UF4GZ4KUT5HUBHGTMILFY3SEUKRGM
X-Message-ID-Hash: Q72UF4GZ4KUT5HUBHGTMILFY3SEUKRGM
X-Mailman-Approved-At: Sun, 20 Sep 2026 07:31:22 +0200
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/Q72UF4GZ4KUT5HUBHGTMILFY3SEUKRGM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

From: Peng Fan <peng.fan@nxp.com>

Convert open-coded if/else with set_bit/clear_bit the assign_bit API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 net/batman-adv/distributed-arp-table.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index a4be5b2a87d7..74050bffedbc 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -863,10 +863,8 @@ static void batadv_dat_tvlv_ogm_handler_v1(struct batadv_priv *bat_priv,
 					   u8 flags,
 					   void *tvlv_value, u16 tvlv_value_len)
 {
-	if (flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND)
-		clear_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities);
-	else
-		set_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities);
+	assign_bit(BATADV_ORIG_CAPA_HAS_DAT, &orig->capabilities,
+		   !(flags & BATADV_TVLV_HANDLER_OGM_CIFNOTFND));
 }
 
 /**
-- 
2.51.0

