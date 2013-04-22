Return-Path: <ordex@autistici.org>
Date: Mon, 22 Apr 2013 20:44:28 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130422184428.GE5732@ritirata.org>
References: <1366629138-28627-1-git-send-email-mihail.costea2005@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6BvahUXLYAruDZOj"
Content-Disposition: inline
In-Reply-To: <1366629138-28627-1-git-send-email-mihail.costea2005@gmail.com>
Subject: Re: [B.A.T.M.A.N.] [PATCH] Added generic transformer to string
 function for DAT data
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


--6BvahUXLYAruDZOj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mihail,

You should first send the patch introducing the dat_entry->type field,
otherwise this one cannot apply..
Then please add a few lines commit message describing what this patch is
bringing and why it would be nice to have this new function (e.g. talk about
future uses with many dat_entry types..).

However I put some comments inline

On Mon, Apr 22, 2013 at 02:12:18PM +0300, YourName wrote:
> Signed-off-by: Mihail Costea <mihail.costea90@gmail.com>
> Signed-off-by: Stefan Popa <Stefan.A.Popa@intel.com>
> Reviewed-by: Stefan Popa <Stefan.A.Popa@intel.com>
>=20
> ---
>=20
>  distributed-arp-table.c |   71 +++++++++++++++++++++++++++++++++++++++++=
------
>  types.h                 |    8 ++++++
>  2 files changed, 70 insertions(+), 9 deletions(-)
>=20
> diff --git a/distributed-arp-table.c b/distributed-arp-table.c
> index 3a3e1d8..5df8f19 100644
> --- a/distributed-arp-table.c
> +++ b/distributed-arp-table.c
> @@ -34,6 +34,36 @@
>  static void batadv_dat_purge(struct work_struct *work);
> =20
>  /**
> + * batadv_dat_data_to_str: transforms DAT data to string
> + * @data: the DAT data
> + * @type: type of data
> + *
> + * Returns the string representation of data. This should be freed with =
kfree.
> + */
> +static char *batadv_dat_data_to_str(void *data, uint8_t type)
> +{
> +	size_t buf_size;
> +	char *buf, *format_type, ipv4[] =3D "%pI4";

char ipv4[] should instead be const char *ipv4. However, I think a more gen=
eral
approach should be nice. Look at sysfs.c:46 for an example. In that case we=
 have
an array of strings where for a given item with value 0, you find its
string representation exactly at index 0. For DAT it may be the same:

if you do something like

enum batadv_dat_types {
	BATADV_DAT_IPV4  =3D 0,
	BATADV_DAT_CHACHA =3D 1,
};

then you can have an array of strings where you can put the format to use w=
ith
Ipv4 exactly at poistion 0 and the format to use for CHACHA at position 1:

static char *batadv_dat_types_str_fmt[] {
	"%pI4",
	"%chacha",
}

This makes the code easier to be read by other people and also easy to be
improved in the future.

> +
> +	switch (type) {
> +	case BATADV_DAT_IPV4:
> +		/* maximum length for an IPv4 string representation + NULL */
> +		buf_size =3D 16;
> +		format_type =3D ipv4;
> +		break;
> +	default:
> +		return NULL;
> +	}
> +

If you use the same approach for the buf_size (another static array, say
batadv_dat_type_str_len) then you can get rid of this switch (which otherwi=
se
would grow continuously as soon as we add new types) and use a couple of li=
nes
only.

> +	buf =3D kmalloc(buf_size, GFP_ATOMIC);
> +	if (!buf)
> +		return NULL;
> +	snprintf(buf, buf_size, format_type, data);
> +
> +	return buf;
> +}

for what concern the buffer, what do you think about using an approach simi=
lar
to inet_ntop() ? Instead of allocating a buffer inside (which may fail as y=
ou
correctly handled) the function could receive a buffer and its len directly=
 from
outside and use it (and return it). In this way you could easily put this
function directly into a batadv_dbg().

E.g.:

*batadv_dat_data_to_str(data, type, buf, buf_len) {
	/* play with buf and ensure we don't exceed buf_len  */
	return buf;
}

