Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C546606A31A
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 08:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=INeMIc2m
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 0692B8479B
	for <batman@archiver.kernel.org>; Sat, 31 Oct 2026 09:40:21 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1793436021;
 b=4LyLOoWo1qEmOyZMJU/ItymlZ7ZIwtmBRG8jDbA7MuhtkcSeDFe0cZpgRFrRJDCHdKe5t
 fcuzgqnj0cimuwjqGvTOAkb5CzRQMQTAQBi5eopb/502LILD93i6rWzPmWpJo4h86msEDGf
 K9/X57v7w6tvntqUHb8kSfhEf2V4fsg=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1793436021; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=kwrG7ecg7Gkp8O666QzFszH8flNQHF5uvmmzMHWSzqQ=;
 b=Qfk7Ei+9nVduRn++JtKK8nbdoBtZo8KUJdVTMgJVVwcpi/O/5xB+qHFjBEMl+0QTZfL82
 hFKRPwkLMR6IfTg3T3M0wjIM+EKC3FZBlnSOGM5xFTJtdJ31h/JBPCob7lud0qPvCIFZ9J9
 zHWxEppTBb2aRPpaEdjaobyjzUHY25U=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id F37CF8192E
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sat, 31 Oct 2026 09:39:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1793436005;
	b=T31EN2euExgJUmqBGJeTcp4n86JoRMLN0nHaof/55glbHCKAPoF2Mg+AbId7wn7eQLdZmE
	kZZ39AoI8NG8JNarlDJAoONBNxTpP7eMBT5bNoL/9E0nQ95ajtIQnNK4R80iC5cOoH2YLo
	ozzYQjD1gJTXE9tlfVpZN2HgXPocG3s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1793436005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=kwrG7ecg7Gkp8O666QzFszH8flNQHF5uvmmzMHWSzqQ=;
	b=H7Efov2JmfWAY+pWy9DKfkG4whEUteTNWmg6xwCrlbtz7uey58zLodRjOZzDBlhVtETmKX
	AeZt7DYDMutOlmiIzlwtH9eHtkad01HroLGHx4pIB02YnwHqvUX5UCtWLtql8dEjpbbK98
	yNIvFAeZKXAktk1sHoS7hJp0nCprkBc=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=INeMIc2m;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id 97DC91FE5D;
	Sat, 31 Oct 2026 08:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1793435993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kwrG7ecg7Gkp8O666QzFszH8flNQHF5uvmmzMHWSzqQ=;
	b=INeMIc2mMwCYJKlMqL9ngrN8QI2abI5KTiRpS1SrgWV4osUDIdY7K5I2kIxnqfO1l+nZyW
	4MVuYIcjTlqvubnwO6+WebdnhAVQCvWurzG/DxeiNX99qknvCL+F0rDzRuYbUUUfLMc52O
	6cqZPBaZCoAPpJhCnLsPJwzfctLejE4=
From: Sven Eckelmann <sven@narfation.org>
To: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: davem@davemloft.net, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org,
 syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com
Subject: Re: [PATCH net] batman-adv: reduce softirq drain in tt_purge loops
Date: Sat, 31 Oct 2026 09:39:49 +0100
Message-ID: <2282819.irdbgypaU6@sven-desktop>
In-Reply-To: <48b23995-4f67-4f3b-8988-78546cc23ecd@gmail.com>
References: <20261030000222.286935-1-omermetekaya0@gmail.com>
 <5221322.cEBGB3zze1@ripper>
 <48b23995-4f67-4f3b-8988-78546cc23ecd@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart14125537.uLZWGnKmhe";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: YELNPIUHWIWZE33XKK6QGSKXHTQUL5WU
X-Message-ID-Hash: YELNPIUHWIWZE33XKK6QGSKXHTQUL5WU
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/YELNPIUHWIWZE33XKK6QGSKXHTQUL5WU/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart14125537.uLZWGnKmhe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 31 Oct 2026 09:39:49 +0100
Message-ID: <2282819.irdbgypaU6@sven-desktop>
In-Reply-To: <48b23995-4f67-4f3b-8988-78546cc23ecd@gmail.com>
MIME-Version: 1.0

On Saturday, 31 October 2026 01:02:27 CET =C3=96mer Mete Kaya wrote:
> I think keeping the batching approach is the better option since
> cond_resched() alone does not reduce the number of inline softirq
> drains. But if you prefer the simpler per-bucket spin_lock_bh()
> with only cond_resched(), I will go that route for v2.

My understanding seems to be completely different. There is are two major=20
changes - one is the actual optimization and then a second one which only=20
applied in some situations:

I need an explanation in the commit message which tells us what the=20
problematic situation is and why the approach of an outer local_bh_disable(=
)=20
is the correct one.

But since you have also an cond_resched() in the middle, I need also an=20
explanation why this is required/good idea. And why it is not a problem to =
not=20
have cond_resched in some contexts. I am not talking about the technical=20
problem (commit_lock - which still needs to be mentioned) but why it doesn't
cause problems that there is no cond_resched there.

Not to forget about an explanation why the time for the worker doesn't stay=
=20
stable when it has a lot of softirq work which is done anyway on the BH re-
enable points. The number of these BH re-enable points is lower but the tot=
al=20
amount of work it needs to do stays the same - (without this explanation) y=
ou=20
could therefore argue that just more softirq work is done per BH re-enable=
=20
point and therefore the total amount of time spend by the worker (with the=
=20
softirq time) stays the same. As result, we would still see the splat (see
syzkaller report).


> > This looks like a workaround for a problem which isn't described very w=
ell.=20
> > Are there any precedents in the Linux kernel?
> >=20
> > I know of things like ctnetlink_dump_table() with the large local_bh_di=
sable()=20
> > and inner spinlocks. But I know of nothing with the cond_resched. But s=
ince I=20
> > don't know why it was added in the first place, I would a better explan=
ation=20
> > of the problem and the reasoning why it was tried to be fixed like you =
did.
>=20
> ctnetlink_dump_table() in net/netfilter/nf_conntrack_netlink.c uses
> an outer local_bh_disable() with inner spin_lock()/
> spin_unlock() calls on per-bucket locks.

As said in my message: no cond_resched in ctnetlink_dump_table()

> nf_ct_iterate_cleanup() also uses cond_resched() while walking the
> conntrack hash, although it re-enables BHs at a different granularity.

No outer local_bh_disable() and only a mutex around the main loop.

Kind regards,
	Sven
--nextPart14125537.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCauWpVQAKCRBND3cr0xT1
y3M4AQC4HuRmgMaEOHiBQSb+c4kJXxuvfdfKthXIWGMWOHKLXgD+PiHiiINFLstF
BHqG0nhUOmNTdRqHwqfH9Y8giOLATAg=
=PXMY
-----END PGP SIGNATURE-----

--nextPart14125537.uLZWGnKmhe--



