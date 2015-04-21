Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 21 Apr 2015 12:06:26 +0800
Message-ID: <25530253.gmXp9rLdmH@voltaire>
In-Reply-To: <0516b7e4ce841146f759473be197ce252878f8ec.1428329893.git.alex.suykov@gmail.com>
References: <0516b7e4ce841146f759473be197ce252878f8ec.1428329893.git.alex.suykov@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3844856.I5Xe9SoVXn";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v2 2/2] batctl: use netinet/if_ether.h
	instead of linux/if_ether.h
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


--nextPart3844856.I5Xe9SoVXn
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, April 06, 2015 17:29:13 Alex Suykov wrote:
> musl does not allow including netinet/* and linux/* headers together.
> batctl includes netinet/if_ether.h indirectly via net/ethernet.h,
> so netinet/if_ether.h must be used instead of linux/if_ether.h.
> 
> Signed-off-by: Alex Suykov <alex.suykov at gmail.com>
> ---
> v2: updated to work with #include <linux/types.h> in packet.h introduced by
> https://lists.open-mesh.org:443/pipermail/b.a.t.m.a.n/2015-April/012961.html
> and ported to batctl by patch 1/2 in this set.
> 
>  ping.c       | 2 +-
>  tcpdump.h    | 2 +-
>  traceroute.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied in revision 6423e3e.

Thanks,
Marek

--nextPart3844856.I5Xe9SoVXn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVNczGAAoJEFNVTo/uthzAMv4H/AqIso0cg06IAWfIWt8P14WR
88TUHwE5qqg8r8J3hKU/oIyt/CEsMucG0nz7isgQPGRA/pcPKwrAdf9a6QEtETUg
xOT0OD1Ng3veQs8xI58w6ajpNuuiHKliyCQtwYaDLuKirtFRp5sjIuH98kLIemCO
0tnLcwsc6GU6EYDGu02UKFZ05IU7sfMQGfsU0+8bXPME+duCFrEPhYUKp4dnwHyC
s42fF2s5Mw4fnCAhUWwMjJypKnq/eMIw5bFjf41hXDWQdBRSjG/anvMHEj/ysV1S
SaY6Ks8DI2Zs+f1ZA08rk4KkvQ/iLmkG642/KZ7TfKO1rBcAcjpjB5Nlz8lXSMg=
=1Jj8
-----END PGP SIGNATURE-----

--nextPart3844856.I5Xe9SoVXn--

