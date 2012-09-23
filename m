Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 23 Sep 2012 10:42:05 +0200
Message-ID: <1472405.uQj6TZy5i4@sven-desktop.home.narfation.org>
In-Reply-To: <CANMkaoyhATZnFpRTDQXPFUOyPXnVOzTHgr5O1+UwZgmYZ9tvYA@mail.gmail.com>
References: <CANMkaozByUVfK9h_UAY08UDCZd6xJWg7NqPpCTWJfsyaBnEJEA@mail.gmail.com>
 <20120920114250.GA29329@ritirata.org>
 <CANMkaoyhATZnFpRTDQXPFUOyPXnVOzTHgr5O1+UwZgmYZ9tvYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2618328.3rLe6Sohy1";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCHv2] batman-adv: Fix change mac address of
	soft iface.
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart2618328.3rLe6Sohy1
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 20 September 2012 14:56:13 Def wrote:
> Into function interface_set_mac_addr, the function tt_local_add was
> invoked before updating dev->dev_addr. The new MAC address was not
> tagged as NoPurge.
> 
> Signed-off-by: Def <def@laposte.net>
> ---
>  soft-interface.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/soft-interface.c b/soft-interface.c
> index cf26e41..1345b86
> --- a/soft-interface.c
> +++ b/soft-interface.c
> @@ -100,18 +100,21 @@ static int batadv_interface_set_mac_addr(struct
> net_device *dev, void *p)
>  {
>  	struct batadv_priv *bat_priv = netdev_priv(dev);
>  	struct sockaddr *addr = p;
> +	uint8_t old_addr[ETH_ALEN];
> 
>  	if (!is_valid_ether_addr(addr->sa_data))
>  		return -EADDRNOTAVAIL;
> 
> +	memcpy(old_addr, dev->dev_addr, ETH_ALEN);
> +	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
> +
>  	/* only modify transtable if it has been initialized before */
>  	if (atomic_read(&bat_priv->mesh_state) == BATADV_MESH_ACTIVE) {
> -		batadv_tt_local_remove(bat_priv, dev->dev_addr,
> +		batadv_tt_local_remove(bat_priv, old_addr,
>  				       "mac address changed", false);
>  		batadv_tt_local_add(dev, addr->sa_data, BATADV_NULL_IFINDEX);
>  	}
> -
> -	memcpy(dev->dev_addr, addr->sa_data, ETH_ALEN);
> +
>  	dev->addr_assign_type &= ~NET_ADDR_RANDOM;
>  	return 0;
>  }


Your patch is malformed:

Applying: batman-adv: Fix change mac address of soft iface.
fatal: corrupt patch at line 10
Patch failed at 0001 batman-adv: Fix change mac address of soft iface.
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

Please use a mailer that doesn't eat the patch. For more information read 
http://os1a.cs.columbia.edu/lxr/source/Documentation/email-clients.txt

I personally prefer to use git-send-email with msmtp

Kind regards,
	Sven
--nextPart2618328.3rLe6Sohy1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQXstdAAoJEF2HCgfBJntGn1cP/3+ICjGmUqmnBNe9KGLZefnh
uysLYw7lk8qayMzezOQ6lSIPuxCCsifAEuLzGoyXJYLeoyPxkacEJE9PPmQGQZ7F
6XL2an+Mk5SvXjfvOVnd630E8o2CIwNyQnNdeFIKVwY34necy+ykzC69WUtOPzkX
rqY1fP99WN4qowZuOm3qBSoDM6CgbNi8/UZBXPuhTxQ/TUXhioKsgjbDAuTZn/8T
OFRPUU4kiAYvrpVdIA1WraVPgUOsGwuPPZH5KE9gGeiO4XubUbR78R+5WBR7b+2p
Nn86ubxO8a1UsqcPenEeCLVL3JIUPJ7Ja/g/OPal/zIJskzUhs1gYG21KPNmw0uA
uYPZn4HixGFbGa4kn/y6uVzSlv628+m0GZ/sBWwzKuBqNGZSIXeX0GSR5tL802qI
q5T6jVbRoKaqXxi6M9bmKbH0plDERffGPGbJpKrNUsdM85uo3suRNKsmpZ+KIMN4
gSVYV0s2yAgOIzDQvFOIVJFUeOy1XPlGR0WEND/CSrpZSDjn6/onKKHaDzUl4uCS
rBqVHRTrcMZAPEJOqQe9OnsS8jC7ckl9MZ/k179I9qeBagpAEwbpPy8n6eHzryPN
8OFH8E2hU4Di0XI9nWU5inkEmNQq1uOhQDI/Rqq6taC0B5U8p8+pzVKvtG35ILAZ
yPUb5Of3H4Q34g9QjhOT
=zA3T
-----END PGP SIGNATURE-----

--nextPart2618328.3rLe6Sohy1--

