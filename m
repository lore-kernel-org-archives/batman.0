Return-Path: <ordex@autistici.org>
Date: Sat, 10 Aug 2013 13:03:03 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130810110303.GA849@ritirata.org>
References: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <1373242365-763-1-git-send-email-mihail.costea2005@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/6] batman-adv: Generalize DAT in order to
 support any type of data, not only IPv4
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


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mihail,

sorry for the very looong delay :)
I'm finally sitting at my new location and I can give you some feedback on =
your
nice work.
Comments are inline.

On Mon, Jul 08, 2013 at 03:12:40AM +0300, mihail.costea2005@gmail.com wrote:
> From: Mihail Costea <mihail.costea90@gmail.com>
>=20
> Mades DAT support more types by making its data a void*, adding type field
> to dat_entry and adding data_type to necessary functions.
> This change is needed in order to make DAT support any type of data, like=
 IPv6 too.
>=20
> Adds generic function for transforming DAT data to string.
> The function is used in order to avoid defining different debug messages
> for different DAT data types. For example, if we had IPv6 as a DAT data,
> then "%pI4" should be "%pI6c", but all
> the other text of the debug message would be the same.
> Also everything is memorized in a struct in order to avoid further
> switch cases for all types.
>=20
> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>=20
> ---
>  distributed-arp-table.c |  197 +++++++++++++++++++++++++++++++++++------=
------
>  distributed-arp-table.h |    1 +
>  types.h                 |   24 +++++-
>  3 files changed, 169 insertions(+), 53 deletions(-)
>=20
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index f2543c2..90565d0 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -31,9 +31,32 @@
>  #include "types.h"
>  #include "translation-table.h"
> =20
> +static struct batadv_dat_type_info batadv_dat_types_info[] =3D {
> +	{
> +		.size =3D sizeof(__be32),
> +		.str_fmt =3D "%pI4",
> +	},
> +};
> +
>  static void batadv_dat_purge(struct work_struct *work);
> =20
>  /**
> + * batadv_dat_data_to_str: transforms DAT data to string
> + * @data: the DAT data
> + * @type: type of data
> + * @buf: the buf where the data string is stored
> + * @buf_len: buf length
> + *
> + * Returns buf.
> + */
> +static char *batadv_dat_data_to_str(void *data, uint8_t type,
> +				    char *buf, size_t buf_len)
> +{
> +	snprintf(buf, buf_len, batadv_dat_types_info[type].str_fmt, data);
> +return buf;

alignment.
Remember to check your patches with "checkpatch.pl --strict" before sending=
=2E It
will tell you about these hidden mistakes.

> +}
> +
> +/**
>   * batadv_dat_start_timer - initialise the DAT periodic worker
>   * @bat_priv: the bat priv with all the soft interface information
>   */
> @@ -45,6 +68,19 @@ static void batadv_dat_start_timer(struct batadv_priv =
*bat_priv)
>  }
> =20
>  /**
> + * batadv_dat_entry_free_ref_rcu - free a dat entry using its rcu
> + * @rcu: the dat entry rcu
> + */
> +static void batadv_dat_entry_free_ref_rcu(struct rcu_head *rcu)
> +{
> +	struct batadv_dat_entry *dat_entry;
> +
> +	dat_entry =3D container_of(rcu, struct batadv_dat_entry, rcu);
> +	kfree(dat_entry->data);
> +	kfree(dat_entry);
> +}
> +
> +/**
>   * batadv_dat_entry_free_ref - decrement the dat_entry refcounter and po=
ssibly
>   * free it
>   * @dat_entry: the entry to free
> @@ -52,7 +88,7 @@ static void batadv_dat_start_timer(struct batadv_priv *=
bat_priv)
>  static void batadv_dat_entry_free_ref(struct batadv_dat_entry *dat_entry)
>  {
>  	if (atomic_dec_and_test(&dat_entry->refcount))
> -		kfree_rcu(dat_entry, rcu);
> +		call_rcu(&dat_entry->rcu, batadv_dat_entry_free_ref_rcu);
>  }
> =20

since you are not using the kfree_rcu() function anymore, you should also d=
elete
the compatibility function we have in compat.c (and its declaration in
compat.h).

>  /**
> @@ -136,12 +172,21 @@ static void batadv_dat_purge(struct work_struct *wo=
rk)
>   *
>   * Returns 1 if the two entries are the same, 0 otherwise.
>   */
> -static int batadv_compare_dat(const struct hlist_node *node, const void =
*data2)
> +static int  batadv_compare_dat(const struct hlist_node *node, const void=
 *data2)
