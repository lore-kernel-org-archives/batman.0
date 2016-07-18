Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 18 Jul 2016 10:08:09 +0800
Message-ID: <1860757.yr2NKKrY37@voltaire>
In-Reply-To: <1467545508-7333-8-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-8-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart56494110.K8adIQsycy";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 07/16] batman-adv: netlink: add
	originator and neighbor table queries
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

--nextPart56494110.K8adIQsycy
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:39 Sven Eckelmann wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Add BATADV_CMD_GET_ORIGINATORS and BATADV_CMD_GET_NEIGHBORS commands,
> using handlers bat_orig_dump and bat_neigh_dump in batadv_algo_ops. Will
> always return -EOPNOTSUPP for now, as no implementations exist yet.
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [sven@narfation.org: Rewrite based on new algo_ops structures]
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  include/uapi/linux/batman_adv.h |   4 +
>  net/batman-adv/netlink.c        |  13 ++++
>  net/batman-adv/originator.c     | 160
> ++++++++++++++++++++++++++++++++++++++++
> net/batman-adv/originator.h     |   4 +
>  net/batman-adv/types.h          |   9 +++
>  5 files changed, 190 insertions(+)

Applied in revision c441a84.

Thanks,
Marek

--nextPart56494110.K8adIQsycy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjDoJAAoJEFNVTo/uthzARKEH/i393JrNzFRtJfp2UfuVtgfI
Y9WTWshuHTFjyooTcm/zMwikniEmRPaWpGUPr6y4OGAG5vZCYG06sjqs0aC6+SU6
sJlUMgRRLi28oLWKR0qyJ0YlBo1C1bIxHUHRu8Hr+U0JsVzMFMvA0FQ2de9P4hrw
kXckzf4lYpY8svRZ/XQDeJh7PMVmwhb8pDU/fmbSXvAjyjuzy6/Z57oCZwXjtSZT
vc5oSMW0+UZ1dd9ymylbgQD2egzAvE6INcLvLguZ/hIwdiVavq0Z0aBhuWSO8gDv
RbBRHeAbP7pMkFnQv8Wnhd/kUXuV3zW+PY4lYB5Q6tUfyQM1wWdksxA6tn3IrA8=
=Dj5e
-----END PGP SIGNATURE-----

--nextPart56494110.K8adIQsycy--

