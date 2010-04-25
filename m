Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Mon, 26 Apr 2010 00:01:10 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100425220110.GA6186@pandem0nium>
References: <201004252136.25395.adebex@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <201004252136.25395.adebex@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Security & node authentication in BATMAN network
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


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Adrian,

quite good answers have already been on the list. Maybe it is helpful to
create VLANs for your purpose on top of the mesh, e.g.:
 1. An open patient/customer VLAN for internet traffic etc
 2. a hospital internal VLAN for your sensitive information
 3. an administration VLAN for maintainance on your nodes

These VLANs should be configured ontop of the meshnodes and should be=20
controlled by the nodes, means that the patients should not be able to=20
access the internal VLAN.=20

Additionally, you should secure the mesh with WPA-NONE, but as
stated before the security of this method is not well researched and=20
might be weaker than WPA2/CCMP. It basically use static keys with either
TKIP or CCMP(AES).

best regards,
	Simon

On Sun, Apr 25, 2010 at 09:36:25PM +0200, Adrian Byszuk wrote:
> Hello,
>=20
> I'm currently working on project (part of my Bachelor work) which will us=
e to=20
> transfer very sensitive data over the network, and I'd like to use mesh=
=20
> networks to transfer this data. Additionally, it should also be possible =
for=20
> "normal people" to connect to this network (e.g. to surf internet).=20
> Preliminary, I've chosen BATMAN to build this network. But I've got a few=
=20
> questions regarding security of this solution:
>=20
> 1. Does BATMAN provide any method of *authenticating* nodes?
> As I've said earlier, sometimes transferred data will be highly sensitive=
 (for=20
> example: information of patients health in hospital), so it's absolutely=
=20
> critical to not allow leaking this information. I can imagine situation w=
hen=20
> some fake nodes claim "Hey, I'm the server collecting this data"...
> I think this is also important when someone would try to destroy our mesh=
=20
> network by placing some fake nodes in it.
> 2. If point nr one isn't possible, maybe there is some other way to ensur=
e=20
> security? I don't know too much about security or cryptography, but I can=
=20
> think of solutions such as openVPN or IPsec.
>=20
> Generally, the goal is to assert security of transmitting some data *with=
out*=20
> losing open characteristics of mesh network.
>=20
> I will very thankful for any answers.
>=20
> Kind regards,
> Adrian
>=20

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkvUu6YACgkQrzg/fFk7axbhGACeM5DErbuCa21sAACpdLlIHttu
v+wAoMwv2BexlP6Ap0Yp84NZd91Wz5N1
=r4cV
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
