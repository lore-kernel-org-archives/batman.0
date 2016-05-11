Return-Path: <a@unstable.cc>
Date: Wed, 11 May 2016 18:47:30 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160511104730.GB21549@prodigo.lan>
References: <1462962557-23950-1-git-send-email-a@unstable.cc>
 <2789203.91ASHWIDJV@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
Content-Disposition: inline
In-Reply-To: <2789203.91ASHWIDJV@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: remove forward
 declaration by including proper header
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2016 at 12:38:31PM +0200, Sven Eckelmann wrote:
> On Wednesday 11 May 2016 18:29:16 Antonio Quartulli wrote:
> > If main.h is included, the forward declaration for struct batadv_priv
> > is not required.
> >=20
> > Cc: Sven Eckelmann <sven@narfation.org>
> > Signed-off-by: Antonio Quartulli <a@unstable.cc>
> > ---
> >=20
> > Sven, is there any special region for not having the include in this fi=
le ?
> > It seems to be compiling just fine.
> >=20
> > Cheers,
>=20
> We have some files which don't include main.h:
>=20
>  * net/batman-adv/bat_algo.h
>  * net/batman-adv/bat_v_ogm.h
>  * net/batman-adv/netlink.h
>=20
> There is a special exception which should not include it to avoid cycles =
in
> the includes:
>=20
>  * net/batman-adv/packet.h
>=20
> The reason for the other three is just... there is no reason I can provide
> other than it was not necessary for these files :). But if you want that =
to
> have "main.h" included everywhere then please do it really everywhere:
>=20

Maybe I could include it only when really needed, i.e.
 * net/batman-adv/bat_algo.h
 * net/batman-adv/bat_v_ogm.h

(netlink.h does not seem to be requiring it)

Cheers,

--=20
Antonio Quartulli

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXMw3CAAoJEJ4aZjxxc6bKO6kP/RdlDam3M+AQgbXldA6O307f
fJITDsz0lqyisplxmlN0FgYnYVQkxGUJZL3aLhuZ3v0GbQR/891+lkleinmEFHxO
jp9Fh1JWKXQDJAz/mC5g51XxoGjlA4xRclYf4YCOxdpOfnxLsIX7IB+ZkIId1k+z
6Ks7Wd02iYcN9juuioa4vY4RzSYAw5xH6xUu//k1J6RXks71DhOw1Dmnz6/1OSns
1OIzf1/W6uhdBCBHwbwEhm8qjOzvX6zR5s67WlrS5qPhdvqJvephLdb9cpSliVM9
0QL37IijkD9lqN/JUOZOrfKm6y+gZB6C8CA3q3l5egsvwJFmoWhDcCCcTlxpDA2X
Ds5qnJLo+qpA47XFKTswShJJ6uA1BO1l1nZAjGx0U/b0JuO2rvkgcaPXGO/K/1zl
3DXixm32l9IWIa2HWvaKtPTiQHuapWrwH4UJ5yZg4cmNYE1LLmDMHX7HSszbnHV2
+G2rHshCSaxJx9K19JQO4f5ojKdsZhCzbdonBkDj+6dFsCeEL0yE9mzGVXouZkCB
CQ080AZfRcDnFTKa2yuu3+HLXPQC0qMHCKBmTCdGOkZNCpjy9umXPlSqcN00GhVV
yXbngIoFixaI7prX9i1R/qUOYbwNY/3TIGmWOZ47MVWyQdTADuquV51rJr8QNFM2
347EosRD0NG5lWnDiDuF
=paDI
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--
