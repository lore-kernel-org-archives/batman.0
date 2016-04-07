Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 07 Apr 2016 15:43:57 +0200
Message-ID: <2118490.p8Tlif1VFA@bentobox>
In-Reply-To: <1458101205-26316-3-git-send-email-linus.luessing@c0d3.blue>
References: <1458101205-26316-1-git-send-email-linus.luessing@c0d3.blue>
 <1458101205-26316-3-git-send-email-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16046853.dOgQS8Ob1U";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv12 2/4] batman-adv: Add multicast
	optimization support for bridged setups
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

--nextPart16046853.dOgQS8Ob1U
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday 16 March 2016 05:06:43 Linus L=FCssing wrote:
> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 38)
> +
> +#define pr_warn_once(fmt, ...) \
> +       printk_once(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
> +
> +#endif /* < KERNEL_VERSION(2, 6, 38) */
> +

Please drop support for kernels < 3.2.

Kind regards,
=09Sven
--nextPart16046853.dOgQS8Ob1U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXBmQdAAoJEF2HCgfBJntGRAYQALuePLf9CsdWKXTO2XETlrar
9Pa18DfFdmMHzL+AyrGCVkgJEbY2D474QX5jvJc/gdZVqkzdZo7pPgb38/MOfnHZ
CP0AKGjvA5vXQK1HausHUoHnN5bHC5YL2qZ1SqKtJH2odd9ioiPxtpZDM5df7ViD
zEWuC1Uii8DcIbTvoPgr9kNdhcN0ZUCrzuTls1tSJVy7quNxRsulNZvrcEzeRVbR
WITaVKRdiyX+FcNy45apVeE81LU7eBW5QAu3TGXkIwRsmt0vL4POluYq+u0iTO6c
Us415DaaBGm/tEuhZiqV4QBld6yakZ+TkAUa0H7XI06hPTDiPNZxvMdZR6Jx10ED
0Y3Rk9Tij3HBBY7l9fspaB56MVpEjrqPhJXaGMSos09PGx3yrXAD1Pk2d24rf34p
STKN2ajrA3LOzuftD0plU0lARcJRQF3wZzGwxgESTgBsb7Mc/7al8iDXlxi8aU7H
MUWIHwmUx5SLpJiPrWjLp7hkTfdlAyORjUt3+Jpvv6dDvbykPDi5LwAAT6Fs6dSQ
jbuTZct3KWShuE+Z1nXNfbb2B+54LuRvdStQOXtzsQv0NDwvgMV/ZcXWS2E87Lqo
/nKjk2FeodWjLPE8pGy96whQ5mA8dAdxDmrtCbjighJ48dEw5in64sKf9oyqeJHv
pZHn6xie10J6MiKnDvIV
=pZ5P
-----END PGP SIGNATURE-----

--nextPart16046853.dOgQS8Ob1U--

