Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8920CD5BC8
	for <batman-adv@archiver.kernel.org>; Tue, 26 May 2026 14:18:45 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0B28C83C13
	for <batman-adv@archiver.kernel.org>; Tue, 26 May 2026 16:18:44 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779805124;
 b=fPdNXtyw1x0vdyRvFDomyxTRGJ1mdwpKmQnA9z1FcK+fy/1V4OcXl1U8JXBBr5K0Fj1ih
 GbqLYQnnRHNAw1J7EMjUH487IyZr5d45zWuoiL/RPKTOw5paqxPnrMxTozyy9hNdaRukgxN
 muVBvCj6useTduCylZ0loR5dcVburMQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779805124; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=PcA7XtyXGltk5H+OKUZ/7bSf2zntXwWFan/bkQ0o9cE=;
 b=fIdNOT930xmOgCxU4ja7g7uCYfZhVie/p2UCLeaXISMujExKXPbxrN3Q6PGI4U4Bfdgrt
 TRXtTSyp+TUJ0q0QBkFr0Xajf7vS2GrZNfIHwIPv9SnqyNWEdQUfIModnzKH56TUllRBYlL
 99SMTmCE5PHriedvC2CxmuPhJn+Nk9I=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id E34D480944
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 26 May 2026 16:18:12 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779805093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PcA7XtyXGltk5H+OKUZ/7bSf2zntXwWFan/bkQ0o9cE=;
	b=uvPn5RYjC9pZc0WXQT4uQ0PZq/jAnewHPwAxgqvaSH8IjAem3U2UFDKjrUvp6l65XhNcm3
	DbEWPZlGqmZkuGIZ4AvCGwELxKQ5HlDkKc0hJBdNUFJMwFSWB3EUjb038CbfAIpAh92Ufc
	jLWw+K+L//eUiXxh0aJrhBIjdWnlPso=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779805093;
	b=LaTisjhmjA6n4B3cEc4UT/mSfZVDRWdB4i+4TGZz+fwaaomun4TrBMdIp5wjxRSEeDpgBV
	CT6knFDzofRQYBRVZMkq86L1cBwqV31WZ1v52ZXJSj++o/1XMNi3I/V66gOu1gDkX+iOdN
	5y7rC8yjxfxOFL29QiesBm/1VEn7kJE=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=nMSqzbZz;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id D0A4E1FE5D;
	Tue, 26 May 2026 14:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779805091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PcA7XtyXGltk5H+OKUZ/7bSf2zntXwWFan/bkQ0o9cE=;
	b=nMSqzbZzX9/xIcSgQFQ9WikWFppvKIDoWUqk3COdeXGjLQ8fkttap/NtBHoqRsUj+0E+eK
	NL382xGfq/VqQZSBQQ70EdIyr0mDSk4d+LNaBfSIPc7DPCGQAKyH5PhlVpbcCZNT9hf1fA
	VIn5LdxB6oh+1qSCv0T79Ln04eqZrBY=
From: Sven Eckelmann <sven@narfation.org>
To: =?UTF-8?B?wq3rsJXsiJjsmYQgLyDtlZnsg50gLyDsu7Ttk6jthLDqs7XtlZnrtoA=?=
 <swan2718@snu.ac.kr>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] batman-adv: fix DAT purge use-after-free on teardown
Date: Tue, 26 May 2026 16:18:05 +0200
Message-ID: <10856691.nUPlyArG6x@ripper>
In-Reply-To: 
 <CAL3z5EbfEeMn-2_JrvcXRtuKTtruEf+8MX9tCmn-N9edvvrjwA@mail.gmail.com>
References: <20260526064835.2233822-1-swan2718@snu.ac.kr>
 <14018241.uLZWGnKmhe@ripper>
 <CAL3z5EbfEeMn-2_JrvcXRtuKTtruEf+8MX9tCmn-N9edvvrjwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2352248.iZASKD2KPV";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: S7P4JFDYR4NGFKNLJHGPFDMQ5XJUR6ID
X-Message-ID-Hash: S7P4JFDYR4NGFKNLJHGPFDMQ5XJUR6ID
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/S7P4JFDYR4NGFKNLJHGPFDMQ5XJUR6ID/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2352248.iZASKD2KPV
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 26 May 2026 16:18:05 +0200
Message-ID: <10856691.nUPlyArG6x@ripper>
MIME-Version: 1.0

On Tuesday, 26 May 2026 15:56:58 CEST =C2=AD=EB=B0=95=EC=88=98=EC=99=84 / =
=ED=95=99=EC=83=9D / =EC=BB=B4=ED=93=A8=ED=84=B0=EA=B3=B5=ED=95=99=EB=B6=80=
 wrote:
> Hi Sven,
>=20
> You're right. I re-examined __cancel_work_sync() and confirmed that it
> internally disables the work before flushing, so the re-queue race I
> described does not exist. I'll withdraw this patch.
>=20
> Thanks for the review.

But you said that this was reported by syzkaller. I can't find the report i=
n=20
the official list [1]. I am guessing you have a reproducer in a private=20
instance and tested with it. And if you tested your patch with it, you have=
=20
found that your patch fixes it, right?

Can you give us more information about this to let us figure out what is=20
actually going on?

Regards,
	Sven

[1] https://syzkaller.appspot.com/upstream/s/batman

--nextPart2352248.iZASKD2KPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCahWrnQAKCRBND3cr0xT1
y+YjAP4mjdybqYAhYNFHxwB50gsr7/IZmrwAhlyRjOI5weUo7AD9Hw8JGIxkIEgT
zzKWPbt/x5y3Y44n01Itxw4BVjCYtA8=
=zlnD
-----END PGP SIGNATURE-----

--nextPart2352248.iZASKD2KPV--



