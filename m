Return-Path: <ordex@autistici.org>
Date: Sun, 15 Jul 2012 21:26:30 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120715192630.GD16072@ritirata.org>
References: <1341144314-20995-1-git-send-email-sven@narfation.org>
 <1341766146-21037-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline
In-Reply-To: <1341766146-21037-1-git-send-email-sven@narfation.org>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: Split batadv_priv in
 sub-structures for features
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


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Sven,

some inline comments about the TT part.


On Sun, Jul 08, 2012 at 06:49:06 +0200, Sven Eckelmann wrote:
> The structure batadv_priv grows everytime a new feature is introduced. It=
 gets
> hard to find the parts of the struct that belongs to a specific feature. =
This
> becomes even harder by the fact that not every feature uses a prefix in t=
he
> member name.
>=20
> The variables for bridge loop avoidence, gateway handling, translation ta=
ble
> and visualization server are moved into separate structs that are include=
d in
> the bat_priv main struct.
>=20
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
 =20
> +struct batadv_priv_tt {
> +	atomic_t vn; /* translation table version number */
> +	atomic_t ogm_append_cnt;
> +	atomic_t local_changes; /* changes registered in a OGM interval */

please, substitute OGM with originator

> +	/* The tt_poss_change flag is used to detect an ongoing roaming phase.
> +	 * If true, then I received a Roaming_adv and I have to inspect every
> +	 * packet directed to me to check whether I am still the true
> +	 * destination or not. This flag will be reset to false as soon as I
> +	 * increase my TTVN
> +	 */
> +	bool poss_change;
> +	struct list_head changes_list; /* tracks changes in a OGM int */

please rephrase the comment as: /* tracks tt local changes within an origin=
ator interval */

> +	struct batadv_hashtable *local_hash;
> +	struct batadv_hashtable *global_hash;
> +	struct list_head req_list; /* list of pending tt_requests */
> +	struct list_head roam_list;
> +	spinlock_t changes_list_lock; /* protects changes */
> +	spinlock_t req_list_lock; /* protects req_list */
> +	spinlock_t roam_list_lock; /* protects roam_list */
> +	atomic_t num_local;

I'd prefer:

atomic_t local_entry_num;


> +	/* Checksum of the local table, recomputed before sending a new OGM */
> +	uint16_t crc;

uint16_t local_crc

> +	unsigned char *buff;

unsigned char* last_changeset;

> +	int16_t buff_len;

int16_t last_changeset_len;

> +	spinlock_t buff_lock; /* protects buff */

spinlock_t last_changeset_lock; /* protects buff_lock */

> +	struct delayed_work work;
> +};

Thank you,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlADGWYACgkQpGgxIkP9cwee8ACdHt+Mw2SUGcels0sAfTO7nDgf
8lEAoIUA1QeusM4MWCkLCjYhGVN86zEE
=sqUY
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
