Return-Path: <antonio@meshcoding.com>
Date: Wed, 18 Sep 2013 21:21:46 +0200
From: Antonio Quartulli <antonio@meshcoding.com>
Message-ID: <20130918192146.GI3053@neomailbox.net>
References: <1378903492-2604-1-git-send-email-mihail.costea90@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="uc35eWnScqDcQrv5"
Content-Disposition: inline
In-Reply-To: <1378903492-2604-1-git-send-email-mihail.costea90@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Generalize DAT in order to
 support any type of key/value, not only IPv4 and MAC
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


--uc35eWnScqDcQrv5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2013 at 03:44:52PM +0300, Mihail Costea wrote:
> Mades DAT support more types by making its key and value a void* and
> by adding type field to dat_entry.
> This change is needed in order to make DAT support any type of keys,
> like IPv6 too.
>=20
> Adds generic function for transforming any data to string.
> The function is used in order to avoid defining different debug messages
> for different DAT key/value types. For example, if we had IPv6 as a DAT k=
ey,
> then "%pI4" should be "%pI6c", but all the other text of the debug message
> would be the same.
> Also everything is memorized in a struct in order to avoid further
> switch cases for all types.
>=20
> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>=20

the commit message should be revised a bit because it is not very clear.....
It has to give a general idea. Talking about void*, %pI4 is not useful to m=
ake a
person understand what change we are really bringing.
I can understand because I know the patch, but imagine how it could be from=
 a
totally agnostic prospective.

[...]

> +/**
> + * batadv_dat_data_to_str: transforms a given data to a string using str=
_fmt

kerneldoc starts with:

function name - short description

so you have to use the '-' instead of the ':'

> + * @data: the data to transform
> + * @str_fmt: string format
> + * @buf: the buf where the key string is stored

what is "the buf"? You meant "the buffer" ?

> + * @buf_len: buf length

same here.

> + *
> + * Returns buf.
> + */
> +static char *batadv_dat_data_to_str(void *data, char *str_fmt,
> +				    char *buf, size_t buf_len)

Wouldn't it be better to pass the data_type and let the function choose the
str_fmt from the array? This way this function becomes more generic and can=
 be
used in any context. I thought we agreed on this already.

EDIT: I noted later that you use this function both for the key and for the
value (maybe this is why you kept it this way). At this point I'd rather su=
ggest
to remove the function at all and use the snprintf() at its place. What do =
you
think?

