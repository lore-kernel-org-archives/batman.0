Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:30:52 +0800
Message-ID: <1771253.6bF21ZQbi3@voltaire>
In-Reply-To: <1468597173-25378-11-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-11-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9125182.T3Qqgd2xb2";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 11/18] batman-adv: Place kref_get for
	dat_entry near use
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

--nextPart9125182.T3Qqgd2xb2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:26 Sven Eckelmann wrote:
> It is hard to understand why the refcnt is increased when it isn't done
> near the actual place the new reference is used. So using kref_get right
> before the place which requires the reference and in the same function
> helps to avoid accidental problems causedy incorrect reference counting.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - split patch based on type
> 
>  net/batman-adv/distributed-arp-table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 22f8257.

Thanks,
Marek

--nextPart9125182.T3Qqgd2xb2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjeU8AAoJEFNVTo/uthzAn58IAKb40DxybwpwZuH6qSwPJ17+
s8DuUdCyDD6ii469wl873W3B0w8Ak9+ikiJXsNv11A/aOD1IeXvQHFAbnJvlBej4
SwDUFH+mRoJhFYKIsLwF7l6M3a6iT2ynDC7NLuxfHxpCp5QFvNq9tnurmsf1XHks
dnSbqQ123w7SlfYCPBdM/ioX1sPhFK3HetrY55yf64da+hEIUMSNJtL1cF+ZqUnH
rTHnDUqfc7FandEstCYyQRdXCAOlWNy0IljN7EV3swNI2E9OJTWBjz61ZWyWQzJN
1gS0j6WpQ4Ogf98m1XXg+65D1BqOIHfpIhDOIcm1UI1WDTDb2ZKxdlyXAlKDVHY=
=fcgG
-----END PGP SIGNATURE-----

--nextPart9125182.T3Qqgd2xb2--

