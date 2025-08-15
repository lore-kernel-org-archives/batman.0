Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DC8CA0EE4
	for <batman-adv@archiver.kernel.org>; Fri, 15 Aug 2025 18:15:00 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 9882D81C26
	for <batman-adv@archiver.kernel.org>; Fri, 15 Aug 2025 20:14:58 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1755281698;
 b=iIIpEeKa/IzZl0pUJzG4Fyo2R1tFvZRlgejebdWVgqbhIF+m7IHkXng7bPqfWCCoCCOap
 7XW1n9IlTqTuVFrL95gK+NfF2ioFIHWcJOjBh9581iuUKF1ShxB7OZzP61JShAKL+KJ79ff
 jNvNNCo6qO+VGyOJMxVVmslEqHjisP8=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1755281698; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=xs2rx1eCTbGj1hhlsVHX4/F/vr1GTt6ppXxhwdl66hQ=;
 b=zqtpfbVJs4TCUWESX2OVwfH8rp+BfAVAdBhen6/Az5ZVXztHbItYvPwazr0zBufLs6xb9
 AQTJ3XYRyGr9pjXd0vyp8ZWQNniYjymxEvuVXRGMxxMrZLWuJXatzeJySj9/OOrTkuFsb6E
 eTK2h0fSlcRrQrAJHWxfKgeVpgSgDms=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=sandelman.ca;
 arc=pass;
 dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=sandelman.ca;
 arc=pass; dmarc=none
Received: from tuna.sandelman.ca (tuna.sandelman.ca
 [IPv6:2607:f0b0:f:3:216:3eff:fe7c:d1f3])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 5C2A0810D8
	for <b.a.t.m.a.n@lists.open-mesh.org>; Fri, 15 Aug 2025 19:54:28 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1755280479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xs2rx1eCTbGj1hhlsVHX4/F/vr1GTt6ppXxhwdl66hQ=;
	b=iC8GcWHd5oJhX1oHx6B1H0edBVzm/bu38OlAKxoKGfH6Xx6M1qYFFQ/ipLz047Nxv1mecR
	c9Emdrx5xFijHziyi9O99kKx5DuO4sjjY5hMyUmqVeVpBVhln81miSvpgGN28y1VlmI5d/
	sm9V9bXG3HvAxRo27Jqs03o8TmbP/Ic=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=sandelman.ca header.s=mail header.b=NYOirQMO;
	dmarc=none;
	spf=pass (diktynna.open-mesh.org: domain of mcr@sandelman.ca designates
 2607:f0b0:f:3:216:3eff:fe7c:d1f3 as permitted sender)
 smtp.mailfrom=mcr@sandelman.ca
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1755280479; a=rsa-sha256;
	cv=none;
	b=Tc14yRATo22sE6eCog62Wxfn2jCmBwbbGBsl87AJ7jfD9bgIB9uk3NSxIwtUFmWnbhNQsm
	yrqWT9JRneYMvLmPRNYEUxUlq6OedpLtqLKhPSk+4tRzhbpj5k72BGDFVkY95T65CjEEqd
	QcV8cy0KcvYM7t82JpxR9HB3LMLLwrc=
Received: from localhost (localhost [127.0.0.1])
	by tuna.sandelman.ca (Postfix) with ESMTP id 9BAEB18011;
	Fri, 15 Aug 2025 13:54:22 -0400 (EDT)
Received: from tuna.sandelman.ca ([127.0.0.1])
 by localhost (localhost [127.0.0.1]) (amavis, port 10024) with LMTP
 id 9yH3a_2APJ4g; Fri, 15 Aug 2025 13:54:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandelman.ca;
	s=mail; t=1755280460;
	bh=xs2rx1eCTbGj1hhlsVHX4/F/vr1GTt6ppXxhwdl66hQ=;
	h=From:To:cc:Subject:In-Reply-To:References:Date:From;
	b=NYOirQMOSbjA1hPoIAuv/9I5DtxY0aC6yEqPDQk3iL/745NbcfozlSNIA4QQL0bRX
	 PnrAP5vkroctW/7p15F2nYu4LeNVgXQwn9HH7pNbtCsYKd+7xqot6d+1MWqZzl8S3U
	 14LcVLw7sH6G6x5Zm2qyxHKj1wAteM0OxBkF3e1VCcMi7SxlXF6pWHp4+7k4exxAIK
	 2LVE0PuDHivyAve239Wy8PPYxpNZ2GgDYv5fWpf5p6ZlDcobxhvSN/iQOW9gFuLVQ+
	 yz9x6UUszNAaDT3DBsBl3QmLiGngn3iZXBg/oEOR3r+IeEKRJevUQqB3Yw+RrFYeze
	 VXc6/+sYnCJVw==
