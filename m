Return-Path: <ordex@autistici.org>
Date: Mon, 15 Apr 2013 12:25:09 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130415102509.GA18298@ritirata.org>
References: <1364895668-15046-1-git-send-email-ordex@autistici.org>
 <201304151710.40934.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <201304151710.40934.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: move
 batadv_slide_own_bcast_window to bat_iv_ogm.c
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


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2013 at 05:10:40PM +0800, Marek Lindner wrote:
> On Tuesday, April 02, 2013 17:41:08 Antonio Quartulli wrote:
> > +static void
> > +batadv_iv_ogm_slide_own_bcast_window(struct batadv_hard_iface *hard_if=
ace)
> > +{
> > +       struct batadv_priv *bat_priv =3D netdev_priv(hard_iface->soft_i=
face);
> > +       struct batadv_hashtable *hash =3D bat_priv->orig_hash;
> > +       struct hlist_head *head;
> > +       struct batadv_orig_node *orig_node;
> > +       unsigned long *word;
> > +       uint32_t i;
> > +       size_t word_index;
> > +       uint8_t *w;
> > +
> > +       for (i =3D 0; i < hash->size; i++) {
> > +               head =3D &hash->table[i];
> > +
> > +               rcu_read_lock();
> > +               hlist_for_each_entry_rcu(orig_node, head, hash_entry) {
> > +                       spin_lock_bh(&orig_node->ogm_cnt_lock);
> > +                       word_index =3D hard_iface->if_num * BATADV_NUM_=
WORDS;
> > +                       word =3D &(orig_node->bcast_own[word_index]);
> > +
> > +                       batadv_bit_get_packet(bat_priv, word, 1, 0);
> > +                       w =3D &orig_node->bcast_own_sum[hard_iface->if_=
num];
> > +                       *w =3D bitmap_weight(word,
> > BATADV_TQ_LOCAL_WINDOW_SIZE);
> > +                       spin_unlock_bh(&orig_node->ogm_cnt_lock);
> > +               }
> > +               rcu_read_unlock();
> > +       }
> > +}
>=20
> Kernel doc ?

ok. Will provide some :)

>=20
> Cheers,
> Marek

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCAAGBQJRa9WFAAoJEADl0hg6qKeOAnAP/RfsrTK124Qiddm9/VnQvN2Q
7XtSDVFd952io/jIZhriJh9SjV/9QgU4Js3MQ1a9Ng2XY4hWvlBUJD+6f7ol2m96
PhBKLCEydGOyOM4s5wNzRui4HG01yIjM2q81jRN0HYIIi2hhL8Xy+1cIMmN3JpcJ
tEoeaw7aBFT20CI61oi2DYWgxDhSsLSYuq4SuzyUY2FuXX4O15J9SoB4p007GiXy
nk+siiBoy6aixXNN3RfhpKNSvAP3KboIoUOjVIVJKgaM6e2LyJ/gEaPZy4RRah67
oAQYbc2uhMsterDshbORGLdctlgRk8I3RZyTZC1NOt3eaTTzN8cALkgH78npVpyr
dLhTp6CkxMic0qxkynD3xnTBpRfE9za9ndh115iVRJeZ4Ztlnpa/qKVk9Iy9cHvo
75d/ky0xEoCz3jQuC0pRM8U3ymieyVR6KYhZFZ6uoo9xCM9aDmYjlQbbbcrSkiQP
0ia/f4ulafZrQW9Hfb3Wnmrmym6ZczNCtubSrZSy4EPjekM7cRzRM9mjuCjZzam3
8Z12QijsAibMEXavGwn4iKdu7Dt3qOVjmU3368kJaaCJdMg0q8zfbtcNCcuDhew/
L2If+2AwZ4mx23TRaHiCp2sTNMsFjK5O365vnyxhGrlFRaSvoGBPjt/+O2ru7MQo
e7IZ/+/UgltODn+cupug
=3gNK
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
