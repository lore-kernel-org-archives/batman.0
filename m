Return-Path: <antonio@meshcoding.com>
Message-ID: <52E003DD.6040302@meshcoding.com>
Date: Wed, 22 Jan 2014 18:46:05 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
 <86mwipch0u.fsf@coulee.tdb.com> <86lhy8pn5v.fsf@coulee.tdb.com>
 <52DF7556.9090200@makrotopia.org> <86y527oqpl.fsf_-_@coulee.tdb.com>
In-Reply-To: <86y527oqpl.fsf_-_@coulee.tdb.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CHOFNRfBEp8HQTckAD0NRpvim9VJKQRsU"
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
--CHOFNRfBEp8HQTckAD0NRpvim9VJKQRsU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 22/01/14 18:45, Russell Senior wrote:
>>>>>> "Daniel" =3D=3D Daniel  <daniel@makrotopia.org> writes:
>=20
> Daniel> On 01/22/2014 07:04 AM, Russell Senior wrote:
>>> Has anybody else seen this memory leak?  Leads on where it's coming
>>> from?  Not a runaway process, at least not that top shows up.  Just
>>> a gradual disappearance from MemFree that /proc/sys/vm/drop_caches
>>> doesn't fix.  It isn't adhoc mode, and I can associate the two
>>> devices over adhoc and move a bunch of data with no memory lost,
>>> but turning on batman-adv seems to sink it.
>=20
> Daniel> Yes, and I tested (compile-time selected) with and without
> Daniel> network coding, and (at run-time) with and without
> Daniel> fragmentation (as I also bumped into the MTU calculation
> Daniel> problem later fixed by the patch on this list) -- any 32MB RAM
> Daniel> devices reboots after roughly 30 minutes due to OOM without
> Daniel> substantial traffic, if there is traffic then apparently even
> Daniel> faster...
>=20
> The memory leak I see seems to commence as soon as a batman-adv
> neighbor (same version, in this case 15) appears and stops when the
> neighbor goes away.
>=20

Thank you very much for the hint Russel!
Today I tried with one node only, but kmemleak did not report anything...=


> I am going to try enabling kmemleak and see of that tells me anything.
>=20

Thanks! Keep us informed!

Cheers,

--=20
Antonio Quartulli


--CHOFNRfBEp8HQTckAD0NRpvim9VJKQRsU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS4APhAAoJEEKTMo6mOh1VGn4P/j7c9d4vcA/ojFofLOo/CxHU
E7mbddrTmKgYdlhNe9MTuv51H7yQA5PP+45UnBobYE0lRG5jsvd4L721+ZGPyb05
FH4Yyrpq47JbqzIr5tnkt4aD2GV5WKy4OilxnVvs7fpo/zL65MGbQAE+z+O80Ync
vJBtXNIE0chfryJltQZk0ZeDImyLqyGAjqInBy4X+bV2SkL4oqifSacNJL8sHPNp
+SA9Wy5vb7x+CRTtdMeILLDf8Wtt8H+30KXXjRKiykvgAbn904AqJu8cvAlOAEmD
ymaFFDIM6qx0O+htKOGkv7daLOQbbqxhu9iy0H3+dQmLnD1/JrBl85cIkww79zjZ
cf7KFa+Ma53J+vSBtTlVLMbDLZfrhSyWUCLPGRdF7/1cvzsXFSNCrMHeEqQbNz+k
RsDxZsMtzWf8JdRx0JU6/mJOfIc1emCOoDRx5cAEJGa7uO9LiGNwK1lM45fCAApV
L/QjhmIFCnBSRVLyLq2LsZ6nbNP/TvjB3XyMeeKJCx4Oz+j/wU+k5En44gqljvnL
FoiLbtQnNYnG/P8NWzwHVOnVqIODwKDUD+lMifpt7w/E+c0836jnzmW1J6ipdmfI
G3QAbSKTZds/aZ3FC/2nVpTV60WCIZxoL2Oq+NaAwrrf4+vffckZ0eWvuego6kxd
DsjxJTvA5V7k8KFD38iA
=nX06
-----END PGP SIGNATURE-----

--CHOFNRfBEp8HQTckAD0NRpvim9VJKQRsU--
