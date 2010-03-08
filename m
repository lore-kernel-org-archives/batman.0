Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Mon, 8 Mar 2010 17:23:06 +0100
References: <20100308151244.GA4468@lunn.ch>
	<201003081615.49579.sven.eckelmann@gmx.de>
	<20100308161107.GL6469@bicker>
In-Reply-To: <20100308161107.GL6469@bicker>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1302465.Y0fTrzrNYY";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201003081723.06876.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] FWD: batman: potential null dereference
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
To: Dan Carpenter <error27@gmail.com>
Cc: kernel-janitors@vger.kernel.org, "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart1302465.Y0fTrzrNYY
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dan Carpenter wrote:
[...]
> > It looks a little bit like checked with clang's static analyzer. This
> > analyzer has problems to track constraints at all. This means that it
> > doesn't catch the update_routes constraint "orig_node->router !=3D
> > neigh_node".
> >
> > But I am also not good at tracking that kind of constraints and reported
> > this or a similar "bug" in batmand a while ago.
> >
> > So it is not a real bug, but maybe not easy to read.
>=20
> Yeah.  I see what you mean...

Good. And thanks for the bug report. It is always good that someone looks o=
ver=20
the code :)

Best regards,
	Sven

--nextPart1302465.Y0fTrzrNYY
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJLlSRqAAoJEF2HCgfBJntGpX8P/iFcEdKtce6pG0Qed5CZZW41
3OLi7GihzgOzRpUtcxBkLi4WAo+rU95kQfkct31dhLNv3T/HDf8TecRjv9+g12qI
ZwG0y77rqGR/X+6l/5+vklVz30ucfiVkIy4pkQPqZ30OnJe29LAfFjo9mBwxH5rL
OmJpTdPPwaXnyj1k1jCr7zQi9RojTptGAXnaBSSQUAO3LE/6E3rrp5BV2MLORTmn
bKDE6SzcWnvE4DQVz2ThmcWDodWNo66ULxYVXFsaRRXSrJtvfrenaao/HrM8DpPf
0izE4ddgQhxDwB4k16bwMmOfVHfgJi/geCsQStNqBre72ghW+Qn8KUIhJui17f7i
5VHzVXTfL0VfMrIwhp+bre1yn9Ll+vetQFIVc/g9CoxoO/R6P10TLr7gD14hYvFP
xccOFVAO2Hn2QDOqcwnyAt8RHfgkQPBIentbgQDcJUpM5T7RxJOAEDUQMRpYwRPG
SFPevjAOxumEgeY6edmPW73Oan82dF4oV2LPaNdGww/PuSRGXGGuGCdC0xk232Fb
02SJTwmnKMEAoLSY5p93Ly1hSnPRXAPY1ns1W8xnZZ7zUOJwf/Tozr1xt56ps+Ir
4LAdwZwRNX7L+CD17lFRl+K5NTrKUFUjJsC7C2ijxPnRoFx3QiCf3+ZEz4hXJ3uz
tiVkQcIbb3XX0BOoYe9r
=FI4E
-----END PGP SIGNATURE-----

--nextPart1302465.Y0fTrzrNYY--
