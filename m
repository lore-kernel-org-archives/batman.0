Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
Date: Wed, 9 Sep 2020 17:27:56 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: Re: [PATCH maint v2 4/4] batman-adv: mcast: fix duplicate mcast
 packets from BLA backbone to mesh
Message-ID: <20200909152756.GD2391@otheros>
References: <20200904182803.8428-1-linus.luessing@c0d3.blue>
 <20200904182803.8428-5-linus.luessing@c0d3.blue>
 <3191833.Be6Uz4tNrB@prime>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3191833.Be6Uz4tNrB@prime>
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Wed, Sep 09, 2020 at 02:15:51PM +0200, Simon Wunderlich wrote:
> On Friday, September 4, 2020 8:28:03 PM CEST Linus L=C3=BCssing wrote:
> > @@ -1626,7 +1626,8 @@ bool batadv_bla_check_bcast_duplist(struct bata=
dv_priv
> > *bat_priv, if (entry->crc !=3D crc)
> >                         continue;
> >=20
> > -               if (batadv_compare_eth(entry->orig, bcast_packet->ori=
g))
> > +               if (!is_zero_ether_addr(entry->orig) &&
> > +                   batadv_compare_eth(entry->orig, orig))
> >                         continue;
> >=20
> >                 /* this entry seems to match: same crc, not too old,
>=20
> Shouldn't this check also be skipped if the orig parameter is a zero ma=
c=20
> address? i.e.:
>=20
> if (!is_zero_ether_addr(orig)) {
> 	if (!is_zero_ether_addr(entry->orig) && batadv_compare_eth(entry->orig=
,=20
> orig))
> 		continue;
> }

Would be redundant. If entry->orig is non-zero and
the compare_eth() says they are equal, then orig must also be
non-zero.

I initially wanted to leave the code as unchanged as possible for
net / maint. Should I do the restructuring to enhance readability, with
the bool in this patch or in additional patch for net-next?
