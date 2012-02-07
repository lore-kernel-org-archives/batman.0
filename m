Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 7 Feb 2012 19:50:50 +0800
References: <201202071719.22804.lindner_marek@yahoo.de>
	<201202071911.00384.lindner_marek@yahoo.de>
	<4F310757.7030801@hundeboll.net>
In-Reply-To: <4F310757.7030801@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201202071950.51417.lindner_marek@yahoo.de>
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

On Tuesday, February 07, 2012 19:13:27 Martin Hundeb=C3=B8ll wrote:
> On 2012-02-07 12:10, Marek Lindner wrote:
> >>> +	unsigned long random_seqno;
> >>>=20
> >>> >  >  +
> >>> >  >  +	/* randomize initial seqno to avoid collision */
> >>> >  >  +	get_random_bytes(&random_seqno, sizeof(unsigned long));
> >>> >  >  +	atomic_set(&hard_iface->seqno, (uint32_t)random_seqno);
> >> > =20
> >> >  Wouldn't it be better to cast "unsigned long" in the call to
> >> >  atomic_set()?
> >=20
> > Why should it better ?
>=20
> Maybe not better, but at least it is consistent with the type of
> random_seqno, which is unsigned long. I know the two types are identical,
> but nevertheless, I like to use the same type of type :)

You lost me somewhere. Yes, random_seqno is unsigned long. If we wanted to=
=20
store unsigned long we would not need a cast.=20
However, in my kernel the second argument for atomic_set() is "int" and not=
=20
"unsigned long" which why we have a cast there.

Regards,
Marek
