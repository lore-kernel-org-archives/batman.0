Return-Path: <ordex@autistici.org>
Date: Sun, 29 Apr 2012 19:11:56 +0200
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20120429171155.GF30759@ritirata.org>
References: <1335170112-6610-1-git-send-email-lindner_marek@yahoo.de>
	<20120424131556.GD1015@ritirata.org>
	<201204261349.30120.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <201204261349.30120.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC] batman-adv: turn tt commit code into
 routing protocol agnostic API
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


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2012 at 01:49:29PM +0800, Marek Lindner wrote:
>=20
> Hi,
>=20
> > thank you for your effort in improving the TT code :)
>=20
> I try to make the TT code a better place.  ;-)

mh, I think more effort is required! :-D

>=20
>=20
> > > +	if (hard_iface =3D=3D primary_if)
> > > +		tt_num_changes =3D tt_append_changes(bat_priv,
> > > +						   &hard_iface->packet_buff,
> > > +						   &hard_iface->packet_len,
> > > +						   BATMAN_OGM_HLEN);
> > > +
> > > +	if (tt_num_changes > 0)
> > > +		batman_ogm_packet->tt_num_changes =3D tt_num_changes;
> > > +	else
> > > +		batman_ogm_packet->tt_num_changes =3D 0;
> >=20
> > Do we really need this if-loop? Am I wrong or tt_num_changes can only b=
e >=3D
> > 0 ?
>=20
> Right, strictly speaking it is not needed. However, tt_append_changes() i=
s=20
> defined as returning int, hence the calling function can't rely on this=
=20
> assumption.
>=20

Ok. Then tt_append_changes() should be fixed. It's a really stupid thing,
but it would simplify this part of the code.


>=20
> > > -int tt_changes_fill_buffer(struct bat_priv *bat_priv,
> > > -			   unsigned char *buff, int buff_len)
> > > +static void tt_realloc_packet_buff(unsigned char **packet_buff,
> > > +				   int *packet_buff_len, int min_packet_len,
> > > +				   int new_packet_len)
> > > +{
> > > +	unsigned char *new_buff;
> > > +
> > > +	new_buff =3D kmalloc(new_packet_len, GFP_ATOMIC);
> > > +
> > > +	/* keep old buffer if kmalloc should fail */
> > > +	if (new_buff) {
> > > +		memcpy(new_buff, *packet_buff, min_packet_len);
> > > +		kfree(*packet_buff);
> > > +		*packet_buff =3D new_buff;
> > > +		*packet_buff_len =3D new_packet_len;
> > > +	}
> >=20
> > I took quite a while to understand what happens to packet_buff_len if
> > kmalloc failed. Actually it correctly stores the "previous" buffer size=
, so
> > the rest of the code will handle kmalloc failures the right way. :)
>=20
> Actually, this part of the code did not change. Check realloc_packet_buff=
er()=20
> in send.c and you will find the same function.
>

Yeah, this luckily means that the current code is correct :-)

>=20
> > > +}
> > > +
> > > +static void tt_prepare_packet_buff(struct bat_priv *bat_priv,
> > > +				   unsigned char **packet_buff,
> > > +				   int *packet_buff_len, int min_packet_len)
> > > +{
> > > +	struct hard_iface *primary_if;
> > > +	int req_len;
> > > +
> > > +	primary_if =3D primary_if_get_selected(bat_priv);
> > > +
> > > +	req_len =3D min_packet_len;
> > > +	req_len +=3D tt_len((uint8_t)atomic_read(&bat_priv->tt_local_change=
s));
> >=20
> > This cast is also in the current code. But why not removing it? atomic_=
t is
> > an int, the tt_len() argument too.
>=20
> No idea why the cast is there. I'll remove it.  :-)
>=20
>=20
> > > +
> > > +	/* if we have too many changes for one packet don't send any
> > > +	 * and wait for the tt table request which will be fragmented */
> >=20
> > please fix this comment. */ must be on a new line.
>=20
> Ok, I'll fix it. Just a quick reminder that this is old code as well ..

Yep, I know, but since you are touching that comment it is better to fix it=
 :)

