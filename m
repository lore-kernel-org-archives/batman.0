Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C69DC02198
	for <batman-adv@archiver.kernel.org>; Sat,  8 Feb 2025 09:50:08 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 8694883F35
	for <batman-adv@archiver.kernel.org>; Sat,  8 Feb 2025 10:50:06 +0100 (CET)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1739008206;
 b=uemUs6DiehF6xHjnPgwtrzxtM8a3+lK8qDh3QwessJf0eY2Jo1PVz9YkydYekX3htvaEU
 RKaFNMvLKpU7ISoptPLjOI6qt9YhZEhP/XnWrzLphG5ZJ/8YIOEWPQ8ZbVHU+d5f3N/yVOi
 LkAhGM78WLew1XrSCz+H/oe6wLnASrM=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1739008206; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=05vlvaazxLJUFO9NuLcTBErf6vFOlFPIpmxds7Q3KkE=;
 b=sDxyFmcdO8U6WWVRaTiPUCgkOof1q1/DVUjrCBqVTALfI4gYyOwmg5QGIgm3uwPgJ4Mko
 TzkNNI+a++yh68KTO+ggSm+7wnSJmu163WONcdjN28HXPx9ZQ7A6U64QjsWP5fOyxfxUPF/
 Gu9/6aOLxPc3sNDiaAZ2lZNorjmN4AE=
ARC-Authentication-Results: i=3; open-mesh.org; dkim=pass header.d=live.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=live.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=live.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=live.com
 policy.dmarc=quarantine
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn190110000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d407::])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 6AEFB82F18
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat,  8 Feb 2025 10:49:53 +0100 (CET)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1739008193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=05vlvaazxLJUFO9NuLcTBErf6vFOlFPIpmxds7Q3KkE=;
	b=JVgRoEAkB1kc02ylSYZRG/QUnRGJDhXq781wOcXAAM5qOsjbRmVH6896EPSJTAKHi91F2Y
	jg0NxNvTiThBBF14N1RjgZN8DgNGSHPHQ3auIyjpShp7AhTzj5Th6Lk7EcVA/6HJA1Q4tP
	DfDrvGkDCFhgPL4Yv80g/wr13/kWP88=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=live.com header.s=selector1 header.b=u7FbwjhQ;
	spf=pass (diktynna.open-mesh.org: domain of marscatcn@live.com designates
 2a01:111:f403:d407:: as permitted sender) smtp.mailfrom=marscatcn@live.com;
	dmarc=pass (policy=none) header.from=live.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1739008193; a=rsa-sha256;
	cv=pass;
	b=QCOcn3mwKubrZE5VDRnsYujmRJA9XxySv6V4FuDKHSCmPw3lVLfvikJRaXhvWYJbf550Np
	wUNBApmcOv1jTV0qbQA6EjopfKhfDfLYryCgYt7Nv7Zks9Hr30UnteAB/NOgAVVfZQsdhF
	fqbMmCyz3Eo2l87wpFv/cnoX8b2jn24=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cV0nU0KdIEPTiTxww+hYlWxd77d66dfD1y9eNuq0sXlI4K4ReuIyPeOZA0d1OT3wYvvGOPEJlWzxrTVgOpiRXX+9u2t8gcYgl+uW9jkVeRgx74M0zMPr06SvGlh/V1uTSyGZQeKWWGMxTwPOpSqyJPQ+xCm1xX8wgd/G/YnTEofVySwGZKjNR7wwxYLlHniHAs80c35JOes+7VS2UNtbAC4rJHi4QQHKg2NPMXlo0PjnSQkbFXib8EF4xV9TJWGTFwMMeFGYXMJZ4UFyicVOGSSkWi/e0ODVHMglToC6Lc8ML+8jyQBWW0QTXGdkg1cuYSuAL0zmOBmJMs2z9qb2yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05vlvaazxLJUFO9NuLcTBErf6vFOlFPIpmxds7Q3KkE=;
 b=UQZ8EL+2yYQhbko05nkDqgn8TJMUSHzLdg2t07rfnk/qQV9Voggrs8GTk17rWHEh/fjH6PeQ1sD7FIRN2+AKVxjkrutQMW2kTbUtckQCzi/qPCTLumOwAV4aoeTVqMH9YI4w27/ihTJfJcbMj3yXReRZqsywMacWyMXCMvvUPoiSv6XI5GWWvoFbC6Ph7dXkUfLzftEocc0UrOsrliJTrCr8xtRbIH+ticTMssoecFHg3UCbqffJNpmRCrM708/BwqUPjW6du20P3l2EYPvQ/Vvs/g8P1GdU53M5U+OOacw4sludYGAacYfEirctoXFyEJj/atwkjdw9k9gzgOiL2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05vlvaazxLJUFO9NuLcTBErf6vFOlFPIpmxds7Q3KkE=;
 b=u7FbwjhQePGw4w5GeEMYN4mqm3UqY0No5cQ4YDAdUgn1aLMkzH7Kdq2ONqgC+kQYZMND3MMu8j2P1h5ERdLujBFok2Ru5BO2HWegvFH+QPDq6jTwCDGHF0F9QtA+zeAyy5BUjxYe3zYll0PMVTQfv1xPP9104DOJk87IHew8hYxa8Q1c1yAJOjIVBRRiwMC1YuNPM7x5EXkVwjnGuu+c/LH8Js5xrw1A9oUbHFntcPMpfZKxucvfjx2K8G7C8MCSAMt3rDXKj8yfIdbzwbyLdxWNOyIonDG++eRGLx1APQ9+gv18eDFfMxuocuBRd43ybBnUKC83D3/KwF6wgohDHQ==
