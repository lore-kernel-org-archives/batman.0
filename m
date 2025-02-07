Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08AD1C02194
	for <batman@archiver.kernel.org>; Fri,  7 Feb 2025 19:03:19 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 40C6481867
	for <batman@archiver.kernel.org>; Fri,  7 Feb 2025 20:03:18 +0100 (CET)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1738954998;
 b=oiPq/F9QME8o4WIbiczU3/ayG+kLqxVvoxfl4E5xOLu2nNYsGkRFfyROn3PovlkQ02KUX
 25HBK6zv00uHamvpZSPGz0Eezjf3OmG9loo9mtwJA9eQBnMWQvMA3w/kkNiTWq055D1XKkc
 ECdceGZL5biIE3LzpHJj2MPACKXLclI=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1738954998; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=/u0/+zHInVfddGya0ZKFyByasy1A6+M5h5xQaJViY9U=;
 b=lKhHh7rLve1G0DEDHfeJOKRn0RZibZLzZwoK03X4y8bE2FzIY2CwPP8FxO7ITHpdgsKIX
 pd4+tDJyITBPRQTVoMrV1KudRba1DcLP9REBxVZV4bw6xMwNFz7hF+WOmFgmbOktu/l2OwS
 AjUj2T3W+J2RE9MXQ963wSzKWB1qqlA=
ARC-Authentication-Results: i=3; open-mesh.org; dkim=pass header.d=live.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=live.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=live.com; arc=pass;
 dmarc=pass (Used From Domain Record) header.from=live.com
 policy.dmarc=quarantine
Received: from OS0P286CU010.outbound.protection.outlook.com
 (mail-japanwestazolkn19011024.outbound.protection.outlook.com [52.103.66.24])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 2B70881848
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri,  7 Feb 2025 14:21:51 +0100 (CET)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1738934512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=/u0/+zHInVfddGya0ZKFyByasy1A6+M5h5xQaJViY9U=;
	b=E9mSUPRuTCQELpt72Ovzu7fmcMBSoP8eQcmBUuL0biQ+GEnI/PTtiKrduWD9tXPStCIbWt
	ze4FS3ut8oEN+lUtNcZ16cUg+8tpHjd/XRmna2Ihoq1sOR0R20vpaHtuCfmH89ovNA4tAL
	sxz6Ctk3UJNAjfGcC7PxKRKh0JeZ89k=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=live.com header.s=selector1 header.b=rNZ0XaQh;
	spf=pass (diktynna.open-mesh.org: domain of marscatcn@live.com designates
 52.103.66.24 as permitted sender) smtp.mailfrom=marscatcn@live.com;
	dmarc=pass (policy=none) header.from=live.com;
	arc=pass ("microsoft.com:s=arcselector10001:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1738934512; a=rsa-sha256;
	cv=pass;
	b=FIUGVYswBW8OTR5jTpWxvlJ5fGa3qb/NkuJpvSgR+TiguuzqBNYFoRushj9eEXwcfezImf
	iX7SLJNi2XU+6oj+XTKriehSpPPEWYZ2ClGuA4hFx9nzVQauMX4lTIbPSysovRZpElVXUg
	VFqsFsOWMTvaHKcEQ4fU8D5BMMo1paM=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvFSvBmWFdcZCxuOjkIMynX6YcoMgaKyLGIBSSFRYnRhp2dnVVU80LepbUiAPEcCvxARyuRybgbf8vTafs6vtxekNkzx9quP6GlOGOrpoEgmv+6MpuV5U8y/cEtkZXblSqSE52kujbEFnZuwYArf0crZE5iZT0s6nJLJmeKIfH09R24qpPNJCB3uSrdviy6ZGNHYwuOg8ck0ZbOaS6BGgSwvcs5BuuXryAES2xzQq5DzsdtbNV2t4fSeNa+kguQb5litAjEMR0kM6nUujgisOIieD8AkJNq27zbA7/dhmSfxIQaKzdr1ZXtr/eyZWw4380FzHpO6gt++ZGnOHpbTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/u0/+zHInVfddGya0ZKFyByasy1A6+M5h5xQaJViY9U=;
 b=jOhe654gyeF+i/8qt8wg467tuH9CBaM+7hvpB+GbAFT8JjtP4BRi038CV4+xMzQSVDPa/xVX8vvGSIul/6+aOffvd2NZqH67q/6AI2VvsdPX32bNY658KeuGAuZ3tRyjWwFJ3BRDaUzDHszDwG8K5YYm3xzi/MmDt2N4EgnujCIwxNTL6LmF4jbvtnnAQsasfvqnMVCmdMbh8BaMBLa4+SdrwICnZ6RJB82sjaHewB4PqEuw4MH5y4XDxiQ4SU2n1n66czxr9W8HndN9X/30UxpuSDQRVoCDDz4x5vYFt71zrXpjARowSCi9cXseXm3cUGB9FZhqcEOwt8n0cyeKYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/u0/+zHInVfddGya0ZKFyByasy1A6+M5h5xQaJViY9U=;
 b=rNZ0XaQh4zTYNQeMKShjMm/OewpqkxtHkVkrqaXF5st/d7p6edm/cPT6OR+Dl/7EdAZyiqB5mfeSVarx2vwGyD1r5bNIWlPnMM8lhRzpYOCTwbkN75ZrgvWB7rzDCyl2/rCnvX3paX/ZuRmeO1pGi6QibWrsvqqA0o3KANUKpRP2bnA09n5+olUlnZCONR4BOe2+UNucOeV1ySiKbIhccYcSvvZ6BTAjOMUOSBe1G/xi8aQ7qowDCoXj664t97qoYqkSCJBFcnz915dGRGKYdpelzjJz8uc1I3hTsyeA1EfUq2Lcsp3CMsPZE1E3IqmD/ogrFTxCvEGwznnMMi6prQ==
Received: from OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1b2::9)
 by TY1P286MB3123.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.14; Fri, 7 Feb
 2025 13:21:47 +0000
Received: from OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b5c7:27ce:7810:83a0]) by OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b5c7:27ce:7810:83a0%3]) with mapi id 15.20.8422.010; Fri, 7 Feb 2025
 13:21:47 +0000
From: Jingwei LI <marscatcn@live.com>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Subject: No Connection Between Two Specific Nodes in a 4-Node Network
Thread-Topic: No Connection Between Two Specific Nodes in a 4-Node Network
Thread-Index: AQHbeWMUvFYhgrIcQEmpOcNolon6UA==
Date: Fri, 7 Feb 2025 13:21:47 +0000
Message-ID: 
 <OSZP286MB15101558B02308C9DDFB940FD5F12@OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZP286MB1510:EE_|TY1P286MB3123:EE_
