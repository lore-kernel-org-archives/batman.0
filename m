Return-Path: <b.a.t.m.a.n-bounces+batman=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B5CC54E5D
	for <batman@archiver.kernel.org>; Tue, 19 Mar 2024 13:22:51 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 30A0781A10
	for <batman@archiver.kernel.org>; Tue, 19 Mar 2024 14:22:50 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1710854570;
 b=AWrAtU8cacJ9750hFo/DC0LtjEamtmsG9qs6+NtBtF3VPwvm+gMM2A8yW2kwBPBrhWq4N
 na5p8qrfZgM6I+2QrMqlZugw4yk828hPPQpEsPJr4/JPZqZcO3EWEOnXGoncm2WVmV1MsvZ
 xn2EczARkd5F3Gv1/1sl5RvVs2RUbqQ=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1710854570; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=qlMWgzCdIDDA3TfwtyMcSQvofdYr4JxDgv8/lzTuVSY=;
 b=TggpwJrA9+kEaQYh5eHzC6FZmBYTlX72yBAnsdHZMhizKp/VaENO3wqTUIu0+xf9S7KF3
 E8Wcyx59gh4iejoPsKp/MgkAiA7NEZ+0J1yLi1HT+yFVqPDfE7EnqT4gn9W/3C+VuEutbXI
 34pjYXscImJeRAR5B8nMsGLn74ElHk4=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
  arc=pass;
  dmarc=pass (Used From Domain Record) header.from=narfation.org
 policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id DD5FB80F47
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 19 Mar 2024 14:19:25 +0100 (CET)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1710854365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=qlMWgzCdIDDA3TfwtyMcSQvofdYr4JxDgv8/lzTuVSY=;
	b=Wg90hqXXXNVkMhIHcHRDyZckI5T+qkV/SSGMV6a27iTZyzkNBnwhgouKGDm2zGF1MtVmWv
	AgAb6dpKYSz5lAxQRpI1NesLCMje0nmQwWpU3S6etYNWBPojRcVo1XRrHyQCBviVmciw59
	1gbP9E9rT8Tn7KMhmT9pLCLkv7XmWe4=
ARC-Seal: i=1; s=20121; d=open-mesh.org; t=1710854365; a=rsa-sha256;
	cv=none;
	b=PCWfyGfNZwtRdEvCBDNhoWyyn6XrKxDkZ6cTZ9269WImTuf51TI6X3ZlYYYnekmkMTSsuR
	6eBRSSlb4HGOIBmHfJfAHwEjlhNnRt4qqAuMFS5PG6W7Ob+HbfAQwmC82tQFo/J5s3+MQE
	XMqgt9ZztJxhIOzNLpqDsAw5avLPNcs=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=ebQjNwzQ;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1710854364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qlMWgzCdIDDA3TfwtyMcSQvofdYr4JxDgv8/lzTuVSY=;
	b=ebQjNwzQiC9YAQIOw5K3DJugtjjHnKCsOBqUZQHO8KmDFC6CaDWqsrzvDnWawN8KYIvZZJ
	XbyOlyAJJtqqZAaLqXXGmzYogRHlo7EELioeF50I9zQKOShoFQZ+uFkka5OuOdcK4CNuFI
	aDWZ+pU6Iwl84el0Fv8w7jzskZmX3xM=
From: Sven Eckelmann <sven@narfation.org>
To: akpm@linux-foundation.org, andrii@kernel.org, ast@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, christian@brauner.io,
 daniel@iogearbox.net, dvyukov@google.com, edumazet@google.com,
 elver@google.com, glider@google.com, hdanton@sina.com, jakub@cloudflare.com,
 jannh@google.com, john.fastabend@gmail.com, kasan-dev@googlegroups.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 mareklindner@neomailbox.ch, mark.rutland@arm.com, netdev@vger.kernel.org,
 pabeni@redhat.com, shakeelb@google.com, syzkaller-bugs@googlegroups.com,
 syzbot <syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [batman?] [bpf?] possible deadlock in lock_timer_base
