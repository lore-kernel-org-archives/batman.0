Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B642C4345F
	for <batman@archiver.kernel.org>; Mon, 29 Apr 2024 14:22:36 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 472048224C
	for <batman@archiver.kernel.org>; Mon, 29 Apr 2024 16:22:35 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1714400555;
 b=BWQT5JO5thqvsVs7cejg/+jlEhCXry1vnKwmLK9Z8VKrnKpBIJz+bOHNgs39O9LyD3Wl9
 O/d10llc5NDytZych9t3Ei+3M59ywBggFXzXfmMc7v1c4++t+ejVgaDWYLKZ/qGkrsjf/ov
 FUfqwftyGqk+FZJZMRlHSNY3VBXUjKI=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1714400555; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=0qeoI22i/bxqZgNQYc8Vz3tFNMFwK3o65+8przx1hNY=;
 b=1F74koPb26dVHYRv+amOO5jSGCara+V/LvWafRQF4YOxleMXisLCCAuWu96tMOO8rHlWX
 Lg+v+qcfJrR5mL4y9g2MD0x6bJtK2cPBgyjSA0K7zXdDbatoNhsIPL9wQoerAn60kYLMkEY
 v5jInHdr7uWP5NzJ5E+JV+BIXAiHklE=
ARC-Authentication-Results: i=2; open-mesh.org; dkim=fail;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org; dkim=fail; arc=pass; dmarc=none
Received: from mailg110.ethz.ch (mailg110.ethz.ch
 [IPv6:2001:67c:10ec:5605::21])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id C4D4881560
	for <b.a.t.m.a.n@lists.open-mesh.org>; Mon, 29 Apr 2024 16:16:22 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1714400182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0qeoI22i/bxqZgNQYc8Vz3tFNMFwK3o65+8przx1hNY=;
	b=DFKuvwdHoZLm6feeru+/AmdTdNSLaEQmeb9WrCGX8aXyMBLdy1Zv0q5kWnuoPtiBZjA36C
	tZtnVggCY6Ip0qfbg9PUfB+6DyGlFGcFsqivYDGcYEm9eGeC2S4aMSHKeXUmFRjMixQHLo
	XP6jSjCeCTfkVrtE0L7GTrFux5dRt18=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1714400182; a=rsa-sha256;
	cv=none;
	b=F3qqlMicdw2TB/9XArQajbPxZYgr/gWcg/Agx7IuNp19moY3+yM4RisW5i9KQfIzZ9XY5t
	bcUqj4CuZ85kfvl+onlYTOuH26wQ5xnk9PexhtgtkXUoUdDgxN42EbwjfSPkaY7W9LdZ6+
	yJ7rw7NKCQSMTDpoPTHSsCCC7ORPJo4=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=none;
	spf=pass (diktynna.open-mesh.org: domain of hfurmans@student.ethz.ch
 designates 2001:67c:10ec:5605::21 as permitted sender)
 smtp.mailfrom=hfurmans@student.ethz.ch;
	dmarc=none
