Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C46CD11C2
	for <batman-adv@archiver.kernel.org>; Sun,  7 Apr 2024 09:47:10 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 96DC881AF9
	for <batman-adv@archiver.kernel.org>; Sun,  7 Apr 2024 11:47:08 +0200 (CEST)
ARC-Seal: i=3; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1712483228;
 b=Atfdh8Lg1HvXI+sLw8JLh6NsvluY9++GO+AyX/c7YlcExVQZ7xWbEShfaz9acQMxWmZRj
 OtuQsseHg9ZvYEz4g8BGG9RQSBHeA/z3FNvAnKFz1kYrqw0n6KwbMdhAVcGlaIADJR4RaR9
 ESRaKRwCRDBuHC40hVn9R4RcKkf4tn8=
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1712483228; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=yzfT/TRahcV3Kbbuc977wlXuNPFfkjEPGYdG27pRzMc=;
 b=06At2LxDPmvvuce2nFC32cHN7X2SdVMGJQ56zPq1y2uX9lgsSz5UmUxp4PRl9FIVYt7AY
 ODygZbZVcfOBtWQJt8fEE9I77eru/2Pof29wQZyJkhPJwZb/OMW/QHGO91guyTHVz+l+WWK
 dTYKksZ2CyxEAXy6Usy4PZ0TGE2UKhY=
ARC-Authentication-Results: i=3; open-mesh.org;
 dkim=pass header.d=outlook.com;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=outlook.com
 policy.dmarc=quarantine
Authentication-Results: open-mesh.org; dkim=pass header.d=outlook.com;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=outlook.com policy.dmarc=quarantine
Received: from AUS01-ME3-obe.outbound.protection.outlook.com
 (mail-me3aus01olkn2185.outbound.protection.outlook.com [40.92.63.185])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 07AFF8015A
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun,  7 Apr 2024 11:46:52 +0200 (CEST)
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1712483218;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=yzfT/TRahcV3Kbbuc977wlXuNPFfkjEPGYdG27pRzMc=;
	b=O0+PihFjjfDBOvKF+3U9IqzpaPg1XXBIFacsVRADBlwapHpnF9r3TgjwE/itR/F0uenEIX
	Ju7UO916kyF4gQYC7+C2JPEWmdm0Jl09MIHshBaKtdPkn01lqUdbq0ZiYzaM70LBtNRhFp
	1CRXfvQK+nnEibQdVSLTMRn9WUWEMyM=
ARC-Authentication-Results: i=2;
	diktynna.open-mesh.org;
	dkim=pass header.d=outlook.com header.s=selector1 header.b=nOv0aScl;
	spf=pass (diktynna.open-mesh.org: domain of mrbianliunian@outlook.com
 designates 40.92.63.185 as permitted sender)
 smtp.mailfrom=mrbianliunian@outlook.com;
	dmarc=pass (policy=none) header.from=outlook.com;
	arc=pass ("microsoft.com:s=arcselector9901:i=1")
