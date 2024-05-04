Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70951C4345F
	for <batman@archiver.kernel.org>; Sat,  4 May 2024 17:15:13 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 87E0F8217E
	for <batman@archiver.kernel.org>; Sat,  4 May 2024 19:15:11 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1714842911;
 b=GxgdPDFYc3XpU2JgpfCHX8G8f0C0qSseWWkjc1i/uTzMZIgQM+Mivivglx2X1Cp4DUmrj
 Yv5u4Pcm0JmZupWaLbx0/nUDfXXE4u124n7ShZCzD2LyBjzMMtVaE8bS/6KHrN+QfAdWQ86
 2rl6Ce0IgQVnJkXOwOJIu61fDSHIAVc=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1714842911; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=cw8nzKpnOVpC5LmgD+kJADa5w994LoR5bUQd6sq39Mg=;
 b=QS4cxHKN6dPDyNJcEzL0OPnUPTvo+Boe5VoINDhpKmcyzNiQx3omLXr+mCVWtG1HJ/ttZ
 2vrraf2L1AJUEdWGmptNZEMO6XYE2YkefzhZY6W+JI+3hAzoUBKDVC7ooPa93xVw495gchh
 6kutUW1bQjnReXyXMQUU6wM0cLO2s1E=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=outlook.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=outlook.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=outlook.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=outlook.com policy.dmarc=quarantine
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01olkn2053.outbound.protection.outlook.com [40.92.65.53])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id AFF0081210
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  4 May 2024 19:08:54 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1714842534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=cw8nzKpnOVpC5LmgD+kJADa5w994LoR5bUQd6sq39Mg=;
	b=wx1s1AfSxZIRtomsJoAL8m00H9Od4wpIokpLvA1d4idKAZL0X1LohDXFfsVMXujh/hHnVE
	TNRk22XSKI6dpY5P7tmM7vrXfQOVyI/mV1HUBrrdb69Qsh9vw7yRabQ0sJ4sxgHIa4xGY6
	sVLDZ548T4zR/lXKxnOYCwyjYxABZw8=
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1714842534; a=rsa-sha256;
	cv=pass;
	b=F1+x9vMan99Xfhgb3j4Efo5ROZuR9Igi8g5lMhoF6d0owQjvW5Dhf570FbkO5JBfcMG/BW
	BV5m01BGG9juX1xUo3H6NB1VAk8SAtWncIcZtEo48+P/CqpdDIW5CL8bZ1eLBl1auFrbv8
	z6G3LWRCi3DWU6LruVAGYR4wzmhca4k=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=hdBezUaa;
	spf=pass (diktynna.open-mesh.org: domain of erick.archer@outlook.com
 designates 40.92.65.53 as permitted sender)
 smtp.mailfrom=erick.archer@outlook.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1");
	dmarc=pass (policy=none) header.from=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3gpbNwlx6Km71646pwqF+4RxeBY1tFpGcMFGwHnyEfJcqhzgxlaZ4t/4ToYYdYksHYX9DDLg2AwokkyQVKQBfRpLaeu54e6gge4OeBMKND+NUQYBAC5H7/H0YoNyff7zV4tdTFtZXyQL+BRUXwYlke1PXJumZrCVLYfr+R8+uUzGKksryafPLMCJ5dyE+0BzHkAGvQIcHe//n7PfIXk+0GGuX8r/MUUwVyhpGJOyyOTvdIwXXnD/v6hXXSyMlgBTnWI7EVxqoNFQT07HV3IsnVLzcHhOdtuWIYSGluJ2Ei7PydnYq/C2bfcjecNmyJAB6qS9UTkyf1A5k5VauVufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw8nzKpnOVpC5LmgD+kJADa5w994LoR5bUQd6sq39Mg=;
 b=ktFF17cZIc+zTFmv4Dy40THJURLeMWe7uwWwuq77TiU+C/lXr91/Qaf0/xTiDEGmTrbX6Doc4vMpVGjeNZPzkXIiTnqBaD9AB19K1zDhnvNnPWcqrTnWwehywwbpDGgLYAheTMU+IYQskh89lb9DN6AucPAELzfpbFadl1v+Mbe6cMY4i2Dpl9bIJuBbGiQUzxsZzrZvrsuV6YBn2UAvsENRmVAK7GJu/4DY/s0Jihnq+DirmPCha8p7EI9hAslVlsj6ZQ5BAQmxis7oeGB3ElYbOxgFWbxZqqkMk4gen9H+X24jMERjnHpym/OTPiHr+YTjzkgvappc/LFu84zRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw8nzKpnOVpC5LmgD+kJADa5w994LoR5bUQd6sq39Mg=;
 b=hdBezUaaNcdkP1o/PMekE0JV+A1y0opkJ1b4fccpMnkWDR0B5lP7oeBPSw7YaNPEWBvimXHQsh3BbHojC/m9Iif0uqE/P3oOApJyuJvFmrMhXVhPxknOwq9YyUiWHBvpRc2P8075yWI9J9BelXmQdXV7GMN7wPI+p3261yaljJ1sQFAc5qYDJtCMWMhjC1/kkJoLwVZOr1yA8kOdcF4wLqnt0lt3lYh/vh89HZmsYgRJxgEUBV0vcLeuz58mFEkOsPlnRdgKnixtdqLLuhZ4LLuQj80EbrWMqxfpfy5bt2FituOONxcdHJoWOLIm479p2M5r614VXD0aFIv9zGyTvg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB5PR02MB10070.eurprd02.prod.outlook.com (2603:10a6:10:489::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sat, 4 May
 2024 17:08:52 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.036; Sat, 4 May 2024
 17:08:52 +0000
Date: Sat, 4 May 2024 19:08:39 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	"David S.  Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@outlook.com>,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Subject: Re: [PATCH v3] batman-adv: Add flex array to struct
 batadv_tvlv_tt_data
Message-ID: 
 <AS8PR02MB723738E5107C240933E4E0F28B1E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: 
 <AS8PR02MB72371F89D188B047410B755E8B192@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <3932737.ElGaqSPkdT@sven-l14>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3932737.ElGaqSPkdT@sven-l14>
X-TMN: [QE19YAEU1vCHNCTe9yt0HLsdoXKNn/cq]
X-ClientProxiedBy: MA2P292CA0026.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::12)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240504170839.GA3490@titan>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB5PR02MB10070:EE_
X-MS-Office365-Filtering-Correlation-Id: eae39119-7b43-47e7-6299-08dc6c5cdf00
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info: 
	bEi1YuNpgg+gE7nmCzg7q83ItAooLKXjJ5ftGYwihf8eTxawv6f8HpLh5ojK4wipcDExPah6TJEa1M42YzGTnWcmbew8f2oPBtJbP9ULGQVtiNAkqdkWDhtSv+4/q8ZBWODGiDsmb7E+sVqgHOaCrGorPTUGwMgGPVaKr3ob42ojbNNf/Eq2tYTNWESCNTU7IVB1bR9SF4o+XoZ5LRZ5Mgxy3h9nwcvxTY/oxaveq30cqbp1WXLqFTyGdnEuB3pvaTOcZ9lrRCMlhCqmdDrDU1rX6oCm9makQbrITSJRWibbM4EeSvrc+YbqjYWEpBoxGOSSiFTsKu253WBwJnvMoEgmXiOkIjkbVyI3ZRgYgT+OsBX1tQgT2kj5SpraXxmA46vAwO/3s7p1/wJinpbyNg2VioeSmkY8bk7eH2wzAYFhAl2mnxgug9wD1z8eBX8MaNbSUvNF1BMuIcOqTw1kMD76UeBpCofteT0X82e+ukJB4w+mHDLxyThZIn3+xMkEBmskyvP5y3zo3877wCPSa1zkp5WcJCt/iuL6kGAMLoYg6FtDwUI1dLdLFG9YdC25QiAufAl+tMoG3YPGENpDPHSsYeXrlGxbK97ZNkW9uuncMTfeuHIEnGSbv3mbXI4P
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?A2KDuKhXzzvdnmZzLYMMcsvi/I5S+4bP8SbQ1VW0QwvaLR0w2u2BktHv+fyO?=
 =?us-ascii?Q?nOHv7BC9vfFvoVKFQw9mdQypxQs90cqlDFkq4e3dCyGo3dazFjaWBEqQOkm3?=
 =?us-ascii?Q?GUO93SuKhwlJBFhF+y6MeYozQz1oJtL7YuLkRWDeRN7Odk9cFKVEqqfHFSd8?=
 =?us-ascii?Q?jbXDFc+xN6idVgode0wPmx6QWG1Vil+jAKY90WKpWqmZjHPFkEg5mv4DcwrZ?=
 =?us-ascii?Q?Two1B4rC9rWF4wz58NTPo3Gtt6no9u+sUOTzs/H8wvOObS8l9OT88GdQboWu?=
 =?us-ascii?Q?EHxD5iVpWRlZBMbSFbz+07VCi/NUbVoaSrvNoakSn4JU66OvZ5JWYkmRNFHd?=
 =?us-ascii?Q?AkY2jDxL3GHCd3fm40RQSdnZqZtw+GX65C1uQqB0+mTjTLxw9TVgKSnIFIRJ?=
 =?us-ascii?Q?ifAN4dHN/pkeRyktvtNL6VF2sg3l+5JKj5zNEnpR5MyqGJDYU9R11qGhTqGZ?=
 =?us-ascii?Q?xQHdfu7fYgnMm0cKAX5VG6E0qqhwvsuKMKKkqpM6L28Tqk+Pxj1ZDybNQmJv?=
 =?us-ascii?Q?lvH13KpqWyEKdjwO5DpBYzn765yrHpQf0ySscaYOoaiLikbBFe3jSbk5KY1S?=
 =?us-ascii?Q?lGucH1zIc9mWiacg4Vq6/hJPmC5daXfMk1olIsnz+HtlwR/LbRZQ42d8JXld?=
 =?us-ascii?Q?Z2O7c0tao8AZplvhy3vbYfk42Z5Fm7tSZX1VoxCst8wAArSwmKCbPkLThO21?=
 =?us-ascii?Q?0zcQW1Pj6x1yxN2CFqEof8abEWh4cEw9NCIoO1T+b7fsEFE/y55CJgag+VGO?=
 =?us-ascii?Q?ym8ukTm+m/8FhTlw4bhYhRZRFSDo3Jo2i/z/QQw7fiaCzuLznbm7VJe6lstw?=
 =?us-ascii?Q?KZmlRv3GVmMw5D7SEMaHfAh744kdMRw4jJrq5jUcirL/WA8WLqowHqel9VSf?=
 =?us-ascii?Q?qt4fjJQcLOmGDb0DLsa3zQ4mCYIrFJqrhoMBrkYYK8eLCb3UgBOc3SDjiFoW?=
 =?us-ascii?Q?uqympyP2kLb2pTvcUq4l2wpe4lJwH/8Dog0xmHvjC/WpQtXJUAw34oDl01OH?=
 =?us-ascii?Q?10+HHm3t+OSJx4pidCxvx77GftNrNQJqc705FZsxEuGGmSg0koQUewb1oM9r?=
 =?us-ascii?Q?s4UszanKY1lCqp+oMoi2syf1w+06OFcmgqEuDFNq/zi34floNkysPviTcumE?=
 =?us-ascii?Q?oH1BAlk5eEerRKlaklgnxpbCjmfpDgJsf4Yn6aQpUD2+cgmHCJBlCXR7qLIz?=
 =?us-ascii?Q?NXNi8sqCBJHa/NAgKpEcLKjGJOX7906asBhwIVTcpYNh2mzmIRoTkoBv24Wr?=
 =?us-ascii?Q?1ZevmYiV+OTJQy2tWouf?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 eae39119-7b43-47e7-6299-08dc6c5cdf00
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2024 17:08:52.2295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR02MB10070
X-MailFrom: erick.archer@outlook.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: FEW43HY54TAL26AADKZGZVFRA2BQOMGM
X-Message-ID-Hash: FEW43HY54TAL26AADKZGZVFRA2BQOMGM
X-Mailman-Approved-At: Sat, 04 May 2024 19:15:08 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/RDH3RXQZEOICRKZJICZYQRHWMHK3V2O6/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Sven,

