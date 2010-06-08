Return-Path: <sebastian.criado@gmail.com>
Message-ID: <4C0E7AE2.9080204@gmail.com>
Date: Tue, 08 Jun 2010 14:16:18 -0300
From: =?ISO-8859-1?Q?=22Sebasti=E1n_D=2E_Criado=22?=
	<sebastian.criado@gmail.com>
MIME-Version: 1.0
References: <4C07CD29.7000505@gmail.com> <201006081832.39301.neumann@cgws.de>
In-Reply-To: <201006081832.39301.neumann@cgws.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] BMX, client node doesn't choose a gateway node.
Reply-To: sebastian.criado@gmail.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: Axel Neumann <neumann@cgws.de>, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

El 08/06/10 13:32, Axel Neumann escribi=F3:
> On Donnerstag 03 Juni 2010, Sebasti=E1n D. Criado wrote:
>> Hello,
>>
>> I'm having a problem with BMX when trying to make a client node
>> connect to a gateway node.
>>
>> It's BatMan-eXp 0.3-rc1 rv1636 (compatibility version 10).
>>
> ...
>>
>> The start of the client node it's made with: /usr/sbin/bmxd dev=3Dath2
>> -o 2000 -r 1
>>

Hi Alex. thanks for replying

> I could reproduce the problem. There is someting strange with -r [0..2]. =
Only=20
> -r 3 seems working as expected in the current code.
>=20
> Can you confirm if -r 3 works fine in your setup?

Yes. It works with that.

> Meanwhile I'll check the code whats going on there...=20

ok. I will keep waiting for your news.

>=20
> Thanks for the report and sorry for the late response.

Thanks you.

> cu
> /axel



--=20
Sebastian.Criado@gmail.com - GPG: 1024D/7D98DF14
37E4 246A F17B 689F 9F2D|counter.li.org: #146768
0578 B1AA 8CDB 7D98 DF14|http://www.lugro.org.ar
http://noalamatricula.wordpress.com/about/ read!
"Si  el Universo fuera un programa estar=EDa hecho
en C, y correr=EDa sobre un sistema UNIX" An=F3nimo.