ARC-Seal: i=2; s=20121; d=open-mesh.org; t=1712483218; a=rsa-sha256;
	cv=pass;
	b=bN4KiuP9/xIooihyLXDBCG/5BAQmg++Axh0RopGWxOPXOCScjwfmECFhABOAXb7L+Q9T27
	lyTkSCYPOWsBL8T6KGmTx+6lv/+thJBDgN6Jdea51NvBPKbPdwVLyxXBCoV3KHt+oRqe0p
	Zf37N8xnnIP/bpp0r18aIPC8Dxw/q9A=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5aD0VLCpMmJfDhHJ0S6ez5N2k3bu8kGxvV5ntscQd/+DHD07qX+6431pHVpNlk0KyhbGbuPytqFDwYcv5ET91YPAl6lEQXXx8u+4jnzHr0tfI2nPLNfhdtTt30SNoHvlQS63SAmex1Y+6hGR7VsEYnQ/7AADp8LDoe6UZ54n2pTagIMfCuIAFTY+fejY+ckSeanBaq7D6uCJZyeOqkh5tQMrmraR0oKVLNqNpXaRzMw7zpTRLjhE6ME7WBfqI4ySGTMZGenmBShTMcC6E53GrBAXHYy8f5Bh/jKPeuzzK7OcXLZOnbe9pg8TRqeIlI2D7TWYUNHoeeOexHRKgkGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzfT/TRahcV3Kbbuc977wlXuNPFfkjEPGYdG27pRzMc=;
 b=KUbcJgk3LN5D5qpie9jvY7Jd8eazFSYpuNMiNelE3zCis0B6i9Gpy4xcjmau+b2cYDhI69PU8Vf42hg81YuknlvC7NlrxtGq2NOYc3dVmhvQ39ZglnlrcgXCMQijUf64oesKreUX/5ws4PwnO5RiwM1jBl4dLN8cA9J5lvNW2OCRVZaDdf8XMs25dUnqz1qa8spA9rGsVykdMl0T9Z5nobjfahEnC4x3FOyURQEKu843OqLZZnRWmnAxWoBP9MZrVuR8BD1Dl+77R5JA1EOdGO70euPRLGvB5hu5fEdCQehE07CWAJmUq6HL9qWr/JxJAMRrAjzbe8Qhsc8LzewAIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzfT/TRahcV3Kbbuc977wlXuNPFfkjEPGYdG27pRzMc=;
 b=nOv0aSclyXG2IoQE7l/Jtq6/ktpPbyem7IqvzoRpFd1+sJOtToj4MTOTnex/59We6mNtik07Z523MkNE6R7+SnBWXrAG6lKGgf+5ks6bwBHdfiWqrdXZrQCCdh9VfwoRBoFpDKyNwb7seLvZjS8CwTMoAcQLHwhO/zCApk4l57ZLgQXxaJmeI5Ubd4gOpUDqNIFFmxEuM0JSD7cEihZgflM4WO4XamIEY6RLdr95gSZx9HsAoX7fucK2D+NpN7g7VWtUZyX6EMA5Z1ps5FVw66rDM3Y1CHz7O86yH5LHQYNxjOQE9ac0o0Q+o5btQwx/83oU3xrmyYvSgacJowkbJw==
Received: from MEYP282MB3123.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:158::11)
 by SY4P282MB4235.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 09:46:49 +0000
Received: from MEYP282MB3123.AUSP282.PROD.OUTLOOK.COM
 ([fe80::2af3:f9c8:3abc:41c0]) by MEYP282MB3123.AUSP282.PROD.OUTLOOK.COM
 ([fe80::2af3:f9c8:3abc:41c0%6]) with mapi id 15.20.7409.053; Sun, 7 Apr 2024
 09:46:49 +0000
From: Liunian Bian <mrbianliunian@outlook.com>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Subject: How to cite the BATMAN routing protocol in a research paper?
Thread-Topic: How to cite the BATMAN routing protocol in a research paper?
Thread-Index: AQHaiMy51Xd00v+L2kat72DCC6pMhg==
Date: Sun, 7 Apr 2024 09:46:49 +0000
Message-ID: 
 <MEYP282MB31231B4B48B7D9960334CEE4BF012@MEYP282MB3123.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn: [2lHk7Dqx2KTZ+yMy+dXACI6p2QT7juL1]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MEYP282MB3123:EE_|SY4P282MB4235:EE_
