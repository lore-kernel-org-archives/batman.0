From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 27 May 2009 18:16:01 +0200
References: <4313f3060905261148t14ea24bcq6f2ebca3e1007106@mail.gmail.com>
	<200905270013.12447.sven.eckelmann@gmx.de>
	<4313f3060905270720k45859cb5y822c47397482b77c@mail.gmail.com>
In-Reply-To: <4313f3060905270720k45859cb5y822c47397482b77c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1301356.YPKn0QLJ2n";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200905271816.04764.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Debug Malloc Problem
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: Nathan Wharton <naw@greptar.com>
Cc: b.a.t.m.a.n@open-mesh.net

--nextPart1301356.YPKn0QLJ2n
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 27 May 2009 16:20:16 Nathan Wharton wrote:
> On Tue, May 26, 2009 at 5:13 PM, Sven Eckelmann <sven.eckelmann@gmx.de>=20
wrote:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > #include <stdio.h>
> > #include <stdlib.h>
> >
> > #define x_moved(pos) ((int*)&x[pos])[0]
> > static const int value1 =3D 0x01234567;
> > static const int value2 =3D 0x89abcdef;
> >
> > int main() {
> >        volatile char *x =3D (char*)malloc(sizeof(int) * 2);
> >        x_moved(0) =3D value1;
> >        x_moved(2) =3D value2;
> >
> >        if (x_moved(2) !=3D value2) {
> >                printf("ERROR Value: ");
> >        } else {
> >                printf("Value: ");
> >        }
> >        printf("%x %x\n", x_moved(0) , x_moved(2));
> >
> >        free(x);
> >        return 0;
> > }
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> This results in:
> ERROR Value: 89abcdef cdef89ab
Thanks. This is completely unexpecting for a kernel with alignment trap. Th=
e=20
expected result is  "Value: 12389ab 89abcdef". Can you check the value of=20
/proc/cpu/alignment ? I will look further at it this evening.

Regards,
	Sven

--nextPart1301356.YPKn0QLJ2n
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKHWdBAAoJEF2HCgfBJntG+OoP/2KdqDFYSLJMn95M0WuweaZ0
+2q25gxLBd2p/WH7nBooL2IeM+CldDXM2anIP1xzxBv7wSXXbaOmaIvZCEjKN8qn
qev06hYMVz4haaWniZMcANmFNmfYgIhpBvna2U5F6r9aqL3nyfU5WNFrknL7bK2D
YWZI5Lx/3Z4Rle0f7gN8sWKM9iQ+9ZyhdoGa7C74IH1Cz8DR2aQBfufYxUStOtd/
vbn7lbqTjPg7hI6esNlN0I2EFNDNKY1JPyd9SZMe5c4YYZcc+hVflH0qPCI3gcEX
ZVlJYgr+2D76pjhZEl0aQ+xqKOBo0UctS3qHAbXqhi9g4fvIa68P/42h7tXoy3Lg
VHTlyBMSDzlhkZsuSMUIbcfmlH8cgzh/Db9PALKa34kiXNS7ghgiYThtMJ+YL5bT
P0fJm/tIYBshHZ6utexVgvG7+cl2pLoJOjhodFJWR+OErANnnIENE9PkHcmSFwlK
y7e5BoNmvKUH3hSeHJcPQHQ5Zj5cednCfsq02q01MDjVoE8E9jSwuoSkrjjtV0fG
zlLhE7Ic7xDZdjealRfKhlVePwRHnXtoPwTRmOaBa0exjsMgNBoHerjGB5mSKJj4
0wMpmfwMUT+aVb3k6Xcllbnpq9/h5Psr4kw7ZqWLcwh72FjB5W6Ct1+/XTU1y9a6
vt4DmzSIpnLsG9xopDIW
=NJtG
-----END PGP SIGNATURE-----

--nextPart1301356.YPKn0QLJ2n--
