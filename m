Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:09:50 +0800
Message-ID: <6770671.XCzjMospWl@voltaire>
In-Reply-To: <1468597173-25378-4-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5401899.TzgHKSfp9S";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 04/18] batman-adv: Place kref_get for
	neigh_ifinfo near use
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

--nextPart5401899.TzgHKSfp9S
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:19 Sven Eckelmann wrote:
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
>  net/batman-adv/originator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision ecd3e3d.

Thanks,
Marek

--nextPart5401899.TzgHKSfp9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjeBOAAoJEFNVTo/uthzAteMH/i0vp4QKKljozv7AgEavAXqT
HVnUSEjXULS7I3/od5XlqVYoTzNQvhLqiaJTWs+mDz5CDVPLa1qexlFseU7Pv8J7
SXjfyXUtd7nDMWx4zvWePAtlBJ97vn8RGVM8KzCQQvcXf/EfG/YNmHXHGXhiwEHI
TZ7YyKY9cnd5/ZIlmN6D1KuAdx8F/82u1BfEq5tkxm57jaD4UpxXhkTSOWR2fWkY
d7o2yPSUqzeGeL9xNV3Vww6KoOhs0wsdtyCEyXfVxkwsb90LodtQasWnHTKMWgsA
6OBy6uQVhyjmPWiiQkSmRzTIC7+cRQTwbTa22+NuTM5cZwPAqmXcHw9mbhHaWmw=
=U9g8
-----END PGP SIGNATURE-----

--nextPart5401899.TzgHKSfp9S--

