Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Apr 2016 18:24:08 +0800
Message-ID: <1470586.V5OWLOQusS@voltaire>
In-Reply-To: <1457190564-11419-6-git-send-email-sven@narfation.org>
References: <1457190564-11419-1-git-send-email-sven@narfation.org>
 <1457190564-11419-6-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart15056764.nxHajI9gBQ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 6/9] batman-adv: Use kref_get for
	batadv_nc_get_nc_node
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

--nextPart15056764.nxHajI9gBQ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, March 05, 2016 16:09:21 Sven Eckelmann wrote:
> batadv_nc_get_nc_node requires that the caller already has a valid
> reference for orig_neigh_node. It is therefore not possible that it has an
> reference counter of 0 and was still given to this function
> 
> The kref_get function instead WARNs (with debug information) when the
> reference counter would still be 0. This makes a bug in batman-adv better
> visible because kref_get_unless_zero would have ignored this problem.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/network-coding.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

Applied in revision e0fbb37.

Thanks,
Marek

--nextPart15056764.nxHajI9gBQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXC3tIAAoJEFNVTo/uthzAqdIH/1N8su/I3TzqqaE8EGrYFVvm
rKn4gfX76pos64IjI6Lyfj3jJ3uPaHHSfVuOod9b4G7W1PF5kUlU0iRIeHIJyqvq
vzsz4wuJEzgObsOfQhjJi1cWj/ZLsnlI3Kq5xnBwtIQSBaednGaFlAx3AHrMeWD3
8kfyJmlBg2Skki911PgUck6vcOFXbucmpgnvuOXlsgsFJl1FB2KBC9Ex/iAmfHjH
VNW0rnKL66ntas37HF4lOFCD9lKRkdSVIsoNvcGbgVoSF5RcDdemevxFO9K4BNrI
5FUJPesBMxQ+Grs5TD8m+enUpCjRofBp6piFlJzQB1zMxK58lNjPa0y9xQi2fig=
=1nJr
-----END PGP SIGNATURE-----

--nextPart15056764.nxHajI9gBQ--

