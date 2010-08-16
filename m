Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 16 Aug 2010 18:32:13 +0200
References: <mailman.375.1281525844.17951.b.a.t.m.a.n@lists.open-mesh.org>
	<201008141646.49517.lindner_marek@yahoo.de>
	<AANLkTimpmFOrT_AnH5Fq-50uLBJswhC_T1-B3G4fC8Nc@mail.gmail.com>
In-Reply-To: <AANLkTimpmFOrT_AnH5Fq-50uLBJswhC_T1-B3G4fC8Nc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1813598.UYuphJ4HYj";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201008161832.14980.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Nat Question
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
Cc: David Beaumont <djb31st@gmail.com>

--nextPart1813598.UYuphJ4HYj
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

David Beaumont wrote:
> Sorry for the late reply, a few things came up over the weekend that i
> had to attend to.
>=20
> Here are three tcp dump files from the internet node on bat0 and one
> on eth1 (the internet port)
>=20
> Really don't understand what is wrong here :-(

Ok, test plan:

 * Find the machine and interface were a response from google.com could be
   received but which will not forward it to the other interface
 * take a real dump on all interfaces (wan and lan)
   tcpdump -s 0 -i eth1 -w eth1.dump
 * when the response packet is forwarded over the lan/bat0 interface but
   doesn't get to the final machine than please also create a tcpdump on the
   receiving machine (real interface and maybe bat0)
 * Go to your router and check mtu of your wan interface
 * Try to ping google.com with the maximum size (mtu - 28 bytes, for exampl=
e=20
   mtu 1492): ping -M do -s 1464 google.com
 * Send small tcp packet with small tcp response:
   echo "HEAD / HTTP/1.1\nHost: git.open-mesh.net\n\n"|nc git.open-mesh.net=
 80

Best regards,
	Sven

--nextPart1813598.UYuphJ4HYj
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMaWgOAAoJEF2HCgfBJntGVCYQAJhKJnkG74OqHygD8GbdmhCa
+KIGXmiEcsAE/IZ1aUsnJ5ZvfZ2ztCf8PZPCYfvmhoxcpMg2Lvl23zJHMBP8Ech3
dy3C237gljAaMNEaofASMRjhuZfI8wRipomRiQ46TWGxJnjbklTq7NA1wExP6koj
qdGIM4r+lJSLhtmS9+vSD4xYcVaSsX99hDndv0FWg3cNWJreJfmovOiph+44juPf
HKtNMKY8dm2rhoLmwhrs1Z6YwbcYX4Jyq+rSIvScdoes9uCTxf2hOkmnw9YbCztL
O8agV+SK9FS5F+fojCZ+RSyOL6CUXzAuinz9VjPVdzsR5AoOaSb5CZ2J8h9wFtoK
1Gb6FhlsOZt26NocYADyyDcmg2GzilwDHX1xfLcqJnWO4yAha5YuVUWYbl/AVgXR
Bsgx/7nXA/VoEw9gDdKf+ECqO1TcB7I70RHCcMRSCpjzbRUmQpwuqaL9Ug5RgBCH
K9CqCmHSKUOSbXnngBiQBdUsLgzvt2OvOx55sAvre11Glwyrkc68vCHrY/bm6kiX
3JGxi8JnzHV2K2jo3iO/LIGG7IXhFQq7kF4rinvivIsHDSzLPK8qAIy4HU1zUm8H
YcYFLAC8rlV3auRNJ12HHl6vNyP1ochNOtW3xp+N0iQji8TceUOo5PKzw3WYYaTx
6HiPKLThUgbrhCT6AHkS
=1Pf/
-----END PGP SIGNATURE-----

--nextPart1813598.UYuphJ4HYj--
