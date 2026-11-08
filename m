Received: from diktynna.open-mesh.org (diktynna.open-mesh.org [136.243.236.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF88606A31C
	for <batman@archiver.kernel.org>; Sun,  8 Nov 2026 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=DjwpgHpt
Received: from diktynna.open-mesh.org (localhost [IPv6:::1])
	by diktynna.open-mesh.org (Postfix) with ESMTP id 854B980498
	for <batman@archiver.kernel.org>; Sun, 08 Nov 2026 08:35:40 +0100 (CET)
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=open-mesh.org; s=20121;
 t=1794123340;
 b=aWOYiRhfKXiQOPxEQBHczHIBiJ5kiAXvfYu0TJ5oeKIzCAy3qB+LQ7rVCqW3C9wBk3oxM
 cmWO3HhtfTQkuT3ufZP8EgTch4rkPajEAiQjb15/xmwRqn8zJ6JN0Ls+D4yX8ZrhItHEAY/
 5LdT/6Z90fQ/5UOkVE7vFQxBeWieFWA=
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=open-mesh.org; s=20121; t=1794123340; h=from : sender : reply-to :
 subject : date : message-id : to : cc : mime-version : content-type :
 content-transfer-encoding : content-id : content-description :
 resent-date : resent-from : resent-sender : resent-to : resent-cc :
 resent-message-id : in-reply-to : references : list-id : list-help :
 list-unsubscribe : list-subscribe : list-post : list-owner :
 list-archive; bh=airxadynoljcG4WiKcNkLwGnwk/Kca8utG3nG0W1M3E=;
 b=VCmVFSnZRMMT331lyW+RqaNQ9UHc2RHeu9rT/XIZjJq4YnJYJO/TsPFrX13PLx21SarYw
 GPpE3UQLRy2+AeIWwyydgD5zGOlC72Uj8SrXzsN4dKHyuM+bThiRQ2KTgpgUQAZcZkydcN9
 TjzNH5WNHn0ZROHtJKh3sMkRFysAbX0=
ARC-Authentication-Results: i=2; open-mesh.org;
 dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass header.from=narfation.org policy.dmarc=none
Authentication-Results: open-mesh.org; dkim=pass header.d=narfation.org;
 arc=pass;
 dmarc=pass (Used From Domain Record) header.from=narfation.org policy.dmarc=none
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	by diktynna.open-mesh.org (Postfix) with ESMTPS id 3373B81900
	for <b.a.t.m.a.n@lists.open-mesh.org>; Sun, 08 Nov 2026 08:35:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; d=open-mesh.org; s=20121; cv=none; t=1794123316;
	b=SgJ4c82aV23A6I3e0FceopZRXR4U98geMqzjXVNBmqDbPAa33u/46vQDMInHHw88pLQDkY
	QeXnaGyp9b+Y0b9LkSLO4qrWHtiEn+4rIt6kkhJHQkTdTZPKgcN4WJR9gVGJlwznuGARUa
	T6fg6TgYeUBGBjoSxa76DyfXDJJXlMs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=open-mesh.org;
	s=20121; t=1794123316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=airxadynoljcG4WiKcNkLwGnwk/Kca8utG3nG0W1M3E=;
	b=Ji8fsqwLOjdi4j0KcPO93q8XPIZOxBcp/7NX4qbvOe5mJ9F37KMauU9C2Ac22fgRYFFkN6
	jG0NZ3k1O4W/hhvWb5WlmC6lFSbqvOCgQge0qFpomcL4OQPjz/vznGzO7AxH9Lvi3BMRj8
	mOrpMOAPe5s4UvVJxP8bWhHvRkP/Bs8=
ARC-Authentication-Results: i=1;
	diktynna.open-mesh.org;
	dkim=pass header.d=narfation.org header.s=20121 header.b=DjwpgHpt;
	spf=pass (diktynna.open-mesh.org: domain of sven@narfation.org designates
 213.160.73.56 as permitted sender) smtp.mailfrom=sven@narfation.org;
	dmarc=pass (policy=none) header.from=narfation.org
Received: by dvalin.narfation.org (Postfix) id F226A1FE2D;
	Sun, 08 Nov 2026 07:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794123305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=airxadynoljcG4WiKcNkLwGnwk/Kca8utG3nG0W1M3E=;
	b=DjwpgHptia91IXmOdK5mOSl4wlpPl5hSzqvTdud/KdG7x1dddYV6jbjfnYV5jFsp6K79eM
	xgMAnlg41nKhQzlRIqy/ToDyrTgeaSc00rV+DEFSg8P/30LlWRaSJqimgXQ7OtPxeCM674
	MZ+bGp2bm2KzdfWLZsRYHW1uKc0o1Qk=
From: Sven Eckelmann <sven@narfation.org>
To: =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Cc: marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net,
 syzbot+61b202fdc410840f0198@syzkaller.appspotmail.com
Subject: Re: [PATCH batadv-next v3] batman-adv: tt: batch BH re-enable during
 TT hash
 walks
Date: Sun, 08 Nov 2026 08:35:01 +0100
Message-ID: <2056587.PYKUYFuaPT@sven-l14>
In-Reply-To: <20261108000137.822325-1-omermetekaya0@gmail.com>
References: <20261108000137.822325-1-omermetekaya0@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart23304117.EfDdHjke4D";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Message-ID-Hash: HPL6EOLITYPXMJ2YLIS5WP4XDTVB4OA7
X-Message-ID-Hash: HPL6EOLITYPXMJ2YLIS5WP4XDTVB4OA7
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
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/message/HPL6EOLITYPXMJ2YLIS5WP4XDTVB4OA7/>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Owner: <mailto:b.a.t.m.a.n-owner@lists.open-mesh.org>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--nextPart23304117.EfDdHjke4D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: =?UTF-8?B?w5ZtZXI=?= Mete Kaya <omermetekaya0@gmail.com>
Date: Sun, 08 Nov 2026 08:35:01 +0100
Message-ID: <2056587.PYKUYFuaPT@sven-l14>
In-Reply-To: <20261108000137.822325-1-omermetekaya0@gmail.com>
References: <20261108000137.822325-1-omermetekaya0@gmail.com>
MIME-Version: 1.0

On Sunday, 8 November 2026 01:01:11 CET =C3=96mer Mete Kaya wrote:
> Each spin_unlock_bh() re-enables bottom halves and, when softirqs are
> pending, processes them inline before returning. During a 1024-bucket
> TT hash walk under network load, the purge worker can be repeatedly
> interrupted by inline softirq processing at every bucket boundary.
[...]

I already told you that this is not directly for net or net-next. Please do=
n't=20
send this to netdev@vger.kernel.org or davem@davemloft.net. The scripts als=
o=20
tell you this:

$ ./scripts/get_maintainer.pl ./20261108000137.822325-1-omermetekaya0@gmail=
=2Ecom.mbx
Marek Lindner <marek.lindner@mailbox.org> (maintainer:BATMAN ADVANCED)
Simon Wunderlich <sw@simonwunderlich.de> (maintainer:BATMAN ADVANCED)
Antonio Quartulli <antonio@mandelbit.com> (maintainer:BATMAN ADVANCED)
Sven Eckelmann <sven@narfation.org> (maintainer:BATMAN ADVANCED)
Sebastian Andrzej Siewior <bigeasy@linutronix.de> (maintainer:Real-time Lin=
ux (PREEMPT_RT):Keyword:PREEMPT_RT)
Clark Williams <clrkwllms@kernel.org> (maintainer:Real-time Linux (PREEMPT_=
RT):Keyword:PREEMPT_RT)
Steven Rostedt <rostedt@goodmis.org> (maintainer:Real-time Linux (PREEMPT_R=
T):Keyword:PREEMPT_RT)
b.a.t.m.a.n@lists.open-mesh.org (moderated list:BATMAN ADVANCED)
linux-kernel@vger.kernel.org (open list)
linux-rt-devel@lists.linux.dev (open list:Real-time Linux (PREEMPT_RT):Keyw=
ord:PREEMPT_RT)
Real-time Linux (PREEMPT_RT) status: Supported:Keyword:PREEMPT_RT

And please don't send two versions of the same patch (series) in less than=
=20
24h.

> diff --git a/net/batman-adv/translation-table.c b/net/batman-adv/translat=
ion-table.c
> index b9407ad..ebeb486 100644
> --- a/net/batman-adv/translation-table.c
> +++ b/net/batman-adv/translation-table.c
> @@ -36,6 +36,7 @@
>  #include <linux/overflow.h>
>  #include <linux/rculist.h>
>  #include <linux/rcupdate.h>
> +#include <linux/sched.h>
>  #include <linux/skbuff.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>

Why do you include linux/sched.h? The correct include would have been
#include <linux/bottom_half.h>


#syz test: https://git.open-mesh.org/batadv.git disable-bh

Regards,
	Sven
--nextPart23304117.EfDdHjke4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCavAmJgAKCRBND3cr0xT1
yxzUAQCPh+tkFcwXUPoojY8YRA6P6UDSSmVLaC6R1TyE7dJV7AEAiT2yFIAt493d
X6ZVH6EpyS3xikpiG9xhQ4+RFWx7FQM=
=4L9N
-----END PGP SIGNATURE-----

--nextPart23304117.EfDdHjke4D--



