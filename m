Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 15 Jul 2016 16:55:56 +0800
Message-ID: <1536065.ecAZSN066e@voltaire>
In-Reply-To: <1467545508-7333-4-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-4-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4785132.sTLmCMfUZ3";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 03/16] batman-adv: netlink: add
	routing_algo query
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

--nextPart4785132.sTLmCMfUZ3
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:35 Sven Eckelmann wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> BATADV_CMD_GET_ROUTING_ALGOS is used to get the list of supported routing
> algorithms.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [sven.eckelmann@open-mesh.com: Reduce the number of changes to
> BATADV_CMD_GET_ROUTING_ALGOS, fix includes]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  compat-include/linux/netlink.h  | 18 +++++++++++
>  include/uapi/linux/batman_adv.h |  2 ++
>  net/batman-adv/bat_algo.c       | 68
> +++++++++++++++++++++++++++++++++++++++++
> net/batman-adv/bat_algo.h       |  3 ++
>  net/batman-adv/netlink.c        |  9 +++++-
>  net/batman-adv/netlink.h        |  3 ++
>  6 files changed, 102 insertions(+), 1 deletion(-)

Applied in revision d632653.

Thanks,
Marek

--nextPart4785132.sTLmCMfUZ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXiKUcAAoJEFNVTo/uthzAIzwH/RL2VqCtgFPsxihyiVHGACnP
wcyonsES8dsorhXIhiPxSfzSZsqZGmWg1dlIHECAmjUGOEAg+0f1iXq6jWfqfD5t
7Te+Y2ckbiR3bCTlu3Ij/JuDPT2oc0i1FfUguF0QpSv6Oc9FdohF4YYOoY8XpJ8w
VMMxBdPa3jvaSwDCS4dCXoMhzBzs6GNitHke8E0ClSH+lZOdP+X3oDBXB6fD+Dwm
tw3+NLMCr6UGAqLW0XBdbI/NoEHnrffaIEfa5QJyp98oFY0SMKMjvQp49vdUlhyG
wl2Ln6HxIWzOS5i0+wOxOdy4pt0RPPsXj+7J7ouTsiJRfNWwbyQpSZesiGPTZFg=
=uTRy
-----END PGP SIGNATURE-----

--nextPart4785132.sTLmCMfUZ3--

