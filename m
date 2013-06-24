Return-Path: <ordex@autistici.org>
Date: Mon, 24 Jun 2013 09:02:45 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130624070245.GI1124@ritirata.org>
References: <51C76DDE.20903@altermundi.net> <51C77678.1040904@altermundi.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VbfcI4OLZ4XW0yH2"
Content-Disposition: inline
In-Reply-To: <51C77678.1040904@altermundi.net>
Subject: Re: [B.A.T.M.A.N.] Possible bad interaction between BLA2 and TT?
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


--VbfcI4OLZ4XW0yH2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2013 at 07:28:08PM -0300, Gui Iribarren wrote:
> On 06/23/2013 06:51 PM, Gui Iribarren wrote:
> >
> > the "gap" in labanda-oeste is between seq=3D73 and seq=3D89
> > in labanda-oeste there were no messages or traffic for 25secs, and then
> > the "TT inconsistency" came up, resolved, and seq=3D89 succeded, traffic
> > restored.
> > at that time, seq=3D74, labanda-este got a TT update:
> > [  23161800] Deleting tdorado from global tt entry 44:d8:84:b0:d2:f5: tt
> > removed by changes
> > and (AFAIU) dropped traffic coming from labanda-oeste until
> > labanda-oeste finally got the TT update and increased the ttvn to 129

As we clarified on IRC, BLA2 is not involved at all.
=46rom what I can see I'd say that a node in the middle is dropping the tra=
ffic
due to a wrong re-routing operation. if you could reproduce the issue, it w=
ould
be nice if you could get the tt log on all the nodes along the path.
In this way we can clearly see who is doing what.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--VbfcI4OLZ4XW0yH2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRx+8VAAoJEADl0hg6qKeOQ5YP/j5Hk5VkN3vf+Y1TpU1Onzwf
BlSn0IFOG+fjxLVs17w4eOtq4FmPDcmqlQzhPlu4WQPZv0PMy1UhwCKaiMet8j3D
yqa5xf9aK7ciCcv10zbFSiK2y3E5yvDuIn7VuS7xRPSZO7iQbCBJfGnmveETUbhE
TDFqRdkdRVYhAtekUj3izN1HFLjczsQs34Caq+hZ0gn+Lp+Qo4MB9PSCJpiBs0jM
PHVSqHPWOmVvvY2Cv0hgPvBzdYswtcgIhJWczp6ru1Oxx5cdNB7lh9/CxaXhSM6B
6c3oPFthRwYZsk/Bl4UPl+wekt2BUgKwHEh+P1V+wZcW00hzOZISvdZ8Xo9GzShK
g0MU+hpeP6F/8X4EaLkRO5ExaqIFut2En5P9WxB6+SQz6dhwbTCK1YG3R4bHrxLP
k4p13gH4bD8/Zj3SAEM6vZChyk/lZ2wLWkoQ//w6xKV+reI+ZbvdGDGFOj7DRU/G
0gTHTpvuZwEL1UJmgpQNbeqlPU9qclx0zfpkj8kpqaPyl0Mz5GcypyDqjycijMIJ
snKjeqlALgap4fxMLbFVe5EeDpgXBQt0OJjcT/MTGJvJoReFvyPk3QRo+z8flzZE
zhbAL4FThNDR6a6HzEM3tWyzWl09wiOLO6C4CYVBQD/GcYw21xpqPUVTj32Qgir+
nYNQLTYHkQLt3umOfsAT
=fmkw
-----END PGP SIGNATURE-----

--VbfcI4OLZ4XW0yH2--
