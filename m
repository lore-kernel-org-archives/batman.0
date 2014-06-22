Return-Path: <ilario.gelmetti@sns.it>
Message-ID: <53A6B0E4.6070503@sns.it>
Date: Sun, 22 Jun 2014 12:33:08 +0200
From: Ilario Gelmetti <ilario.gelmetti@sns.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="s8u5OJt02cT04wRcpmoWUAMTtHb2MvL76"
Subject: [B.A.T.M.A.N.] Bad link via ethernet using two tl-wr1043nd ports
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s8u5OJt02cT04wRcpmoWUAMTtHb2MvL76
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi all!
I'm using OpenWrt trunk (r41296) with batman-adv (2014.2.0) on a TP-Link
WR1043ND using this network configuration file:
http://sprunge.us/SVCI
as you can see batman is running on ports number 1 (eth0.3) and number 3
(eth0.4).

 root@OpenWrt:~# batctl if
 eth0.3: active
 eth0.4: active

I connect this router via ethernet cable to another device running
batman-adv (2014.2.0).
Looking at the link quality with "batctl o" I noticed that sometimes the
link quality is poor using a port and good using the other one port. The
good and the bad port aren't fixed, they switch randomly, so I tend to
exclude an hardware problem. I connected the batman device to port 1
(eth0.3) and laptop on port 3 (eth0.4) and the quality of the batman
link changes from one boot to another:

 root@OpenWrt:~# batctl o
 [B.A.T.M.A.N. adv 2014.2.0, MainIF/MAC: eth0.3/10:fe:ed:7f:3e:80 (bat0
BATMAN_IV)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
 dc:9f:db:2c:e4:34    0.700s   (255) dc:9f:db:2d:e4:34 [    eth0.3]:
dc:9f:db:2d:e4:34 (255)
 dc:9f:db:2d:e4:34    0.360s   (255) dc:9f:db:2d:e4:34 [    eth0.3]:
dc:9f:db:2d:e4:34 (255)

-----reboot & wait some minutes-----
good, 255
-----reboot & wait some minutes-----

 root@OpenWrt:~# batctl o
 [B.A.T.M.A.N. adv 2014.2.0, MainIF/MAC: eth0.4/10:fe:ed:7f:3e:80 (bat0
BATMAN_IV)]
   Originator      last-seen (#/255)           Nexthop [outgoingIF]:
Potential nexthops ...
 dc:9f:db:2c:e4:34    0.680s   (119) dc:9f:db:2d:e4:34 [    eth0.3]:
dc:9f:db:2d:e4:34 (119)
 dc:9f:db:2d:e4:34    0.580s   (119) dc:9f:db:2d:e4:34 [    eth0.3]:
dc:9f:db:2d:e4:34 (119)

-----reboot & wait some minutes-----
good, 255
-----reboot & wait some minutes-----
bad, ~129
-----reboot & wait some minutes-----
bad, ~139
-----reboot & wait some minutes-----
bad, ~131
-----reboot & wait some minutes-----
good, 255

Thanks,
Ilario

--=20
Ilario Gelmetti
iochesonome@gmail.com
ilario.gelmetti@sns.it


--s8u5OJt02cT04wRcpmoWUAMTtHb2MvL76
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOmsOgACgkQifrzB0y7qpbHkwCeM8p2XnPNWmLmwsY8chA6GGLV
0pIAnjTaJaXQAq6nYVBBQgF87GfwGgfQ
=SrWt
-----END PGP SIGNATURE-----

--s8u5OJt02cT04wRcpmoWUAMTtHb2MvL76--
