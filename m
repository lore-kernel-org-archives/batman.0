Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Thu, 05 May 2016 18:06:42 +0800
Message-ID: <11189229.WBdSWXHkp5@voltaire>
In-Reply-To: <1462434282-3307-1-git-send-email-sven.eckelmann@open-mesh.com>
References: <1462434282-3307-1-git-send-email-sven.eckelmann@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1787523.RYgsyL5n3A";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH next] batman-adv: replace
	dev->trans_start update with helper
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
Cc: Sven Eckelmann <sven.eckelmann@open-mesh.com>

--nextPart1787523.RYgsyL5n3A
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, May 05, 2016 09:44:42 Sven Eckelmann wrote:
> From: Florian Westphal <fw@strlen.de>
> 
> Replace all trans_start updates with netif_trans_update helper.
> change was done via spatch:
> 
> struct net_device *d;
> @@
> - d->trans_start = jiffies
> + netif_trans_update(d)
> 
> Compile tested only.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> ---
> Warning: untested
> 
>  compat-include/linux/netdevice.h | 10 ++++++++++
>  net/batman-adv/soft-interface.c  |  2 +-
>  2 files changed, 11 insertions(+), 1 deletion(-)

Applied in revision c5ebb1b.

Thanks,
Marek

--nextPart1787523.RYgsyL5n3A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXKxszAAoJEFNVTo/uthzAdPUIALm+wUeK6FeHQdvEl97N2m1o
ziNOjpMlCl4ZWVaHyO2YJ4QuTbUk8nxi/ta4kDc6QMhhnqB4nz2514mA/1lz9v1h
uT1YO3SA4edK/vlB4KVDg19+6KWL3x26RuTUTO0eOlKEE4Dar+irZGkqXn2blzU6
A/SNAP8u/vhgYyTu3E8lf3kWW8anNWt3vOhhcBI89XItMyr8KCPcplVPNBTejk2I
7/JmiMm+fjMOM+WinFLYtie9kVqQjhNRFC7o8zULEAeWCyj2o3buvhu52n7ubRcA
MWisnhkDMwRk6wyiH56nbskPxmOBcdgRpBVNCwep0u6CpOQBPG3zO0tT/zLiLO4=
=l4qd
-----END PGP SIGNATURE-----

--nextPart1787523.RYgsyL5n3A--

