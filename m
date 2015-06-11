Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 11 Jun 2015 19:01:05 +0800
Message-ID: <3429641.2BPuLvbBbi@voltaire>
In-Reply-To: <1434019673-21646-1-git-send-email-sven@narfation.org>
References: <1434019673-21646-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3495621.1TCTEOI48j";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batctl: Replace C99 int types with
	kernel type
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


--nextPart3495621.1TCTEOI48j
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, June 11, 2015 12:47:53 Sven Eckelmann wrote:
> (s|u)(8|16|32|64) are the preferred types in the kernel. The use of the
> standard C99 types u?int(8|16|32|64)_t are objected by some people and even
> checkpatch now warns about using them.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  main.h   |   5 ++
>  packet.h | 204
> +++++++++++++++++++++++++++++++-------------------------------- 2 files
> changed, 107 insertions(+), 102 deletions(-)

Applied in revision 224b5e4.

Thanks,
Marek

--nextPart3495621.1TCTEOI48j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVeWp1AAoJEFNVTo/uthzADEAIAJkgt2MeUKsCQ9PyBpCvzff9
yrx4h7rXbIgv6j125JpO8rdL/D79N0z97zqgF3zw7MNQ4u7H4W4nYYGyxMv2jS1o
Lw6+/TwmcOiiu0EUvhCWU6rHjlxvrXOicuTVM//YqVa9GHa7XqqnwIqcpofQ3NmJ
chuLcDAruPhNy/CwBEUJEgMU+e/x6gSv/LBri3A+6cLjU0YrvVkO+H5SY5kgVirJ
LhDCEbRgHsrNzoKTxUAQiS2tf1grXO/keYDN/dKEivGOmDgT99/KHK5HqiSydyy6
eH4o/rc1F+XrvBvHBdQPoAnvEH25WZfGHwmVQqFERJfdG/Ns0va87M45Bx7BxdA=
=xQd9
-----END PGP SIGNATURE-----

--nextPart3495621.1TCTEOI48j--

