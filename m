Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 20 Feb 2014 18:56:24 +0800
Message-ID: <2473524.Ovb87v20Tu@diderot>
In-Reply-To: <1392625772-1860-1-git-send-email-antonio@meshcoding.com>
References: <1392625772-1860-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12011560.I39xUlKDF3";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv add compat code for
	consume_skb
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


--nextPart12011560.I39xUlKDF3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday 17 February 2014 09:29:32 Antonio Quartulli wrote:
> consume_skb() has been implemented in 2.6.30, therefore some
> some compat code is needed for 2.6.29. This patch adds it.
> 
> Introduced by 9289542085d7e298b90c7b6fb6efb509dab69d8b
> ("batman-adv: free skb on TVLV parsing success")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
>  compat.h | 2 ++
>  1 file changed, 2 insertions(+)

Applied in revision 15fb0fa.

Thanks,
Marek

--nextPart12011560.I39xUlKDF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTBd9bAAoJEFNVTo/uthzA5JgIAJYFKqTtD4dU4R+9uoAbPm90
Th7XEthpKBCwFtYa0CQdB/S6dt/+f9+fkjxQJqcSL04VlGilUpCzen9JtlpTmcZp
k8IZsUGyzkN6wx/Hg59Xrz2Q7ivb2dFxvAzVx7OvIPUyI+3Ydf5FoE7iLPH1B9A/
5Yyi/sV2nnbNtlSA0q7d3bcoVkL1mxuRmCupjtpkJkEc26xD1gWzPo4GIZFMazBv
1x0uOTtkCH2tAqWXq/zij22i/8GrNLBdqRt5CRfWs5c9sUs8bLLNysulyYunizML
4n6xrXCVsTI8IuQHp7SnWtH90LyaWcVbb/KTEjio9yOyVkpI+O+MJnQ+jkM/R80=
=goxs
-----END PGP SIGNATURE-----

--nextPart12011560.I39xUlKDF3--

