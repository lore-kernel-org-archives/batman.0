Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 7 Feb 2012 19:10:59 +0800
References: <201202071719.22804.lindner_marek@yahoo.de>
	<1328606451-3418-2-git-send-email-lindner_marek@yahoo.de>
	<4F30EFDA.9010405@hundeboll.net>
In-Reply-To: <4F30EFDA.9010405@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201202071911.00384.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH 3/8] batman-adv: randomize initial seqno
	to avoid collision
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

On Tuesday, February 07, 2012 17:33:14 Martin Hundeb=C3=B8ll wrote:
> On 2012-02-07 10:20, Marek Lindner wrote:
> > Signed-off-by: Marek Lindner<lindner_marek@yahoo.de>
> > ---
> >=20
> >   bat_iv_ogm.c |    5 +++++
> >   1 files changed, 5 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/bat_iv_ogm.c b/bat_iv_ogm.c
> > index 3eff7f0..4ac2d1d 100644
> > --- a/bat_iv_ogm.c
> > +++ b/bat_iv_ogm.c
> > @@ -33,6 +33,11 @@
> >=20
> >   static void bat_iv_ogm_iface_enable(struct hard_iface *hard_iface)
> >   {
> >  =20
> >   	struct batman_ogm_packet *batman_ogm_packet;
> >=20
> > +	unsigned long random_seqno;
> > +
> > +	/* randomize initial seqno to avoid collision */
> > +	get_random_bytes(&random_seqno, sizeof(unsigned long));
> > +	atomic_set(&hard_iface->seqno, (uint32_t)random_seqno);
>=20
> Wouldn't it be better to cast "unsigned long" in the call to atomic_set()?

Why should it better ?

Regards,
Marek
