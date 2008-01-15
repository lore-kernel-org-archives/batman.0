Date: Tue, 15 Jan 2008 15:25:36 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Basic question
Message-ID: <20080115142536.GA7314@hrz.tu-chemnitz.de>
References: <BLU134-W199EC580346187E750B911E1470@phx.gbl>
	<200801151243.27415.lindner_marek@yahoo.de>
	<BLU134-W258B642D8C3F7F4093850E1470@phx.gbl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <BLU134-W258B642D8C3F7F4093850E1470@phx.gbl>
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


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Carlo,

batman-adv-kernelland is currently not integrated in madwifi (this is
just another idea on our TODO list). You only need to compile the
batman-adv-kernelland/batman-core/ directory against your kernel.
This gives you the batman-adv-core.ko module which you can insmod and is
independent from madwifi (and any other driver).

Best Regards,
	Simon

On Tue, Jan 15, 2008 at 12:59:00PM +0000, Carlo Beccia wrote:
>=20
>=20
>=20
> Hi Marek,
> thank you for your quick reply....
>=20
> I would like to compile the module...I don't need the complete openwrt in=
tegration...
> I would like to see and study your (you all) work on kernel space.....
>=20
> At the moment I have already build a custom openwrt firmware....but from =
what I understand I need to patch the madwifi driver to support the new fea=
ture and recompile the driver....then I can build the batman module...
> I need only some hint on what steps to take in order to compile the modul=
e...I doesn't seem so difficult but i wanna follow the right steps...
>=20
> Obviously if I don't waste your time.....
>=20
> Regards, Carlo
>=20
> ----------------------------------------
> > From: lindner_marek@yahoo.de
> > To: b.a.t.m.a.n@open-mesh.net
> > Subject: Re: [B.A.T.M.A.N.] Basic question
> > Date: Tue, 15 Jan 2008 12:43:27 +0100
> >=20
> >=20
> > Hi,
> >=20
> > > How can I compile the stuff
> > > https://dev.open-mesh.net/svn/batman/trunk/batman-adv-kernelland/ into
> > > openwrt...I would like to try the layer 2 version on my fonera router=
=2E...
> >=20
> > currently I'm working on the batman openwrt integration. It is a bit tr=
icky=20
> > and I'm not 100% finished yet. It will be included in the latest kamika=
ze=20
> > trunk. Either you wait some more days or I send you my current status.
> >=20
> >=20
> > > I don't understand if I have to integrate it in a package inside the
> > > menuconfig or I can build everything off from the standard configurat=
ion...
> >=20
> > You can't use the standard configuration.
> >=20
> > Greetings,
> > Marek
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20
> _________________________________________________________________
> Ti piace giocare con le lettere? Prova ABCLive!
> http://messengergiochi.it.msn.com/
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHjMJgrzg/fFk7axYRAlauAKCIifCPOa5CnHYC0m5PdIyGKdJExACg6ZG4
9AjhdSHxkKjIuxYNiJ5UGho=
=gXdA
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
