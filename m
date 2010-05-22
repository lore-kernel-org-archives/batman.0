Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 17:53:53 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1634122.27galRBN9d";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005221753.54176.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 00/26] Staging: batman-adv for 2.6.36
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
To: gregkh@suse.de
Cc: b.a.t.m.a.n@lists.open-mesh.net

--nextPart1634122.27galRBN9d
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

here are the patches for 2.6.36 split from the old patchset.

Linus L=FCssing (1):
      Staging: batman-adv: Adding netfilter-bridge hooks

Marek Lindner (3):
      Staging: batman-adv: remove redundant struct declaration
      Staging: batman-adv: convert all sysfs files to single value files
      Staging: batman-adv: Add information about batman-adv sysfs entries

Sven Eckelmann (2):
      Staging: batman-adv: Move device for icmp injection to debugfs
      Staging: batman-adv: Move tables from sysfs to debugfs

Best regards,
	Sven

--nextPart1634122.27galRBN9d
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL9/4RAAoJEF2HCgfBJntGbtYP/3pdDjG10DsTiXz57ip6J4VQ
McsZrxzRzMCOtADFfpmPsLsPiQm+qigUIAQs3Vn/q8DVpq/c4Gx3OshBDJDTTwhN
fdSb/pTm42ECnA0RDUEWJurXeLVfH3uxkO26pFCIQwO+1IwbmcvdNO/MS2Anyz5b
J0OqcAUtiymHIKqY1WZYMEL44UkvdcJuX4K0PF+ST3+dwYj3KV90szRT/DzFn11E
+E5SjhnfnI6SRAfNVVdymqeykFVt1PO0g3jIR3+yO54aADpVC0i/cUcfACSFU/PE
lBj+Kvjzv1LCzYkhgVBquZ0kPKH2bKBFE31d0kzWZtB/KlcdHwU4LEhXKRwXeEsK
N7EsusjGHkRrTW3LtTc6387BO9asaKpo8oT6Xy64PEO/QA89RQ9iniz3WHthcATk
N1o7dBgmqye8YbIea+//5aYFn/FyyTOJGWZCXHZ9+VzPdSnUvKBv4dc95PYoqyXe
n/M96xDevUOULLOoeUFdgR2Z766mFpOsAqVhybTkS9ahDcSoo7oLPZ2nY6SnsYB+
zOtImnkl1+IM5Jd6Mql3cN/C1XeMyEeRhLo43nHzvXxvFYskTyL8qEpOAbpozxpz
dzpuGwqearmoOxAz/lsulbsXbroaxLiVATkEUj4WuQQNagurJ4DxLthG6y7/UfdD
1lBBRTsEUboMjtOCeMDt
=y332
-----END PGP SIGNATURE-----

--nextPart1634122.27galRBN9d--