Received: from mailm113.d.ethz.ch (2001:67c:10ec:5602::25) by mailg110.ethz.ch
 (2001:67c:10ec:5605::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 29 Apr
 2024 16:16:22 +0200
Received: from mailm116.d.ethz.ch (2001:67c:10ec:5602::28) by
 mailm113.d.ethz.ch (2001:67c:10ec:5602::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 29 Apr 2024 16:16:22 +0200
Received: from mailm116.d.ethz.ch ([fe80::31f2:ac40:ea30:48d1]) by
 mailm116.d.ethz.ch ([fe80::31f2:ac40:ea30:48d1%4]) with mapi id
 15.01.2507.039; Mon, 29 Apr 2024 16:16:22 +0200
From: "Furmans  Hannes" <hfurmans@student.ethz.ch>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>
Subject: Using B.A.T.M.A.N.-Adv and scanning for neighbours
Thread-Topic: Using B.A.T.M.A.N.-Adv and scanning for neighbours
Thread-Index: AQHamj/PxxClAi5hxkGEvLHqOc0CZw==
Date: Mon, 29 Apr 2024 14:16:21 +0000
Message-ID: <DAE0E173-234B-44C0-8D2B-C16551497CE0@ethz.ch>
Accept-Language: de-DE, de-CH, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.5.186.228]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5219118FC306874F97EC9D76FC3E517C@intern.ethz.ch>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MailFrom: hfurmans@student.ethz.ch
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2
Message-ID-Hash: NWKUSVRG2JH2PYMGS27NQEKDN3SNHSLV
X-Message-ID-Hash: NWKUSVRG2JH2PYMGS27NQEKDN3SNHSLV
X-Mailman-Approved-At: Mon, 29 Apr 2024 16:22:22 +0200
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/NWKUSVRG2JH2PYMGS27NQEKDN3SNHSLV/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

SGVsbG8gZXZlcnlvbmUhDQoNCldlIGhhdmUgYSBzZXR1cCB3aXRoIGZvdXIgUmFzcGJlcnJ5IFBp
LCBhbGwgaW4gSUJTUyBtb2RlIGFuZCBjb25uZWN0ZWQgdmlhIEIuQS5ULk0uQS5OLi4gVGhhdCBh
bGwgd29ya3MgZmluZS4gSG93ZXZlciB3ZSBub3cgaGF2ZSB0cm91YmxlcyBzY2FubmluZyBvbiB0
aGUgUGlzIGZvciB0aGUgbmVpZ2hib3Vycy4gDQpXaGVuIHdlIHJ1biANCnN1ZG8gaXcgd2xhbjAg
c2NhbiBzc2lkIGJhdG1hbi10ZXN0DQoNCldlIGhhdmUgdGhlIG91dHB1dDoNCkJTUyA3ZTo0MDpl
YTowNTo1NzplOShvbiB3bGFuMCkgLS0gam9pbmVkDQoJbGFzdCBzZWVuOiAyNDMzLjEzMHMgW2Jv
b3R0aW1lXQ0KCVRTRjogMCB1c2VjICgwZCwgMDA6MDA6MDApDQoJZnJlcTogMjQxMg0KCWJlYWNv
biBpbnRlcnZhbDogMTAwIFRVcw0KCWNhcGFiaWxpdHk6IElCU1MgKDB4MDAwMikNCglzaWduYWw6
IC0xNy4wMCBkQm0NCglsYXN0IHNlZW46IDAgbXMgYWdvDQoJU1NJRDogYmF0bWFuLXRlc3QNCglT
dXBwb3J0ZWQgcmF0ZXM6IDYuMCogOS4wIDEyLjAqIDE4LjAgMjQuMCogMzYuMCA0OC4wIDU0LjAN
CglEUyBQYXJhbWV0ZXIgc2V0OiBjaGFubmVsIDENCglJQlNTIEFUSU0gd2luZG93OiAwIFRVcw0K
CUVSUDogVXNlX1Byb3RlY3Rpb24NCglIVCBjYXBhYmlsaXRpZXM6DQoJCUNhcGFiaWxpdGllczog
MHgyMQ0KCQkJUlggTERQQw0KCQkJSFQyMA0KCQkJU3RhdGljIFNNIFBvd2VyIFNhdmUNCgkJCVJY
IEhUMjAgU0dJDQoJCQlObyBSWCBTVEJDDQoJCQlNYXggQU1TRFUgbGVuZ3RoOiAzODM5IGJ5dGVz
DQoJCQlObyBEU1NTL0NDSyBIVDQwDQoJCU1heGltdW0gUlggQU1QRFUgbGVuZ3RoIDY1NTM1IGJ5
dGVzIChleHBvbmVudDogMHgwMDMpDQoJCU1pbmltdW0gUlggQU1QRFUgdGltZSBzcGFjaW5nOiA0
IHVzZWMgKDB4MDUpDQoJCUhUIFJYIE1DUyByYXRlIGluZGV4ZXMgc3VwcG9ydGVkOiAwLTcNCgkJ
SFQgVFggTUNTIHJhdGUgaW5kZXhlcyBhcmUgdW5kZWZpbmVkDQoJSFQgb3BlcmF0aW9uOg0KCQkg
KiBwcmltYXJ5IGNoYW5uZWw6IDENCgkJICogc2Vjb25kYXJ5IGNoYW5uZWwgb2Zmc2V0OiBubyBz
ZWNvbmRhcnkNCgkJICogU1RBIGNoYW5uZWwgd2lkdGg6IDIwIE1Ieg0KCQkgKiBSSUZTOiAwDQoJ
CSAqIEhUIHByb3RlY3Rpb246IG5vbi1IVCBtaXhlZA0KCQkgKiBub24tR0YgcHJlc2VudDogMQ0K
CQkgKiBPQlNTIG5vbi1HRiBwcmVzZW50OiAxDQoJCSAqIGR1YWwgYmVhY29uOiAwDQoJCSAqIGR1
YWwgQ1RTIHByb3RlY3Rpb246IDANCgkJICogU1RCQyBiZWFjb246IDANCgkJICogTC1TSUcgVFhP
UCBQcm90OiAwDQoJCSAqIFBDTyBhY3RpdmU6IDANCgkJICogUENPIHBoYXNlOiAwDQoJT3Zlcmxh
cHBpbmcgQlNTIHNjYW4gcGFyYW1zOg0KCQkgKiBwYXNzaXZlIGR3ZWxsOiAyMCBUVXMNCgkJICog
YWN0aXZlIGR3ZWxsOiAxMCBUVXMNCgkJICogY2hhbm5lbCB3aWR0aCB0cmlnZ2VyIHNjYW4gaW50
ZXJ2YWw6IDMwMCBzDQoJCSAqIHNjYW4gcGFzc2l2ZSB0b3RhbCBwZXIgY2hhbm5lbDogMjAwIFRV
cw0KCQkgKiBzY2FuIGFjdGl2ZSB0b3RhbCBwZXIgY2hhbm5lbDogMjAgVFVzDQoJCSAqIEJTUyB3
aWR0aCBjaGFubmVsIHRyYW5zaXRpb24gZGVsYXkgZmFjdG9yOiA1DQoJCSAqIE9CU1MgU2NhbiBB
Y3Rpdml0eSBUaHJlc2hvbGQ6IDAuMjUgJQ0KCUV4dGVuZGVkIGNhcGFiaWxpdGllczoNCgkJICog
SFQgSW5mb3JtYXRpb24gRXhjaGFuZ2UgU3VwcG9ydGVkDQoJCSAqIEJTUyBUcmFuc2l0aW9uDQoJ
CSAqIE9wZXJhdGluZyBNb2RlIE5vdGlmaWNhdGlvbg0KCVdNTTogaW5mb3JtYXRpb246IDAxIDAw
DQoNCldoaWNoIGlzIG5vdCB3aGF0IHdlIGV4cGVjdGVkLiBXZSBob3BlIHRvIHNlZSB0aGUgUlNT
SSBvZiBvdXIgbmVpZ2hib3VycyBhbmQgdGhhdCBzaG91bGQgYmUgcG9zc2libGUsIGF0IGxlYXN0
IGFzIEkgdW5kZXJzdGFuZCBpdC4gV2UgaGF2ZSBhbHJlYWR5IHRyaWVkIGl3c3B5IChkZXZpY2Ug
ZG9lc27igJl0IHN1cHBvcnQgaXQpLCBsZWF2aW5nIHRoZSBpYnNzIGdyb3VwIChkb2VzbuKAmXQg
aGVscCksIGl3bGlzdCAoc2FtZSBwcm9ibGVtKSBhbmQgdGhlIE1hYyBhZGRyZXNzIHlvdSBzZWUg
aW4gdGhlIG91dHB1dCBkb2VzbuKAmXQgbWF0Y2ggYW55IG9mIHRoZSBQaXMgd2UgdXNlLiANCg0K
V2UgYXJlIHN0dWNrIGhlcmUsIHBsZWFzZSBoZWxwIHVzLiBNYXliZSBpdCB3b3VsZCBiZSBwb3Nz
aWJsZSB0byBleHRyYWN0IHRoYXQgaW5mbyBmcm9tIGJhdG1hbiBkaXJlY3RseT8NCg0KVGhlIGRl
dmljZXMgaW4gcXVlc3Rpb25zIGFyZSBhbGwgUmFzcGJlcnJ5IFBpIDQgTW9kZWwgQiwgb25lIHdp
dGggMSBHQiBSQU0sIHR3byB3aXRoIDIgR0IgUkFNIGFuZCAxIHdpdGggNCBHQiBSQU0uIFdlIHJ1
bjogYmF0Y3RsIGRlYmlhbi0yMDIzLjAtMSBbYmF0bWFuLWFkdjogMjAyMy4zXQ0KDQpUaGlzIGlz
IHRoZSB2ZXJzaW9uIG9mIG91ciB3aWZpIGNoaXAgZHJpdmVyIChzdWRvIGxzaHcgLUMgbmV0d29y
ayk6DQogICotaW50ZXJmYWNlOjANCiAgICAgICBkZXNjcmlwdGlvbjogV2lyZWxlc3MgaW50ZXJm
YWNlDQogICAgICAgcHJvZHVjdDogNDM0MzANCiAgICAgICB2ZW5kb3I6IEJyb2FkY29tDQogICAg
ICAgcGh5c2ljYWwgaWQ6IDENCiAgICAgICBidXMgaW5mbzogbW1jQDE6MDAwMToxDQogICAgICAg
bG9naWNhbCBuYW1lOiBtbWMxOjAwMDE6MQ0KICAgICAgIGxvZ2ljYWwgbmFtZTogd2xhbjANCiAg
ICAgICBzZXJpYWw6IGQ4OjNhOmRkOjMwOjFkOjRhDQogICAgICAgY2FwYWJpbGl0aWVzOiBldGhl
cm5ldCBwaHlzaWNhbCB3aXJlbGVzcw0KICAgICAgIGNvbmZpZ3VyYXRpb246IGJyb2FkY2FzdD15
ZXMgZHJpdmVyPWJyY21mbWFjIGRyaXZlcnZlcnNpb249Ny40NS4yMzQgZmlybXdhcmU9MDEtOTk2
Mzg0ZTIgbXVsdGljYXN0PXllcyB3aXJlbGVzcz1JRUVFIDgwMi4xMQ0KDQpUaGFuayB5b3UgZm9y
IHlvdXIgdGltZSANCkhhbm5lcyBGdXJtYW5zDQoNCkVUSCBaw7xyaWNo
