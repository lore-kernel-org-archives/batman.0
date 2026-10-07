Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD88CA5FF1
	for <batman@archiver.kernel.org>; Wed,  7 Oct 2026 07:24:53 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0474A83D76
	for <batman@archiver.kernel.org>; Wed, 07 Oct 2026 09:24:52 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1791357892;
 b=eLkhdWcXfKkl2aHyatHLtvIdP7ae5WsgpPwBo+ggeZqS+HB+1uXMDq3NSg81hr1kUtWD8
 7EQdflK91esHDTyHsiM/l7zJ0NDDFbJd8BbuS9UYCf3BGA1+GKZuDcT9KDQntVCR6pqVKvS
 V+tMtxcbXj9O/+b+BDpqz0jl6clmzsc=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1791357892; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=tEMbHhbyIhW8QfQ6FUYDsU+PwblYw5z4o/SY7zb4OIg=;
 b=3FwK0I++f0HDPzgT46FqYJDKYqMvzUzbRoa85Ie88QC4ZQSNgWDpmZZY1rWUaHT7QvWBs
 fgZuc2CyhNuAATxrTDtYBWzf0wuTMTxgjkJYpNYrYn1W7iaWggRPt38xcHBXYvXJpPwx2S4
 ua8kkUHZkxVX7VCs4UDwI39yxJ+GGKM=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 86C288192E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Wed, 07 Oct 2026 09:24:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1791357881;
	b=NN01Hd1thTWzA+BEhyZg7UiZQnlWP89tmBDkUvMbBXwH+WohNq/NamLFAia/Nit3XgFv0U
	UKcOWWAjNx2q94i5feiwcAf+rS/WTXx5Oy0PUHZnUG91rDYWshczqBcaHhRd/03Uo+zoqn
	y275mmPtNI0VzN1mUHeixGwbfCv28+w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1791357881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=tEMbHhbyIhW8QfQ6FUYDsU+PwblYw5z4o/SY7zb4OIg=;
	b=Hgf2/2ORpQShIoiVk2rJHihUpTPluQk8+oEIucM57ZLvUqzFSCV47TYwl2KVwg93G5+xl6
	3y6aba7SN9WfyCOpzzdDDTlXT4bSxtecXYMJvXa8HFJfGwG6iD9jmhlNtvibKoTnpG9hTb
	mqWtRSQCoBpp5qjHWOu2uudzu8QXd+8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=OSPQWt56;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 1C0A81FD5A;
	Wed, 07 Oct 2026 07:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1791357869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tEMbHhbyIhW8QfQ6FUYDsU+PwblYw5z4o/SY7zb4OIg=;
	b=OSPQWt56SzWiPiIHdb1nQ5xO25GCgU0eBrpuYcztKDDDEZVwYyKftyBe115IkrgQNkPduf
	bWU5lxDThZVvjTxG+GAZYXAjollc1OlTys5yJQfOnHthjd/hz55dQEh0abHGB8N5cXlGXW
	1QtVHQ2EEclLdrE9p/uJczWSgA0SJVU=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, sashiko-reviews@lists.linux.dev,
 Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com
Subject: Re: [batadv,v14 5/5] batman-adv: avoid superfluous DAT DHT_PUT
 additions to
 local DAT
Date: Wed, 07 Oct 2026 09:24:23 +0200
Message-ID: <5152412.GXAFRqVoOG@sven-desktop>
In-Reply-To: <asWbc64vRQgTKt9E@sellars>
References: <asWbc64vRQgTKt9E@sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2015193.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: GTTYAVJT2MJWBJATOH6CW7KA5WXLCM2V
X-Message-ID-Hash: GTTYAVJT2MJWBJATOH6CW7KA5WXLCM2V
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-3; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/GTTYAVJT2MJWBJATOH6CW7KA5WXLCM2V/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2015193.tdWV9SEqCh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 07 Oct 2026 09:24:23 +0200
Message-ID: <5152412.GXAFRqVoOG@sven-desktop>
In-Reply-To: <asWbc64vRQgTKt9E@sellars>
References: <asWbc64vRQgTKt9E@sellars>
MIME-Version: 1.0

On Wednesday, 7 October 2026 03:08:03 CEST Linus L=C3=BCssing wrote:
> > - [Medium] batadv: UAPI source compatibility breakage via reserved fiel=
d rename
>=20
> I would have thought that for a field called "reserved" it would
> be clear that it'd be subject to change in the future.

To play the devils advocate: But programs would still fail when they=20
manually initialize this field to 0.

> Or should I introduce a "struct batadv_unicast_4addr_v2_packet"?

Usually, you have a couple of bytes marked as a reserved array. And then th=
ey=20
reduce the number of bytes by X and add a new field. You can discuss if thi=
s=20
is correct or not (because then suddenly the new field would no longer be=20
initialized).

But for example, in commit c07d3aede2b2 ("fscrypt: add support for hardware-
wrapped keys") or commit 38a435800945 ("habanalabs: expose device security=
=20
status using info ioctl") or 91233ad71186 ("vhost: support ASID in IOTLB=20
API"), exactly your approach was taken.

You could in theory (to make it compile in all situations), also use an=20
anonymous union around flags and reserved to ensure the byte can be accesse=
d=20
with both names.

To also support your point, please check=20
https://docs.kernel.org/dev-tools/checkuapi.html - which also considers=20
"reserved" as ok:

 95         # Common padding field names which can be expanded into
 96         # without worrying about users.

Regards,
	Sven
--nextPart2015193.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCasXzpwAKCRBND3cr0xT1
y1l0AP9yhPxWl77/OwJTFpAy6UFrvQedoFCAuG+HysXp2Um5SQD8C4EJw40rEddj
L67A9mess7x9Lzdmk9eFsmugzeXOwwU=
=YG2O
-----END PGP SIGNATURE-----

--nextPart2015193.tdWV9SEqCh--



