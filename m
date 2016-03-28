Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Mon, 28 Mar 2016 23:10:07 +0800
Message-ID: <12473139.x6aGNvRE0T@voltaire>
In-Reply-To: <1457558571-5855-1-git-send-email-sven@narfation.org>
References: <1457558571-5855-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3010148.ocRmnyGs2a";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Fix checkpatch warning about
	'unsigned' type
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

--nextPart3010148.ocRmnyGs2a
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, March 09, 2016 22:22:51 Sven Eckelmann wrote:
> checkpatch.pl warns about the use of 'unsigned' as a short form for
> 'unsigned int'.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  net/batman-adv/fragmentation.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied in revision 89c1f3b.

Thanks,
Marek

--nextPart3010148.ocRmnyGs2a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJW+UlPAAoJEFNVTo/uthzAmN0H/2kovcQReIPlOp3x2gdptgE8
LDSczBzX/2FZOX8yJOLeSYHAdkPd93HpY3/WL7HPxMrdDOM/UqITH9SD8eWFwOun
0ErbG+zJpaJuEO4hxn+yHkaVm4N/gGRcOsR6myF9sPIkkaQlnb/ClVqtzuGmqeFy
l76v42cWw8Q3ieYOGTSLA1k/Rl0w9Ptbto0Zt1msJZJOwTNVsJSxA5ZWuL5NLYQs
bbT0Nvr6eLrqaTkChVD9S0YMPjQzITWFURcGNI8rqj6Tr2GgLu+shlLXuM+wNBYZ
NZJzFi8LCvMtkFtx9tBVmg9vf6E6XEH67gD0O9t/0L9BsSGFccbRzF1b+ZUkYf8=
=Lqm4
-----END PGP SIGNATURE-----

--nextPart3010148.ocRmnyGs2a--

