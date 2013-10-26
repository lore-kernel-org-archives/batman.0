Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 26 Oct 2013 22:05:21 +0800
Message-ID: <7905615.ZaMoS6h0AM@diderot>
In-Reply-To: <1381852869-2104-1-git-send-email-sven@narfation.org>
References: <1381852869-2104-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1767692.WjRUmAQo7h";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batctl: Fix static buffer for
	resolved mac adddress
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
Cc: Sven Eckelmann <sven@narfation.org>


--nextPart1767692.WjRUmAQo7h
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 15 October 2013 18:01:08 Sven Eckelmann wrote:
> The resolve_mac_* functions are currently not reentrant-safe because they
> are using ether_aton. Thus all functions returning a mac address in a
> similar way must also ensure that their data is in a statically allocated
> buffer and not on a stack.
> 
> resolve_mac_from_cache did that for the wrong buffer.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  functions.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied in revision ef41a8d.

Thanks,
Marek

--nextPart1767692.WjRUmAQo7h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSa8wlAAoJEFNVTo/uthzAq5kH/3h7dxUTw7tNL2sMinaxNp4i
+wh2JaDquWKpdxPHfHJ+gGUrcNgwh3vc43D4wQbtYT5odwbAqw5/HCxBiBLXlcv9
QjRmsmdLj6t+0ykaSzi7HnmSUijhZWONiszQsLp30qTPlbG9nXNB71kGbY4hJxY8
VQ1C1LV/Yj1zFb/Wc3t/hLd4kEVW/1PmFoHydZoRMb96Z6xX0bC/U73/5we2g/XE
oj6b5cmRF8aaPq4leztxvqKJjv9mWJIzxv8t0In9S3IzV3RJGJHrbMWXF7bF7qhr
4etORBr2hTeBaLSgrjS+l8mLKit7hlVui8pjdxPLi/ki3195phfQIThU1mYWwhE=
=uGTn
-----END PGP SIGNATURE-----

--nextPart1767692.WjRUmAQo7h--

