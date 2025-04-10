Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125B6C3601E
	for <batman@archiver.kernel.org>; Thu, 10 Apr 2025 15:38:49 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 4E3F884264
	for <batman@archiver.kernel.org>; Thu, 10 Apr 2025 17:38:48 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1744299528;
 b=WP2UHsjAlXxLv8sjnH7BKdSCVjIK1oJ6FAXksYvrZ7gPTKko3GR7xa0M2w4jXraDXpTEv
 jZZ+mNS1MjfVxf8Lc9WUdamKOdj6h025whSc6f8UnAKM7OgLEeEqU5HYMzePE7ptEEUy9Dx
 vEfYeOHf8GuFSJfhi5afzgqothHri0U=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1744299528; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qZRjEXGAKny5LBHm+0gZDyT2jAe9uIbIhB61DdBPZlM=;
 b=mqzg3+aTLnuaNYmpwA1omV1x81Vj/2JD/+BQWj4RvQVa4aeV6XasOqCqZFHNb9rufbHpV
 twry2bNegc1ZvpxMHBCaYsObaIvmEFwQFW5/yHwDIrdB/dEn5IUL40ycj99V0MTl+qc+Bw2
 f0dbMe6mDRgT1JP6e3RE5POOf2pfr1s=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=universe-factory.net;
  arc=pass;
  dmarc=none
Authentication-Results: open-mesh.org;
 dkim=pass header.d=universe-factory.net; arc=pass; dmarc=none
Received: from mail.universe-factory.net (osgiliath.universe-factory.net
 [141.95.161.142])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F16E481A4F
	for <b.a.t.m.a.n@lists.open-mesh.org>; Thu, 10 Apr 2025 17:38:32 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1744299513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	in-reply-to:in-reply-to:references:references:dkim-signature:autocrypt:autocrypt;
	bh=qZRjEXGAKny5LBHm+0gZDyT2jAe9uIbIhB61DdBPZlM=;
	b=l2HkYQY+zTHrY3bC5dVSfGCSBJbL/ZKbMwOCayZvtTMD95NRxJb2eTnSexecN/lL8XG9sQ
	+3v0fi293ylHpDimo1qpUxKksgD3qeQ/6YmqkMXhBc7qwmQZHhr+OF6DkvI/+30baM3OT8
	MiEWAlvEctdKZKPfbDmg4UlIkUMNXf0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=universe-factory.net header.s=dkim header.b=OxvxGSqN;
	spf=pass (diktynna.open-mesh.org: domain of mschiffer@universe-factory.net
 designates 141.95.161.142 as permitted sender)
 smtp.mailfrom=mschiffer@universe-factory.net;
	dmarc=pass (policy=reject) header.from=universe-factory.net
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1744299513; a=rsa-sha256;
	cv=none;
	b=OztGc6nOoWBz60FR0aXbDvsomyrAlLqGy5rGJK+PnTm4YRl5Nkx4waYidS+9hqJEbJzm9l
	8me8xOmgOvj8FB5AH+aUPbXniRRSNdcV7yHDhoiA2rNNAxpfoVx/Cf4Bu7ReRvW1v/tepE
	/BvkRUJW2lsl7pY1gRNu2nymWhBu0wU=
Message-ID: <94e1ac2c-46f1-4787-ad50-e4a5ab11011a@universe-factory.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=universe-factory.net;
	s=dkim; t=1744299512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qZRjEXGAKny5LBHm+0gZDyT2jAe9uIbIhB61DdBPZlM=;
	b=OxvxGSqNEPv9J3+vc8TGXBmMct0cQR0Nt0AorohevYq/vlyHNeJP0S7z+r7kbsoHF1pw8h
	kM2rvWfdOCa9nBV9PgvWxColMmK3zHu7C5f5JpVsTlns2tN2TMDfKeHlDiZV7iJPPOeb6Q
	nkTd9pSDOtFlbvwXxv/GkzRbDWGSGpXFdnq5K5WpBPf1ppKY3yoDTMyR4a6emhAJZWRESy
	HHneQMurS20SCIEtMJrbYhK4uP73GUdrI8giAzPHIFo3N51laGHGQCwTz71J4RgPBEQedf
	6dL6SisL5iPm8SAc0Kbb5kDgwNT2fvpciZkQ22ezdrE+AWMowYN3226YM7ci2A==
