Date: Sat, 14 Feb 2009 11:17:12 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20090214101712.GA26153@pandem0nium>
References: <238a15490902111906g23358005v35fd57d8df857154@mail.gmail.com>
	<20090212125347.GA4074@pandem0nium>
	<238a15490902120658h4edb144bvc17db63a5b4a6f0a@mail.gmail.com>
	<200902130029.48657.lindner_marek@yahoo.de>
	<238a15490902131258r3f44f405m75ce70b7fff09738@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <238a15490902131258r3f44f405m75ce70b7fff09738@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] Using batman L2 on multiple wireless cards
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Gargi,

the design of the main interface in BATMAN has the effect that only
OGM packets from the main interface are distritibuted over the whole
network. OGM packets from secondary interfaces are only sent with TTL=3D1,
that means the next neighbor will drop them.=20

The reason for this system is that the secondary interfaces need an unique=
=20
ID/MAC (not the same address as the main interface), because physically this
address must be used to send the frames. The "secondary neighbor" will want=
=20
to send only to the main interface, because this address is known=20
in the whole mesh. The "secondary neighbor" therefore needs to address
the "secondary interface" correctly, so he (and he alone) receives the=20
secondary OGMs. This allows the neighbor to build a route to the main=20
interface.=20
Flooding the secondary OGMs throughout the mesh would have been another
possible alternative, but thats redundandant, and we don't want to flood
too much.

Hope that makes it somewhat clear. ;)

The consequence is that by design you won't see the secondary interfaces
of the nodes if you're not physically connected (and in range) with
them.=20

> I am wondering why
>=20
> Node A: Cannot reach mac 23
> Node B: Cannot reach mac 23
> Node C: Cannot reach 20, 22
>=20

So i guess for your scenario 22 is As secondary interface, 20 is Bs
secondary interface, and 23 is Cs secondary interface.

You can verify that with your local setups: The first interface added is
the main interface, the following ones are the secondary interfaces.

best regards,
	Simon

On Fri, Feb 13, 2009 at 02:58:03PM -0600, Gargi Purohit wrote:
> > Yes, batman has the concept of "main interface" (the first given interf=
ace) to
> > reduce overhead but on the node that has 2 interfaces you should see bo=
th
> > interfaces in the originator table (on a more distant host this might be
> > different).
> > Could you post the important lines from originators and explain the
> > corresponding setup ?
>=20
> Ok...now I get that...However I think not always I am able to
> reproduce this scenario.  I have node A, node B, node C - each with 2
> radios
>=20
> --ch60---| A |---ch56---------ch56---| B |---ch40-------ch40---| C |---ch=
48
>       (1C)..........(22)...............(20)............(21)..............=
=2E..(1D).........(23)...
>=20
> The terminating mac addresses for the radios are shown in ( )
>=20
> My originator tables for node a, b, c are as follows:
> For Node A
> =3D=3D=3D=3D=3D=3D=3D
> root@OpenWrt:/# cat /proc/net/batman-adv/originators
>   Originator     (#/255)           Nexthop [outgoingIF]:   Potential next=
hops .
> 00:02:6f:52:80:20  (255) 00:02:6f:52:80:20 [      ath1]: 00:02:6f:52:80:2=
0 (255)
> 00:02:6f:52:80:1d  (177) 00:02:6f:52:80:20 [      ath1]: 00:02:6f:52:80:2=
0 (177)
> 00:02:6f:52:80:21  (255) 00:02:6f:52:80:20 [      ath1]: 00:02:6f:52:80:2=
0 (255)
>=20
> For Node B
> =3D=3D=3D=3D=3D=3D=3D
> root@OpenWrt:/# cat /proc/net/batman-adv/originators
>   Originator     (#/255)           Nexthop [outgoingIF]:   Potential next=
hops .
> 00:02:6f:52:80:22  (255) 00:02:6f:52:80:22 [      ath1]: 00:02:6f:52:80:2=
2 (255)
> 00:02:6f:52:80:1d  (250) 00:02:6f:52:80:1d [      ath0]: 00:02:6f:52:80:1=
d (250)
> 00:02:6f:52:80:1c  (255) 00:02:6f:52:80:22 [      ath1]: 00:02:6f:52:80:2=
2 (255)
>=20
> For Node C
> =3D=3D=3D=3D=3D=3D=3D
> root@OpenWrt:/# cat /proc/net/batman-adv/originators
>   Originator     (#/255)           Nexthop [outgoingIF]:   Potential next=
hops .
> 00:02:6f:52:80:1c  (241) 00:02:6f:52:80:21 [      ath0]: 00:02:6f:52:80:2=
1 (241)
> 00:02:6f:52:80:21  (255) 00:02:6f:52:80:21 [      ath0]: 00:02:6f:52:80:2=
1 (255)
>=20
> I am wondering why
>=20
> Node A: Cannot reach mac 23
> Node B: Cannot reach mac 23
> Node C: Cannot reach 20, 22
>=20
> Should they be able to reach out "each of the radios" on "a node" or
> "just one of the radios" on "the node". Sometimes they can and some
> times they dont seem to..
>=20
> For instance...
> I am not sure if it is more of a radio issue than software problem...
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>=20

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFJlpoorzg/fFk7axYRAh50AJ0UEA83G+syuJcv5C2KNyRO4vxt+ACgv1xJ
vSp21XqpRcD70uEc0vn/RcE=
=qi11
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
