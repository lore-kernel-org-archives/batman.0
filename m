Return-Path: <sebastian.criado@gmail.com>
Message-ID: <4A61EB22.8060108@gmail.com>
Date: Sat, 18 Jul 2009 12:32:50 -0300
From: =?ISO-8859-1?Q?=22Sebasti=E1n_D=2E_Criado=22?=
	<sebastian.criado@gmail.com>
MIME-Version: 1.0
References: <8c906fa50907160755g41d2e437m11fa02c7fdde8cfb@mail.gmail.com>	<200907180252.07997.lindner_marek@yahoo.de>	<4A60FE9A.8040403@gmail.com>
	<200907181338.56870.lindner_marek@yahoo.de>
In-Reply-To: <200907181338.56870.lindner_marek@yahoo.de>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] VIS labels
Reply-To: sebastian.criado@gmail.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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

El 18/07/09 02:38, Marek Lindner escribi=F3:
> On Saturday 18 July 2009 06:43:38 Sebasti=E1n D. Criado wrote:
[...]
>> Am I wrong?
>=20
> The given code converts batman's own format into the format I mentioned=20
> earlier. Currently, batman uses a so called TQ value which expresses link=
=20
> quality as well and has its max value at 255. Performance considerations =
led=20
> to this kind of representation (you want to avoid float operations on emb=
edded=20
> devices). Imagine a link quality of 66.6%:
>=20
> 255 (TQ max) * 66.6% =3D 170
>=20
> 255 / 170 [orig_node->tq_max/(float)neigh->tq_avg] =3D 1.5 (vis label)
>=20
> 100 / 1.5 [100 / $number] =3D 66.6% (link quality)

Thank you very much Marek.
I now understand it better

>=20
> May be I should put that in the wiki somewhere ... :-)

Yes. Sure that will be helpful for more people

Saludos.-

--=20
Sebastian.Criado@gmail.com - GPG: 1024D/FB208AA2
797A 6D01 B7FC B8C7 AD5E|counter.li.org: #146768
2A50 66E6 2FFB FB20 8AA2|http://www.lugro.org.ar
http://noalamatricula.wordpress.com/about/ read!
"Si  el Universo fuera un programa estar=EDa hecho
en C, y correr=EDa sobre un sistema UNIX" An=F3nimo.

