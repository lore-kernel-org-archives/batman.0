Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Jan 2016 16:39:38 +0800
Message-ID: <8047297.0qIFjkW2bL@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart290606756.odWmVZydO0";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: [B.A.T.M.A.N.] B.A.T.M.A.N. V leaves the nest v2
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart290606756.odWmVZydO0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

after several rounds of code & documentation reviews a number of improvements 
found their way into the patchset. The changelog is as follows:

v2:

 - rebroadcast packet immediately after best neighbor timeout
 - add a flag to avoid forwarding the same OGMs multiple times
 - move TVLV processing out of update_route() and into 
batadv_v_ogm_process_per_outif()
 - code comments improvements (typ0s, clarifications, etc)
 - mark OGM packet as new when protection window is started
 - remove redundant throughput checks
 - simplify/fix best neighbor check


Happy routing,
The B.A.T.M.A.N. team

--nextPart290606756.odWmVZydO0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmgHKAAoJEFNVTo/uthzAKTcIAIC07GRHtisQ9eQPhnuKBM95
QXJ3JpzAn8myXZLONfH9WKJkfXrx9HBkNtNK0BBI4uvKUJH+qUkhcQCo5HXaEEFf
bz9CFferc8xBSd4aU+BlSDxGQaYClaShAL1UyngnZ6WlXGKgJbxwsBiyx4lEPmU6
4+9lT3um1PTjepgXboH4TOfVib6I+Z9NWspPz484zLiZQ1NESJTxuenSBNMFMPyA
tiGOfsjcNTs78tQAoFjEOVl+lF+goM3RUizCLAtfG/BZdvWM+U1AJ4nlLeb5cV2K
hD6gfuAr7f66wFixOkQOP5uvgrg+qT+NRAlEV/D07DF7TO2ZGu9oBB0OD5RMjZg=
=CWVi
-----END PGP SIGNATURE-----

--nextPart290606756.odWmVZydO0--

