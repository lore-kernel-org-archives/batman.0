Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Tue, 20 Oct 2009 17:23:38 +0200
References: <45f642440910200802u6864b4cfk6b52f03bed14f8fe@mail.gmail.com>
	<200910201717.12868.sven.eckelmann@gmx.de>
In-Reply-To: <200910201717.12868.sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3814132.bFIBgabdn9";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200910201723.38988.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] basic B.A.T.M.A.N-adv setup
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart3814132.bFIBgabdn9
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sven Eckelmann wrote:
> You must give bat0 also an ip to use IPv4(/6) over it... in most cases only
> bat0 as it is just the hardware interface the bat0 interface is using.
> If you only want to test raw ethernet data over bat0 this should work.
Meant that wlan0 is just the hardware interface bat0 is using.

> > Or I have to bridge bat0 and wlan0 together?
No, you should not bridge them together.

Best regards,
	Sven

--nextPart3814132.bFIBgabdn9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJK3dX6AAoJEF2HCgfBJntGpCAP/RGizRzDI0QjXuovhPc/Pwsc
MoD6Dd+IA94gWaVM0tcnSDebKfXnKWwVTKaU1mPUNBugardkAF3AKTAhqK5j3WUW
wabTG+7fcDoN3hPFGpnsmOxV+qzG5INIF3UjIjFXzf1kEsVGs6Bn5ifWPyCkV8au
VUwOfJ7D7E/k+5rZwJB5LuRU6T2w1JE1zaOxd9NCTcC+4EXcaQ4rmYByPxfYh0Rx
kuXyi1b0bNThthJnMlHZOY4TnpvmogHh/X/R/EFDWM8C1mNuDKndWHTKJfXdUp7V
3GXH6WZjQwVU7MaphCCSU7p3el6VvUKQjT1Pv7zmD+c9HWu8ctIBWnQYZs8nInl4
Opu0AQcAW8i1bRBNGPZPFiI295JfKCYP319oiWdqV1v+CLFH8E3FIqGXKz1f5ujz
E5NJ99r6c+7SpRlN2Zx/gvCWsH/BthJMgGGOnOOPingZYqtTw37Lvplj5+8L8n8k
SQJOe4X2wpjat8bdJR7Dd5lWSJAB/5meydvorWyf58AG7oF3LxaO6VX7yyc1CIYb
4P0lo8HTvYr6AojRTCRc4mzCu84R8+x+tVS0MsUh2gkWK88nvPyvzJyg4UokNXDJ
oERUONOFD2nulOGykEcktgxigXPra6QmtlNN51eCdeQPBAo74XDYVpZmDIqqOh/h
0vyBUzqvuEtAGp3v7jxl
=fo7f
-----END PGP SIGNATURE-----

--nextPart3814132.bFIBgabdn9--
