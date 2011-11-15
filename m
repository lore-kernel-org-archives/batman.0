Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Tue, 15 Nov 2011 21:27:23 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111115202723.GA619@pandem0nium>
References: <1320752062-21776-1-git-send-email-ordex@autistici.org>
	<1320752062-21776-8-git-send-email-ordex@autistici.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <1320752062-21776-8-git-send-email-ordex@autistici.org>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 7/7] batman-adv: add Distributed ARP
 Table compile option
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2011 at 12:34:22PM +0100, Antonio Quartulli wrote:
> Signed-off-by: Antonio Quartulli <ordex@autistici.org>
> ---
>  Makefile.kbuild         |    8 +++++++-
>  README                  |    4 ++++
>  distributed-arp-table.h |   12 ++++++++++++
>  3 files changed, 23 insertions(+), 1 deletions(-)
>=20
> diff --git a/Makefile.kbuild b/Makefile.kbuild
> index e8861cb..f09004f 100644
> --- a/Makefile.kbuild
> +++ b/Makefile.kbuild
> @@ -18,6 +18,8 @@
>  # 02110-1301, USA
>  #
> =20
> +# uncomment the following line to enable the Distributed ARP Table featu=
re
> +# CONFIG_BATMAN_ADV_DAT=3Dy
> =20
> =20
>  # openwrt integration
> @@ -27,6 +29,10 @@ endif
> =20
>  # ccflags-y +=3D -DCONFIG_BATMAN_ADV_DEBUG
> =20
> +ifeq ($(CONFIG_BATMAN_ADV_DAT), y)
> +ccflags-y +=3D -DCONFIG_BATMAN_ADV_DAT
> +endif
> +
>  ifneq ($(REVISION),)
>  ccflags-y +=3D -DSOURCE_VERSION=3D\"$(REVISION)\"
>  endif
> @@ -36,7 +42,7 @@ batman-adv-y +=3D bat_debugfs.o
>  batman-adv-y +=3D bat_iv_ogm.o
>  batman-adv-y +=3D bat_sysfs.o
>  batman-adv-y +=3D bitarray.o
> -batman-adv-y +=3D distributed-arp-table.o
> +batman-adv-$(CONFIG_BATMAN_ADV_DAT) +=3D distributed-arp-table.o
>  batman-adv-y +=3D gateway_client.o
>  batman-adv-y +=3D gateway_common.o
>  batman-adv-y +=3D hard-interface.o
> diff --git a/README b/README
> index 5ba56b5..1a27f9f 100644
> --- a/README
> +++ b/README
> @@ -26,6 +26,10 @@ it.  If you work on a backport, feel free to contact u=
s.  :-)
>  COMPILE
>  -------
> =20
> +Before compiling you want to have a look at the Makefile.kbuild
> +file to enable/disable wanted features. Actually there are:
> +- CONFIG_BATMAN_ADV_DAT enables the Distributed ARP Table
> +
>  To compile against your currently installed  kernel, just type:
> =20
>  # make
> diff --git a/distributed-arp-table.h b/distributed-arp-table.h
> index d3fb8b1..496b7f3 100644
> --- a/distributed-arp-table.h
> +++ b/distributed-arp-table.h
> @@ -28,6 +28,8 @@
>  #define ARP_HW_DST(skb) (ARP_HW_SRC(skb) + ETH_ALEN + 4)
>  #define ARP_IP_DST(skb) (*(uint32_t *)(ARP_HW_SRC(skb) + ETH_ALEN * 2 + =
4))
> =20
> +#ifdef CONFIG_BATMAN_ADV_BAT

Took me some time to find this typo :P
please use CONFIG_BATMAN_ADV_DAT, not CONFIG_BATMAN_ADV_BAT or else it won'=
t compile.

> +
>  uint16_t arp_get_type(struct bat_priv *bat_priv, struct sk_buff *skb);
>  bool arp_snoop_outgoing_request(struct bat_priv *bat_priv,
>  				struct sk_buff *skb);
> @@ -36,6 +38,16 @@ bool arp_snoop_incoming_request(struct bat_priv *bat_p=
riv,
>  bool arp_snoop_outgoing_reply(struct bat_priv *bat_priv, struct sk_buff =
*skb);
>  bool arp_snoop_incoming_reply(struct bat_priv *bat_priv, struct sk_buff =
*skb);
> =20
> +#else
> +
> +#define arp_get_type(...) (0)
> +#define arp_snoop_outgoing_request(...) (0)
> +#define arp_snoop_incoming_request(...) (0)
> +#define arp_snoop_outgoing_reply(...)
> +#define arp_snoop_incoming_reply(...)
> +
> +#endif
> +
>  /* hash function to choose an entry in a hash table of given size */
>  /* hash algorithm from http://en.wikipedia.org/wiki/Hash_table */
>  static inline uint32_t hash_ipv4(const void *data, uint32_t size)
> --=20
> 1.7.3.4
>=20
>=20

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk7CyysACgkQrzg/fFk7axb1sQCgwKCNOcDVUgfkA7lLht6dDTyr
rnUAnRvq+SA46Gv+M0J987gBwL9q+RyD
=5oi4
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
