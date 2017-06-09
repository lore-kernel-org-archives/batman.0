Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 09 Jun 2017 09:23:09 +0200
Message-ID: <5895676.ebVRaD88im@bentobox>
In-Reply-To: <1493121800-28066-1-git-send-email-gfree.wind@foxmail.com>
References: <1493121800-28066-1-git-send-email-gfree.wind@foxmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1579445.UNeM99XEuf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH net] net: batman-adv: Fix possible
 memleaks when fail to register_netdevice
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
Cc: gfree.wind@foxmail.com, mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc, davem@davemloft.net, netdev@vger.kernel.org, Gao Feng <fgao@ikuai8.com>

--nextPart1579445.UNeM99XEuf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 25. April 2017 20:03:20 CEST gfree.wind@foxmail.com wrote:
> From: Gao Feng <fgao@ikuai8.com>
> 
> Because the func batadv_softif_init_late allocate some resources and
> it would be invoked in register_netdevice. So we need to invoke the
> func batadv_softif_free instead of free_netdev to cleanup when fail
> to register_netdevice.
> 
> Signed-off-by: Gao Feng <fgao@ikuai8.com>
> ---
>  net/batman-adv/soft-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/batman-adv/soft-interface.c b/net/batman-adv/soft-interface.c
> index d042c99..90bf990 100644
> --- a/net/batman-adv/soft-interface.c
> +++ b/net/batman-adv/soft-interface.c
> @@ -1011,7 +1011,7 @@ struct net_device *batadv_softif_create(struct net *net, const char *name)
>  	if (ret < 0) {
>  		pr_err("Unable to register the batman interface '%s': %i\n",
>  		       name, ret);
> -		free_netdev(soft_iface);
> +		batadv_softif_free(soft_iface);
>  		return NULL;
>  	}

It looks to me like this change is invalid after David's change [1]. Can you
confirm that?

Thanks,
	Sven

[1] https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=cf124db566e6b036b8bcbe8decbed740bdfac8c6
--nextPart1579445.UNeM99XEuf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlk6TN0ACgkQXYcKB8Em
e0Yi8BAAt6XzoJ1aa84L8sH3tbcRDhK1p925Fgt5D5wLnZ6CUwlwxYCOOTfQgNUP
nF2sn7no6k28ug1FoGHYms5XdQtp+kkEDLBzxibK9rkQ/+ZR0EAdqAJ8Ob4gBgmD
730sRF3HUPXLHcbbbrGsVDEpdVYPXUJmBdyJg6L5+RpU2vGgaqAo6/uYaSVXzLuD
TO4SlyjLihzN80+aA/BkSMDYB34RvhCunckNABLFGmJ+Gd0k6tqxc3xpo7sWKn44
CoZCstfRn4uf4kYqjyWbVSXRnv+x6h/UMIuzY623NsWURR6hFbdZipWbgPB4bGOq
qbx8cEFIv36cSo7GkNyOhGXahdYUsa5htf6RkTIcElZvIGci5ARUkf+DwS5IdCai
80+5hl82BXOMs1O8HIfJLeSIt2Q4MpyTHDgauPrqSdb5ZJYYtJxsMHB2n4n3SE4r
/w39gDiF9MvMM+lCe0URzJbOGDYcJFWFDd35hooQIzzf0KrUq6RVhFNgprE5SRXV
W3KpfNED/AqgdlZZGfZ/x7nifEeo6wZMZoEFASt/IV32lnIwHHar0V3WOwPSDW9y
ED80CjL47PdYf0ru/sWgOn2Ji2QhHmlxzxjwoA0ficsfhNxHm1/PDOlqCMgq05hx
K2PpNi6Qr1Nrr9DcgjNVYvIM7wMOS69sBrLKuPCGkQrgwe+V1o4=
=SWA+
-----END PGP SIGNATURE-----

--nextPart1579445.UNeM99XEuf--

