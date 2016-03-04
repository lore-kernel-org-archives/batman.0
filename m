Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 04 Mar 2016 16:50:43 +0100
Message-ID: <2378940.op5bKN67gL@sven-edge>
In-Reply-To: <20160304152132.GV15541@lunn.ch>
References: <20160304152132.GV15541@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2599269.LDVhAB0iB0";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Use of ref_get_unless_zero() ?
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>

--nextPart2599269.LDVhAB0iB0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Friday 04 March 2016 16:21:32 Andrew Lunn wrote:
> Hi
>=20
> I'm sometimes getting a crash after removing a hard interface when th=
e
> batadv_send_outstanding_bat_org_packet() is called in a work queue.
> It calls
>=20
> static void batadv_iv_ogm_aggregate_new(const unsigned char *packet_b=
uff,
>                                         int packet_len, unsigned long=

> send_time, bool direct_link,
>                                         struct batadv_hard_iface
> *if_incoming, struct batadv_hard_iface *if_outgoing, int own_packet)
> {
>         struct batadv_priv *bat_priv =3D netdev_priv(if_incoming->sof=
t_iface);
> struct batadv_forw_packet *forw_packet_aggr;
>         unsigned char *skb_buff;
>         unsigned int skb_size;
>=20
>         if (!kref_get_unless_zero(&if_incoming->refcount))
>                 return;
>=20
>         if (!kref_get_unless_zero(&if_outgoing->refcount))
>                 goto out_free_incoming;
>=20
>=20
> Given that we have:
>=20
> static inline void batadv_hardif_put(struct batadv_hard_iface *hard_i=
face)
> {
>         kref_put(&hard_iface->refcount, batadv_hardif_release);
> }
>=20
> does using kref_get_unless_zero() make sense? If it is zero, hasn't i=
t
> been freed by the kref_put that set it to zero?

At least it makes sense for the outgoing interface because it is only i=
n a=20
rcu_read_lock in batadv_iv_ogm_schedule (batadv_iv_ogm_queue_add ->=20
batadv_iv_ogm_aggregate_new). The batadv_hardif_list is traversed with=20=

list_for_each_entry_rcu and it is expected that one entry (maybe) gets =
dropped=20
from=20the list. The batadv_hardif_release will only queue the actual fre=
e of=20
the memory (kfree_rcu) and every function which wants to get a referenc=
e has=20
to increase the counter with kref_get_unless_zero to check that it is n=
ot=20
actually in the waiting-to-be-freed-phase.

But you have something which needs to be fixed (you see a crash). Quest=
ion is=20
what is causing the crash and what can be done against it. I am current=
ly=20
wondering how the if_incoming interface is being protected. It is not f=
etched=20
from=20a list via a rcu list access primitive and it is not protected via=
=20
rcu_read_lock. I can also not see where the reference for the forw_pack=
et-
>if_incoming is increased. It is just accessed in=20
batadv_send_outstanding_bat_ogm_packet (and later send to the mentioned=
=20
function via batadv_schedule_bat_ogm). Also batadv_add_bcast_packet_to_=
list=20
doesn't increase the reference counter for if_incoming before adding to=
 the=20
forward packet. So I would just say that the reference counting for=20
batadv_hard_iface is broken.


Kind regards,
=09Sven
--nextPart2599269.LDVhAB0iB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW2a7TAAoJEF2HCgfBJntG/L0P/3OmwyUJsqwpyfZfzbRX/EuR
elLAq1mJwJcrlq78U+0bHP1SYYAlXpUzPFMB4PaOvss2WbYAQU7lO8VRvWPrhwQE
IP/cm3O8V7SzfE/MOG4+iY4P9POs79QCNNE/qiL/wga2tYBPvtnmkGmOYfjeIWpB
2EGey3iioxh0+1Lfr9xVQsihZwWNVH9YrEAxq0X/GDfTVb6Ny2nwGzTzmjKtBqrl
AS/1V5TUD56QL4SFDE7GkKhEigtWOnuucnJjnXpzsIcpIyta7RIzQUFxXVUqq+ba
/gyVKhJkkohl0Rx/hPEcQwFIPqJJv3HdXL+8UKh5nINhrJkeC4wf1FpN55sttsvm
s2NXbg7XFD34GGLexphSHLGEj1d4M8xCi5P+NDbsKoFFSEwUizs/F9tGkQ8bga6W
G1QyfgHfxgirPp0+ZrAAktRJPxlr26yNQ4NRogSJL83KcQH6VM68Bswc6uXkW/os
8+/A3VWasDvcL3VX0x/WCE3TgEOpjsHrglsNZtCa2klFow8wX+lI3fjMyCN5mKXh
HDRPwyl1qVNSiS6QpZZA7k9Q/S6k+AZ2lBkEiSJ1cvhLXK1Ip8mHEXyf2rWkeko6
/ceMzIfa3B8ph6PEKiu9ki6ZV4GBFja1B881mkO/xE8tiaGYhk/7sR6RYtezEcP9
ICiYLKqeDP5Q3qPWRyVX
=pT1I
-----END PGP SIGNATURE-----

--nextPart2599269.LDVhAB0iB0--

