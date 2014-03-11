Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 11 Mar 2014 17:55:29 +0800
Message-ID: <5309736.xc4eGd75N6@diderot>
In-Reply-To: <1393420412-3931-1-git-send-email-antonio@meshcoding.com>
References: <1393420412-3931-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart10132721.d7f6VN7xpH";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: use the name of the array
	as pointer
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


--nextPart10132721.d7f6VN7xpH
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 26 February 2014 14:13:32 Antonio Quartulli wrote:
> Introduced by fb4756fe5f6e58ca2ab208ca634ae4c8dd6e9499
> ("batman-adv: use ether_addr_copy instead of memcpy in multicast code")
> 
> Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
> ---
> 
> change from v1:
> - added Signed-off-by clause
> 
>  multicast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision f5129b2.

Thanks,
Marek

--nextPart10132721.d7f6VN7xpH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJTHt2RAAoJEFNVTo/uthzAYxsH/0fsLk8dDCTQSGOGLXc7itLE
XaJmO67s7jQAzgoUlGnKM9j5pBfF+76sfeB68cO8PysV9peAgJ0pEzlLlEe0w1hX
I+Gpk0zbnWjoqnQQMhXLeGuQ1y0FT8BCGWvVIXwSnwNuoIFDEb3fTqOCKHYH7Vmo
MLwEVpMPdpP4HrSNtGotlx0J7u/YfRXXXtTE/cm4txwazSaTKpTUqLxLSz2MA+ih
YL5GBPivlWGHmLq6DTJSNeELjulHgboRMkjWlgy6QSZEZrSxrd8Zmqr32MkwRLXu
E2B6iNotOD7e8YVr+UZwrCk0MmBs2tcmxhtd/0LwDmiG2JmtOIrrBmJvN+vRnPk=
=RXUZ
-----END PGP SIGNATURE-----

--nextPart10132721.d7f6VN7xpH--

