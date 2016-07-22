Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 22 Jul 2016 17:06:31 +0800
Message-ID: <1511394.FBpgSkT0Lv@voltaire>
In-Reply-To: <1468836728-21890-8-git-send-email-sven@narfation.org>
References: <6098496.c9QsHxvAun@sven-edge>
 <1468836728-21890-8-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1655928.pbG5yVkhnA";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v11 08/11] batctl: Split translate_mac
	from debugfs backend
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

--nextPart1655928.pbG5yVkhnA
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, July 18, 2016 12:12:05 Sven Eckelmann wrote:
> The debugfs tables cannot be used by the batctl in network namespaces.
> These have to use netlink. Thus the translate_mac should be less tightly
> linked to the debugfs tables to implement optional netlink support.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  functions.c | 46 +++++++++++++++++++++++++++++++++++-----------
>  functions.h |  3 ++-
>  2 files changed, 37 insertions(+), 12 deletions(-)

Applied in revision c8434de.

Thanks,
Marek

--nextPart1655928.pbG5yVkhnA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXkeIXAAoJEFNVTo/uthzA+EcH/i6+f1tT3IbtGSgdg09TaImM
tIsy7xfbkbHY7QxIf0g6J4Pk5df6mMjx2KIPkZKiejUs+Y9waXXaWUHKQO9LdiRi
HD1G0EQAkjXjfhdRl4Wha17x6mijMHH7sFJuxl/qVIa8HSGb/SE71ipZc3Z/QyUF
hAvc9OQoVVZmMEtiQt7uNVgWlh3PFqeR8hwbaA6WA6GBx5XiCBICq4RXfGp4E0eW
onvaZyj70yWjO09a2K5KQIGavliZQUUSZ7HjbMunluKuoLZUBRXoKV+VRLX7YvNj
mpSJEI/DzTpr/oUOyIyV+4FizGSQhSuz2yQZ+y2Twd/fP6CCalOHbEPTEifZKjI=
=8L+t
-----END PGP SIGNATURE-----

--nextPart1655928.pbG5yVkhnA--

