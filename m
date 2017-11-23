Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 23 Nov 2017 19:13:00 +0100
Message-ID: <3609615.V5ZD6Euj8K@sven-edge>
In-Reply-To: <20171123154329.GE30167@lunn.ch>
References: <20171119140517.24329-1-sven@narfation.org>
 <7304207.KlJx96cEKj@bentobox> <20171123154329.GE30167@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3280967.PehHDCzncB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 8/9] batman-adv: Change batman_adv.h
 license to MIT
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart3280967.PehHDCzncB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Donnerstag, 23. November 2017 16:43:29 CET Andrew Lunn wrote:
[...]
> I just looked at Linus's current master branch:
>=20
> ~/linux/include/uapi$ grep -hr SPDX * | sort | uniq -c=20
>      14 /* SPDX-License-Identifier: GPL-1.0+ WITH Linux-syscall-note */
>     541 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>     113 /* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
>       1 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) AN=
D MIT) */
>      21 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR=
 BSD-2-Clause) */
>      17 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR=
 BSD-3-Clause) */
>       4 /* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) O=
R BSD-3-Clause) */
>       3 /* SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR=
 MIT) */
>       3 /* SPDX-License-Identifier: LGPL-2.0+ WITH Linux-syscall-note */
>       3 /* SPDX-License-Identifier: LGPL-2.1 WITH Linux-syscall-note */
>      15 /* SPDX-License-Identifier: LGPL-2.1+ WITH Linux-syscall-note */
>=20
> We are in the region of "Lies, damn lies, and statistics", but
> everything with an SPDX tag has some form of GPL/LGPL. Now, adding
> SPDX tags is a new activity, and adding the GPLs tags have been done
> first, since they are easier to do. So it could be there are a lot of
> UAPI header files which are not {L}GPL. Also, given this small sample,
> it seems BSD is more popular over MIT.

Problem here is how the most SPDX stuff was added (until now). Mostly thing=
s=20
got an SPDX tag which either didn't contain any license information or whic=
h=20
used a rather obscure way of informing the user about the license. If I sea=
rch=20
for some (not perfect) markers of the ISC then I can find 471 files (includ=
ing
the nl80211.h which was the original reason to chose the ISC). And I find 3=
154
for MIT and 2371 for BSD (no idea which version is more popular here). I=20
cannot be really sure about the results until the proper SPDX tags=20
were added.

    $ git grep -l 'Permission to use, copy, modify, and/or '|wc -l=20
    471
    $ git grep -l 'Permission is hereby granted, free of charge'|wc -l
    3154
    $ git grep -l 'Redistributions of source code must'|wc -l
    2371

> I understand the reasons for ISC to MIT, so
>=20
> Acked-by: Andrew Lunn <andrew@lunn.ch>

Thanks

> However, i wounder if GPL-2.0 WITH Linux-syscall-note OR one of the
> BSD variants would be more consistent with the rest of the kernel?

=46rom a popularity contest perspective, the BSD licenses seem to lose (I=20
could be wrong here). But some of the BSD license variants are also under t=
he=20
LICENSES/preferred/ folder in Thomas Gleixner's latest patchset (which was=
=20
prepared with Linus & Co. [1]). So technically, the BSD-2 would also work.

To the "GPL-2.0 WITH Linux-syscall-note" part - we have currently the probl=
em=20
that this file usually doesn't exist in a packaged form on Linux systems=20
(yet).

Usually, people are just building the external kernel module when they want=
=20
the latest features and then build their software *not* against the headers=
 of=20
the external module. And this means that people tend to integrate the file =
in=20
their software (even we do that) to be able to access it when compiling it.=
=20
And I would like to avoid that people are scared of using netlink (with=20
batman_adv.h) because they would have to package a GPL-2.0 (+some extra stu=
ff)=20
licensed file.

It seemed to be the easiest/cleanest move to have the file under a permissi=
ve=20
license. Especially because this file only contains the IDs used when
communicating with batman-adv over netlink and some (brief) documentation.

That said, I personally don't know of any closed-source software which uses=
=20
the batman-adv netlink interface.

Kind regards,
	Sven

[1] at least I've read more than once that a this or that decision cannot be
    changed because Linus said so :)
--nextPart3280967.PehHDCzncB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAloXD6wACgkQXYcKB8Em
e0bFzA/9H1eXuOH22zLlWYBqkzo+8l6TIhfmFEOiC5EtdG/2vCkti6YitEzHfAEm
bpLJGUmX/zyneWgzUi/XLq3bsBs6N54mobeD5CiDasgmQJtTRZbyd5UA9/S0cAHJ
7aYk7sX2qe/hhsa4udsnWvTMLuA/xnp43drayOhnAZ+F3kc0kEYWhe63YhZylKCO
EEHwNB7WX8XHttMMJ/HEt9NyVYjUNqKOv2trMmkQ6oLm5+/PRJoIhhr3f2AVgS2z
nhGBnOB+2Og21f2pRSboRZQdYIYAKcDWSH4znHdi2uO1sC015Jxfg4PKP1bzqUOe
Pvise+vYIUYFMHu/REKoTRu0FVYjesaXDC3JmAyCgX+cudqj5d1z+5yHL1REeSqp
+ss4AiQz8pRuxj5+Wm485dJZAiWjWYTVOgagm7Qwzas419Eelqecf54UxC4ObvSm
kOyA7GV1Z6wh8+ov/hEjW3zwggOIMM2daGbCa9B3hPX4GUHui4InxzhZQYmwJKZM
5xU8l8Oft/ZnnsJvSEh/nv2/e6mPtr9Phjnr3jsHI7Lx3u6zbW4dnF81ga4g+fH9
3weWcR81QXmcZdenQz8ReEs9lBuhzB89U2nYp0Y1mBq2j1gkZi1vang2COZS3B3N
hPVAx/fTkA8hBbGnpcySTe9lmDchA+0/jhUfKNwB+aSymkhXSQA=
=N+rn
-----END PGP SIGNATURE-----

--nextPart3280967.PehHDCzncB--