Received: from sandelman.ca (obiwan.sandelman.ca [209.87.249.21])
	by tuna.sandelman.ca (Postfix) with ESMTP id A19451800C;
	Fri, 15 Aug 2025 13:54:20 -0400 (EDT)
Received: from obiwan.sandelman.ca (obiwan.sandelman.ca [127.0.0.1])
	by sandelman.ca (Postfix) with ESMTP id 9E713225;
	Fri, 15 Aug 2025 13:54:20 -0400 (EDT)
From: Michael Richardson <mcr@sandelman.ca>
To: Linus =?us-ascii?Q?=3D=3Futf-8=3FQ=3FL=3DC3=3DBCssing=3F=3D?=
 <linus.luessing@c0d3.blue>
Subject: Re: [tcpdump-workers] B.A.T.M.A.N. Advanced libpcap pull-request
In-Reply-To: <aJ8rBnoIBaOuKVCT@sellars>
References: <aJ8rBnoIBaOuKVCT@sellars>
X-Mailer: MH-E 8.6+git; nmh 1.8+dev; GNU Emacs 28.2
X-Face: 
 $\n1pF)h^`}$H>Hk{L"x@)JS7<%Az}5RyS@k9X%29-lHB$Ti.V>2bi.~ehC0;<'$9xN5Ub#
 z!G,p`nR&p7Fz@^UXIn156S8.~^@MJ*mMsD7=QFeq%AL4m<nPbLgmtKK-5dC@#:k
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 15 Aug 2025 13:54:20 -0400
Message-ID: <18587.1755280460@obiwan.sandelman.ca>
X-MailFrom: mcr@sandelman.ca
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; emergency; member-moderation
Message-ID-Hash: R5R3EMZBFQZ2MI7IMEAFLD6EBS3Y2B2Q
X-Message-ID-Hash: R5R3EMZBFQZ2MI7IMEAFLD6EBS3Y2B2Q
X-Mailman-Approved-At: Fri, 15 Aug 2025 20:14:38 +0200
CC: tcpdump-workers@lists.tcpdump.org, b.a.t.m.a.n@lists.open-mesh.org
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/R5R3EMZBFQZ2MI7IMEAFLD6EBS3Y2B2Q/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Linus L=C3=BCssing <linus.luessing@c0d3.blue> wrote:
    > I wanted to cautiously inquire about the pull-request I had filed
    > about 5 years ago for adding B.A.T.M.A.N. Advanced support to
    > libpcap here:

    > "Add support for B.A.T.M.A.N. Advanced #980"
    -> https://github.com/the-tcpdump-group/libpcap/pull/980

Oh, yeah, I remember now.
I had hoped to get Bill Fenner to review the pcap compiler changes.
That never happened... but at this point, I'd say merge.

=2D-
]               Never tell me the odds!                 | ipv6 mesh network=
s [
]   Michael Richardson, Sandelman Software Works        |    IoT architect =
  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails  =
  [


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFFBAEBCgAvFiEEbsyLEzg/qUTA43uogItw+93Q3WUFAmifdEwRHG1jckBzYW5k
ZWxtYW4uY2EACgkQgItw+93Q3WW4RQf/Rn46AT90xWoDI2fbq2yh6amWzPzsykzm
OAYlvebdFhcmPTVpl+IA+CDBTeBRiM8gU45N2bdCTYveobXTwplQYav9FfxIRQZY
lusj/i4vyWydeFSr/mYxykuqHjAraEXa9qtC8CcFKEtL563xyQw9A5jNy7KS9mPI
ueX9L5sPw5w5eOEcu/YeoybDn+GuSv4TqTFnQWQLgk5RzRzXZmTJFGSyOAEV0iqf
DdcLhXvv/vC5/vyHBEYOFASoGd87OGAkZf3jnbAESHqFnHKlyNha/udkykGNcKhB
VqkQE/O4P3W2siGFafnTOfMRffB2yZgrA5eRNdwQv5+JtkWTCwx4Qw==
=jQDy
-----END PGP SIGNATURE-----
--=-=-=--
