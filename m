Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 19 May 2015 15:14:04 +0200
Message-ID: <2815619.WUHEGcIjkX@prime>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2115356.17dS3XkqRY";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] The Joker attacks
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart2115356.17dS3XkqRY
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

After laying low for quite some time, the Joker finally makes its appearance! 
"The Joker" - a penetration testing and research tool to test security aspects 
of batman-adv networks - was developed by security researchers Pedro Larbig 
and Alexander Oberle at TU Darmstadt (Germany), and we finally got permission 
to release the source code to the public.

The tool currently supports the following tests:

 * Peer/Route flooding: flood fake OGMs
 * Blackhole: announce to neighbors that the best route is via the attacker 
node
 * Loop Forming: create local loops on multi-hop paths
 * Fuzzing: modify packets randomly to create malformed packets

Pedro & Alexander developed the tool in order to facilitate their mesh network 
security research. Their work focuses on B.A.T.M.A.N. Advanced version 
2011.1.0 and concluded that this version was performing pretty well in the 
Peer/Route and fuzzing tests. Albeit not being able to prevent maliciously 
provoked loops/blackholes entirely, B.A.T.M.A.N. Advanced did recover quickly 
when needed, according to their study.

To instigate further interest in mesh network security the 'Joker' code base 
is being published alongside this announcement. Hopefully, the Joker inspires 
security researchers as well as developers to investigate and fix issues in the 
B.A.T.M.A.N. protocol and/or implementation. We will also accept contributions 
for the Joker through the usual channels. Note that the tool does currently 
not work with the more recent versions 2013.4.0 or 2014.4.0 and later - 
patches are welcome.

Happy routing,

The B.A.T.M.A.N. team
--nextPart2115356.17dS3XkqRY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlVbNxwACgkQrzg/fFk7axZGiACfXaSZ+IybJEAo6uIIlbHL/O0Q
+YsAoPIaGTMz7Qj7/ZnNpycFkdvgKH5c
=Nj5u
-----END PGP SIGNATURE-----

--nextPart2115356.17dS3XkqRY--

