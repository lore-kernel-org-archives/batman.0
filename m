Return-Path: <b.a.t.m.a.n-bounces+batman-adv=archiver.kernel.org@lists.open-mesh.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E792ECD5BCF
	for <batman-adv@archiver.kernel.org>; Tue, 26 May 2026 07:30:47 +0000 (UTC)
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id EB87F835FB
	for <batman-adv@archiver.kernel.org>; Tue, 26 May 2026 09:30:45 +0200 (CEST)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1779780645;
 b=nueqWABNJn0Y7kP6Ymo80uDov0nmXqHNcreXplAoaEr+JokWVjQCPhvX32jLfCC3NlYtS
 zVqvw6qkfak7ua/vtpzrgKnmTx0Wd6pyJn5R/qRDwZ2HSrH9dzCVQJwx1TDJTkNNkvdJNh4
 WWNJKg0bUJspfWNIddz26g1slO/DTqo=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1779780645; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=NvBuL1voqSEN0oLWaKKw+NjOufd3aAtSPxxpVUGOPIQ=;
 b=iEmp/LYAmaoKDXN+U2Y6SM0AaVQU90n8rAxhr6rI2ioDj4wCjSirPu4CwSXVFtbbOWvE1
 HuwCR9mSDMKXphoS6Tt4+SZrZajCqwoyhhIOqrE139q5X5MfWR4nFhkN1N8jMDVJffx3nEl
 QEpVV2bDq0rJ2ATH6wc571Wzn2tiS/E=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org
 [IPv6:2a00:17d8:100::8b1])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 166EA807B0
	for <b.a.t.m.a.n@lists.open-mesh.org>; Tue, 26 May 2026 09:30:11 +0200 (CEST)
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1779780612;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=NvBuL1voqSEN0oLWaKKw+NjOufd3aAtSPxxpVUGOPIQ=;
	b=bbOhJdTClJ2jBEhrTwymt6su8ydn7BhIlmlTI7cM719AKO5i14eCDLhMHYZQegGVBjzeCR
	xyphNQm/csPZAzL4ev1pKDN7Wh9D0QphqKyWv0Q1Si6qR7NCctnbyNsn5cJ8vwi2vPyr+M
	1BRxbJStif6p2+//ND8InLiwL8IaZBY=
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1779780612;
	b=UTpS8updxqilqBUtCK8WL+gm6/v9qUN9XNwrDoA9rjZTxSyWUrsE1Hc+KFt/S1XjOLCgUF
	kqiDRLMG0DKMjTwZ53EUPXu2vlgpbpf2yi4KA+xspHZYsCEFtLrQVlzE+gz+PrkDXsEI+k
	x6wnNhFafyxzcyOf19SWVytxwJ1wng0=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=JtjTg5IY;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 2a00:17d8:100::8b1 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id A520C1FE2A;
	Tue, 26 May 2026 07:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1779780610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NvBuL1voqSEN0oLWaKKw+NjOufd3aAtSPxxpVUGOPIQ=;
	b=JtjTg5IY5niVsR9IQBrb0/h/cOAmb0mBqCv0HPtFh+KU4iuBaSingsT5CFBe3Zr0EqjbJ3
	1BqyK3Tmmn6iuUkfiEMxzSTNuXZ/amCyAeMiiYu8CAsEX9WI1VVu1dvu/kdjOqgpulq+8Z
	sjY1NS2arWDN7DZRWtwjRArZi5XOBno=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 Soowan Park <swan2718@snu.ac.kr>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, Soowan Park <swan2718@snu.ac.kr>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] batman-adv: fix DAT purge use-after-free on teardown
Date: Tue, 26 May 2026 09:30:07 +0200
Message-ID: <14018241.uLZWGnKmhe@ripper>
In-Reply-To: <20260526064835.2233822-1-swan2718@snu.ac.kr>
References: <20260526064835.2233822-1-swan2718@snu.ac.kr>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3046581.e9J7NaK4W3";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: SM4HJH7XQJAOZ6RZOOYNJ7DTZWPMUNPF
X-Message-ID-Hash: SM4HJH7XQJAOZ6RZOOYNJ7DTZWPMUNPF
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/SM4HJH7XQJAOZ6RZOOYNJ7DTZWPMUNPF/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>

--nextPart3046581.e9J7NaK4W3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 26 May 2026 09:30:07 +0200
Message-ID: <14018241.uLZWGnKmhe@ripper>
In-Reply-To: <20260526064835.2233822-1-swan2718@snu.ac.kr>
References: <20260526064835.2233822-1-swan2718@snu.ac.kr>
MIME-Version: 1.0

On Tuesday, 26 May 2026 08:48:35 CEST Soowan Park wrote:
> batadv_dat_purge() is a periodic delayed work that re-queues itself via
> batadv_dat_start_timer() at the end of each run. When the mesh interface
> is torn down, batadv_dat_free() calls cancel_delayed_work_sync() to stop
> the purge work before freeing the DAT hash table.
>=20
> However, cancel_delayed_work_sync() leaves the work in an enabled state.
> If the purge work is currently executing and re-queues itself before
> cancel_delayed_work_sync() internally marks it for cancellation, the
> newly queued work escapes cancellation. This re-queued work then fires
> after batadv_dat_hash_free() has already freed the hash table but before
> the pointer is set to NULL, causing __batadv_dat_purge() to operate on a
> dangling pointer that passes the NULL check, and spin indefinitely on a
> spinlock in freed memory.


You are talking about a re-queue by batadv_dat_start_timer(). This only=20
happens when the DAT gets initialized or via the worker (batadv_dat_purge)=
=20
itself. How can the worker which is cancelled (with sync) re-queue itself?=
=20
Isn't this breaking a guarantee of cancel_delayed_work_sync() or did I=20
misunderstand this part of the documentation?


"This is cancel_work_sync() for delayed works." [1]

"Cancel work and wait for its execution to finish. This function can be use=
d=20
even if the work re-queues itself or migrates to another workqueue. On retu=
rn=20
from this function, work is guaranteed to be not pending or executing on an=
y=20
CPU as long as there aren=E2=80=99t racing enqueues." [2]

(the part "This function can be used even if the work re-queues itself" is
the important part here).


> Replace cancel_delayed_work_sync() with disable_delayed_work_sync(),
> which additionally disables the work so that any concurrent
> queue_delayed_work() call from the running batadv_dat_purge() is
> silently rejected. This guarantees no re-queued work can fire after
> disable_delayed_work_sync() returns.

I have no problem with using "disabled_*" everywhere (I even have a pending=
=20
patchset to use it - just to avoid problems with code changes in the future=
).=20
But since this is a fix which I don't get in the moment, I would like to=20
understand the problem you are describing better before applying it.

Regards,
	Sven


[1] https://www.kernel.org/doc/html/v7.0/core-api/workqueue.html#c.cancel_d=
elayed_work_sync
[2] https://www.kernel.org/doc/html/v7.0/core-api/workqueue.html#c.cancel_w=
ork_sync
--nextPart3046581.e9J7NaK4W3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCahVL/wAKCRBND3cr0xT1
y38WAPwLlc/180rzpcmO7N4qmYg2RQ8w5oxAKnvdfgyknBNaKwEA8cOumQjNSrey
d3jt9GblIoJWiBGN3V2wgfsHvDwVWAI=
=KaNu
-----END PGP SIGNATURE-----

--nextPart3046581.e9J7NaK4W3--



