Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Jan 2016 13:25:24 +0800
Message-ID: <2293091.Gz1YCv01K4@voltaire>
In-Reply-To: <1452936598-28619-5-git-send-email-sven@narfation.org>
References: <1452936598-28619-1-git-send-email-sven@narfation.org>
 <1452936598-28619-5-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4200726.Gv7tKCJ0LU";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 05/20] batman-adv: Convert
	batadv_bla_backbone_gw to kref
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

--nextPart4200726.Gv7tKCJ0LU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, January 16, 2016 10:29:43 Sven Eckelmann wrote:
> batman-adv uses a self-written reference implementation which is just based
> on atomic_t. This is less obvious when reading the code than kref and
> therefore increases the change that the reference counting will be missed.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v6:
>  - removed patches which are now applied in the branch next
>  - rebased remaining patches on the patch
>    "batman-adv: Avoid recursive call_rcu for batadv_nc_node" which was
>    modified by Marek while he applied the patches (this unfortunately made
>    some of the remaining patches "hard" to apply)
> v5:
>  - add hack which allows to compile against stable kernel like 3.2.44 which
>    also added the kref_get_unless_zero function
> v4:
>  - fix function names in commit messages
>  - fix double whitespace in batadv_tt_orig_list_entry_release kerneldoc
>  - add extra patch for batadv_claim_free_ref kerneldoc fix
>  - change the phrase "free it" in all *_free_ref/*_put functions to "release
> it" v3:
>  - update copyright year
> v2:
>  - split patchset into fixes and kref migration to make it easier when the
>    decision is made where each patch will be applied
> 
>  net/batman-adv/bridge_loop_avoidance.c | 29 +++++++++++++++++++++++------
>  net/batman-adv/types.h                 |  2 +-
>  2 files changed, 24 insertions(+), 7 deletions(-)

Applied in revision cda4d54.

Thanks,
Marek

--nextPart4200726.Gv7tKCJ0LU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWmyXEAAoJEFNVTo/uthzAqm4IAL7F/LEJxLjscj8idLOFkOTw
koXeGCHmN9K2v+5E0T/diT/lGq+Q67OMmQdY8jQI5E9aylZKG+DFpRxz5K8h1+mK
AdLBLy/w1ZlS2mUBKG4Fbp6Z81duDWCCn6VO0twyQz2NPkX3Ntv3JMz20/sv1+3a
5awnZGZOY5noiaQWKdykoHpRkKjjuPereCqGufcJTkZ9aN4dc3JtKx269pjPHgVa
K37PGjVzge7H3XaHpl6g7R3SaoE0NnO/2OhgR+EexsMy3+MNjgGjMa7p3Cq+4q9N
hc3wGbwPLSl9LKuMT7Ef5aPKl44oL+2ODtjlVLYXe4pW5aNB4o8t0z1GOw0ED5s=
=a9SM
-----END PGP SIGNATURE-----

--nextPart4200726.Gv7tKCJ0LU--

