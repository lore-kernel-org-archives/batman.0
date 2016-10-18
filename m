Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 18 Oct 2016 13:34:29 +0200
Message-ID: <1676579.6XHqyD8iXT@bentobox>
In-Reply-To: <20161009065738.8279-1-sven@narfation.org>
References: <20161009065738.8279-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1893110.rbjyd1Ftj4";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [next, v2,
	01/11] batman-adv: Introduce compat-patches support
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

--nextPart1893110.rbjyd1Ftj4
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sonntag, 9. Oktober 2016 08:57:28 CEST Sven Eckelmann wrote:
> compat-includes/compat.h can usually be used to solve compatibility
> problems with older kernels. This works well for functions, defines/enums
> and sometimes even structures that were introduced.
> 
> But this can fail when structs changed. Some of these can be solved in
> crude ways but sometimes it is unavoidable to have a version specific code.
> Unfortunately, this kind of code is not acceptable in the kernel and thus
> the compat infrastructure of the external module has to do add it
> automatically before the source is compiled.
> 
> This process works by creating a build directory which is prefilled with
> the source from net/batman-adv/. The patches from compat-patches/ will be
> applied on top of this copy and then the code is compiled.
> 
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - no change
> ---
>  .gitignore              | 10 ++++------
>  Makefile                | 31 +++++++++++++++++++++++++++----
>  compat-patches/README   | 23 +++++++++++++++++++++++
>  compat-sources/Makefile |  6 +++---
>  4 files changed, 57 insertions(+), 13 deletions(-)
>  create mode 100644 compat-patches/README

Applied in 66ac14a09445b6066de6a8ae4382d8f981466ae3 [1].

Kind regards,
	Sven

[1] https://git.open-mesh.org/batman-adv.git/commit/66ac14a09445b6066de6a8ae4382d8f981466ae3
--nextPart1893110.rbjyd1Ftj4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBgjFAAoJEF2HCgfBJntGyxUQAMAIt8NnfcgRbB6YYYBNBeU7
UgWQFPhVoGorvssSuYYBNAOe688H+w/+/1pKWCLP+4OgHdxP1yQ8adgpjwHNCqPS
RaaS6/B5YzeJUGfMNJXGybDvWyjxrLnfzUakechjRfoFF1tUbDJb5x1dl7tvwz6L
83POvPBryokPZ7Ms4yQ3n1rnXttrIfJzgNyVySTOph9g6QrikDupMTjuVO9qET4g
fgftFeEwA2v63qiLFIkw8k2K51AAZhvuYcOT3kWmdKblJVdWC+KbU/V/VIlri+YX
2OO8YGyde++swdPy/IwICk9jnkXB0/KEVLHH/02N2WdbRhA0Kif3avWIxrM6dADE
k8PVP2smGZIZfZxEBAQY2f9Uz9+A0blwr1uuxmNncKXmpX2qZ7dFEMkvbye7AXxr
FRaHpxuRNr6DPHROwQVvjSiXhvXd4GaL3/McO+7QfA/qz276GKiQYBSeA5oainwM
19a2JZfx9rhsa9+Pss6dMvUdyWJffcVOzS4iJZ0FsEgsp+ZhFTM31w4F68tV9QY9
Vn306Jc1HgMEg+2V0fFGqEhz6xcQUUB0M6duzKLB1LWuIidwH0U45sdXJouIOYrU
kuoHwKEWYdJ7hurh9/b5bb6ZRpERGPd22kSs6Q7MAFr+3bUpHdL7FqBgUSMmF/Fs
c3SHZdySvOTbwGx9Af+H
=J/3A
-----END PGP SIGNATURE-----

--nextPart1893110.rbjyd1Ftj4--

