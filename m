Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 09 Jun 2015 22:30:58 +0800
Message-ID: <1676988.96CjocXmEM@voltaire>
In-Reply-To: <1433059821-8521-1-git-send-email-sven@narfation.org>
References: <1433059821-8521-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2697540.DCGFTdjoA8";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: Fix kerneldoc over 80
	column lines
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


--nextPart2697540.DCGFTdjoA8
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, May 31, 2015 10:10:20 Sven Eckelmann wrote:
> Kerneldoc required single line documentation in the past (before 2009).
> Therefore, the 80 columns limit per line check of checkpatch was disabled
> for kerneldoc. But kerneldoc is not excluded anymore from it and checkpatch
> now enabled the check again.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/icmp_socket.c    | 4 ++--
>  net/batman-adv/network-coding.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Applied in revision 2c236a3.

Thanks,
Marek

--nextPart2697540.DCGFTdjoA8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVdvijAAoJEFNVTo/uthzArt8H/RGZNMClr0U0Wx/JPVz2Ax6z
urId/EY/h1NX6hM2y3Mw9lkuJxREv8LbHcweJk12TK+K7lV7++BdNoElm27wBjJO
nycqw0nVuNC3OCVat8Fsz5pr+oXdFwaVQR36Iq3zQOrTZNDEfZX/Vrx/+4QPfpQz
Old9jedJf39S+ITK70ABV4WnoC4lODsJsxkT+CfY2G2OgGtlQs+xPm/vKnISfo8E
RZkxkQ9MQhM1NwoA3UOG6kEn7yVJK9q8H8r54wIk6aEvqYo87INj9aAw2AUvhq/N
Nnfb9OiU/hLP/P2zL+G/iD1ym/RD1S24O4p9PRQpmC5OYOPjVKAFrJBvx1s7uzk=
=6s1p
-----END PGP SIGNATURE-----

--nextPart2697540.DCGFTdjoA8--

