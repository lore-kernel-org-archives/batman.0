Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 20 Mar 2016 17:57:05 +0800
Message-ID: <2644691.zSgtM82fcN@voltaire>
In-Reply-To: <1456505773-1059-1-git-send-email-sven@narfation.org>
References: <b.a.t.m.a.n@lists.open-mesh.org>
 <1456505773-1059-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart21460134.IlOklcCjW0";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Check skb size before using
	encapsulated ETH+VLAN header
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

--nextPart21460134.IlOklcCjW0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, February 26, 2016 17:56:13 Sven Eckelmann wrote:
> The encapsulated ethernet and VLAN header may be outside the received
> ethernet frame. Thus the skb buffer size has to be checked before it can be
> parsed to find out if it encapsulates another batman-adv packet.
> 
> Fixes: 48628bb9419f ("batman-adv: softif bridge loop avoidance")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/soft-interface.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied in revision 7d2f8a7.

Thanks,
Marek

--nextPart21460134.IlOklcCjW0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW7nPxAAoJEFNVTo/uthzAGv8IAKwHX9eVZmacZnoZ7ZWNFMCu
/rFE476pD3lJ+2tvyA47feuUE1lQV78nQBc3+LsGL3i1wckNreLvvqsUos5EGBc5
9Cvo3Dn3Xj/V9LSp05NFWKV5QOzta3LmF/aEEyr+XgbUMsZKBDxLzX6MdSUTX5wh
KF3WSsll6ZHiRg0eiy7e3QPJYrdRxxEuj7FJGIy6kj15nkJbBWxB24Pce82jbWfa
vB/awtXkUItpPKLY6bE6OScCNgGu9yNwTJ8hLjQj+nVDcihJDYVo5yPfWuRSEloV
pJMyTTi35Wbtt+8EuKIWd4DLjkKz8nXyTf7Ipga/tFpWkP6iTaz9WHBuQWcMSgY=
=SkkR
-----END PGP SIGNATURE-----

--nextPart21460134.IlOklcCjW0--

