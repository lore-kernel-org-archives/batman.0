Return-Path: <a@unstable.cc>
Date: Thu, 28 Jan 2016 09:28:07 +0800
From: Antonio Quartulli <a@unstable.cc>
Message-ID: <20160128012807.GA22112@prodigo.lan>
References: <1453312110-32683-1-git-send-email-andrew@lunn.ch>
 <1453312110-32683-5-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <1453312110-32683-5-git-send-email-andrew@lunn.ch>
Subject: Re: [B.A.T.M.A.N.] [PATCH 4/4] batman-adv: debugfs: Add netns
	support
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: b.a.t.m.a.n@lists.open-mesh.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 20, 2016 at 06:48:30PM +0100, Andrew Lunn wrote:

[...]

> +static DEFINE_MUTEX(batadv_debugfs_ns_mutex);

[...]

> +static void batadv_debugfs_ns_put(struct net *net)
> +{
> +	struct batadv_debugfs_ns_entry *ns_entry;
> +
> +	mutex_lock(&batadv_debugfs_ns_mutex);
> +	list_for_each_entry(ns_entry, &batadv_debugfs_ns, link) {
> +		if (ns_entry->net =3D=3D net) {
> +			kref_put(&ns_entry->refcount, batadv_ns_entry_release);
> +			break;
> +		}
> +	}
> +	mutex_unlock(&batadv_debugfs_ns_mutex);
> +}
> =20

Andrew, is there any particular reason why in this case we use a mutex inst=
ead
of a spinlock + RCU ? I imagine it is something related to debugfs..or just=
 to
make the code simpler as we don't really require a full-blown RCU strategy ?



>  int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
>  {
> +	char *name =3D hard_iface->net_dev->name;
> +	struct net *net =3D dev_net(hard_iface->net_dev);

here we should respect David's inverted Christmas tree rule :)

>  	struct batadv_debuginfo **bat_debug;
> +	struct dentry *debugfs_ns_dir;
>  	struct dentry *file;
> =20
>  	if (!batadv_debugfs)
>  		goto out;
> =20
> -	hard_iface->debug_dir =3D debugfs_create_dir(hard_iface->net_dev->name,
> -						   batadv_debugfs);

how about:

	debugfs_ns_dir =3D batadv_debugfs;

> +	if (net !=3D &init_net) {
> +		debugfs_ns_dir =3D batadv_debugfs_ns_get(net);
> +		if (!debugfs_ns_dir)
> +			goto out;
	}

	hard_iface->debug_dir =3D debugfs_create_dir(name, debugfs_ns_dir);

isn't it nicer? :)


>  	if (!hard_iface->debug_dir)
>  		goto out;
> =20

[...]

> -	bat_priv->debug_dir =3D debugfs_create_dir(dev->name, batadv_debugfs);
> +	if (net !=3D &init_net) {
> +		debugfs_ns_dir =3D batadv_debugfs_ns_get(net);
> +		if (!debugfs_ns_dir)
> +			goto out;
> +		bat_priv->debug_dir =3D debugfs_create_dir(dev->name,
> +							 debugfs_ns_dir);
> +	} else {
> +		bat_priv->debug_dir =3D debugfs_create_dir(dev->name,
> +							 batadv_debugfs);
> +	}

same as above


> +
>  	if (!bat_priv->debug_dir)
>  		goto out;
> =20



--=20
Antonio Quartulli

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWqW6mAAoJENpFlCjNi1MRSGkP/RXxw5tY/gi3akORvPRm3F1Q
5E50CajNu6otVtHNfcKu5eBTEix2dTyNC058I+CPEbMRf7tN47D96pEhGSYxWHNd
TSoBw2Rpgk8wfd1IWom1SfRewcxseV8uiIe0Gx73Otg6SO/BQa9+0MybaMjICjLF
9LUkSA23YGhPVjcSdgKrOJTbaHd0Inc1ojklhFBKYVCJsc/QL7qDJzGDQn06XVtF
9qAKjyegZqr0gxlbozke6kALXVt03vA1g/VP+g7m445yUf0eZxcMAe4ZTu84guD3
2rA7g2ENBTEim/5/3pDX0aAi8k/tr2RjaRJnr236pVmbWtTuz4GgTN9BTOUAdeng
4IkWbyyWemcXcfPVlro2i51mDPhkKR9nOhLCJDpMOZ8aAQT0rf8+OYfcz5vPeJxr
WYaDsuIh1v8wuVB3OrvFoQBKnaGihUGn0OCoYnnpgiINFZAh9PvTxjfAgoebJkAm
LTlAw0ZIa5EENfrwQlP2HvvQCwr+R4RURvLEvcIBgdKt4EZ58ccqJPdHdu9/zi9s
XqEP1ZNpxFquko8oH95ZDguIlL5+QlJKNj4S+MN8K/1OjNzBLN7zsmoY9Qas3zfX
uHf/4CK2lsrRqCFEpPPRW+OOuJNvyC4vI9sf8/IgGjAVEC8pj7p3unk6dfr74M3C
TatbqaY2KrqpqbF3blhN
=TD0N
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
