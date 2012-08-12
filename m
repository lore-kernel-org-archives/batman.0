Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 12 Aug 2012 18:30:09 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120812163009.GB1919@pandem0nium>
References: <BB2F02D2-9B93-465E-BB7D-FA13492511BF@gmail.com>
 <2670997.NDZah7qDiQ@bentobox>
 <B6EC8CB5-DDE0-4708-B89E-FADE58F33026@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Content-Disposition: inline
In-Reply-To: <B6EC8CB5-DDE0-4708-B89E-FADE58F33026@gmail.com>
Subject: Re: [B.A.T.M.A.N.] Batman-adv and routed subnets
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Luca,

On Fri, Aug 03, 2012 at 11:40:43AM +0200, Luca Pretto wrote:
> Thanks for your answer Sven.
>=20
> So, I've obviously misunderstood the part "mixing non-B.A.T.M.A.N. system=
s with batman-adv" [&]
> I admit: the fact that batman-adv operates al L2 really confuses me a lot!
> I'm a DIY nerd with no background training, so it's quite difficult to me=
=2E. But I won't give up! ;D
>=20

Sven explained it already ... just think of batman-adv as a big, distribute=
d switch with some nice
extras. ;)

> So, do you think that I should try to setup OSPF on every node, to keep t=
he thing as-much-auto-scaling-as-possible?

=66rom your description, you want to have some smaller subnets, and use bat=
man-adv for the backbone
to interconnect them. That's a fine approach, and you can use any routing t=
echnology on top (quagga with
OSPF/BGP, olsr, babel, ...) to announce the networks. Whatever seems most s=
uitable for you. :)

>=20
> But in that case I suspect I won't be able to use the "Gateway support" f=
unctions. Is it correct? [%]

The gateway support is just for sending DHCP packets to the "best" gateway,=
 and this gateway
is selected by batman-adv. But this won't work for you, because the users w=
ill get the DHCP leases
=66rom their local DHCP server responsible for the network. So this feature=
 won't help you as long
as you are subnetting.

The idea of the gateway feature is that you have multiple DHCP servers whic=
h are serving
as router for their respective internet connection, e.g.:

 * router A serves subnet 10.9.1.0/24
 * router B serves subnet 10.9.2.0/24
 * router C serves subnet 10.9.3.0/24
 * some more routers don't act as a DHCP server as they don't have an Inter=
net uplink

Then, you'd just bridge all APs so that users DHCP requests will end up in =
the mesh at one of the
DHCP servers - and the gateway feature will make sure that it's the DHCP se=
rver with the best
connection quality. ;)

OTOH, subnetting has it's plus side as well if you want to seperate the APs=
 somehow or limit
the broadcast scope. Also on very large networks I'd recommend to use subne=
ts or smaller mesh
islands.

Cheers,
	Simon

>=20
> Have a nice day,
> Luca
>=20
> [&] http://www.open-mesh.org/projects/batman-adv/wiki/Quick-start-guide
> [%] http://www.open-mesh.org/projects/batman-adv/wiki/Gateways
>=20
> Il giorno 03/ago/2012, alle ore 11:22, Sven Eckelmann ha scritto:
>=20
> > First thing: batman-adv doesn't route (as in l3 routing). batman-adv cr=
eates a=20
> > distributed switch on l2 (so, batman-adv does path finding). Therefore,=
=20
> > batman-adv doesn't care about the l3 stuff.
> >=20
> > And the stuff you've mentioned above is l3 stuff. So out of scope for b=
atman-
> > adv. Either you create static routes, use proxy arp or use another soft=
ware=20
> > that distributes the l3 routes.
> >=20
> > Kind regards,
> > 	Sven
>=20
>=20

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlAn2hEACgkQrzg/fFk7axbc6ACfWB26QbjKqf4msP0xhfiDxFBC
dLYAn30CSB7/v67UR/C9w9tQx9ZknZHl
=8q4u
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
