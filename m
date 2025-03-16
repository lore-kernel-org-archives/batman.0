Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E94C282DE
	for <batman-adv@archiver.kernel.org>; Sun, 16 Mar 2025 13:22:12 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8E344842D1
	for <batman-adv@archiver.kernel.org>; Sun, 16 Mar 2025 14:22:10 +0100 (CET)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1742131330;
 b=eF7ihhiCLDINBvx4t6JoyUtM/4jrjeZtvAiPMSxNzUhpkCxWlpZ3dxCuFmcotG3evoKXz
 k3T2JcOoI0sv0DsX+JzxED6boiwABVcYMPBkq9mICCi15MMX0KT6YSuj7RGpkoKEGxT12Bu
 NuX9T/anfHm/z+sY0f1fXpgvvlpEHfY=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1742131330; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=OqzTERfXgqZR6rbccARXglZTXd9gIVydkHGxvc8rOkc=;
 b=XgPj5ZLKV7GsJv/nf7KMRib8BuOFoQ6L5jCGIRSJNHMRQyE83o4nebbu1Di/e56BHL49s
 nOpCc04m4ZJlb3DH+eQun+psFsK6gnvQhc0ySHJWfgeET41Mw4LeV4m+TtS6KT/7O4AtSPW
 hR6saC1nBx0YZ6dAUu0t+TmJGhfXqpQ=
ARC-Authentication-Results: i=3; open-mesh.org; dkim=pass header.d=live.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=live.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=live.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=live.com
 policy.dmarc=quarantine
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn19011031.outbound.protection.outlook.com [52.103.66.31])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id BA8EF82273
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 16 Mar 2025 14:21:59 +0100 (CET)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1742131320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=OqzTERfXgqZR6rbccARXglZTXd9gIVydkHGxvc8rOkc=;
	b=Hw4qR6WHkoYf9VnO6TiZgT7m1lTtaEh5Y5VKbFuC61g1m+RXlH4gzv6MsSNfsldquNYvFD
	trEdUUCc8fF1zl+GlhIxydXm4rAcNSR7CqKGAbZTkiGEk2VW8zFjE6cCXM04uOvqQDQWcn
	1Z036orH598OSXqdI7FsMnKLPJkZSy4=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=live.com header.s=selector1 header.b=Wt4893jf;
	dmarc=pass (policy=none) header.from=live.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1");
	spf=pass (diktynna.open-mesh.org: domain of marscatcn@live.com designates
 52.103.66.31 as permitted sender) smtp.mailfrom=marscatcn@live.com
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1742131320; a=rsa-sha256;
	cv=pass;
	b=ulIHdAWLRmq2PLB2nzWx8TYT0XWDpSqEWIOYt7lg/Ymr1zGt9k9flQhPAdtXbGfv8njPRH
	Sb1aR6ZHBtW2Zcpa/MXxmvxUQ7nlQEIN0mapNvO2IGfVoBdsA+kuuhalLusBZGhs0BY1pL
	Kdf8flSoQH4vpCoGI9qC+DY++R8oeH0=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NX4zt2Vo0wrccNtLWyMl1bpnPjTUvGHhYu9dQH8sdfyT353ZelFSGv/Fmwn+il/e/PFwjWvN6863bbuhhZGrTy4t0+kxZ6mgSrBYwiP7PNrWnn1GYVv/B/afBqdlfneKKRXn2KL88urFq/CrcoIT/Ndnzciz4DxPvStQ0kjCt/Lbn/zMCepDECUk53N0c1K3fLVCY4PGXibburtlavFc6x2/JGJ29TqHaFVHYXcYSYapeXGhSmYjY76QaxaKBzQPo3k7C++96A3tOR7GUdiJNWpB1x7Co6dmgfJl7lpIDUAcwjkEPZyvtw7pKaeirf0I2YJkSocPMKG0qgVPTJadDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqzTERfXgqZR6rbccARXglZTXd9gIVydkHGxvc8rOkc=;
 b=pds0L38hSHmKYRd5CIj0DlN/Q0JjKTU1VMfeY5iImlA1RYp3lh5g1W7l/VkHIdCn1PlMLm6jkYWXyfZUYUnKJUeadLS+ujQUTd61orOdt/dHwy5TjkdPEbgO5dCUvYD1nGeqjeHMRdiCrp8RtFerl1Qn9lr3iJwRSyih7JyGntgsjO9ejee6OYBOpMyu01h2AZGHFtbP2GWk+cHCWwsfxW8L6aSIpZYAtdvpUMiKtDCkMZAFnmUZzt0SVbSG5el92BY+kxsp9j1vVMV+S3L2Q+UQFA+QjEPiCzgU1X7lHYpxaGiOE1DbVUy4nmLhZQAWcNop603ncbJWLhzUJ+5vHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqzTERfXgqZR6rbccARXglZTXd9gIVydkHGxvc8rOkc=;
 b=Wt4893jf5qDYc2zBqO1PHfNxqE+ExOe3K4ABebtRtrslVE0UJEE2E+n3qpkKcUsaBnA67ESXY4LI6EkkR3SF+qgeVhZwucjTWyhpCicnphKq8ecH/bWv0gc6w7C/PN484fVh8QDFD1bWpGaSGzToiaIPUmd91t4BPnwlRzwch1qAPhR+5gwpMQFSRwZ7qjdTLpNL1yChykehXyZJuyAXq4c0Czg5fKhnlvk6TaaN2JfVfdnQH810RP5ModyPjZbCEKZDSY7AH+CrqzrWikndyB4UEQkGhZdya7BLkRdKbu0JQ/Xtc5xrpaGLMlnO0t8vO7B+TzrDMkPFHPaLPubuOA==
