Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 03 Jun 2016 02:06:10 +0200
Message-ID: <23629568.LZ3uSEMMIu@sven-edge>
In-Reply-To: <20160602230044.GM7555@decadent.org.uk>
References: <20160602230044.GM7555@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10694741.VlV3zT6SNB";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix double-put of vlan object
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart10694741.VlV3zT6SNB
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 03 June 2016 00:00:44 Ben Hutchings wrote:
> Commit a33d970d0b54 "batman-adv: Fix reference counting of vlan object
> for tt_local_entry") makes each batadv_tt_local_entry hold a single
> reference to a batadv_softif_vlan.  In case a new entry cannot be
> added to the hash table, the error path puts the reference, but the
> reference will also now be dropped by batadv_tt_local_entry_release().
> 
> Fixes: a33d970d0b54 ("batman-adv: Fix reference counting of vlan object
> ...") Cc: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> This is untested; I just spotted this apparent oversight while trying
> to backport the previous fix.

Yes, you are completely right. I've missed this line in the error handling 
path for hash_add in batadv_tt_local_add

Acked-by: Sven Eckelmann <sven@narfation.org>

Kind regards,
	Sven
--nextPart10694741.VlV3zT6SNB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXUMnyAAoJEF2HCgfBJntGAU8P/22S/pBCdhuOWxNg/NWcQ3H6
o04B0e2VqPVTAxMSo5jqymwi5ehkqT9aEEcP2S2TSEfRZ2Jj1bKC4nzl/rBwRZNP
9MQFY2+MFJfxtiqcJZqH87pvcpVEjE+Y2pR4HsqggHH/oZhXXo7AU0WI8/Monw40
4YzfJDgV8QwbByAm+QqTOoeIH5mboO/A7d1Ab96i1G3I+WwooG+HmGZsA1q1/COy
nSXAbvu4bLRRYppq+KVtbD0GI7qeUwXsZ1olxRLsWdrxTsVSHoGRQ/D+JEx6T0Wb
C4II90QtmyxIOUCjTcODh5eOUwufL8oYKkuUe1JlD0y4mYLT7WtjVrizvzQe3rM1
sRfKbkx0T9v5SyhkAbXbf5f9thediEIaDVF3YHeYmy6h+v3e8np1L1xFAy8gaa4m
IG8X3J862TppJJ/x6aYWoAGOZOKVybKxl0HCXHTJQtnTx5lYktzOW2V42JR4zCjo
JsHBtxZuRH4roGR+jWx9+LvZy2tYi8CZ95FeCLDsG/RHr1aOyRQVVeXouS1BUM+r
FblNxoSVhJXiy4ZfJ7zGWRkl4CS6ZOPdmtwNy715I6EzhRgBLosGQ7T9a5Z9mbFF
+Zxd1Juy6mXSl2rY5H3tZ/qKXU0hiWSYi9pQShz21Vn3Gca4pyTB2bc756ipYv+e
xcgiibzj/k7Nn40XaHmU
=PMVJ
-----END PGP SIGNATURE-----

--nextPart10694741.VlV3zT6SNB--

