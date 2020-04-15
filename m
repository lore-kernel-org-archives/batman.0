Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: Fix refcnt leak in
 batadv_show_throughput_override
Date: Wed, 15 Apr 2020 11:04:02 +0200
Message-ID: <28340414.QPzbqP6r4N@bentobox>
In-Reply-To: <1586939510-69461-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1586939510-69461-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3979470.HMjOjGzVmR";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc: Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>

--nextPart3979470.HMjOjGzVmR
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 15 April 2020 10:31:50 CEST Xiyu Yang wrote:
[...]
> Fix this issue by calling batadv_hardif_put() before the
[...]

Thanks, fixes for batadv_store_throughput_override [1] and 
batadv_show_throughput_override [2] were applied. I've also added the missing 
Fixes: line to both patches.

May I ask whether you are still a user of the deprecated sysfs interface or 
did you find this in an automated fashion?

Thanks,
	Sven

[1] https://git.open-mesh.org/linux-merge.git/commit/cd339d8b14cd895d8333d94d832b05f67f00eefc
[2] https://git.open-mesh.org/linux-merge.git/commit/3d3e548f74fe51aee9a3c9e297518a2655dbc642
--nextPart3979470.HMjOjGzVmR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl6WzgIACgkQXYcKB8Em
e0YWYA//cxS1UcxnDCvjyQWGYwFAPix8PLJ9rCp7jlscYfwarzqplrpPvLM6GNkl
O0H1Hh6SEWsyJ4kBdWrcADqHWfhanPco1Bh0o+Oh307JFtlViDVWpZnAKsICz1Hm
X9GsDu1SwkTepf+py6GNUnMJj2FXC/M1bXQJC15t8gAXwVwhQU8VVP9Vq0Hk1c7a
vwKU4vdV1JTix1zzWWDHGHXrMODQMFdOfBMuSS+AdCPONmffbsRzfGw8aJPu/qDW
vdMajAZWgYC9LP4FFZxyK1DLkaEVeVUScobj69RuyxFdZT2dCPakgMeLKZmtLmxt
yCKzxetELw107//zOXbRGqf1R7zTnqj5Zn8DmmNGA8H1EVii1WQhB8M1r17f8ROy
093I3ZgvnCd5T2i7yPWP6BLIHGt6ckIvdqERhw3EV4xTiS5KyWpTRPJ8B0Mqva4y
Us4k+D8EaTrZuwZwCR20DUx2liWsDSoGfWjEJ0ufIPWAe4qTs0f5ZFRbSuQf7FQW
KSLuI1dTEZp3zZH4zMSxhapCLNZt6d/+HRaVWrdr1ZRTXzdqdFNWmZKRUMUpXZYT
pXJNA5PDJBYXRGEfJUsM0/m/B2NDCvfbXSgl0wOsT3kPyZkE93K8szKLJhvbfiCW
gPOrz+UQsl6Sd2i7fKLmC+W01l4DOURUplSyP4HgHL0XnCMz3K4=
=iyC7
-----END PGP SIGNATURE-----

--nextPart3979470.HMjOjGzVmR--



