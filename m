Return-Path: <sven.eckelmann@gmx.de>
From: Sven Eckelmann <sven.eckelmann@gmx.de>
Date: Sat, 1 May 2010 18:34:56 +0200
References: <1272719410-406-1-git-send-email-andrew@lunn.ch>
	<1272719410-406-3-git-send-email-andrew@lunn.ch>
In-Reply-To: <1272719410-406-3-git-send-email-andrew@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1388338.l9TKyoxUGW";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Content-Transfer-Encoding: 7bit
Message-Id: <201005011837.42615.sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 2/4] batman-adv: Import sparse fixes from
	mainline.
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
Cc: lindner_marek@yahoo.de, b.a.t.m.a.n@lists.open-mesh.net

--nextPart1388338.l9TKyoxUGW
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Andrew Lunn wrote:
> diff --git a/bat_sysfs.c b/bat_sysfs.c
> index 7acf8d8..e2c000b 100644
> --- a/bat_sysfs.c
> +++ b/bat_sysfs.c
> @@ -357,7 +357,8 @@ void sysfs_del_meshif(struct net_device *dev)
>  static ssize_t show_mesh_iface(struct kobject *kobj, struct attribute
> *attr, char *buff)
>  {
> -	struct net_device *net_dev =3D to_net_dev(to_dev(kobj->parent));
> +	struct device *dev =3D to_dev(kobj->parent);
> +	struct net_device *net_dev =3D to_net_dev(dev);
>  	struct batman_if *batman_if =3D get_batman_if_by_netdev(net_dev);

This has not real something to do with this patch (which is good), but=20
to_net_dev was added in v2.6.20-236-g43cb76d and the README still states th=
at=20
we are compatible with linux 2.6.20. I think we must change that to 2.6.25=
=20
(explanation below).

I did a build test with 2.6.19-2.6.28 (have to update my buildenv...):

 * 2.6.19: fails in many ways
 * 2.6.20: fails in bat_sys.c
 * 2.6.21: warnings in bat_sys.c (better call it fail)
 * 2.6.22: warnings in bat_sys.c (better call it fail)
 * 2.6.23: fails
 * 2.6.24: fails
 * 2.6.25: ok
 * 2.6.26: ok
 * 2.6.27: ok
 * 2.6.28: ok

But to your patch:

Acked-by: Sven Eckelmann <sven.eckelmann@gmx.de>

Best regards,
	Sven

--nextPart1388338.l9TKyoxUGW
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABCgAGBQJL3FgyAAoJEF2HCgfBJntG+VcP/jwQuFBgFG+PGCHF5QPCYaOp
dNcL+CNvkBhO+e8GRjbiH8TA5hUcKilIBNq5IqLe0iXYr9syJjNkx1d5OYztbWCJ
+wpGw2oh9digXtI3njGZBM9RkEIPFqGdb11Jr5m/eBGsoBzMgoHqciD0dr6kgSPM
PumQNOdM1HUt9uRztLdJAdxxPT83fwogSINfLTl7sTrAfiuSO1mvzIA8wBt9SL4p
mlRfJI7IdSzAPjtOUS2msxKxow9njdCS1KBghP9VgevN0mw5PaUQnnER9IdLaewc
s5vU8zwCvaqgUXnzHMoQRwYCSBsJnCmf+wK9heDz0uBUJ+bHsaRmWm/avydQ4D0H
UgiJucpF86YYTXYq54rMXDSKtq3vPVDMmLXIxbCGZRABahzrnZJ8DcS/JWwkST9l
jaxfPRuEdHR6EUJUtodD8y0FtIz2CENvsVa76Its/IEjO1+q2l4OyICxjI61oaQW
1bECwvqbwAXYhc3QCGGyZvk1QyHY9EoK9ZwU0ld/nBU9w0qKYfIg+44afCX6XkFg
z6RRxlP/0BmC5GAzLVewGylPGKGtGxyLVRtKqslTNGOlFmL+OlRyc53A40Ujwtbx
mfi5EpcktIOfKeFUxSoWXpFbiTEtTYda1gwBc967hh6TFyZIfhn2PFM5DlOfVxa+
VR0tm4UuwxvGUp/MRqTb
=CNgj
-----END PGP SIGNATURE-----

--nextPart1388338.l9TKyoxUGW--
