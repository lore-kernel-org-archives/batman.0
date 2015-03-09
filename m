Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 09 Mar 2015 08:28:15 +0800
Message-ID: <9972064.4O5yWsjnv4@voltaire>
In-Reply-To: <1419594103-10928-21-git-send-email-mpa@pengutronix.de>
References: <1419594103-10928-1-git-send-email-mpa@pengutronix.de>
 <1419594103-10928-21-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1805896.h6kWCPVxkU";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 20/26] batman-adv: types,
	Fix comment on bcast_own
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


--nextPart1805896.h6kWCPVxkU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, December 26, 2014 12:41:37 Markus Pargmann wrote:
> batadv_orig_bat_iv->bcast_own is actually not a bitfield, it is an
> array. Adjust the comment accordingly.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---
>  types.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Applied in revision eb923e9 (with the modifications discussed on IRC).

Thanks,
Marek

--nextPart1805896.h6kWCPVxkU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJU/OkfAAoJEFNVTo/uthzA9KsIAIHiwmJNVMNuctJ+eqf6rNaz
vpYkE7u1Qd/oXrdWy4yg5YpK4I2QD2VMAur1iVkKor1fcRJF2z6ddrH0MdJsaz2O
gl9K2JaFDEJP7C4+CV6AIuuAu/m6xtQ7NB4QVwZrnhRhrZqAZi3PPEH3JOqkhyER
tKdiDyE2P+cCayG8qJRgJEWmeN+dVjsb7a3UTlDN0NoBk8eFVPhOFn6Htzk+rF5P
pKnLWd8b1z+AUShCkg0nWPz7Le8XiA+4b+3NH+ZyF+dp4ZBdci9T66NCwJVn9ryZ
hko5c2RE9vdeobTwrimHXLt5NIRdDLZxRwb8mMLMNgRnfprjD6dQmA6dMeyFn7s=
=ALj9
-----END PGP SIGNATURE-----

--nextPart1805896.h6kWCPVxkU--

