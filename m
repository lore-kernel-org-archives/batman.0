From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 16 Mar 2009 23:54:21 +0100
References: <49B825BE.4040605@java-system.com>
In-Reply-To: <49B825BE.4040605@java-system.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1487203.shhQ6zVFyQ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200903162354.22455.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Unable to connect to internet
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>, marco tozzini <lists@java-system.com>

--nextPart1487203.shhQ6zVFyQ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 11 March 2009 21:57:34 marco tozzini wrote:
[...]
> As you can see from node 200 I can ping node 203 (wireless interface
> 192.168.2.203 and wired interface 192.168.0.203), but I'm unable to go
> through adsl modem (192.168.0.1)
> But I can connect to adsl modem from node 203
Solution was found today on irc. Marco hadn't setup a NAT on the gateway no=
de=20
as described in paragraph 4.2 " Why I can=E2=80=99t connect to the Internet=
 after=20
setting the default gateway?" in
 http://downloads.open-mesh.net/batman/misc/batmand_howto.pdf

A different solution was suggested by Simon to set the route to 192.168.2.x=
=20
nodes on 192.168.0.x nodes over the gateway node. This way the 192.168.0.x =
can=20
send answer packets to 192.168.2.x when it receives packets from 192.168.2.=
x=20
nodes without a NAT between the networks. 192.168.2.x could send to=20
192.168.0.x because the batman gateway node announced it to batman gateway=
=20
clients, but packets in the other direction never found their way because t=
he=20
batman gateway doesn't announce a backward route to the 192.168.2.x nodes=20
outside the mesh. This wasn't due to a fault of batmand, but a=20
misunderstanding what the -a option does and what batmand cannot do (set=20
routing informations on nodes outside the mesh).

Regards,
	Sven

--nextPart1487203.shhQ6zVFyQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkm+2J4ACgkQqQGwKVlMoDviyACg6J7TWxfa75NOkktiFiXETacn
hcwAoIYyMPo2NnGY+Q+9/Krc5wp72TwU
=cZ+H
-----END PGP SIGNATURE-----

--nextPart1487203.shhQ6zVFyQ--