Date: Thu, 10 Apr 2025 17:38:30 +0200
MIME-Version: 1.0
Subject: Re: [PATCH net] batman-adv: fix duplicate MAC address check
Content-Language: en-US-large
To: Paolo Abeni <pabeni@redhat.com>, Marek Lindner
 <marek.lindner@mailbox.org>, Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: 
 <c775aab5514f25014f778c334235a21ee39708b4.1744129395.git.mschiffer@universe-factory.net>
 <0c288b2e-9747-4a50-a16f-bf4238829ffa@redhat.com>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Autocrypt: addr=mschiffer@universe-factory.net; keydata=
 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
 cQqe8eRmcdNdqWSiJQ8VLoI=
In-Reply-To: <0c288b2e-9747-4a50-a16f-bf4238829ffa@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------sNPEAjL00dW0Dw07Asv36qEo"
X-Spamd-Bar: ----
Message-ID-Hash: REKCBQ5GSVGZUE5U3JI6V2STSEOF5ARN
X-Message-ID-Hash: REKCBQ5GSVGZUE5U3JI6V2STSEOF5ARN
X-MailFrom: mschiffer@universe-factory.net
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/REKCBQ5GSVGZUE5U3JI6V2STSEOF5ARN/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------sNPEAjL00dW0Dw07Asv36qEo
Content-Type: multipart/mixed; boundary="------------oBMmu7dtOKxnkbs8AgOfZ2ca";
 protected-headers="v1"
From: Matthias Schiffer <mschiffer@universe-factory.net>
To: Paolo Abeni <pabeni@redhat.com>, Marek Lindner
 <marek.lindner@mailbox.org>, Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 Sven Eckelmann <sven@narfation.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <94e1ac2c-46f1-4787-ad50-e4a5ab11011a@universe-factory.net>
Subject: Re: [PATCH net] batman-adv: fix duplicate MAC address check
References: <c775aab5514f25014f778c334235a21ee39708b4.1744129395.git.mschiffer@universe-factory.net>
 <0c288b2e-9747-4a50-a16f-bf4238829ffa@redhat.com>
In-Reply-To: <0c288b2e-9747-4a50-a16f-bf4238829ffa@redhat.com>

