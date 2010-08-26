Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Thu, 26 Aug 2010 10:28:26 +0200
References: <4C6437BF.9080909@web.de>
	<201008210801.17503.lindner_marek@yahoo.de>
	<4C760EEB.4000001@bb.banban.jp>
In-Reply-To: <4C760EEB.4000001@bb.banban.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2263609.5Tslo9FB10";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008261028.35755.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] problem openwrt-trunk + ath5k + batman-adv-devel
	in my case
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
To: b.a.t.m.a.n@lists.open-mesh.org

--nextPart2263609.5Tslo9FB10
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Thursday 26 August 2010 08:51:23 Kazuki Shimada wrote:
>   Hi, Marek and Sven.
>=20
> I'm sorry to be late to reply.
> Thank you for your instruction and patches.
> I could update to latest revision 1778 and built successfully.
>=20
> I met a new problem.
> After configuration, I entered /etc/init.d/network restart
>=20
> root@OpenWrt:/# /etc/init.d/network restart
> br-lan: port 3(bat0) entering disabled state
> br-lan: port 1(eth0) entering disabled state
> device bat0 left promiscuous mode
> br-lan: port 3(bat0) entering disabled state
> device eth1 left promiscuous mode
> br-lan: port 2(eth1) entering disabled state
> device eth0 left promiscuous mode
> br-lan: port 1(eth0) entering disabled state
> eth0: link down
> device eth0 entered promiscuous mode
> device eth1 entered promiscuous mode
> device bat0 entered promiscuous mode
> br-lan: port 3(bat0) entering forwarding state
> batman_adv: bat0: Interface deactivated: wlan0
> batman_adv: bat0: Removing interface: wlan0
> eth0: link up, speed 100 Mb/s, full duplex
> br-lan: port 1(eth0) entering forwarding state
> batman_adv: bat0: Interface deactivated: wlan1
> batman_adv: bat0: Removing interface: wlan1
>=20
> After this line, console stopped. No key input was recieved.

Hm, thats not much information. So here some question to enrich it a little=
=20
bit (otherwise I have no idea were the problem might be as I could not=20
reproduce it yet).

How did you connect? Using serial console or using lan (from output I would=
=20
guess serial console).

Does the hang always happen?

Can you reproduce the problem with the version in linux-2.6.36-rc3 or=20
maint/next of the batman-adv git repository? Can you reproduce the problem =
by=20
doing the necessary insmode/iw/batctl/rmmod steps by hand (aka no=20
configuration using /etc, but manually)? What where your calls? Which call=
=20
made it hang? Can you drop parts of you iw/batctl calls and the hang still=
=20
occurs?

Can you add printks in hard-interface.c around the call of=20
hardif_remove_interface inside hard_if_event to check if it stops inside th=
at=20
function and if it does then please try to add more printks inside of=20
hardif_remove_interface and hardif_disable_interface.

thanks,
	Sven

--nextPart2263609.5Tslo9FB10
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMdiWsAAoJEF2HCgfBJntGjSsQALJnVKg3NPZwDzVWB9DFwkQ8
JwQsmplrC376RbMckKVu3pso9vyjDr8XUoVrIhXyBP2HVZElnGnp8tY0Tk+v6nIf
HhEtf4MZQ7UyCN6yoUrsNUczr88eEJh7XaRnFFZZvTnTbes09qv0l1X/HeiThLZy
E0QKz2tgTHufIaUkk2uHg8lUKHgMysnsLWgG/wD3V+yc4S+7PdqEjm1rqkRiGmRE
Nx5TkwW1C9SFTEkE7tty7MgtN9K9sZMVbRz1qhR22CkwjtK2qMU3liarrLcWCit/
L6GYFkgWkInAaaVTt/VsbwndPYlnSA0AwuM3FoByrqoPY0a82+e1vELJsrFlVhXv
0RKaaLIPMwefV/4camhqUSgkGdW/YRiyyEkuVV+8l8Fz0ZdD6+ZAZ2kPPli50zaT
BQ2TEvxOjoz68Tx3oGtDyQ4z5ObLIHC2iZTqVQDtwmVCn7s86C7ebYY6jbUEzOT/
8k+pA+FpSSDhsXMledEwRVjxzNf59bIQ+sYTu2garSUHUQUSYM1TqndMtR9cR/FJ
BDYhGKLRj1JFTlXtSm2SOipaKSmZa6n3VH/gUx/Dk0zdVIgp/SbUfr1454m8j3Ec
ZGey8HQ/9C7r4KKKpCiUijqxzGdsFtCEUawxB6uINoMula/I+hqIxUdXpYM5wrtV
OveSjfIi4UHrxPRZ4MYB
=yK3g
-----END PGP SIGNATURE-----

--nextPart2263609.5Tslo9FB10--
