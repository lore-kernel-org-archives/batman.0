Return-Path: <ordex@autistici.org>
Date: Mon, 3 Jun 2013 18:08:13 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130603160813.GC1226@ritirata.org>
References: <51A3C7E9.7080208@inti.gob.ar> <20130528070057.GC3333@ritirata.org>
 <51ACBCE4.8000506@inti.gob.ar>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <51ACBCE4.8000506@inti.gob.ar>
Subject: Re: [B.A.T.M.A.N.] batctl bw performance
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
To: Gabriel =?utf-8?B?VG9sw7Nu?= <gtolon@inti.gob.ar>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Gabriel,

first of all thank you very much for testing the bw meter :-)
answers follow inline.

On Mon, Jun 03, 2013 at 12:57:24PM -0300, Gabriel Tol=C3=B3n wrote:
>    Hi Antonio,
>=20
>    As you suggested, I've tested the bandwidth meter with batman-adv-devel
>    38a1b72. I've installed it on two TP-Link WDR-3500 routers.
>=20

oky. However, since the bw_meter has not been merged yet, its branch changes
=66rom time to time because it gets rebased on top of the very latest devel=
opment
code. Therefore, when you decide to update your testbed, I'd suggest you to=
 look
at: http://git.open-mesh.org/batman-adv.git/shortlog/refs/heads/ordex/bw_me=
ter
and pick the commit ID of the last patch at the top.

If you have problems in doing this, please ask.

>    Running normal iperf inside the routers, and without unloading any ker=
nel
>    module, I get 60 Mbps using UDP, 80 Mbps using TCP (I don't understand=
 why
>    TCP works better), and about 4 Mbps with batctl bw -t 10000. Any ideas=
? By
>    the way, the batctl ping between routers doesn't  work, I get time-out.
>    Besides, there's another strange behaviour, when I try to pass traffic
>    from a PC client connected to one router, to the other router using ip=
erf,
>    if I use UDP values of about 100 Mbps, the router that receives the
>    traffic and redirects it, reboots. Thanks.
>=20

Ok..well, first of all I'd rather check what is wrong in the mesh. If batctl
ping does not work, then it means that there is something else which is not
working/configured properly.

For this reason I'll first suggest you to update to this commit id: d672369=
 .
Then, does "batctl o" properly shows the other node with a "reasonable TQ"?


By the way, your iperf tests have been done on top of batman-adv? or direct=
ly on
the wifi interface?

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRrL9sAAoJEADl0hg6qKeOmVMP/3AccmyQly0ql5SVjuduEdAW
1algL5z5oR5dWV069/thLwH0KxZZXeH8oGHesxa90n55VBByKCR7ZiHND8rL981P
2IlEWP6BiX5Q8I0TTlbqrLhDs1TT80wW+w7aJsU/GLM5X28+bOhqP5dXx31i+TMS
oH10Iuae8p/3sxDArCvh5jkTj/TBl3lPHYeTxwwg68sx9WbQNbWX8BAZJDVGR1LU
Yfun8sziPRxGpND9h2CLA+md3capVYlGjW4LlJBcZIeoTlKIPv5MAwqGidlJAf/0
7th6pgmIlICQzKUrIfFpdwKOaECeHXZKDJ8xaMX4Cpru9Jz6VJpCMUvg5KonmbgT
A95r4iGxNCoD48EibKbjMSFQskuuhZc2RseZ/LgGLk+jRIX/RlNK0acSO9hHHg7Y
vJjolJj+Cb5ODvDPMIV9yuwz2CYOthCjSo2pvCaY8hnEviBjlkHWkk8+fRVG64mJ
k7blE6gNcTakM+R8b4/2DozJRUVVyt4z3EWdY/OE/bCpM+oj2TjwGbQOanZEe9dz
J+Nrf9VuqSyVvJ0pr2UrtaUp+FTXJWdKPI1RyeoWfuzpFWI/kiuTB0+Bz1Tq6Day
Ny+W3Ijm6PhKcMoHGsLRX69hBPhiO5EAlxrKTMD3k7cF7M56k+VRLoGik4Sf8urr
U2vkbQNZQR19UCGWbHh8
=fr9M
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
