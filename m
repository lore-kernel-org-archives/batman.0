Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 16 Aug 2011 11:47:49 +0200
Message-ID: <2744235.RrtTiUgUxn@sven-laptop.home.narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2278498.fPjyE95hJq";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: [B.A.T.M.A.N.] batman(d|-vis) deprecated by upstream
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
To: Michael Weber <xmw@gentoo.org>, cedk@gentoo.org
Cc: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2278498.fPjyE95hJq
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I just wanted to inform both of you about the upstream state of the batmand
[1] and batman-vis [2].

Marek Lindner stopped to actively maintain batmand a long time ago (my guess
was 2009/2010... after the release of v0.3.2). The maintainer role was vacant
and Elektra Wagenrad tried to be the replacement. Unfortunately, after the
first hype, nothing seemed to be changed from the time were nobody maintained
batmand. No patches were processed and no changes were committed. So parts of
it doesn't build right now and other things don't seem to work as expected.

There are still people which try to create new mesh networks using this
software, but nearly no one from open-mesh has the energy to support them as
most developers switched to batman-adv and batctl. The decision was made to
really say "batmand is deprecated" [3,4] instead of waiting for some fairies
to take over the project. I've already closed the upstream bugtracker and
moved the git repositories [5] in our "obsolete" folder.

The best option for end users is to use a recent kernel with the included
batman-adv (or olsrd [6], babeld, ...). I am personally thinking about
removing the Debian batmand package [7] from all future stable releases, but
have to discuss this with Holger Levsen.

Kind regards,
	Sven

PS: Michael Weber, version 2011.2.0 of batman-adv [8] and batctl [9] were
released [10] some time ago. You may want to update your ebuilds [11,12].
batctl/batman-adv 2011.3.0 will also be released in the coming weeks.
batman-adv 2011.3.0 will be part of linux v3.1 and is "incompatible" with
batctl <=2011.2.0. batctl 2011.3.0 will also include some fixes which make
your sed hacks in src_prepare unnecessary. The compat code in batman-adv for
kernels < 2.6.29 will also be removed.

[1] http://packages.gentoo.org/package/net-misc/batmand
[2] http://packages.gentoo.org/package/net-misc/batman-vis
[3] http://www.open-
mesh.org/wiki/1/BranchesExplained/diff?version=22&version_from=21&commit=View+differences
[4] http://www.open-mesh.org/wiki/open-
mesh/Download/diff?version=55&version_from=54&commit=View+differences
[5] http://git.open-mesh.org/
[6] http://packages.gentoo.org/package/net-misc/olsrd
[7] http://packages.qa.debian.org/b/batmand.html
[8] http://downloads.open-mesh.org/batman/stable/sources/batman-adv/
[9] http://downloads.open-mesh.org/batman/stable/sources/batctl/
[10] http://www.open-mesh.org/wiki/open-mesh/2011-06-19-batman-adv-2011-2-0-release
[11] http://packages.gentoo.org/package/net-misc/batman-adv
[12] http://packages.gentoo.org/package/net-misc/batctl
--nextPart2278498.fPjyE95hJq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOSjzFAAoJEF2HCgfBJntGT08P/134N0M4P0DO1QXbNLv5Ivqt
cPQZbMt+BE4RKK+zNOjbTEqAjNScWW5QXpFudB2pCI7sbytdY75sMRfpSyhGWhw3
iz//3Aqix8kLFZbrHRI7oQPzRN7Fg3F+W4ciYtcpYjKy9VgbECAOng6N5nGhkUvS
zfNVrVVlGb8nVCAOBvVQU2Xp/PUg9GxVSf9L3xjP0bO7zHukq9f0svUr2audAEQw
+UnSFobq/DAQw0MCXmLT8+4IbQsIyQOLul7ogxob4YCJp7ikozqeDGixhImkfBiP
CFIjVtrfnctkGGwZyHIaqckZl9BcInsG8yWgiii00JU3b4rKzbpAImlMomc3aadt
w8LdmAQIUe2AExxgMsBsiYMPaAHAi8Gc3TMIftIfNK/rxmYyjFTzw1q7zhWFftb5
xPSEBDQLr25xCuzF2Gd2J7KE64rkKnc1GVLfGYSS79gDbyKTsadRLRyZyREcFZYl
AeU7XSz4xw+8v+3KCRut+QlN7/faDrXELKfpYUDOtp9diklvDwEZnqoQFoLJKcLj
pNXLeSu+12cZ6qUUz8B2haYF8BeYOgivIyDDKZQ984t0yBjriFFxkG7M58XtzcR3
vrnO4xtcGom0CJN5JVJqWoQjFFj6nKaGgGkjkyovpjsbYul8nwsj3a1FcQAGWFQf
SIP7PfQh5wUz84U+6PqZ
=ADhY
-----END PGP SIGNATURE-----

--nextPart2278498.fPjyE95hJq--

