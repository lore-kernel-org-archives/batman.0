Date: Tue, 25 Sep 2007 11:20:12 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] MAC and OLSR
Message-ID: <20070925092012.GA31929@hrz.tu-chemnitz.de>
References: <46F31E2A.9040801@toyota-ti.ac.jp>
	<20070921094015.GA12211@hrz.tu-chemnitz.de>
	<46F84B93.2080702@toyota-ti.ac.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <46F84B93.2080702@toyota-ti.ac.jp>
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


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently you should use the batman-saxnet branch for batman-advanced, it
features bridging and some other fixes which are not merged back yet.
Use subversion to check out:

svn co https://dev.open-mesh.net/svn/batman/batman-saxnet/

Regards
	Simon


On Tue, Sep 25, 2007 at 08:43:15AM +0900, giuseppe de marco wrote:
> Simon Wunderlich wrote:
> >Hello,=20
> >
> >maybe you already noticed, but we implemented batman on layer 2,=20
> >called batman-advanced. It uses MAC-addresses as identifies, sends
> >protocol information and payload in own ethernet frames and does the=20
> >whole switching/routing part on its own. Maybe you want to have a look.
> >:)
> >
> >For your question, i don't know but a guess would be to look in the
> >wireless-tools accesible information and the driver itself.
> >
> >Regards
> >	Simon
> >
> >
> >On Fri, Sep 21, 2007 at 10:28:10AM +0900, giuseppe de marco wrote:
> > =20
> >>I agree that OLSR and also BATMAN should be moved to link layer.
> >>Anyway, now I am trying to do some experiment with OLSR and BATMAN, but
> >>by using also the information of MAC layer.
> >>I am using linux and ieee80211. Does anybody know how to read the mac=
=20
> >>parameters, such as
> >>lost frames, number of retransmission and so on?
> >>Regards
> >>
> >>--=20
> >>Giuseppe De Marco, PhD
> >>Toyota Technological Institute
> >>468-8511 Aichi 2-12-1 Hisakata, Tenpaku-ku,=20
> >>Nagoya, Japan
> >>Email: demarco at toyota-ti dot ac dot jp
> >>Tel (int): +81 (052)-809-1802
> >>Skype-Id: giuseppe_dem2
> >>
> >>_______________________________________________
> >>B.A.T.M.A.N mailing list
> >>B.A.T.M.A.N@open-mesh.net
> >>https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >>   =20
> >>------------------------------------------------------------------------
> >>
> >>_______________________________________________
> >>B.A.T.M.A.N mailing list
> >>B.A.T.M.A.N@open-mesh.net
> >>https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >>   =20
> Where I can download the code from?
> G
>=20
>=20
> --=20
> Giuseppe De Marco, PhD
> Toyota Technological Institute
> 468-8511 Aichi 2-12-1 Hisakata, Tenpaku-ku,=20
> Nagoya, Japan
> Email: demarco at toyota-ti dot ac dot jp
> Tel (int): +81 (052)-809-1802
> Skype-Id: giuseppe_dem2
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG+NLMrzg/fFk7axYRAuTGAJ42OJ1t4gyC10p1PEK4fyIbagTkiQCeK2S5
CpzcAVaL96odtrR5bEieM04=
=blo/
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
