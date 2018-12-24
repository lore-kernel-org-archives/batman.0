Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 24 Dec 2018 19:43:07 +0100
Message-ID: <4059540.uxCivL65nk@sven-edge>
In-Reply-To: <20181224174926.20321-1-pakki001@umn.edu>
References: <20181224174926.20321-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7191841.mqxAbxXKxD";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv/main: Fix check on return
 value of rtnl_link_register
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
Cc: Aditya Pakki <pakki001@umn.edu>, Marek Lindner <mareklindner@neomailbox.ch>, kjlu@umn.edu, Antonio Quartulli <a@unstable.cc>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

--nextPart7191841.mqxAbxXKxD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 24 December 2018 18.49.26 CET Aditya Pakki wrote:
[...]
> diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
> index 69c0d85bceb3..e0007f242823 100644
> --- a/net/batman-adv/main.c
> +++ b/net/batman-adv/main.c
> @@ -109,7 +109,10 @@ static int __init batadv_init(void)
>  	batadv_debugfs_init();
>  
>  	register_netdevice_notifier(&batadv_hard_if_notifier);
> -	rtnl_link_register(&batadv_link_ops);
> +	ret = rtnl_link_register(&batadv_link_ops);
> +	if (ret < 0)
> +		return ret;
> +
>  	batadv_netlink_register();

Uhm, but shouldn't the already initialized parts be unregistered/uninitialized 
in this case?

Rejecting this patch because this could cause a new bug.

Also "Fixes: " line is missing

Kind regards,
	Sven
--nextPart7191841.mqxAbxXKxD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlwhKLsACgkQXYcKB8Em
e0aocw/+OngTRNriOUuAUhqvFiEsEOd9cTfKSauh01enwW3ER+X/MT+kzuaLxOBa
NRj7UEOvqtZw+UumsTQgO1B6hs3SPHgTPQ5SceUCDcQ8kDOc+mni52x//9xGpEd2
mABnL/kAmDxpUcDTr3T/83qUAdxw/dwrhRhnmMGiA6UOXJK27ocsOsUr3fMNMt2a
KoUaWg2Stiovz0/pBDmbe9wJiQ4TLmtwLyCjSHo4sdGWGJJ733QDIhq3Ou+4kG4r
gj5RJbE3MtXkqAzj0bf/OEBM2QT21cgMVzgjynHv6o+rREZUgY7cyx3rpVEBzlX4
muODmEqYdyJ4IiNf7iygsfRc2Nh/JXUGaFZ1r2NwJhPnGgQ2J/q+NyqFlw1Obzwl
ZYKmaL+Ap2EGG30+ZiCQJ3Ccq0x27eEe2mIcW2JSk/guQBiZ/gv8ufeKyLdZwj44
eVqAeO3SBYY+1qVnWb96hmDtBANvc9MOiuFQ55l7PYMrUpAoHpfrK4u4RZsfxycw
l2qfIUtmIOOMM0o5gTwYwK8pEsV7OeNqr31R08xKUCntOVFcKYlZYGh/GkSgWATc
pRlMnmIkjbLHHpjCP7YaAa1GvsL5paOd6S+AUwpj9SXyDmR4jpTKeVRAhdkocJEe
im9TSDSKVJaSLdhaBXTmH30HFGMeOC7Mw5CZ01lNVJvuBQIWXPE=
=dQvc
-----END PGP SIGNATURE-----

--nextPart7191841.mqxAbxXKxD--



