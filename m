Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 22 Jul 2016 17:07:18 +0800
Message-ID: <2848693.fKv0fopr4v@voltaire>
In-Reply-To: <1468836728-21890-9-git-send-email-sven@narfation.org>
References: <6098496.c9QsHxvAun@sven-edge>
 <1468836728-21890-9-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart734590667.ZRhmrNKvOa";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v11 09/11] batctl: Translate mac
	addresses via netlink
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

--nextPart734590667.ZRhmrNKvOa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, July 18, 2016 12:12:06 Sven Eckelmann wrote:
> The debugfs entries are only available on the main network namespace. All
> other network namespaces have to fall back to netlink to read the global
> translation table.
> 
> batctl has therefore try to access the translation table via netlink and
> try to fall back to the debugfs table in case the batman-adv module doesn't
> support BATADV_CMD_GET_TRANSTABLE_GLOBAL.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  functions.c |   6 +-
>  netlink.c   | 185
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> netlink.h   |   5 ++
>  3 files changed, 195 insertions(+), 1 deletion(-)

Applied in revision c2eb7a6.

Thanks,
Marek

--nextPart734590667.ZRhmrNKvOa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXkeJGAAoJEFNVTo/uthzAaZUH/1FVPnHrHVolkymEfAyde34p
FYl0UKxzMWoC//M79wfXmyhtGtW266XB1fO5XubHYd8dx2o3f9RHiaUlVW5qsHY9
pfA2JQ8ALN6PDwuMpZMX2hKKfmrRvyDp80nddCmguaJJI3m4iuELDWCNzhNnv6Kw
Q0wN99oAJLHvUvtkQ5EypUQBTQLO8MtLK3I9fSuYF6TCNW2k6A+X3/Z+bxVdRdTv
sd7wvD5ARn1vE6knklmYG94WU88wkz3XZHsxwJe1WpI0LHtpW813PEemFyfKASrF
7CzOe4az1h5VF6cDyX86hz1iteKmHIwTTrRSaO7kvlRvfZEdQod4Vfnh21Ix4O4=
=dIGU
-----END PGP SIGNATURE-----

--nextPart734590667.ZRhmrNKvOa--

