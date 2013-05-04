Return-Path: <ordex@autistici.org>
Date: Sat, 4 May 2013 13:39:20 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130504113919.GD3773@ritirata.org>
References: <1366984615-15429-1-git-send-email-mihail.costea2005@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lc9FT7cWel8HagAv"
Content-Disposition: inline
In-Reply-To: <1366984615-15429-1-git-send-email-mihail.costea2005@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Made DAT more generic by adding support
 to any type of data
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--lc9FT7cWel8HagAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2013 at 04:56:54 +0300, Mihail wrote:
> From: Mihail Costea <mihail.costea90@gmail.com>
>=20
> Made DAT support more types by making its data a void*, adding type field
> to dat_entry and adding data_type to necessary functions.
> This change is needed in order to make DAT support any type of data, like=
 IPv6 too.
>=20
> Added generic function for transforming DAT data to string.
> The function is used in order to avoid defining different debug messages
> for different DAT data types. For example, if we had IPv6 as a DAT data,
> then "%pI4" should be "%pI6c", but all
> the other text of the debug message would be the same.
>=20
> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>

Hi Mihail,

as discussed on IRC this patch is now pretty mature and looks very good!
Also other devs have read it and were happy about the work done so far.

However the idea is to wait and merge this patch together with the IPv6
mechanism, so that we don't only introduce this generalisation, but we also=
 use
it (Bloating the kernel with something cool that is not exploited is not a =
good
idea..).

Hence we will be happy to to wait and review the IPv6 mechanism as soon as =
you
can send it over the ml.

While discussing this patch I imagine you learnt a lot of things which may
help you in polishing the code that is going to come :)


Let us know when the IPv6 part is ready to be reviewed! We are all eager to
introduce and use this new feature!


Cheers (have a nice Saturday),

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--lc9FT7cWel8HagAv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRhPNnAAoJEADl0hg6qKeO3PkP/j9DC+zi58OfxdWAUs4IRGJa
YffpicHiXyqScBG5BCu6jJkY1pMyzbqChApcarQVIMsBWpAEttH8ObnrJoTfeZds
npD4utc2zuozYskJzlHRQzeMHUdU92T242BrWz7iWAdpIzJC4Bwuwp4D/CgQsDv/
W8LLPWBTS/7+i1tCNz03WOxke/+5w5i4U+NWAyA5ElJU8NoX8iBE1/XC5jNhnRws
iAC5eLzP5tWVjkUq7Zr46hiQ5GHg69coNPqD+vKoQMl8jGdZolIoPIgwwbNCoWCi
NQ4uHF5ffXGnHP5qCl4g3fkYYILtnIVGN9/Sng+PFVDtSUud6A+X5O/o7eCSFSqT
8oYlhrjnLkhDD1lUeFI2hN2jNighYjewls35P+xeKo2BJrbX8zQBGRUSKaQ6e+xI
QV5UaJGpERYgTCU6mO9N9RAZLWRgRjt6RVftgeCbHpGTq6WGhOX0qOmluuBEf2yP
rHxI5Ii3pvTEkCELH9GV9/qJoewGa7XX5F2FzsIkksu2OGUz9jzHrsSKGIjakORY
GJ2cxZRDa9lT8hmbVHrA/YuQt8/rgeEs8SGclQZlmfqtuYVx81c5fy5NxVzKx16D
HTUjpqXTAdKK1fMjTBybhYOCbWKz5BOp/5BrVtzIKP55LElzaOlv3uV1kr3e03jZ
SsVD7QXK0uNTlsM3DxGt
=ZTF3
-----END PGP SIGNATURE-----

--lc9FT7cWel8HagAv--
