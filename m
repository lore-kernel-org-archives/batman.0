Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Fri, 17 Sep 2010 00:44:11 +0200
References: <201009170035.05463.lindner_marek@yahoo.de>
	<1284676540-15734-1-git-send-email-lindner_marek@yahoo.de>
In-Reply-To: <1284676540-15734-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1561072.HDMT5rRO5D";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201009170044.12820.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: softif lan loop avoidance
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

--nextPart1561072.HDMT5rRO5D
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

To make it short: please check your code against=20
Documentation/RCU/checklist.txt

The new patch adds different problems I tried to address in other patches=20
posted by me today. There are also new parts which leaks information outsid=
e=20
rcu_read_lock... so parts which aren't yet addressed by patches for other=20
subsystems of batman-adv.

Best regards,
	Sven

--nextPart1561072.HDMT5rRO5D
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMkp28AAoJEF2HCgfBJntGUQIP/RmSIQLKn72DEil28xpXFehV
IFG4LrgAD3B7qUmhq739DaLDd6p4hWsCa6P3eU9FL11dl5adSgt7OHUby0xsnzXG
72ZfxvwvYeG+h1JxZrFHSpf+1JwWDD/HY9fBbi0nS0TV3lXqBZlv2MliC5zRFk5T
X+7m0A7Se24YBLEfre8u1PHtOdIdmzr5cO1s9G658xwLqLSHaq6XD69RGAHKvyfD
ccbTtF3wZJ9YdmYiIvhzPuvlTEFrs+P9yn4y7evrHHmw+lXmskNvomIVl8cJ5EhZ
lG/dfKlk5s9NWbQOkshRsxfihS8ji3+4Gk66ZEvWlJHB9xN+CgaY1g2z/CKa304S
FOc+cIsuLRmwu3MQt/mxLJZdRAuFhR1eAwcr5ecKTnh393vs9qNVGOXP/IEjJN2R
/HeFRtMl2QML572S0Bj0NnYYLeYwoxeP6IJCuVxb4Bb+aoD08B0o97FUTl/Polhs
e/HWAw3ZR4xXWJDX5Ko4rCG8+1v+CPtByvpoYGsLlKe9k/UaZIa3lx8qfsiXWFA/
JHjJq9nmBaigvIq+CNk6TEncjAv4lOkCG0rvhEPn2/5xM2efFHreqZHskGdQX4Fy
cVLX/iOok7tmerhX2r3QhkYB/LJ2huqtc5bNfsTl7X9/VyWwiOkSgniAEl44GSh6
Yhavfxl8E0TCcemA9Mis
=PTVV
-----END PGP SIGNATURE-----

--nextPart1561072.HDMT5rRO5D--
