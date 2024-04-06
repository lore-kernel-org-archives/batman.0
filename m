Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1DD0CD1284
	for <batman-adv@archiver.kernel.org>; Sat,  6 Apr 2024 17:11:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0EDE481A71
	for <batman-adv@archiver.kernel.org>; Sat,  6 Apr 2024 19:11:18 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1712423478;
 b=vao+nZ/rC5pX1iNpHE1vuQ/qFYWc5uhlR4hsrsTk88odFZ4SuRT37erfH6Z1jSNw1w+CB
 tXLutdj23u7TEDtzOu890/xcHPsuNCEgLBut1Yo1PumWhmadN5HWY50EeOwIZhBv2zwSBkD
 TLG9MZi9YvqhGa7bZNQUpRgiNFdIyrk=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1712423478; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=UF2zGeEp20pZ+g+ruR/Y/fUPN2XB39IWhALwuoEmqXc=;
 b=k/sSLbopDGJKWxaz3gBZjt/8z4OzJf3OrgG5qT/68xlDojX2WeHul5eWjJvelvH2UGwid
 hVnv8TD8y2bjK39pgh4TFEP7+ZoiKvgCcYdEpmt4QP5g9kIHSkXStPiIF4h+Xss3Ioiofvb
 8wuZbHL/51rwCRR6uZGQhu66IzdyXOc=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=outlook.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=outlook.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=outlook.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=outlook.com policy.dmarc=quarantine
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03olkn20801.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2e0e::801])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 9DFC580C84
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  6 Apr 2024 18:46:26 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1712421986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=UF2zGeEp20pZ+g+ruR/Y/fUPN2XB39IWhALwuoEmqXc=;
	b=v7h6rGnpPTKJOKvQwP3juxk0saRQgtD2vj7dvxgB2KVxv5bT3s2l7Yrqjc3rL6NHdh0b62
	eJeCOnJ3jJaaudYDkHhC8Pp0Pp9kw89QeRpuz33PBGJcYFHH7djx/pM/U7utH1h7IUdxs1
	w4xEvD6O6iXx65DdgSXqvedDUofnxOs=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=gizgIDXY;
	spf=pass (diktynna.open-mesh.org: domain of erick.archer@outlook.com
 designates 2a01:111:f403:2e0e::801 as permitted sender)
 smtp.mailfrom=erick.archer@outlook.com;
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1712421986; a=rsa-sha256;
	cv=pass;
	b=M7qVLlxRw2TpY8foE8smb4uawag/KEE/xmdM7SXFTCFVEoG26M6c0bISmiwqWbz6HmRiYG
	cR5+0o3GOtCCizoSdZ3vb2HfAOUCNV+mKA5FMN92kMkWqu+VfgHaj0B5iSEn9M34omlZnX
	xLdBkwIh+rO3x1XvjXO38RO9MKv5ngs=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeF766Ckn84p3HE0IKvtwOALsdN+f0za6CDhPFbruUQe0AM6SJcT2yvrbte4o2CjocjIY+ca4XdnlppiyX87/htQ8ua3NK41kMOK5eyhvpaiA86Mv26s54vxhxfqT1Gj2zxBesWi645sqdrs5uaw4GJ+vhgwQ7mxEvV4L0oZjSCrRyWWsONpRoBcwgMbiz7hPRfwqeaoSMskZfyRlqhiO1EaH4UQSkBfmGPaSg8rbcFgggp71LJvUhLSk/bWkcZYO7Te45BzIEL1+Td5qRNDjUKzchIRauMjx05YIvGaG/EQ9wDCKw3v3G/mDMNe2mrKRv90Z8Lsh5PhbkKPXWWCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF2zGeEp20pZ+g+ruR/Y/fUPN2XB39IWhALwuoEmqXc=;
 b=MCP38VGA7Ftk5fOF2Tkt0/GMxJdVqXwCuSHx5hTcF1yoLNn3td1OZ8cgEyGEOQ48F9uXvdEvYHKAqLu/+pW26mogGjhO962Wv4XnC6jp+J1eej/FOV4JxgtpgBBDt1KItWqFGVWn2KIW0pOtzwWnGqerrWh7XfQ91y/UCf2gU9+rMNngRUJbfOBDyMdMAqZx4JnlAbsD+0NbPBjTK2y8FN9P8CaXCUisldz/a2o0/GTZaZnP6ggO613QMhAd23drY/nx1BodBrOL39D4fTGhaMIcEEy5xX/OW5utma+GnwhTSOJf7IEWZG2pWQLZbkfmBLMCRisD8R1bj6Speoi1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF2zGeEp20pZ+g+ruR/Y/fUPN2XB39IWhALwuoEmqXc=;
 b=gizgIDXYuFzWm85H/poPtD9rY0lfwRwH9YC968EwYDNw3qeDluwaD/KUjl9a64iOOXXOedJMn9JQzDRh1CqBHfWo6vu4gnf6PJA24neoOaxBflkTxDyzwVwB9rNc7wcXVqdFb/h3IPX2U/R9em9WcvtLGb27zX5CV693OC6Nvk3HYT9eqWQulQpmW9DcMv21VGId0qhT73XtWXip9esmac4UJKhP52469WNLeLjpSatiyQlF80dg2B451FbtI4pKgilRfGvyKBYh7+5I759aZhBVutF0AtndV3VMqArW6lo1ZYcTyqe0EDAY86wTN8K5BQeNjTGcd+jsLzldPNrkgA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB8PR02MB5771.eurprd02.prod.outlook.com (2603:10a6:10:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 6 Apr
 2024 16:46:23 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.049; Sat, 6 Apr 2024
 16:46:23 +0000
Date: Sat, 6 Apr 2024 18:46:11 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	"David S.  Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@outlook.com>,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Message-ID: 
 <AS8PR02MB7237161B8D17F83F0A31467F8B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: 
 <AS8PR02MB7237987BF9DFCA030B330F658B3E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <5466543.Sb9uPGUboI@sven-l14>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5466543.Sb9uPGUboI@sven-l14>
X-TMN: [B/2mQTnMSx/9dfbusV7bQx2ESxCQQOMB]
X-ClientProxiedBy: MA4P292CA0014.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::7) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240406164611.GA21322@titan>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB8PR02MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: db0b8e0a-a757-4698-89bf-08dc565917bb
X-MS-Exchange-SLBlob-MailProps: 
	vuaKsetfIZkROEo2gJaqbzokFpX8aXM6DNmNUR/0rxwggsJctEeOogq2OeF011FdJL+4eq562zTEHD78Hq1QKoXS46511zfbZfpB0GD/c2AivYT/fY54oa4JzWdSyq83cLKFgcKXjDGMYuYRe1cY3fuRbDIE1gZWJ3xDuyVbe53UwlLU5I33DCnPi+sqQomMLswhaqSa1Cwac39DcZbxmVzQAILkVmmRwasbZff45vGzxOKIgfB1ryyVRxIV6PBySe7TYckH1IZ7MpqSX2wIqJg/wKINUm6m/Wi48++imS0rKds/s9BuHID1V332u6nTR1V8q9fdGfS3RTH9b7xMUuv1M3+9ladkz2L+TOXPzpaZv8Cgomq7ND0gMISGyEYOuH8DKJCXupo7rPLUn1VveRlf16rKNpNLOe5/qaxbzgVIWn0Ywmq68axwj8MFnUcLrAOnwM2Qa4b9VDWHXV0zYtey5uLK4eZdVuIdxGp2/ahqVrzDlDyKiSyNqE6qCegYGHStLejVdPqaj61AkoglP7kaXCGrPzV+Jx1Bw0LMq1U329/TBeC7IOSH9mJQWINlcXyT7MEA8yqZMQf/2PJzH0MdJkAGg0W2gQ2zVqOOxF2rIIOAmzzt2rKpytxwy9PJw1ex5vcFMj6VCmVSJpqqXrM32Qjqa79QhhMUtjbnNULs+sCY5JG2VTVYvEQa2RYODBlM1qp3aZS1rUpBWuEqFuq2yANMMojWd9QRKss0JY8Cn7NjssA7txb48kuPKK2/AeVv2Cs4O0pL3/gPl/kS2OxBXY0dqg5OJJNj/oRH2ALfZcYzbg0c5uNcwYwvJIj0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	VebbSgdsyIe4DVKeU8GpE6fShD4MGDioLQxg8TdFO3astpbzQfPfFtc4wdVh2C2wOjwx9VsQlyvj+NQ2VqO2pge81CdsqoziDVTIpiKtgfHgfGHXN92meA6sNK3+AlXFEMH/v1f6aQtmSB4xEzDsXJVwbAuZZEN3o7WFFXuVuEcTA8Fq40YfXJmIaY14jD89/U/JgKEIjv7fXCIXF01EbDQUgFFUKmsMxAgdd0sCDpFWuQ3C7tkIORLitPiM9SCbkhEyf+sGJrBAYJDCzzy/mHgDos15grU4Jq2Ucr6vp4weJU9aOo6A2hf4qWYdrh7aUk4PQBnch2o9jJEqzndsD+p+bprGlfwPfEqphTh3NVw8nQpWvkEQKZfxpkER8bLnw/2gjfay/XO3pjFPcQN3lKY3VDsLL6QwO0njy9+cEjLe0SgURbl+7sH2GWJyw+I//PtGl8dGWM9Ea4pQudcJM3bZlXdP9qy9EHPfNvl1HjTaEkWGaOtqdLxlVF4IUZk1i7V/IoTxYU7N1DtkqhbN5jqIWJLBgWznHFyDYAMTaBtJ+Zif3t8Ne3N87yInhA4YDzxzuk1Eq1lE4b28S6dcSGXaYSEbFCed5QlQA1Dqns1jSQX7V4EtgbwwLEI9EcX/pnJPsAdGI9AwCvV02XLHlgC6VInxII4lUdoSIqRe486OksDfCXY3inpwifyS1UkgTKOdt4KZwkamA4y4Z9qWag==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LUFvAlSbFT+eyc7bEa60mJIC0bu8ikvBIUkw0dfp42t9YQufdBHJWGYEsE76?=
 =?us-ascii?Q?+01BPdzhpyLIzn4bQFi6w5WcwauIs35/B3+Kef3JJsbyIkBqfVGpSLwiQR4r?=
 =?us-ascii?Q?VcqiYz61frg2DH2H7lxbOolIoYWqzV+Kl3VVh1oK2zNFUbNp4UeuAcfI8+HV?=
 =?us-ascii?Q?VRNl99I0NThICtz+ptu+HYgGEQYDhLBGYmhbsugmvYhYyc4vykmMoM2fwd04?=
 =?us-ascii?Q?iZfm1TViVHpMejOEMijw3BdqU59rasrrVDEC67XQjYiAHzLsExxCp2QsetB0?=
 =?us-ascii?Q?qGvyd+nlMUQ44bATNEiiEZHBmzrGgxdQNrwrnjH50OxOt+iQK/mbjNjDJliZ?=
 =?us-ascii?Q?SGFf5E5OZuKvhnFDzql0Onv/mYi1fjzvfQ3YDZgvirvdTQpluJZRcy+IHxtJ?=
 =?us-ascii?Q?Uof7Dtyghjr3i+BIO21Kx1qiWKmdk0AVp9AOV46qnTgixp+BXO0RM6h3rsaV?=
 =?us-ascii?Q?6rESR8W8tz8J+lIWCHqESc6/K5xfYMOuvqFT/mAY5QdgJBGbDq+O1vz39KwN?=
 =?us-ascii?Q?DtRE9gKIhdAmxEQiuWYIeqaj+hcccYadAqJHSWvYIABUXszogSou3bokJ+H2?=
 =?us-ascii?Q?zo5Tw779r/PkbuIYoocgkiX/0dHlgFIGc7V8ICyU/8VvBI9efPXdkia4rrvY?=
 =?us-ascii?Q?cfigUwposXW2ZPKtTwr7P9FWh4SK2iqx4UN1Nf7YBaqNa53nbtaWrdFJVXRC?=
 =?us-ascii?Q?uw3PeXJZtavq0D+0INYqFrqF2bs4kh+zwKWrOa+xL1ZqBWVmIFgfvhabj/tE?=
 =?us-ascii?Q?Y9rsQYEaR/wW31oeQ1yaF8w6NvpOqfmyM3rJt743J1C5iUaEuwZB8WtbK7wj?=
 =?us-ascii?Q?WEnVWiWa23NhFVbYt/qlURHkMoghvoqsXGJEH4rZBMheuVMwce2UszvFuFKn?=
 =?us-ascii?Q?gA+YAmsvKkHmuTVpkzuI5ojNF4J5PqEFs7rWp3lx0+kE66yUFqazcRDWmFAC?=
 =?us-ascii?Q?QlC+NZjbLWexLUd9hxXG+cwqMTFjBdL2a1zWUaCbVl85PDRqd52QnFcp1Ful?=
 =?us-ascii?Q?kwiT2dDyRd0HlBYomCy+UwscC2Zm1b15u3Lu72J0q0lt85MLdvo6y/wL+OSN?=
 =?us-ascii?Q?JK6muFnewpXeXkcAboVizLIFZ5feYWATHsJnrYhIxJBzOXb4V3ksjWjdlUlw?=
 =?us-ascii?Q?xPCKxhCXG9VShldPnJAwBMATlvy8nWz3pFxud31BBCKLZPXkKhj3h98P8zgw?=
 =?us-ascii?Q?svwY9rYJ1CjQdBV9H+2ASuLGR9Haidg0kWEjrENnwUFBK0QVX2Lb5ShrGQ3f?=
 =?us-ascii?Q?LSYIumHio8BhUWpGzcF3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 db0b8e0a-a757-4698-89bf-08dc565917bb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 16:46:23.2362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5771
