Return-Path: <cmsv@wirelesspt.net>
Message-ID: <52E02EDC.3080805@wirelesspt.net>
Date: Wed, 22 Jan 2014 15:49:32 -0500
From: cmsv <cmsv@wirelesspt.net>
MIME-Version: 1.0
References: <1390299725-1873-1-git-send-email-antonio@meshcoding.com>
 <86mwipch0u.fsf@coulee.tdb.com> <86lhy8pn5v.fsf@coulee.tdb.com>
 <52DF7556.9090200@makrotopia.org> <86y527oqpl.fsf_-_@coulee.tdb.com>
 <52E003DD.6040302@meshcoding.com>
In-Reply-To: <52E003DD.6040302@meshcoding.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8VTmOCM6iDiTF4TxgneFgDeisvHdAj3Pf"
Subject: Re: [B.A.T.M.A.N.] batman-adv: memory leak?
Reply-To: cmsv@wirelesspt.net,
 The list for a Better Approach To Mobile Ad-hoc Networking
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
--8VTmOCM6iDiTF4TxgneFgDeisvHdAj3Pf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


I had the same problem which caused reboots but after the last
batman-adv update i am not seeing it.
all my devices are have mb ram
i am using network coding and 1560 MTU

On 01/22/2014 12:46 PM, Antonio Quartulli wrote:
> On 22/01/14 18:45, Russell Senior wrote:
>>>>>>> "Daniel" =3D=3D Daniel  <daniel@makrotopia.org> writes:
>>
>> Daniel> On 01/22/2014 07:04 AM, Russell Senior wrote:
>>>> Has anybody else seen this memory leak?  Leads on where it's coming
>>>> from?  Not a runaway process, at least not that top shows up.  Just
>>>> a gradual disappearance from MemFree that /proc/sys/vm/drop_caches
>>>> doesn't fix.  It isn't adhoc mode, and I can associate the two
>>>> devices over adhoc and move a bunch of data with no memory lost,
>>>> but turning on batman-adv seems to sink it.
>>
>> Daniel> Yes, and I tested (compile-time selected) with and without
>> Daniel> network coding, and (at run-time) with and without
>> Daniel> fragmentation (as I also bumped into the MTU calculation
>> Daniel> problem later fixed by the patch on this list) -- any 32MB RAM=

>> Daniel> devices reboots after roughly 30 minutes due to OOM without
>> Daniel> substantial traffic, if there is traffic then apparently even
>> Daniel> faster...
>>
>> The memory leak I see seems to commence as soon as a batman-adv
>> neighbor (same version, in this case 15) appears and stops when the
>> neighbor goes away.
>>
>=20
> Thank you very much for the hint Russel!
> Today I tried with one node only, but kmemleak did not report anything.=
=2E.
>=20
>> I am going to try enabling kmemleak and see of that tells me anything.=

>>
>=20
> Thanks! Keep us informed!
>=20
> Cheers,
>=20


--8VTmOCM6iDiTF4TxgneFgDeisvHdAj3Pf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS4C7hAAoJENmyd4cVxLOC1lwP/AjZcYjwXLsLmndhcDsWT695
lDoFSuPvkzWX8cN8lwRU0mLJDdb8ammUGrvxX+mdwXGna7hLDplSuNaPox1KSscO
iCgVte3hj2tQ/iKDC7iL2wOBk1gi0RXgiShIb/igr4DIKqANQxfrE09JmysndE0C
nexM06s/iNNeXdQWai5Lo2F6zcptvF5I26v3ZM9psnqeJWuLbNHGy6YE8+3ftq9O
fs8yKHuFfPljUz+hEMgKAvYsHPNQi5n5UKAaQPc2TFwx/4NBz+Q+4Ee5e5UekaKP
QH12rLCej5r/toovXAux0EQH3GeDs7QzytVCXKRuU78FxuX9qujareLiO7LxTRHX
Kk4VCt5eTeGQIk91s4zEmIqM/ycLieYTdLv03aYQkO12gtnjw0MD1rcW60bviLRk
ZnqGHFtE1x+QpsgjRKwuOQ/LL4j+BPCVwXBVjs3foGzVhZgax6RyImIoL2jqAqYN
698Lnzg8yxMUVzvDikj9bOaPE1cm4W0/Ex9pgK9y34DtFrZ/9vGRk/PZtxARUPOX
fl5NIAlDfQ4Io7cfbFX9BQodB5v8NidPWv60yPNFcSPfFmjHZ2HBVCwtpq0hPccM
rxjNJZfYCsyu574ZbUe9l1qUDvC4ifIucPylsV/Kj5xotkiHXiAJKfUM1/DCPC9w
IDd2v5XI+EQzx1nFm8bd
=FDde
-----END PGP SIGNATURE-----

--8VTmOCM6iDiTF4TxgneFgDeisvHdAj3Pf--
