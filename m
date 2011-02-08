Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Wed, 9 Feb 2011 00:37:49 +0100
References: <201101282346.16035.clemens-john@gmx.de>
	<201102041638.54751.clemens-john@gmx.de>
	<4D4F1E31.4040200@kevinsteen.net>
In-Reply-To: <4D4F1E31.4040200@kevinsteen.net>
MIME-Version: 1.0
Message-Id: <201102090037.53981.clemens-john@gmx.de>
Content-Type: multipart/signed; boundary="nextPart6361837.CHHXAfLiSY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Connecting through Batman advanced interface
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

--nextPart6361837.CHHXAfLiSY
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Am Sonntag 06 Februar 2011, 23:18:25 schrieben Sie:
> On 04/02/11 15:38, Clemens John wrote:
> > Am Dienstag 01 Februar 2011, 11:51:16 schrieben Sie:
> >> If your non-batman clients don't need incoming connections, you could
> >>=20
> >> NAT outgoing connections :
> >>     [client]-->[adhoc ath1]-->NAT-->[br-mesh]
> >>=20
> >> You would have to run a DHCP server on the ath1 interface to give those
> >> clients a private IP and tell them to use the private IP on ath1 as
> >> their router.
> >=20
> > What do I have do insert into iptables to NAT ath1 to br-mesh? I=B4m a
> > complete firewall noob.
>=20
> There might be an easier way using the config files of the distribution
> you're using, but from a script it would look something like this:
>=20
> #! /bin/sh
> modprobe iptable_nat
> ## Work-around for bad ISPs which drop ICMP Fragmentation Needed
> packets: (Needs to be early in list)
> iptables -A FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS
> --clamp-mss-to-pmtu
> iptables -t nat -A POSTROUTING -o br-mesh -j MASQUERADE
>=20
> -Kevin

Thank you that got me a little bit further.
But now the traffic from the wlan client (wlan0) gets into the router (br-m=
esh)=20
and tries to reach the internet over the default route of the router, my lo=
cal=20
lan port. But I want to Use a special gateway (10.18.0.1) behind the vpn an=
d=20
in the same network as br-mesh, only for traffic comming from the clients. =
Traffic=20
comming from the router itself should use the default gateway furthermore.

What can I do?

Regards
Clemens

--nextPart6361837.CHHXAfLiSY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk1R080ACgkQZgdHbA22lqOVDQCg9q2yUUPh3FMkdiIK3/Tr+E2U
DAgAn2+rrdLIVmpJR9OH2kEIKkJ7MVjp
=dPWi
-----END PGP SIGNATURE-----

--nextPart6361837.CHHXAfLiSY--
