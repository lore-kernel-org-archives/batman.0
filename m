Return-Path: <sven.eckelmann@open-mesh.com>
From: Sven Eckelmann <sven.eckelmann@open-mesh.com>
Date: Tue, 17 May 2016 19:31:28 +0200
Message-ID: <3413869.lrcFurLlMu@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2126535.YlNClGtnXl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH v9 0/3] batman-adv: throughput meter
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

--nextPart2126535.YlNClGtnXl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

Antonio was kind enough to provide some feedback about the patchset. I have
taken his suggestion and integrated all of them in the patchset.

batman-adv:

 * rebase on top of current master+"batman-adv: Include main.h in all files"+
   "batman-adv: Keep includes ordered by filename"
 * adjust BATADV_DBG_TP_METER to bit 7 to avoid conflicts with mcast
 * Renamed BATADV_TP_SIGINT to BATADV_TP_REASON_CANCEL
 * Renamed batadv_tp_meter_reason enumerals to BATADV_TP_REASON*
 * Remove unrelated patch chunk in batadv_iv_ogm_orig_add_if
 * Re-add accidentally removed empty line from batadv_recv_my_icmp_packet
 * define BATADV_TP_PLEN via BATADV_TP_PACKET_LEN (increases it to 1476)
 * fixed whitespace problems in compat code
 * remove double "a" in kerneldoc for batadv_tp_meter_reason

batctl:

 * rebase on top of current master
 * added include guards to tp_meter.h
 * imported newest batman_adv.h and packet.h from batman-adv
 * move iw/genl.c functions into own file "genl.c"
 * adjust result handling based on new BATADV_TP_REASON_* names

The patchset lost one patch because it was merged in the meantime.

Kind regards,
	Sven
--nextPart2126535.YlNClGtnXl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXO1VwAAoJEF2HCgfBJntGlhEQAMuvUociH9xeO0/LkjcERXD+
b/bIqKVRQuSk5c41f4swUEU/X1hChpSc3y4yDER0eyYXsFBfOy1Ku4Yhkgw61aYs
hiD5NHgVBVPOjN5xWCtutK+ftHpSTRegU0wGzZ7T+zFa79LjqYMRtsuHkRhBX1xK
6sEAYhGA4C1/XHw9DaKEjQSh99pXw9KKFI16ZheYTZv4V6y9AAfIh20PJUN4NtT1
1rnXKvszQpPf5EQzpQ7w9SIP+a/1W6d9YYk6mGizoO9hFnn7PCcPrVKzCVrKVZfV
qhYm4KIONYpZFjyVz9ECouPeR6S/9kaKKuz1UhiDaqsaDc3Z8aQVZiVMZxy+y2r/
cxilDLY/Hlvky2wga/jcyJYK1/zYeRGQmUO4h75be4vS2Zg6az/dOQYmopyU+OcK
IlP4/aBwPyC7xgpE8sZ7bXBNAs3aFkpbddNS8fh/lJfx8+I//xtYMfKvhUkPb2HD
u99yd0utO9SPKMumN3GhwvnoJm7KruT/ZYmXqBEFO3oo4uE+8jqZn0U/RwmB9Q/R
iKj2rdgAlyDqY1/EnGZTtgeycwr98xYpP5hqnsrLqCGxc076w/ksjrl4Ncs39yf0
HZ540j0Zful5BI+NNqAEML7tqvHPdbIq51JSxX4+7jSbxbQ+96h6xvPm/iqaAJeh
w0Yvq3ewXvRr2sr0QNpb
=Uofc
-----END PGP SIGNATURE-----

--nextPart2126535.YlNClGtnXl--

