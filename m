Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Wed, 10 Feb 2016 19:04:33 +0800
Message-ID: <1800749.IPEkk1fdTQ@voltaire>
In-Reply-To: <1454336498-2621-2-git-send-email-sw@simonwunderlich.de>
References: <1454336498-2621-1-git-send-email-sw@simonwunderlich.de>
 <1454336498-2621-2-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2329489.9FJJ0dg5je";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/2] batman-adv: Merge
	batadv_v_ogm_orig_update into batadv_v_ogm_route_update
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
Cc: Simon Wunderlich <simon@open-mesh.com>

--nextPart2329489.9FJJ0dg5je
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, February 01, 2016 15:21:38 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> Since batadv_v_ogm_orig_update() was only called from one place and the
> calling function became very short, merge these two functions together.
> 
> This should also reflect the protocol description of B.A.T.M.A.N. V
> better.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  net/batman-adv/bat_v_ogm.c | 117
> ++++++++++++++++++--------------------------- 1 file changed, 46
> insertions(+), 71 deletions(-)

Applied in revision 507dba0.

Thanks,
Marek

--nextPart2329489.9FJJ0dg5je
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWuxlBAAoJEFNVTo/uthzAIb0H/Rc5HlyqhII11MHG/CUlHm4T
NVnS1ZCNT6I4KHld8eCvJZvPD0f6BoiTvvaygc9/0dmn6oDmBNtr+vjglY5SkStG
wTROmQLvEoCUe6n4OIBozg9V4RZDpJ027hk8HkaN63uhtUjH8aOs3eKOj6LEs2iR
CdhttXvsj7Rekz07rrcWbwIhjgy9qhOGRf/6ZpQfBVDPtla3Ir+0LC22jTn/5fKg
igOsbAWfwV7eYxSBHdHhvY0eX7OnsmExkERB3JbicNvlx6x17e3zu+/9HlojzxvI
yKYfw2PDD33ZmIlMU0ydXJt6BFym/pvmNNDDISIvF8rEvqoEizKmB+Ou01L95Fc=
=g8ys
-----END PGP SIGNATURE-----

--nextPart2329489.9FJJ0dg5je--

