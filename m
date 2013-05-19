Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sun, 19 May 2013 12:50:34 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20130519105034.GB16497@pandem0nium>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] Alfred Open Beta
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


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

To those of you who actively follow the recent discussions it may come to no
big surprise that it was decided to remove the vis functionality from the
batman-adv kernel module in a not so distant future (with the next
compatibility bump). There always has been a debate whether or not such
functionality belongs into the kernel or not. The in-kernel solution bears the
disadvantage of being rather inflexible because every change has to go through
the official Linux channels. With the growing interest in flooding the network
with arbitrary data in addition to the visualization data realizing a solution
in user-space became the obvious choice.

A new, more general user-space daemon which takes over the old vis
functionality and much more, called A.L.F.R.E.D. (Almighty Lightweight Fact
Remote Exchange Daemon) came to life. Alfred is capable of distributing
information over your mesh network in a decentralized fashion, for example
graph information for vis, but also any other data which appears to be useful
- like hostnames, phone books, administration information, DNS information,
the local weather forecast, etc while requiring (almost) zero configuration.

As the development on the core functionality has been finished and alfred works
(at least on the developers boxes), we would like to call for an open beta!
There are bleeding edge downloads and an OpenWRT feed available [1]. Please
try alfred and report bugs, send patches and inform us about your experiences.
Alfred will be release along with the next batman-adv release.

Happy routing,

The B.A.T.M.A.N. team

[1] http://www.open-mesh.org/projects/open-mesh/wiki/Alfred#Download

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlGYrnoACgkQrzg/fFk7axZ9NgCgxXBkytzsS+o3fK9h2jsvztZT
FS0AnirzNAXHtBWLKExcl+CVlCBAwN+3
=gD/u
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