--------------oBMmu7dtOKxnkbs8AgOfZ2ca
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTAvMDQvMjAyNSAxMTozOCwgUGFvbG8gQWJlbmkgd3JvdGU6DQo+IE9uIDQvOC8yNSA2
OjMwIFBNLCBNYXR0aGlhcyBTY2hpZmZlciB3cm90ZToNCj4+IGJhdGFkdl9jaGVja19rbm93
bl9tYWNfYWRkcigpIGlzIGJvdGggdG9vIGxlbmllbnQgYW5kIHRvbyBzdHJpY3Q6DQo+Pg0K
Pj4gLSBJdCBpcyBjYWxsZWQgZnJvbSBiYXRhZHZfaGFyZGlmX2FkZF9pbnRlcmZhY2UoKSwg
d2hpY2ggbWVhbnMgdGhhdCBpdA0KPj4gICAgY2hlY2tlZCBpbnRlcmZhY2VzIHRoYXQgYXJl
IG5vdCB1c2VkIGZvciBiYXRtYW4tYWR2IGF0IGFsbC4gTW92ZSBpdA0KPj4gICAgdG8gYmF0
YWR2X2hhcmRpZl9lbmFibGVfaW50ZXJmYWNlKCkuIEFsc28sIHJlc3RyaWN0IGl0IHRvIGhh
cmRpZnMgb2YNCj4+ICAgIHRoZSBzYW1lIG1lc2ggaW50ZXJmYWNlOyBkaWZmZXJlbnQgbWVz
aCBpbnRlcmZhY2VzIHNob3VsZCBub3QgaW50ZXJhY3QNCj4+ICAgIGF0IGFsbC4gVGhlIGJh
dGFkdl9jaGVja19rbm93bl9tYWNfYWRkcigpIGFyZ3VtZW50IGlzIGNoYW5nZWQgZnJvbQ0K
Pj4gICAgYHN0cnVjdCBuZXRfZGV2aWNlYCB0byBgc3RydWN0IGJhdGFkdl9oYXJkX2lmYWNl
YCB0byBhY2hpZXZlIHRoaXMuDQo+PiAtIFRoZSBjaGVjayBvbmx5IGNhcmVzIGFib3V0IGhh
cmRpZnMgaW4gQkFUQURWX0lGX0FDVElWRSBhbmQNCj4+ICAgIEJBVEFEVl9JRl9UT19CRV9B
Q1RJVkFURUQgc3RhdGVzLCBidXQgaW50ZXJmYWNlcyBpbiBCQVRBRFZfSUZfSU5BQ1RJVkUN
Cj4+ICAgIHN0YXRlIHNob3VsZCBiZSBjaGVja2VkIGFzIHdlbGwsIG9yIHRoZSBmb2xsb3dp
bmcgc3RlcHMgd2lsbCBub3QNCj4+ICAgIHJlc3VsdCBpbiBhIHdhcm5pbmcgdGhlbiB0aGV5
IHNob3VsZDoNCj4+DQo+PiAgICAtIEFkZCB0d28gaW50ZXJmYWNlcyBvbiBkb3duIHN0YXRl
IHdpdGggZGlmZmVyZW50IE1BQyBhZGRyZXNzZXMgdG8NCj4+ICAgICAgYSBtZXNoIGFzIGhh
cmRpZnMNCj4+ICAgIC0gQ2hhbmdlIHRoZSBNQUMgYWRkcmVzc2VzIHNvIHRoZXkgY29uZmxp
ZWN0DQo+PiAgICAtIFNldCBpbnRlcmZhY2VzIHRvIHVwIHN0YXRlDQo+Pg0KPj4gICAgTm93
IHRoZXJlIHdpbGwgYmUgdHdvIGFjdGl2ZSBoYXJkaWZzIHdpdGggdGhlIHNhbWUgTUFDIGFk
ZHJlc3MsIGJ1dCBubw0KPj4gICAgd2FybmluZy4gRml4IGJ5IG9ubHkgaWdub3JpbmcgaGFy
ZGlmcyBpbiBCQVRBRFZfSUZfTk9UX0lOX1VTRSBzdGF0ZS4NCj4+DQo+PiBUaGUgUkNVIGxv
Y2sgY2FuIGJlIGRyb3BwZWQsIGFzIHdlJ3JlIGhvbGRpbmcgUlROTCBhbnl3YXlzIHdoZW4g
dGhlDQo+PiBmdW5jdGlvbiBpcyBjYWxsZWQuDQo+Pg0KPj4gV2hpbGUgd2UncmUgYXQgaXQs
IGFsc28gc3dpdGNoIGZyb20gcHJfd2FybigpIHRvIG5ldGRldl93YXJuKCkuDQo+Pg0KPj4g
Rml4ZXM6IGM2YzhmZWEyOTc2OSAoIm5ldDogQWRkIGJhdG1hbi1hZHYgbWVzaGluZyBwcm90
b2NvbCIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBNYXR0aGlhcyBTY2hpZmZlciA8bXNjaGlmZmVy
QHVuaXZlcnNlLWZhY3RvcnkubmV0Pg0KPiANCj4gRXZlbiBpZiBtYXJrZWQgZm9yIG5ldCBJ
IGFzc3VtZSB0aGlzIHdpbGwgZXZlbnR1YWxseSBnbyBmaXJzdCB2aWEgdGhlDQo+IGJhdG1h
biB0cmVlLg0KDQpZZXMuIFNob3VsZCBJIGhhdmUgbWFya2VkIHRoaXMgZGlmZmVyZW50bHk/
DQoNCj4gDQo+PiAtLS0NCj4+DQo+PiBBc2lkZTogYmF0YWR2X2hhcmRpZl9hZGRfaW50ZXJm
YWNlKCkgYmVpbmcgY2FsbGVkIGZvciBhbGwgZXhpc3RpbmcNCj4+IGludGVyZmFjZXMgYW5k
IGhhdmluZyBhIGdsb2JhbCBiYXRhZHZfaGFyZGlmX2xpc3QgYXQgYWxsIGlzIGFsc28gbm90
DQo+PiB2ZXJ5IG5pY2UsIGJ1dCB0aGlzIHdpbGwgYmUgYWRkcmVzc2VkIHNlcGFyYXRlbHks
IGFzIGNoYW5naW5nIGl0IHdpbGwNCj4+IHJlcXVpcmUgbW9yZSByZWZhY3RvcmluZy4NCj4+
DQo+PiAgIG5ldC9iYXRtYW4tYWR2L2hhcmQtaW50ZXJmYWNlLmMgfCAzNyArKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2Vy
dGlvbnMoKyksIDE1IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9uZXQvYmF0
bWFuLWFkdi9oYXJkLWludGVyZmFjZS5jIGIvbmV0L2JhdG1hbi1hZHYvaGFyZC1pbnRlcmZh
Y2UuYw0KPj4gaW5kZXggZjE0NWY5NjYyNjUzLi4wN2I0MzY2MjZhZmIgMTAwNjQ0DQo+PiAt
LS0gYS9uZXQvYmF0bWFuLWFkdi9oYXJkLWludGVyZmFjZS5jDQo+PiArKysgYi9uZXQvYmF0
bWFuLWFkdi9oYXJkLWludGVyZmFjZS5jDQo+PiBAQCAtNTA2LDI4ICs1MDYsMzQgQEAgYmF0
YWR2X2hhcmRpZl9pc19pZmFjZV91cChjb25zdCBzdHJ1Y3QgYmF0YWR2X2hhcmRfaWZhY2Ug
KmhhcmRfaWZhY2UpDQo+PiAgIAlyZXR1cm4gZmFsc2U7DQo+PiAgIH0NCj4+ICAgDQo+PiAt
c3RhdGljIHZvaWQgYmF0YWR2X2NoZWNrX2tub3duX21hY19hZGRyKGNvbnN0IHN0cnVjdCBu
ZXRfZGV2aWNlICpuZXRfZGV2KQ0KPj4gK3N0YXRpYyB2b2lkIGJhdGFkdl9jaGVja19rbm93
bl9tYWNfYWRkcihjb25zdCBzdHJ1Y3QgYmF0YWR2X2hhcmRfaWZhY2UgKmhhcmRfaWZhY2Up
DQo+PiAgIHsNCj4+IC0JY29uc3Qgc3RydWN0IGJhdGFkdl9oYXJkX2lmYWNlICpoYXJkX2lm
YWNlOw0KPj4gKwljb25zdCBzdHJ1Y3QgbmV0X2RldmljZSAqbWVzaF9pZmFjZSA9IGhhcmRf
aWZhY2UtPm1lc2hfaWZhY2U7DQo+PiArCWNvbnN0IHN0cnVjdCBiYXRhZHZfaGFyZF9pZmFj
ZSAqdG1wX2hhcmRfaWZhY2U7DQo+PiAgIA0KPj4gLQlyY3VfcmVhZF9sb2NrKCk7DQo+PiAt
CWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KGhhcmRfaWZhY2UsICZiYXRhZHZfaGFyZGlmX2xp
c3QsIGxpc3QpIHsNCj4+IC0JCWlmIChoYXJkX2lmYWNlLT5pZl9zdGF0dXMgIT0gQkFUQURW
X0lGX0FDVElWRSAmJg0KPj4gLQkJICAgIGhhcmRfaWZhY2UtPmlmX3N0YXR1cyAhPSBCQVRB
RFZfSUZfVE9fQkVfQUNUSVZBVEVEKQ0KPj4gKwlpZiAoIW1lc2hfaWZhY2UpDQo+PiArCQly
ZXR1cm47DQo+PiArDQo+PiArCWxpc3RfZm9yX2VhY2hfZW50cnkodG1wX2hhcmRfaWZhY2Us
ICZiYXRhZHZfaGFyZGlmX2xpc3QsIGxpc3QpIHsNCj4+ICsJCWlmICh0bXBfaGFyZF9pZmFj
ZSA9PSBoYXJkX2lmYWNlKQ0KPj4gKwkJCWNvbnRpbnVlOw0KPj4gKw0KPj4gKwkJaWYgKHRt
cF9oYXJkX2lmYWNlLT5tZXNoX2lmYWNlICE9IG1lc2hfaWZhY2UpDQo+PiAgIAkJCWNvbnRp
bnVlOw0KPj4gICANCj4+IC0JCWlmIChoYXJkX2lmYWNlLT5uZXRfZGV2ID09IG5ldF9kZXYp
DQo+PiArCQlpZiAodG1wX2hhcmRfaWZhY2UtPmlmX3N0YXR1cyA9PSBCQVRBRFZfSUZfTk9U
X0lOX1VTRSkNCj4+ICAgCQkJY29udGludWU7DQo+PiAgIA0KPj4gLQkJaWYgKCFiYXRhZHZf
Y29tcGFyZV9ldGgoaGFyZF9pZmFjZS0+bmV0X2Rldi0+ZGV2X2FkZHIsDQo+PiAtCQkJCQlu
ZXRfZGV2LT5kZXZfYWRkcikpDQo+PiArCQlpZiAoIWJhdGFkdl9jb21wYXJlX2V0aCh0bXBf
aGFyZF9pZmFjZS0+bmV0X2Rldi0+ZGV2X2FkZHIsDQo+PiArCQkJCQloYXJkX2lmYWNlLT5u
ZXRfZGV2LT5kZXZfYWRkcikpDQo+PiAgIAkJCWNvbnRpbnVlOw0KPj4gICANCj4+IC0JCXBy
X3dhcm4oIlRoZSBuZXdseSBhZGRlZCBtYWMgYWRkcmVzcyAoJXBNKSBhbHJlYWR5IGV4aXN0
cyBvbjogJXNcbiIsDQo+PiAtCQkJbmV0X2Rldi0+ZGV2X2FkZHIsIGhhcmRfaWZhY2UtPm5l
dF9kZXYtPm5hbWUpOw0KPj4gLQkJcHJfd2FybigiSXQgaXMgc3Ryb25nbHkgcmVjb21tZW5k
ZWQgdG8ga2VlcCBtYWMgYWRkcmVzc2VzIHVuaXF1ZSB0byBhdm9pZCBwcm9ibGVtcyFcbiIp
Ow0KPj4gKwkJbmV0ZGV2X3dhcm4oaGFyZF9pZmFjZS0+bmV0X2RldiwNCj4+ICsJCQkgICAg
IlRoZSBuZXdseSBhZGRlZCBtYWMgYWRkcmVzcyAoJXBNKSBhbHJlYWR5IGV4aXN0cyBvbjog
JXNcbiIsDQo+PiArCQkJICAgIGhhcmRfaWZhY2UtPm5ldF9kZXYtPmRldl9hZGRyLCB0bXBf
aGFyZF9pZmFjZS0+bmV0X2Rldi0+bmFtZSk7DQo+PiArCQluZXRkZXZfd2FybihoYXJkX2lm
YWNlLT5uZXRfZGV2LA0KPj4gKwkJCSAgICAiSXQgaXMgc3Ryb25nbHkgcmVjb21tZW5kZWQg
dG8ga2VlcCBtYWMgYWRkcmVzc2VzIHVuaXF1ZSB0byBhdm9pZCBwcm9ibGVtcyFcbiIpOw0K
Pj4gICAJfQ0KPj4gLQlyY3VfcmVhZF91bmxvY2soKTsNCj4+ICAgfQ0KPiANCj4gSSBmZWVs
IGxpa2UgdGhlIGFib3ZlIGNvZGUgbWl4ZXMgdW5uZWNlc3NhcmlseSBmaXggYW5kIHJlZmFj
dG9yDQo+ICh2YXJpYWJsZSByZW5hbWUsIGRpZmZlcmVudCBwcmludCBoZWxwZXIgdXNhZ2Up
Lg0KPiANCj4gSSB0aGluayB0aGUgZml4IHNob3VsZCBiZSBtaW5pbWFsLCB0aGUgcmVmYWN0
b3Igc2hvdWxkIGxhbmQgaW4gYQ0KPiBkaWZmZXJlbnQgcGF0Y2ggZm9yIG5leHQuDQoNCk9r
YXkuIEknbGwgcmVtb3ZlIHRoZSBwcmludCBoZWxwZXIgY2hhbmdlIGZvciBub3cuDQoNCkkg
dGhpbmsgdGhlIHZhcmlhYmxlIHJlbmFtZSBzaG91bGQgYmUga2VwdCwgYXMgd2Ugbm93IGhh
dmUgdHdvIA0KYmF0YWR2X2hhcmRfaWZhY2UqIHZhcnMsIHNvIHdlIG5lZWQgdG8gaW50cm9k
dWNlIGEgc2Vjb25kIG5hbWUuIE5hbWluZyB0aGUgDQppbnRlcmZhY2Ugd2UncmUgd29ya2lu
ZyBvbiBoYXJkX2lmYWNlIGFuZCB1c2luZyB0bXBfaGFyZF9pZmFjZSBmb3IgYSBsb29wIA0K
dmFyaWFibGUgbWF0Y2hlcyBzaW1pbGFyIGNvZGUgdGhhdCBhbHJlYWR5IGV4aXN0cyBpbiBi
YXRtYW4tYWR2Lg0KDQpCZXN0LA0KTWF0dGhpYXMNCg==

