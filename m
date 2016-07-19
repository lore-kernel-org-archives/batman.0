Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 19 Jul 2016 15:55:28 +0800
Message-ID: <2503884.aX2sYPWlRf@voltaire>
In-Reply-To: <1467545508-7333-14-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-14-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6415949.dvitdVblNU";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 13/16] batman-adv: add B.A.T.M.A.N.
	Dump BLA claims via netlink
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

--nextPart6415949.dvitdVblNU
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:45 Sven Eckelmann wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> Dump the list of bridge loop avoidance claims via the netlink socket.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [sven.eckelmann@open-mesh.com: add policy for attributes, fix includes, fix
> soft_iface reference leak]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> [sw@simonwunderlich.de: fix kerneldoc, fix error reporting]
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  include/uapi/linux/batman_adv.h        |  12 +++
>  net/batman-adv/bridge_loop_avoidance.c | 169
> +++++++++++++++++++++++++++++++++ net/batman-adv/bridge_loop_avoidance.h
> |  10 +-
>  net/batman-adv/netlink.c               |  12 +++
>  4 files changed, 202 insertions(+), 1 deletion(-)

Applied in revision 3b7a636.

Thanks,
Marek

--nextPart6415949.dvitdVblNU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjdzwAAoJEFNVTo/uthzAAtgH+wWCIr0GEVZmKjun+GDcGyxr
6G30HmVi1IMeRz2DkJ4CZUa0nCTouLBsA0aoW+iG6sxQ5vLLGJYD5b1dxZTo12pX
ldJSnU2eH3BtlMXDi6ZMJvJCIhupGc4K+eEaPWwVbQOP34cHQ53jPwZa1F6ZC3G7
WYuYn9aUCP6oMa3aNUYMy0SuWL6xREwj89dYfmuq10qF3pNUTBUFoVzQbCMKvtxt
reL2Pe5QD3Uy1yaI2g25kNGn1/4mUs15b+NX7XL7CMMFoPESNvDxwh9IYWJHwQDE
2prDXKH2bDSBQ9WdM+GZC0qJceJdF6SvgvxVlQH2PpTPc2ji0Fej/lsW62XIbKo=
=xGn7
-----END PGP SIGNATURE-----

--nextPart6415949.dvitdVblNU--

