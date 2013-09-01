Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sun, 1 Sep 2013 12:48:44 +0800
References: <1377790385-24720-1-git-send-email-lindner_marek@yahoo.de>
 <20130831183829.GT2896@ritirata.org>
In-Reply-To: <20130831183829.GT2896@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201309011248.44874.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: limit local translation
	table max size
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

On Sunday, September 01, 2013 02:38:29 Antonio Quartulli wrote:
> > diff --git a/hard-interface.c b/hard-interface.c
> > index c5f871f..c60d3ed 100644
> > --- a/hard-interface.c
> > +++ b/hard-interface.c
> > @@ -266,16 +266,9 @@ static void batadv_check_known_mac_addr(const stru=
ct
> > net_device *net_dev)
> >=20
> >  int batadv_hardif_min_mtu(struct net_device *soft_iface)
> >  {
> >=20
> > -	const struct batadv_priv *bat_priv =3D netdev_priv(soft_iface);
> > +	struct batadv_priv *bat_priv =3D netdev_priv(soft_iface);
>=20
> Why are you removing the const qualifier?

  CC [M]  /home/marek/batman-adv/hard-interface.o
/home/marek/batman-adv/hard-interface.c: In function =E2=80=98batadv_hardif=
_min_mtu=E2=80=99:
/home/marek/batman-adv/hard-interface.c:286:2: warning: passing argument 1 =
of=20
=E2=80=98atomic_set=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier fro=
m pointer target type [enabled by=20
default]
/usr/src/linux-headers-3.2.0-4-common/arch/x86/include/asm/atomic.h:35:20:=
=20
note: expected =E2=80=98struct atomic_t *=E2=80=99 but argument is of type =
=E2=80=98const struct=20
atomic_t *=E2=80=99
/home/marek/batman-adv/hard-interface.c:298:2: warning: passing argument 1 =
of=20
=E2=80=98atomic_set=E2=80=99 discards =E2=80=98const=E2=80=99 qualifier fro=
m pointer target type [enabled by=20
default]
/usr/src/linux-headers-3.2.0-4-common/arch/x86/include/asm/atomic.h:35:20:=
=20
note: expected =E2=80=98struct atomic_t *=E2=80=99 but argument is of type =
=E2=80=98const struct=20
atomic_t *=E2=80=99

=09
> >  	/* Register the client MAC in the transtable */
> >=20
> > -	if (!is_multicast_ether_addr(ethhdr->h_source))
> > -		batadv_tt_local_add(soft_iface, ethhdr->h_source, vid,
> > -				    skb->skb_iif);
> > +	if (!is_multicast_ether_addr(ethhdr->h_source)) {
> > +		client_added =3D batadv_tt_local_add(soft_iface, ethhdr->h_source,
> > +						   vid, skb->skb_iif);
>=20
> Isn't this assignment as ugly as the following if condition?
>=20
> 		if (!batadv_tt_local_add(soft_iface, ethhdr->h_source, vid,
> 					 skb->skb_iif))
>=20
> client_added looks useless to me.

The general idea behind "client_added" was to increase readibility. For the=
=20
casual reader this variable makes it more obvious what goes on.


> > +/**
> > + * batadv_tt_local_table_transmit_size - calculates the local
> > translation table + *  size when transmitted over the air
> > + * @bat_priv: the bat priv with all the soft interface information
> > + *
> > + * Returns local translation table size in bytes.
> > + */
> > +static int batadv_tt_local_table_transmit_size(struct batadv_priv
> > *bat_priv) +{
> > +	struct batadv_softif_vlan *vlan;
> > +	uint16_t num_vlan =3D 0, tt_local_entries =3D 0;
> > +	int hdr_size;
>=20
> David always asks to sort variable declaration lines from the longest to
> the shorter.
> IMHO it is not really important (in particular in this case) but since you
> are creating the function now, please follow that indication.

Sure.


> > @@ -717,12 +762,6 @@ static void batadv_tt_tvlv_container_update(struct
> > batadv_priv *bat_priv)
> >=20
> >  	tt_diff_entries_num =3D atomic_read(&bat_priv->tt.local_changes);
> >  	tt_diff_len =3D batadv_tt_len(tt_diff_entries_num);
> >=20
> > -	/* if we have too many changes for one packet don't send any
> > -	 * and wait for the tt table request which will be fragmented
> > -	 */
> > -	if (tt_diff_len > bat_priv->soft_iface->mtu)
> > -		tt_diff_len =3D 0;
> > -
>=20
> Why are you removing this? We are not going to fragment OGMs and in this
> function we are preparing the TVLV to send within one of those.

Upon reading this function a realized this "tt_diff_len =3D 0" mechanism is=
=20
buggy. For instance, the changes_list list is not purged but keeps growing=
=20
until it magically fits the ogm diff again. Or checking bat_priv->soft_ifac=
e-
>mtu isn't terribly accurate either. The more I looked the more my head=20
started to spin. Suddenly, I was convinced we don't need the check anymore=
=20
because we have the fragmentation but you are right - it won't help here. I=
'll=20
add the check again but be aware that it is broken.

Thanks for the review!

Cheers,
Marek
