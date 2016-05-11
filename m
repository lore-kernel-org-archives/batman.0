Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Wed, 11 May 2016 11:34:33 +0200
Message-ID: <2757709.ryloMgzIDh@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13675123.gqnUVY2ShH";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH v8 0/4] batman-adv: throughput meter
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

--nextPart13675123.gqnUVY2ShH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Marek applied some of the netlink patches to get the initial support for a 
netlink family in the kernel. He also started to merge some of the batctl 
patches. These were removed from this patchset.

Antonio also suggested that all *_IFNAME attributes should be limited to 
IFNAMSIZ in userspace. This was adjusted in the policy table of patch "batctl: 
Add attributes/command for BATADV_CMD_GET_MESH_INFO"

Also some conflicts with the current masters of batctl/batman-adv were fixed.

Kind regards,
	Sven
--nextPart13675123.gqnUVY2ShH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMvypAAoJEF2HCgfBJntGqXEQALCBfdKJQCfaBXWiwyrbq5T+
pNgsnZOSJfTWCJW8lTeNci31YW/SBCzAsz5Yt+0Klba/1AEZJ1JcTgO66xr3fTni
zqiPgSJr6q03tBrxdTY6JZw3wBDfJzSvusXFiz1ZQBodoXFXSN9EruLF9s6SLuyU
M2cA5nN8zO9WSQANBbuaC+xcUR+1i8r0tiJ4x9J2WQVKCC8q2ncRWVCwcnSQhG+r
UnyuTG+VXiZ8noc23+wVs3bAztDFikwtp7Eb36s/iTI5v6ckvk0hnpaH/MZgV+io
Lh+EEV7qdImfYARwId+780CLFDOv4Ji6vsaCRhpQPqCNXAbUcQdtkyBa36oY3AoF
kkV6uZlxc+TKtFCAzr51qPFX/kUTSRa2Rf+JLST2XAfylmIROce0SAR3jtbRK5Hd
LHQoqgTtMCwlQWMX682bUrxxVsieb4v4ACRJD3fnzQH1Mae8EAwLmv0oKxk+mcuM
B9ZaBOf05j9kuW74VhpBJ6vM5bdtM2w94ndEZGqRm/wYTCvHU0EsNDANm9tFV4zU
K4XWiehfvt0bqsIVJcL1Z2onZw3jIQuxojWQ8WPd2aGH7Xd5xUPeaYCujDUiFSgZ
xR8bxmjhRR5KVkGhjaakgZciliQOY+rsflwA87wBdk/nmZJTcZAdYO+hMjUI895Z
ACOBd59wnB9/BqHKAnRN
=8vFM
-----END PGP SIGNATURE-----

--nextPart13675123.gqnUVY2ShH--

