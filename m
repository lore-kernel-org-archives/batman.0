Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 19 Jun 2015 11:32 +0200
Message-ID: <1674100.1XU1fCZBAt@bentobox>
In-Reply-To: <1434697758-8399-1-git-send-email-mareklindner@neomailbox.ch>
References: <1434697758-8399-1-git-send-email-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3211582.DWLfaaR3Xa";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: convert tt request list into
	hlist
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
Cc: Marek Lindner <mareklindner@neomailbox.ch>


--nextPart3211582.DWLfaaR3Xa
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 19 June 2015 15:09:18 Marek Lindner wrote:
>  		spin_lock_bh(&bat_priv->tt.req_list_lock);
> -		list_del(&tt_req_node->list);
> +		/* only remove tt_req_node if it still is in the list */
> +		if (!hlist_unhashed(&tt_req_node->list))
> +			hlist_del_init(&tt_req_node->list);
>  		spin_unlock_bh(&bat_priv->tt.req_list_lock);
>  		kfree(tt_req_node);
>  	}

hlist_del_init doesn't require the hlist_unhashed check because this is
already done inside of this function [1].

Kind regards,
	Sven

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/list.h?id=a54acb3a6f853e8394c4cb7b6a4d93c88f13eefd#n588

--nextPart3211582.DWLfaaR3Xa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVg+GQAAoJEF2HCgfBJntG6kUQAMl87TltDhORykYD9Z7Eu6NB
xxqyoueNYbXbwZ5bbbJspKvk06UzSzP/3DSe3vINAED1st4+K4Zf6TGvMD2oMQxj
MSNGIttmLlNEqIjK/LncuSxr8aH/Gg0mdcBdVj0gJAhN2y86Fi5aJB1RKtYSiswY
jVLHM9IdLx4nTW4c1iHXdRmv/14pNBtBQGUEcSAoIklhCReWmnYcwmrFBiP/l1mB
bRI/KF4lbKlt63JE/KKBrfuwCH1jFQZXEQE82yinoEkJ4ho9UDR9sSiTLYYBOcs0
q+Ox1Vam+h3SXM6rkFhL8hHYw0zDKbXEFhHoiIJJP2caeeQIqm7Kmalivjjmuixf
A88D/jD8PYu1p7tz1F5m5GwOvcmv/NM8EASURPECcxNJRcFuCftrKbo40INWIBrU
tdkh5r/t3XYY60jZXPTbkOPVwaSpmIqoausfNIawhYWQS07SG6VbzbsmF+4uN9SA
LszZ/jWvnYfjGhQilnQPiVFV5rAjUMIXvTkuMONhNWWOgbehuPLAPsIXgc1MMHHg
igbwV5TfpSm1korzBEKvtpGpjBfeiyVHxSp2hOnr/x6sZScZ1KNg3ToXGwhnKent
rXz1t1owTXpEKewB+veFvXGh2+f/FHnpvm6gymj5EvKei1GGWY9eBYiyvSOF22P0
zgNjvtDlLO9GCkNPaoBr
=+eVy
-----END PGP SIGNATURE-----

--nextPart3211582.DWLfaaR3Xa--

