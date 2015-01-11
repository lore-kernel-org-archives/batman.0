Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 11 Jan 2015 20:40:21 +0800
Message-ID: <6610931.d4Wk8W40ou@diderot>
In-Reply-To: <1419594103-10928-7-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-7-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5264610.fU94MCGNTh";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 06/26] batman-adv: tvlv realloc,
	move error handling into if block
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
Cc: Sven Eckelmann <sven@narfation.org>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart5264610.fU94MCGNTh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 26 December 2014 12:41:23 Markus Pargmann wrote:
> Instead of hiding the normal function flow inside an if block, we should
> just put the error handling into the if block.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  main.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Applied in revision 9aef872.

Thanks,
Marek

--nextPart5264610.fU94MCGNTh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUsm81AAoJEFNVTo/uthzAWiwIAJIH0st+dROQAYlC4fh40uQS
WjlIBrgIJMZ9AltKZiX1YZBG5ZksU9bVfKHSKTOtvhI7RAfl8ii8vQFQL7xjxIaC
WsM90fOCpk3FJUafuUPtp1dOOrmX3KvQOuCYxYVKQ0qnTowccpfQd4KgiR0L6OLU
xBR4B7SB0wVanQEEBncLMitFMf2CJiCpCVTP7vhGEx9YXjq25CzTha7yHVGPsLie
9/Fr2rOucN2lqhOheO/+kjAj9OnlV77cVPW5v3WoATcn+YNPTDV4fWPLkJ/NUiin
SDTmto6ETIYub3bx0gq0ncv4Pupyq7rhELsvM6onbnLaCmx3xVIsZHp/jjBv9CU=
=7lEu
-----END PGP SIGNATURE-----

--nextPart5264610.fU94MCGNTh--

