Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 16 May 2016 00:06:51 +0200
Message-ID: <2095413.dm017UXCDp@sven-edge>
In-Reply-To: <20160515212632.GB10345@otheros>
References: <20160514145129.GD4375@otheros> <10164043.KPuzFIC6Pp@sven-edge>
 <20160515212632.GB10345@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2169848.0zluyr1Fkq";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] kmalloc() vs. kmem_cache_alloc() for global TT?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2169848.0zluyr1Fkq
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday 15 May 2016 23:26:32 Linus L=FCssing wrote:
[...]
> Yes, it's not ar71xx like you have, it's x86-64/amd64 in a
> VM. sizeof() actually tells me 144 bytes for a tg entry. And 56
> bytes for an orig-list entry (like I wrote before).

Ah, sorry. I was doing something else when I received the mail which ex=
plained=20
the VM setup - I scrolled over the initial part of the mail and only re=
ad the=20
part about your own patchset.

Kind regards,
=09Sven
--nextPart2169848.0zluyr1Fkq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXOPL7AAoJEF2HCgfBJntGoK0QAMg7xRnniaju/Mad0Dwlpnkm
2Y6s6k9yAXsTS7w4QFsmK6juc5vHzHFR9Wg0UvEGj9tioHnhrqOMgqEo1vgupPsU
spJWYM89NBU7dgMsVpd5ryAWM1WkI44dxqcs8TDWEVOEHNX1qFh99u0y1nR5Er9i
Pdv+NuWME+YICy9DTvOzu5mGr6/dyxOlcilhza0t6kwMrk60S3kcsMTAURGk2Ap3
tKZkRJq0uATbb7v07y7FM6w8Wzhe8lsHZjGXymXnrB4IAwbSC0WwPbmCB1LUgQGC
cYpkxUH0z3Evbko2tlRHPOQmfDV3kfgIEloZCvyhFRtsY1OaWdf4AYHbOzR12Azj
2NjUX89T/gxzEHkgTdCm9lpLYdkH4F3YMFDTIQKoq7wQQ4DkGL81N/EL+khpBrtn
Qh9wy/eZKM+8dFxpdEjJFUYSuIVFyVELps8+IXCBvRnI22OAPYxL2o50hSgUQbYV
WbJM5CtEDj05RFiZPRbCy4ffPsfFoJZTMzy9DuUe42ZojbB5g+UQaH0NRSMiCTZM
a1RJMFglXKYppCxMa/SnthD0VUtwhC7RxrWlrVaxI9eIHQpKmT9881Zjy17REfr3
TOzslXqzFDl8EGd4IfOUm4PU3qTl6Lr0QI+IrcZHXX6952b5V5nEMOGJtW7shxpT
xg6v/INXyWsl6nXyuazM
=x3mR
-----END PGP SIGNATURE-----

--nextPart2169848.0zluyr1Fkq--

