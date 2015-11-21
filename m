Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sun, 22 Nov 2015 05:42:45 +0800
Message-ID: <1604913.TZOKfsDGYZ@voltaire>
In-Reply-To: <1447082453-13117-2-git-send-email-sw@simonwunderlich.de>
References: <1447082453-13117-1-git-send-email-sw@simonwunderlich.de>
 <1447082453-13117-2-git-send-email-sw@simonwunderlich.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2239453.ukCVilkmsZ";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: purge bridge loop
	avoidance when its disabled
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
Cc: Simon Wunderlich <simon@open-mesh.com>

--nextPart2239453.ukCVilkmsZ
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, November 09, 2015 16:20:52 Simon Wunderlich wrote:
> From: Simon Wunderlich <simon@open-mesh.com>
> 
> When bridge loop avoidance is disabled through sysfs, the internal
> datastructures are not disabled, but only BLA operations are disabled.
> To be sure that they are removed, purge the data immediately. That is
> especially useful if a firmwares network state is changed, and the BLA
> wait periods should restart on the new network.
> 
> Signed-off-by: Simon Wunderlich <simon@open-mesh.com>
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 20 ++++++++++++++++++++
>  net/batman-adv/bridge_loop_avoidance.h |  1 +
>  net/batman-adv/sysfs.c                 |  4 +++-
>  3 files changed, 24 insertions(+), 1 deletion(-)

Applied in revision 07ed3c3.

Thanks,
Marek

--nextPart2239453.ukCVilkmsZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWUOVVAAoJEFNVTo/uthzA1HcH/i9PVsfTP1XpXSLDNXhgDnW8
SNer3c6hL2JBxkYypTA0b4YBJH0wJkA1Aj99l7Lx8zLQ2iwAxa4k1gfXemGuTURh
j6o8ZzQN0qqj65PkWIVUv9YRwIqw/eMiiOjiRK+uA7pw5/qhd3KbW8StRqDaXym3
F7lVm6sUwkxV5nox1zqEQXfjW6V9R+h2v42dqjApyv6MDR7PZ3ZPPargFWevX9YY
7JOoMM13TqLRtQuELvJV/O2+1/TfcZz6DrpPq+IC8bXNmb4aOQm2X4StoYWoL9mO
3OdlYPdzv7+ZJjBuZKQJfcbgXdzfYuzYm1wR/GbXp+0KHqVo0G3RKjlcnbi7dBo=
=Tv70
-----END PGP SIGNATURE-----

--nextPart2239453.ukCVilkmsZ--

