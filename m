Return-Path: <simon.wunderlich@s2003.tu-chemnitz.de>
Date: Wed, 2 Nov 2011 12:01:12 +0100
From: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Message-ID: <20111102110112.GA6355@pandem0nium>
References: <1320015072-10313-1-git-send-email-siwu@hrz.tu-chemnitz.de>
	<1320015072-10313-3-git-send-email-siwu@hrz.tu-chemnitz.de>
	<201111011152.46222.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
In-Reply-To: <201111011152.46222.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 02/11] batman-adv: add basic bridge loop
 avoidance code
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


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 01, 2011 at 11:52:45AM +0100, Marek Lindner wrote:
> On Sunday, October 30, 2011 23:51:03 Simon Wunderlich wrote:
> > +static const uint8_t announce_mac[6] =3D {0x43, 0x05, 0x43, 0x05, 0x00,
> > 0x00};
>=20
> All we ever use are 4 bytes - we could make this shorter. Otherwise pleas=
e use=20
> ETH_ALEN. Please use ETH_ALEN throughout the code instead of 6.
>=20

OK, that's right, i'll change it to 4 and use ETH_ALEN at the other place w=
here i missed it.
=20
> > +       bat_dbg(DBG_BLA, bat_priv,
> > +               "handle_announce(): ANNOUNCE vid %d (sent "
> > +               "by %pM)... CRC =3D %04x (nw order)\n",
> > +               vid, backbone_gw->orig, crc);
>=20
> It is not network byte order anymore ..
>=20

OK

> +       /* TODO: we could cal something like tt_local_del() here. */
>=20
> Why should we ?
>=20
>=20

Because when someone claims the adress, the the client has roamed to the me=
sh.

Usually this is handled by the tt roaming code, this will only fail in a li=
mited
horizon scenario where a node does not know the other node the client roame=
d to.
In this case, the tt will time out after a long while.

This is just an idea/optimization to add the tt_local_del(). :)

> > @@ -634,7 +640,7 @@ static int batman_skb_recv(struct sk_buff *skb, str=
uct
> > net_device *dev, case BAT_TT_QUERY:
> >                 ret =3D recv_tt_query(skb, hard_iface);
> >                 break;
> > -               /* Roaming advertisement */
> > +               /* bridge roop avoidance query */
> >         case BAT_ROAM_ADV:
> >                 ret =3D recv_roam_adv(skb, hard_iface);
> >                 break;
>=20
> Small typo here but why are you even changing the comment ?
>=20

Oh thanks, this is wrong. This comes from an earlier version of the BLA tab=
le
changes where I used a special packet type.=20

The comment should not be changed.

> >         atomic_t gw_reselect;
> >         struct hard_iface __rcu *primary_if;  /* rcu protected pointer =
*/
> >         struct vis_info *my_vis_info;
> > +       uint8_t own_orig[6];            /* cache primary hardifs addres=
s */
> >  };
>=20
> I'd call this "primary_addr" instead of "own_orig" to be consistent with=
=20
> "primary_if". Furthermore ETH_ALEN should be used for the length.
>=20

OK.

> > +struct backbone_gw {
> > +       uint8_t orig[ETH_ALEN];
> > +       short vid;              /* used VLAN ID */
> > +       struct hlist_node hash_entry;
> > +       struct bat_priv *bat_priv;
> > +       unsigned long lasttime; /* last time we heard of this backbone =
gw */
> > +       atomic_t request_sent;
> > +       atomic_t refcount;
> > +       struct rcu_head rcu;
> > +       uint16_t crc;           /* crc checksum over all claims */
> > +} __packed;
> > +
> > +struct claim {
> > +       uint8_t addr[ETH_ALEN];
> > +       short vid;
> > +       struct backbone_gw *backbone_gw;
> > +       unsigned long lasttime; /* last time we heard of claim (locals =
only)
> > */
> > +       struct rcu_head rcu;
> > +       atomic_t refcount;
> > +       struct hlist_node hash_entry;
> > +} __packed;
>=20
> Why are these structs packed ?

For similar reasons as the tt_global/local_entry issue: The hash functions =
both
access orig and vid from these structures.

However, as there are not that many sharing function I'll split it into
choose_claim()/choose_backbone_gw() and remove the __packed attribute.

In this case, it should be a little bit shorter and cleaner than using a co=
mmon
structure (no container_of() stuff).

Thanks for the comments, you'll find the changed stuff as patches in my bla=
II_dirty repo.

Cheers,
	Simon

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEUEARECAAYFAk6xIvgACgkQrzg/fFk7axaMswCfctRuj+wcfOvVCbjFVDQfmGUa
PIgAliY8xn6bhQlWAlaLH/pSRw83LcA=
=Ks4R
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
