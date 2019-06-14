Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] batman-adv: no need to check return value of
 debugfs_create functions
Date: Fri, 14 Jun 2019 20:16:45 +0200
Message-ID: <2060405.LLBHa7GSGR@sven-edge>
In-Reply-To: <20190614071123.GA2922@kroah.com>
References: <20190614071123.GA2922@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3167038.yAbhmPq4Nh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Lindner <mareklindner@neomailbox.ch>, Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

--nextPart3167038.yAbhmPq4Nh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 14 June 2019 09:11:23 CEST Greg Kroah-Hartman wrote:
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.
> 
> Because we don't care if debugfs works or not, this trickles back a bit
> so we can clean things up by making some functions return void instead
> of an error value that is never going to fail.
> 
> Cc: Marek Lindner <mareklindner@neomailbox.ch>
> Cc: Simon Wunderlich <sw@simonwunderlich.de>
> Cc: Antonio Quartulli <a@unstable.cc>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: b.a.t.m.a.n@lists.open-mesh.org
> Cc: netdev@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---

Applied with minor modifications


>  /**
> @@ -333,42 +315,24 @@ void batadv_debugfs_destroy(void)
>   * batadv_debugfs_add_hardif() - creates the base directory for a hard interface
>   *  in debugfs.
>   * @hard_iface: hard interface which should be added.
> - *
> - * Return: 0 on success or negative error number in case of failure
>   */
> -int batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
> +void batadv_debugfs_add_hardif(struct batadv_hard_iface *hard_iface)
>  {
>  	struct net *net = dev_net(hard_iface->net_dev);
>  	struct batadv_debuginfo **bat_debug;
>  	struct dentry *file;


The file variable should be removed here (it is now unused).

> @@ -421,42 +382,28 @@ int batadv_debugfs_add_meshif(struct net_device *dev)
>         struct net *net = dev_net(dev);
>         struct dentry *file;


Same here

> --- a/net/batman-adv/log.c
> +++ b/net/batman-adv/log.c
> @@ -192,25 +192,16 @@ int batadv_debug_log_setup(struct batadv_priv *bat_priv)
>  {
>         struct dentry *d;

Same here

Thanks,
	Sven
--nextPart3167038.yAbhmPq4Nh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl0D5I0ACgkQXYcKB8Em
e0YXEhAAp0mV/u+w8uWC64czNeI7fb0U7mUY4n9g5uPWtnrRO7CMZv7y5Xvo2hUM
1oDKB8sP6vdP5QnKKMqBH7UDctB+YqsqzM8Fel3yjnVjaKtdftQMXc+pTgT4zflI
1IW4XWa8OfNlr7km5wRwnTM4cZtVpdV7mtuOtc2+QHKKjtqRjsElrdIw0HeRXX3u
vhdNGFRgFjW2ihYGrgFH1ZFBXU8Onx2bbZl8wc6M+BHLO/etbd87HlCNeAeEdjPd
/UIEvPGF4iI3IsKbt4yimXTn6kqA9q6VG+DkBLVwcLDTixEgYtt7rYWBAq9haSud
0yeltXJ1eeWSG392LVPp8+8ZCEKOTsbclSDYtQUEiJZLhPuTWy7brkbbgnU0aiBd
mfjVDZ7lyTWoM0jtahUDa5zezq+5aG8+80ZLZ+6Vcg0qln8dNT7cN00wSRX3C4Zc
A21eMvDx3YqpNC4svA3/ZIw1RnBea77F4xgZ/JXismLIwm4XbukoGgP9J2F4LK4G
U3wV5ea8IHLi2+Su0UKuGNg9QpgjHW5WwyJ2E7GoRug1t5f/jwDp0f1p3t1dGSuo
MwS+H2eWsD9BJdw6xc/c7uXbp8L1abE001aroi3zzLvUw0iUbfcbHOUVr1FvTfJr
i5Qy8gO9WgyOYhYpR1r5to92QuueKH/BQh53xVYKT/uMZNcZW0E=
=9ifG
-----END PGP SIGNATURE-----

--nextPart3167038.yAbhmPq4Nh--



