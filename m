Date: Sat, 2 Aug 2008 17:14:12 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv-kernelland: Possible kernel deadlock?
Message-ID: <20080802151412.GA32217@pandem0nium>
References: <E9DE65F5-50B7-494C-8C69-E0A028F2AF0B@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <E9DE65F5-50B7-494C-8C69-E0A028F2AF0B@gmail.com>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Scott,

please have a look into rev 1104, this should fix some synchronisation
problems. At least the problem i could reproduce when unloading is gone
now. Please tell me if this solves your problem, too. :)

regards,
	Simon

On Fri, Jul 25, 2008 at 03:14:44PM +1200, Scott Raynel wrote:
> Hi all,
>=20
> I'm running batman-adv-kernelland r1102 on linux-2.6.21.5. I've found =20
> I can fairly reliably deadlock the kernel by disabling and re-enabling =
=20
> batman a few times, e.g.
>=20
> $ echo ath0 > /proc/net/batman-adv/interfaces
> wait a while...
> $ echo > /proc/net/batman-adv/interfaces
> wait a while and repeat.
>=20
> It appears that this is deadlocking the kernel somehow, as syscalls =20
> never return, e.g. 'ps' prints the header and then freezes.
>=20
> Our interface configuration system brings interfaces up and down on re-=
=20
> configure, so we'd like the batman interface to be able to withstand =20
> this use case. I will try to start looking through the code, but I =20
> thought I'd throw the problem out there to see what others more =20
> experienced with it think.
>=20
> Thanks all,
>=20
> --
> Scott Raynel
> WAND Network Research Group
> Department of Computer Science
> University of Waikato
> New Zealand
>=20
>=20
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--Kj7319i9nmIyA2yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIlHnErzg/fFk7axYRAqPCAJ9AaBK8VIaf/ZsyeODz56ww0VmGwACgqMhY
KZeLeim4GqnzMx2H0ke2nNQ=
=XVVi
-----END PGP SIGNATURE-----

--Kj7319i9nmIyA2yE--