--------------oBMmu7dtOKxnkbs8AgOfZ2ca--

--------------sNPEAjL00dW0Dw07Asv36qEo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEZmTnvaa2aYgexS51Fu8/ZMsgHZwFAmf35fYFAwAAAAAACgkQFu8/ZMsgHZx9
0g//dk/nrApTxdGHS/ubqriFFKtDfsRDDgthWuFpsNbrzPsR0jmxvYJpRMRHC+RyJH4504xbQGAB
OSD2eEj42lVSnnPUM6m4ggNTtQy5XCbqqwmBSyLB4nVetNZhYBdQe3mKMsItbC1UkL4cI2QU7I+p
o2uKu7gYQQ64oJkQ1oxSCYI2Ir1a3sTb9RjQ3iPy17LbeffaVj70RoQ/fweC7TYHhzpiX61odqN1
902ZqwdtNZABKFwX/HuLUWkiCjtDuWRjt5kwTcvuhFV8vfup7/eHH1yoVnLSgd2zcTyyA2PXHEUE
hxlvmTVqfNobrxF8UPnCvHcTGmt/fGHO6Gq5fcEkkdcRDFO0DrcR/bowVK7Kmk0aRMPJD2USsR68
/xYZefvd85kcUxGntFU/KkJeN7Fr7RZsXDCuv8q5hogy4ykOMAI4Ej8QTvxZJfdwjlfs6cGFAnqw
470YpMw1Kil+Okmb2JeMDgG7JNXwO3FJkIzKufhv1lFqo+axuQi+dOnr+AyoHRFjMGUq6AGV1uQ4
57+GI+n2LuA+8zdHi/C11FjlH7h8BrOy7DpHTT0kjzjfNhPym4NQ3SiNPgROOL0tLAHeNAYiq+r0
1zyaedMPBmvQh+SQ/fMYzBq6+KtvL3tn0WoRwQHRkDrPdlBZoj94UyFIEvgplmk+OWYqJ0ZcrKBU
79U=
=S+Dw
-----END PGP SIGNATURE-----

--------------sNPEAjL00dW0Dw07Asv36qEo--
