Return-Path: <gmazzurco89@gmail.com>
Sender: Gioacchino Mazzurco <gmazzurco89@gmail.com>
Message-ID: <50697F83.60500@eigenlab.org>
Date: Mon, 01 Oct 2012 13:33:23 +0200
From: Gioacchino Mazzurco <gio@eigenlab.org>
MIME-Version: 1.0
References: <50697D78.3040005@eigenlab.org>
 <20121001112853.GB2848@ritirata.org>
In-Reply-To: <20121001112853.GB2848@ritirata.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2D354E91B57377B28710F96F"
Subject: Re: [B.A.T.M.A.N.] reboot sometimes doesn't work well
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
To: Antonio Quartulli <ordex@autistici.org>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2D354E91B57377B28710F96F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On powering off kernel panicked reporting batman-adv tryng to access
some invalid pointer

Nor I remember exactly what was the solution but i remember you told me
that was about trying to doing something with an interface no longer exis=
ts

On 10/01/12 13:28, Antonio Quartulli wrote:
> Hello Gioacchino,
>=20
> can you first tell us what version (and possibly which external patches=
) you are
> using?
>=20
> Also, can you remember the symptoms of the previous problem? I don't re=
member
> very well what was happening...In this way everybody can understand wha=
t's
> going on.
>=20
> Cheers,
>=20
> On Mon, Oct 01, 2012 at 01:24:40PM +0200, Gioacchino Mazzurco wrote:
>> Hi all!
>>
>> Some times ago' in ninux Pisa we was experiencing kernel powering off
>> the machine caused by batman-adv, with ordex help we debugged what was=

>> happening and the issue was solved bat that was possible because it wa=
s
>> happening on x86 computers ( with screen )
>>
>> Now it SEEMS the same is happening but on mips ( Ubiquity M devices )
>> but here i don't know how to make sure the problem is this, the sympto=
ms
>> is exactly the same, someone have idea how to save the powering off
>> kernel output on some file so after detach/attach cable we can find wh=
at
>> happened ?
>=20


--------------enig2D354E91B57377B28710F96F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlBpf4YACgkQnwkeGL0UcCSLXgCeODeQ9poFZW+hWZARofx4Q0m1
6h8AniE3IwmUckR6AyabpKFhsYl0GDDe
=nu6I
-----END PGP SIGNATURE-----

--------------enig2D354E91B57377B28710F96F--