x-ms-office365-filtering-correlation-id: 1947bc16-ff0e-4598-d78c-08dd477a5f90
x-microsoft-antispam: 
 BCL:0;ARA:14566002|8062599003|8060799006|461199028|6092099012|15080799006|7092599003|19110799003|15030799003|102099032|440099028|3412199025|13095399003;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?0+QAopUr7uzZwXNSDEmnEwsau7GdHoe4vDdSRlxb4trcMoPAurJru56cy8?=
 =?iso-8859-1?Q?Qb5H4On+UCjJcZLoBxdU7j+mwYUvrqObBA60bomyXJDs2OEhxu0mELH/vY?=
 =?iso-8859-1?Q?VCsHVkVspJsVA0nL0jttMSJ8jrUZbihYGiKpLRfTKUYhitl1I06FLc1oti?=
 =?iso-8859-1?Q?/KUaZNaNYDTd+yfDE6xaCV7lc/NNsBC51Bs40dn/LYuRuVJS7dfaMig10A?=
 =?iso-8859-1?Q?wDtDhd4HPFnNYL0VVag44SP5THa4P3CVYSuZEBKDvfLUug/qegIHXk771Y?=
 =?iso-8859-1?Q?IH5e0Xe3sFNu67zu364r3JPh5gSxYdXj58gEVtgczg7GlD+6Uqgv/OApKA?=
 =?iso-8859-1?Q?M4bhfA3zJkFrPn250IgVGAhchkNNHlarO96ckK4TMNcO9QUBpn9j9gTocr?=
 =?iso-8859-1?Q?cdwzDpmUWzjJ2uD+aLg9wc4m12ZQrDE5KArSYlZVB45Sy/QG2sfgWpxQmB?=
 =?iso-8859-1?Q?eMK19eIfkFq0QjJMFlQ8l7cuh55NkZMVfibuoGn6tbD1E4udpyfDp1V8sf?=
 =?iso-8859-1?Q?N86Bg6hYqr+Lj+4kH7c7wSzN5bifvr1qA766jCDmqgxjHZ/VUxnBMOjdpi?=
 =?iso-8859-1?Q?bXFmUw1VEeVrt4HNMm9t4uXQ/stW+EqTqVocjxE2Fou3GJm6SUIp6c0WMZ?=
 =?iso-8859-1?Q?fu145Sz1xHc2vIWWhSWaoepl5wMDv9Gd+D8m9E0oHrIh0Xhq9GCdjQZF4Q?=
 =?iso-8859-1?Q?taTZiTXLM3sVSMRSZSuxULRzXfMYHZii+IZQg+nB3lQLSbL0TKNtbk/830?=
 =?iso-8859-1?Q?JimnWYznv7iQy/PcRKokzPufqthbMeg3y3zxKSsA/VnusMOBqq7Rbe+ALJ?=
 =?iso-8859-1?Q?gKvSu4JF7M/jBgUALAamKk+f3UuVRUkcpFf4cEyrLzqBzH8QqT2zfB+4PF?=
 =?iso-8859-1?Q?WhHIrYfHdz/Qic8PhfLuPCJ7oSVg2ZZVntKYVeo0KTgznzpk446WFOFSHp?=
 =?iso-8859-1?Q?JroWkIqZiXWP8fk81DfK/qBRUJv/I8/B5bqmDDd7UGW3TC+yunSK/rS2dy?=
 =?iso-8859-1?Q?Cobh+4PHRpZ5GRJwj4Cr27kuWekbeJQYzA3k5tunOFejw4YkgLADFinFwS?=
 =?iso-8859-1?Q?ADJdJ0Ix+LsoidEJ+tU14A144QyiYU4HMyGZ+nS2pRRq8lK6PiEQGWBsJk?=
 =?iso-8859-1?Q?+EkelWJu6cLXTPtXC4STgmKauiE4vZnMXKOhKKUkcf+haXFmjS0x/WD5aq?=
 =?iso-8859-1?Q?67ngrNJ1NZvAnxf+XP41x+9TztQC7U/8rag=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?kxvTj/ZMvCAimJ5kKUFc6dPAgDdcDaBU55KdHwjZwa1HRWNrCqam3IPHbb?=
 =?iso-8859-1?Q?zY6vRVgUPznH2yT4NpS6mrLc1Lq1smoRMlRjQQVqThFVXfn8gOX0CM3odY?=
 =?iso-8859-1?Q?eFMFXrl8KKIm3wlHJjXx30gBl7JDVCeMahECOh98REzzRpXA7pEIHMrVwz?=
 =?iso-8859-1?Q?RhIHXorb657TlAGKMUUGMC9CaCMiPysNuDFI0IjitV0H41dpj7nOIJ9cjo?=
 =?iso-8859-1?Q?43RPbt+DY2Okdh6+q69Ooa0lzRTgD7/ZY73m3gtDF2vZ/I1eB1mOXn6giH?=
 =?iso-8859-1?Q?cS4dU78L297KXWfk/9kjM836DB645WSbgL5FCzKTkB22hczKX1lbTKH+TM?=
 =?iso-8859-1?Q?NL0EHeuPyjEAwQquDBAplQV4X2UXRMc4+YvrqmK6vD4syFp4iLD88EcAfS?=
 =?iso-8859-1?Q?z/kNX6sCQHz4U8Lk/XB5xU8qpCSskrdnTgX+iYVuWKU0Ud/g1V8SlcpI8B?=
 =?iso-8859-1?Q?NOkzynXmxzKKQ+FHjYBn8KlYx3fuhyr4SMigz7FrqvuEtq9CzT8vFrXtxY?=
 =?iso-8859-1?Q?+ZQVXOZV075HJtv6ctzfWqGMFCAqg7K1wdawhVdkea6d9ooSRFA17a+K58?=
 =?iso-8859-1?Q?hXcYZxMudZa8gCyldVvsFPxs4X54VGnq9yA4Ytv6s/G22AsHXg+YTPqPPx?=
 =?iso-8859-1?Q?sFX+9rncecjBNZqcj0fJMMRBOsKz6n/oY/vpbaFMFs/pYp3paRGYaqHkEc?=
 =?iso-8859-1?Q?aAbihZhTDaRF+WXm01633prAMpjtejUuj6BZBtGI1gOArio4ppxuG+MRyB?=
 =?iso-8859-1?Q?LW8yKbhmls38lT0ge1RUjG9UsKpD1Zrn8qLqOqdO6Jl4xpFzA+HkSrJz4a?=
 =?iso-8859-1?Q?bVKBlf5xSkcgSFiE6kK695+us2cqkeqBShBjbKLB1efVx16LpEi1FbwB9m?=
 =?iso-8859-1?Q?AoLfOzsUjW8MAcBRrEDbo10vNmDR4ssTystC2uthHEImTrv4LZeIknxIAc?=
 =?iso-8859-1?Q?4htTwv9wFHxr4aGCaiVvAunmZXwUp+6XcGV1LP1+FQGLxieqZ+NCmvrOXs?=
 =?iso-8859-1?Q?pweK1iWpvqekqr3aI+rMkSE0wHN5wQmGgJPu9b/UoBLIED7+I3ub0Z7jaZ?=
 =?iso-8859-1?Q?Cb+yyeum2IrAdPXVhXzLgAVuQ2Du97kfEdZwet9d9t/EP7OlQNi7/W2sGB?=
 =?iso-8859-1?Q?k8aOcr02ZtzxOcfbzZGY05MerL/sm+7qea89yVyVUudyoZeeekGQrHmWUm?=
 =?iso-8859-1?Q?gW8XRR5xVnbG8TeySPSl3mN0nTB613ACGesWyZtLWtDmIyEhj2inhajO3J?=
 =?iso-8859-1?Q?84axAKrssugZO/n0wAsQ=3D=3D?=
Content-Type: multipart/related;
	boundary="_004_OSZP286MB15101558B02308C9DDFB940FD5F12OSZP286MB1510JPNP_";
	type="multipart/alternative"
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-6efd8.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZP286MB1510.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1947bc16-ff0e-4598-d78c-08dd477a5f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 13:21:47.0873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1P286MB3123
X-MailFrom: marscatcn@live.com
X-Mailman-Rule-Hits: member-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address
Message-ID-Hash: LAGYEJLXXM4GTEPBOYUEPQ5T3IYFVIUI
X-Message-ID-Hash: LAGYEJLXXM4GTEPBOYUEPQ5T3IYFVIUI
X-Mailman-Approved-At: Fri, 07 Feb 2025 20:03:03 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/W2GS4VQLVNTMXW5YDCVA4N5ZOC3HHBKM/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--_004_OSZP286MB15101558B02308C9DDFB940FD5F12OSZP286MB1510JPNP_
Content-Type: multipart/alternative;
	boundary="_000_OSZP286MB15101558B02308C9DDFB940FD5F12OSZP286MB1510JPNP_"

--_000_OSZP286MB15101558B02308C9DDFB940FD5F12OSZP286MB1510JPNP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi all, thank you so much for such an awesome project! I got a problem and =
need your help.

I've set up a 4-router wireless network, routers are connected together in =
a linear topology, by using the AP-APCLI (AP Client) mode provided by the d=
river.
The figure shows how they are connected:
[cid:8ed19ad8-f576-448b-8eea-360545bd4d4b]
However, the node 2 and node 4 cannot connect to each other, while other th=
ings go well.
Ping status:
    Node 1 can ping 2, 3, 4.
    Node 2 can ping 1, 3.
    Node 3 can ping 1, 2, 4.
    Node 4 can ping 1, 3.

Use Node 2 to ping Node 4, the `tcpdump -i any icmp` output on Node 4:
    02:11:54.683342 bat0  P   IP 192.168.6.2 > 192.168.6.4: ICMP echo reque=
st, id 32006, seq 0, length 64
    02:11:54.693420 br-lan In  IP 192.168.6.2 > 192.168.6.4: ICMP echo requ=
est, id 32006, seq 0, length 64
    02:11:54.703673 br-lan Out IP 192.168.6.4 > 192.168.6.2: ICMP echo repl=
y, id 32006, seq 0, length 64
    02:11:54.703677 ra0   Out IP 192.168.6.4 > 192.168.6.2: ICMP echo reply=
, id 32006, seq 0, length 64
Here I noticed that the outgoing interface is ra0, instead of bat0, maybe t=
his is the problem?
Use Node 4 to ping Node 2, Node 2 gets nothing.

`batctl ping` works well:
Node 2 -> 4:
    ~# ./batctl ping 192.168.6.4
    PING 192.168.6.4 (9a:15:64:00:0b:f7) 20(48) bytes of data
    20 bytes from 192.168.6.4 icmp_seq=3D1 ttl=3D49 time=3D1.20 ms
Node 4 -> 2:
    ~# ./batctl ping 192.168.6.2
    PING 192.168.6.2 (9a:15:64:00:0b:f8) 20(48) bytes of data
    20 bytes from 192.168.6.2 icmp_seq=3D1 ttl=3D49 time=3D1.08 ms

