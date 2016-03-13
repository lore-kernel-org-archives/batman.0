Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 13 Mar 2016 19:48:57 +0100
Message-ID: <3465881.llCNFeNLl4@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3666000.6Br0vFbpJE";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH v3 0/6] batman-adv: Add network name space
	support
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

--nextPart3666000.6Br0vFbpJE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

This patchset makes batman-adv network namespace aware. A soft
interface can be creates in a namespace and hard interfaces added to
it. soft interfaces cannot be moved between name spaces.

The biggest change is to debugfs, which is not natively netns aware,
unlike sysfs which is. A new netns directory has been added and within
that, a directory per network name space which batman is used within.
The changes are backwards compatible, in that interfaces in the global
namespace are not placed into a subdirectory.

v3:

 - Added new system to add patches to the build (in case the build against an
   older kernel is not possible otherwise)
 - Rearranged the retrieval of the link netns
 - Rearranged the retrieval netns id for debugfs
 - Fix header includes
 - Add compat-include for linux/ns_common.h
 - Add compat-patch for netdev->rtnl_link_ops->get_link_net
 - Add compat-patch for net->ns.inum
 - Fix alignment errors

Kind regards,
	Sven
--nextPart3666000.6Br0vFbpJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW5bYZAAoJEF2HCgfBJntG8wQP/RseTR7Y6OujDjHLfEhwaWTl
Hz3wi3cG+/rs3Xk0v8SJAb4vcccf5+D5EMUeJGyX1h+BewG4+Wmb+OW/dzvOox8M
ycqvrVntxCXtpyewDU0VCdf/F+uRm56pjH0kKhQ8hVLqCJOeXLiumU999NeDRJHQ
hFRQhNCeP9UVRGSBUpbpfFObxrOIB7rF1TrBz/i5TsYxSXR0UxDxIcVwu0KNmElH
F7qzwGZ/ukQKeWqrYtY+O8XvdmkBpfOmNMuPM9gP//lwlAGPPray5fLbMtLN8IGQ
106vgGrnsmVGI6zr5UsfVGyAPeC1k5pXSSns/PemOr1RFu4pkUcvy8L183yIpbt2
FZ7LlT+4JkhE3FbNgouAbnttbg5E42qGOqpFIj2ATWwF63Tw+UJybOPv0coptpIN
a0KNhUGdBiLCxQzknTxZ1cnYAFTrBiDpxTzaAi1x/iKimgG5go+12h9Ooqqt1k2F
ACQHAcgrVIPuOn9Q88ThG14EvGw8RmxziRCMbQfsWbi7Kq/AWp4zf/hw1QKZ4F5j
AXAwij02V6g70j+p5dUt/Fam1Z28M0ZR8NwM4W1I33Wi84hgMjnsu4Ucr6tKaAqm
u1hfNHX9NniOlv5rYVJSuLZSLsURJ7yPWblBgSetFJas+sN355b851J/GZxD0LKI
7WRtGKKD2q/l+SuEjxGl
=6dp0
-----END PGP SIGNATURE-----

--nextPart3666000.6Br0vFbpJE--

