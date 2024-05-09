Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F58C10F1A
	for <batman@archiver.kernel.org>; Thu,  9 May 2024 18:00:33 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 7993E825FE
	for <batman@archiver.kernel.org>; Thu,  9 May 2024 20:00:32 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1715277632;
 b=mXo3NcqTf9KoyYBWjYsGC1qh57rLc1tLAuoSt6ocN7lrZd6Z0fmS6iBfgvUI0UJw5V/yO
 xNJCm3/XXJF+6mSIc7LwAqDr2yuQF65As3LpH318dPM3S2v2lm5nNi1LlXQAx96/2IFSxSM
 khETf9DZZ59JCnKUUNcHG9O52PoLWcU=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1715277632; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=rrsJRKTXIQk4+neYibaCVbd+r9P8rhMWu2sijpM1grQ=;
 b=almWGJZ/c6qF728j2ivMnNVkGRJnEtWyat9pSy399MDxGH5ZtAcWi4GL2BcX091MEgHSx
 4PlKKcofpTLeb9cCrSMwYCLcSjaNhyTd3a0bg6aO9pHy06E3T3TWBVu4XUJtY4HXBk+Pbps
 5M8zN2WMevINxEutsfyC5w6IyIQHf+c=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=outlook.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=outlook.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=outlook.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=outlook.com policy.dmarc=quarantine
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04olkn2109.outbound.protection.outlook.com [40.92.74.109])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3E85581B32
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu,  9 May 2024 19:17:58 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1715275078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=rrsJRKTXIQk4+neYibaCVbd+r9P8rhMWu2sijpM1grQ=;
	b=QbOI/zF+uLX+bt0mlu5cmhnV1axnWepre/3TSQIQnvnqG5o4xDABZyYsRebpXdJ732aNzu
	ekXOdFHOtWS4zBNKV4hPTfkFXpTSJ9sBHzoLG0PjK9tCHtodjiaDl7IF9fYiCPxPP2S2o8
	YJ0qKd3elLbaI3a8COuV3VL/CuHa6AY=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=outlook.com header.s=selector1 header.b="ow6wK/3b";
	spf=pass (diktynna.open-mesh.org: domain of erick.archer@outlook.com
 designates 40.92.74.109 as permitted sender)
 smtp.mailfrom=erick.archer@outlook.com;
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1715275078; a=rsa-sha256;
	cv=pass;
	b=VlYz+qTomI9QZvprD1M4Jows3FYyXBDl66QLQs/fO10fBOM2adDxI6h8owKqWDC83nh6Yl
	wz4yUHzmcN5vj+0FYQSSiXhXHHwS0Gt3GeSxOcaxcAhvyVENMERPjfI+BmL7X+fr5riDSS
	laAU31cLoR2vAcOZ0BZg8AySXrciAyQ=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7Ru4T1u+xt/fuDRIbOohlJgUOHx3yKoGpqpcZEB7iddWLn8LI6bmwcZNaA3QjwG5UZYzuijj0QF+rfLPgYjm0K3J3A36eyMXvTj12E7dab3n9IU68Bu4AeK7KUZ0f+N+/DcHYuxAZUicfnsT972ti8Qj+I90nuMAQRlAptfUlfZXw7LzaJdwH72qAt+JQYwkznEfljrqBJNJXUd7/TTt0nWQK/vmTMcPwbYnI4d+Avdbe3TyVXH9Sn7afGb3L3IGHM6KS6tOC4SRums9fRVOCT0gpSpJqu2HvrWoupmry8UK2AGMIjHjfhBxcTwhOKRRp0TIve4VJWD9rmFwyVQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrsJRKTXIQk4+neYibaCVbd+r9P8rhMWu2sijpM1grQ=;
 b=WGa643n5TWrf1PMb3EXlUOGyNsVgZk0Hq9bXCgmspy4tU085r31w8mq+hvfuNa+uf/abcdEq/mnYcD05/aoBzAsBHQEBcC95iBuunymMf3wb+j8rAvvzJFkBIwJiNgH7QgAqq4Oev5dLyYIerJIC6HaFEI+6seYAOb9k4l3/gSnTQ5qk5viMdauZMDrtawMneGbYiDcz3VDyZJHkIJxbBJMptj/29k4K8fSX3E6HGY1Nj86/UbvvmbBDcRD/quB3hx3u4gbzxjT7ncm4wSUPb2dP3rtFXyGTi20S/+OZXjnsIjvbCiLPL1FF/hbxHqGDsceXTPvLIko936pcwVyHmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrsJRKTXIQk4+neYibaCVbd+r9P8rhMWu2sijpM1grQ=;
 b=ow6wK/3bL59iEO3RnUpmTwGvwjhd1je6sWNos8KaZ90jbucHuNPc3GjQbujBBxRNGOo3OeEdczwCj+1UCM2sJAKgZoX0eWekVzkAxk/izUTYOlZk9Z0YYdt58fTXhsC9d6rqJawWQzy/CMCgbFZKNMjHoq5m3Vq6Cnmrx2D73rfBXR6UBZ8/fe9m06iThickZTWATOlpqFnaK1TL7w4zqLjbl3WdcfwJwogojqjWX/KXDoXR/D4YAuZQNhSQ6VkFxjRqTdQGqLdm2FCwNvLr6u+rA2v3+XCbpL5dyMU+jbRw79AlsBTHP5ON+tOOVQCPL6QoNi09aQdObiqYkdtN1g==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DU5PR02MB10565.eurprd02.prod.outlook.com (2603:10a6:10:518::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 17:17:56 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.046; Thu, 9 May 2024
 17:17:56 +0000
Date: Thu, 9 May 2024 19:17:44 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Sven Eckelmann <sven@narfation.org>, Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@outlook.com>,
	Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	"David S.  Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v3] batman-adv: Add flex array to struct
 batadv_tvlv_tt_data
Message-ID: 
 <AS8PR02MB7237F77CAF0B49E99A10B9058BE62@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: 
 <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <3932737.ElGaqSPkdT@sven-l14>
 <AS8PR02MB723738E5107C240933E4E0F28B1E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202405060924.4001F77D@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202405060924.4001F77D@keescook>
X-TMN: [6D+r2sXm6nW37D6JLqn/jgLKtGmx9LX1]
X-ClientProxiedBy: MA2P292CA0010.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250:1::9)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240509171744.GA10465@titan>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DU5PR02MB10565:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f64e4e-eeb2-45a9-c626-08dc704bf71e
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info: 
	sqTg3ayHnzDvKIzSodDNsV70U/TMDC8gUwfsBwjDSoY9PartJlRp4WaiT/Ra8pV1CqvESsiNS/jBP21ZtsUYFiXUVfYxV1Up54QlqwdbeCbPCAiG1hZt8BLPmdddyRPJmbmWFH1wjwO7AyLu3NF4XTvu5foWTuBkTntXuwGuwRuN1eGZ3CI1b2swkrTQMEGXH91L2C/fGoq90tXHm6Y+9JKLfP1Je31uF8uNXA/Pz6Vv7Ryqi22bUW4tvzppQ8L1UK4Nj/nsj7ZSd/bf1/eno8E/C8f4D9KI2EKiuK/i4qE25Gs7CcU+IO2+SqGjkVOjM1k3SyYVjERZhyReXrGkzI7AuyvYVZEXzB8UNBYclJzoVwx2eatmDAaPmvPWPrD7l0CChsw7EDL0guC3M4ZLw8RhFJL/NoDy7zgYFOH3AkpEZXJc8DqZTcfmfOEvvi7D6Thta+vAZ0mWHHWb0Bh9Lz+e7vORoDGl0qkPJ5WjLvJOB+APnHmU8zWDpR3r4z/pEdT5afCZNcPCpLU3dVJi1zm3RxYL+zO1eBNyupxWkDxdo1fh9BkNaaubjo+rD36puQFsActn1qZRH7RYoR9mTyNN9+AbLfyWArBq0T5I144X8/C5MiHTYsB45BA1BllV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3Eq0bKrl94SOmI8mPK1OVvgNB9sfTWBMm165Ms+Bwea0R84BRJ451XqhP7Vf?=
 =?us-ascii?Q?dIThVdmAfc6h/PyxMAj/IWnu93CgWevLb3j5waqHL61lJd0xpuvIcNktcXUA?=
 =?us-ascii?Q?6tFQnH5Mp77orNWaZMu1FZdZmLVs/upfVJy25uarmnkAu0l4ebug1J+cTY8i?=
 =?us-ascii?Q?5qrEtX6W9XJHnOh9FH74sz8TG3DB53hdRnu79XoO5l5ozogMdTzFH2k6w20V?=
 =?us-ascii?Q?Ua3MroX/aS6+sac+MOQ1diD3TBKIVb3oYdgzBnXdhpFvRXUQXtzaInNTCsgH?=
 =?us-ascii?Q?34Z7vy+07x9uZ1q47zFf1NxRt+2WLayTI+MiEX3B9qdYoun1IPX2wksnKA83?=
 =?us-ascii?Q?Y+Qu3WHtbyhNURr9lgrER+zx3GNhal55bDISfFR8o+F1krFC7WWh66R+W14C?=
 =?us-ascii?Q?tTELiV5805lEC52+E4vtQ7S4XWYq6GBeS9oWsKOqFeWe5wwkLiBFHpA0v773?=
 =?us-ascii?Q?dP6KaNiK5lEXnsZOyiZljePSFa5Qhn99znVffPeg8DtAs4OjIJdDFM1GCDXV?=
 =?us-ascii?Q?zlGkUfh84LrZUcF+6dLE5jI5xnKPGrKPru7mzt7zJgpn3qIOIaSndC/QpbYx?=
 =?us-ascii?Q?++/hl1xAOxqx8MSy7875hWfOyhLXSixBykwMGxqmOCwicHW3tcP0Ckr+JugQ?=
 =?us-ascii?Q?CpwJOro2MuzgY/HNKfSv8TKzTHFUTJfZCFVYflIIpaIr63EChkfKP4yuUFO6?=
 =?us-ascii?Q?4auAN++dqw38SPkhjxns+pb1zt3qXtG4u5sXKBK2R09i7axw2iSga+FfyX7a?=
 =?us-ascii?Q?yfhRBW/vHVuy7mK8WDktiiMOQTCaW4m+h0DzTFVueDAvOKg1aWN8hg/ZKE0o?=
 =?us-ascii?Q?dV6R9ywxDNZqu6KxnEfpQ4sd6QVDicoGVpa90xEqRi8fym5RqByNu2vVcGPu?=
 =?us-ascii?Q?vp/ZAZj4r6rod58+K5JJbWpp0uNCdK7lKwCD4HzCNdTH4oWFfJRp519h9sFJ?=
 =?us-ascii?Q?kow+VMi5xerWUbcOGeQEuMj0nOcuE14h8WZA/h8GoIob91VyaKMfgYw7AjNR?=
 =?us-ascii?Q?4eq6pnhBQJ0X8Iui/qJWDCsAaUSy9TBLhBxCMLlFZ0crLocPyxjTAK2V6mSw?=
 =?us-ascii?Q?OGaByK85Cgs//9PrVYvbbwG7TcwL6WAlBxWBZSM6TRIC7IcjT8DoWY48sKe5?=
 =?us-ascii?Q?DRDegn2t4bN4JX0CKL60St+Iq0X5MJ4YevBTt0Ew33yV/85l96hcAofPqgrJ?=
 =?us-ascii?Q?631NYsmIryt8pYpObk/dqxEYoGx04iXdoQOei5vpFBEJMj2kbCxSNmt20K5R?=
 =?us-ascii?Q?k4zG4GzVDT3BEZI7TKJh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 70f64e4e-eeb2-45a9-c626-08dc704bf71e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 17:17:55.9135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10565
