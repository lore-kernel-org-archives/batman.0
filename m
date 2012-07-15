Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Sun, 15 Jul 2012 21:57:18 +0200
Message-ID: <2567727.rP3vtCSzra@sven-laptop.home.narfation.org>
In-Reply-To: <20120715192630.GD16072@ritirata.org>
References: <1341144314-20995-1-git-send-email-sven@narfation.org>
 <1341766146-21037-1-git-send-email-sven@narfation.org>
 <20120715192630.GD16072@ritirata.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2572625.WGdHR8Rz7Z";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart2572625.WGdHR8Rz7Z
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Sunday 15 July 2012 21:26:30 Antonio Quartulli wrote:
> Hello Sven,
> 
> some inline comments about the TT part.
> 
> On Sun, Jul 08, 2012 at 06:49:06 +0200, Sven Eckelmann wrote:
> > The structure batadv_priv grows everytime a new feature is introduced. It
> > gets hard to find the parts of the struct that belongs to a specific
> > feature. This becomes even harder by the fact that not every feature uses
> > a prefix in the member name.
> > 
> > The variables for bridge loop avoidence, gateway handling, translation
> > table and visualization server are moved into separate structs that are
> > included in the bat_priv main struct.
> > 
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > 
> > +struct batadv_priv_tt {
> > +	atomic_t vn; /* translation table version number */
> > +	atomic_t ogm_append_cnt;
> > +	atomic_t local_changes; /* changes registered in a OGM interval */
> 
> please, substitute OGM with originator
> 
> > +	/* The tt_poss_change flag is used to detect an ongoing roaming phase.
> > +	 * If true, then I received a Roaming_adv and I have to inspect every
> > +	 * packet directed to me to check whether I am still the true
> > +	 * destination or not. This flag will be reset to false as soon as I
> > +	 * increase my TTVN
> > +	 */
> > +	bool poss_change;
> > +	struct list_head changes_list; /* tracks changes in a OGM int */
> 
> please rephrase the comment as: /* tracks tt local changes within an
> originator interval */
> > +	struct batadv_hashtable *local_hash;
> > +	struct batadv_hashtable *global_hash;
> > +	struct list_head req_list; /* list of pending tt_requests */
> > +	struct list_head roam_list;
> > +	spinlock_t changes_list_lock; /* protects changes */
> > +	spinlock_t req_list_lock; /* protects req_list */
> > +	spinlock_t roam_list_lock; /* protects roam_list */
> > +	atomic_t num_local;
> 
> I'd prefer:
> 
> atomic_t local_entry_num;
> 
> > +	/* Checksum of the local table, recomputed before sending a new OGM */
> > +	uint16_t crc;
> 
> uint16_t local_crc
> 
> > +	unsigned char *buff;
> 
> unsigned char* last_changeset;
> 
> > +	int16_t buff_len;
> 
> int16_t last_changeset_len;
> 
> > +	spinlock_t buff_lock; /* protects buff */
> 
> spinlock_t last_changeset_lock; /* protects buff_lock */
> 
> > +	struct delayed_work work;
> > +};
> 
> Thank you,

Please scroll to the "-" part of the patch and read it again.

Kind regards,
	Sven
--nextPart2572625.WGdHR8Rz7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQAyCeAAoJEF2HCgfBJntG3CgP/RIalhNotWYozTlM4KSvTFoq
NbIrHe/1BbDv6EK9JsutsL3cwG1opS5Dm5qNA1Qz0vOwxK56D0qw1YsPROH7mlPk
syZh2YCqS0igVIpQdzlpqoMhmRzujwNBdx4Lekx9rx29KHfKvzUJHKY0X+W+7lMh
3veOS4iAVpTtdEWRGMk7b1OpboqzM81my06rlsXBrPhUiy/ploceb1c657rG4BMZ
l9bxMjzDzGaO79WkBY3dDTEh1POEdT49adKL5zLgvAFBcHejb3X6ma7wuSC+Fnrn
oww8gkBodfIiGimL+cP+MA7xKxU16yiMK6piB1HestVsRxyysijLYIX4qDpE1rUI
/TPJ4iisZ6oM93IfGZ7vfPzJiPH2x5tUBqvW9XMYdqsKcTaWZeZQBozQcFHf9ttT
uTLYxumtnjRFbQQmXaCaHG3pquugYflz5cQ8vlUT5DmYL5P0hQmBok/MkBugwA73
kppnmwc6m5IG/LtmhynAKoTDu0RJTJtftkKgJWjm6xo0RkuqJD/VKOlD5lnQP0iS
AeUjXKGnNxw2qH6rGAyAeePliuyVbU1xbU7+syRSo8x9AuoFJkUnkLUkRM0T5bAr
oQFlzUVJRmywENgtRbjmiQX22934TcKruddYV8JfE6OD98rnIZv2HX5dFbIUkLku
1Q3BsEtiRfQI4bM1uzEI
=3HNG
-----END PGP SIGNATURE-----

--nextPart2572625.WGdHR8Rz7Z--

