Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 18 Jul 2016 12:11:13 +0200
Message-ID: <6098496.c9QsHxvAun@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1540179.J5x7uq34aL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] [PATCH v11 00/11] batctl: netns and netlink support
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

--nextPart1540179.J5x7uq34aL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

This patchset adds netns/netlink support to batctl. It complements the
batman-adv netns/netlink support v10 from July 3th. This series is an
update from the v10 sent me on July 3th with the following changes:

 * rebased on current master (didn't apply anymore because batman_adv.h
   changes were extracted from batman-adv and these changes collided with the
   patchset)
 * batman_adv.h changes are now separate patches (based on batman-adv patches)
 * asprintf return code is evaluated for systems not initializing *strp

Kind regards,
        Sven
--nextPart1540179.J5x7uq34aL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXjKtBAAoJEF2HCgfBJntGZyEP/1iHQcOxZnSzd6lMq1TwD6hq
Sg/FbzaL3ilZ4SOW5A+yGXTOYGBCH+6c1RZAMcpTW+ndxs72Oaj1rWtOWMbXKLvK
XGNpjHLTvfe1NfruDV4rylpnz0oU1PDk8aXNrUCCZwfFCQ7zSd0t3eWmS6dUQmsu
DiEcASRp/Ia4uI534Q1ZRnwj4yZqZ2qg3Y7trFqFzKsb+Vk17Y/8l0MShRFdZivL
fQgFemNCZJwN6tu1axcNxuFKNtT3y9jg2bGLByaiA4cHf2/hVNNQDrEcLOGMhWh+
5+hxH4hZoEPRx4pztu9+daFHWiNpCLN/fTLKY8XrkeTyGe9vv2+TPY/3DZBzGVVR
4DOcrKeaxGynKWtSOc5QjJiakRSXcqS1eqkRiv4G9sLFGK3A4yfWocY6L1sYh3to
YTt8bjZF50rz7jwvhXVzzZ0QTmY+WdjbDYWOAEzi42s7UjCPFI4z8VSkq5EIwomw
gE/P+uWlXs1/oRy6cgHTJFApxUTwA9+GBZY9vtnydPbhypH1lT6ogNthOq/Lb6RV
K2Ocx7OjCKdqrNf++bCSWjnY5qih7dKV3I0gdabGtAzApZnTN2qZSwUBXL0u18Fh
aI/bhJ26QpKc05VaE6Gu4YpgMCP0haqaKhoBKdOJNthYRr2fLl4bPUv3SCbrruNn
bdP7qU1KhbGpuop0G+Y9
=FgQl
-----END PGP SIGNATURE-----

--nextPart1540179.J5x7uq34aL--