x-ms-office365-filtering-correlation-id: 01f67654-be78-4e8b-c5a2-08dc56e7a5a6
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 BUKwsqfHTRuS2RobP+HR+c3kAOC+xcDcB8A7P4Kr9upPrsykyp1f+pjOT/pdZr+6xRqGuJm4fVishNMaqyEocNRURfZrF6hrdEkC7DAeiAfzOzv3hSCSOZWZJebBChdT6Ln/oqA6ObUjbDRjJyw+6vrSthRAvs4QDZP1F6B79UFhwtARNVY5MZ4RIBS/eus5OeVAl39SEgmFqBXMp5jSLH37RIk74Xtxc7fUzHMi4YpcCGBfGSg2MriGSgoaTEQm+LnZN6jWKGf9+tAhfiyr5SEOuV6lEtsTxCRLRe+nbHEGdYVKuLQFiD1PRXeEG3gMR9sgSQhWrMKDwVt/mZb5ARyzW1Myl6u0yQCIQEbIy4spdvuh+ZXzL7kjtn6YDayrbwDf3ySiIGpKEzJtQ3wUyS+WnL5UA6xY2WVaqz7kQdENbfuQfC5aqGDmIwW/Bz+X7BE6GHF/2/znIL9+C5GRzS7JcuJAeN/+CzRzgz9csTruwGMCoRzZOJja3U1tqaoluiTvDzhydPL7KbuFToKrjOXWi2cQ0FqKusvAvvf+Rs0YJbYDjty++3fnY9hmKZXH
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?gb2312?B?NWZ2T0VBZGtyK3VJdmNTaXdrUU0vbElNSjhJb2hWY1dyYmJQZnFTZDJIc2J5?=
 =?gb2312?B?b3YwUVhHT2E1UlY5M21ScmcrSElyVjljeENjSmVzNStrcCtSU21vNENGbnEv?=
 =?gb2312?B?QmVFKzd1a0hGSTl4KzVZa210TE9ZcDZCRDhTT2RVcGZkeDQ2QjlRQm9tc2hj?=
 =?gb2312?B?eVBNclROUkhueityVko0SXRSZ3NzSUFFdGFqZ1pjUUVweTBoUmRaUHkwSGVk?=
 =?gb2312?B?SmlDbWV3SnJHTGgwS24xMmFuZFd1UUlWY2xYM1U3ck54Rk1SV2RkQnJmcVdm?=
 =?gb2312?B?V3FUa2RCSW55a3NIVno0Y2kyNWkrbGlSQXVQNVBCeG9QcGdzMnJsVWdxcCtr?=
 =?gb2312?B?c3JmVnFMeG5MVDREc1BEa0JvejV0aVNNcUJJYmJHd1FTQzBlM2J5dFQ1ZW1y?=
 =?gb2312?B?MUZ5MWNXc25SdEVMdGJjNlNDcU5jZTRRUFpDN0RBZEltYkNsUVM0eEx5bVpE?=
 =?gb2312?B?alRhdmdidng5N3NIbWtaWks1YjlZWTdQTWNsNis5S2UycnJ2dloyYjZsZGxR?=
 =?gb2312?B?T29Dbm1rVk1SajNKWWF3SVhjc0IvVHBIVHdQZk53YUN1QVNucVRIdVNoVk9D?=
 =?gb2312?B?dGcxRXdlN0U4ZmF1SjVJdmVETVNnMXJVSUNvS2ZjeHRpTW5US1hRS0xGRjR2?=
 =?gb2312?B?TFExTkQ5Wk81SEduTnpvSUt2dUlIQVFMY0FpRFlaalJ3bDI3dHRLb0Fhb0Yy?=
 =?gb2312?B?WVFmdzNkYmpsMmgyMXRubFBJMlAyakRaL3krYURwVjhjbElEYytzYXEwMVVz?=
 =?gb2312?B?WWc5N1A3dnVIejJIUUxnTzFiaG9LZVBrMEZ4VWtlMFFHeHFDSlVsclMzMzcy?=
 =?gb2312?B?OWFma0hBaHN2aUYyRlJQSGdFcytWeTc5NkhuWDR4K2x5ZENZVE14SmxZNUVO?=
 =?gb2312?B?bjZ5U05TYjFteU5OWXR6WStuZVJkVy9OU1A4dmo1Nm9GNnFmTG1QaytaYkFJ?=
 =?gb2312?B?aGo1ekRYai9kMEVqZXZ3QThSMjVsSUFlN3JHZU9OR1NTdGd6c3RRQWhYMFVt?=
 =?gb2312?B?Tmo0VVZFRlBQSk9zcDBQUFF0WmVSMlcxaWJQdldnd05PdGdNa3J4azhPWHZo?=
 =?gb2312?B?Vk9RMTJVN1FYQmZBMDZHNUg2cG5XUUFBU1k3cXgwdWpjcG1FOXNheUdvMTFx?=
 =?gb2312?B?NHBiek5jVGxLUTdBT3BYSG9QRVZSQkNQUkhpeldTUjNJclAwOHpsbkFLLzk0?=
 =?gb2312?B?V253T0FyZGVscHBDakJkRFdnTThMZ01odXNzU05sTW9samYzSHhyc0hvUVJo?=
 =?gb2312?B?TklsNnpXL21RRHVDWk5GdGtOc20rL3hCU2IyZTB5UHVDRG9GWUY4c096T3RT?=
 =?gb2312?B?cS9ObHFzbUx2WEM0RWpHeVNoU3E0MW5jaVBneW85SjNDeGtBMkJiTEhrVG4y?=
 =?gb2312?B?SnR6MnU0VFJOVFo0a2ZHOXN0QmJJU2NxRUR3Q3NNeFpOR3k2SkZBdkN2ZEdV?=
 =?gb2312?B?S1oxNUJVNGVtOTFmZW5QUjJpTUdFVUVwSDNBYWpaZE1CTU5VSzV6K2N6a0Ny?=
 =?gb2312?B?Qk84OU5aOGprLzFTQzV0bXJPSnloQkZjQlBXUzgxUzNJdS96ekw0RjQycVVG?=
 =?gb2312?B?WDhFQnp5OEhQeWYrZ0ppMTYrTzZWQ2FmQVJKTDR5c1JhMHhKaHhwVDB6TEoy?=
 =?gb2312?Q?t09mb75nBhpOHKLswLS+fh/h15dIwH2TPFg9/dWmK+AU=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MEYP282MB3123.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 01f67654-be78-4e8b-c5a2-08dc56e7a5a6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 
 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 09:46:49.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB4235