X-MailFrom: erick.archer@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: IMVOUMZWRFLWIQ5QUA3Y7VWECVMXZC2W
X-Message-ID-Hash: IMVOUMZWRFLWIQ5QUA3Y7VWECVMXZC2W
X-Mailman-Approved-At: Thu, 09 May 2024 20:00:07 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NZD4TGR4T3CF3HFJYKESDOVYUHQTXB53/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Sven and Kees,
First of all, thanks for the reviews, comments and advices.

On Mon, May 06, 2024 at 09:27:46AM -0700, Kees Cook wrote:
> On Sat, May 04, 2024 at 07:08:39PM +0200, Erick Archer wrote:
> 
> > If this is the right path, can these changes be merged into a
> > single patch or is it better to add a previous patch to define
> > __counted_by{le,be}?
> 
> We're almost on top of the merge window, so how about this: send me a
> patch for just the UAPI addition, and I'll include it in this coming (next
> week expected) merge window. Once -rc2 is out, re-send this batman-adv
> patch since then netdev will be merged with -rc2 and the UAPI change
> will be there.
> 
Ok, I will follow these steps. The patch for the UAPI addition has
already been sent. When the -rc2 comes out, I will resend this
patch.

Again, thanks,
Erick

> -Kees
> 
> -- 
> Kees Cook
