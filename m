Return-Path: <mareklindner@neomailbox.ch>
From: Marek Lindner <mareklindner@neomailbox.ch>
Date: Sat, 16 Nov 2013 13:35:53 +0800
Message-ID: <3563164.50QBaKXCKk@diderot>
In-Reply-To: <1384360685-366-2-git-send-email-antonio@meshcoding.com>
References: <1384360685-366-1-git-send-email-antonio@meshcoding.com>
 <1384360685-366-2-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2567869.5xNcxC3Prp";
 micalg="pgp-sha1"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCHv2 1/6] batman-adv: add isolation_mark
	sysfs attribute
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


--nextPart2567869.5xNcxC3Prp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday 13 November 2013 17:38:00 Antonio Quartulli wrote:
> @@ -692,6 +692,8 @@ static int batadv_softif_init_late(struct net_device
> *dev)> 
>  #endif
>  
>         bat_priv->tt.last_changeset = NULL;
>         bat_priv->tt.last_changeset_len = 0;
> 
> +       bat_priv->isolation_mark = 0;
> +       bat_priv->isolation_mark_mask = 0;
> 
>         /* randomize initial seqno to avoid collision */
>         get_random_bytes(&random_seqno, sizeof(random_seqno));

Wasn't the plan to initialize isolation_mark_mask with something useful like 
0xFFFFFFFF ?


> +/**
> + * batadv_store_isolation_mark - parse and store the isolation mark/mask
> entered by + *  the user
> + * @kobj: kobject representing the private mesh sysfs directory
> + * @attr: the batman-adv attribute the user is interacting with
> + * @buf: the buffer containing the user data
> + * @count: number of bytes in the buffer
> + *
> + * Returns 'count' on success or a negative error code in case of failure
> + */
> +static ssize_t batadv_store_isolation_mark(struct kobject *kobj,
> +					   struct attribute *attr, char *buff,
> +					   size_t count)
> +{
> +	struct net_device *net_dev = batadv_kobj_to_netdev(kobj);
> +	struct batadv_priv *bat_priv = netdev_priv(net_dev);
> +	uint32_t mark, mask = UINT_MAX;
> +	char *mask_ptr;
> +
> +	/* parse the mask if it has been specified */
> +	mask_ptr = strchr(buff, '/');
> +	if (mask_ptr) {
> +		*mask_ptr = '\0';
> +		mask_ptr++;
> +
> +		/* the mask must be entered in hex base as it is going to be a
> +		 * bitmask and not a prefix length
> +		 */
> +		if (kstrtou32(mask_ptr, 16, &mask) < 0)
> +			return -EINVAL;
> +	}
> +
> +	/* the mark can be entered in any base */
> +	if (kstrtou32(buff, 0, &mark) < 0)
> +		return -EINVAL;
> +
> +	bat_priv->isolation_mark_mask = mask;
> +	/* erase bits not covered by the mask */
> +	bat_priv->isolation_mark = mark & bat_priv->isolation_mark_mask;
> +
> +	batadv_info(net_dev,
> +		    "New skb mark for extended isolation: %#.8x/%#.8x\n",
> +		    bat_priv->isolation_mark, bat_priv->isolation_mark_mask);
> +
> +	return count;
> +}
> +
> +/**
> + * batadv_show_isolation_mark - print the current isolation mark/mask
> + * @kobj: kobject representing the private mesh sysfs directory
> + * @attr: the batman-adv attribute the user is interacting with
> + * @buf: the buffer that will contain the data to send back to the user
> + *
> + * Returns the number of bytes written into 'buf' on success or a negative
> error + * code in case of failure
> + */
> +static ssize_t batadv_show_isolation_mark(struct kobject *kobj,
> +					  struct attribute *attr, char *buff)
> +{
> +	struct batadv_priv *bat_priv = batadv_kobj_to_batpriv(kobj);
> +
> +	return sprintf(buff, "%#.8x/%#.8x\n", bat_priv->isolation_mark,
> +		       bat_priv->isolation_mark_mask);
> +}

We always have 'show' before 'store' in the sysfs.c file. Please keep the 
order.

Where is the sysfs documentation update ?

Cheers,
Marek

--nextPart2567869.5xNcxC3Prp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAABAgAGBQJShwQ5AAoJEFNVTo/uthzAD34H/02Qb7+OF0qCeXecC7jHRfRY
9woMF2BudjP1PPyu19Sy+97N/Wetir2PA00QofK3J/O5kxGYA62mmXyms+tZSS46
RyKjvOvIL96FyGrvDuU7pwxzCoGmjx3jruMU2Vh2U8lfQ/vHnxIM7eL2XQgUWkXx
+RhlTFk/NS6sykstWLBYyzP5VEuYPFaUa6xpKQgiF8YNBnwgkV2UAogCTS06leCh
BdxUbcaxAu9Qm5KNXYbrPLfHMTfjYYaCQO5beY30Irh5fkp+W6PkIunYFh0Tmy/K
jP8MtC2tPIh6/OlzcapUGN3FntmR54OsBD5U/HBm0GBekBnM/FQFlSUegpaK9BI=
=RVlK
-----END PGP SIGNATURE-----

--nextPart2567869.5xNcxC3Prp--

