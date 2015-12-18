Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Fri, 18 Dec 2015 22:25:31 +0800
Message-ID: <1955217.rHmPbHNXC9@voltaire>
In-Reply-To: <1449414907-21358-1-git-send-email-sven@narfation.org>
References: <1449414907-21358-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7583411.T0HsD6a4WX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Switch to HTTPS version of
	links
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

--nextPart7583411.T0HsD6a4WX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, December 06, 2015 16:15:07 Sven Eckelmann wrote:
> open-mesh.org and its subdomains can only be accessed via HTTPS. HTTP-only
> requests are currently redirected automatically to HTTPS but references in
> the source code should be only https.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
>  Documentation/networking/batman-adv.txt | 2 +-
>  MAINTAINERS                             | 2 +-
>  net/batman-adv/Kconfig                  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied in revision 5fe476a.

Thanks,
Marek

--nextPart7583411.T0HsD6a4WX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJWdBdbAAoJEFNVTo/uthzAQgQH/RmkAzjomJE2CAMU8d0EEIpO
KUfts+p67Q1t3ldan1afUtj7EQQ6mSqbovcVzHgzKczrGm3BP6DvYZ6WIoEzCaGB
7ixE0S+KdiYA5ipWs6iCjJ+W6sXCdtNqVxYYEr0JhpJYhrRydjfNO5aywuc4Vqto
D3RXZqWN0rBBGNLGkaNMY8ZEISynbeZ0IHhGHQ+eKOP0h8/ybyyrLRTaSpwFSjIL
u/ST/4+WTl+P/Yhq8m1qpOqd25DhsdN4WwwG9l5Fg8DIfb0mKLfOmtTTBlNat8gQ
wFrNLwwsaYHknaWisiQj46xnwmismvNG2u1ajVFvj7u4YLL71VfX0j2VjRVEkwA=
=Ak/F
-----END PGP SIGNATURE-----

--nextPart7583411.T0HsD6a4WX--

