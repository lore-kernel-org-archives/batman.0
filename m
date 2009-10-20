Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 20 Oct 2009 22:22:31 +0200
References: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com>
	<200910201917.12629.sven.eckelmann@gmx.de>
	<45f642440910201259j63a37a7bi58ea8b97a094a82f@mail.gmail.com>
In-Reply-To: <45f642440910201259j63a37a7bi58ea8b97a094a82f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2289961.hRlSADyTOA";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200910202222.36928.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] basic B.A.T.M.A.N-adv setup
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart2289961.hRlSADyTOA
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=46rancesco wrote:
> Hi Sven,now I see what was wrong, I'm really feeling so stupid.. :)
> It was misleading that I reached the batman-adv download page (
> http://downloads.open-mesh.net/batman/stable/sources/batman-adv-kernellan=
d/
>  ) browsing batman 0.3.2 download page (
> http://www.open-mesh.org/wiki/2009-06-13-batman-0-3-2-release ) and I got
> confused.

No reason to feel stupid. You aren't the first person which got confused by
the different implementations of the B.A.T.M.A.N. algorithm.

> I didn't read enough about batctl and its use against most recent
>  batman-adv version.
> My fault.
>=20
> As soon as i get back to the lab I'll try latetest version of both
> batman-adv and batctl and see what comes out.

There is currently nothing like a stable branch. So if you want to have 0.1
with some backported stabilization patches you should look at the Debian
package of batman-adv-kernelland[1] and batman-adv-battool[2]. The source
packages of both packages include the separated patches[3].

But if you are currently in lab testing I would recommend to use both from =
svn
as batctl has some nice new features and changes in batman-adv-kernelland a=
re
also looking quite interesting.

Best regards,
	Sven

[1] http://packages.debian.org/sid/batman-adv-source
[2] http://packages.debian.org/sid/batman-adv-battool
[3] http://git.debian.org/?p=3Dcollab-maint/batman-adv-kernelland.git;a=3Dt=
ree;f=3Ddebian/patches;hb=3Dmaster

--nextPart2289961.hRlSADyTOA
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJK3hwIAAoJEF2HCgfBJntGdrEP/2DXsWBKpq4gbV24G9fbf05V
us1ukx80kzp0vbJRi9TIbI5H8viuulDb2R+PavS/6rsQas/l6i7QVQkGSZJNsjib
YEYf3222KZPD8Hv7flYcdGQ3zcvjQblMCE9JtTtlHkXCEFTO8q282Jl7ZqRHa9Tk
u7GbVb9KZtmQ1VO3rpmU4hZlVbTXdURUW5XFLxWNalAln0lC9hN/XxwjYVare8CU
82Ng4FmMMfyFwJoMVuzd9bI80LhGEM0PIXP//W/bcyt2uTgSZoCMVwniE89Kv2kf
+w4hztYEsN+W65D3C+ZrCmRHkz3LQwJWKfScjl1VklxMxuAIb6M+QskKnW0xW0ra
Q8KH7LCDd7wh5rwX0dIYsxkBKnEFiPcFGlxYhtOlMZOUwcGGHZJrFnuYDTUgDWj5
QMcma1Xbwvx+ioG/zw+zj1i3FgAAARPZV6MZARjeAx9mrZ2EUru+W/r472093jAl
jqg0lUwU4BKV0IHtJjpyeUGZ62rYT5RgeNiTtwCrRo5Mj6o2CapW70zuOBnnv7rK
6sV3uUgDcZZww/TQXO9I9vK4fnA/wlF+qHxYe3em2jtYuY6kTU6idAq5E/sTIWmd
XxfQtGtwfEJZbfVi4nHCd8Ohl21NXDp+IBLcT3kSAb3bByq6XUQrQfjxiLqKCtTN
aunG9hdYA/u6xQxfTRrW
=cq/V
-----END PGP SIGNATURE-----

--nextPart2289961.hRlSADyTOA--
