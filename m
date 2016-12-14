Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 14 Dec 2016 21:49:32 +0100
Message-ID: <1839226.YuCrK3WLFe@sven-edge>
In-Reply-To: <20161006064142.20003-3-linus.luessing@c0d3.blue>
References: <20161006064142.20003-1-linus.luessing@c0d3.blue>
 <20161006064142.20003-3-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1759315.ek7toy45ip";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/4] batman-adv: Store and transmit
	own neighborhood hash
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

--nextPart1759315.ek7toy45ip
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 6. Oktober 2016 08:41:39 CET Linus L=FCssing wrote:
> ~((u32)0);

I already saw this multiple times. Maybe you could use U32_MAX from
linux/kernel.h.

> u32 min_throughput =3D ~((u32)0), max_throughput =3D 0;

I personally don't like multiple assignments in one line. Makes it
harder to check what is assigned and what is actually the next
statement.

Kind regards,
	Sven
--nextPart1759315.ek7toy45ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlhRsFwACgkQXYcKB8Em
e0b5VRAAmSJXpc9VZoCuFnbpeccTzf1nByTok7nrfh98gyzjJLjzfHnMTcDsgAy9
fm88FTRBDpGcfnMMlXXrcpPeJW+r1Y5F0H95fjq2d8WGzxWw+LjiXr2nBnwwRAzF
zVZgxe4bI6rhjFyrelqYeD86nyThHwnAPO0HROYzX9ioOPeEuqlxbJIHu8Znp/uc
kvVjiwulLICSzvG0QQ/PwGSl1KV6uMGvZkp1rlegXVUkW8XPseaVkfqssVDgfuc8
4iE6U+F6l8lQ3SIxg+WdjA0O+iVFeKgTWClyvPM0G7KQFDUk4CqeTaU/TFkWNAqd
HRKidvopxd2P1p9h6p/nhmYMTdt+KJeIvZRTP+MEazW8ZOP7913+n8yYm1nWeQ5b
lmFKA+dmAWnTuyYg/yAbOz5Q/r32342vR1iq38VfoLGHviP0+2J8lIttfbwmQXFL
xdAbHODmO3mRtH2NB+kZzkg48sZ5rgGVXAfS/60bSJsuCyzsFXUS82zeJbMlioSf
t4DzNSHXlb1nNl8/ERS8uvH0Ip0SHF4UBI6uBHPKIREUW0M9MtVXpH6yo8jf+0ss
nQmqvFlAj6pIkfSZuyyCBNRWl3vAAQOBp7J7ivu41SLsm9rArzSzxuzm/3C3R9RE
sIg3Q86/ruNTukQ3Su8i4V+vKFZSmjH0lUfq6gZwOwdpSFwUIug=
=gcvw
-----END PGP SIGNATURE-----

--nextPart1759315.ek7toy45ip--

