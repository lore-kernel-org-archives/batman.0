Date: Tue, 4 Dec 2007 07:00:04 -0600
From: Jan Hetges <tran@ms20.net>
Subject: Re: [B.A.T.M.A.N.] two-way-tunnel quirks
Message-ID: <20071204130004.GA3907@apoderado.ometepe.net>
References: <20071130232852.GC3934@apoderado.ometepe.net>
	<200712021954.24310.axel@open-mesh.net>
	<20071204040309.GA3827@apoderado.ometepe.net>
	<200712041005.46329.axel@open-mesh.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
In-Reply-To: <200712041005.46329.axel@open-mesh.net>
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


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2007 at 10:05:46AM +0100, Axel Neumann wrote:
> Hi,
>=20
> On Dienstag 04 Dezember 2007, Jan Hetges wrote:
> > Hi Axel
> >
> > On Sun, Dec 02, 2007 at 07:54:24PM +0100, Axel Neumann wrote:
> > > ...
> > >
> > > > > - Can you describe it in way that i can reproduce it ?
> > > >
> > > >   A---B---C
> > > >
> > > > A: your computer
> > > >
> > > > B: bmxd_rv804  client node      }
> > > >                                  }running 2-way-tunnel
> > > > C: bmxd_rv804    gw node        }
> > >
> > > I am just curious, can you confirm if the following correctly
> > > describes the HNA/SNAT of your setup:
> > >
> > > for the two-way-tunnel setup:
> > >  - you were doing SNAT at Cs' upstream interface AND at Bs' bat0
> > > interface
> >
> > MASQUERADE
> >
> > > for the one-way tunnel setup:
> > >  - you are only doing SNAT at Cs' upstream interface
> >
> > no, i still do MASQUERADE also on Bs' bat0, because i was too lazy to
> > comment it out ;-)
>=20
> Interesting to know that this is possible, because (as I understand):
>=20
> - Internet Uplink packets are MASQUERADEd (*) when being entunnelled at B=
s'=20
> bat0 interface and a second time at your upstream GW interface
>=20
>  A          B                C     =20
> eth0    eth0 bat0        bat0 dsl0   Internet
>  >---------->*=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>*--------->
>         MASQUERADE       MASQUERADE
>=20
>=20
> - Downlink packets are de-MASQUERADED (*) at Cs' upstream interface (dsl0=
).
> But using one-way-tunnel, the Downlink packets are NOT routed via the=20
> bat-tunnel, therefore downlick packets will not come out of Bs' bat0=20
> interface and (I thought) would not be de-MASQERADEd (?) !
>=20
>  A          B                C     =20
> eth0    eth0 wlan0      wlan0 dsl0   Internet
>  <----------<?---------------<*---------<
>        de-MASQUERDE?   de-MASQUERADE=20
>=20
>=20
> catched my draft ? Please correct me if I misunderstood!

completley correct, the thing is, if i understand right, the good old
one-way-tunnel doesn't do anything with virtual IPs, but just uses
the real IPs so it doesn't matter.

cheers

  --Jan


--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHVU9UlTtvZdk47D4RAsoPAJkBw/FbaGONvHYOKuC2/jRRw6r3nwCfYmxV
OnDPGt7tIIJPRCt36gl0DYE=
=nUYU
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
