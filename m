Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 18 Jul 2016 10:12:17 +0800
Message-ID: <2533934.lsj5Ui92jU@voltaire>
In-Reply-To: <1467545508-7333-9-git-send-email-sven@narfation.org>
References: <1467545508-7333-1-git-send-email-sven@narfation.org>
 <1467545508-7333-9-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart8541088.u7SkBqx8K2";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v10 08/16] batman-adv: add B.A.T.M.A.N.
	IV bat_{orig, neigh}_dump implementations
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

--nextPart8541088.u7SkBqx8K2
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 13:31:40 Sven Eckelmann wrote:
> From: Matthias Schiffer <mschiffer@universe-factory.net>
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> [sven.eckelmann@open-mesh.com: Fix function parameter alignments,
> add policy for attributes, fix includes, fix algo_ops integration]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@open-mesh.com>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> ---
>  include/uapi/linux/batman_adv.h |   4 +
>  net/batman-adv/bat_iv_ogm.c     | 366
> ++++++++++++++++++++++++++++++++++++++++
> net/batman-adv/netlink.c        |   2 +
>  3 files changed, 372 insertions(+)

Applied in revision df08990.

Thanks,
Marek

--nextPart8541088.u7SkBqx8K2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXjDsBAAoJEFNVTo/uthzAFfwIALCE1sG4SV8CmRHFoOF1PjiK
Q8JRWfZpRutJT4oM1mBI3ECzEaueFkCb7gKQrcQFwCIiHBiemWE/3QKran9OFg3F
aRJNhb0qaRZZ7GozOYuZRff3LT0hGgsqDt8an+M+DC9y4M7Etw3QiA+nEbzloHR7
GzOuwcw6lwiXn58ls7nZWxs6YOpMjE01g2Zq1KE/uSyTniFnJasCjGmrPQSvt/Bs
td7mF+M0XYQ6vMrXEuYi0qFmhhJOLZAuLb8C3absH1YADvbVmIpJofSw8ILs4nNZ
O4hkxndFAf4fwPtwA9buCioMVp7qwH7VyYRA4bflia2GnYGhifN/UwIIdWlrxNM=
=6djR
-----END PGP SIGNATURE-----

--nextPart8541088.u7SkBqx8K2--

