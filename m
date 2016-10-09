Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 09 Oct 2016 08:56:44 +0200
Message-ID: <1647833.jYley1tZnH@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5350165.ZNTCPxVL6Y";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH v2 0/11] batman-adv: Support for complex
	compat patches
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

--nextPart5350165.ZNTCPxVL6Y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

some patches (like patch 3+4) require special code modifications that cannot 
be handled (reasonable) with the compat headers. One of these patches (3) is 
already in linux-next and thus should also be in batman-adv.git.

I am proposing in this patchset two different solutions. The first one is the 
easiest and most likely the best for the upcoming release. It uses a simple 
shell script to patch the problematic lines in a copy of the source code. The 
second solution uses parts of the first solution but replaces the simple shell 
script with unified and semantic patch files. Patch 5-11 should therefore be 
used as an example how coccinelle/spatch can be used to clean up some of the 
"interesting" hacks in the compat headers.

Changes in v2:

 - remove second replacement.sh line which basically does nothing
   (thanks Linus)
 - added patch 4 to also mark batadv_netlink_ops as const
 - introduce patch 5-11 to show usage of coccinelle
   (I personally recommend patch 9 to get familiar with the idea)

Kind regards,
	Sven
--nextPart5350165.ZNTCPxVL6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX+eosAAoJEF2HCgfBJntGqZUP/jXoFG4W1D3bjm07U8W/NJwB
kYeyhfA7cIwy8Dqey5uQTre0ry7kGJ2NDsAuH3SdHYVSA0oS0IMIsWtFmtQwIVuE
8esBYxw4ARed1Wn4ab6+DwNeyosDU/bSQZ1B+XX53/Bn3j8/uVrPWs+QseMkxOKh
DpCrXgSXOSKH1MFVouJoV8VPRSfFgSvYdzzCJ3RP3iLG7vxdg7PYlIKFs5mn/TDN
+PolWyWmRJMMZauNIqy9vdZvyHRE/RRAYQ4eFiGh9wjx2T6JJkKGZ5cpFN+WKEWY
PJz4uMj+uxPMZ3xJFFZx0GyCuMgdKeLre+4KoUhyDk6OjJGT+f8QATznv0uAFtql
X4fVghAPR+q7iuxEphtvdlbiGDnua4lmR0Ae9B7+/Psdr/Pw2UXKdydKgT4pilrn
zIQrNhdLY6uOhnmFkt6RcgMn6F4PLxlKfFEQG+yOJ1O5rpGd97WiKX0VPVYihsdy
0/+KLOVUrhKmRhZHB+Z9+fwsojhhGCN8yWDQYNVx7ktWUGP0fJUG1cdFRrmHnvBS
Zleb9DbpXN012cSCLEmpnupnVQfbQCLLOgkYs2RnzsHgCxZxrZSSp/wA8DWCUF50
2r4XHcKp/WEv0hkogl8rbkHsnwQqTxMpe39/rljJxvJdhAvFO79LkNq2N+LYsTdq
lWrpFbZPhHCCXW3G0Aqe
=4EM3
-----END PGP SIGNATURE-----

--nextPart5350165.ZNTCPxVL6Y--

