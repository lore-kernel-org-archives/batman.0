Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 06 Sep 2018 19:45:43 +0800
Message-ID: <3845719.Az451rQS5Q@rousseau>
In-Reply-To: <20180812190445.28013-3-sven@narfation.org>
References: <20180812190445.28013-1-sven@narfation.org>
 <20180812190445.28013-3-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2662978.hjRXCKt3YR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/5] batman-adv: Prevent duplicated
 nc_node entry
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--nextPart2662978.hjRXCKt3YR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 13 August 2018 03:04:42 HKT Sven Eckelmann wrote:
> The function batadv_nc_get_nc_node is responsible for adding new nc_nodes
> to the in_coding_list and out_coding_list. It first checks whether the
> entry already is in the list or not. If it is, then the creation of a new
> entry is aborted.
> 
> But the lock for the list is only held when the list is really modified.
> This could lead to duplicated entries because another context could create
> an entry with the same key between the check and the list manipulation.
> 
> The check and the manipulation of the list must therefore be in the same
> locked code section.
> 
> Fixes: 3ed7ada3f0bb ("batman-adv: network coding - detect coding nodes and
> remove these after timeout") Signed-off-by: Sven Eckelmann
> <sven@narfation.org>

Acked-by: Marek Lindner <mareklindner@neomailbox.ch>

Cheers,
Marek

--nextPart2662978.hjRXCKt3YR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAluRE2cACgkQU1VOj+62
HMBcJwf/Qofz9ELPX6UI2yp5OhRZykhXBhpket8twrXgBE590U+ipcBR0QDRdbkc
7pZdcI3o8rKwaOk7/mnxhxyPwkI5D+MaVQRZePLfs8A0djdDWjB+NSfz4LhudNK0
3Q8byl7uOz5mMROvDHs+OA8MDcAA9zlieFmQU4tQf/PzT2N/rMVt802NwrbMjuUf
SHlRY7ZcxmfbnJtbHtEKGe6nAs6tAtZA/pF8NL275pFDEcyzbPIIfAFGCYyux/zP
1BX7vVhg8ISeNijIsm77X+WuGGedixdU9z6IeeZsy4zWVx8BLckvNWQKjDI15ull
BvsVzHvAZNIMQwFBkIYC0de5uk2rAA==
=MPok
-----END PGP SIGNATURE-----

--nextPart2662978.hjRXCKt3YR--



