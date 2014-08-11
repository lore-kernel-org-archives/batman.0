Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 11 Aug 2014 12:55 +0800
Message-ID: <5254283.uB3IR0AFsC@diderot>
In-Reply-To: <1406066350-26579-1-git-send-email-sven@narfation.org>
References: <1406066350-26579-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart24272805.RC0gQzmE8u";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Don't use hyphen for parameter
	in manpage
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


--nextPart24272805.RC0gQzmE8u
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 22 July 2014 23:59:10 Sven Eckelmann wrote:
> By default, "-" chars are interpreted as hyphens (U+2010) by groff, not as
> minus signs (U+002D). Since options to programs use minus signs (U+002D),
> this means for example in UTF-8 locales that you cannot cut and paste
> options, nor search for them easily.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  man/batctl.8 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied in revision 263b307.

Thanks,
Marek

--nextPart24272805.RC0gQzmE8u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJT6EykAAoJEFNVTo/uthzACYYIAKabh0es+P7tF21K5zZy4tRA
KIJYPMnk4sJ3h2nI9XJuLbYYfVJTzYUClvbAnJwcTPpibN86ffD+GbZojlaDnq1r
wkuWzEL9dmTCzbcZqhubq3J9t/2UXN3G3m9i7yCyBMv+dF0C/vX+azDx9hjRjzbS
qmhjYIZX0Du39pucitFgkR7PgId4X9OQo1Sze2wEae2pMARXCU/PlXUSldsVmekN
7ksrSlE+oMMJdPreQaBqI3je8CoM+zVpeJ+9Ck1x0G9cN7qKb1w1v+FoBFAw5T34
CBdriRq0DfL6DdXnm3geh/CYSUagO5sfrRd/Qx8ZTOa+xnKBC4k22mkbdr6zqUE=
=j8IE
-----END PGP SIGNATURE-----

--nextPart24272805.RC0gQzmE8u--

