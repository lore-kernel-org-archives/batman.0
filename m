Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 21 Mar 2014 16:39:04 +0800
Message-ID: <17906872.lVEFMZROIM@diderot>
In-Reply-To: <1395251855-30765-6-git-send-email-antonio@meshcoding.com>
References: <1395251747-27289-1-git-send-email-antonio@meshcoding.com>
 <1395251855-30765-1-git-send-email-antonio@meshcoding.com>
 <1395251855-30765-6-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1482989.dkT16YJbUy";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv4 next 10/11] batman-adv: fix more code
	style
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
Cc: Antonio Quartulli <antonio@meshcoding.com>


--nextPart1482989.dkT16YJbUy
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 19 March 2014 18:57:34 Antonio Quartulli wrote:
> - keep variable declarations in descending line length order
> - use common iteration style pattern when looking up an
>   object
>=20
> Introduced by 86cb16e5ec1e2d75821006e8f4abbec66fb741ac
> ("batman-adv: Add IPv4 link-local/IPv6-ll-all-nodes multicast support=
")
>=20
> Cc: Linux L=FCssing <linus.luessing@web.de>
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  multicast.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Applied in revision 45dab5f.

Thanks,
Marek

--nextPart1482989.dkT16YJbUy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTK/qoAAoJEFNVTo/uthzAJZEH/3G5r/Au65oTe+pqmSLz5mEx
7usPq6zM/Z1sbDknG4oRgfoe3etKl733IT+JL0v3dcdA/xXeE4YFwrEOBiTr80B8
UJ9tHfAThdYDt68HBhBMWe5zaPYMe0LuqGiILZxT4hP0+xppEaLhSIf06BWnh2Ki
wrJWn35ml0tnaR/DM7l35tqPcrjkEBDiy+5s9NKQ1XymgvqtLi9qLVbA4CH8VPZI
gyCOU+AxCRcBFRokpaEc6W88qilF2tsuZOxsd5xuCcPWlTQboFKXH0eGrfomYrZl
2Ps9yu1SjS9MOih2bhSyUGZIR4DOurolLxGxs4gFS6kS5YKCXOuLCWgkQ0Ua2Zc=
=lfFp
-----END PGP SIGNATURE-----

--nextPart1482989.dkT16YJbUy--

