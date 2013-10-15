Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 15 Oct 2013 22:01:51 +0800
Message-ID: <1453392.LrPeSdtQbS@diderot>
In-Reply-To: <1381832947-25980-1-git-send-email-sven@open-mesh.com>
References: <1381832947-25980-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7238191.RYmTU8jYrO";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Fix warning about comparing
	signed vs. unsigned
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
Cc: Sven Eckelmann <sven@open-mesh.com>


--nextPart7238191.RYmTU8jYrO
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 15 October 2013 12:29:07 Sven Eckelmann wrote:
> The macros NLMSG_OK and NLMSG_NEXT operate on the parameter len as if it
> would be a variable from the type size_t. Using ssize_t (signed size_t) can
> cause warnings about comparing a signed with an unsigned variable.
> 
> It is ok to store the signed len variable in an unsigned variable because an
> check is used to stop processing when it was negative.
> 
> Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
> ---
>  functions.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Applied in revision c1ffa59.

Thanks,
Marek

--nextPart7238191.RYmTU8jYrO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSXUrTAAoJEFNVTo/uthzABl4IALcCjlpLbMbxRe5GuH6EHY5c
Q9+NndKpGv3MvDPdAkqddFyYrkcASo+ER1jzwd16fpiJP7kHEiYI4OfKu54dA5R0
wDIuVjy9gqrS9WswvM9FKoOGZ8TLrtbK435Jj32wzmYYPKtGhhZeEp9vuVyvRL2z
myqIFEjUsAQvya8EMj75Iz7i+Ljj37sKhOhUrx8aIw3uB+BNKxpIdWqj0Aok8Fa8
8UYZ/n1iscNW+gswD+aFc4oQyFxwXACN6o835gat/kaQEE1beYsHCK0Tdzes1xv+
mYJfBLSOHQxWW1/7HwyxmPZ3FJSZXse5I3MGgBqbUruNRlqAin3tbqdJ/43CRpU=
=Qvi1
-----END PGP SIGNATURE-----

--nextPart7238191.RYmTU8jYrO--

