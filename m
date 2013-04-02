Return-Path: <ordex@autistici.org>
Date: Wed, 3 Apr 2013 00:06:54 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130402220654.GB14372@ritirata.org>
References: <CAP5XTDPibzzo_wLjXOsT07JnwNM_YTioxXdwo2bcDuAb0021xA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <CAP5XTDPibzzo_wLjXOsT07JnwNM_YTioxXdwo2bcDuAb0021xA@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] [RFCv2] batman-adv: Modified DAT structures and
 functions in order to support both IPv4 and IPv6
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


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2013 at 02:07:42PM +0200, Mihail Costea wrote:
> Subject: [RFCv2] batman-adv: Modified DAT structures and functions in ord=
er
>  to support both IPv4 and IPv6
>=20
> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
>=20
> ---


A couple of remarks that I missed till today:

> +
> +/**
>   * batadv_compare_dat - comparing function used in the local DAT hash ta=
ble
>   * @node: node in the local table
>   * @data2: second object to compare the node to
> + * @ip_type: type of IP address
>   *
>   * Returns 1 if the two entries are the same, 0 otherwise.
>   */
> -static int batadv_compare_dat(const struct hlist_node *node, const void =
*data2)
> +static int batadv_compare_dat(const struct hlist_node *node, const void =
*data2,
> +			       uint8_t ip_type)
>  {
> -	const void *data1 =3D container_of(node, struct batadv_dat_entry,
> -					 hash_entry);
> +	struct batadv_dat_entry *dat_entry1 =3D container_of(node,
> +				struct batadv_dat_entry, hash_entry);
> +	struct batadv_dat_entry *dat_entry2 =3D container_of(data2,
> +				struct batadv_dat_entry, ip);
> +	size_t ip_size;
>=20
> -	return (memcmp(data1, data2, sizeof(__be32)) =3D=3D 0 ? 1 : 0);
> +	if (dat_entry1->type !=3D dat_entry2->type)
> +		return 0;
> +
> +	ip_size =3D batadv_sizeof_ip(ip_type);
> +	return (memcmp(dat_entry1->ip, dat_entry2->ip, ip_size) =3D=3D 0 ? 1 : =
0);
> +}
> +
> +static int batadv_compare_dat_ipv4(const struct hlist_node *node,
> +			       const void *data2)
> +{
> +	return batadv_compare_dat(node, data2, BATADV_DAT_IPV4);
> +}
> +
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +static int batadv_compare_dat_ipv6(const struct hlist_node *node,
> +			       const void *data2)
> +{
> +	return batadv_compare_dat(node, data2, BATADV_DAT_IPV6);
>  }
> +#endif
>=20

can't you simply use one function (batadv_compare_dat()) and use
dat_entry1->type to compute the ip_size?

In this way you do not need the two wrapper functions (batadv_compare_dat_i=
pv6()
and batadv_compare_dat_ipv4()).


>  /**
>   * batadv_arp_hw_src - extract the hw_src field from an ARP packet
> @@ -201,16 +367,19 @@ static __be32 batadv_arp_ip_dst(struct sk_buff
> *skb, int hdr_size)
>   * batadv_hash_dat - compute the hash value for an IP address
>   * @data: data to hash
>   * @size: size of the hash table
> + * @ip_type: type of IP address
>   *
>   * Returns the selected index in the hash table for the given data.
>   */
> -static uint32_t batadv_hash_dat(const void *data, uint32_t size)
> +static uint32_t batadv_hash_dat(const void *data, uint32_t size,
> +			       uint8_t ip_type)
>  {
>  	const unsigned char *key =3D data;
>  	uint32_t hash =3D 0;
> -	size_t i;
> +	size_t i, ip_size;
>=20
> -	for (i =3D 0; i < 4; i++) {
> +	ip_size =3D batadv_sizeof_ip(ip_type);
> +	for (i =3D 0; i < ip_size; i++) {
>  		hash +=3D key[i];
>  		hash +=3D (hash << 10);
>  		hash ^=3D (hash >> 6);


mh, I think we should encode the "type" in the hash as well..
Maybe we can postpone this suggestion to when we will make the DHT more and=
 more
generic. :) For now (that we encode IPs) we won't have IP addresses of the =
same
size but different type :):)

