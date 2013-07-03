Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Jul 2013 19:25:36 +0800
References: <1372840800-642-1-git-send-email-linus.luessing@web.de>
 <20130703102223.GF2325@ritirata.org>
In-Reply-To: <20130703102223.GF2325@ritirata.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201307031925.36734.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3] batman-adv: refine API calls for
	unicast transmissions of SKBs
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
Cc: Antonio Quartulli <ordex@autistici.org>

On Wednesday, July 03, 2013 18:22:23 Antonio Quartulli wrote:
> On Wed, Jul 03, 2013 at 10:40:00AM +0200, Linus L=FCssing wrote:
> > With this patch the functions batadv_send_skb_unicast() and
> > batadv_send_skb_unicast_4addr() are further refined into
> > batadv_send_skb_via_tt(), batadv_send_skb_via_tt_4addr() and
> > batadv_send_skb_via_gw(). This way we avoid any "guessing" about where =
to
> > send a packet in the unicast forwarding methods and let the callers
> > decide.
> >
> >=20
> >
> > This is going to be useful for the upcoming multicast related patches in
> > particular.
> >
> >=20
> >
> > Further, the return values were polished a little to use the more
> > appropriate NET_XMIT_* defines.
> >
> >=20
> >
> > Signed-off-by: Linus L=FCssing <linus.luessing@web.de>
>=20
> Acked-by: Antonio Quartulli <ordex@autistici.org>

Applied in revision ab91f68.

Thanks,
Marek
