Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 30 Jan 2016 15:11:27 +0800
Message-ID: <29092534.7PJDQTYJpc@voltaire>
In-Reply-To: <1453204027-10948-1-git-send-email-sven@open-mesh.com>
References: <1453204027-10948-1-git-send-email-sven@open-mesh.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1565004.PR52HplXOu";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] openwrt-feed-batman-adv: Allow to select
	routing algorithm
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
Cc: Sven Eckelmann <sven@open-mesh.com>

--nextPart1565004.PR52HplXOu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday, January 19, 2016 12:47:07 Sven Eckelmann wrote:
> The network config section for proto batadv now allows to select the
> routing algorithm via the option routing_algo. This allows to chose between
> BATMAN_IV and BATMAN_V when BATMAN_V is released. This option is only
> useful when a new batman-adv device is created and not when only a device
> is added to an already existing batman-adv device.
> 
> Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
> ---
>  batman-adv-devel/files/lib/netifd/proto/batadv.sh | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied in revision 3dafbb1.

Thanks,
Marek

--nextPart1565004.PR52HplXOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWrGIfAAoJEFNVTo/uthzABCgH+wSGAwsbcjvujfDwRQn9lHE+
7WOIL0xWwz/lR2oSu+UD2KH8SmyXdS694Xt7VyjZppdX/YCFfLfeFkqlqAN3xp5u
8pxb5jCe5N48B1VwD+0ZkWt9CzsT6DdC2iz47iOGNk0/XjcsGnq2nJWGA7EMj0KG
wjQ3TmghFFJP/S1WAIY1veCcMwrlP1NW0lL5+mEN84oSfQSsQQa+u/CZDKKaVEAE
JcZKtZj0hpwH/s+cPf12HIZh2pNT/dTxMxbhq6VKwpr20YN7awo2moPUFprHN4U8
Gm1lkWvYq1I2HOWggDBZpoUKclBDVnCkAW/IuLtHhi910kPAwwJFI3iQusT3e+c=
=y7sf
-----END PGP SIGNATURE-----

--nextPart1565004.PR52HplXOu--

