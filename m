Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Tue, 07 Jun 2016 00:12:05 +0800
Message-ID: <5003171.nFJlRClX9B@voltaire>
In-Reply-To: <1658184.bVJx44a0QY@sven-edge>
References: <20160521121756.27450-1-a@unstable.cc>
 <20160521121756.27450-2-a@unstable.cc> <1658184.bVJx44a0QY@sven-edge>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2127641.Ss0CmTLRc4";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/2] batman-adv: move include line at the
	same place as other files
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

--nextPart2127641.Ss0CmTLRc4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Saturday, May 21, 2016 14:32:38 Sven Eckelmann wrote:
> Signed by sven@narfation.org.	Show Details
> 
> On Saturday 21 May 2016 20:17:56 Antonio Quartulli wrote:
> > main.h is always included after the #ifdef guard except for
> > bat_v_elp.h. Move it at the right place.
> >
> > Cc: Sven Eckelmann <sven@narfation.org>
> > Signed-off-by: Antonio Quartulli <a@unstable.cc>
> > ---
> 
> Good find
> 
> Reviewed-by: Sven Eckelmann <sven@narfation.org>

Applied in revision f47544c.

Thanks,
Marek

--nextPart2127641.Ss0CmTLRc4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJXVaDVAAoJEFNVTo/uthzAHU0H/30KsTnUG87fbhV/9B75xoKW
dZzYwXxqKzp4v72arEVRg4ijknEI2NGirp6mx8qct+trwZ3a73Hx4ZzTsHoByNvo
qm1XtqxyPKrvvginyYtYYEDy8KBW6MyAafKnO8Qc4GglW0manZWEYIKZqQC3hTBg
XJqXUpxlfGHroAafc8nGH91odCSSECM6HoT7tzCIvycw0yRGyKtF6UdYiukiYLi5
MMWG+/mc6bNqNa34jejxNB7nprb+zkTiZegwK9nNmUv/OkSU9qUfN8PJEnKJ93Xu
PyAGQuXHdsLOzbaSJUjoYrlW7nziAY1XeLwBBAHkhNGXyIz0a4jPSm5XcBIk+Hw=
=igU1
-----END PGP SIGNATURE-----

--nextPart2127641.Ss0CmTLRc4--