> +{
> +	snprintf(buf, buf_len, str_fmt, data);
> +	return buf;
> +}
> +
>  /**
>   * batadv_dat_start_timer - initialise the DAT periodic worker
>   * @bat_priv: the bat priv with all the soft interface information
> @@ -132,16 +157,24 @@ static void batadv_dat_purge(struct work_struct *wo=
rk)
>  /**
>   * batadv_compare_dat - comparing function used in the local DAT hash ta=
ble
>   * @node: node in the local table
> - * @data2: second object to compare the node to
> + * @key2: second object to compare the node to
>   *
>   * Returns 1 if the two entries are the same, 0 otherwise.
>   */
> -static int batadv_compare_dat(const struct hlist_node *node, const void =
*data2)
> +static int batadv_compare_dat(const struct hlist_node *node, const void =
*key2)
>  {
> -	const void *data1 =3D container_of(node, struct batadv_dat_entry,
> -					 hash_entry);
> +	const struct batadv_dat_entry *dat_entry1, *dat_entry2;
> +	size_t key_size;
> =20
> -	return (memcmp(data1, data2, sizeof(__be32)) =3D=3D 0 ? 1 : 0);
> +	dat_entry1 =3D container_of(node, struct batadv_dat_entry, hash_entry);
> +	dat_entry2 =3D container_of(key2, struct batadv_dat_entry, key);

have you tested the code to be sure this expression is working as expected?
the assumption of container_of is that the address received as first parame=
ter
is within the structure you want to retrieve. If I am not mistake key2 shou=
ld be
a dynamically allocated buffer, hence it should not work as you expect.
You can check the definition of container_of in the kernel source.

> +
> +	if (dat_entry1->type !=3D dat_entry2->type)
> +		return 0;
> +
> +	key_size =3D batadv_dat_types_info[dat_entry1->type].key_size;
> +	return (memcmp(dat_entry1->key, dat_entry2->key, key_size) =3D=3D 0 ?
> +			1 : 0);

"1 : 0);" should be aligned with the first opening parenthesis, not with the
memcmp one, right?

>  }
> =20
>  /**
> @@ -198,7 +231,7 @@ static __be32 batadv_arp_ip_dst(struct sk_buff *skb, =
int hdr_size)
>  }
> =20
>  /**
> - * batadv_hash_dat - compute the hash value for an IP address
> + * batadv_hash_dat - compute the hash value for a DAT key
>   * @data: data to hash
>   * @size: size of the hash table
>   *
> @@ -209,7 +242,8 @@ static uint32_t batadv_hash_dat(const void *data, uin=
t32_t size)
>  	uint32_t hash =3D 0;
>  	const struct batadv_dat_entry *dat =3D data;
> =20
> -	hash =3D batadv_hash_bytes(hash, &dat->ip, sizeof(dat->ip));
> +	hash =3D batadv_hash_bytes(hash, dat->key,
> +				 batadv_dat_types_info[dat->type].key_size);
>  	hash =3D batadv_hash_bytes(hash, &dat->vid, sizeof(dat->vid));

shouldn't the vid be part of the generalization?
If we want to generalise the key, then we have to include it all. The vid is
part of the key as well, therefore it should not be externalised this way. =
I'd
rather think you should use a struct for the key (I think this is what
you planned to do for they data already). In this way you will have a struct
including the IP and the vid which can be hashed in one shot (thanks to the
generic key void * and the key_size).

> =20
>  	hash +=3D (hash << 3);
> @@ -223,24 +257,26 @@ static uint32_t batadv_hash_dat(const void *data, u=
int32_t size)
>   * batadv_dat_entry_hash_find - look for a given dat_entry in the local =
hash
>   * table
>   * @bat_priv: the bat priv with all the soft interface information
> - * @ip: search key
> + * @key: search key
> + * @entry_type: type of the entry
>   * @vid: VLAN identifier
>   *
>   * Returns the dat_entry if found, NULL otherwise.
>   */
>  static struct batadv_dat_entry *
> -batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
> -			   unsigned short vid)
> +batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, void *key,
> +			   uint8_t entry_type, unsigned short vid)
>  {
>  	struct hlist_head *head;
>  	struct batadv_dat_entry to_find, *dat_entry, *dat_entry_tmp =3D NULL;
>  	struct batadv_hashtable *hash =3D bat_priv->dat.hash;
> -	uint32_t index;
> +	uint32_t index, key_size =3D batadv_dat_types_info[entry_type].key_size;
> =20
>  	if (!hash)
>  		return NULL;
> =20
> -	to_find.ip =3D ip;
> +	to_find.key =3D key;
> +	to_find.type =3D entry_type;
>  	to_find.vid =3D vid;
> =20
>  	index =3D batadv_hash_dat(&to_find, hash->size);
> @@ -248,7 +284,9 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_pr=
iv, __be32 ip,
> =20
>  	rcu_read_lock();
>  	hlist_for_each_entry_rcu(dat_entry, head, hash_entry) {
> -		if (dat_entry->ip !=3D ip)
> +		if (dat_entry->type !=3D entry_type)
> +			continue;
> +		if (memcmp(dat_entry->key, key, key_size))
>  			continue;
> =20
>  		if (!atomic_inc_not_zero(&dat_entry->refcount))
> @@ -265,36 +303,62 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_=
priv, __be32 ip,
>  /**
>   * batadv_dat_entry_add - add a new dat entry or update it if already ex=
ists
>   * @bat_priv: the bat priv with all the soft interface information
> - * @ip: ipv4 to add/edit
> - * @mac_addr: mac address to assign to the given ipv4
> + * @key: the key to add/edit
> + * @entry_type: type of the key added to DAT
> + * @value: the value to assign to the given key
>   * @vid: VLAN identifier
>   */
> -static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
> -				 uint8_t *mac_addr, unsigned short vid)
> +static void batadv_dat_entry_add(struct batadv_priv *bat_priv, void *key,
> +				 uint8_t entry_type, void *value,
> +				 unsigned short vid)
>  {
>  	struct batadv_dat_entry *dat_entry;
>  	int hash_added;
> +	char dbg_key[BATADV_DAT_KEY_MAX_LEN];
> +	char dbg_value[BATADV_DAT_VALUE_MAX_LEN];

Please rename BATADV_DAT_KEY_MAX_LEN and BATADV_DAT_VALUE_MAX_LEN (maybe ad=
d STR
inside) because they make me think they refer to the length of the buffer f=
ield,
not the string representation.

> +	size_t key_size =3D batadv_dat_types_info[entry_type].key_size;
> +	size_t value_size =3D batadv_dat_types_info[entry_type].value_size;
> +	char *key_str_fmt =3D batadv_dat_types_info[entry_type].key_str_fmt;
> +	char *value_str_fmt =3D batadv_dat_types_info[entry_type].value_str_fmt;

Since you are declaring all these new variables, what about sorting them all
=66rom the longest line to the shortest (and put them above the existent on=
es)?

This is guideline suggested by the networking tree maintainer.

> =20
> -	dat_entry =3D batadv_dat_entry_hash_find(bat_priv, ip, vid);
> +	dat_entry =3D batadv_dat_entry_hash_find(bat_priv, key, entry_type, vid=
);
>  	/* if this entry is already known, just update it */
>  	if (dat_entry) {
> -		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
> -			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
> +		if (memcmp(dat_entry->value, value, value_size))
> +			memcpy(dat_entry->value, value, value_size);
>  		dat_entry->last_update =3D jiffies;
>  		batadv_dbg(BATADV_DBG_DAT, bat_priv,
> -			   "Entry updated: %pI4 %pM (vid: %d)\n",
> -			   &dat_entry->ip, dat_entry->mac_addr,
> +			   "Entry updated: %s %s (vid: %d)\n",
> +			   batadv_dat_data_to_str(dat_entry->key, key_str_fmt,
> +						  dbg_key, sizeof(dbg_key)),
> +			   batadv_dat_data_to_str(dat_entry->value,
> +						  value_str_fmt,
> +						  dbg_value,
> +						  sizeof(dbg_value)),
>  			   BATADV_PRINT_VID(vid));

things get complicated here. As I wrote before the vid should be part of the
key..but then we should be able to print in a generic fashion (using the fmt
array)..but I don't immediately see an easy way to do that.

>  		goto out;
>  	}
> =20
> +

useless blank line

>  	dat_entry =3D kmalloc(sizeof(*dat_entry), GFP_ATOMIC);
>  	if (!dat_entry)
>  		goto out;
> =20
> -	dat_entry->ip =3D ip;
> +	/* Assignment needed for correct free if next allocation fails. */
> +	dat_entry->value =3D NULL;
> +	dat_entry->key =3D kmalloc(key_size, GFP_ATOMIC);
> +	if (!dat_entry->key)
> +		goto out;

NACK.
We can't go to "out" (and use dat_entry_free_ref()) here. We must directly =
free
what we allocated in this function. The refcounter is not even initialised =
so we
absolutely cannot make use of dat_entry_free_ref(). I'd suggest you to use
another label (maybe you can put it after the return?) and free everything
there.
If you need again to assign the fields to NULL, I'd suggest to change the
kmalloc to kzalloc (which takes care of setting the allocated memory to 0).

> +	memcpy(dat_entry->key, key, key_size);
> +
> +	dat_entry->value =3D kmalloc(value_size, GFP_ATOMIC);
> +	if (!dat_entry->value)
> +		goto out;

as before.

> +	memcpy(dat_entry->value, value, value_size);
> +
> +	dat_entry->type =3D entry_type;
>  	dat_entry->vid =3D vid;
> -	memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
> +
>  	dat_entry->last_update =3D jiffies;
>  	atomic_set(&dat_entry->refcount, 2);
> =20
> @@ -308,8 +372,12 @@ static void batadv_dat_entry_add(struct batadv_priv =
*bat_priv, __be32 ip,
>  		goto out;
>  	}
> =20
> -	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %=
d)\n",
> -		   &dat_entry->ip, dat_entry->mac_addr, BATADV_PRINT_VID(vid));
> +	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %s %s (vid: %d)\=
n",
> +		   batadv_dat_data_to_str(dat_entry->key, key_str_fmt,
> +					 dbg_key, sizeof(dbg_key)),
> +		   batadv_dat_data_to_str(dat_entry->value, value_str_fmt,
> +					   dbg_value, sizeof(dbg_value)),
> +		   BATADV_PRINT_VID(vid));