Received: from OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b2::9)
 by OS9P286MB3883.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sat, 8 Feb
 2025 09:49:49 +0000
Received: from OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b5c7:27ce:7810:83a0]) by OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b5c7:27ce:7810:83a0%3]) with mapi id 15.20.8422.012; Sat, 8 Feb 2025
 09:49:49 +0000
From: Jingwei LI <marscatcn@live.com>
To: Sven Eckelmann <sven@narfation.org>
CC: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Subject: Re: No Connection Between Two Specific Nodes in a 4-Node Network
Thread-Topic: No Connection Between Two Specific Nodes in a 4-Node Network
Thread-Index: AQHbeWMUvFYhgrIcQEmpOcNolon6ULM8NHKAgAD1dQw=
Date: Sat, 8 Feb 2025 09:49:49 +0000
Message-ID: 
 <OSZP286MB151066BEC04F25B87FA416B9D5F02@OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM>
References: 
 <OSZP286MB15101558B02308C9DDFB940FD5F12@OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM>
 <2365930.ElGaqSPkdT@sven-l14>
In-Reply-To: <2365930.ElGaqSPkdT@sven-l14>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZP286MB1510:EE_|OS9P286MB3883:EE_
x-ms-office365-filtering-correlation-id: 3e52a70c-5558-4822-defb-08dd4825edce
x-microsoft-antispam: 
 BCL:0;ARA:14566002|15080799006|461199028|7092599003|8062599003|19110799003|15030799003|8060799006|102099032|440099028|3412199025|10035399004|41001999003;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?YTMgjQ2n2QEoITzzqpcc6P2iS9c3o4W4GbN3ZrxbLLqH8lH2if52G82Ism?=
 =?iso-8859-1?Q?6D7QJcSsu1mPI5vnUOHbpi1yY1lsF1Y3KoOAxZaNLElm2glqO4HOOeyBSw?=
 =?iso-8859-1?Q?Bh8JCV5+ILAq9JYoF8nUgXF63EMSyjp+CNvsWb5HwZ307P2GwocA80gRrj?=
 =?iso-8859-1?Q?urZdaglxltNM+l8HpgRbD8H5Q+jKK9ENnZ9QEecy6QRva0VX2FpNCKwHMM?=
 =?iso-8859-1?Q?RVtCVA4tiAzmOyhueJ16CURy+vTm07omv/U0uJgpxI8pc5TN8HfCb00uaQ?=
 =?iso-8859-1?Q?huRIB62t8G2fl/jbZVixeC7rKJWlLZkqSQeN7UGXb7hzvE4zC+um6iRxFN?=
 =?iso-8859-1?Q?bYzVj3w7JlVMjvzBZUZ84CPkb2gznOSGaJ+p4Ql43zblFkrVDzVY/j61nH?=
 =?iso-8859-1?Q?syt/TJeIs3J9Ni3U18d1dSio9LxykpA/rVPuvmxsmL3w7OK5SjC0QoBG94?=
 =?iso-8859-1?Q?qR/H+NFLXwS2R2FQoWlW/kGEJAjuvcoAbbe34Hl1T4GIse3ccdTz6kUrw3?=
 =?iso-8859-1?Q?/59IJdOVhMfjj8jv6FmMi5QvLBnzaF1NwjSsbI4J3N5uh2bhMmnftW2LDp?=
 =?iso-8859-1?Q?be/dxM86L3k6giWSjJuRnqGGeNqWGO51Zx8kycDlqqyZooGkLd9gMj/+ey?=
 =?iso-8859-1?Q?n1oyzId8fHQsqewWu17nLXOXaGVjigzF9ZxD+9yIBIUq18fCGT3lWULWtC?=
 =?iso-8859-1?Q?7QW3HUII5FirEiaP8saVlvndeY/ifpiXG1u87rhjFlGU4EWJw94Ko7Q51q?=
 =?iso-8859-1?Q?WgvZ1MJAVL66jEWjCjzZWna1ZYocZ9ValR+jw9UQPyGeU5tEKtCrUsO0vz?=
 =?iso-8859-1?Q?Rg2BbmtBP141KJkZpGCH7Y0DxI31L+gdP6+JZd/XuwLaf+xNF5iqPwhKXa?=
 =?iso-8859-1?Q?JYAQ17kRraW6Q8QFLY4H8fyCUcLUPIUdZaVuMQc64hZprQHQlYANYeuK0x?=
 =?iso-8859-1?Q?jg6bGQnLx1qd69gDNHTMnlEGpkJPQwbF/jIk4ZoupAeKO0GE37z21Ht9iL?=
 =?iso-8859-1?Q?b5NVNqj91/OGvpbZrC4Bt6s1mrvMPhv5tEOzu77kq6gzo8+qd+UO+hMvLk?=
 =?iso-8859-1?Q?WyzaXk6qQu/dZ6rEd1BACK+iaaZm/RYvPEdYBhQIv80ae8KNNdlvG1hwiw?=
 =?iso-8859-1?Q?uZjGHUoXixyqSonjr4pPKN4nyunT3XnTFCo9KvP32tMq688qd6tq1+LJ2r?=
 =?iso-8859-1?Q?mdUypAq9Gtsf4bhbyUnVreTFtkzEOLJ8wZAIqyLQnzTPGlFng3qVji/Y?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?Y47ljVp0ry4PlkX/upvMdqHCI3MlW3B5HSQppsojCHdjz19HIMIzcgwu1o?=
 =?iso-8859-1?Q?7usaB5pMHBa0pDHYTauI8w0R5mWzVEOLgiyDPrG7gxTSb7xGCrlIhSBGCq?=
 =?iso-8859-1?Q?akZDnCNeVke1LPtaXWZ17rDyukru+nkIe86rV4H2K7s7GWroqmlzgqhvDm?=
 =?iso-8859-1?Q?Q5blZ8Xk2ZQn35wv/VD1/OFbgUqMXmaDnV/xg7sRMMuZCnq360KX60EsGR?=
 =?iso-8859-1?Q?svXjPH01CSEoQLZO0Y4cmCMDvV7Z/Iq7LqC8gntWfPKGg6nJ4zQyAeYgHp?=
 =?iso-8859-1?Q?LlQ3stPaonp3/2e3iXUxsZhwynNAQJGwDYtCC4O/3ETMeT0yv4z9dmz66C?=
 =?iso-8859-1?Q?HghZ6k3q+2qyzgf8fLRiLbPlllEkzWYsm4P7cmREng7pzPBvXsy/aLZbVG?=
 =?iso-8859-1?Q?bgGwBHWmPOscFvo0IDHmvI4FdWqu3nF4jMTHGbOGDuSN91DWh13Dg6IZQH?=
 =?iso-8859-1?Q?XLTeV6kCv94OmG+Iq7TPxp1vo0c3ROoKJ4LHxkpNojvXkz297jN4vczRVU?=
 =?iso-8859-1?Q?hdIF9cEfMS8p+BR7hf9jhZz3axHsETmYTjNQfuam3W5z3oi3przp+9XruA?=
 =?iso-8859-1?Q?/vlpOwtyq8xTQtIjaRCr2sDelnXAoLs2pXFr2wkAH0IweQI+R/JuhKo28i?=
 =?iso-8859-1?Q?rQ3avra6FijE757jYtA0w45aI5wV/T0TyTww5tx+g8L1ocxd1EHk18LTYF?=
 =?iso-8859-1?Q?D/gWOe9qG2XAyT2ueGcti3PZcjNHY4jJdDi6+BY0jGVvvfTjxknQSw5mO8?=
 =?iso-8859-1?Q?f/HWR86EC69qnbnIEOx7CLqddHmqv++UEmibgZ7gcmBe4qrwjjFs1+/X2W?=
 =?iso-8859-1?Q?DkXCTfMPWe9vzE+/DlRUK8Ot8wNqpiG7rIIiiDJaRgZqGU/RRQSIay+h05?=
 =?iso-8859-1?Q?PW7W51RrHPiZeUoQBtmw+57cPR8Kwan21apgXR4s23CoAqzWIiDU3+3tfW?=
 =?iso-8859-1?Q?boLTnUs9t2xlmaC4UEVSQ8l2PYae4A1/2cAazaPfbR30p7Je60ttCN9oQu?=
 =?iso-8859-1?Q?qhdLgi2Fq+0ojxUjLJ0J4/AxbFjSJBKIiPZI22QKk9zCUAWuF7Gt68JKWg?=
 =?iso-8859-1?Q?kSOH12tBN1KZoz1YnWiVHACBgJsCsG0kVLcelP/h1Ub2kPFQs0feZyZ7eg?=
 =?iso-8859-1?Q?GQ3ETYvcmDq9SIshwEgKtQJY1Bh207I9tdY33RTzeFcfANTMUjdYtJcBI1?=
 =?iso-8859-1?Q?wNTIBIk9M3JQ15HJ6SEensy14iDD7mkHirOR/Vt393lUSwaDR0NexofjzE?=
 =?iso-8859-1?Q?im5s9SGEfSER9sLvWobA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-6efd8.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3e52a70c-5558-4822-defb-08dd4825edce
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2025 09:49:49.7059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3883
Message-ID-Hash: S4SVMGBMBG2FROICXFXBIVFAJZWHSMYV
X-Message-ID-Hash: S4SVMGBMBG2FROICXFXBIVFAJZWHSMYV
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/CLAO3ICKB2QWBF6ENAGVPWOP2C7CURQP/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

