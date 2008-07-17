Date: Fri, 18 Jul 2008 01:36:21 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] Batman 0.3 + Freifunk setup questions
Message-ID: <20080717233621.GA10978@hrz.tu-chemnitz.de>
References: <487F60E5.5000003@reglue.org> <487F77DF.8050305@reglue.org>
	<487F9142.9000704@reglue.org> <487FA7DD.7080607@reglue.org>
	<20080717220707.GA9314@hrz.tu-chemnitz.de>
	<487FC8BB.6010707@reglue.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <487FC8BB.6010707@reglue.org>
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


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Don,

Debug Level 2 will list the available gateways. There is no need to
restart BATMAN, it will notice the new gateway available gateways=20
automatically (the gateways are announced with the BATMAN-packets). One
of the gateways will be selected depending on the configuration at -r.=20

You might want to read the howto [1] for further information. :)
Please ask again if your question is not answered there.

regards,
	Simon

[1] http://open-mesh.net/batman/doc/batmand_howto.pdf

On Thu, Jul 17, 2008 at 05:33:31PM -0500, Don Davis wrote:
> Simon Wunderlich wrote:
> >On Thu, Jul 17, 2008 at 03:13:17PM -0500, Don Davis wrote:
> >>batmand -g 5mb eth1 vlan1 #for gw?
> >Hello Don,
> >
> >try "-g 5mbit" instead of "-g 5mb". Seems this wrong option is silently
> >ignored ...
> >
> >best regards,
> >	Simon
> >
> Thank you.  That did do the trick.
>=20
> Is the gateway detection for announced gateways?
> Is there a script that can probe to see if the router is a gateway and=20
> if so make it available?
>=20
> I was under the mistaken impression that because I hadn't configured=20
> olsr (nor had I disabled it) that I was not running OLSR.  Thanks to=20
> Sven Ola it seems that it was a zero conf olsr.  Without specifying=20
> ifconfig eth1:bat 10.0.5.* the batmand eth1  command seemed to work (the=
=20
> same for batmand -g 5mbit eth1 vlan1) and batmand -c -d 1/2/3/4 show=20
> batman running.
>=20
>=20
> Is it normal that I have to kill and restart batman for the new gateway=
=20
> to be noticed?
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIf9d1rzg/fFk7axYRAqEUAKCm72E2TT0Yk1NaXd0PZILpzcCJDQCg1AGF
tBtN0xBbSeUqKoNOAj5F2zQ=
=CiUd
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