same problem as before..we should think about a solution for this.

> =20
>  out:
>  	if (dat_entry)
> @@ -521,7 +589,8 @@ static void batadv_choose_next_candidate(struct batad=
v_priv *bat_priv,
>   * batadv_dat_select_candidates - select the nodes which the DHT message=
 has to
>   * be sent to
>   * @bat_priv: the bat priv with all the soft interface information
> - * @ip_dst: ipv4 to look up in the DHT
> + * @key: key to look up in the DHT
> + * @entry_type: type of the key
>   *
>   * An originator O is selected if and only if its DHT_ID value is one of=
 three
>   * closest values (from the LEFT, with wrap around if needed) then the h=
ash
> @@ -530,11 +599,15 @@ static void batadv_choose_next_candidate(struct bat=
adv_priv *bat_priv,
>   * Returns the candidate array of size BATADV_DAT_CANDIDATE_NUM.
>   */
>  static struct batadv_dat_candidate *
> -batadv_dat_select_candidates(struct batadv_priv *bat_priv, __be32 ip_dst)
> +batadv_dat_select_candidates(struct batadv_priv *bat_priv, void *key,
> +			     uint8_t entry_type)

I just realise there is something wrong here..the issue is not in your patc=
h,
but in DAT itself: together with ip_dst we should also pass the vid to this
function, otherwise it cannot compute the correct hash and select the corre=
ct
candidates.

>  {
>  	int select;
> -	batadv_dat_addr_t last_max =3D BATADV_DAT_ADDR_MAX, ip_key;
> +	batadv_dat_addr_t last_max =3D BATADV_DAT_ADDR_MAX, dat_key;
>  	struct batadv_dat_candidate *res;
> +	struct batadv_dat_entry to_find;
> +	char dbg_key[BATADV_DAT_KEY_MAX_LEN];
> +	char *key_str_fmt =3D batadv_dat_types_info[entry_type].key_str_fmt;

as before, put the longest line above.

[..]

>  static bool batadv_dat_send_data(struct batadv_priv *bat_priv,
> -				 struct sk_buff *skb, __be32 ip,
> -				 int packet_subtype)
> +				 struct sk_buff *skb, void *key,
> +				 uint8_t entry_type, int packet_subtype)
>  {
>  	int i;
>  	bool ret =3D false;
> @@ -580,12 +658,16 @@ static bool batadv_dat_send_data(struct batadv_priv=
 *bat_priv,
>  	struct batadv_neigh_node *neigh_node =3D NULL;
>  	struct sk_buff *tmp_skb;
>  	struct batadv_dat_candidate *cand;
> +	char dbg_key[BATADV_DAT_KEY_MAX_LEN];
> +	char *key_str_fmt =3D batadv_dat_types_info[entry_type].key_str_fmt;

longest line above

> =20
> -	cand =3D batadv_dat_select_candidates(bat_priv, ip);
> +	cand =3D batadv_dat_select_candidates(bat_priv, key, entry_type);
>  	if (!cand)
>  		goto out;
> =20
> -	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
> +	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %s\n",
> +		   batadv_dat_data_to_str(key, key_str_fmt, dbg_key,
> +					  sizeof(dbg_key)));
> =20
>  	for (i =3D 0; i < BATADV_DAT_CANDIDATES_NUM; i++) {
>  		if (cand[i].type =3D=3D BATADV_DAT_CANDIDATE_NOT_FOUND)
> @@ -755,6 +837,9 @@ int batadv_dat_cache_seq_print_text(struct seq_file *=
seq, void *offset)
>  	unsigned long last_seen_jiffies;
>  	int last_seen_msecs, last_seen_secs, last_seen_mins;
>  	uint32_t i;
> +	char dbg_key[BATADV_DAT_KEY_MAX_LEN];
> +	char dbg_value[BATADV_DAT_VALUE_MAX_LEN];
> +	char *key_str_fmt, *value_str_fmt;

longest lines above


Good job so far! Apart from these glitches the patch looks pretty good.

you may want to discuss with us the changes you are going to apply before
sending another patch. This would simplify your work.
You can always join our IRC channel or reply to this email.

Regards,

--=20
Antonio Quartulli

--uc35eWnScqDcQrv5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJSOf1KAAoJEADl0hg6qKeOxNIQAK5d1lL7L2vRSnDZY21STMPu
JuUVLjSkDGedgY+Tj3GSb+F4/biD4clLBkORnE/oDj4ro3pRlqA07ck+D054b8p4
szpm0Qirq3AfgSo6MwRGVkHPk+pAbqv8QnD4KOwaKd0/hMMWPnbBGBLbzq+Cfq6a
iMfZBVYv3Q+3poWexGl1F9tapNug3GtVCTHhrZZ0Ung5vvMRaE7I6lVLQ1gNp4Ks
OypkObXTS4M8cJdBVlZxTxeWaOsGwTqAsF2VwOINpSnlKx2fNvJTXmIh0tVkSjcu
ffzcQ6117jTuSRp8DxL5L8sike8ItPIlOc5cWp4M3wmsw49J+oQr0gPf9582/hgv
Kra0jR5ZA0lBsfFiKHEdZ3AnT3fW2znUE7fhqmRhhd4O2o/KI499lj9KcCIq/jv4
uR7B0kT2+GcP9oCmM5TFXyz7XzwOlpXgvNVNcZCVQffoYodEeC4xT5kp33g2J8nj
U1ZxiQOj/XTU3/Qu7dkTl87pmlSjxmeVjZBZIgaROcBFBrtVdzIKoWY0zi5ifpM1
N3xtn/GowbD5wT7hmzrIopSXOTTEcPfPBoorAsaGDXe/LZSbyN+8AGDm1YJ9kJ9x
EOQt/NSxQrECoC4GFUQ41+NtdEImpNtYys5EZ9pX7oxyOtbSh9KFFdZhIT+vlKon
bqOSHjdzvFF77dkNiUZG
=fTpA
-----END PGP SIGNATURE-----

--uc35eWnScqDcQrv5--
