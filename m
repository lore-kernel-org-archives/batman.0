Return-Path: <mschiffer@universe-factory.net>
References: <1439848023.1458.15.camel@nord-west.org>
 <20150818080855.GD19496@medion.lan> <1439915717.1370.9.camel@nord-west.org>
 <78ccce3e5516b2613b09306a586f2584@hilses.de>
From: Matthias Schiffer <mschiffer@universe-factory.net>
Message-ID: <55D5B5B6.60002@universe-factory.net>
Date: Thu, 20 Aug 2015 13:10:46 +0200
MIME-Version: 1.0
In-Reply-To: <78ccce3e5516b2613b09306a586f2584@hilses.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ls0xkGCu5sSrleOpp95igtl3jBpejRRko"
Subject: Re: [B.A.T.M.A.N.] Kernel crashes when using more than one
 interface in bat0
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ls0xkGCu5sSrleOpp95igtl3jBpejRRko
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/20/2015 12:08 PM, Hans-Werner Hilse wrote:
> Hi,
>=20
> Am 2015-08-18 18:35, schrieb Bjoern Franke:
>=20
>> Thanks for the hint, it did not work on the debian machines, but I got=

>> the systems running with crashkernel enabled. Now we got the first
>> crash:
>> https://p.rrbone.net/paste/nnNHrIJI#oHfBMOs2
>=20
> We've seen these on our Goettingen Freifunk gateways, too. There, too,
> batadv_frag_purge_orig was the smoking gun. However, I didn't report it=
,
> because:
>=20
> - first and foremost, we were using the outdated legacy 2013.4 version
> - it was most probably an issue with RCU lists
> - and either disabling SMP or using a much more current kernel fixed it=
=2E
>=20
> So I blamed a buggy RCU implementation in older kernels, plus maybe som=
e
> ill behaviour in the old batman-adv codebase. The crashing kernel was
> the old debian-wheezy one - pretty old, I'd say.
>=20
> -hwh

This is an independent bug (2013.4 uses a completely different
fragmentation implementation) that has been reported in
https://github.com/freifunk-gluon/batman-adv-legacy/issues/1 . Please
don't bother the upstream BATMAN developers with batman-adv-legacy bugs.

Matthias


--Ls0xkGCu5sSrleOpp95igtl3jBpejRRko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJV1bW3AAoJEBbvP2TLIB2czXMQAIlQOOxlV7wrKg4P1rzmICGZ
ISETql0fp7MeKdJwxcwVI3NY5+FmMcD4XPLNF9Piw+WYPIEFVL5PKSPnawCrQLF6
UwTGj0uUUDtEDPnVwsikr78NzyrNWtE1cra83XYCXj90DN7aHiVJAwNhbpRBdIiL
98dT6W8Mxbd+ROWG4nEO8DeeakG2omEc49Iv29YFGuoCNeEFJoBRlHniGfm+9Bdk
e/M6ULuBTLzul4Kb7JKJ7EzhD9928l9CYo577/Ksj3Uq1fsOrS99UbXbaQM8lwru
Mu7J//i2l9NoHWC/dYF5TFjO+q7uVwMzMoOgdD45pOKKA2LBAXBB/mIIBY5ITDW/
lfwXU53xr0lI9co2XMm/GTiETtk6z4OzF0u19wU7wF6mOQCGsiYM3EXVz8t3i2Qa
YMOvmClHC2z1lJHrhsL2l+ipEQNmcyyhyyhXWawj5ELn/qWBiX3GNHJAWW3RuJEe
LAB40OKwpyfz6WegGMpST6VCtfa5mjd3LpXrJxmylHJ1KsGrvgQC+xU6K6HVIaZY
FcPwmRjyN+d5jEJuZ5OvtwneHPl1pxotX90aX6cAStDgpmdGQK+pu7YckUEQjQ1D
usXCqxGM0vC2eSJtjqkATGj2ARORDc40mJYEUv9T/3ih29YQCecT6u+rX6PLiN+x
jzfzDN6MV5T+8cdMMUeP
=vMP9
-----END PGP SIGNATURE-----

--Ls0xkGCu5sSrleOpp95igtl3jBpejRRko--
