Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 13:32:57 +0200
Message-ID: <1902845.IZAkOjBWIK@bentobox>
In-Reply-To: <20160929152258.8217-1-sven.eckelmann@open-mesh.com>
References: <20160929152258.8217-1-sven.eckelmann@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4617183.Ktuhy51H7g";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [maint] batman-adv: Modify neigh_list only with
	rcu-list functions
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

--nextPart4617183.Ktuhy51H7g
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Donnerstag, 29. September 2016 17:22:58 CEST Sven Eckelmann wrote:
> The batadv_hard_iface::neigh_list is accessed via rcu based primitives.
> Thus all operations done on it have to fulfill the requirements by RCU. So
> using non-RCU mechanisms like hlist_add_head is not allowed because it
> misses the barriers required to protect concurrent readers when accessing
> the data behind the pointer.
>=20
> Fixes: fed2826b490c ("batman-adv: add list of unique single hop neighbors
> per hard-interface") Signed-off-by: Sven Eckelmann
> <sven.eckelmann@open-mesh.com>
> Acked-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
> ---
>  net/batman-adv/originator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in 0e384ddb1995ae400766cf33b95537fb115a7800 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/0e384ddb1995ae400766cf3=
3b95537fb115a7800
--nextPart4617183.Ktuhy51H7g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBghpAAoJEF2HCgfBJntGs1wP/2H2rBKl7z05kbFREiH79R6U
QrHE0QHWJhzvWVlJ9zxP+Xilz25GZE5oyobyv1VMr1lOYnzEjVljTm2aXLrWLUTQ
RapyVedmRV6Gft+vhaKvJvyPFacrBq8a9dPA+O8m+PwfYJlv2ubFugvZQxjOXCMe
sj8VpMmj6zFHmYtM5YQIZiVT9fmOHBs7lnIwLcnyKRYHskPax8rZ5FoNImHlRh2b
GdA5+1Uq/KkPrmm3Z4XBsCNzi/6u4JukrNC8TJib2h9RKvwT2Z3XVoQhrC5rZIlu
V04yWPyKWNqQoXG06ysHbvmRDb3W+CJikqB7PpdrwlDir6zusoNtpTaoMFP+T6NK
7QEPSmkkJ1ExOgUI16Y16sGKwwRrtS1+JDpYvBGU/VZnfd9PiqBGdQ0ZnTb7H9Tq
r6KdzFtt7GrD/PkbGu90uBxzRC6N9K8YyK8ggb1OdUfUsOrJp1glYzC8p8/u3X3T
yUHEr/FRrBzZPsiI2qYdBBqIXdTxyVZTvgpxrCaR0NTwZ8a6xnUYrlO6hAIF5aeW
t/RlnVIq6lGSLIwDoOlVNo4Hvl4cfqYaUPXGpqNwOlG5Ziz0pl1Tm8N5myPVe3ef
GMdyvrKQnU3vmZcUFO9modKUFqaTfVPPdyEVHroVfjyVLc1N3QFpH5+RJhKYbbcq
O38uKk8rxQZSm4t4bh98
=J3Ku
-----END PGP SIGNATURE-----

--nextPart4617183.Ktuhy51H7g--

