Return-Path: <linus.luessing@web.de>
Date: Fri, 2 Apr 2010 08:52:29 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@web.de>
Message-ID: <20100402065229.GA3908@Linus-Debian>
References: <201004020054.08840.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <201004020054.08840.clemens-john@gmx.de>
Sender: linus.luessing@web.de
Subject: Re: [B.A.T.M.A.N.] Problems connecting VPN and WLAN with Batman-adv
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


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Floh1111,

Welcome to the B.A.T.M.A.N. mailing list :).

On Fri, Apr 02, 2010 at 12:54:02AM +0200, Clemens John wrote:
> Hi,
>=20
> I use batman advanced ("# batctl o" says "B.A.T.M.A.N. adv 0.2.1-beta r15=
78")=20
> on OpenWrt trunk and I have the following problem:
>=20
> I have a wlan meshnetwork in ahdemo mode which uses batman. The meshnetwo=
rk is=20
> used by clients without batman and therefore I have another network on th=
e=20
> same wifi device in ad mode which is bridged with bat0.
> The bridge is in the network 10.18.1.0/24.
>=20
> I think its like described in http://www.open-mesh.org/wiki/batman-adv-qu=
ick-
> start-guide
Yes, this configuration looks quite good already if I didn't miss
anything and if you're having wifi cards with an atheros chip.
What kind of devices are you using?
>=20
> The problem is, that I have a vpn network on tap0 (10.18.0.0/24) and I do=
nt=20
> know how I can link this two networks/interfaces to each other with batma=
n.
> I tried to assign tap0 to batman, but this doesnt work.
>=20
> I want to be able to ping hosts that uses batman in the vpn and in the wl=
an=20
> network. How can I do this?
Ok, now I have some more questions already :). What do you want to
gain with this vpn exactly, merging a couple of mesh clouds or
getting the network behind the vpn into the mesh? What is
creating this vpn right now, how are the two sites connected with
each other (over network identified with 'lan' I guess?).
Does pinging inside of the vpn itself without any mesh work?

=46rom the configuration now, it looks like you're having another
batman-adv on the other side of the vpn as you've assigned tap0 to
batman. So keep in mind that the recipient on the other side of the tunnel
will get batman-adv ethernet frames only which encapsulate the
payload - there has to be a batman-adv on the other side to unwrap
the IP packets again.
And if there is a batman-adv on the other side of the tunnel, make
sure the vpn itself is transporting whole ethernet frames and not
only ip packets (in tinc this is "switched" mode for instance or
in OpenVPN having "dev tap" and not "dev tun").

Cheers, Linus

>=20
> My configs look like this:
>=20
> ---------------
> /etc/conf/network
> ---------------
> config 'interface' 'loopback'
>         option 'ifname' 'lo'
>         option 'proto' 'static'
>         option 'ipaddr' '127.0.0.1'
>         option 'netmask' '255.0.0.0'
>=20
> config 'interface' 'lan'
>         option 'proto' 'dhcp'
>         option 'ifname' 'eth0'
>=20
> config 'interface' 'mesh'
>         option 'type' 'bridge'
>         option 'ifname' 'ath0 bat0'
>         option 'proto' 'static'
>         option 'ipaddr' '10.18.1.101'
>         option 'netmask' '255.255.255.0'
>=20
> config 'interface' 'vpn'
>         option 'proto' 'none'
>         option 'ifname' 'tap0'
>=20
> ---------------
> /etc/conf/wireless
> ---------------
> config wifi-device  wifi0
>         option type     atheros
>         option channel  6
>=20
> config wifi-iface
>         option device   wifi0
>         option mode     ahdemo
>         option bssid    02:CA:FF:EE:BA:BE
>=20
> config wifi-iface
>         option device   wifi0
>         option mode     ap
>         option ssid     oldenburg.freifunk.net
>=20
> ---------------
> /etc/conf/batman-adv-kernelland
> ---------------
> config batman-adv-kernelland general
>         option interface                'ath1 tap0'
>         option originator_interval
>         option log_level
>=20
> thanks
> Floh1111



--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBAgAGBQJLtZQtAAoJEBKw7u43QNpfsSwP/1y7MhUHLNPdl3GbjCWiROCl
qNxwMMupoXGMp7IyUSlKy66rPmHn8YPUMPPttPDkKUQB2gFLmVAa7E5Jt/pX41Su
K6BNHDbvzPrVxNwz4E7JWCu4Hvolqsz+54TFwSkJN3U/JSgOuOW5xzvIYdhIV2Kx
6MJ4d1JD17DXyoFJB7W4zspcoLL75DjDJWDxSdinxGRxBnGwZjYvo3O4funrzfxn
vupSLqP1EIFXL6Q8niLmAL3HyPnDH0B24HHw/OxqdTT3flUkVVVE+kq3FEKF2uGp
9UlCw7yaVjjvZ68ErYvcB0jGu6Pfzrg0IKa4foIM6b9S9YL5vEx5UlrJ3nuXhzp9
8vIWtvPXFrMi+jq/7lQ8Ue2yCNmCuVtoHXzzNe9LUtctBXMEv377ef42RropYIG1
b4kjLwdxX23nWAUsj4sDDfb83EdBsB1ZEZCm8YEDq+MIMQLEDUvtFnMXM84tjJb4
xfD0u27Ie5gt44SCNcVlQNORAOon2a9W+9Ev/uirBMMYAWHSEDchhr/dFpzAcnC+
c4MsrAR5VxJRdWipHl9o251hPMpAntdHxW5kIMzok/3DbBgzg2gBcKlecZ4es0bn
Y88ltCPV3siUNGAfuo3G13mIs7YpQrzyK7WMhEvXQXpoGBgoP8iIYTEkwACk20M8
DiL/toWNr5PacLes9gPP
=eAMN
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
