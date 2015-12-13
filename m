Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 13 Dec 2015 14:30:38 +0800
Message-ID: <36251051.0TfVRU6jZ7@voltaire>
In-Reply-To: <1449606958-6548-1-git-send-email-sven@narfation.org>
References: <1449606915-6457-1-git-send-email-sven@narfation.org>
 <1449606958-6548-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7632863.xnlfhL1jOb";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 3/3] batman-adv: Act on
	NETDEV_*_TYPE_CHANGE events
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

--nextPart7632863.xnlfhL1jOb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, December 08, 2015 21:35:58 Sven Eckelmann wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> A network interface can change type. It may change from a type which
> batman does not support, e.g. hdlc, to one it does, e.g. hdlc-eth.
> When an interface changes type, it sends two notifications. Handle
> these notifications.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  compat-include/linux/netdevice.h | 3 +++
>  net/batman-adv/hard-interface.c  | 4 +++-
>  2 files changed, 6 insertions(+), 1 deletion(-)

Applied in revision 399bf29.

Thanks,
Marek



--nextPart7632863.xnlfhL1jOb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWbRCOAAoJEFNVTo/uthzAEygH/jP5geC778is4FlCd7b8GTfd
7jXpbxsLwV1VdA2HhNPsewXKHAoqgxdvWLfztbjx+j1bMa4a73vm4PeucbBcbFs8
8kUu8uFBgG64gvYgNYQVaCJOuPX5fie3lxWFS6siu7WuCZIj+qURgxI3JP0yPsUy
BciFerdl73yv+Ft/0rXeuJ8BuMzyeLDUk1SD5eouL15+6LhoXK8Q0VFEzqXyX5+A
s93olcjH+0QqIdt9JFPF9nlLeYZAtCYNUiJXIQg2GyD+0Al0lv84B5gM5XqG5ctl
RTl0EQ4MOeFk+JOz0b+HK3vgactPO6bZSTZYMM0mAfP5ewmY87aI00/J4LEz5mc=
=dePD
-----END PGP SIGNATURE-----

--nextPart7632863.xnlfhL1jOb--

