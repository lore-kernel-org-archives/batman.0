Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 08 Apr 2019 11:14:30 +0200
Message-ID: <2333514.yPfxEEDAa4@bentobox>
In-Reply-To: <20190407112320.32021-1-linus.luessing@c0d3.blue>
References: <20190407112320.32021-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4072542.o65Qt8kU2r";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4 0/2] batman-adv: increase DAT DHT
 timeout
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
Cc: Linus =?ISO-8859-1?Q?L=FCssing?= <linus.luessing@c0d3.blue>, a@unstable.cc

--nextPart4072542.o65Qt8kU2r
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, 7 April 2019 13:23:18 CEST Linus L=FCssing wrote:
> To increase the timeout only for DAT DHT entries added via DHT-PUT but
> not for any other entry in the DAT cache the DAT cache and DAT DHT
> concepts are first split into two separate hash tables (PATCH 1/2).
>=20
> PATCH 2/2 then increases the timeout for DAT DHT entries from 5 to
> 30 minutes.
>=20
>=20
> The motivation for this patchset is based on the observations made here:
> https://www.open-mesh.org/projects/batman-adv/wiki/DAT_DHCP_Snooping

Antonio, please check whether this approach is to your liking. Also that th=
ere=20
are now two ways to retrieve the DAT data via netlink.

Kind regards,
	Sven
--nextPart4072542.o65Qt8kU2r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlyrEPYACgkQXYcKB8Em
e0aiQxAAhp7fw7GvHmeWAjlxxPz5JRWhREXMNQXMoYs5n3XL8retS7V9uHkw0ZNQ
hydcH/IgfYS47GwVKiQJAHpwRwvMCtdNj78B3GOog8rKD4oc/BikP28jpJzpY+df
qFxM//c9SjAG/UG3gluFbVv9JeYu6WBfF+B5enoQZmNcT58wR2AVciTRjtLPKYlF
aHs/84aYpoB28VZUgdw+X5A4pFsO+tB/wCR+43s8jkLsU4kMBnpW4ggZ8dM1sqHC
yrsSbTBWVGMe7BlwGCAqf9x3kHyYQk6yr5x5Z92AvOB9LcUHX+YM3cAXaIhzsRvg
jmyoAaCOQqcETyHGKGs6abRE0MPL9HcsSV4CUtmYWWI9TWu1/OSTWlIVWzAfxjBb
6J6VPvHDMMh3bXh2Ssb/A6F5QesvdKPDQ9w00ZBoFh1zSMs7YPl5K6vzEHl1pp38
lEqcqe8PJYETZuMSYPHF212iExHhtbRNxN+GL01fD01EP6d3gxk/aA6IgU5/a053
Du5xoqkyYfhadg1w6V2tjr5jtljs/bi6915mL+H/vgR94KXbkoRauVAyabM1VGu+
agMfvwaC7HRG0J0+cIg8SS1IH0ijpoJA/RfD4qp7w4Y78dnkqT6IWnTFqCfDcdaj
wClh8Irx4Lu+R1lVSI6wepA6z/mF+mJNGk3vcXK5E5i2U23A/Zw=
=MEuC
-----END PGP SIGNATURE-----

--nextPart4072542.o65Qt8kU2r--



