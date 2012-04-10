Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 10 Apr 2012 14:31:40 +0300
References: <1333370896-11295-1-git-send-email-martin@hundeboll.net>
	<201204101405.16743.lindner_marek@yahoo.de>
	<4F8416C8.6010701@hundeboll.net>
In-Reply-To: <4F8416C8.6010701@hundeboll.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201204101431.41143.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/2] batman-adv: Add interface to keep stats
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

On Tuesday, April 10, 2012 14:17:28 Martin Hundeb=C3=B8ll wrote:
> >>> If you add an ifdef around the definition here would be no need to
> >>> malloc bat_stats separately, right ?
> >>=20
> >> Do we prefer IFDEFs in the definition over mallocs? (I guess so by your
> >> comment). If thats the case, then no problem with me.
> >=20
> > The types.h is full of ifdefs already. It helps to keep the structs
> > smaller when functionality is not compiled into the module.
>=20
> As long as we agree on ifdefs. They weren't there until BLAII and DAT add=
ed
> them, but I don't have a problem with'em. Let's see how long this
> patch-set will live, as I expect to use the get_ethtool_stats(), if
> possible.

Some of the counters might exist in bat_priv->stats as Antonio already poin=
ted=20
out (bat_priv->stats.rx_packets). They have the advantage of being printed=
=20
with ifconfig and friends.

Regards,
Marek
