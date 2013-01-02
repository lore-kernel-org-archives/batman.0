Return-Path: <ordex@autistici.org>
Date: Wed, 2 Jan 2013 08:48:13 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20130102074813.GB27589@ritirata.org>
References: <1355570082-19574-1-git-send-email-ordex@autistici.org>
 <201212261808.51135.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline
In-Reply-To: <201212261808.51135.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: postpone OGM preparation
 to sending time
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


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 26, 2012 at 06:08:50 +0800, Marek Lindner wrote:
> On Saturday, December 15, 2012 19:14:42 Antonio Quartulli wrote:
> > OGMs are currently prepared 1 originator interval in advance
> > then the time they are used to be sent.
> > This means that once in the air they carry old information (like TT
> > announcements and possibly other flags). To fix this, postpone the OGM
> > creation to the same time of sending, in this way the OGM is first crea=
ted
> > and then immediately sent.
>=20
> How about:
> OGMs are currently assembled and enqueued one originator interval before =
they=20
> are sent. This means they might carry information which was outdated whil=
e the=20
> OGM waited in the outgoing packet queue (like TT announcements and possib=
ly=20
> other flags).
> The OGM assembly has to be postponed to the latest possible moment before=
=20
> sending in order to minimize the gap between gathering the data and flood=
ing=20
> it to the network.

Sounds much better. Thanks!

>=20
>=20
> > -/* when do we schedule our own ogm to be sent */
> > +/**
> > + * batadv_iv_ogm_emit_wait_time - compute the OGM preparation waiting =
time
> > + * @bat_priv: the bat priv with all the soft interface information
> > + *
> > + * Returns the amount of jiffies to wait before preparing and sending =
the
> > next + * own OGM
> > + */
>=20
> I'd say "Returns the number of jiffies [..]".
>=20

Yeah

>=20
> > @@ -468,6 +442,7 @@ static void batadv_iv_ogm_aggregate(struct
> > batadv_forw_packet *forw_packet_aggr, memcpy(skb_buff, packet_buff,
> > packet_len);
> >  	forw_packet_aggr->packet_len +=3D packet_len;
> >  	forw_packet_aggr->num_packets++;
> > +	forw_packet_aggr->own |=3D own_packet;
> >=20
> >  	/* save packet direct link flag status */
> >  	if (direct_link) {
>=20
> Using "|=3D own_packet" isn't strictly necessary because "forw_packet_agg=
r->own"=20
> isn't a bit field.

Well the point is that here own_packet could be false, but forw_packet_aggr=
->own
might already be true, so I didn't want to destroy the original value.

> Did you vigorously test this code ? Especially, multi-node with multiple=
=20
> interface setups are of interest. Also use different orig intervals to en=
sure=20
> it still works everywhere.
>=20

I will try more topologies and in particular different orig intervals as so=
on as
I have the possibility


> The thing is: Throughout the code you can find the implicite assumption o=
f the=20
> first aggregated packet being an "own packet" (if forw_packet_aggr->own i=
s=20
> set). Therefore, you have to be very careful changing that logic. One fun=
ction=20
> you definitely overlooked is batadv_iv_ogm_send_to_if() but there might b=
e=20
> others.
>=20
>=20
> > @@ -498,8 +473,7 @@ static void batadv_iv_ogm_queue_add(struct batadv_p=
riv
> > *bat_priv,
> >=20
> >  	/* find position for the packet in the forward queue */
> >  	spin_lock_bh(&bat_priv->forw_bat_list_lock);
> > -	/* own packets are not to be aggregated */
> > -	if ((atomic_read(&bat_priv->aggregated_ogms)) && (!own_packet)) {
> > +	if ((atomic_read(&bat_priv->aggregated_ogms))) {
> >  		hlist_for_each_entry(forw_packet_pos, tmp_node,
> >  				     &bat_priv->forw_bat_list, list) {
> >  			if (batadv_iv_ogm_can_aggregate(batadv_ogm_packet,
>=20
> Now it gets interesting! Did you review the impact of=20
> batadv_iv_ogm_can_aggregate() before you bravely removed the exclusion of=
 own=20
> packets ? That is quite a beast ...


well, the poor existing doc didn't point out all the possible threats :-P I=
'll
investigate more. Thanks :)

>=20
>=20
> > +/**
> > + * batadv_iv_ogm_send - prepare an send an own OGM
> > + * @work: kernel work struct
> > + *
> > + * Prepare the OGM and immediately enqueue it for sending
> > + */
>=20
> prepare and send an own OGM
>         ^^^
>=20

well, technically it is enqueued, not sent..

>=20
> > +static void batadv_iv_ogm_send(struct work_struct *work)
>=20
> The naming is less than optimal. bat_iv_ogm.c now has:
>  * batadv_iv_ogm_send
>  * batadv_iv_ogm_emit

mh..ok, I will propose something better :)


>=20
>=20
> > --- a/types.h
> > +++ b/types.h
> > @@ -49,6 +49,7 @@ struct batadv_hard_iface_bat_iv {
> >  	unsigned char *ogm_buff;
> >  	int ogm_buff_len;
> >  	atomic_t ogm_seqno;
> > +	struct delayed_work work;
> >  };
>=20
> Guess we need some kernel doc for this change too. Since types.h now is f=
ully=20
> documented ...
>=20

only because you are commenting this patch after having merged your full-ke=
rnel-doc-patch :-D
Ok, I will fix it too.

Thank you very much for your precious feedback.
Greetings from down under!

Cheers,

--=20
Antonio Quartulli

=2E.each of us alone is worth nothing..
Ernesto "Che" Guevara

--KFztAG8eRSV9hGtP
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ4+Y9AAoJEADl0hg6qKeOtVMQAKzgCLt6SWq+VdN3vLy6xF82
2kfbRp10kNDwC/KO30XHMF99FoEwMdZFpGR0Lx5OfT2D/KIKUl31oLRQG9/Xx376
2hisdDlyCdFKxgyN2600sLT6bfOFGiajTeYYcr6YM41lzQ8SSx30302Qf1WGdniG
yr6uuMrOWg5JgzwTmJzWLYv60yzqBBQstJMPcMVTQ+8LmkFXQeTsfz87jk73K7PT
x59k+TzzIZRXooyhVWOCHx5+/C3MsiuZqfW1eFEO+drFtaO/vEEchTk6jqKOiijh
GCYWoWLtlcj1sFjoo7EardZKiqDZNNOhQ50zrRNJ7q9PmJRsR/YlmIPT25Vm3Upw
2VMDcLLAPcldFivZhGwcPpSJCmeSjG5r3ptGc+MCKjw2G2NhPQBi8lii+aygmpXO
/NEGUyKkNElQskhVyWP5ucM/VSbTgRfvNqiYnoz8R1h2ADuxNf0l6SQvNKfEMpXf
iw221j+J3C3kJozCHHj6yrKO4l0No6cfEXlrKXQdXWn+3OKkm9edYZPOkI8bYrXs
E/JMu3ZBWIR3hnaBDF6V8yQHyYeynA5rlr3ixrmGhxEQ/YIvRetVWWI5XtZBdDQr
RZEkWTrr2EAdfU4/3mZzzjbF0Jm2y1p0aXbyEsnXjPdIg8LTXrlVS7YK7SrKpjBc
YGu866CxSOvXcxlIkYmO
=URTU
-----END PGP SIGNATURE-----

--KFztAG8eRSV9hGtP--
