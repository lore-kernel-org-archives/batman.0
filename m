Return-Path: <clemens-john@gmx.de>
From: Clemens John <clemens-john@gmx.de>
Date: Thu, 17 Jun 2010 14:35:42 +0200
References: <201006171018.47209.clemens-john@gmx.de>
	<201006171220.03431.clemens-john@gmx.de>
	<20100617120708.GA23608@Sellars>
In-Reply-To: <20100617120708.GA23608@Sellars>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6617478.tPQPfQB3pM";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201006171435.55683.clemens-john@gmx.de>
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

--nextPart6617478.tPQPfQB3pM
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

I think we are bridging the VPN interface:
root@OpenWrt:~# cat /etc/config/batman-adv-kernelland=20
config batman-adv-kernelland general
        option interface                'ath1 tap0'
        option originator_interval
        option log_level

> I know that tinc has two little, a bit hacky features in case of
> bridging tap0 with tap-mode (they call it switch-mode) to inform
> the other machines of the lower MTU in between. But I haven't
> heard of OpenVPN having similar features.
>
> So I guess the easiest step would be the first suggestion, to do
> routing in between and lowering the MTU on the tap interfaces for
> a start before starting to experiment with (experimental) features
> and/or more complicated setups :).

So there is no "easy" or documented way how to do this with openvpn without=
=20
routing? I would be happy if there is a way that is understandable.

If not, then I think the best way would be to try tinc.

Thanks
Clemens

--nextPart6617478.tPQPfQB3pM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkwaFp4ACgkQZgdHbA22lqNZggCgmrsC+drRh0pgg2bANmWpNlgr
3HYAnArTlEobRHEFnOjpc7Q57GYyA+Nb
=bFKh
-----END PGP SIGNATURE-----

--nextPart6617478.tPQPfQB3pM--
