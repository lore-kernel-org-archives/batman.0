Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 18 Jan 2010 21:38:32 +0800
References: <20100118112706.91160@gmx.net> <20100118113954.GC7844@lunn.ch>
	<20100118132935.91200@gmx.net>
In-Reply-To: <20100118132935.91200@gmx.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201001182138.32432.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] batman-adv on different archs
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

On Monday 18 January 2010 21:29:35 Juha Yl=F6nen wrote:
> I couldn't find any info on debug build in the README, and some
>  instructions I came across in the wiki didn't really work,

Could you please let us know what part of the wiki does not work as expecte=
d ?=20
Only then we can improve it.  :)


>  so I went and  modified log.c directly to printk everything that is pass=
ed
>  to debug_log.

Actually, there is a debug level which you can modify to obtain the same=20
result ...  ;)


> batman-adv: bidirectional: orig =3D 00:22:fa:dc:9a:ce neigh =3D
>  00:22:fa:dc:9a:ce =3D> own_bcast =3D  0, real recv =3D 63, local tq:   0,
>  asym_penalty: 255, total tq:   0 ---
>=20
> Interestingly there seems to be packets coming and going from my laptop?

Yes, the devices are talking to each other. "real recv" indicates you recei=
ved=20
the other node's messages but the other node does not repeat our own=20
broadcasts (see "own_bcast"). Would be interesting to see the log from the=
=20
other side. It looks like the messages get dropped there.

Regards,
Marek
