Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Thu, 17 Jun 2010 16:19:44 +0200
References: <201006171018.47209.clemens-john@gmx.de>
	<201006171220.03431.clemens-john@gmx.de>
	<20100617120708.GA23608@Sellars>
In-Reply-To: <20100617120708.GA23608@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1516620.utRFnycUpZ";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201006171619.49916.clemens-john@gmx.de>
Subject: Re: [B.A.T.M.A.N.] MTU/connection problem
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

--nextPart1516620.utRFnycUpZ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thursday 17 June 2010 14:07:09 Linus L=C3=BCssing wrote:
> Yep, tap mode in openvpn is adding an extra header, it
> encapsulates not only the ip-packet but also the ethernet frame
> into udp or tcp. (By the way, tun-mode also adds an
> extra header, but the packets are smaller - only IP packets
> encapsulated in UDP or TCP.)
>=20
> May I ask whether you are bridging tap0 or if you are routing the
> packets (so having an ip address on tap0 and having according
> entries in your routing table)? If it's the latter, then you could
> just decrease the MTU on the tap0 interfaces to a fitting size and
> let the VPN routers do the PMTU discovery stuff automatically. But
> of course, then you probably wouldn't need tap-mode in this
> scenario, as it just adds additional overhead with the unnecessary
> ethernet frame in between.
>=20
> I know that tinc has two little, a bit hacky features in case of
> bridging tap0 with tap-mode (they call it switch-mode) to inform
> the other machines of the lower MTU in between. But I haven't
> heard of OpenVPN having similar features.
>=20
> So I guess the easiest step would be the first suggestion, to do
> routing in between and lowering the MTU on the tap interfaces for
> a start before starting to experiment with (experimental) features
> and/or more complicated setups :).
>=20
> Cheers, Linus

We tried tinc now, but the problem does still exist.
Our Tinc config looks like this:

=2D---------
root@OpenWrt:~# cat /etc/tinc/batvpn/tinc.conf=20
Hostnames=3Dyes
Mode=3DSwitch
name=3Dfloh1111
ConnectTo=3Dbatgw
#ConnectTo=3Dharlingen
=2D----------

Normal ping over vpn till package size 1453 works.
If I increase the package size to 1454 ping fails.

All devices have an mtu of 1530 except bat0 and br-mesh which have an mtu o=
f=20
1500.
Batman is running on the tinc device tap0 and our bridge looks like this:

=2D--------
config 'interface' 'mesh'
        option 'type' 'bridge'
        option 'ifname' 'ath0 bat0'
        option 'proto' 'static'
        option 'ipaddr' '10.18.1.101'
        option 'netmask' '255.255.128.0'
        option 'mtu' '1500'
        option 'dns'   '10.18.0.1 10.18.0.254'
=2D-------------

If I decrease the mtu on the client that has no batman advanced to 1481,=20
everything works fine.

Think we need help again^^
Clemens

--nextPart1516620.utRFnycUpZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwaLwAACgkQZgdHbA22lqMgIgCdHEwzLaPy1G7ORq/84FhMw4jT
X0AAoLxFTsSDE1bbHXLBuzKGq+QNFHiR
=UWQB
-----END PGP SIGNATURE-----

--nextPart1516620.utRFnycUpZ--