`batctl o` outputs below. I also feel the output on node 3 and 4 are a bit =
weird, too.
On 1:
[B.A.T.M.A.N. adv 2024.4, MainIF/MAC: rax0/90:15:64:00:0b:ee (bat0/22:f9:67=
:7c:cd:e8 BATMAN_IV)]
   Originator        last-seen (#/255) Nexthop           [outgoingIF]
 * 9a:15:64:00:0b:f8    0.016s   (255) 9a:15:64:00:0b:f8 [      rax0]
 * 9a:15:64:00:0b:b9    0.980s   (221) 9a:15:64:00:0b:f8 [      rax0]
 * 9a:15:64:00:0b:f7    0.216s   (197) 9a:15:64:00:0b:f8 [      rax0]
On 2:
[B.A.T.M.A.N. adv 2024.4, MainIF/MAC: apclix0/9a:15:64:00:0b:f8 (bat0/f2:71=
:14:f3:8c:e8 BATMAN_IV)]
   Originator        last-seen (#/255) Nexthop           [outgoingIF]
 * 90:15:64:00:0b:ee    0.212s   (247) 90:15:64:00:0b:ee [   apclix0]
 * 9a:15:64:00:0b:b9    0.392s   (255) 9a:15:64:00:0b:b9 [      rax0]
 * 9a:15:64:00:0b:f7    0.588s   (225) 9a:15:64:00:0b:b9 [      rax0]
On 3:
[B.A.T.M.A.N. adv 2024.4, MainIF/MAC: apclix0/9a:15:64:00:0b:b9 (bat0/ca:97=
:7e:d4:23:7e BATMAN_IV)]
   Originator        last-seen (#/255) Nexthop           [outgoingIF]
 * 90:15:64:00:0b:ee    0.972s   (221) 90:15:64:00:0b:f9 [   apclix0]
 * 9a:15:64:00:0b:f8    0.032s   (255) 90:15:64:00:0b:f9 [   apclix0]
 * 90:15:64:00:0b:f9    0.128s   (251) 90:15:64:00:0b:f9 [   apclix0]
 * 9a:15:64:00:0b:f7    0.536s   (255) 9a:15:64:00:0b:f7 [      rax0]
On 4:
[B.A.T.M.A.N. adv 2024.4, MainIF/MAC: apclix0/9a:15:64:00:0b:f7 (bat0/ae:77=
:82:36:4d:f7 BATMAN_IV)]
   Originator        last-seen (#/255) Nexthop           [outgoingIF]
 * 90:15:64:00:0b:ee    0.412s   (187) 90:15:64:00:0b:ba [   apclix0]
 * 9a:15:64:00:0b:f8    0.652s   (217) 90:15:64:00:0b:ba [   apclix0]
 * 9a:15:64:00:0b:b9    0.840s   (255) 90:15:64:00:0b:ba [   apclix0]
 * 90:15:64:00:0b:ba    0.552s   (255) 90:15:64:00:0b:ba [   apclix0]

`ip neigh` on Node 2 (pasted related entries only):
192.168.6.4 dev br-lan lladdr 90:15:64:00:0b:f6 used 0/0/0 probes 1 STALE
192.168.6.3 dev br-lan lladdr 90:15:64:00:0b:b8 used 0/0/0 probes 1 STALE
192.168.6.1 dev br-lan lladdr 90:15:64:00:0b:ec used 0/0/0 probes 1 STALE

`ip neigh` on Node 4:
192.168.6.1 dev br-lan lladdr 90:15:64:00:0b:ec used 0/0/0 probes 1 STALE
192.168.6.2 dev br-lan lladdr 90:15:64:00:0b:f7 used 0/0/0 probes 4 STALE
192.168.6.3 dev br-lan lladdr 90:15:64:00:0b:b8 used 0/0/0 probes 1 STALE


All batctl parameters are remained default.

Thank you so much for your kind help!


Jingwei

--_000_OSZP286MB15101558B02308C9DDFB940FD5F12OSZP286MB1510JPNP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
Hi all, thank you so much for such an awesome project! I got a problem and =
need your help.</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
I've set up a 4-router wireless network, routers are connected together in =
a linear topology, by using the AP-APCLI (AP Client) mode provided by the d=
river.&nbsp;</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
The figure shows how they are connected:</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
<img size=3D"63333" contenttype=3D"image/png" style=3D"max-width: 1232px;" =
data-outlook-trace=3D"F:1|T:1" src=3D"cid:8ed19ad8-f576-448b-8eea-360545bd4=
d4b"></div>
<div style=3D"background-color: rgb(255, 255, 255); margin: 0px;"></div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
background-color: rgb(255, 255, 255); margin: 0px; font-family: Calibri, He=
lvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
However, the node 2 and node 4 cannot connect to each other, while other th=
ings go well.</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
Ping status:</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; Node 1 can ping 2, 3, 4.</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; Node 2 can ping 1, 3.</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; Node 3 can ping 1, 2, 4.</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; Node 4 can ping 1, 3.</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
Use Node 2 to ping Node 4, the `tcpdump -i any icmp` output on Node 4:</div=
>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 02:11:54.683342 bat0 &nbsp;P &nbsp; IP 192.168.6.2 &gt; 192.1=
68.6.4: ICMP echo request, id 32006, seq 0, length 64</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 02:11:54.693420 br-lan In &nbsp;IP 192.168.6.2 &gt; 192.168.6=
.4: ICMP echo request, id 32006, seq 0, length 64</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 02:11:54.703673 br-lan Out IP 192.168.6.4 &gt; 192.168.6.2: I=
CMP echo reply, id 32006, seq 0, length 64</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 02:11:54.703677 ra0 &nbsp; Out IP 192.168.6.4 &gt; 192.168.6.=
2: ICMP echo reply, id 32006, seq 0, length 64</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
Here I noticed that the outgoing interface is ra0, instead of bat0, maybe t=
his is the problem?</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
Use Node 4 to ping Node 2, Node 2 gets nothing.&nbsp;</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
`batctl ping` works well:</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
Node 2 -&gt; 4:</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; ~# ./batctl ping 192.168.6.4</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; PING 192.168.6.4 (9a:15:64:00:0b:f7) 20(48) bytes of data</di=
v>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 20 bytes from 192.168.6.4 icmp_seq=3D1 ttl=3D49 time=3D1.20 m=
s</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
Node 4 -&gt; 2:</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; ~# ./batctl ping 192.168.6.2</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; PING 192.168.6.2 (9a:15:64:00:0b:f8) 20(48) bytes of data</di=
v>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 20 bytes from 192.168.6.2 icmp_seq=3D1 ttl=3D49 time=3D1.08 m=
s</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
`batctl o` outputs below. I also feel the output on node 3 and 4 are a bit =
weird, too.</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
On 1:</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
[B.A.T.M.A.N. adv 2024.4, MainIF/MAC: rax0/90:15:64:00:0b:ee (bat0/22:f9:67=
:7c:cd:e8 BATMAN_IV)]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Originator &nbsp; &nbsp; &nbsp; &nbsp;last-seen (#/255) Nextho=
p &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [outgoingIF]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 9a:15:64:00:0b:f8 &nbsp; &nbsp;0.016s &nbsp; (255) 9a:15:64:00:0b:f=
8 [ &nbsp; &nbsp; &nbsp;rax0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 9a:15:64:00:0b:b9 &nbsp; &nbsp;0.980s &nbsp; (221) 9a:15:64:00:0b:f=
8 [ &nbsp; &nbsp; &nbsp;rax0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 9a:15:64:00:0b:f7 &nbsp; &nbsp;0.216s &nbsp; (197) 9a:15:64:00:0b:f=
8 [ &nbsp; &nbsp; &nbsp;rax0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
On 2:</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
[B.A.T.M.A.N. adv 2024.4, MainIF/MAC: apclix0/9a:15:64:00:0b:f8 (bat0/f2:71=
:14:f3:8c:e8 BATMAN_IV)]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Originator &nbsp; &nbsp; &nbsp; &nbsp;last-seen (#/255) Nextho=
p &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [outgoingIF]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 90:15:64:00:0b:ee &nbsp; &nbsp;0.212s &nbsp; (247) 90:15:64:00:0b:e=
e [ &nbsp; apclix0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 9a:15:64:00:0b:b9 &nbsp; &nbsp;0.392s &nbsp; (255) 9a:15:64:00:0b:b=
9 [ &nbsp; &nbsp; &nbsp;rax0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 9a:15:64:00:0b:f7 &nbsp; &nbsp;0.588s &nbsp; (225) 9a:15:64:00:0b:b=
9 [ &nbsp; &nbsp; &nbsp;rax0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
On 3:</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
[B.A.T.M.A.N. adv 2024.4, MainIF/MAC: apclix0/9a:15:64:00:0b:b9 (bat0/ca:97=
:7e:d4:23:7e BATMAN_IV)]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Originator &nbsp; &nbsp; &nbsp; &nbsp;last-seen (#/255) Nextho=
p &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [outgoingIF]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 90:15:64:00:0b:ee &nbsp; &nbsp;0.972s &nbsp; (221) 90:15:64:00:0b:f=
9 [ &nbsp; apclix0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 9a:15:64:00:0b:f8 &nbsp; &nbsp;0.032s &nbsp; (255) 90:15:64:00:0b:f=
9 [ &nbsp; apclix0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 90:15:64:00:0b:f9 &nbsp; &nbsp;0.128s &nbsp; (251) 90:15:64:00:0b:f=
9 [ &nbsp; apclix0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 9a:15:64:00:0b:f7 &nbsp; &nbsp;0.536s &nbsp; (255) 9a:15:64:00:0b:f=
7 [ &nbsp; &nbsp; &nbsp;rax0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
On 4:</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
[B.A.T.M.A.N. adv 2024.4, MainIF/MAC: apclix0/9a:15:64:00:0b:f7 (bat0/ae:77=
:82:36:4d:f7 BATMAN_IV)]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;Originator &nbsp; &nbsp; &nbsp; &nbsp;last-seen (#/255) Nextho=
p &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; [outgoingIF]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 90:15:64:00:0b:ee &nbsp; &nbsp;0.412s &nbsp; (187) 90:15:64:00:0b:b=
a [ &nbsp; apclix0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 9a:15:64:00:0b:f8 &nbsp; &nbsp;0.652s &nbsp; (217) 90:15:64:00:0b:b=
a [ &nbsp; apclix0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 9a:15:64:00:0b:b9 &nbsp; &nbsp;0.840s &nbsp; (255) 90:15:64:00:0b:b=
a [ &nbsp; apclix0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
&nbsp;* 90:15:64:00:0b:ba &nbsp; &nbsp;0.552s &nbsp; (255) 90:15:64:00:0b:b=
a [ &nbsp; apclix0]</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
`ip neigh` on Node 2 (pasted related entries only):</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
192.168.6.4 dev br-lan lladdr 90:15:64:00:0b:f6 used 0/0/0 probes 1 STALE</=
div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
192.168.6.3 dev br-lan lladdr 90:15:64:00:0b:b8 used 0/0/0 probes 1 STALE</=
div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
192.168.6.1 dev br-lan lladdr 90:15:64:00:0b:ec used 0/0/0 probes 1 STALE</=
div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
`ip neigh` on Node 4:</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
192.168.6.1 dev br-lan lladdr 90:15:64:00:0b:ec used 0/0/0 probes 1 STALE</=
div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
192.168.6.2 dev br-lan lladdr 90:15:64:00:0b:f7 used 0/0/0 probes 4 STALE</=
div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
192.168.6.3 dev br-lan lladdr 90:15:64:00:0b:b8 used 0/0/0 probes 1 STALE</=
div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
All batctl parameters are remained default.</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"text-align: left; text-indent: 0px; background-color: rgb(255=
, 255, 255); margin: 0px; font-family: Calibri, Helvetica, sans-serif; font=
-size: 12pt; color: rgb(0, 0, 0);">
Thank you so much for your kind help!&nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Calibri, Helvetica, san=
s-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Jingwei</div>
</body>
</html>

--_000_OSZP286MB15101558B02308C9DDFB940FD5F12OSZP286MB1510JPNP_--

--_004_OSZP286MB15101558B02308C9DDFB940FD5F12OSZP286MB1510JPNP_
Content-Type: image/png; name="image.png"
Content-Description: image.png
Content-Disposition: inline; filename="image.png"; size=63333;
	creation-date="Fri, 07 Feb 2025 13:20:42 GMT";
	modification-date="Fri, 07 Feb 2025 13:20:42 GMT"
Content-ID: <8ed19ad8-f576-448b-8eea-360545bd4d4b>
Content-Transfer-Encoding: base64

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
Qya9r/TV336lR38NFSeXj4/69smzj2eLchg415dlfmzZns92PykfL/uMw22dx3U8t4/3+AQl/SbD
rv7q49M5Xj71uLTJZ/77cV17ZljVX+PxtuH39o2W4qWtfrZRn694N8d+5swyHxslf5cY/p5JP6Mr
+3zF57iZffp5dXHaKL+tjWv1+cvs2fz7PwAAAAAAn4toHzeX0dnZWXR+fRPdXJ5HZ2dnudd5dHlz
mz8qdnMZnRf2T49Jd7qNrs/z27eveL/tPtvjdt1c7m6/vU7zehmVHLLr9jrO6/l1ZC5NRR5aK+e2
vi9vbqJLw/7n17fbvJamtT1Xcb/yfeN0y/J5Hl2bK6aeSz6iKIpuzWU/OzuPrm+SsmcPTPK+815W
Wl9l21NNzrPpH7nKybZjpgzn17ebWDW98vFrzkraRrnYdqnnsnyXaToOlNTDpp9V5cM1DmyOu03y
YTouKjvuLDo37u+gML6U9bP4ZZdc+Tl283sbXRvbrGK8cx0PXPePD3Ks77Jzn0Xnl38q3XaWrc+0
/Q0vYwzmtTQ+O/fvQj8pr4ud8xaO233/8qZsPKruz4XzxRuNdXJW2p4Gled3i+O0jo3nqhrrTeN8
FLmVr27cK1NVfsvxffPdJ5+njSRPhbzcY/msx4+y7fFrN5v7l+f8+qYivT0+f6Oosiy7+XMoR0F5
GmeF+nLrX/XK027v88lcN7bjcFvnaTqe18f77v6FfhNF9vVsFZ/l5zorlM9cZ4V0jVzSaRAflVzO
Z5nPTfuUjRd7fv8pGZ+K+c3J5Mvpe3vUcry01M/ScxX3K983Trcsn6Z2seSSjyiq/rvE9PdM1XeU
KKr4nlLCNf2NsuOK44tzftsY12zzFyV1YNivPA8AAAAAAHyeWplQEr/Oo8vr2+g2ubB/m7mgkv+7
fXtx6Dy6zlywut2cL3Nx9fY2ur1NL8RdRje3t9Ft8kp2SLaVX/xJb4ptLwrcRJfn58ULCmUKN3zT
92+j25vr7QWLwvY2y5mr7/N4nyi6zUyQOY/Oz+N8xMndRjfptmzeXPIVFdv5+uY2Ptcmv4ay23DN
R+Yi0vnlzTbW8hfD8heU0jQMGay+2J/V4DxlF8QK7Ri/nS1PVRwY09ow3KBwreeyfJdpOg4U6iFO
b1PU0nw0iYMo04aux+XS27y9Pa6YRwem8cVmPCiVudi6GQuinXLGNwry+6U71vRr1/HAdX/n+s6X
I3k3W94//bfa+tx+TmzTvE0vppf0+x3GeHYfn537t6mf2MSP6bjM+2meL9P2suzPhfM5t2cJi/Pb
x3HZxIltHBTGxU3b5GPBsXzGOMmMe2XKyu80vqdjYLFsUSb2yvrXvZTPZfywifu9y5PsfptPL8nb
bfr5l3Bqn2gnf6XjWW78tiqHiWN92fevKvnzJe9WlM8p3UJ7xedyHYfbOk/T8TxNozLeM/sX2zpf
f8m7+Xp2iU/HeHnYcWlxPpt8urana/0Z49R+vE3zZf29ve14MebfvZ855Ssqlr++XSy55iPf3mkb
VP5d0uDv0VJN0jcct3nbFKcN8rvvuOaUv2j/7/8AAAAAAHwmWptQUrjWkN1uuChze3Nt/AM9v5pI
zHDRdaP6QkWUuVhRvDBhyfjrqNzr3JS3NsuZre/i9s1NsEJdp+fcrR+nfG3SNdVxff1XccnH5gKj
MdgyF5ly28vbv6a+c5zPU3ZBrLI+o/LzpVtNF982zMe61HNpvss0HQfq6qEkH/vGQf79ZGuz4zZj
g7mtrJgmlMQbjG1Zq6y+oyiKotvoJr0CW7NfWh+FYle2m2E8cNzfub5ryrEpb2V9Vtxov73ZXLSu
1NL47Ny/S/qJcd+ssuP27M/58zm3Z5mS85fmJ4oq4zhuk3xM7v5KdfeY5Fy5dJzLV9kfKpSVP3Ib
34sTbFPmeLn38lWerzh+lJVjs7X18hT7cJ5L+9TFczqeOZejVHV91eWnrH+Vqjlfe59PxfK4jMNt
nafpeG6OJ0O81/WbQh6j3Xp2jU9TnrNbP9G4LD+fZT4t29O5/irPX2FznKlM1fXRZry01c8i13xV
1luxXVy45KOyvTNxl9/u/PdoiX3Tz7+fbCzEqXN+9xzX3PLXwvd/AAAAAAA+E3+TfwROI95EL/v5
NyX1X2riSQre6n24u6nbv9CF4XG8/WdDSdKHj7kD9hD+FOTfasjTcDgsvDxJCpYadQYa+7tHHKSc
w2fKV3f3sSdJ8p4/1W5yXX39RJIC/ZRJqlG+hq8Mx/SVHLIRhr58v/wVNspHqPdvA0meJsZg6+rp
87gO8rpPnysOw/faKZV/pWkgeZOXhfo0aes8G8b6PAz7et5Dg3FAcq2HpnFwoOO6TxUf9kFtVOH+
Qs1fLyVJw1cXubFAkrrq9+N3/XfV+128imNj+S43qKWM7VYcDzas9netb/vyVusqHkKXej0vfFjJ
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
rqY3fQJNe2kaA403VxP6miVLyS5HHQ02eYgvWMib6E32l7f+WJ1eT73OuOSXWSWCqV4MBhrkXp1O
T6PkYuNwsdo8iqH9crahSb4OoUE++jMthl58AbQ32LTzeDBQb7SU0udUl0p/lS3DxB8XbZ2n3PYi
nyEO0l/Va6lRJ9PnOj2NlkMNdyqhQT035DYO7KFpHHQv9CZeb9l8nOfJyx+j/HHx+DL3fc2TOp8G
gT583O7ujzvq9XrqWF6cLNdwPNjkN9A0yW9azs5oqSD4oI/JfvES3Ln9xgN1evFEvO14dkSO9W1d
3qr63KxUMVJnME76yVzjwSCJ34lK7yO1zal/V6kor4XW+rNre7raM467T58n/d4wlqdLtEsavrow
/zL90OWrtMf4nsZZEMR1VPYz4XstXxM1cX/U8jRoH9vxrLVy1NfXPv2rwKF8raZ7X1obzx1Z1XOD
+LSIl4cal83OV5NPV63Vnx23z/kDxEsrmuTrEBrko+nfMxt7/j3aNP3Gcbpnfq3GNcf8OXz/b+/v
OwAAAAAAHqhoHzeX0dnZWXR5E0XR7XV0eX4WnZ1tX+eX19Ft/pjE7c1ldJ7Zd7P/7XV0fnYWnV/n
j7yNri/Pd/Y/O989f+k5M/tE0TbfZ2eX0U1+m0mSp520d/JxHp1fXkc3hYQq8tSknEm+i8dE0e11
fMyloUCmbU75qkg3iqLo5vIsOjs7j0o2V3LKR3rMdf6Y8+jy+jaKopvo8uwsOjNVQipty6p9bNic
p6zeyt7PuSmLgygqiZPL6OY2bY/d2HaqZ8v8bTQdB+rSqdneNA7MdXGzqYvK43Jl26a5Fdd/+XkK
0nRz41my0dDOpv2Kbm+KbXF2flnop6X7mQa0qL5dCuOB6/4J2/pOlZZjZ/eq+jRsq4rfvIpymsbg
6m2GvJT174p0zeep+TzJvt9if3Ztz4La8xfzWhnHG7fR9Xl5v4rbp/67gnX5aspRquI485hWMr5n
JecsK3vWvZWv7P2EefyoiPt0j9bKk8RPIQ9bTdqnNJ5zu1qXo5JNfZXkp7Z/mZWer1C+kv3K0q1o
L/NYW7KtrfPE7xrqt8l4boj3mv1L6y+zu3t8msqTj5dPLC4rz1eRz5r2KbRnwrr+as5fKjnO+Xt7
2/FSkX9zXyrf5pSvinSjinax4ZSP9JiGf89EUdx+VX+72GiavnWcZtnkt6Z9Svtp035kilFDP3D+
+w4AAAAAgE/Mr6IoivKTTPaSPEqm27X81Un66Jlu1/zr34JQ8WqjXZUmYXPOMFT5CQ7AJk87LMrZ
Bud8HUiTfLjG2oNUFwfJdtt6a1LPTRyzbZqmlT/OH6szWkrDhe4qV1+oa5NDjC8WaZayjRHb/Y7N
tew25ag+52ZJ68pzHINNWWxUl3dH0g+8yVqr9OfY+b6yF4e8NNJWnTV16PJVcB3fTW1d6x7L58wm
rzb7tMS1fSSHeG6jHDbnsM2PLdvz2e53yu6zDBZpO8enQ7xU7lPH5hwW5XPS5Hw2+XR1iHOWcP2c
P0i8tMA5XwfSJB+ubdC2xukfqW0LbPupff5qv/+Hbf99BwAAAADAw9H+hBIAeIDC+UC9aeB4cxX4
xDSaZICHyB93NFp6mqxNj3IAAAAAAAAAAACQ/ib/BgB8kvy5Bp2OBsZnt/u6mgbNnukNAA9NONfr
paThKyaTAAAAAAAAAACAUkwoAfB56H+tJ5KCaU+dwVjzuS/f9zWfjzXojLSU5E3ecHMVwKfJH2s8
9+X7cw16UwXyNHlZ9XgvAAAAAAAAAADwueORNwA+H6Gv8YuRlkF+g6fh4o1mfWaT4DPHI28+UaHm
g56mmbGPNgYAAAAAAAAAAHWYUAIAAAAAAAAAAAAAAIAdPPIGAAAAAAAAAAAAAAAAO5hQAgAAAAAA
AAAAAAAAgB1MKAEAAHjwfI07HXUGc4X5TQAOyx+r0+loMPbzWwAAAAAAAADgQftVFEVR/s0Hyx9r
8PqDnjx/o9lFN7+1RqjQD+ObMN2++q6H18qcX111+13tJhEqdLgD1O3mMxgqDLsqvP0pCOcav3ir
D09eaTXr57fuJ4zbpFifu8IwlLr5NssJQ4Vqtw1Cq6BoN80HI/Q1fjHSMoj/6Q0nejO7qG6jkxJq
Pn6h6bYAWryZHWDsAR6gvT7Pj83u89c0ntd99tgLNR/0NA08TdYrnWyVPah2/VScQnyaZL93d9U3
pfXA4iWcD9SbBhou7tT211UAAAAAAAAAuC+f3AolQRDoQ/5Nf6xBxa8Gw/lYg05PvdFIo9FIo15H
ncFYfvHaurvQ13jQUSd7/lFPvU5Hg/H2V8T+uKdez/b1QvOdvMU3knq9Qe79T8eHIFBy271V/lVc
p4OqivPHcb2XxE/M17jXU+9F5pfhNXFXK5zrRaHtDa80Tdf0XPc/Kb7GvWQyiefJ86RAXz+sySSD
XjKZJM6/9Lj2hh9OyIPuPw+D8fP85Fh+/paM551OR53OQIOxv9eqIuH8haaB5E3enO5kkoSxXelP
B3Ia8bnD9L04ScuUzkOKl+7FKw0lLUdjnVbOAAAAAAAAAKC5T25CiUn48YMCScGHj4UL1fGvCZcK
5Gk4WWixmGjoeVKw1Ki35wXhcK7B5qb3UJPJQovFQovJML4Bvpyq14nT6D4eajjcfcU3mSUv9/5w
+FxfZ9PxrzQNJCnQ9GqvHH92+s+GkqTg7ftCbKTCj8mtjOW78njw32kpyXv+dDOpoSru3HiF2Nh5
PY+jwTU91/3LhfLnY40zE6QOLZy/jut7stbdaqXV6k53D+nnwGmfHS50d5fkf/WQVlf5HFTHdXv9
p23V+T4dDyWfNZw/f/PjuSdPgYLlSL1OzU3/Ur6u4gFFr059NkmJ0+1PD9xJxOdW6I93vhfH37sX
mgyH8qQ4nUH9d+/7i5e6cauv2WIoaanX+1YWAAAAAAAAAJyK6FNycxmdnZ1F59e3uQ230c31dXST
fzu6iS7PzqKzs/Mof8jN5VnJuextznF5k98U5ynZfmbcnh5fzFve5jxnZ9HZ2WVkPtsDdnsdnVfU
037SGCirt9vo+nxbv2VZuL0+N2wviztLabnPryO7U7im57p/mbSOyuqwfbZ941SZ4wWnpS6u2+o/
bavL96moyWfp5/lpsf78rRzPb6ObZEwwb6+WjienXldRVNWup9qfHrZTiM+NpO3Pzs6jS2NDZ75v
pR+OJxcvNeNWFFl8rwQAAAAAAACAh+WzWKFE6qp/caF+/oe7yaoSGr4qLBHffzmJfy05var9paRZ
qHhhC0/PX5pWTuiqP1toOJxoYdxuy9e7ZbzSwWLi8atIZ33Fi5Qs9c7U0OF7vQ22/1yad9L7t/Gv
w5/tNGVJ3B2Ma3qu+5+KtG8B9+mh9h+0p63P3676F280ib90yGohiY3088fT86cPORjpT+07hfhM
hZq/XkqShouVZsaG7upitdDE6nvxKcdLzfdKAAAAAAAAAHhg/sUf/vCHP+TfdBfKny919e23+u67
7/Tdz4/062+6+qKwWyj/hx8kdfXFF1IY+lpOr/RtesyX8ftVdo757mc9+vWX6qYHhd/p9Z9/1Fd/
/3v97pvMiZJ0Q3XVzbztX/1ef/5R8v7Nq939JemLL/XP/h/1/S+P9Jvf/k7x5lDz8VTfPvq1zrMn
MvpB3/6ff9aP+kp///v0+Lyuzs+/2clTVvjda/35x6rjpXD+Qq++/0XDf3ij/+Obf5b/x+8V/PVv
9dvffVOs/zI77RIq9JeaXn1brF+F8udTXX2b1n1F3qvaqVQ27e/086Nf68vuF/rin/67vv3j9/rl
736rV+fmuwehP9fy6lvH9GLdR/+fXv/5R/34L73C+cPlf9R/+v4XDScT/d333+vHH/+lvFfnu48m
CZf6j//pe/0y/Ae9yR5fEnfW0nJ/9ff6vU17uqZXtn++n/rzTZvk+3bo+/oh/Ef95S/f68dfHuk3
3lf6axgqDMPN8VlW7ZRN/598zZM4+vnRr/Vl+EMmva/01d9+pUd/DRUn90WujizHpQzbuLUqh0no
y/8h1D/+5S/6/sdf9Og3nr76a0V9WeZHyrdbpq9alDtlm57tflI+X9Xx1Gj/DNd2KSuHVVy30H92
lYx/ChX6P+gHqbIsUoP+WFL+pmzPZ5XP3Oe5fT1axkEb/cXl87d2PP9CX/6zrz9+/4se/ea3xe8k
pZLvGt6/1//90nTelOV4mI/fe/6eVuoQ31ts4majYX1axfHuWPDdzz/r0Zfl+S5zGvGZ8Kf63+Y/
St5E/8/EdP5UV99kvxfvES9W7enQPlbjVqLqeyUAAAAAAAAAPDj5JUuc3VzGy2QXXufFxzkkS1df
3mQe91I4pmz96t1Hj2Rfm0fKlC2NbXx/e75CPhNpHtPt6bLytstYb8p43mxZ7vrHeuSX3k7/XXWM
waZdbqJLQx2fX99ul0MvtFf+ZLfR9WVaT7lX1VLpt+a0z87Oo+ubqkfelB1X9qghk/LlyeM2iN/P
x0Oq9PElxrhzULkEvYFremX7Z/qpuc+l8VW23VRPDu2Ujcfsftc3Fenl2s5lXIqiyrLs5s+hHAbb
MaT42j28QT8qqbfS/XfYln+ffJWlkRuvXPePD3Jsl7Jzn0Xnl38q3XaWbae9+09G1fh3m7SnsRxZ
Zenl8p3u69qOlVzOZ5nPTf2W9XtDPbrEwV79JcqUw/Lz12I8b/SovaQclfHhMh5m4vf+v6dVyLaf
IU237y3mc+zke2f3ZvVprptcvKT93fCyrpsoOp34TDQ+tiwuyt6PN9q3p3X7lG2PX/nT2tQnAAAA
AAAAADwU+00o2VysP4+uMzcYbtMbHIabvNmLtJc3t8mF1tvoNnOBvnBhNnshNzM54zZzE+7y5rb8
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
T8DFQ4/zh55/4BjoJwAAAAAAAICLf/GHP/zhD/k3rYWh/B9+kNTVF1+E8udTXX37nb77+ZF+/U1X
X2x3lD9f6urbb/Xdd6btUuj7+iEMFYZSt5vdstlB/g+hQknh//tKf/5R8v7NK/3um9y+X3ypf/b/
qO9/eaTf/PZ3ym8u5V/p93/+Ud6//7/1su6geyp39wvpy69+r/9r8r/rm2Tf8LvX+vOP0t/99pXO
CxdGQ83HU3376Nc6N527Qjh/oVff/6LhP7zR//HNP8v/4/cK/vq3+u3vvtnJvyTpn/67vv3j9/rl
q7/X703b9YW+/Gdff/z+Fz36zW+LbZaXq9/QX2p69a2+++5nPfr1l+p+kR6fqfvvftajX3+jsmKG
oa/l9Erffpfumz1PmWza3+nnR7/Wl90v9EVa3r/7rV4VK12SFPpzLa++dUwv1n30/+n1n3/Uj//S
K5w/XP5H/afvf9FwMtHfff+9fvzxX8p7db77C8twqf/4n77XL8N/0Jvs8Um9huqW1lOl2nbOcU2v
bP+deIjrNm2TfJ+K+9M/6i9/+V4//vJIv/G+0l/DUGEYbo7PsmqnbPr/5GuexNHPj36tL8MfMul9
pa/+9is9+mvcn9X9IldH9eNBnm3cWpXDJBlf/vEvf9H3P/6iR7/x9NVfK+rLMj9Svt2qxslytulZ
tXv4nV7/+Ud99fe/1++++aIyjvKs6nfv8lrGR74/ZOvo50f69ZfFdsurrNdcPWUOMvdPA6v2yO5f
lZ8GbM9nu59kqPe6+HHdP8Mq3jLKyuHaDinX48rSb8ayH2RUpu/a7y3ivK59Nt/rKs8R76NusWx1
569Uln+HeHRuf5v87j0+JhzOUxkXeclnoal88WZf8eYv9E8nWj+25bXdT8rnqzpuGu2fYVVPGWXl
sIrfsn6SUXZ+oz3KDQAAAAAAADwI0T5uLqOzs7Po8uYmujw7i87S1/l1dJvZ5zy7bfM6jy5vMue6
vU72O4+uNwfnt11GN9FtdH0en2Pn+Iyby+rtJvExhrRN7qXcZlVlvb0+T9IsP94sreP0uPTfhjxG
mXxmy5+T5vPceIKcbP0mbZ19nV/fZuqmom6jKM77ZVoPuVdFfqNbc9pnZ+fR9U2SdjGxKIrKjjuL
zo37m6RxVWy3uB7j98vaPm33/PtpvVq1gYlFO+9wTa9s/008bPt+oU1uo0ycml+79eHQTiX9/fz6
piK9XNvZjgcb5WXZzZ9DOQy2Y0TxtXt4g35UUm+l++9wSa+8ruL0k9028VXWbqbxzaF+9ymvS3xk
+kM6BhSPKUuxvK425anph4X3C8rTOGsjriqVp73bXg3StR6HGu4fH2Qfb1FUU94/lW47K7RDVvk5
i8c1qMcqLv0giirzWoxny35fGeeW7ZOcw/wdIfNZWthuef4qZfm3jsey7fFrNxsO+d1nfMyyOo97
XJZ+b4qiTJ3s/g1iet1P/ZTniXFv97U5XVk/iaLj1BMAAAAAAADwwLQyoSS+yHYZ3dzGV8uS/+xO
lsjc4LrdHFe86Vp8f3txLr4QmP67/OKc0+SFKJPPsguFefdSbrOySQWxm+jy/LzkgmwF082Oqhsk
tfW3vUBuOrzAWL+3mZvf59H5eZxeXL230U26LX9TIb2we369aafoNnNjyZjn7XHnlzdJu95Gt/lJ
JoXC5I7bvL09zjYmze2a1GOa55I2yU46yW1wykNBbTvnuKZXtn82HpI+FTeJoR1v43ba3Py5vY1u
k9eWYzsV4jHZ/TafXpK329vtWBBl6s12PCjEbfJuJn/xhAHHchjF+U37z+Um/+b6cupHhXqL99g5
tVGD9Gza3SWO4pO61W/T8rrGR64cl2k5otvoNnNDvjA8Feo1eTcfVzX9sPC+iU17FPJj0c6V8udL
3s2Xr7CfZbqu8eO6v2u8FcqRvJst75/+m0U7GNxH+7n2g0L6ybv59nZth9I4d2mf9DuP+XuqefKC
y/krlOXfpR4c298qv03Hx7za8+TjItlgKmeGuU1S6TmTGDyp+smXN3k33w8K+9nVi1PcNNnftZ4K
5UjedR33yvpJ4fwHqicAAAAAAADggWlpQon5onkURdHtzbVxm/mG+fb99CZ5epHX9kJ9ZDymWvWF
ZIN7KbdZ2fn2Ya6P8lUzKicaNLmYWnoDKVNPhXOlF4EzbZKep7BvtHPROF93m4kr+Q3x1m15ctsr
j7NYbWZHmvfsuQoXwHMTTErfSzflj3dkXBUm/8qUzzW9sv0r+5tpPMjd/MlxbqfK9CNz7OU4jQc1
cXuT3EFxLkcFc59P1OSnrB/V11uJpunVtHt1fopx5Fy/leev1ig+8u/nt+frr+z9KNqJq7p+WHi/
lGV7lOSnvJ1L1JwvX76y/UrTrWzfYvy47t843krKsSlvXTuUqjmuJv3SeqzQqB+UpF9ob8t2KItz
1/Yp/w5nrlfX85cqyb9zPZTkc7PVNb+V6TuoO09NXJTFZeVnoLEuTO9tHa1+aspb6Acl+5XVS3W+
DHHjuH/jeioph/W4V9dPSs7fWj0BAAAAAAAAD8zf5B+B08jwlS66+Tdj3f6FcVv/2VCS9OFjuPv+
bKGhJC1HGs/HejENJG+iN6aTlAh/CvJvVQj1/m0gaahn/fy2GidW7nb4ukrSfrlTH33FWV/q9Xw3
7xvBVC8GAw2SV6fTUac30jSQ5A21WF3IqTTDZ8o3SfexJ0nynj/Nnaurr59IUqCfkuz575aSpOEr
U7pdXbyK22L5zs+8n8aDp8luBSS6evo8zsOumuO6TxUf9kG5pjfrP4vj4cNHpbuHHz9I8vT8aVqa
rh57koK3ep/u5L/T0lg/5cLQl++Xv0JDfj3PK3nl92yRsb+lcWlrj3Yypm/HfjwINX9dHbf9fne/
cjhq1o8yHOtt7/TqGPOTj6M96td4/mr28ZFRGKMT/Zea5McF67g6nnbb2b58e6drbN98/GRY7e8a
b/blPZS969HAvh80KL9VO5RxbR+p+/S54m74fvMZLknyrxR/xXqZ+X7jfv7G9qqH1B75Nabf4HtI
yXkOEZfu2q8fM/t+sHe9GPNVETdW+7vWk315mzp6PQEAAAAAAAAPRDsTSiqF8ufj7QSDTkedwUCD
1x/yOyb6mq0n8iQtp0sF8jR5k72wl9xEb0v4XvF8kuLkhf20Xe4jSSYk6IkU5i7o63F8RbRwg6RE
PMFgqMlirbvVzLl+vcflpX/ydXFbOtkk5iu+LlwxUSidtLF8p+2l4VDxfKQnMiQhZW4U7UqPCzR9
sZ1Us329iCfWZCa8VEsuQG9uCicX3r3n2swn2UxuCfQ2uXNcnHRSL7waaTQqf13l8+tN9Ga10sr4
cm9nW1XxYK/tdrJlOx6k+auIW+mI5Wjaj5o6fHp2cXSs+k3ZxkfGk69LPh+Kk+vs4+pY2m5n2/Lt
n65d/GzZ7e8ab7blPZT969HMth+4l9+uHcq4to+k7oVeDSUFU11lKiC+YZ3/jG5w/ob2q4dU+/l1
/h5idKi4dNV+/ZjZ9oP968U1buz2d60n2/I2dfx6AgAAAAAAAB6KViaUlF9A8zXu9DSaLhUE0nA4
jF+SFAT5nbc2v0pTya+9ZHUh1jTpIM+/miqQNCy9eljufsp9WOmv87ScFi7oj6bJtp1fvmcYJxrM
dLHnLwYfFk/ekyd6YnilcVAaNjnxr7KTySLJxKf8yiO7v4I2TTqp15+ttV6Xv2buXeMBcG+n8v5e
p+F4YMW9HMfWvN5OgXv9upe3WXy4p4PT5x5vn45m/eC43NonXVllu5pBcsO69Pud2/nvn3t+y8Yt
1+8hZec5Le3Vz6fNvZ4AAAAAAAAAHFcrE0rK+ONR/PiNyVp3dyvNZrP4tVpptYgvtJuE8/RXaZKW
Iw12HrGS/vq65DEACvXxgyR5Fhcgk4v7ZY8OaOgw5T6CcK7XS8WPp1kszK9hvCLGNPuT25OUrmRj
WFI8FX5UHCqP3VbACX9S8fbW9rjnL5P2LnmZbyQZdB9vJov4798qME2SSichBW/1vmTSSb2uut3y
16flAO1Uw208sIhb6YjlsMiPsR81dez0yhyrfl3jYyuom1G58xloUa9HZZEfp3a2OJ9kt59Tum1x
jTeLchyURfqO9ejWDyzSb5Vr+yTSx0+lqxkkK8AVJzA3PP+9OUR+i9893L+HWMRFTVya/65wdYj6
MbEor2S3X029HIZrPVmUYy8W57+XegIAAAAAAADu3wEnlGwndpgevxE/msMgnOvFNJA01GK9ULxi
+Atl51akv/o0PnolfYSNzSoNycV99xvwVQ5X7kMLk0kL3vOX6vf75tfsVeVyz6dj+9iH9HEweWl5
dx8dkR63VNkj0jeruOwwPWZiT5nJIq/j5zIZluHOPPbmxVsFJXGH1AHaqZLreFAft7FjlaM+P+Z+
1NSx0ytzrPp1jY+M0jE4XbY/+9iu+no9rvr8uLVz/fli9fu5pdsW13irL8dh1afvVo+u/aA+/Xa5
tk8q/Xxe6vU81Pz1svRzvNn578up5rc+LsrishsfWCJ91IqtY9VPfXlj9fuV1cthudZTfTn2U3/+
+6knAAAAAAAA4P4dcEJJynSh0NfVZimOrFDzF1MF8jRZz9Tv9jVbxI/9mL6YbyePpM+wzj2bfnu8
3SQR87Ps23KAcjcRhpbHJ49L0VCvKn8y2Vc8nye+QXLK+i8n8Qofpok5mwk8nia55Wk2y9SPxvJz
x4X+WCPTfJJMeqbjpFDzwUDj4oYK28kiQSBp+EyF+1DKPPYmCHI3kT935l+Ztt9ONuzHg8q49cca
DOJ8H6sclfmp6EdN7Z+eud1dHat+Y/bxsbXUaOwXxvd0pYf8eFFZr5m4ap+5PSrzY9XOuyrPZ+g3
xv0apNsW13irLIexPc3tUM98XGX6jevRvh9Upm8s/35c2yfVvYgn4QbTnqaB5E1eGj/Hm57/8Krb
/9TyWxkXVXGZrgg3vcpN1Au3Y6rR/dZPZXkZ90rbp0zl+VuupzDMJwAAAAAAAACcrgNOKOnq4lV6
Y36g8dyX7/vy52MNOuaLs/44veD+ZrsMdH+meG7FVL1xepk3nXAhLUcdDcZjjcdjDQbx8fImelM5
KSK+MBg/3sViJRMnhyy3I3+sTq+nXmdc8kv2DP8qrruSSQtZlSvEnJLuRbJUfqBpbxsn4/FAnV48
8Wi4WBWXHO/Pkkf7LDXqDbbHDQbqjZbScBhPaMrrXuhNvL69Rkl6c9/XfDzWoNPTNAj04WP+oGrp
ZBEZl8lPpCuZyK79Pn3biTjT3mDT5uP07sAB2qmc+3iwzV8ubgcDdUZLBcEHfdzZ78DlaNqPmmqc
Xk27uzpK/TaIj4Q3HMpbjtQbpGUdazDoxBPevKEWs/wNU8u4ak1NezRu5xK25Ws73ba4xptteeva
oVTNca3WY4N+YF3+lri2z0Y6CVfVE5gbn/9Q6tv/tPKbaBqXm+9RS406mTG109NoOdSw8KXvROrH
th80rZdDc60n2/LWtU+ZI9WTP+6o1+up0/TvOwAAAAAAAODYon3cXEZnZ2fR+fVtfsvG7c1ldH52
Fp1lXueX19Ht7XV0njn2NjnX2fl1VDzbTXSZHHt5s3239NzZQ0vcXp8XzmftnsuddXNZsT0999ll
ZNqcVXmegtvo+jyzf1ImcxkaqKjfqnYr23Z7cx1dJvndvM4vo+ub4vmzbq/zbXgeXV7fbtsln1Di
9uYyOs+ntznWVVrX1W1YVvYdFfVqxbWdXdMr27/s/UQcu+fR7ubb6PoyrpNtm+/m27qdatLftlE+
D1u248HuMSVxm9vVuhwVbOKnND9l/ai23qo5pxdF1e1ekx9zHDnUb835qzjFRzad22Id1X0GltZr
elBZOcrer1TRHukeZfmpbOdypecrtGvJfmXp1pS/ED+u+yes4y1RWo6d3evbwaz+uNL0y+qxglM/
2BxTkn7TdqjZ37V9oijafnZWDbCJRufPKst/2fuJQj1EkWX7W+a3Jn1rlucpjYvKuDSV9zK6uU3r
J/89zLT//dRPaXlzpyvdr6xeavJViBvX/RPW9ZQoLYdt/Nbks/T8LdVT+jeXzZgAAAAAAAAAnIJf
RVEU5SeZHET66JVut/ZRNM4Oee593XfewlDq3kvKJyhUGDZoi6QNu871mKSnLk1wb2zawGafljQa
D2zj9ljlsM1PW5qkd4i6OMQ5c2ziwx+rM1rKm6y1Sn8m3WiMalKvTdnUXdv5sT2f7X7HZlNnWTbl
cD1nyuY4m/Qt2fSDghbTt2JTJ/s49Pld2OTFZp/70CQuXI+xKbvNPm2wzbvtfsfmWk825XA9Z5bN
+RsK+fsMAAAAAAAAD8fxJpQAAID9mCaUAAAAAAAAAAAAAAfwN/k3AAAAAAAAAAAAAAAA8HljQgkA
AAAAAAAAAAAAAAB2MKEEAAAAAAAAAAAAAAAAO34VRVGUfxMAAAAAAAAAAAAAAACfL1YoAQAAAAAA
AAAAAAAAwA4mlAAAAAAAAAAAAAAAAGAHE0oAAAAAAAAAAAAAAACw41dRFEX5N12EYZh/y6Crbjf+
v3j/7b/LhYp37ap2VyuhwrA+XVN5unUHteLU83cPwrnGL97qw5NXWs36+a37CUPF4VVdd2EY1sdg
GCq0iml7pnYuajfNByP0NX4x0jKI/+kNJ3ozu6huo5MSaj5+oem2AFq8man/cApwv/yxBq8/6Mnz
N5pd3HelhQr9eCyRuur282NF8jlmqTge2X0uAAAAAAAAAAAAAIew34SScK5Bb6rktmg5b6L16kLd
dP/03/n9MsL5QL1pIG+y1mrvm4ah5oOepoGnyXql0tNVlseTN3ylN7N+Zb6bOfX83ZO0vMOF7lqe
UOKPOxotVR1f/lid0VKqTN/XuDPSMhvT/liD5LhGE2Eq2zkjTdM1Pdf9T0pS35LkefIUKHhS1T6n
Ju3rivusFyhQ/XiIjKRfVvbdQ8tNasrKTnBKxxk7+fHf8nMB7XjQ4yIAAAAAAAAAAMBhtPTIG0/D
4bD89fzr/AHH5V8lN3ADTa/8/FaDfHmSG9fLkXqdgeYOvzi3cur5+wT1nw0lScHb98nqAkXhxw/x
/yzfqbRV/HdaSvKeP91MCAg/flAgKfjwsfTcdvLtbO5Xrum57l8ulD8fazye73kee+H8dVzfk7Xu
ViutVncPaDJJpq8PF7q7S/LPZJKHJZxr0Esmk3hDTSYLLRYLLSZDeZ4ULKfqdcbyJXUfF/ut58Wn
8fL9efhcO5+Uzp8LqFY9XrU3LgIAAAAAAAAAAHw62lmhxGLFEclt/zZXKNn9lfhQi7uZjLegK/MX
yp+/0GgabFeG2Nne3Knn794ccIWS7UoXZfWdXUlCGi7uZMpCGqe720P58/fS04tmjzGpbGcT1/Rc
9y+T1lFZHbYv7isPd8UGc7zAyT2vULJZ3ci4kkUof9yLx/OSccs2hq0/F2Cpbrxqa1wEAAAAAAAA
AAD4dLS0Qskp8/Uuubm3mHiSlnrdaAmPrvoXbzTxJAVTtfeD8VPP36eqr3iRkqXemeoqfK+3mcdZ
LM076f3bQNJQz3buTnbVvzjmTUnX9Fz3PxWh0kVjgPuRxqCn5y+LUxKkrvqzhYbDiRbG7bba+lyA
vYc6LgIAAAAAAAAAABzOJz+hJH1ExvBZX/2nz+XVPOakWldPn8fPK/jwMXuGUPPxWGPf/azHyV+J
MJTv+wpDSQoV+nONx/EjAfz4zXTH5FEB6bbMppww9OO6MJ6nTDbtseZ+aF3+0J83SC+WPvbGNFkk
fP9WgaThZKJ43onhsTfppJPhs91fuyf1WlVPrXJNr2z/nXiI6zZtk/Hc32mT0Pfl++/1kyTpgz76
fnzOzPFZVu2UTT8TR3M/zKUn/fQ+Tc8UK6H8eXneTWzj1qocJmGc3/dJAT58rKkvy/xI+XbL9NW6
cjsc51busv6ctGP+2KRu8m+n4rY3tXMZy/Z3KP9WqJ8yE83M+prN9puY0O7ngmV9SIW2G8/Lxnvb
/WJO8Zxhd1x9+azGq7JxMcMuPwmH8RQAAAAAAAAAAOBkRfu4vY7Oz86is/Pr6Da/zcRh/9vr8+js
7Cw6v67bs8ptdH1+Fp2dXUY3O/8+j4yntcjfzeVZIV9pXrfp2DpO/krdXEZnZ2fR5c1NdHkeH5d9
nV/fbtPceZ1Hl4WC3kbXl2k95F4V+Y1uzWmfnZ1H1zdJ2sXEoigqO+4sOjfub3ITXZ6dGdstrsf4
/bRO86dN2z3/flqvVm1gYtHOO1zTK9t/Ew9pHOZfaVyWbTfVk0M7ZeMxu9/1TUV6uba7uTTE61lJ
zEaVZdnNn0M5DLZjRPG1e3iDflRSb6X7p6yOcyx3VX++TdLJHVfaj6LIMEZWxG+yzbr9rcpflI4H
Z+fX0U3VjiXi40vG+CgylLnmc6GKS32k7WN47dS17X7xzu7xHEX2/dKqfOXnOsvGXVVcNSmH9XgK
AAAAAAAAAABwuu5thZIwDKtf+QOaKKwg0dXFq6GkQNNGz4RJHkMg6cnX25+fdy9eaeh58vIrVdQ5
Uv7qLEcjLTXUYr3W3d1a60m8ykkwfaHBi6kCb6LF+k53d+vk8QuBlq/nmTYKNR/0NF0GkjdJznOn
u/Vi8wie3iC7f+a4FyMtA8kbLrRO0livFxp6gaajqcyLAYSaDzLH3d1t0ht6UrAcaWD1eIiyx94k
9eg9VrdiJZPwJ9Pjbh6+5ainaeBpsljHdZu2owJNX8wVqquLN3E7xe/HsbNOXrNNfTRrp+VopKU3
TGLuTm+e9nPpJXlbr7Vez7Z9LpxrMFoqSLbfJemtF3GfWo7GuVVmkrgNlMRtsn8mf/GqQ83KkdW9
eKP1Ou0/0nCT/3x9NelHsW29xcet31zIZhQoP8613L7GvYr+3BspGZ4Ow7n9Y+XlN+vPFvGqRcFU
o15Hg0G8Cktr2vpccKwP/ypuH2+ybev1YhKvjjJ9obSpbfdrHs+W/dK6fLbjVZmm5YjVj6cAAAAA
AAAAAAAnLD/DxIlx9Yr8K/PLcqv9d1/mXwvbMf/yvXxVisqVIW4zqySYtjdw7/lLfkFtSiv7K/zd
cxl+LZ+ep7BvtPPr8Pwv4jerNuQ3xFu35SlZ0SD/frIxibFimYzSvOd+9b4be0mb5FduKLyXbsof
78iqn1iu2GBStv8mHky/nE/jMrstv5LCLud2qkw/Msdezu3NtXGbcZWZmri9SZafcC5HBXOfT9Tk
p6wf1ddbiZrjXMtdub9FfzYeZoqxsvht2v4l5a92G91cnhf66fn5ZXRzW32yuhVKzPVR8blQwb4+
Ks5/e5NZicV2vxbiueS4tF9GTuWLzLGUVRZXNfmpLYexrU3jKQAAAAAAAAAAwOlpbYUSz/NKXvk9
JcnTcDisfhmPc+Hrahr/ovjlzi+Qt6tSvC5bVSCY6sVgoEHy6nQ66vRGyS+mh1qsqn/BbueE8mdY
WaX7OG4A7/nT3Lm6+vqJJAX6Kf3FerIsyvCVKd301/X5FT5CvX8bxKtN7FZAoqunz01BUHNc96ni
wz7oY0n17eg/i1cb+PBx80vx8OMHSZ6eP01L09VjT1LwVu/Tnfx38a/0C/VTLgx9+X75KzTkt9if
qvpVS4avdFEoVBqXtvZoJ2P6drr9C+Ox6SozHzaJhZq/ro7bfr+7XzkcNetHGU3rzXica7lr9i/t
z+2yb/8MY/nrdNWfrbRKVs6YDL14hY5gqVGvp07FihXV9vhcMLCvj2SMM52/21d/cw7b/ZrGs22/
TP5lXb7mmpUjwxhfruMpAAAAAAAAAADA/WhnQok30ZvVSivjK/NIis3+z/VyNtOs4vVy35uPyQ1/
PZHC3I17PY7v5ARv31vd9Itv4A/jZfVN5WnihPLnPS7c7dowPTonnWwSSx+zU/Hol3TSxvJd5hEL
oX4KJOmJDElIkrpPn6sYBelxgaYvtpNqtq8X8cSazISXasmNvc1kkeTGuPdcm/kkm5vhgd4mM0qK
k07qhVcjjUblr6t8fl37VUuq4sFe2+1kK5Q/H28nWnU66gwGGrz+UNgvzl9F3EpHLEfTfnQoruVu
2p/bZtv+7el2+7pIJ5cshnEZg6le5Cdc2GjxcyFmWx/xxAhPUjDtqdPpaDCeGx7lY7tf03i27Zcp
2/I11bQcW+2MpwAAAAAAAAAAAPejnQklJyj9VbGW08KN+9E02ZZdcSLLeCN/povsz6/3dOr5O32e
vCdP9MTwSle5sb2PF/+aPZksEr5XPJ9kd+WR9GZ4fDPXNOmkXn+21npd/pqV3bB80NzbqfkNWF/j
Tk+j6VJBoO1qR5IUBPmdHbmX49ia1lv1cadf7q1m7V9dfjfd/kyrRTLxY3plnGBQZa/PhQLH+ujP
tLpbazEZyvOkYDnVdNRTpzPQODthxHa/g3MsHwAAAAAAAAAAAJx9mhNKwrleLxU//mWxML+G8YoT
0yvXW34tOPX8OUkfgVDxyI/woz5Ikvc4M0kjPa5C+JOKtwW3xz1/WVzZJvsqPmagRPfxZrKI//6t
AtPKLOkjPoK3el8y6aReV91u+evTcoB2quGPR/FjiCZr3d2ttmmsVpub/FsWcSsdsRwW+TH2o0Nx
LXfT/ry17+NJ3Nq/udCfV08USVescNXy50Kz+uiqfzHTanWnu7u1FpM4veXohXYXXKnbr2k8WxyX
aFY+Vxb5MZYDAAAAAAAAAADg0/BJTigJk0kB3vOX6vf75tfsVeUy9Yd06vlz09XXT7Rd4cMgLa+e
fL1z4zA+bql3JQXc/Fp/xza9/R4xkpGZLPL6bVDyeIPMY29evFXg+Libz88B2qlSqI/xXV1ju8SP
KMqqj9vYscpRnx9zPzoU13I37c9SNz6wRPoIlDqu7d9MOB+oN5pqNC4ppDITDBy1+7nQpD7C3KN0
uupfrBTPzcjGgc1+TeO5/rhYk/I1UZ8fczkAAAAAAAAAAAA+DZ/ghJLkcSQa6lXlkgF9PYvvzOn1
7k+vmwnzN9nK3FP+Dqj/chKv8DHN/4pdUjjXi2kgydPk5e4sjfhRM9JyNFb+SQmhP9bIfP95k57p
OCnUfOD66IXtZJEgkDR8psJ8EmUeexMEkp4ov4jJ58v86/3228mGaQKEr6tpcVZCZdz6Yw0Gcb6P
VY7K/FT0o0NxLXfV/lX9ebNCUOERMeFmFQp79u3fRPcindAx0mDuG8b8UP7VNJ5gUDKOmB3qc8Gy
PsK5Bp2eelUTZeSw3x7xXHlcpl/GLMu3wzxelanMT0U5mgjDfAIAAAAAAAAAAAD369ObUOJfaVox
KSArndAQvH1vuDHowB+r0+up1xnX/Gr8nvJ3aN2L5BEDgaa9jgbjscbjscbjgTq9+ObqcLEqPhKk
P0se4bDUqDfYHjcYqDdaSsOh+dER3Qu9maTHxenNfV/z8ViDTk/TINCHj/mDqqWTRSRpWFyeJJau
ZCK79vv0bSfiTHuDTZuP07uuB2incl1dvEonKA00nvvyfV/+fKxBp2RSwiZ/ubgdDNQZLRUEH/Rx
Z78Dl6NpPzoU13Lv7G/oz5636WM7Nv1qqVEnjaM4jdFyqKFxEMhr0P6N9DVbpxMMRup1dtspzrMk
DbWYOYwQrX8uONZH2gbLkTqDcbL/XOPBIC6PN9HLvsN+2iOerfqlY/mk+vGqTNNyOPLHHfV6PXUs
JusAAAAAAAAAAAAcyyc3oSR9rELppICs/kvF962mujrSPZxTz19j/ZnWi4mGnhQsl1oul1ouA8kb
arJYq+zean+20noylKdge1wgDSdr3c2e5Xff6F6stF4M5SXpTUcjTZdLBfI0nKy1cr27t7mpbXrc
TSq9IWnZfp+B7sUbTYbxTdq0zZeZG92tt1OV/ixOS4GW05FGo5FG06U0nGidTALIi/OXi9sgidv1
9ibx0crRsB8dimu5N/vv9OdA3nCh9ZvnO/tudXWxWufiaKnAG2qxnql8FMhp0P6NdC+0Wi+S/O62
UyDJG060vpvVTgzJOsjnglN9ZNogWCb7T5O2m2i9ukge52K7X6JhPFv1S6fypeetHq9KNSwHAAAA
AAAAAADAQ/erKIqi/JtoIAylbks3lR+8UGEoqdvdvblYJ3lsUNe5HpP01KUJ7o1NG9js05L0EVRO
MWgbt8cqh21+jsWx3Pn+7I/VGS2l4UJ3pXfgWypzo/ZvKPO4M/ex60gc62Pz6JWa/W33izVtW4vj
HMvnHMs7LPLTFN8jAAAAAAAAAADAiXk4E0oyN+3KnOzNPAD4zIXzgXrTQJ5hZRMAAAAAAAAAAAAA
p+eBTCjxNe6MFD8UoIy384gKAMAR+XMNRlPJOGEkHcMZpwEAAAAAAAAAAICH4oFMKAkV+hYrlPT7
7S9BDwCwkJn45w01ef5MX38tffz4Tm+nSwUSq5MAAAAAAAAAAAAAD8gDmVACADh5oa/xi5GWQX6D
p+HijWZ9JpMAAAAAAAAAAAAADwUTSgAAAAAAAAAAAAAAALDjb/JvAAAAAAAAAAAAAAAA4PPGhBIA
AAAAAAAAAAAAAADsYEIJAAAAAAAAAAAAAAAAdjChBAAAAAAAAAAAAAAAADuYUAIAAAAAAAAAAAAA
AIAdTCgBAAAAAAAAAAAAAADADiaUAAAAAAAAAAAAAAAAYAcTSgAAAAAAAAAAAAAAALCDCSUAAAAA
AAAAAAAAAADYwYQSAAAAAAAAAAAAAAAA7GBCCQAAAAAAAAAAAAAAAHb8/7luy3vOuMGOAAAAAElF
TkSuQmCC

--_004_OSZP286MB15101558B02308C9DDFB940FD5F12OSZP286MB1510JPNP_--