>=20
>=20
> > > +static int tt_changes_fill_buff(struct bat_priv *bat_priv,
> > > +				unsigned char **packet_buff,
> > > +				int *packet_buff_len, int min_packet_len)
> > >=20
> > >  {
> > >=20
> > > -	int count =3D 0, tot_changes =3D 0;
> > >=20
> > >  	struct tt_change_node *entry, *safe;
> > >=20
> > > +	int count =3D 0, tot_changes =3D 0, new_len;
> > > +	unsigned char *tt_buff;
> > > +
> >=20
> > As suggesting on IRC we should lock the "read and copy procedure".
> > I'd call lock() here.
> >=20
> > > +	tt_prepare_packet_buff(bat_priv, packet_buff,
> > > +			       packet_buff_len, min_packet_len);
> > >=20
> > > -	if (buff_len > 0)
> > > -		tot_changes =3D buff_len / tt_len(1);
> > > +	new_len =3D *packet_buff_len - min_packet_len;
> > >=20
> > >=20
> > >=20
> > > +	tt_buff =3D *packet_buff + min_packet_len;
> > > +
> > > +	if (new_len > 0)
> > > +		tot_changes =3D new_len / tt_len(1);
> > >=20
> > >  	spin_lock_bh(&bat_priv->tt_changes_list_lock);
> > >  	atomic_set(&bat_priv->tt_local_changes, 0);
> > >=20
> > > @@ -290,7 +339,7 @@ int tt_changes_fill_buffer(struct bat_priv *bat_p=
riv,
> > >=20
> > >  	list_for_each_entry_safe(entry, safe, &bat_priv->tt_changes_list,
> > >  =09
> > >  				 list) {
> > >  	=09
> > >  		if (count < tot_changes) {
> > >=20
> > > -			memcpy(buff + tt_len(count),
> > > +			memcpy(tt_buff + tt_len(count),
> > >=20
> > >  			       &entry->change, sizeof(struct tt_change));
> > >  		=09
> > >  			count++;
> > >  	=09
> > >  		}
> >=20
> > and I'd call unlock() after having copied everything to the tt_buff and
> > emptied the changes list. Can we directly use
> > bat_priv->tt_changes_list_lock ? It seems to be the case :)
>=20
> I'd rather move the locking into a separate patch to make it easier to tr=
ace=20
> the change.

I agree

>=20
>=20
> > >=20
> > >  	/* all the reset entries have now to be effectively counted as local
> > >  =09
> > >  	 * entries */
> > >  =09
> > >  	atomic_add(changed_num, &bat_priv->num_local_tt);
> > >  	tt_local_purge_pending_clients(bat_priv);
> > >=20
> > > +	bat_priv->tt_crc =3D tt_local_crc(bat_priv);
> > >=20
> > >  	/* Increment the TTVN only once per OGM interval */
> > >  	atomic_inc(&bat_priv->ttvn);
> > >  	bat_dbg(DBG_TT, bat_priv, "Local changes committed, updating to ttvn
> > >  	%u\n",
> > >  =09
> > >  		(uint8_t)atomic_read(&bat_priv->ttvn));
> > >  =09
> > >  	bat_priv->tt_poss_change =3D false;
> > >=20
> > > +
> > > +	/* reset the sending counter */
> > > +	atomic_set(&bat_priv->tt_ogm_append_cnt, TT_OGM_APPEND_MAX);
> > > +
> > > +	return tt_changes_fill_buff(bat_priv, packet_buff,
> > > +				    packet_buff_len, packet_min_len);
> > > +}
> >=20
> > As you suggested on IRC, we may want to envelop this function with a
> > lock/unlock to force exclusive access to the local table and to the eve=
nt
> > list.
> >
> > We should apply the same lock in tt_local_add()/del() I think.
>=20
>=20
> Why do want to lock tt_changes_fill_buff() and tt_commit_changes() separa=
tely?=20
> We should already lock in tt_commit_changes() because the entire commit h=
as to=20
> be an atomic operation. Several of the function calls in tt_commit_change=
s()=20
> depend on the fact that no client is purged or added while these function=
s=20
> run.

Yeah, lock in tt_commit_changes() is definitely safer. I was trying to redu=
ce
the critical zone, but I'd open race conditions in that way.

Thank you!

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQEcBAEBAgAGBQJPnXZbAAoJEFMQTLzJFOZF+P8H/RA+DlA7h0q8+GsM1n1bRv7z
N3GQ64cZWsGorNdFHI5/SA5wmcVpMu0mE+eYunasx++U8WWGyE5hf26BteVWxtUl
oCEpbl1og/Mhtgq2NUUbtGEHkSiSTHPbi8NbDGv0qXs/p/PAQKDdN89Cuvh9+6Xv
PsTV0ck5qbZcQMUhBaqXwdNxD7F/+1a4yYuJZUPkVYAzZN28x384I04vV8u+ZwSi
QOQytet7v+6yRxYuPHCGTN6DFpEtiOYi90CE9scjBl8t9I6lkNUnucHoqa6ydNC1
RF3OiAL4AGbVn88/s/QI4oP80dD3aBH49ET9duSWD7OCtnSlWnH8m/SQInhN7bU=
=vWaf
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
