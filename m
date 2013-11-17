Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 17 Nov 2013 11:32:33 +0800
Message-ID: <2117201.lOdXSplxnP@diderot>
In-Reply-To: <1384599832-3959-4-git-send-email-antonio@meshcoding.com>
References: <1384599832-3959-1-git-send-email-antonio@meshcoding.com>
 <1384599832-3959-4-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7516515.5BLvqmkGUv";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 3/6] batman-adv: print the new
	BATADV_TT_CLIENT_ISOLA flag
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart7516515.5BLvqmkGUv
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday 16 November 2013 12:03:49 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Print the new BATADV_TT_CLIENT_ISOLA flag properly in the
> Local and Global Translation Table output.
> 
> The character 'I' is used in the flags column to indicate
> that the entry is marked as isolated.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  translation-table.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Applied in revision febf510.

Thanks,
Marek

--nextPart7516515.5BLvqmkGUv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSiDjRAAoJEFNVTo/uthzAqFwH/iY2wWrlXn8WgcuCpIH/ujGD
gFuX87/xe9sQghENP6ZL3huj/ped0tCJ1LY0ZeXVeCTRQvT7tsPlWI+1RlZqbyyL
9MFy/T2oZvQxCDnszv02KoZrcKkEk8TKnr44eUrVMnS1//s/UKqeKMB65f7m0Jv5
g5eetaxXw9L78SRLVNUXBC18HSKQoGYJ1DCELOlAr2j2KcXQmb1ZnEdK5PuEbVyK
VrHX9BOkv20Xln51Vzu8wrgSIN/jZyTWAaUn6zpTuSY5W4xcB4ZVFwqLzt+S1kwg
ZRoPCzoRFGeez1phrBqSpqeJkIggmfavKzCsdimcMHlC9gfSZ/goiO1L9lG3Xnk=
=BvIW
-----END PGP SIGNATURE-----

--nextPart7516515.5BLvqmkGUv--

