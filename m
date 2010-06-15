Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Wed, 16 Jun 2010 00:23:02 +0200
References: <1275498615.23599.12.camel@Joe-Laptop.home>
	<1275509466.23599.43.camel@Joe-Laptop.home>
In-Reply-To: <1275509466.23599.43.camel@Joe-Laptop.home>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9410837.8cLyrOzzOb";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201006160023.04296.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] drivers/staging/batman-adv: Use
	(pr|netdev)_<level> macro helpers
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
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: devel <devel@driverdev.osuosl.org>, b.a.t.m.a.n@lists.open-mesh.net, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Simon Wunderlich <siwu@hrz.tu-chemnitz.de>, Joe Perches <joe@perches.com>, Marek Lindner <lindner_marek@yahoo.de>

--nextPart9410837.8cLyrOzzOb
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Joe Perches wrote:
> Compile tested only
>=20
> Add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> Remove "batman-adv:" from format strings
> Use pr_<level>
> Use netdev_<level>
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> ---

=46ound some time to play a little bit around with your patch and noticed t=
hat
it crashes the kernel. I did my tests using following "interesting" part:

[....]
> @@ -152,18 +155,18 @@ static ssize_t store_vis_mode(struct kobject *kobj,
> struct attribute *attr, if (buff[count - 1] =3D=3D '\n')
>  			buff[count - 1] =3D '\0';
>=20
> -		printk(KERN_INFO "batman-adv:Invalid parameter for 'vis mode' setting =
on mesh %s received: %s\n",
> -		       net_dev->name, buff);
> +		netdev_info(net_dev, "Invalid parameter for 'vis mode' setting on mesh=
 received: %s\n",
> +			    buff);
>  		return -EINVAL;
>  	}
>=20
>  	if (atomic_read(&bat_priv->vis_mode) =3D=3D vis_mode_tmp)
>  		return count;
>=20
> -	printk(KERN_INFO "batman-adv:Changing vis mode from: %s to: %s on mesh:=
 %s\n",
> -	       atomic_read(&bat_priv->vis_mode) =3D=3D VIS_TYPE_CLIENT_UPDATE ?
> -	       "client" : "server", vis_mode_tmp =3D=3D VIS_TYPE_CLIENT_UPDATE ?
> -	       "client" : "server", net_dev->name);
> +	netdev_info(net_dev, "Changing vis mode from: %s to: %s on mesh\n",
> +		    atomic_read(&bat_priv->vis_mode) =3D=3D VIS_TYPE_CLIENT_UPDATE ?
> +		    "client" : "server",
> +		    vis_mode_tmp =3D=3D VIS_TYPE_CLIENT_UPDATE ? "client" : "server");
>=20
>  	atomic_set(&bat_priv->vis_mode, (unsigned)vis_mode_tmp);
>  	return count;
[...]

I compiled the module and loaded it using `insmod batman-adv.ko`. This will
create some files in /sys. Just changed the vis mode to server using:

echo 0 > /sys/class/net/bat0/mesh/vis_mode

And then it will crash at that netdev_info call.

The problem seems to be that dev_printk is used by netdev_printk (which is
used by netdev_info). netdev_printk will add (netdev)->dev.parent as second
parameter of dev_printk (and parent is NULL in our case). This macro will n=
ow
call dev_driver_string with NULL as parameter and just dereference this nul=
l pointer.

Maybe it is related to something else, but at least I think that this could=
 be
the cause of the crash.

Best regards,
	Sven

--nextPart9410837.8cLyrOzzOb
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJMF/1HAAoJEF2HCgfBJntGp4EQAM0w9doUEOLbqwNi2UYnIfe0
1VFfvrBdiB2MmrXBbDXMdg+APoUUZ8f+9aO6rnrZXbKBGJcac6uDoT4BgDBid46Y
A/ua9r4uUrwfg9Od1QlCDrnHKmsrzHdOIACF7GnPNRk5j42FU0siySVWq5PxIDLE
e+GFuB/2BLl16ip/c+mW/sqoXlOfT4Btat2kOlmMkByPJBHB+HF9gQ4XY0IwREzZ
qrAE318v9ILDVxZFfGxuSNnCheVzsE/PkXExvD+T5ldzfAKwnjEtjzTq/T8kUF/b
imcBdQa/jD/i5ddr/FYmTy+wVQqIOCspUsJrlVARrELBsIgWchIkZCM7Q7xmJpc2
XcwQW2Z1FInxIUCnWm4PVfbao751NjGgV+OmwHWBpxphgrqhekGv77K1qL7H7XFV
jSbMOGpTkV95E8VmIwlMgHdxDNFZopHzER4whXjdmjbJ+13ywQRKvbuUxkSYp8TH
W5dl5DxAGpzhjO3erg+cHi1jnTDM7Od27IDZDKLWG5FhtI4jBboqfENXRnRAERWe
fWj4QPQvAjw593BDXRBlTTzHlBA/+Y6wOiyLT3AKf7gnUiswZgb85T6NQbEcw2Su
PLmVa8oZVseoVnAOMAH6+STvUVpJpW4umUZREsC3Zsyvwzjb7trCZm/8x3EziMnz
3jjZsKr1OUF7dJYA6QY4
=TzFV
-----END PGP SIGNATURE-----

--nextPart9410837.8cLyrOzzOb--
