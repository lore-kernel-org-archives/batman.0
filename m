Date: Mon, 3 Dec 2007 22:03:09 -0600
From: Jan Hetges <tran@ms20.net>
Subject: Re: [B.A.T.M.A.N.] two-way-tunnel quirks
Message-ID: <20071204040309.GA3827@apoderado.ometepe.net>
References: <20071130232852.GC3934@apoderado.ometepe.net>
	<200712011834.54327.lindner_marek@yahoo.de>
	<20071202043216.GB3923@apoderado.ometepe.net>
	<200712021954.24310.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <200712021954.24310.axel@open-mesh.net>
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


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Axel
On Sun, Dec 02, 2007 at 07:54:24PM +0100, Axel Neumann wrote:
> ...
> >
> > > - Can you describe it in way that i can reproduce it ?
> >
> >   A---B---C
> >
> > A: your computer
> >
> > B: bmxd_rv804  client node      }
> >                                  }running 2-way-tunnel
> > C: bmxd_rv804    gw node        }
>=20
> I am just curious, can you confirm if the following correctly=20
> describes the HNA/SNAT of your setup:
>=20
> for the two-way-tunnel setup:
>  - you were doing SNAT at Cs' upstream interface AND at Bs' bat0 interfac=
e=20
MASQUERADE=20
>=20
> for the one-way tunnel setup:
>  - you are only doing SNAT at Cs' upstream interface
no, i still do MASQUERADE also on Bs' bat0, because i was too lazy to
comment it out ;-)
>  - and additionally an HNA announcement by B for the address used by A
yes, but also with 2-way-tunnel (because i want net internal routing)

cheers

  --Jan


--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHVNF8lTtvZdk47D4RAm5QAKC45gLoAk/ZYIZhJdce7Ga2QTgJpACggKdT
b5+h3pfT6LFz5fCNUq4Y6Oc=
=cYLv
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