Message-ID-Hash: RZ6N3ATVJSYUMBZWQPCLI4UYO4U4VJS2
X-Message-ID-Hash: RZ6N3ATVJSYUMBZWQPCLI4UYO4U4VJS2
X-MailFrom: mrbianliunian@outlook.com
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/ZAKWBK4BEK5QZWVPVQYX63CM5JIYUZYC/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

U3ViamVjdDogSG93IHRvIGNpdGUgdGhlIEJBVE1BTiByb3V0aW5nIHByb3RvY29sIGluIGEgcmVz
ZWFyY2ggcGFwZXI/CkhpLCBJIGNhbm5vdCBmaW5kIGEgcHJvcGVyIGNpdGF0aW9uIGZvciB0aGUg
QkFUTUFOIHJvdXRpbmcgcHJvdG9jb2wuIApUaGUgY2l0YXRpb25zIEkgY291bGQgZmluZCB3ZXJl
Ogo+IEEuIE5ldW1hbm4sIEMuIEFpY2hlbGUsIE0uIExpbmRuZXIsIGFuZCBTLiBXdW5kZXJsaWNo
LCChsEJldHRlciBhcHByb2FjaCB0byBtb2JpbGUgYWQtaG9jIG5ldHdvcmtpbmcgKEIuQS5ULk0u
QS5OLiksIiBJRVRGIERyYWZ0LCAyMDA4IFtPbmxpbmVdCj4gUi4gU2FuY2hlei1JYm9ycmEsIE0u
IC1ELiBDYW5vIGFuZCBKLiBHYXJjaWEtSGFybywgIlBlcmZvcm1hbmNlIEV2YWx1YXRpb24gb2Yg
QkFUTUFOIFJvdXRpbmcgUHJvdG9jb2wgZm9yIFZvSVAgU2VydmljZXM6IEEgUW9FIFBlcnNwZWN0
aXZlLCIgaW4gSUVFRSBUcmFuc2FjdGlvbnMgb24gV2lyZWxlc3MgQ29tbXVuaWNhdGlvbnMsIFNl
cHQuIDIwMTQKd2hpY2ggYXJlIGluY29tcGxldGUgYW5kIG91dGRhdGVkLgpJcyB0aGVyZSBhbnkg
cmVmZXJlbmNlcyBJIGNhbiB1c2UgZm9yIGNpdGluZyBCQVRNQU4gSVYgb3IgQkFUTUFOIFYgaW4g
YSByZXNlYXJjaCBwYXBlcj8gSXQgd291bGQgaGVscCBtZSBhIGxvdC4KCkJlc3QgcmVnYXJkcywK
TGl1bmlhbiBCaWFuCkVtYWlsOiBiaWFubGl1bmlhbjE4c0BpY3QuYWMuY24=
