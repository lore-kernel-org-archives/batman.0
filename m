Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 22 May 2010 16:16:45 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2991219.jxXPom7Qux";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005221616.46785.sven.eckelmann@gmx.de>
Subject: [B.A.T.M.A.N.] [PATCH 00/26] Staging: batman-adv
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
To: gregkh@suse.de, b.a.t.m.a.n@lists.open-mesh.net

--nextPart2991219.jxXPom7Qux
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

we've tried to fix the outstanding problem regarding the sysfs filesystem a=
nd
fixed some further smaller problems. I hope that it is right were we put th=
e=20
ABI documentation.

Linus L=FCssing (1):
      Staging: batman-adv: Adding netfilter-bridge hooks

Marek Lindner (4):
      Staging: batman-adv: remove redundant struct declaration
      Staging: batman-adv: fix rogue packets on shutdown
      Staging: batman-adv: convert all sysfs files to single value files
      Documentation: ABI: Add information about batman-adv sysfs entries

Sven Eckelmann (5):
      Staging: batman-adv: Call unregister_netdev on failures to get rtnl l=
ock
      Staging: batman-adv: Don't call free_netdev twice
      Staging: batman-adv: Move device for icmp injection to debugfs
      Staging: batman-adv: Move tables from sysfs to debugfs
      Staging: batman-adv: Don't allocate icmp packet with GFP_KERNEL

Best regards,
	Sven

--nextPart2991219.jxXPom7Qux
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL9+dOAAoJEF2HCgfBJntGWZ8P/3BJGdpFiFCvkkY5yTf5iK3O
w9Pq0hhgHIvjenDeKwjjJG9Ps5rZ7fcn5lQpkHl+7VVocysE2f2+7oAwiLAKCTwM
8udgxgVxJMIf7Yj3GJmkqHzdv+MbZhvBLb7EJzESNxNTQOrprEQntOAzzZvi7kIY
5DHkaQfiAIX0gswYE9oDfcFeX+6ozv7ZLFfd5uEhhxAHimHGTqn59xTHYfNThz8z
5LRxLMDxk71H7828V1jqXG+AJzbMtCivxKiTvOMtRbX193zoTeB1lD9lyuiSEBYR
JcG5I5aN8OclqVOFOJq4/VclF+IDUSFX8ATNXrAHnu2HNGFj1pw6/wXEhBZ5y64R
P9AoY3vzLyLzpWGf9Wc0hmiR/tFW/m4AUrefXMOAVJEuD9AigV/zayiIVJkXcPbT
AwwMEcbDnOmoaPRcJXV1YIOebAtGPUWZ+tKIAz/9ZvGEzfRBqaPo4vZ55+hx9tSX
SPnV5RtIjvaHbCm48snlq87hiwnlbhs+IyqmP1GiLVLUP6TdAHAi5ZV0Q/c8ku+u
VaU4PJGHuwYod4OXSK03pYzQ3sQqSoZe7KbSCunfX2GewxPA9JrpbCy1N0Uh6E04
6BBpuwdcEVaUkwUJQmEhq1vTHVT1AiPbqpFlV5NdTnq14kFn1t8Ir0/bTuQjw6eT
ogpi7yeNLb6p0ALz3ixp
=z4uR
-----END PGP SIGNATURE-----

--nextPart2991219.jxXPom7Qux--
