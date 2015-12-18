Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 18 Dec 2015 15:27:40 +0100
Message-ID: <85323191.ElJ3MJEYx2@sven-edge>
In-Reply-To: <1955217.rHmPbHNXC9@voltaire>
References: <1449414907-21358-1-git-send-email-sven@narfation.org>
 <1955217.rHmPbHNXC9@voltaire>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2857884.fpGDayDgkI";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Switch to HTTPS version of
	links
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org, Marek Lindner <mareklindner@neomailbox.ch>

--nextPart2857884.fpGDayDgkI
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 18 December 2015 22:25:31 Marek Lindner wrote:
> On Sunday, December 06, 2015 16:15:07 Sven Eckelmann wrote:
> > open-mesh.org and its subdomains can only be accessed via HTTPS. HTTP-only
> > requests are currently redirected automatically to HTTPS but references in
> > the source code should be only https.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > 
> >  Documentation/networking/batman-adv.txt | 2 +-
> >  MAINTAINERS                             | 2 +-
> >  net/batman-adv/Kconfig                  | 2 +-
> >  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> Applied in revision 5fe476a.

Antonio, please don't forget to forward the MAINTAINERS part to the Linux 
kernel. It was not committed to the out-of-tree module repository.

Kind regards,
	Sven
--nextPart2857884.fpGDayDgkI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJWdBfcAAoJEF2HCgfBJntGRfsP/iUY/V4nF/zGU/ApMCc/69F7
Iovs0H6KiwRlQB6qQhsJzLZT/SiH957ksn7sDI4TowbHmVWKJDcgsaPXO4vRjC3+
iP6YIZAIdlU6gECrB9CeHDO1D1k/z/45WiyT928O4l2Jc5QWLfREZUrjrs46tr5K
jiJhiyhveMYRzMPSclntfJ+PFpliD5LdRW60hvkcR6wU5mcar4LJ6+ky7Q4eQEjU
zcgHkKqwg0b1eV7IunenW37FdCaw18O57X7bLHx/zqEy+AKJ8cp+KGKyqldOJmzr
51awkZAK2u0D1uWaToJ6nvj3I6fjmjoTP+qQvRuBrsYqNva6lgtD4KMI3rhLGdjh
UU1CTEsy5KLOgfQvqDVLQiD+iBYGhfzSa7L/FyqaBIDtqUnZjdehqwgl/lZvq4jL
1KYsNLDT8nFgOp2c30xnKs4lnxsc0UQcKDIZauF1+eC0fxK0dlu0Cg2kTDgVwbwD
XVfe/Bf9T8JcS2fMAH9mCdmC12gYtlXWBmJi8LgxGjEPqiM4bcBmm68A/OhiM3Bi
Fb5Ly3c4XtXx70+CiKIWzo5tZJj/oWbMD0gOzLTHYKwnlqzfWHmxGQdvYcqlMz39
OkiNR9NO/QSFeb31ZSSyGqZxzJ071YjBbTSdeC6vDk6vEyXeseTj3hegP+QZxIYi
MQCseb6YrChi60mx2745
=F8fY
-----END PGP SIGNATURE-----

--nextPart2857884.fpGDayDgkI--

