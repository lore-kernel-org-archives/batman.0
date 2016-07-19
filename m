Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 16:44:13 +0800
Message-ID: <2691799.8DyBiIpzMl@voltaire>
In-Reply-To: <1468597173-25378-16-git-send-email-sven@narfation.org>
References: <1468597173-25378-1-git-send-email-sven@narfation.org>
 <1468597173-25378-16-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4259206.5yA48kCFzT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 16/18] batman-adv: Place kref_get for
	nc_path near use
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

--nextPart4259206.5yA48kCFzT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, July 15, 2016 17:39:31 Sven Eckelmann wrote:
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
>  net/batman-adv/network-coding.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 8427a98.

Thanks,
Marek

--nextPart4259206.5yA48kCFzT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjehdAAoJEFNVTo/uthzA214H/iyC/27kaqw/paS7rEGwVTWV
Ucx0TT3NlsILryclQIeYptDlth+u0CjA8uSf469Kk6/xQqgeeqKweuk6Yoeh/8Rg
RC2KQgyc+/ftw+SugPSwNTD2xKGAgVpUM5XQJ+fBHbNLuW46yGzFCIgUQO2wgyf+
n9uxh1h7osZlK/G4UJB0JJDz5FDE8M6t0V2G1cf0qISWhTxdwlgAc/B3XVyJBqoc
SuR3Z7DexFLfW76oWSbvM1bEYfyI1VGiI3cHBMJm66klO+gc5DgwTqj8SGyOphD5
dPafUPSNYkN0z+feWeHad3OHKgUaFc0RCVOC0KzCwZmGhc/sKwLnFfaitf4NEq4=
=UDei
-----END PGP SIGNATURE-----

--nextPart4259206.5yA48kCFzT--