Received: from OS3PR01MB5765.jpnprd01.prod.outlook.com (2603:1096:604:c2::14)
 by OS3PR01MB6210.jpnprd01.prod.outlook.com (2603:1096:604:f5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 13:21:56 +0000
Received: from OS3PR01MB5765.jpnprd01.prod.outlook.com
 ([fe80::74e6:516d:66db:2df9]) by OS3PR01MB5765.jpnprd01.prod.outlook.com
 ([fe80::74e6:516d:66db:2df9%2]) with mapi id 15.20.8534.031; Sun, 16 Mar 2025
 13:21:56 +0000
From: Jingwei LI <marscatcn@live.com>
To: Sven Eckelmann <sven@narfation.org>, "b.a.t.m.a.n@lists.open-mesh.org"
	<b.a.t.m.a.n@lists.open-mesh.org>
Subject: Re: Limited Connectivity in Mixed Wired & Wireless Backhaul
 Deployment
Thread-Topic: Limited Connectivity in Mixed Wired & Wireless Backhaul
 Deployment
Thread-Index: AQHbllneeJKvVjs6IkipuvKhZ8eM7LN1sb2AgAAIdp8=
Date: Sun, 16 Mar 2025 13:21:56 +0000
Message-ID: 
 <OS3PR01MB5765A0A1FC05309119C723C7D5DC2@OS3PR01MB5765.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB576553C5DACFE878AF2C6878D5DC2@OS3PR01MB5765.jpnprd01.prod.outlook.com>
 <8603745.T7Z3S40VBb@sven-l14>
In-Reply-To: <8603745.T7Z3S40VBb@sven-l14>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB5765:EE_|OS3PR01MB6210:EE_
x-ms-office365-filtering-correlation-id: bf9bb0b0-ed3a-4360-23e8-08dd648d8668
x-microsoft-antispam: 
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|19110799003|15030799003|7092599003|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?vlYcz9ZlJGV52gXSxHj1pJOh0mJs0X0SSDAcQ8J/rskySU6c96t17LxW+7?=
 =?iso-8859-1?Q?tkjoKexziWJdmu/MSURUi2nYqGVxUsCpXjuH7tp37idGvTkvFy+3DnY/tG?=
 =?iso-8859-1?Q?ZeEogEq/ShjeTPyIGEvyCD7W9m9fUEfYanVh3Q/Hca5rbqWZG+PJgPyyG9?=
 =?iso-8859-1?Q?gkBcBjEPeZtx/1oGYVHuPERMHgVT7nwQUZXel/CPAijQu+RQP8fvtJnJ5I?=
 =?iso-8859-1?Q?OJRATKVh1dBbz5Guhsi6uuEBFP4clojZoDTmysO+L3dDGk3kIB6TPk/fQC?=
 =?iso-8859-1?Q?u61cP70BOTjSPr0OlM4QGFWuyB94+U9KL0VM+MRhBqdxf/rv44aGqd2ngZ?=
 =?iso-8859-1?Q?xboiEJ2z46GJCT3EAL35+Ld+cLT8+k1J1JKf3O6dNAriW0xVYj139Oz21x?=
 =?iso-8859-1?Q?BVNtSOUrt40re7iiWpATSHkKlK1dF0ejn0ZTHBvlPAH/7kwLpZSuxR8NuL?=
 =?iso-8859-1?Q?bwcZNOLpJdYVAVRTQattGlsBxAPIwQvQssqEvXXKoosGVZsU19kC1RCE+R?=
 =?iso-8859-1?Q?yrdRRReoc3cqsWoXcJxkZLs4+YWYLqrbOMvFi/X1/Ql0d6DnOx71ZowOfS?=
 =?iso-8859-1?Q?V4U3L6IHuv26odBMvJnsdgTgp/4rFzbJmZ7r3cvu1qvmzoOcyQ+nhVOmwz?=
 =?iso-8859-1?Q?UkoRV55Kqc9AlqHvyReC6LMjX9U5ir3b1KhDy4lxXaJW/dcUMJvSsnySV8?=
 =?iso-8859-1?Q?qR0qQVzpM8fwBnjDV50mpyehYSm62TDXkDInQcuyMRxLFmP+ZY7ZUfnQge?=
 =?iso-8859-1?Q?MvNXvj+uKO2azuTYvB9CjU+jSNeCSsm+ZyujvI3g2GeZFwcYx/3LY/fLlH?=
 =?iso-8859-1?Q?iygEyaHnnUOEqYBRV6MWJErSrm+D8ANqeIURj5voPnrOzLMDGfHCyV+plY?=
 =?iso-8859-1?Q?WRIJJVO6kRF1ePOp+NBF9AbuDp2srZEgGZX/J6iqFXlhHSg9tca4SJBknk?=
 =?iso-8859-1?Q?2gSo9AM4i8zjq6EglfJ2AZC9q65JUO9P8gJSdq6c+p+g6I40XVlSyVSYrI?=
 =?iso-8859-1?Q?4oYv58w1qrxM1QDT2c38hbgnjnM0G0iWPuIsExf9L1joK8PRhnGIJ/3X1g?=
 =?iso-8859-1?Q?LxuJrlNtASFiVU/AIHsobqa+dSuCKMrz0tg5mbHWlSmvqEVzuR6pPiftNn?=
 =?iso-8859-1?Q?wtrq5wtD2fm1/qeAJQdbXzHVV7S+9S69zKGgJ/5Vz+40RdVKtxOouIp2fU?=
 =?iso-8859-1?Q?zeK/0rHXss+qfw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?ykJ4rFXf1XtRZHsQU2scXnHgsAt+KR/61FV3uKN/5gubl4tCkLsVBsl7tu?=
 =?iso-8859-1?Q?69XSgpntPwOR56gnf+SwLCgumlxnhfKp/aYK3M++YG+t3wcIFkTx0VSev1?=
 =?iso-8859-1?Q?c/qNiYO7bKgBJ6T3VbTn5HEbsqsXnHtrTNBGtsVaP3sx9cAD4C0ucw3I/7?=
 =?iso-8859-1?Q?qocVrV+fi8g65NI4VFR1MFb6F7aTkdte0ePpX8z1VpS9DJIZPNIpwAtlJ3?=
 =?iso-8859-1?Q?LEc/xQosRUt9RQ6uGCqoFXFoB5ICA4mSPUCCACKt7bqyfnnn2bh+Ea8ziS?=
 =?iso-8859-1?Q?tZLIG8TNybBX1O6hvZjz8g9Mk3v2qPlbf5IS4VnCcbLa+LlReM20LCuMBm?=
 =?iso-8859-1?Q?ykHMQ/XB5enTbh6k1RCFHA4apIXcEjnf7uzVX8GCXTK3IpQRjgxKUiMpVy?=
 =?iso-8859-1?Q?EaguLcSRqJ5L4vHbt6c0zWW15on0izRHLX1fzzbXAt4Q6HaJ1SZHZ1IKYR?=
 =?iso-8859-1?Q?Q9nyxXoKek3UeIJ95UD7aGDftBnJc3MjnQdnTvMUlAqDqAYvovgqpgAXMY?=
 =?iso-8859-1?Q?jTVQhY4r3pNnYiKH9P8qDvETPn8JMrzhJEunFTUErakYkEiTouBjYPnG2t?=
 =?iso-8859-1?Q?M0miruu4X8xOGQ+S7j36wgt29T4czwN7zKsxsR7KjGj9SKO761pJdM3rMc?=
 =?iso-8859-1?Q?ePtbQeSomxUpZq1+/MiFJQRof0lbIHNyIs5KPlYVhRSaMgC45ZPHCg8pnY?=
 =?iso-8859-1?Q?tRNeGvmOc9EvEC9W4IjmGWwEt1HcWcYR5DaEAPS6RrZ9TP8IsmDDHBiQPR?=
 =?iso-8859-1?Q?Ex/2G9T7RYK0lpFslKLZLCfLvrfdoB7yHBhMX5DVNFCG9JawVXWwLrFXNS?=
 =?iso-8859-1?Q?iVjiAQWH5DqJQaYj4k9LJCntz1KeesTExAcTNvYcYtTff7IBGH3C4RXMQs?=
 =?iso-8859-1?Q?M0lo7XltXkg09VWXOb1OX3+ohMYNOnDJJmhd3HXg/bSZUSzOdXZjkRf5NH?=
 =?iso-8859-1?Q?Z7A0IiXRE3TGXKo04ewns3yJzWVgDGgQ3z/QxkW/pCsPVqOuPVxuNVCIq3?=
 =?iso-8859-1?Q?ZFJbxkOMejktoC7Ho5+85fQMXevfOte8ZmukdrkW5WXcriBLzhzSzGu1E0?=
 =?iso-8859-1?Q?Qjv4iNUdN4+2O6XiAH7eLSv/paKZgs5f7PfPcCImV5KFvgPZlY5mwmW6a4?=
 =?iso-8859-1?Q?fvUt0Sxg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-15995.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB5765.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 bf9bb0b0-ed3a-4360-23e8-08dd648d8668
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2025 13:21:56.4095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6210
Message-ID-Hash: VUP2MWGLIFDHBHLAICL57XI5C6MATL2N
X-Message-ID-Hash: VUP2MWGLIFDHBHLAICL57XI5C6MATL2N
X-MailFrom: marscatcn@live.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/MOHVXWBANPTY3M7YQCCFGOGP5A52UJ2Y/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

Hi Sven,=0A=
=0A=
Thank you for your kind reply! I hope this looks good in your editor:=0A=
=0A=
   Router A             Router B            Router C=0A=
_____________     _________________     _____________=0A=
|  br-lan   |     |    br-lan     |     |  br-lan   |=0A=
|___________|     |_______________|     |___________|=0A=
|AP|  bat0  |     |AP|    bat0    |     |AP|  bat0  |=0A=
|__|________|     |__|____________|     |__|________|=0A=
   |lan|BHAP|        |STA|lan|BHAP|        |STA|BHAP|=0A=
   |___|____|        |___|___|____|        |___|____|=0A=
      ^   ^----WiFi----^   ^   ^-----WiFi----^=0A=
      |______Eth_Cable_____|  =0A=
=0A=
> Is router C required to see the problem? Because only router A and B are =
=0A=
> mentioned in the problem description.=0A=
=0A=
C is not involved in this problem, I'm putting it here to show a mixed depl=
oyment.=0A=
=0A=
> Is the ethernet cable connection required to trigger the problem?=0A=
=0A=
Yes, everything runs great until I plug the cable.=0A=
=0A=
I'm new to this cool project and not familiar with what information I need =
to =0A=
provide, it may take some time for me to collect everything you mentioned, =
=0A=
I will put them here later. =0A=
=0A=
Best regards,=0A=
Jingwei=0A=
=0A=
________________________________________=0A=
From:=A0Sven Eckelmann=0A=
Sent:=A0Sunday, March 16, 2025 8:30 PM=0A=
To:=A0b.a.t.m.a.n@lists.open-mesh.org=0A=
Cc:=A0Jingwei LI=0A=
Subject:=A0Re: Limited Connectivity in Mixed Wired & Wireless Backhaul Depl=
oyment=0A=
=0A=
=0A=
On Sunday, 16 March 2025 11:07:17 GMT+1 Jingwei LI wrote:=0A=
=0A=
> ```=0A=
=0A=
>=A0=A0=A0 Router A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Router B=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Router C=0A=
=0A=
> _____________=A0=A0=A0=A0 ___________________=A0=A0=A0=A0=A0=A0 _________=
_______=0A=
=0A=
> |=A0=A0=A0 br-lan=A0=A0=A0 |=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0=A0=A0=A0 br-=
lan=A0=A0=A0=A0=A0=A0=A0 |=A0=A0=A0=A0=A0 |=A0=A0=A0=A0 br-lan=A0=A0=A0=A0=
=A0=A0=A0=A0 |=0A=
=0A=
> |____________|=A0=A0=A0=A0 |__________________|=A0=A0=A0=A0=A0 |_________=
_______|=0A=
=0A=
> |AP|=A0=A0 bat0=A0 |=A0=A0=A0=A0 |AP|=A0=A0=A0=A0=A0 bat0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 |=A0=A0=A0=A0=A0 |AP|=A0=A0=A0=A0 bat0=A0=A0=A0=A0=A0 |=0A=
=0A=
> |___|________|=A0=A0=A0=A0 |___|_______________|=A0=A0=A0=A0=A0 |___|____=
________|=0A=
=0A=
>=A0=A0=A0 |lan|BHAP|=A0=A0=A0=A0=A0=A0=A0=A0 |STA| lan | BHAP|=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 |STA| BHAP |=0A=
=0A=
>=A0=A0=A0 |___|______|=A0=A0=A0=A0=A0=A0=A0=A0 |____|_____|______|=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 |____|_______|=0A=
=0A=
>=A0=A0=A0=A0=A0 ^=A0=A0=A0=A0 ^----WiFi--^=A0=A0=A0=A0 ^=A0=A0=A0=A0=A0 ^-=
----WiFi---^=0A=
=0A=
>=A0=A0=A0=A0=A0=A0 |______Eth_Cable_____|=A0=0A=
=0A=
> ```=0A=
=0A=
=0A=
=0A=
This is completely distorted in a fixed width character (editor). Is router=
 C=0A=
=0A=
required to see the problem? Because only router A and B are mentioned in t=
he=0A=
=0A=
problem description.=0A=
=0A=
=0A=
=0A=
Is the ethernet cable connection required to trigger the problem?=0A=
=0A=
=0A=
=0A=
> Problem description:=0A=
=0A=
>=0A=
=0A=
> Router A (192.168.6.1) and Router B (192.168.6.2) can ping each other. Th=
e client (192.168.6.192) associating with Router B cannot ping Router A and=
 its associating client.=0A=
=0A=
> I also wrote some simple rules to trace the data frames in each router, b=
elow is the output for a ping from client associating with Router B (192.16=
8.6.2) to Router A (192.168.6.1):=0A=
=0A=
=0A=
=0A=
At which point are the packets dropped from client to client? The "trace" y=
ou=0A=
=0A=
showed me looks like output from iptables (or actually its kernel part=0A=
=0A=
"netfilter") - which is above bat0 (and therefore not in control of batman-=
=0A=
=0A=
adv). If you want to figure out something on layer 2, please use tcpdump to=
=0A=
=0A=
capture packets on the various interfaces involved here (bridge, ap, bat0,=
=0A=
=0A=
lan, BHAP, ...) and then check what happens. You can analyze pcaps recorded=
 by=0A=
=0A=
tcpdump using a somewhat recent wireshark version=0A=
=0A=
=0A=
=0A=
How does you bridge loop avoidance configuration look like and what is the=
=0A=
=0A=
backbone and claim (table) state?=0A=
=0A=
=0A=
=0A=
What is the content of the translation tables?=0A=
=0A=
=0A=
=0A=
Kind regards,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 Sven=
