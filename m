Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 06 Sep 2015 16:18:14 +0800
Message-ID: <2176473.tf5dh2UFb1@voltaire>
In-Reply-To: <1441217396-18043-2-git-send-email-sw@simonwunderlich.de>
References: <1441217396-18043-1-git-send-email-sw@simonwunderlich.de>
 <1441217396-18043-2-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart17805398.IqFV1jBzeP";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-maintv3 1/3] batman-adv: fix speedy join
	for DAT cache replies
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


--nextPart17805398.IqFV1jBzeP
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, September 02, 2015 20:09:54 Simon Wunderlich wrote:
> DAT Cache replies are answered on behalf of other clients which are not
> connected to the answering originator. Therefore, we shouldn't add these
> clients to the answering originators TT table through speed join to
> avoid bogus entries.
> 
> Reported-by: Alessandro Bolletta <alessandro@mediaspot.net>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> Acked-by: Antonio Quartulli <antonio@meshcoding.com>
> 
> ---
> Changes to PATCH:
>  * only allow speedy join for BATADV_P_DATA to avoid adding more
>    corner cases in the future
> ---
>  net/batman-adv/routing.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)

Applied in revision  2decb5f.

Thanks,
Marek

--nextPart17805398.IqFV1jBzeP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJV6/bGAAoJEFNVTo/uthzANPQIAKYbRrXMWK7O5n5KAvHOYxHr
OXBhdfHhZIlze4LnmFZzGFMg3aIxF1wAq0DCwYyrOTnVGz6YX2y+lfydnFyGCS7U
g3UgPjx5z0tA/RALnsJGcVnM+WwazoycDOhhBy0mCiwsYpihIJ/bioXPdhmGX+X2
O+UwbUHVEXJsmwQJ/ez3tKasy6+zM6kh2B3zdTQVvtHoB+8qGLhWxLVBkwOeSYE8
6j/Y8QDNYRcNM3Bw2IodudvzUv47o4/nQow/pajrgO6tm2kczmfSbkAljo68eETF
kOMRrL2umtlpNwqn8m7bWXXd1y2r3mQR0h73l/rzGXyxNmLA8jrsc1TAFCx/lGs=
=3y9W
-----END PGP SIGNATURE-----

--nextPart17805398.IqFV1jBzeP--