Date: Tue, 19 Mar 2024 14:19:20 +0100
Message-ID: <2615678.iZASKD2KPV@ripper>
In-Reply-To: <000000000000901b1c0614010091@google.com>
References: <000000000000901b1c0614010091@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2316114.PYKUYFuaPT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-MailFrom: sven@narfation.org
X-Mailman-Rule-Hits: max-recipients
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-0;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-1;
 header-match-b.a.t.m.a.n.lists.open-mesh.org-2; nonmember-moderation;
 administrivia; implicit-dest; max-size; news-moderation; no-subject; digests;
 suspicious-header
Message-ID-Hash: R5RICZR2WSTL4JIRAQ5XDDZ4KIRRNABD
X-Message-ID-Hash: R5RICZR2WSTL4JIRAQ5XDDZ4KIRRNABD
X-Mailman-Approved-At: Tue, 19 Mar 2024 14:22:34 +0100
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
Archived-At: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/R5RICZR2WSTL4JIRAQ5XDDZ4KIRRNABD/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart2316114.PYKUYFuaPT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Mar 2024 14:19:20 +0100
Message-ID: <2615678.iZASKD2KPV@ripper>
In-Reply-To: <000000000000901b1c0614010091@google.com>
References: <000000000000901b1c0614010091@google.com>
MIME-Version: 1.0

On Tuesday, 19 March 2024 11:33:17 CET syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    35c3e2791756 Revert "net: Re-use and set mono_delivery_tim..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=10569181180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
> dashboard link: https://syzkaller.appspot.com/bug?extid=8983d6d4f7df556be565
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13d9fa4e180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=137afac9180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/26b55a26fc12/disk-35c3e279.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6f39fa55c828/vmlinux-35c3e279.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e1e0501539e6/bzImage-35c3e279.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+8983d6d4f7df556be565@syzkaller.appspotmail.com

Sorry, this is a little bit off-topic. But how does sysbot figure out the 
subsystems (like "[batman?]"). Because neither the reproducer nor the 
backtrace nor the console output mention anything batman-adv related.

Kind regards,
	Sven
--nextPart2316114.PYKUYFuaPT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmX5kNgACgkQXYcKB8Em
e0aRihAA0kDB39knEezz051yKh214KQyzCHU9DDVkDQEJKEhl9AMpB/1R4O5poka
SiwAwoSoP5A5kkczS9gtZGmEcCTSCjPx+Zj5aGgGylhgnHsLoA67qxQhiXDu5EWx
QSXqPtTmfNboRsZ8433zCQcUjN4tHc+r/mxFRkaBcRMWQh5tVXpeYjAB5rkOshVP
/Gnp/V9b3rVqu7STsr2npZT3F0SDk6yj2Oi810d0pnNzR2y49DmabnqzWtPe7sX4
d0/zPlX80F7FYrxjbi7LmjNYUoRrudHTXrb8FZaptsa+mIwVQ01UnK7sm/wWW6xF
BVuEC4j3OyaL9HEHgp9o7lxMNMx7KqYwimrewgPqeMWNHOkYX9swwRGzHUkU5wuC
TbbtgbAJaTtBroNZ4AqxwWO8LviRFhwwABtA6zb1VD/WOu8chQ7dgxAEJs3QdEUK
zVXOaOZefHULjIoJzRoPqwcnE67cvYwlmfHZnEVEp9YPXvdcrjswghJ+TeNoBt3s
+rrgbAsvbTxl/N5EF6Ke4OoVg4qDIY2djOubxk+l5r/Od0thLbHWaFq5vYg2G5Zq
VCX52iuKimsHb9Uso3kCzkGjcE2a/UcZu+9pgD4njh1CS+5l7bO89eknX8+yY1Kw
mOLKMD6oyYfDVWWIj7HNhlQxFZdR+mZoiG1FItjoJ7Pof8CRuZk=
=B2hL
-----END PGP SIGNATURE-----

--nextPart2316114.PYKUYFuaPT--



