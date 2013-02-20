Return-Path: <ordex@autistici.org>
Date: Wed, 20 Feb 2013 14:26:25 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130220132625.GL3523@ritirata.org>
References: <1361112184-9927-1-git-send-email-ordex@autistici.org>
 <20130218234904.GA24241@pandem0nium>
 <201302190908.44891.lindner_marek@yahoo.de>
 <20130219214340.GA29174@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cyV/sMl4KAhiehtf"
Content-Disposition: inline
In-Reply-To: <20130219214340.GA29174@pandem0nium>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: add compat support for the
 new netlink ops
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


--cyV/sMl4KAhiehtf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Simon,

>=20
> > ip link set dev $iface master bat0
>=20
> This doesn't work. eth0 is not added to batman. To further test, I've add=
ed
> it via batctl.

I'm not sure..but I think this does not work because the "set master" comma=
nd
does not use ioctl, but rtnl only. Since in this kernel we don't have rtnl =
for
these operations (this is why we have this hacky patch) I did not expect th=
is
command to work.

> >ip link set dev $iface nomaster
>=20
> has no effect

same as before.

> >=20
> > Even more interesting are combinations of those:
> > * batctl if add $iface && some OGMS here && ip link set dev $iface noma=
ster &&=20
> > ip link del dev bat0
> > * ip link add dev bat0 type batadv && ip link set dev $iface master bat=
0 &&=20
> > some OGMS here && batctl if del $iface
>=20
> Some of these combinations are tested above, but I'd suggest we should fi=
x the
> general case first. :)

what would you like to fix? :) We have just implemented a feature and now we
don't have any userspace tool which can exploit it! :-D

Simon, Thanks a lot for testing!

Cheers,


--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--cyV/sMl4KAhiehtf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRJM8BAAoJEADl0hg6qKeO99cQAIhLJ8WYt3zqkU5rkE7QqHua
kHKdrpu/wXe0wplKNYRCixIZq2+exkg/OxS5Dx7znJsiBzBUPI61Edzr55UIRvHc
BWmE4TWvvvnzUvBHrgPwYHexUDUG4ecIXG9wasOia/nwUqOlIJYSxMqhkqQgZH+b
DtgR6Xg72fepSJ3pDDcO+Hjhr7mZMuymD+GiN7SPIwkgJXMh5Kv+Zy+Avi8vgEwG
ySt2O7Od2yRaI77iE4hIBFsbBE/W4bahk6lvX1rORa8oTX8TNSn5axhMGp2pSIR5
M7PDnh4E4XSWbMD5Cj++z8SgHq4L18jm/TO28aCJ/fbQtTeb9vUOPL2Gdvmgg+tm
VsIArSTzKtmvhaHtn72avTNorrJVw4kvw+3i7hmrw0to/Uz76eJCJrbGf9tPGatg
KFpNhckLSrGE8G0RL1H3kBTNZg74KWiH7ZQm/vvQ3UKqDym+U++QxqGPhG0lPcLH
GZA+2AqrlQSzxotSjVtWSDCJEwPg0lz/OWzoSwMDsymz9P57bGZGAk23z2OWXYhA
i5/NEk4KyzEjZGnWzX/xtx74YjRsmkz2DI8R7fKF0Exw9odFCxmMT2LsS2clJ+eS
aNNBXIk27YV1nDrHQtrwkpqCwxOgFXBThmps6ADoiEKN1C20PXSwyDrHwu7zcqdI
+WGn6uCOJRy6MXTghFSZ
=10Iz
-----END PGP SIGNATURE-----

--cyV/sMl4KAhiehtf--