[Resend because mail list told me my last reply is rejected due to the html=
 content in email]=0A=
=0A=
Hi Sven, thank you for your kind reply!=0A=
=0A=
It turns out that it's not batman-adv's fault, the problem is caused by the=
 bridge's MAC address on node2, the automatically generated MAC is the same=
 as the MAC address on one of Node 4's interface (ra0), what a funny coinci=
dence.=0A=
So, sorry for the bothering!=0A=
=0A=
Again, I really love batman-adv and thank you for your contribution!=0A=
=0A=
Best regards,=0A=
Jingwei=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Sven Eckelmann=0A=
Sent:=A0Saturday, February 8, 2025 3:08 AM=0A=
To:=A0Jingwei LI=0A=
Cc:=A0b.a.t.m.a.n@lists.open-mesh.org=0A=
Subject:=A0Re: No Connection Between Two Specific Nodes in a 4-Node Network=
=0A=
=0A=
=0A=
On Friday, 7 February 2025 14:21:47 GMT+1 Jingwei LI wrote:=0A=
=0A=
> [B.A.T.M.A.N. adv 2024.4, MainIF/MAC: rax0/90:15:64:00:0b:ee (bat0/22:f9:=
67:7c:cd:e8 BATMAN_IV)]=0A=
=0A=
=0A=
=0A=
Please make sure you update to 2025.0. 2024.4 had a bad regression in the O=
GM=0A=
=0A=
TVLV handler and I would like to avoid to start debugging things before=0A=
=0A=
applying a fix [1] for a known bug.=0A=
=0A=
=0A=
=0A=
Kind regards,=0A=
=0A=
=A0=A0=A0=A0=A0=A0=A0 Sven=0A=
=0A=
=0A=
=0A=
[1] https://git.open-mesh.org/batman-adv.git/commit/b10d75d994ee49ead8c87a3=
f26417c666dfccc82=
