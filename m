Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 05 Jul 2016 15:54:16 +0800
Message-ID: <8896655.T0Eh5ejtFM@voltaire>
In-Reply-To: <1467542795-29647-2-git-send-email-sven@narfation.org>
References: <1467542795-29647-1-git-send-email-sven@narfation.org>
 <1467542795-29647-2-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3171461.v13etDhhae";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v6 1/4] batman-adv: make the GW selection
	class algorithm specific
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
Cc: Antonio Quartulli <a@unstable.cc>

--nextPart3171461.v13etDhhae
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, July 03, 2016 12:46:32 Sven Eckelmann wrote:
> From: Antonio Quartulli <a@unstable.cc>
> 
> The B.A.T.M.A.N. V algorithm uses a different metric compared to its
> predecessor and for this reason the logic used to compute the best
> Gateway is also changed. This means that the GW selection class
> fed to this logic has a semantics that depends on the algorithm being
> used.
> 
> Make the parsing and printing routine of the GW selection class
> routing algorithm specific. Each algorithm can now parse (and print)
> this value independently.
> 
> If no API is provided by any algorithm, the default is to use the
> current mechanism of considering such value like an integer between
> 1 and 255.
> 
> Signed-off-by: Antonio Quartulli <a@unstable.cc>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v6:
>  - added "(optional)" to the kerneldoc of store_sel_class and
>    show_sel_class
> ---
>  net/batman-adv/bat_v.c | 34 ++++++++++++++++++++++++++++++++++
>  net/batman-adv/sysfs.c | 34 ++++++++++++++++++++++++++++++++--
>  net/batman-adv/types.h | 13 +++++++++++++
>  3 files changed, 79 insertions(+), 2 deletions(-)

Applied in revision 707355a.

Thanks,
Marek

--nextPart3171461.v13etDhhae
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXe2eoAAoJEFNVTo/uthzAA3UH/1lWA7KoRpixX8wpOloc8mnQ
gn2Jfh+obH2h30nKJT5y3nbTnklEWiEqm1DiD5O0j/tfYbugrr8rN+f6p0GaycNT
0SnomOnhP69hQ0d/sg7LBDUmbNyES/EYAAEt9/Ev1TUkLlluoa4rODuFuKeFjakq
B0mBqFX9VKYaj7sPNj1P1pF5ACQzOsnTiA0ScJzHMiLZ3Ky0PA2wBuVYVY53dwye
JBd88NIuwYWAoM7q364hathtxoAo0ibakn5UVQiLAEh1r3nnpLjJDdSCnS87PsDg
bXkrVPnrQ5NPXywbTCvbal2w1qD8eUDXGCToJK8DIhcRUGNIiZsOop5fzQnERDA=
=r04C
-----END PGP SIGNATURE-----

--nextPart3171461.v13etDhhae--

