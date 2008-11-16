Date: Sun, 16 Nov 2008 17:48:31 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv debian announcement
Message-ID: <20081116164831.GA21213@pandem0nium>
References: <200811170004.23285.lindner_marek@yahoo.de>
	<5635aa0d0811160806h69169967w846a18250d77b87c@mail.gmail.com>
	<200811170026.10020.lindner_marek@yahoo.de>
	<5635aa0d0811160830r5521a8a4he0d5b22665664d7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <5635aa0d0811160830r5521a8a4he0d5b22665664d7@mail.gmail.com>
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


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

yep, bmxd/batman0.3 and batman-adv are both not compatible to each
other.=20

You should know that batman-adv does not have special gateway support
like the layer 3 batman versions. It can be considered as a big switch
where every node is one virtual hop away. You can therefore configure it
like your home LAN: install DHCP on your router, and that's it. If you
have multiple gateways, you might consider multiple DHCP servers, or=20
something else ... depending on your scenario. :)

regards,
	Simon

On Sun, Nov 16, 2008 at 11:30:06PM +0700, Outback Dingo wrote:
> ok lastly, it seems possible its very similiar config to bmxd which is wh=
at
> has been running, though layer 3, im trying to get layer 2 kernel routing
> going
> originally i used batgat but yet it was problematic, so its safe to say i
> could go batman-adv and drop bmxd? as i belive one is not compatible with
> the
> other in the mesh
>=20
> On Sun, Nov 16, 2008 at 11:26 PM, Marek Lindner <lindner_marek@yahoo.de>w=
rote:
>=20
> > On Monday 17 November 2008 00:06:37 Outback Dingo wrote:
> > > any good docs on configuring batman-adv for atheros ?
> >
> > We are writing it but it takes time.  :-)
> >
> >
> > Here the short intro:
> >
> > Batman advanced is not aware of the Atheros driver. On every hardware it
> > runs
> > in the same way.
> >
> > Load the module -> modprobe batman-adv-core
> >
> > In /proc/net/batman-adv/ you will find the files to tweak batman. E.g. =
give
> > it a
> > device to operate on -> echo eth0 > /proc/net/batman-adv/interface
> >
> > deactivate batman-adv -> echo "" > /proc/net/batman-adv/interface
> >
> > The other files in that folder should be self explanatory. If not come =
back
> > and
> > ask us.
> >
> > Regards,
> > Marek
> >
> > _______________________________________________
> > B.A.T.M.A.N mailing list
> > B.A.T.M.A.N@open-mesh.net
> > https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
> >

> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJIE7frzg/fFk7axYRAktRAKCzaSwTl0oiLU35x0tF2uL/vSaUXQCfQEE5
QYgzMfMUlxTDg+4NyaxCiH0=
=pH29
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
