Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 10 Mar 2016 20:30:13 +0100
Message-ID: <1655341.WCvHHx7pqD@bentobox>
In-Reply-To: <564EFC67.7050307@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <564EDE1D.7070809@meshcoding.com> <564EFC67.7050307@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6025988.xOaW2VZJs2";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/3] batman-adv: Less function calls in
	batadv_is_ap_isolated() after error detection
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: SF Markus Elfring <elfring@users.sourceforge.net>, kernel-janitors@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>, b.a.t.m.a.n@lists.open-mesh.org, Antonio Quartulli <a@unstable.cc>, Marek Lindner <mareklindner@neomailbox.ch>

--nextPart6025988.xOaW2VZJs2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 20 November 2015 11:56:39 SF Markus Elfring wrote:
> > On top of that, by going through the batman-adv code you might agree
> > that the current style is actually not a bad idea.
> 
> I got the impression that the current Linux coding style convention
> disagrees around the affected jump label selection to some degree,
> doesn't it?

Yes, see "Chapter 7: Centralized exiting of functions". But your patch
doesn't seem to apply anymore. Can you please resent it or mark it
correctly in patchwork [1].

There was also another suggestion in the past:

 * https://patchwork.open-mesh.org/patch/4081/ [2]

I have prepared a overview of functions and their goto's [3] to make
it easier to spot interesting places.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/4724/
    You can find an updated version at
    https://git.open-mesh.org/batman-adv.git/patch/1b79cb12821da928b4cf2d116469dfdcbe66d8cd
[2] Update version:
    https://git.open-mesh.org/batman-adv.git/commit/28578c9dd0e592f1c69c44ab7723021b1e8c5b28
[3] https://git.open-mesh.org/batman-adv.git/blob/783c827d01b3644ac09a0f32fe4a9dfa8d6debd3:/TODO

--nextPart6025988.xOaW2VZJs2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW4ctGAAoJEF2HCgfBJntG5SEP/3HWwvv8rg4/TZNQbl+e0cOZ
DtWBU0ASuQrvM9D6F4zG0e8Dm17I8EWv/2iLSKlL1hCXjBItWeEmAhfDYwjyCP8o
FECxh35HdDC2s8vIu91mTwv97Bj5yNQr0ukMsEZrF5fF6PbWFiH/iI2yCTTOCF36
JvT9GvTCU2yWnXIk0nuOzr7TF6BUmBmyd0TygU7nS8fELuhD908WalGr3OVSj9Vl
PTOkI0nTN3QFKPE7wNox21+ErJ7gdQZMtUVJkouiFn78lX/69PwUta1c8+z9iQ/A
VymjidKPuJOUyvgAu2RtSHi2VjeTyNg2lXZIvpfvCJ+ccMr4BPRlkX67kFoQ8rHv
QJLGN6BwiPrNY65YgcKYQ4mWpprEZMgfxB8ZGvGlJd+NKigvcf8w20S+9TdpaMl2
z+9a+A8KdjTbAEfb+q7GdyUfZI+52kYm0NltYsUfF4w8GEyug3UOam3nohtg48Ye
axaZsfEfxsCi4a8Q4S6CgF4iKX8hkMlkeokeVeLhk/uRrSqkgl9BjrB6PI8noyg/
piluzaPKWpDXMTn25nhxDdwT1jtLIXZyZgODy7V+acWCaKsYnvnx5lfxf0hMPEcH
I6tF0Ob9H6OQMvczOhCpyNomMBqseqLBGYnxaXXiPocFp3lFzo1aMPPhRWL5OTnX
xzgDoaAwu461oDZFIET8
=DCHt
-----END PGP SIGNATURE-----

--nextPart6025988.xOaW2VZJs2--