> @@ -289,14 +476,34 @@ static void batadv_dat_entry_add(struct
> batadv_priv *bat_priv, __be32 ip,
>  	if (!dat_entry)
>  		goto out;
>=20
> -	dat_entry->ip =3D ip;
> +	ip_size =3D batadv_sizeof_ip(ip_type);
> +	dat_entry->ip =3D kmalloc(ip_size, GFP_ATOMIC);
> +	if (!dat_entry->ip)
> +		goto out;
> +	memcpy(dat_entry->ip, ip, ip_size);
> +	dat_entry->type =3D ip_type;
> +
>  	memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
>  	dat_entry->last_update =3D jiffies;
>  	atomic_set(&dat_entry->refcount, 2);
>=20
> -	hash_added =3D batadv_hash_add(bat_priv->dat.hash, batadv_compare_dat,
> -				     batadv_hash_dat, &dat_entry->ip,
> -				     &dat_entry->hash_entry);
> +	switch (ip_type) {
> +	case BATADV_DAT_IPV4:
> +		hash_added =3D batadv_hash_add(bat_priv->dat.hash,
> +				batadv_compare_dat_ipv4, batadv_hash_dat_ipv4,
> +				dat_entry->ip, &dat_entry->hash_entry);
> +		break;
> +#if defined(CONFIG_IPV6) || defined(CONFIG_IPV6_MODULE)
> +	case BATADV_DAT_IPV6:
> +		hash_added =3D batadv_hash_add(bat_priv->dat.hash,
> +				batadv_compare_dat_ipv6, batadv_hash_dat_ipv6,
> +				dat_entry->ip, &dat_entry->hash_entry);
> +		break;

to reduce indentation here you could use a pointer to function which can be
assigned to either batadv_hash_dat_ipv4 or batadv_hash_dat_ipv6 in the swit=
ch
and then invoke batadv_hash_add once outside the switch block.

if you follow the iupper suggestion, batadv_compare_dat_ipv6/4()
should just become batadv_compare_dat()

> +#endif
> +	default:
> +		hash_added =3D 1; /* in order to catch next if */

assign 1 (better -1) to hash_added declaration/initialisation and avoid this
default branch.

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRW1Z+AAoJEADl0hg6qKeOVpIP/1+aRgBp3sgYqyo7YPyZYOro
2IoDQgzCiB5VHg0KRoEXpyS+AN7Jfe7CqjIgJB7vPersomIEFV/X5AQS6ftobJsQ
Qap62U/lFtfUtaTaQNUOYgmybhcOjTaw57dEfnEdQeCcQ8mD+Iv2PkPZO2nv4FnA
64707NOMuThHxBowouatiHf6dCxmvfkLnjpGkYPY+GthMnrtpkMCXzpI2uJwnacl
+ZIV/2Ate/b2yOdpKeBMdhOz5tUISP/jZoPfKnPtK9LBNBPEgp/eDOPu81GK+pGp
kOOGOtzEc+HjaePSt4bkjkL5X92I3MS+Pk2Z171Xy8MWe2c94bHEJRNoxpnnqpha
8G6WmAAj4Ivn93gjaP+KbXDw7ApdoFnZtKAmLvOP2O3WEIazwmfT1o02Y0xfSa7p
H57t+dz2Tb3Nb2O6amLvglkiDX/j7yCjXxGVv2z/eRkHYmm90YS3R8leq9JESrVt
PALP05+PZi3JRGM2yBhzerHnmJjPa/VZllpg4/F5RknuDavtQBTlZGEjy1UCGKMA
Zc2d2Kjx5LLAZ++qK4OtQoG49tffEpcqbapMoIOSrCGgtukQOv6ZatsDZLEz6yLp
JkpfDR0Ib391Qe2776FC/BF7FfJVEeBK3q2e7bI1Hciv/TsKTs1DFaHu9sbaCnCK
qRMebbQRM/Wnbl23dlmV
=g+Dr
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