=2E..
char buf[20];
=2E..
batadv_dbg(BATADV_DBG_DAT, bat_priv, "this and that %s\n",
	   batadv_dat_data_to_str(data, type, buf, sizeof(buf)));
=2E..

I think the code using batadv_dat_data_to_str() will become smaller and eas=
ier,
no?

> +
> +/**
>   * batadv_dat_start_timer - initialise the DAT periodic worker
>   * @bat_priv: the bat priv with all the soft interface information
>   */
> @@ -272,6 +302,7 @@ static void batadv_dat_entry_add(struct batadv_priv *=
bat_priv, __be32 ip,
>  {
>  	struct batadv_dat_entry *dat_entry;
>  	int hash_added;
> +	char *dbg_data;
> =20
>  	dat_entry =3D batadv_dat_entry_hash_find(bat_priv, ip);
>  	/* if this entry is already known, just update it */
> @@ -279,9 +310,15 @@ static void batadv_dat_entry_add(struct batadv_priv =
*bat_priv, __be32 ip,
>  		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
>  			memcpy(dat_entry->mac_addr, mac_addr, ETH_ALEN);
>  		dat_entry->last_update =3D jiffies;
> -		batadv_dbg(BATADV_DBG_DAT, bat_priv,
> -			   "Entry updated: %pI4 %pM\n", &dat_entry->ip,
> -			   dat_entry->mac_addr);
> +
> +		dbg_data =3D batadv_dat_data_to_str(&dat_entry->ip,
> +						  BATADV_DAT_IPV4);
> +		if (dbg_data) {
> +			batadv_dbg(BATADV_DBG_DAT, bat_priv,
> +				   "Entry updated: %s %pM\n", dbg_data,
> +				   dat_entry->mac_addr);
> +			kfree(dbg_data);
> +		}
>  		goto out;
>  	}
> =20
> @@ -304,8 +341,13 @@ static void batadv_dat_entry_add(struct batadv_priv =
*bat_priv, __be32 ip,
>  		goto out;
>  	}
> =20
> -	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM\n",
> -		   &dat_entry->ip, dat_entry->mac_addr);
> +	dbg_data =3D batadv_dat_data_to_str(&dat_entry->ip, BATADV_DAT_IPV4);
> +	if (dbg_data) {
> +		batadv_dbg(BATADV_DBG_DAT, bat_priv,
> +			   "New entry added: %s %pM\n", dbg_data,
> +			   dat_entry->mac_addr);
> +		kfree(dbg_data);
> +	}
> =20
>  out:
>  	if (dat_entry)
> @@ -527,6 +569,7 @@ batadv_dat_select_candidates(struct batadv_priv *bat_=
priv, __be32 ip_dst)
>  	int select;
>  	batadv_dat_addr_t last_max =3D BATADV_DAT_ADDR_MAX, ip_key;
>  	struct batadv_dat_candidate *res;
> +	char *dbg_data;
> =20
>  	if (!bat_priv->orig_hash)
>  		return NULL;
> @@ -538,9 +581,13 @@ batadv_dat_select_candidates(struct batadv_priv *bat=
_priv, __be32 ip_dst)
>  	ip_key =3D (batadv_dat_addr_t)batadv_hash_dat(&ip_dst,
>  						    BATADV_DAT_ADDR_MAX);
> =20
> -	batadv_dbg(BATADV_DBG_DAT, bat_priv,
> -		   "dat_select_candidates(): IP=3D%pI4 hash(IP)=3D%u\n", &ip_dst,
> -		   ip_key);
> +	dbg_data =3D batadv_dat_data_to_str(&ip_dst, BATADV_DAT_IPV4);
> +	if (dbg_data) {
> +		batadv_dbg(BATADV_DBG_DAT, bat_priv,
> +			   "dat_select_candidates(): IP=3D%s hash(IP)=3D%u\n",
> +			   dbg_data, ip_key);
> +		kfree(dbg_data);
> +	}
> =20
>  	for (select =3D 0; select < BATADV_DAT_CANDIDATES_NUM; select++)
>  		batadv_choose_next_candidate(bat_priv, res, select, ip_key,
> @@ -572,12 +619,18 @@ static bool batadv_dat_send_data(struct batadv_priv=
 *bat_priv,
>  	struct batadv_neigh_node *neigh_node =3D NULL;
>  	struct sk_buff *tmp_skb;
>  	struct batadv_dat_candidate *cand;
> +	char *dbg_data;
> =20
>  	cand =3D batadv_dat_select_candidates(bat_priv, ip);
>  	if (!cand)
>  		goto out;
> =20
> -	batadv_dbg(BATADV_DBG_DAT, bat_priv, "DHT_SEND for %pI4\n", &ip);
> +	dbg_data =3D batadv_dat_data_to_str(&ip, BATADV_DAT_IPV4);
> +	if (dbg_data) {
> +		batadv_dbg(BATADV_DBG_DAT, bat_priv,
> +			   "DHT_SEND for %s\n", dbg_data);
> +		kfree(dbg_data);
> +	}
> =20
>  	for (i =3D 0; i < BATADV_DAT_CANDIDATES_NUM; i++) {
>  		if (cand[i].type =3D=3D BATADV_DAT_CANDIDATE_NOT_FOUND)
> diff --git a/types.h b/types.h
> index b2c94e1..3488528 100644
> --- a/types.h
> +++ b/types.h
> @@ -980,6 +980,14 @@ struct batadv_dat_entry {
>  };
> =20
>  /**
> + * batadv_dat_types - types used in batadv_dat_entry for IP
> + * @BATADV_DAT_IPv4: IPv4 address type
> + */
> +enum batadv_dat_types {
> +	BATADV_DAT_IPV4,
> +};
> +

if you use the approach I proposed above, remember to assign values to the =
enum
constants (at least tot he first) so to ensure they have the values you wan=
t.

> +/**
>   * struct batadv_dat_candidate - candidate destination for DAT operations
>   * @type: the type of the selected candidate. It can one of the followin=
g:
>   *	  - BATADV_DAT_CANDIDATE_NOT_FOUND
> --=20
> 1.7.10.4

Thanks a lot so far!
If you have any question, comment or whatever feel free to interact with us=
 on
the batman-adv IRC channel (#batman @ freenode)!

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--6BvahUXLYAruDZOj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRdYUMAAoJEADl0hg6qKeO9OQQAINGNCUqNgloriYSpB/iKZsx
1xC/s4T2mqLdSHGdOeoQyfAbMfh5L4EJETx7IwYNNUxw+/uz7rsyUVsdcGVWMYOc
rSAxIOoT05QeYzCvUh8jrLSILkGy4+UIKbeHg6rYfjm8NsrjeBl/aBVxIneWaKir
ku3zWB+WvYKRNg1zUhJm5hLolpbx9lqK7NBUxWXQDXYdl8kLoSFoomb+a6/QpO5V
COqfbyyq/I1pEFEgW07cYlb1uBYs9sfvZF/JTuWjwG3is7ii3awY+uXN5DNdf/gW
9W/WDUQ1xBUtil40clK/Pg7pfRycNtgCIaXiXK01uE//0w0kbIUFS8qK3+Y0Duj2
EH5HQbEtzG0DCXVRe8+fRAs5lsHJ5IWvC62FPt9K/6G6YFaf5xf8UKx7+mSj8Xpk
UmvVHTKJTNM85SWwCBmMuh2yP8PGmyUJyJT84dSg+xvdz0YwYHYFMius0g/wHbOm
OtIqYqPTVLfQFXlsHiK3/NCWb7CqRt6vzZDtdbZf2Kut0LfJn9FvgN78Pldo1qcj
h7kNREpsDC68ro1J4nzC+W7ME8xiiZy+VzRBQAqVkUN8hrHzBzibTc2J1nhpDoVp
ByESPKcomYFgirgp3HgvoVcKewxgRnYezSechZXq9SA/RM6URcf5+m1/zKeZGo3E
WNtksI0YBNwKu8YsZyXo
=00y1
-----END PGP SIGNATURE-----

--6BvahUXLYAruDZOj--
