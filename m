Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 09 Nov 2014 12:26:23 +0800
Message-ID: <1724452.I9zB3natQA@diderot>
In-Reply-To: <1407932816-19639-1-git-send-email-sw@simonwunderlich.de>
References: <1407932816-19639-1-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2935173.9J0k1ulM9g";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: fix and simplify condition
	when bonding should be used
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


--nextPart2935173.9J0k1ulM9g
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 13 August 2014 14:26:56 Simon Wunderlich wrote:
> The current condition actually does NOT consider bonding when the
> interface the packet came in from is the soft interface, which is the
> opposite of what it should do (and the comment describes). Fix that and
> slightly simplify the condition.
> 
> Reported-by: Ray Gibson <booray@gmail.com>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  routing.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied in revision 47dc789.

Thanks,
Marek

--nextPart2935173.9J0k1ulM9g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABAgAGBQJUXuzyAAoJEFNVTo/uthzA4nwH/iNQseQsD6bE8SrXzOnrXe+I
UaZAUUUfHm6oKNxPa0ygXZgpFBz6GnLcWG2pPHNET5ECAP0vMmsbBlFNcUwqGnei
/Qhxh5My8bFwva2YL8mfr+U+EJ0Xnu2ct0avXEw7THCqIXrbFqTbuzeZC6oI6O6J
tgbATRXug6AmZtWZE6xnKOJ32mXx1VLsKQIJgohpJUF3ghqSpDgx+GeykAg/fg8F
5jq1VlQvfrcynBYZcbFgKwxTxWpWAGEW47Sh4vGIukVH7mx6lZk4CGbgy1tEpFP8
V+ja/EyXt++Cexp50r4pLjktnwHXF9ezkpdR32DSxmGg3B1yiLj6CPEhrKA2UtE=
=UerP
-----END PGP SIGNATURE-----

--nextPart2935173.9J0k1ulM9g--

