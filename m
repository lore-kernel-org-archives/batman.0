Return-Path: <ordex@autistici.org>
Date: Thu, 12 Apr 2012 14:00:03 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120412120002.GE8528@ritirata.org>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q8BnQc91gJZX4vDc"
Content-Disposition: inline
In-Reply-To: <4F86B02B.9060900@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Jernej Kos <kostko@unimatrix-one.org>


--Q8BnQc91gJZX4vDc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2012 at 12:36:27PM +0200, Gioacchino Mazzurco wrote:
> Hao! Ma allora sei stronzo !!
>=20
> >As I
> > understand, we should be migrating the whole network at same time each
> > time a new version of Batman (or Linux kernel) is released, because
> > you do not keep things backwards compatible? How serious is this
> > limitation in practice?
>=20
> It happen just some times not every batman/kernel version change.
> We use batman-adv in Ninux Pisa and in Ninux Sicily and we managed have
> some compatibility break in updates without problem just start to update
> from the fairest node to the yours

Up to now we had the so called "COMPATIBILITY VERSION". All the nodes must =
use
the same compatibility version otherwise they will not be able to communica=
te to
each other. However the compatibility version is not increased in each and =
every
batman-adv release, but only when the packet format (or something really
crucial) is touched.

>=20
> > I am also a bit afraid of L2 meshing. How problematic are floods in
> > the network in practice? Like people broadcasting stuff and so on? Are
> > there any filters possible for this?
>=20
> II have tried to do something about filtering but without success, but
> we never encountered flooding problems nor in Pisa nor in Sicily
>=20

Actually it depends on what you want to filter. batman-adv itself doesn't
support filtering. But what you can do is using "ebtables" (bridge version =
of
iptables).

For example: If you are creating a bridge called br0 and enslaving bat0 and=
 ap0, you can use
ebtables to DROP all the broadcast packet that want to go out through bat0.=
 Int
his way you will limit the broadcast packets to the AP only.

By the way, I don't know if you really meant this kind of filtering.

> > We have a setup where nodes have WiFi connections and VPN links to
> > central server. We are thinking of migration OpenVPN to L2TP tunnels,
> > so on the central server there will be many tunnels dynamically
> > created as nodes connect and disconnect. Is Batman able to add
> > interfaces it operates during run-time? Probably we should not just
> > bridge all tunnels and run Batman on top of that? This would probably
> > hide that there are different links bellow from Batman? Or not? (For
> > example, on OLSR we should not do this, because then nodes would
> > discover each other over server as one hop/direct neighbors.)
>=20
> In batman-adv you can add/remove interfaces at runtime without problems
> so you doesn't need bridging or similar nasty things

exactly. You can add/remove interfaces at run-time. Creating a bridge with =
all
the tunnels would not be good because it would not make batman-adv exploit =
the
interface diversity.

Cheers,

>=20
> On 04/12/12 12:26, Mitar wrote:
> > Hi!
> >=20
> > I really liked your client roaming support presented at Battlemesh.
> > But I am still afraid to deploy Batman in the network. As I
> > understand, we should be migrating the whole network at same time each
> > time a new version of Batman (or Linux kernel) is released, because
> > you do not keep things backwards compatible? How serious is this
> > limitation in practice?
> >=20
> > I am also a bit afraid of L2 meshing. How problematic are floods in
> > the network in practice? Like people broadcasting stuff and so on? Are
> > there any filters possible for this?
> >=20
> > We have a setup where nodes have WiFi connections and VPN links to
> > central server. We are thinking of migration OpenVPN to L2TP tunnels,
> > so on the central server there will be many tunnels dynamically
> > created as nodes connect and disconnect. Is Batman able to add
> > interfaces it operates during run-time? Probably we should not just
> > bridge all tunnels and run Batman on top of that? This would probably
> > hide that there are different links bellow from Batman? Or not? (For
> > example, on OLSR we should not do this, because then nodes would
> > discover each other over server as one hop/direct neighbors.)
> >=20
> >=20
> > Mitar

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Q8BnQc91gJZX4vDc
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPhsPCAAoJEFMQTLzJFOZFQzsH+wTt2BdBbFtISMJfe1khHQMI
kAOJfz6OAmzfwyrSKrB03IYIiYFqMIef/a6o7LT+HURgqgd3ewcuL4rpae+Gd8RK
nL1PWLh0lY2GWASJJPYEeeufc0B28TnBwIQxVgUtF6uTkfxCNUV4nij4yeCwSgtC
NppJOGE+m1GEEUXS3GNmVaFSpTDI49A+67X0yXz0b1oOO/gDXIGcRX2JcdKs18CM
nLs3AgWfM/lkT0nrq8P0wVc9cVSieaJJQ87wF1zGCqNe0CkyMu5lkyrGQ93XzBB+
54WiaoPNVEx+wROXff4AGuUEqwnLN2Q51DzKWABosML3B56jG4fQVPt4NOX8ZyQ=
=UVNW
-----END PGP SIGNATURE-----

--Q8BnQc91gJZX4vDc--
