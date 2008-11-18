Date: Tue, 18 Nov 2008 01:06:36 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Subject: Re: [B.A.T.M.A.N.] MASQUERADING on the gate0 NIC
Message-ID: <20081118000636.GA11646@pandem0nium>
References: <56963.149.5.32.200.1226966194.squirrel@www.rivertowermail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <56963.149.5.32.200.1226966194.squirrel@www.rivertowermail.com>
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


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Derek,

BATMAN will only open one gate0, so this should be fine. The tunnel is
always pointing to the currently selected gateway. Make sure that
you add something like "--source 192.168.100.0/24" to your iptables
line, otherwise other packets might make into in your NAT which you
don't want there (e.g. from wifi interfaces). Only the packets from=20
your local ([V]AP?) network should be there.

regards,
	Simon


On Mon, Nov 17, 2008 at 11:56:34PM -0000, Derek C wrote:
> Hi again,
>=20
> I'm currently testing with a few openwrt boards - generally its going well
> and I'm connected to the Internet via a BATMAN node thats talking to a
> gateway node - pretty good stuff.
>=20
> I've noticed something.  On my (non gateway) node the traffic is going out
> the "gate0" tunnel NIC.  My notebook is connected wirelessly to an [V]AP
> on the node so I need to have a MASQUERADE rule on the gate0 NIC to allow
> my local AP subnet (192.168.100.0/24) Internet access.
>=20
> In a live network, with lots of nodes, will there still only ever be one
> gateX NIC ? - is it enough to just have an "iptables -t nat -A POSTROUTING
> -o gate0 -j MASQUERADE" rule ?
>=20
> thanks very much for all the help
>=20
> Derek
>=20
>=20
> --=20
> Derek C
>=20
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJIgcMrzg/fFk7axYRAsdzAKDvZgZpL0ioFIkKpwvbxy/0ysNiFQCgof+u
lkizDVg4hNAqdz1lZH1r7E8=
=t/gP
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