On Sat, May 04, 2024 at 11:35:38AM +0200, Sven Eckelmann wrote:
> On Wednesday, 1 May 2024 17:02:42 CEST Erick Archer wrote:
> > diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
> > index 6e25753015df..dfbe30536995 100644
> > --- a/include/uapi/linux/batadv_packet.h
> > +++ b/include/uapi/linux/batadv_packet.h
> [...]
> > +/**
> > + * struct batadv_tvlv_tt_data - tt data propagated through the tt tvlv container
> > + * @flags: translation table flags (see batadv_tt_data_flags)
> > + * @ttvn: translation table version number
> > + * @num_vlan: number of announced VLANs. In the TVLV this struct is followed by
> > + *  one batadv_tvlv_tt_vlan_data object per announced vlan
> > + * @vlan_data: array of batadv_tvlv_tt_vlan_data objects
> > + */
> > +struct batadv_tvlv_tt_data {
> > +       __u8   flags;
> > +       __u8   ttvn;
> > +       __be16 num_vlan;
> > +       struct batadv_tvlv_tt_vlan_data vlan_data[] __counted_by_be(num_vlan);
> > +};
> 
> Thanks for the updates. But I can't accept this at the moment because 
> __counted_by_be is used in an uapi header without it being defined
> include/uapi/linux/stddef.h (and this file is also not included in this 
> header).
> 
> See commit c8248faf3ca2 ("Compiler Attributes: counted_by: Adjust name and 
> identifier expansion") as an example for the similar __counted_by macro.

If I understand correctly, the following changes are also needed because
the annotated struct is defined in a "uapi" header. Sorry if it's a stupid
question, but I'm new to these topics.

diff --git a/include/uapi/linux/batadv_packet.h b/include/uapi/linux/batadv_packet.h
index 6e25753015df..41f39d7661c9 100644
--- a/include/uapi/linux/batadv_packet.h
+++ b/include/uapi/linux/batadv_packet.h
@@ -9,6 +9,7 @@

 #include <asm/byteorder.h>
 #include <linux/if_ether.h>
+#include <linux/stddef.h>
 #include <linux/types.h>

 /**
diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
index 2ec6f35cda32..58154117d9b0 100644
--- a/include/uapi/linux/stddef.h
+++ b/include/uapi/linux/stddef.h
@@ -55,4 +55,12 @@
 #define __counted_by(m)
 #endif

+#ifndef __counted_by_le
+#define __counted_by_le(m)
+#endif
+
+#ifndef __counted_by_be
+#define __counted_by_be(m)
+#endif
+
 #endif /* _UAPI_LINUX_STDDEF_H */

If this is the right path, can these changes be merged into a
single patch or is it better to add a previous patch to define
__counted_by{le,be}?

Regards,
Erick

> Kind regards,
> 	Sven
