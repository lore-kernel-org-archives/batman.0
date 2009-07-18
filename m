Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 18 Jul 2009 13:38:56 +0800
References: <8c906fa50907160755g41d2e437m11fa02c7fdde8cfb@mail.gmail.com>
	<200907180252.07997.lindner_marek@yahoo.de>
	<4A60FE9A.8040403@gmail.com>
In-Reply-To: <4A60FE9A.8040403@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <200907181338.56870.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] VIS labels
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>

On Saturday 18 July 2009 06:43:38 Sebasti=E1n D. Criado wrote:
> In http://www.open-mesh.net/browser/trunk/vis/vis.c
> i saw the following calculation.
>
> orig_node->tq_max/(float)neigh->tq_avg
>
> for link quality (VIS label).
>
> If this is correct, would not be so linear.
> Am I wrong?

The given code converts batman's own format into the format I mentioned=20
earlier. Currently, batman uses a so called TQ value which expresses link=20
quality as well and has its max value at 255. Performance considerations le=
d=20
to this kind of representation (you want to avoid float operations on embed=
ded=20
devices). Imagine a link quality of 66.6%:

255 (TQ max) * 66.6% =3D 170

255 / 170 [orig_node->tq_max/(float)neigh->tq_avg] =3D 1.5 (vis label)

100 / 1.5 [100 / $number] =3D 66.6% (link quality)


May be I should put that in the wiki somewhere ... :-)

Regards,
Marek

