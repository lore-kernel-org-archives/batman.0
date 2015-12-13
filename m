Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 13 Dec 2015 14:01:45 +0800
Message-ID: <10070696.rjA4LQ9luG@voltaire>
In-Reply-To: <1449606915-6457-1-git-send-email-sven@narfation.org>
References: <1449606915-6457-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4633890.rftpPpsfhb";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 1/3] net: propagate upper priv via
	netdev_master_upper_dev_link
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

--nextPart4633890.rftpPpsfhb
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, December 08, 2015 21:35:13 Sven Eckelmann wrote:
> From: Jiri Pirko <jiri@mellanox.com>
> 
> Eliminate netdev_master_upper_dev_link_private and pass priv directly as
> a parameter of netdev_master_upper_dev_link.
> 
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> ---
>  compat-include/linux/netdevice.h | 7 +++++++
>  net/batman-adv/hard-interface.c  | 3 ++-
>  2 files changed, 9 insertions(+), 1 deletion(-)

Applied in revision d794c1c.

Thanks,
Marek

--nextPart4633890.rftpPpsfhb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWbQnJAAoJEFNVTo/uthzADD4H+gIxR5d8BYl7+QM0u2PCFjAt
GqKMj5ySqBNlSyBUUHxPwLMj/lxLa9hZWtqOsRr/JzC9ofmLWOAKY7aM9jipBhJn
ONlgpvCExkMwse1N/4bhhVwoOxTuMbn7CZ8bFSXE6n2U5/lMhG3Ielf7G0CmQ3Os
yv5ula3imzHjOnsV4k8dY3ikECPjdOSdh2kQorlJVGvpSkiSyrYprGOefj7F45vh
9Fy+Z417Ym7+16nLWBjQCcbaW3q0sVrySmMz6HTNSKr4Mx68KcGSEhFCsAhAyDz/
lPkmQ8siDUmw5fzSWbNXiQ2Xba6q6S6ewpk/+SGY3UWrqwGp5q8VtGaJQWF8Pvw=
=HbLT
-----END PGP SIGNATURE-----

--nextPart4633890.rftpPpsfhb--

