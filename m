Return-Path: <antonio@meshcoding.com>
Date: Mon, 23 Sep 2013 10:20:46 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130923082045.GI3911@neomailbox.net>
References: <1379860946-32669-1-git-send-email-sven@narfation.org>
 <20130923070342.GF3911@neomailbox.net>
 <4148310.CdzoCJI8ee@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VaKJWhUROU/xPxjb"
Content-Disposition: inline
In-Reply-To: <4148310.CdzoCJI8ee@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/4] batctl: Add missing includes and
 remove unused includes
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


--VaKJWhUROU/xPxjb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2013 at 10:18:27AM +0200, Sven Eckelmann wrote:
> On Monday 23 September 2013 09:03:42 Antonio Quartulli wrote:
> > > -#include <stdio.h>
> > >=20
> > >  #include <stdint.h>
> > >=20
> > > +#include <stdio.h>
> >=20
> > why is it important to move stdio.h below stdint.h ? Is there a particu=
lar
> > reason for that?
>=20
> No, just an artifact of the work on the includes. But now it is an=20
> alphabetical order (at least these two items)... so it is extremely impor=
tant=20
> :D

lol, ok!

--=20
Antonio Quartulli

--VaKJWhUROU/xPxjb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSP/ndAAoJEADl0hg6qKeOELYP/RavXiB5ixxP4wPehu9m2+yz
p3OvsHeT6Z8io/5AYV+LKQZXaHJ9qnKB/xaxFnXmGzZWcWcbBXVAl3CYkQMFgXFQ
WoB2awMX8ylduF1kskm9Tq2UguME70Mbs+eqrHzxtKLQW3zeTUbsT0yXGfWvmjum
d+yjHto3r6jSXZfp8sWh7kTeuXuBUm3w6FTaTgUpEaoh1JegeMd5oE/gU8OsQqlL
1sFUu18Y0GLT4ArYLAdDWIkw8m4wTw7JDRBk2JfswJ4AVtItF6djdKGTES53tqvy
TlwTrqHmRC658073I6I3Bbgf0sjt8TP2LQ4UT08vBPkx9RTqhEPBCXqZ/msH5goe
ioJzG9BQufR5VwAVK30AlbhLzLHDEc6AMIe6TuNHBYGDimANU+FdhhsaFiYI1zcD
PliTboKVK/2Q5oFZisMkTXP4qBgYUv5sPfGpWaJVKy5ssGOasTbJUrzfPQycuBkW
/tVB4t3znWIjEmSnN81ZtUWE9U1MB4FtYHg3mxg4aYoTBO4rurjMrGrfvwfO0Dgx
OfT0oRiIiTCC1xwwSK+fhlCE3U1nhvXhvJ4nYw2TGmNwbxXyv5ubvJpeyzXXdMXi
S2+0WZSLiS1b3t0MEpoXduEeNZmYDpxXvhp1GBN1Nv1FGMe6HolJ9VUBPabG54lr
AzmO3ukoLuqDvGt6pAXo
=flK3
-----END PGP SIGNATURE-----

--VaKJWhUROU/xPxjb--
