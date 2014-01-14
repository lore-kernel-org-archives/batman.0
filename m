Return-Path: <antonio@meshcoding.com>
Message-ID: <52D530D6.3040004@meshcoding.com>
Date: Tue, 14 Jan 2014 13:43:02 +0100
From: Antonio Quartulli <antonio@meshcoding.com>
MIME-Version: 1.0
References: <1389685269-18600-1-git-send-email-ying.xue@windriver.com>
 <1389685269-18600-8-git-send-email-ying.xue@windriver.com>
In-Reply-To: <1389685269-18600-8-git-send-email-ying.xue@windriver.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mA2NlmA2BririJf0SqDmkClW3SfiEp71V"
Subject: Re: [B.A.T.M.A.N.] [PATCH net-next 07/10] batman-adv: use
 __dev_get_by_index instead of dev_get_by_index to find interface
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
To: Ying Xue <ying.xue@windriver.com>, davem@davemloft.net
Cc: vfalico@redhat.com, stephen@networkplumber.org, dmitry.tarnyagin@lockless.no, socketcan@hartkopp.net, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, john.r.fastabend@intel.com, netdev@vger.kernel.org, johannes@sipsolutions.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mA2NlmA2BririJf0SqDmkClW3SfiEp71V
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/01/14 08:41, Ying Xue wrote:
> The following call chains indicate that batadv_is_on_batman_iface()
> is always under rtnl_lock protection as call_netdevice_notifier()
> is protected by rtnl_lock. So if __dev_get_by_index() rather than
> dev_get_by_index() is used to find interface handler in it, this
> would help us avoid to change interface reference counter.
>=20
> call_netdevice_notifier()
>   batadv_hard_if_event()
>     batadv_hardif_add_interface()
>       batadv_is_valid_iface()
>         batadv_is_on_batman_iface()
>=20
> Cc: Antonio Quartulli <antonio@meshcoding.com>
> Signed-off-by: Ying Xue <ying.xue@windriver.com>

Acked-by: Antonio Quartulli <antonio@meshcoding.com>


> ---
>  net/batman-adv/hard-interface.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-inte=
rface.c
> index bebd46c..115d14e 100644
> --- a/net/batman-adv/hard-interface.c
> +++ b/net/batman-adv/hard-interface.c
> @@ -86,15 +86,13 @@ static bool batadv_is_on_batman_iface(const struct =
net_device *net_dev)
>  		return false;
> =20
>  	/* recurse over the parent device */
> -	parent_dev =3D dev_get_by_index(&init_net, net_dev->iflink);
> +	parent_dev =3D __dev_get_by_index(&init_net, net_dev->iflink);
>  	/* if we got a NULL parent_dev there is something broken.. */
>  	if (WARN(!parent_dev, "Cannot find parent device"))
>  		return false;
> =20
>  	ret =3D batadv_is_on_batman_iface(parent_dev);
> =20
> -	if (parent_dev)
> -		dev_put(parent_dev);
>  	return ret;
>  }
> =20
>=20


--=20
Antonio Quartulli


--mA2NlmA2BririJf0SqDmkClW3SfiEp71V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJS1TDeAAoJEEKTMo6mOh1VOkAP/113xZ1ZzYTc7Zsw6oXq3zYW
o4K/LwnMKITcnMXyhmLdw6ChQ5G7bIXqLC0u/Gk01W+cpnnF+juBexEwCqk9MgkO
UBhs1ASpnUgCSJ0pM7UkKk3q2H7nyod4SY3ldjBl8zwue/crcI9Y6cOxBiPPWUNY
zFTsUchiCTMfH9K4Y13LInw3bWfacW6TeQ7gHH7RUzYBOBkeEx7Kk+OpCm/TeGzS
TVHJs+xKJz95v/U5Q+Q2nsEoOaK010TSjwEcuKvmqkUcSm3T+GT23ZHsVWMxxkoJ
FK9WxSfHQig1Z2YUixUStha+5diOEZwHN1nQ0+CmyiA8OXhdRwxze3fkeQrScTyu
zVVdIuRCzu8EZGwPFKKZhUQ+CKxV9ZQJhg+3lrHo4hS3jKpl01S+D1TWFhbwwIj7
68rpSFLczz3Mg4DpACTWrYMXyDNbSIxEMlbQoerFPQpgh5RyOX61eVmr92vtMWnr
XKcuwbszIP4YfkIFyotMmvRhFcMX2hmNWw69yleMM87b4GgqubB/Vl7ICcqWa5n4
bpUFEOrdC2dliMSjGkkju+WnuC0tXFlhRaZQTYvJ5owQ0UAmSO640nr4OzOSKLiI
46esfS8i1SgSkvTls8nKasR2YOfH5MMRSNp9dqAReFRDCYc3EHeU+bgVMpi0lkxa
ecNK8WbVRK3HdyLV5hCh
=6Exo
-----END PGP SIGNATURE-----

--mA2NlmA2BririJf0SqDmkClW3SfiEp71V--
