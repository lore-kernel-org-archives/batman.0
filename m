Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 15 Feb 2012 20:23:21 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20120215192321.GA24703@pandem0nium>
References: <1328727958-16119-1-git-send-email-martin@hundeboll.net>
	<1328885591-10445-1-git-send-email-martin@hundeboll.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <1328885591-10445-1-git-send-email-martin@hundeboll.net>
Subject: Re: [B.A.T.M.A.N.] [RFCv2] batman-adv: Add blocking of one hop OGM
 messages
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Martin,

On Fri, Feb 10, 2012 at 03:53:11PM +0100, Martin Hundeb=C3=B8ll wrote:
>  13 files changed, 491 insertions(+), 0 deletions(-)

please excuse my superficial review, but do we really need to bloat batman-=
adv
by 491 more lines to drop these OGMs? I'm afraid the filter will evolve
more and more, and eventually the research/debugging code in batman-adv
is bigger than the routing code. ;)

(sorry for ranting ;] )

Have you considered using and/or extending the former ebtables patch
=66rom Linus[1]? We removed [2] it after some discussions [3], but maybe
its worth fixing these problems if its just about dropping some neighbors
packets. The patch has some problems, but it was really short and I guess
we wouldn't mind accepting the performance overhead by ebtables for
research/debugging purposes. Plus, we could make this a compile-feature too.

Cheers,
	Simon

[1] http://ftp.uni-kl.de/pub/linux/kernel/people/gregkh/staging/2.6/2.6.35/=
0120-Staging-batman-adv-Adding-netfilter-bridge-hooks.patch
[2] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2010-September/003305=
=2Ehtml
[3] http://lkml.indiana.edu/hypermail/linux/kernel/1008.1/02232.html

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk88BikACgkQrzg/fFk7axamNACgi9M99GJoEprqdOhmpd+Lvqw9
s0gAn2c92q0SsHcRLX2phbljzln0GBAN
=jcvE
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
