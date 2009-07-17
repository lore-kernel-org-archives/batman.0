Return-Path: <sebastian.criado@gmail.com>
Message-ID: <4A60FE9A.8040403@gmail.com>
Date: Fri, 17 Jul 2009 19:43:38 -0300
From: =?ISO-8859-1?Q?=22Sebasti=E1n_D=2E_Criado=22?=
	<sebastian.criado@gmail.com>
MIME-Version: 1.0
References: <8c906fa50907160755g41d2e437m11fa02c7fdde8cfb@mail.gmail.com>	<200907172154.13655.lindner_marek@yahoo.de>	<4A6094C9.8020109@gmail.com>
	<200907180252.07997.lindner_marek@yahoo.de>
In-Reply-To: <200907180252.07997.lindner_marek@yahoo.de>
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

El 17/07/09 15:52, Marek Lindner escribi=F3:
> On Friday 17 July 2009 23:12:09 Sebasti=E1n D. Criado wrote:
>> Is 3 =3D 25% or 3 =3D 33,3 %?
>=20
> 3 is 33.3% and 4 is 25%.

Ok.
>=20
>=20
>> What function is in use?
>=20
> Not sure that I get your question. Do you mean that:
> link quality =3D 100 / $number

In http://www.open-mesh.net/browser/trunk/vis/vis.c
i saw the following calculation.

orig_node->tq_max/(float)neigh->tq_avg

for link quality (VIS label).

If this is correct, would not be so linear.
Am I wrong?

Saludos.-


--=20
Sebastian.Criado@gmail.com - GPG: 1024D/FB208AA2
797A 6D01 B7FC B8C7 AD5E|counter.li.org: #146768
2A50 66E6 2FFB FB20 8AA2|http://www.lugro.org.ar
http://noalamatricula.wordpress.com/about/ read!
"Si  el Universo fuera un programa estar=EDa hecho
en C, y correr=EDa sobre un sistema UNIX" An=F3nimo.

