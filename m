Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 14 Oct 2013 21:20:38 +0800
Message-ID: <2870112.LGk05b1ysp@diderot>
In-Reply-To: <1381625420-4062-3-git-send-email-antonio@meshcoding.com>
References: <1381625420-4062-1-git-send-email-antonio@meshcoding.com>
 <1381625420-4062-3-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1545536.bfbYqpXzeE";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 2/4] batman-adv: invoke
	dev_get_by_index() outside of is_wifi_iface()
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
Cc: Antonio Quartulli <antonio@open-mesh.com>, Antonio Quartulli <antonio@meshcoding.com>


--nextPart1545536.bfbYqpXzeE
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday 13 October 2013 02:50:18 Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@open-mesh.com>
> 
> Upcoming changes need to perform other checks on the
> incoming net_device struct.
> 
> To avoid performing dev_get_by_index() for each and every
> check, it is better to move it outside of is_wifi_iface()
> and search the netdev object once only.
> 
> Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
> ---
>  hard-interface.c    | 31 +++----------------------------
>  hard-interface.h    |  1 -
>  translation-table.c |  8 +++++++-
>  3 files changed, 10 insertions(+), 30 deletions(-)

Applied in revision f7391e9.

Thanks,
Marek

--nextPart1545536.bfbYqpXzeE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJSW++yAAoJEFNVTo/uthzAk40H/jcVq1Du3kYIuQ7YvGwdEkc5
gMEPPsDhhrSzKbDOyCZXXd603FSuWbs4J7iQgcqmdtZQZGpm4wLTV3RTg0ZRIF9o
d7yqqel8lqPa04doKCvTfLscXWtZ8B6/pEeOFG/nftkhASHwsU+JnJ8J0LlZspIf
HVPyKye5JUVOQ6I81+U0w7HNH/TCKoakGkBp5/UKgzhWuiJCTj38YAaSallQGgJV
34UHErRlNyIkUQtQkE9MScNzPE9xg3zYSyR6ru2NyW2iLSpz3iPwKbBbJk8J1p7V
bOdSpLys7q1gu9ogPYEm4TOSvvde+u+EN9Pc1iq0mIOeB0gq7x6XMESfWmf0W0g=
=nqbv
-----END PGP SIGNATURE-----

--nextPart1545536.bfbYqpXzeE--