X-MailFrom: erick.archer@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: QCHDHNFQCWYEG5JIX3LF6PY6XHCJHVR2
X-Message-ID-Hash: QCHDHNFQCWYEG5JIX3LF6PY6XHCJHVR2
X-Mailman-Approved-At: Sat, 06 Apr 2024 19:11:12 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/UFI6EAMSJOFFB35OFY6XWOFXG3MXO3RW/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Sven,

On Tue, Apr 02, 2024 at 09:06:35PM +0200, Sven Eckelmann wrote:
> On Tuesday, 2 April 2024 19:23:01 CEST Erick Archer wrote:
> > The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
> > trailing elements. Specifically, it uses an array of structures of type
> > "batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
> > declaring a flexible array [1].
> > 
> > The order in which the structure batadv_tvlv_tt_data and the structure
> > batadv_tvlv_tt_vlan_data are defined must be swap to avoid an incomplete
> > type error.
> > 
> > Also, avoid the open-coded arithmetic in memory allocator functions [2]
> > using the "struct_size" macro and use the "flex_array_size" helper to
> > clarify some calculations, when possible.
> > 
> > Moreover, the new structure member also allow us to avoid the open-coded
> > arithmetic on pointers in some situations. Take advantage of this.
> > 
> > This code was detected with the help of Coccinelle, and audited and
> > modified manually.
> > 
> > Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> > Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> > Signed-off-by: Erick Archer <erick.archer@outlook.com>
> 
> > ---
> > Hi,
> > 
> > I would like to add the "__counted_by(num_vlan)" tag to the new flex member
> > but I don't know if this line can affect it.
> > 
> > ntohs(tt_data->num_vlan)
> 
> 
> Yes, num_vlan is a __be16. I could only identify the kernel-doc related 
> scripts as consumer. But maybe they are more - so I would defer this question 
> to kernel-hardening.