>  {
> -	const void *data1 =3D container_of(node, struct batadv_dat_entry,
> -					 hash_entry);
> +	struct batadv_dat_entry *dat_entry1 =3D
> +			container_of(node, struct batadv_dat_entry,
> +				     hash_entry);
> +	struct batadv_dat_entry *dat_entry2 =3D
> +			container_of(data2,
> +				     struct batadv_dat_entry, data);

These assignments are really ugly :-P.
Please make the assignments after the declarations. They will look much bet=
ter.

> +	size_t data_size =3D batadv_dat_types_info[dat_entry1->type].size;
> =20
> -	return (memcmp(data1, data2, sizeof(__be32)) =3D=3D 0 ? 1 : 0);
> +	if (dat_entry1->type !=3D dat_entry2->type)
> +		return 0;
> +
> +	return (memcmp(dat_entry1->data, dat_entry2->data,
> +			data_size) =3D=3D 0 ? 1 : 0);
>  }
> =20
>  /**
> @@ -198,8 +243,9 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, =
int hdr_size)
>  }
> =20
>  /**
> - * batadv_hash_dat - compute the hash value for an IP address
> + * batadv_hash_dat - compute the hash value for a DAT data
>   * @data: data to hash
> + * @data_type: type of data
>   * @size: size of the hash table
>   *
>   * Returns the selected index in the hash table for the given data.
> @@ -209,7 +255,8 @@ static uint32_t batadv_hash_dat(const void *data, uin=
t32_t size)
>  	uint32_t hash =3D 0;
>  	const struct batadv_dat_entry *dat =3D data;
> =20
> -	hash =3D batadv_hash_bytes(hash, &dat->ip, sizeof(dat->ip));
> +	hash =3D batadv_hash_bytes(hash, dat->data,
> +				 batadv_dat_types_info[dat->type].size);
>  	hash =3D batadv_hash_bytes(hash, &dat->vid, sizeof(dat->vid));
> =20
>  	hash +=3D (hash << 3);
> @@ -223,32 +270,40 @@ static uint32_t batadv_hash_dat(const void *data, u=
int32_t size)
>   * batadv_dat_entry_hash_find - look for a given dat_entry in the local =
hash
>   * table
>   * @bat_priv: the bat priv with all the soft interface information
> - * @ip: search key
> + * @data: search key
> + * @data_type: type of data
>   * @vid: VLAN identifier
>   *
>   * Returns the dat_entry if found, NULL otherwise.
>   */
>  static struct batadv_dat_entry *
> -batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
> -			   unsigned short vid)
> +batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, void *data,
> +			   uint8_t data_type, unsigned short vid)
>  {
>  	struct hlist_head *head;
>  	struct batadv_dat_entry to_find, *dat_entry, *dat_entry_tmp =3D NULL;
>  	struct batadv_hashtable *hash =3D bat_priv->dat.hash;
> -	uint32_t index;
> +	uint32_t index, data_size =3D batadv_dat_types_info[data_type].size;
> =20
>  	if (!hash)
>  		return NULL;
> =20
> -	to_find.ip =3D ip;
> +	to_find.data =3D kmalloc(data_size, GFP_ATOMIC);
> +	if (!to_find.data)
> +		return NULL;
> +	memcpy(to_find.data, data, data_size);

why do you create a copy of the data? It is going to be read only by the ha=
shing
function. I think you can reuse the same data passed as argument no? You can
directly assign "to_find.data =3D data;", can't you?

> +	to_find.type =3D data_type;
>  	to_find.vid =3D vid;
> =20
>  	index =3D batadv_hash_dat(&to_find, hash->size);
>  	head =3D &hash->table[index];
> +	kfree(to_find.data);
> =20

=2E.consequently, this kfree can be deleted.

>  	rcu_read_lock();
>  	hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
> -		if (dat_entry->ip !=3D ip)
> +		if (dat_entry->type !=3D data_type)
> +			continue;
> +		if (memcmp(dat_entry->data, data, data_size))
>  			continue;
> =20
>  		if (!atomic_inc_not_zero(&dat_entry->refcount))
> @@ -265,25 +320,30 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_=
priv, __be32 ip,
>  /**
>   * batadv_dat_entry_add - add a new dat entry or update it if already ex=
ists
>   * @bat_priv: the bat priv with all the soft interface information
> - * @ip: ipv4 to add/edit
> - * @mac_addr: mac address to assign to the given ipv4
> + * @data: the data to add/edit
> + * @data_type: type of the data added to DAT
> + * @mac_addr: mac address to assign to the given data
>   * @vid: VLAN identifier
>   */
> -static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
> -				 uint8_t *mac_addr, unsigned short vid)
> +static void batadv_dat_entry_add(struct batadv_priv *bat_priv, void *dat=
a,
> +				 uint8_t data_type, uint8_t *mac_addr,
> +				 unsigned short vid)

