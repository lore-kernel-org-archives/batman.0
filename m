Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sat, 04 Mar 2017 16:32:23 +0100
Message-ID: <13175888.lmslI35NF1@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2632178.PuzgCAmdEp";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH maint 0/3] batman-adv: 2017.0 bugfixes
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

--nextPart2632178.PuzgCAmdEp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

here are some patches which are for maint. These address different
bugs [1,2,3]. The last fragmentation patch is already part of master. But
Martin Weinelt and Matthias Schiffer identified it as a bugfix for a problem
of Freifunk Darmstadt. The commit message of this change was therefore
rewritten to also explain that it fixes this problem.

Kind regards,
	Sven


[1] https://www.open-mesh.org/issues/326
[2] https://www.open-mesh.org/issues/327
[3] https://www.open-mesh.org/issues/328

Johannes Berg (1):
  batman-adv: average: change to declare precision, not factor

Sven Eckelmann (2):
  batman-adv: Keep fragments equally sized
  batman-adv: Initialize gw sel_class via batadv_algo

 compat-include/linux/average.h  | 67 +++++++++++++++++++++++++++--------------
 net/batman-adv/bat_iv_ogm.c     | 11 +++++++
 net/batman-adv/bat_v.c          | 14 +++++++--
 net/batman-adv/fragmentation.c  | 20 +++++++-----
 net/batman-adv/gateway_common.c |  5 +++
 net/batman-adv/soft-interface.c |  1 -
 net/batman-adv/types.h          |  4 ++-
 7 files changed, 87 insertions(+), 35 deletions(-)
--nextPart2632178.PuzgCAmdEp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAli63gcACgkQXYcKB8Em
e0bTgw/+NNGhcGBpXw8QJ/m7P9vN4LMSKWteR5PImq02hsEftJqrazojQp3+bZ7v
v+iGJYfhWaoJ5hQ+X//2peBX2P432pHn7Dc1DC+gHa8RqV2Cf90GLRTFO2Ok5I3l
O8ypw22ZgoER0AmsmWO85hBG0P3mvhr60F4ivNW2X0bfeTGZQhCEJJ0LLEhQLHH2
Iv2fWAPrCHblu2jl/SM0oI/m2n4Pr+YuxpTK8pxi9UhXJcAL4I+THREUKneKDQIg
6LrlYbSC59mir7gKZpT9Wg46FaLQOzj6Yaj9J9vIKv4xJCQOVg5oM7ij6DAJPy9n
5GwtV711CyS7j+4qu9wyKlnGt50YGQHNCBhYbTE5uMmuFOBwaKiW9s8N7o4FROXt
tZ/j2SfsH93CMSVpChdumsDmCMVddANOfxD8jc1HVoKGoPUBF4acQU8DPkzi8idP
uKElpf86jMx42RiAVN2wTDjmd6/BGwUGDPTXAwKZINQg2aqT3rzbl8SgfdNTXQlz
K1+fSErq2z/xJHU6iNN8D6dALeT5KBhdD5AVM1mWOIxtGAXNJSQaZRUhc0tL/0oE
yp4Lya5VUoJaJpgH84InVO5F4zKZZlh8AgNonHxaO1qTtP4NhIyRKQfwn1KM13N4
gkvZHPTCzUs0+Yf/nvqyfbD3bKV5BSiuqiwYoo3qEg+milT1eWQ=
=lkZo
-----END PGP SIGNATURE-----

--nextPart2632178.PuzgCAmdEp--

