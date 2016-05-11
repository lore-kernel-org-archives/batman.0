Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Wed, 11 May 2016 14:24:04 +0200
Message-ID: <5284085.o6G6OjSAFN@bentobox>
In-Reply-To: <20160511104730.GB21549@prodigo.lan>
References: <1462962557-23950-1-git-send-email-a@unstable.cc>
 <2789203.91ASHWIDJV@bentobox> <20160511104730.GB21549@prodigo.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1982267.lRenoCKYdx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH 1/2] batman-adv: remove forward
	declaration by including proper header
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Antonio Quartulli <a@unstable.cc>
Cc: b.a.t.m.a.n@lists.open-mesh.org

--nextPart1982267.lRenoCKYdx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 11 May 2016 18:47:30 Antonio Quartulli wrote:
[...]
> Maybe I could include it only when really needed, i.e.
>  * net/batman-adv/bat_algo.h
>  * net/batman-adv/bat_v_ogm.h
> 
> (netlink.h does not seem to be requiring it)

This is rather vague and hard to detect automatically. Potentially all
files may require it because it has things like:

    /* Debug Messages */
    #ifdef pr_fmt
    #undef pr_fmt
    #endif
    /* Append 'batman-adv: ' before kernel messages */
    #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

Btw. Just looked at this file again and I should really consider
redoing/rebasing the patches [1,2] from Markus Pargmann to clean it up.

Kind regards,
	Sven

[1] https://patchwork.open-mesh.org/patch/4264/
[2] https://patchwork.open-mesh.org/patch/4244/




--nextPart1982267.lRenoCKYdx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJXMyRkAAoJEF2HCgfBJntGWGYP/0oeleass70eGgbfQ7TkXSvy
ZZtOqIrU+hy1KfUzuDmwoFi4MHxY5igYi7tlz6KJrnh4Sy60fEoxcZb4qFHIDkpd
YrBxi/XNwdCBtUWK1XfFm1rlRms3qOh+sNgxQM+Lz85AksXls11lScEUYpT2YQOZ
Tftye69EAAvC7PYNzbBf5+M6WHDo0BTLXB25+tFul2JSwawvegjsOFw96qKaBKsZ
dGzSG/XDi5iDHRZLQfXr2zFYhv5KDQTkBX7MG2koMOFfX9daUBzHZWnEtY3HQ0a3
JimKSSFVXPKECH8eJ8mAKbmdUKF8tO3BJSvzxsV2O3Sl4LSMJtCMaHRAedO3VNp1
952gqXkdVFI+AEixgyRJHdTyNE/Mes+Xxc7a6LIhWsqH49xppGPyyA4J4jmegHk+
VBy6OG2KsLiLqDoc28jj+gOhbBhb8x5wykqok/9dbcWZytb5j7q+vDjXqtz5NeuT
7k6NEizf7Z8q+Xq14xKUv5NlnaTmgA77Bv0QBhKWQyhjZb2kpNyC5n8fjBpYBgoY
UH3lfeznjNdT8cCi1X9E8HdJBoTD7q1QtQuFMotuRe6cDMRI2TEt4G4WekvIB+Om
p8z1uCM9wcCJgXzunsvg5FXq6sa4LdMn0PgR2x+x1FWhEQgzY3LsacvWb+k3Ylef
bMHo+s1j4tySwZwTEUvg
=OjMF
-----END PGP SIGNATURE-----

--nextPart1982267.lRenoCKYdx--

