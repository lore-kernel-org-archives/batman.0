Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 19 Jul 2016 08:59:01 +0200
Message-ID: <2594732.GzDknJdsZu@sven-edge>
In-Reply-To: <20160719062907.GA10173@otheros>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
 <1655869.LYQpVbDg6l@prime> <20160719062907.GA10173@otheros>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1833339.LItjSsOBvE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 2/6] batman-adv: speed up dat by
	snooping received ip traffic
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

--nextPart1833339.LItjSsOBvE
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Dienstag, 19. Juli 2016 08:29:07 CEST Linus L=FCssing wrote:
> What do you think about doing the same in batman-adv? That is,
> only updating, but not creating DAT cache entries from IP traffic.
> That should get rid of the main two concerns, accidentally
> snooping routed IP traffic and performance implications, shouldn't it?

You have to snoop the traffic anyway and search in the dat cache for each(?=
)=20
packet. And the DAT cache is distributed. So why would it avoid the=20
performance implications?

Kind regards,
	Sven
--nextPart1833339.LItjSsOBvE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXjc+1AAoJEF2HCgfBJntGnwUQAInhgrWIFvzQouwdcWu5Y9B4
9aAkFKdejd0dAZOUQixsIen7NbOy3xzDQJr2XDZ/8BP9Qu+DcONPAGmbengZ03hE
dtMb64OLCbQyHsGNXi3I3ANJIUSEQSFNf3N9zHPbChk/v96vjU7xMeLWGY9bfpPF
7ieaJ280ivNQSaIsv7AxxzaPLQlul1VqFN9kuo703GtrYdlh6xu//BgKk8NYbnrG
YJz9VgXL/DD31ehjOZa6O170D76o/m4Y+cgohmA/3euHex+Ub3rrMDupQ/gB6KVf
Dc7MdPl6H7QAyiz0+VwIMxCxKOuacIytzDhxaKPhIxon1rL5KZicgyEJsDv44YAV
zOHEVzY3J9WCtFO4TJ7eYqe4EZvfYULFohVjLHJphlUpiU1PrpAq5MNTTVDA+7pG
hFIeEHh/juYF6M0wwB9O/bM3yutDiBzJ6ivoiRojyjIUQv2J0Pizw0Mw0YYDTYwJ
TKi91Fp/mKsoyGC2alAKC21jYYeUWkLrzptH3mkViO9z1M2b9u0omhNku6tvzuE8
yyTVQzDkVonCT4eA+4IJtLX5my3UmydRnOuqaejbIVzcW3TyRtbmWWd6cI5L4VhP
A4jJG8eMILklSWLnkl8iUIf34DyCjQUGYhrhhHmVP9kBCPxKNx+chGm//ZVejj42
Wk/qsJS2Cjb/083hck1n
=noZH
-----END PGP SIGNATURE-----

--nextPart1833339.LItjSsOBvE--

