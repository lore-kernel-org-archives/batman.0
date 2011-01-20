Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 20 Jan 2011 12:36:49 +0100
References: <1295518649-25141-1-git-send-email-lindner_marek@yahoo.de>
	<201101201157.25991.sven@narfation.org>
	<201101201201.15645.lindner_marek@yahoo.de>
In-Reply-To: <201101201201.15645.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4836123.ChR3CGAIiV";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201101201236.51262.sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: update compat version
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
To: Marek Lindner <lindner_marek@yahoo.de>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart4836123.ChR3CGAIiV
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On Thursday 20 January 2011 12:01:14 Marek Lindner wrote:
> As the table states 2010.2.0 got version 13 but trunk & next are on 12. I
> made a diff between the packet.h files and saw the gateway flags,
> therefore I proposed to increase the version number to 14. Should the next
> release contain a version smaller than the previous release ?

If you promise that we won't have a feature in trunk but not in next for=20
ages... Personally I don't see the reason to make a fully compatible versio=
n=20
incompatible. And I don't want to explain David S. Miller why he has to mer=
ge=20
such a change (and the merge window is closed now).

Best regards,
	Sven

--nextPart4836123.ChR3CGAIiV
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJNOB5RAAoJEF2HCgfBJntGxkgP/3ORii4lrXqIlRYnt6OtHIlP
tw/US+TEIYOS4A5QBSQ/DaL6T87Kqr7EqtvoJyq/8N88Fk9pI4QnAFiOFtoPwAdX
/Xppr51F06cJgpHmAZtEalMwvy2pu6iefug0WcizS6QEWwVwtAOCTaM3bdO8LgK+
VQ78P5k2JFNTOgMurP5dbOtncYZ2isk61IcDEz6ZTLwa9SQo8TXgqDUN8l6U6R+Y
igFeEbB+YUHhNn2o8J6F88ezH5DRfoslq1VMDdlU9xG/T0EqWFDlk85htK4qNVQO
+HpkvmvhgMQzRXQzkadtJ+b2qqDLTTO1t1kld/weh5M37vMfkPWnds/6M08G3RqC
494I08a5lKZwjb8VA4HYNjueWBhz0poy82X0Sc/ODW3jJSCivxsd2GkchZQsPtVO
CerhaFbtSbxwoHlfiDw4Dm5nwCHksgjNyjWz3k3vxF99yueNdBFR5ftiDDa2nRbn
m/Wqk3nhbfppy0zCUKuETDdBcMn/woQYo+nTnz80gOgCyQe9J5itfzb8AiN+VUe/
eICqFdY1CvjfYNsBK3pO6p69d4k7mokg3+afFjMCd/Ip8xV0cgGMkbP/YuOF+S8U
eISQQCnjQUZpmme6HSXTeRXF+eVln/HElntBQWeVScdbfmwK8liMOKzENV7VRJ4n
FI8Vx6hmrzN+RLL1RUBh
=XJ2J
-----END PGP SIGNATURE-----

--nextPart4836123.ChR3CGAIiV--
