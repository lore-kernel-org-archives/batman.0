Return-Path: <a@unstable.cc>
Date: Tue, 1 Mar 2016 16:07:08 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160301080708.GO28478@prodigo>
References: <1456817617-5762-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EqVOK5mkaJAMmtSx"
Content-Disposition: inline
In-Reply-To: <1456817617-5762-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH next v2] batman-adv: Disable
 __ethtool_get_link_ksettings compat on < 3.2
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--EqVOK5mkaJAMmtSx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 01, 2016 at 08:33:37AM +0100, Sven Eckelmann wrote:
> The __ethtool_get_link_ksettings is currently used only for kernels >=3D
> 3.15. But the compat code is read by the compiler for each kernel. But
> kernels up to 3.1 never had the function __ethtool_get_settings which is
> used to emulate this function for kernels < 4.6. Therefore, kernels < 3.2
> will fail to compile when this compatibility layer is enabled.
>=20
> Fixes: 3515604d82d5 ("batman-adv: ELP - use new ethtool_link_get_ksetting=
s API")
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> v2:
>  - correct version number of the supported kernel
>=20
>  compat-include/linux/ethtool.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/compat-include/linux/ethtool.h b/compat-include/linux/ethtoo=
l.h
> index 87f7577..2e6270e 100644
> --- a/compat-include/linux/ethtool.h
> +++ b/compat-include/linux/ethtool.h
> @@ -24,7 +24,9 @@
>  #include <linux/version.h>
>  #include_next <linux/ethtool.h>
> =20
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0)
> +/* WARNING only enabled on kernels with __ethtool_get_settings support */
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(4, 6, 0) && \
> +    LINUX_VERSION_CODE >=3D KERNEL_VERSION(3, 2, 0)

Sven,

does it mean that on <3.2 batman v won't compile at all ?


Cheers,

--=20
Antonio Quartulli

--EqVOK5mkaJAMmtSx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1U2sAAoJENpFlCjNi1MRbH4P/0qiB8cORF0LIfD7mMOiE4Q0
4DBY7bIAlaiflo+f7MATpeennJUFdP3P6lkuNjiu/RyulIgI4GkJ5iGSEDGevfAX
3l5QfzO6fRNCUX24m241qDE7GvAIFkDSkvNbVfNIrtldzGu517FfbG7+0ni+86+8
R1HPuQBPS7eCQadm6jY5Mh4yCNzwdWo8TfRSubwYBrntoSeWK/isxD2fjRuBbexS
4JyiqD2UbpEtisEj236X31fsMEd7PO9H7YE0IO2b1YPtL9SvewwIfchTHdNZjxy7
DbvBEWkijJv7l4QRvexNhfc1UHiYHfdRvaMLP5hSdrt+OfgvYhJpi6v2w9lnuTU4
cyiXfLI0JPF16lmjVy6JOsXYQo7G+iPAYW4+Eg9QaSFyBO9kUN+E4kIeX45sVRm2
D4GEBFCUvu5hB2UXw1Ulsvdg+xgSi/kjOdkDaCi7YpI5H141XVa0ZvNAiy0Ka/P7
oYNsiIcfhJsDbt0syLdSYH8J8HObJotVaxFplPgUbo9QmgWMxmdPgC39tLN54V+w
rByOLVTzovgY/ORnJAsFKW2OsjHnlc0lWD4WvRW/rN00E7gz9C2SkLD7RE9MFEHK
MSxxc49A6uKdHDRfvxtUkvNgajzb7RQ6zWvyeQi60tSLtvV+9spPW3Q3srMvrOTc
5h+eVLdJfx5//SjjCmzC
=FoXE
-----END PGP SIGNATURE-----

--EqVOK5mkaJAMmtSx--
