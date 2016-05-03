Return-Path: <antonio.quartulli@open-mesh.com>
Date: Tue, 3 May 2016 20:21:31 +0800
From: Antonio Quartulli <antonio.quartulli@open-mesh.com>
Message-ID: <20160503122131.GC11201@prodigo.lan>
References: <1459508076-29674-1-git-send-email-sven@open-mesh.com>
 <1459508076-29674-3-git-send-email-sven@open-mesh.com>
 <20160502172828.GZ11201@prodigo.lan> <17410440.33Me94yB3F@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VcZjVMblxkg0/8Ur"
Content-Disposition: inline
In-Reply-To: <17410440.33Me94yB3F@bentobox>
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 3/3] batman-adv: throughput meter
 implementation
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--VcZjVMblxkg0/8Ur
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 03, 2016 at 10:18:50AM +0200, Sven Eckelmann wrote:
> On Tuesday 03 May 2016 01:28:28 Antonio Quartulli wrote:
> [...]
> > shouldn't we propagate the value saved in err to tp_vars->reason ?
> >=20
> > We found this error while using the tp_meter, because we tried to run it
> > against a non-existing originator and batctl crashed.
>=20
> Yes, looks like I've missed this while reviewing your tp_meter code. Was
> the crash something like:
>=20
>     root@node02:~# /host/batctl/batctl  tp 02:ba:de:af:ff:01
>     Throughput meter called towards 02:ba:de:af:ff:01
>     tp_meter.c:198:36: runtime error: division by zero
>     traps: batctl[246] trap divide error ip:410f31 sp:7ffea78512c0 error:=
0 in batctl[400000+18000]
>     Floating point exception

exactly the same.


>=20
> I will most likely add code catching it in both batctl and batman-adv.


Thanks !

Cheers,


--=20
Antonio Quartulli
Director of Embedded Software | Open Mesh, Inc.

--VcZjVMblxkg0/8Ur
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXKJfLAAoJEJ4aZjxxc6bKndUP/1Nf9n9b3YZQzKCJ118UJhHS
Bzv6Bv4w200GlBkAfoGLLs4znChundkvCWpsKiNn5d3dTUmxPoIzYjKEgbcZgdPs
oCqZMa9nrBuSgGCN94umz+Y2AmxOB4ioZ3PGwuIJgXYtDGlO6pmfij5SdYID9J6H
QAVHyQRjzTTQbpJeilRM6gbbr5wHM9//z9gf41B09zsUdH36essTYrH3C/i4/9gA
IdSqzhR5LJ7fV9e9Kefe8jBDEe32klwbwQWSawL2Cmte0awv1UcWgIzz/jEPRJ7b
JUY02Cee0o+NmeGrXkRKIdlbszJBjOVsRY+MmSXjKvLkquzCvPat8ZM/nHOotNwk
U2OGppkl1Grj5lk3UEdA2OZCwnQjTc4tOY2U5pQQqzWqvnbdGvRHBtQQSsDAM0Gp
eOz/kogRlRHjlWbWawBNlZTav2khdGF6t5gIqYI+qOqSKricSiCyMkIsbQNRsLaf
GdxPYnna20iYG5cMB+GFP0oPBO1jUjNDq6arOc5qKtgvlom5T+eifgddi0xClKMX
/iWNiEJHA7WbHbFaxqMiDSfeGxYb5wZilJizgbVjQka6bs4LkXfGZEm19Db1kJ8b
4l+AEl43TqDcnvNW1Kgi+hXh+gu/jWtlDCo23llipxKHbSAzFSEbfnlaFQQxFa2e
zOQxtobM/56qDchg3aFE
=IhAu
-----END PGP SIGNATURE-----

--VcZjVMblxkg0/8Ur--