Thanks for the info.
> 
> And with this change, I get a lot of additional warnings (-Wsparse-all)
> 
> 
> cfg: BLA=n DAT=y DEBUG=y TRACING=n NC=y MCAST=n BATMAN_V=n
>     net/batman-adv/translation-table.c:574:21: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:859:25: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:859:25: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:938:25: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:938:25: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:2932:16: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:2932:16: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:3378:21: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:3378:21: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:3982:30: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:3986:27: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:4026:30: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:4030:27: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:4032:23: warning: cast from restricted __be16
>     net/batman-adv/translation-table.c:4032:23: warning: restricted __be16 degrades to integer
>     net/batman-adv/translation-table.c:4032:23: warning: incorrect type in argument 1 (different base types)
>     net/batman-adv/translation-table.c:4032:23:    expected unsigned long [usertype] factor1
>     net/batman-adv/translation-table.c:4032:23:    got restricted __be16 [usertype] num_vlan
> 
> [...]

I will work on this for the next version. Thanks for share these warnings.

> >  	num_vlan = ntohs(tt_data->num_vlan);
> >  
> > -	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
> > +	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
> > +	if (tvlv_value_len < flex_size)
> >  		return;
> 
> This helper would need an #include of <linux/overflow.h> in 
> net/batman-adv/translation-table.c

Understood.

> 
> [....]
> >  /**
> > @@ -4039,8 +4029,7 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
> >  	tt_data = tvlv_value;
> >  	tvlv_value_len -= sizeof(*tt_data);
> >  
> > -	tt_vlan_len = sizeof(struct batadv_tvlv_tt_vlan_data);
> > -	tt_vlan_len *= ntohs(tt_data->num_vlan);
> > +	tt_vlan_len = flex_array_size(tt_data, vlan_data, tt_data->num_vlan);
> 
> This is definitely wrong on little endian systems. You first need to convert 
> num_vlan from network (big endian) to host order.

I'm sorry. My bad. I forgot to add the "ntohs".
I will fix it for the next version.

> 
> Kind regards,
> 	Sven

Regards,
Erick

