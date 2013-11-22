Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 23 Nov 2013 01:30:25 +0800
Message-ID: <30784685.pbnSSedVYW@diderot>
In-Reply-To: <1385123427-15460-4-git-send-email-sw@simonwunderlich.de>
References: <1385123427-15460-1-git-send-email-sw@simonwunderlich.de>
 <1385123427-15460-4-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1682724.FflnZrKkug";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: fix sparse warning in
	batadv_iv_ogm_process_per_outif
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
Cc: Simon Wunderlich <simon@open-mesh.com>


--nextPart1682724.FflnZrKkug
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 22 November 2013 13:30:27 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> The orig_node_tmp variable is not needed anymore, and spare complains
> about that. Remove it.
> 
> This variable was used for line length reasons and usage was removed
> in de6bcc76ea84fecb136f8c8f5ba1862e4a13f06b ("batman-adv: split out
> router from orig_node")
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  bat_iv_ogm.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied in revision 930c3b9.

Thanks,
Marek

--nextPart1682724.FflnZrKkug
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSj5SxAAoJEFNVTo/uthzA3cIIAJ1tAfh9g0hgQXjKqAmcFig3
htPA1Zf8sEzRzkpDz+/WEfd4rgLopTwYrMx+MIuqUXztCPOUMOdELG1AAa2Q9NS5
DGWu5QnnPoHoxKX0YeWfiebxLtRvsTPEUt/fEIn7lubFyc5VGNHrd5DcfHX1N7Ml
OfG9OAFCz9eafXqDlyqrQ7nBdQDFR6J0+D6UtyhY3Byj81KSNAPTn0JCXDJ9lGlM
Nhzo7QJYQxJp2O+SP4rRm6bxXTn1fokZBsvCZ6GL/kiXIxFyZve5Rnv5bE15bmzH
83eRPKp9yEsXT2mozuqwYa9+8UrfoO7cqqAzkPZoixN33aelphzYltqEHBi0PGQ=
=fI3O
-----END PGP SIGNATURE-----

--nextPart1682724.FflnZrKkug--

