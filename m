Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 2 Apr 2010 18:39:39 +0200
References: <201004021744.01077.clemens-john@gmx.de>
In-Reply-To: <201004021744.01077.clemens-john@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2204686.VPPjBLcYhf";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201004021839.54531.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman Advanced Internet Gateway
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

--nextPart2204686.VPPjBLcYhf
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 02 April 2010 17:43:48 Clemens John wrote:
> on https://www.open-mesh.org/wiki/batman-adv stands, that the upcoming
>  batman- adv 0.3 supports advanced gateway  handling
>=20
> We are testing Batman Advanced as described in my other thread and I want
>  to share my Internetconnection on our network. How do I do this with
>  Batman Advanced?

Just as usual - nat/masquerading and announcing that to your fellow=20
participants.

Some bootstrapping protocol is the real thing which tells nodes were they c=
an=20
send their ip packets to. So imagine that you are sending a bootp request t=
o=20
the whole network -  the fastest server would reply and give you enough=20
information to adjust the routing table. But maybe this machine is not a go=
od=20
choice in metrics of batman-adv. The idea is now to forward that packet onl=
y=20
to a specific host instead of the whole network - it is not real clean in t=
erms=20
of separation of layers, but it works without adding another specialized ip=
=20
routing daemon. This is _only_ needed if you have a "complicated" setup wit=
h=20
many gateways which must be chosen depending on the state of the mesh. Sing=
le=20
gateways just work as you would expect it without that support.

> Is there already a working Batman Advanced version that supports Internet
> connection sharing (Maybe Trunk? Which revision?)?

Trunk is where the development work is done for 0.3. I will not point you t=
o=20
the actual commit, because it would be a version with known bugs - which ar=
e=20
fixed in the current trunk version.

I think most of the code is inside gateway-* files. You will notice that is=
=20
looks similar to the batmand code - so you can read the batmand stuff how t=
he=20
actual selection of a gateway works.

Basically you will have a gateway_mode in /sys or /proc (depends on the=20
version you use - Marek just switches everything to a new configuration lay=
out=20
in /sys). This can be used to say "hey, I am a server" or "I am a client an=
d=20
will choose the best destination in case of a request (udp broadcast to dst=
=20
port 67)".  The real dhcp server must be running on the server or such requ=
est=20
will not answered. You can also choose a scheme which choose how such gatew=
ays=20
are elected by the client and the server announce their bandwidth - but as =
you=20
will see now, it is only needed in situation with multiple gateways and a m=
ore=20
complex mesh situation.

> In Olsr there was the dyn_gateway_plugin. How can I have something like
>  it=B4s functionality in Batman Advanced?

OLSR works on a complete different level. batmand was the thing which worke=
d=20
similar to olsrd (same layer).  It has also an interesting feature called=20
blackhole detection and can work with multiple gateways - but it is not=20
batman-adv. So comparison of that plugin makes no sense.

Just as reminder: batman-adv can choose a gateway but will _not_ setup the=
=20
whole routing stuff on ip layer on client or server. You can use whatever w=
orks=20
on top of ethernet (maybe some work better than others on top of a mesh).

Best regards,
	Sven

--nextPart2204686.VPPjBLcYhf
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLth3VAAoJEF2HCgfBJntGwwwP/1tlzibxnYcocD56EGxtdh/d
iZ4bOkUeZpH+3mvU47RQ62uAA61DwfI3SWNLgvSJV5PEoiGzNoOrXlULZEGRyKB5
2xMhsRJ770BsBziZiFmEv/uIP0JrcpUZ1f/XucSgwrTZGrqcfYS8dhd3O2eGdUem
gceessPCht3I9hWPSYjySWyUeCZ8Rx6r6LmbhOXSJq13kFswqf9Bh87aBPelD5ih
5pIT7sR4nVChgpqBXytiv0YI7JSDWcFMf4zdfFW9stYZNI2nhw/XmwIGZMdNwrkq
KvK/PTZ7BN2B+vFbqIXxy3pcMCaqu92vUyTiBCIsewQjFAaCUXKXGHwA5xedYyCA
e2MrkQdpEA0ZSl8xXwmQCnS9gaZSClMjNcaB82qiNcSDJr5/aw0x4UFvIHafIZ/Z
UTSgR1YcQup7UcIEk4zoWaXy+EYbGA0aKWsaGRM/tU6W1Z99tS24+gUua9aiLX5v
HQL3QSdEEZZrybc1JiU1xt0iu2NLyz64KpzNY7BbKTO9OdLVrLaVoQ46rsojlf1g
obdGdbsogqj3aOcvib+Aq1ZAQR5KI4u4J/+K+V0ZgngtU0f08oJ13+MtE5Gasf3r
Xyg6v5dcdjtuWW40Xj0DNJ12oR96QQbsErKaHXMe0Uxa/TuPItqWmcYJNWrsoCJN
YBEZSRTCjbuqmfYvlCYM
=cQLQ
-----END PGP SIGNATURE-----

--nextPart2204686.VPPjBLcYhf--