here I realised we have a small conceptual problem.
what we are calling "data" is not the real data, but is the "key".
The data instead is supposed to be what we store in the entry: the mac addr=
ess
(that could possibly be generalised too..).

I think generalising the data is not very important now. We have an ARP/ND =
table
for now, so we can assume we only want to store MAC addresses, but I would
suggest to rename the member (and so the variables) from "data" to "key".
It makes much more sense in terms of DHT. (Tell me if you think I am not ri=
ght).


=46rom now on I'll try to speed up the reviews so that we can get this thin=
g done
soonish ;)


Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSBh3nAAoJEADl0hg6qKeO9ZsP/AoF+MvhHupo21lbXaOoTmiC
4H2iMRdYSVVjR2Jb9IrIdp/uxDFlHwBEg2j9mLjp3lVQ93+Oa9kd8nMQlLzYukP/
2ygGtocWD9nLnFriDDgS/rJ10eq2IhtZ2kj/FlVWa7eonVFWz24dDxR6ULUc+4I0
QODfb+aHP4sAuoo5dOWBhw/e10lRDrZ0ay7+dU8qGyoDXDajDdMBpvxGug+d+Ie0
eYhV8XpZ8se/G7ZT9sQ4sxvuhFPUd9YDl55R7y2RZD9JPTGM9pjQEl5C4BKerwEL
bbD5HSZXLPY4AS5DjXKRRmAkzbbrUsDA1XdUdrRfPkM5IBRPm2O5KewSkVidSOPD
6W6JeZYADCc+GuGD4Bjqshxr3jCjQOvKVIkYSDWBj/AX6G2whMQ9evLvVV77leIl
Ynv9eaUC5cCA30QBLr6HA6c65LF9JXb2fYneQ0lIRvqyxmW+HfQbMeM3G9HOlaYu
ut7tJwGSSFI2VBw8zREmtHTukCNYJMeEqhYQjxsrggu4qwWB0to2KVJsrYfGfSxI
iktiLQFF8IFjUKqk71o9DOXsO0nnrIVDESh1cJf5WrQZ8yJ0PPnDPBB37+kLXpBu
BrD6Iq7yPEG0bUuEyaoabfWA5HcfAA18wC/wGdAyiCu6f2AgtQEINOxx5OQdlFJ9
5UwVb4NtS7Mlqdpol3Fe
=OLo7
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
