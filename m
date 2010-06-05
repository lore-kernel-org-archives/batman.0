Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Sat, 5 Jun 2010 19:44:44 +0200
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20100605174443.GA9284@pandem0nium>
References: <1275509418.23599.42.camel@Joe-Laptop.home>
	<1275661137-28878-1-git-send-email-sven.eckelmann@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <1275661137-28878-1-git-send-email-sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv2-trunk] batman-adv: Convert MAC_FMT
	to	%pM
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


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=utf8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thank you, i've applied this patch in svn r1688.=20

I've tested compiling against 2.6.21, 2.6.24, 2.6.27 - no problem.

best regards,
	Simon
On Fri, Jun 04, 2010 at 04:18:57PM +0200, Sven Eckelmann wrote:
> From: Joe Perches <joe@perches.com>
>=20
> Remove the last uses of MAC_FMT
>=20
> Signed-off-by: Joe Perches <joe@perches.com>
> [sven.eckelmann@gmx.de: Adapted for current batman-adv version]
> Signed-off-by: Sven Eckelmann <sven.eckelmann@gmx.de>
> ---
>  Marek, can you please test it with 2.6.21?
>  It was rebased on top of "bonding and interface alternating"
>=20
>  batman-adv-kernelland/bat_printk.c        |   50 +++++++++++++++++++++++=
++++++
>  batman-adv-kernelland/compat.h            |   12 +++---
>  batman-adv-kernelland/main.c              |    3 +-
>  batman-adv-kernelland/translation-table.c |   24 ++-----------
>  4 files changed, 61 insertions(+), 28 deletions(-)
>=20
> diff --git a/batman-adv-kernelland/bat_printk.c b/batman-adv-kernelland/b=
at_printk.c
> index 55c351a..4a02d7e 100644
> --- a/batman-adv-kernelland/bat_printk.c
> +++ b/batman-adv-kernelland/bat_printk.c
> @@ -859,3 +859,53 @@ asmlinkage int bat_printk(const char *fmt, ...)
> =20
>  	return printk("%s", buf);
>  }
> +
> +/**
> + * sprintf - Format a string and place it in a buffer
> + * @buf: The buffer to place the result into
> + * @fmt: The format string to use
> + * @...: Arguments for the format string
> + *
> + * The function returns the number of characters written
> + * into @buf. Use snprintf() or scnprintf() in order to avoid
> + * buffer overflows.
> + *
> + * See the vsnprintf() documentation for format string extensions over C=
99.
> + */
> +int bat_sprintf(char *buf, const char *fmt, ...)
> +{
> +	va_list args;
> +	int i;
> +
> +	va_start(args, fmt);
> +	i =3D bat_vsnprintf(buf, INT_MAX, fmt, args);
> +	va_end(args);
> +
> +	return i;
> +}
> +
> +/**
> + * snprintf - Format a string and place it in a buffer
> + * @buf: The buffer to place the result into
> + * @size: The size of the buffer, including the trailing null space
> + * @fmt: The format string to use
> + * @...: Arguments for the format string
> + *
> + * The return value is the number of characters which would be
> + * generated for the given input, excluding the trailing null,
> + * as per ISO C99.  If the return is greater than or equal to
> + * @size, the resulting string is truncated.
> + *
> + * See the vsnprintf() documentation for format string extensions over C=
99.
> + */
> +int bat_snprintf(char *buf, size_t size, const char *fmt, ...)
> +{
> +	va_list args;
> +	int i;
> +
> +	va_start(args, fmt);
> +	i =3D bat_vsnprintf(buf, size, fmt, args);
> +	va_end(args);
> +
> +	return i;
> +}
> diff --git a/batman-adv-kernelland/compat.h b/batman-adv-kernelland/compa=
t.h
> index a211a36..614d116 100644
> --- a/batman-adv-kernelland/compat.h
> +++ b/batman-adv-kernelland/compat.h
> @@ -74,12 +74,6 @@ static inline int skb_clone_writable(struct sk_buff *s=
kb, unsigned int len)
> =20
>  #endif /* < KERNEL_VERSION(2, 6, 23) */
> =20
> -#if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 24)
> -
> -#define MAC_FMT "%02x:%02x:%02x:%02x:%02x:%02x"
> -
> -#endif /* < KERNEL_VERSION(2, 6, 24) */
> -
>  #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 6, 25)
> =20
>  #define strict_strtoul(cp, base, res) \
> @@ -235,6 +229,12 @@ next_sibling:
>  asmlinkage int bat_printk(const char *fmt, ...);
>  #define printk bat_printk
> =20
> +int bat_sprintf(char *buf, const char *fmt, ...);
> +#define sprintf bat_sprintf
> +
> +int bat_snprintf(char *buf, size_t size, const char *fmt, ...);
> +#define snprintf bat_snprintf
> +
>  static inline struct net_device_stats *dev_get_stats(struct net_device *=
dev)
>  {
>  	if (dev->get_stats)
> diff --git a/batman-adv-kernelland/main.c b/batman-adv-kernelland/main.c
> index c9132c0..20a0d54 100644
> --- a/batman-adv-kernelland/main.c
> +++ b/batman-adv-kernelland/main.c
> @@ -227,8 +227,7 @@ void dec_module_count(void)
> =20
>  int addr_to_string(char *buff, uint8_t *addr)
>  {
> -	return sprintf(buff, MAC_FMT,
> -		       addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]);
> +	return sprintf(buff, "%pM", addr);
>  }
> =20
>  /* returns 1 if they are the same originator */
> diff --git a/batman-adv-kernelland/translation-table.c b/batman-adv-kerne=
lland/translation-table.c
> index 009789e..8edc175 100644
> --- a/batman-adv-kernelland/translation-table.c
> +++ b/batman-adv-kernelland/translation-table.c
> @@ -200,13 +200,8 @@ int hna_local_seq_print_text(struct seq_file *seq, v=
oid *offset)
>  	while (hash_iterate(hna_local_hash, &hashit)) {
>  		hna_local_entry =3D hashit.bucket->data;
> =20
> -		pos +=3D snprintf(buff + pos, 22, " * " MAC_FMT "\n",
> -				hna_local_entry->addr[0],
> -				hna_local_entry->addr[1],
> -				hna_local_entry->addr[2],
> -				hna_local_entry->addr[3],
> -				hna_local_entry->addr[4],
> -				hna_local_entry->addr[5]);
> +		pos +=3D snprintf(buff + pos, 22, " * %pM\n",
> +				hna_local_entry->addr);
>  	}
> =20
>  	spin_unlock_irqrestore(&hna_local_hash_lock, flags);
> @@ -418,19 +413,8 @@ int hna_global_seq_print_text(struct seq_file *seq, =
void *offset)
>  		hna_global_entry =3D hashit.bucket->data;
> =20
>  		pos +=3D snprintf(buff + pos, 44,
> -				" * " MAC_FMT " via " MAC_FMT "\n",
> -				hna_global_entry->addr[0],
> -				hna_global_entry->addr[1],
> -				hna_global_entry->addr[2],
> -				hna_global_entry->addr[3],
> -				hna_global_entry->addr[4],
> -				hna_global_entry->addr[5],
> -				hna_global_entry->orig_node->orig[0],
> -				hna_global_entry->orig_node->orig[1],
> -				hna_global_entry->orig_node->orig[2],
> -				hna_global_entry->orig_node->orig[3],
> -				hna_global_entry->orig_node->orig[4],
> -				hna_global_entry->orig_node->orig[5]);
> +				" * %pM via %pM\n", hna_global_entry->addr,
> +				hna_global_entry->orig_node->orig);
>  	}
> =20
>  	spin_unlock_irqrestore(&hna_global_hash_lock, flags);
> --=20
> 1.7.1
>=20
>=20

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkwKjQsACgkQrzg/fFk7axbVxwCgunhGSKDK1m3300gxr+rdDzeI
F4YAoPSNS1xJOuQKYOjDqVwFdSPnWF22
=f9f9
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
