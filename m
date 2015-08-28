Return-Path: <antonio@meshcoding.com>
References: <4340969.K0PsB6WH4o@bentobox>
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <55E0C8BF.1080203@meshcoding.com>
Date: Fri, 28 Aug 2015 22:46:55 +0200
MIME-Version: 1.0
In-Reply-To: <4340969.K0PsB6WH4o@bentobox>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mpRQVas4GL6Jv3CTW3r4prG0f43QPSwbE"
Subject: Re: [B.A.T.M.A.N.] Patches missing in batman-adv next/maint and
 net-next
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: mareklindner@neomailbox.ch
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mpRQVas4GL6Jv3CTW3r4prG0f43QPSwbE
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 26/08/15 10:23, Sven Eckelmann wrote:
> Hi,
>=20
> there seems to be 5 patches missing in batman-adv next which are alread=
y
> in net-next.git. Most likely the maintainers already know about them bu=
t
> at least one of them didn't reach the b.a.t.m.a.n mailing list.
>=20
>  * batman-adv: convert to using IFF_NO_QUEUE
>    next
>    (will be send as reply of this mail)
>  * batman-adv: Fix memory leak on tt add with invalid vlan
>    maint
>    https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-August/013560=
=2Ehtml
>  * batman-adv: Remove unnecessary braces for test_bit() in DAT
>    maint
>    https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-August/013537=
=2Ehtml
>  * batman-adv: Remove unnecessary braces for test_bit() in NC
>    maint
>    https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-August/013538=
=2Ehtml
>  * batman-adv: Remove unnecessary braces for test_bit() in MCAST
>    maint
>    https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2015-August/013539=
=2Ehtml
>=20
> There are also a bunch of patches missing in net-next (see attachment).=

> I highly recommend to format these patches with the=20
> git-format-patches option --histogram. Otherwise patch 4 ("batman-adv:
> move neigh_node list add into batadv_neigh_node_new()") becomes
> unreadable.

All the patches in next and maint should have been merged net-next and
net as of now.

Marek, could you please take care of merging these patches mentioned by
Sven in next when you have time?

Thanks!

--=20
Antonio Quartulli


--mpRQVas4GL6Jv3CTW3r4prG0f43QPSwbE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV4MjDAAoJEOb/4TMchkvfKxIP/3PZeYz2nsIivOjVFlw0d4kw
DD4+/9+WEVJaozbslbOxybbhCseHD2umESYIfnkRxWPA3HYtJWOrFqsXSMlt3fDZ
Y+xSBOrj7sMSOv2eFu5POukfyAUCddRf2dFFOzvGtH0GuOYSnlW/i8z9N0hPJGD2
WNnvT7Q14haMqq5STQBR22uKTZHUkl53qnnp1ebbhcCTrVHvQX6SD4FAuJSwD6Tu
bDuv6kEeTk9u3+PGMUjQv7fkmMPvtuWxGfkBQYK5OUOE5ejKciJyDkI2/2Dtv1rf
Qcnynm/hcg3E9HyzZ+LECqCLtsne8fmA1TO4Vs/U4mZ2K+QEqeNQqwtfa4n//kH5
9RYih4vPnVl1je/LdtIQg8sLMTqXjORE0kF2Frb88WU3ejcoBRqlAFHoZIYKBBcQ
BntDScmsi0Gquxrj+lgWM1PxUY0PYTBbknpYXKgPW8OdrPPGlvkxMxFnDVIntLL0
S3B3KIt8pSdipIHFzwikSCQ3vIhQWjzMZWyMEP0BSfTbCDSHr4kmpLd72cAbkMzg
HDgOqpcIWaDXecxhChqh4NyJx1GubpJl41Eg+/2C8lhb+YL53J8WbbwYxoFZL+rP
xDb6qqkgPzHeQUN4kOcFOMsehTmxMmKnTLzdZyO8PRzMrwlBImeyVLCuYROTdqLG
/TYCPCmQ7Gn3L+efcw3o
=C1D5
-----END PGP SIGNATURE-----

--mpRQVas4GL6Jv3CTW3r4prG0f43QPSwbE--
