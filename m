Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 20 Jun 2009 03:23:40 +0200
References: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
In-Reply-To: <5161afcd0906191517l4083ef4dnb1642207d81816c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4874190.AuyrTTDz8E";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200906200323.44115.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] HTTP transfers greater than 1000 bytes fail
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
To: b.a.t.m.a.n@lists.open-mesh.net

--nextPart4874190.AuyrTTDz8E
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Saturday 20 June 2009 00:17:23 Jacob Marble wrote:
> Two Linux boxes, each plugged in via Ethernet to a BATMAN node (two
> nodes).  The nodes talk batman-advanced to each other via WiFi.  The
> Linux boxes can ping each other all day long.  Both Linux boxes have
> Apache running.  Downloading a file via HTTP works only if the file is
> smaller than or equal to exactly 1,145 bytes.  TFTP file transfers are
> halting, but they get through (4 megabytes took a couple of minutes).
>
> This happens with both r1176 and r1298 on OpenWrt.
Sry, haven't followed your other mails so I don't know your whole setup. It=
=20
looks like a mtu problem for me. Please try to set the mtu a lot lower on y=
our=20
eth devices. You can do a ping test with `ping -s TESTSIZEINBYTE -M dont=20
IPTOSENDIPPACKET` - dont forget to add the 28 extra bytes needed for the wh=
ole=20
headers inside the ethernet frame. So `ping -s 1472 -M do 192.168.1.1` woul=
d=20
send a 1500 bytes package.
You can also set the mtu on your wifi devices higher (and bat0 devices). So=
=20
for example wifi device to 1524 and bat0 to 1500 (like the eth devices).
Also check if you have bridge mtu patch from Simon[1] (included in linux=20
2.6.27) when you are bridging some of the devices. Also check that icmp=20
"Destination Unreachable" - "Fragmentation required, and DF flag set" isn't=
=20
filtered anywhere.

Regards,
	Sven

[1]=20
http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dcomm=
it;h=3D4adf0af6818f3ea52421dc0bae836cfaf20ef72a

--nextPart4874190.AuyrTTDz8E
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAABCgAGBQJKPDocAAoJEF2HCgfBJntGsR8QAM8dEmcLn9TlfcyXAtr6w5HX
tywFCj+pVoVK7SFFgiDqSx8hTOtiKkESP6lytii0nIKTcPV+avOKNBtvTUZBxkWQ
Y7u9Bl6llWwe3Pdx1tllGcrI5x3HjQUNagj6b1uiZjqIvE8NF0IaOYgF0YYosoMt
rZKDFltVbMprZIlTbGxARzfHVcCMIKzGBfl74b07bUdi8bm0ak1tQLNCLQlro4zS
mpz5e8ypw6KKcU+5x5gxGsFQrLAQrwfCE6ZWLVVKoCcjKuqp9vscL/hZIXxM1nWr
jJ5/Y4018baTPdj2oZPA2QHCtTLWAYbr3Zyjm8X2O3Bs3FK1HQf/wHVj27cEVUfR
PanT3uMGj1viEi6LNUhtGXAqhFtT0INjhNIP1h6nxFsFdvU3iocgQixbHdJNsd+o
Eo46ER2jeKUGJ0x2I7p0booO0r7njWrIQAA5vPJEdAzQgtuZc+yPRskDVsubQHt3
dn2Swx31VASMCFtWxXf8r6CBFdsCrHrJcg4m8uaCgAGGGOdZgLMapukfuZRdZSmZ
Lvvx+EE6JvHYPMTwa7FVSMgrCtBXStJ8wZDVp+xFVnf58/RF83BkqtxekTNbQKEn
+ijVq8hgb5/3AKtWE8xF8qyoH7ks1eAYjfVZLZXDtWqM9FH8X2FvAMSZ5sRDZ0CT
0bhUIDU7n1t1mwa1wpJS
=55FR
-----END PGP SIGNATURE-----

--nextPart4874190.AuyrTTDz8E--
