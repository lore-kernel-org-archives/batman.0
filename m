Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 21 Apr 2015 17:01:25 +0800
Message-ID: <4169825.U60o6nN43M@voltaire>
In-Reply-To: <1524181.VdC0CvID4i@sven-edge>
References: <1429292430-30883-1-git-send-email-sven@narfation.org>
 <2239102.H9P5JOuLU8@voltaire> <1524181.VdC0CvID4i@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3783903.H3NNgmO6QD";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 4/4] batman-adv: Automatically create
	nested kfree_rcu helper functions
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


--nextPart3783903.H3NNgmO6QD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, April 21, 2015 08:35:37 Sven Eckelmann wrote:
> > >  4 files changed, 15 insertions(+), 141 deletions(-)
> > >  delete mode 100644 compat.c
> >
> > 
> >
> > Applied in revision 082c888.
> 
> The commit is also not the patch I've send you. compat-includes/ is also 
> missing in this commit.

Thanks for letting me know! Should be fixed now.

Cheers,
Marek

--nextPart3783903.H3NNgmO6QD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNhHlAAoJEFNVTo/uthzA4MUIAJKWeWGm1iE5IreRaj7IGgMB
pzn/oA4LzxfDdOcp7TdGKl7qMj1Rwj2QbuPg5ThrYaFsf9fdk48FR04ZyC9Eu5gU
O/2QgpJ9qE8XfwzYSqwcsIOO83Wqq3AbJx+JaBl+rVRBevkdfm5WrMEOFrK8WSvz
e2EQ8PkeRZUcem/N6yUrAbtyGlbkXsvf64YGSvlc2/Q0iYq2RZtIqmHkkCaOL+zw
x1x//aXIvJpUHmo2BUx4CWTNWkg+oX/NJVGbtfTeLHN2uhCMd9zlsL8Zja+in3jP
M6ycngM0QEZNq+zgLjSwUnFoglvcm9AWYC7wx4LnXH8VkaChJBaY4Bjk5R5DytM=
=7BMe
-----END PGP SIGNATURE-----

--nextPart3783903.H3NNgmO6QD--

