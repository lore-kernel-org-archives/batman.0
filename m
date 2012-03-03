Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 3 Mar 2012 16:43:12 +0800
References: <4F51CA9D.2090404@codigosur.org>
	<201203031553.53565.lindner_marek@yahoo.de>
	<4F51D34F.9040204@codigosur.org>
In-Reply-To: <4F51D34F.9040204@codigosur.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201203031643.12912.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] routing loops on interconnected routers / adhoc
	+ ethernet
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

On Saturday, March 03, 2012 16:16:15 Nicol=E1s Ech=E1niz wrote:
> Maerk thanks for your fast reply. In fact, that's how we started, that's
> what I meant by:
>=20
> "We have also tried adding eth0 to bat0 and take it out of br-lan, which
> also "works" but gives routing loops from time to time."
>=20
> but my english sometimes fails me :)

Your English is quite good. To be honest I lost the overview about what=20
interface is added where and what is connected how. Some people might be ab=
le=20
to simply look at the uci config to understand the setup but I am not one o=
f=20
those.  :-)

Let me write down what I understood - feel free to correct me.=20

some nodes -- node1 -- adhoc[wlan0-1] + ethernet[eth0] -- node2 -- more nod=
es

Each node also has wlan0 for non-mesh clients but this is of no relevance a=
t=20
this point. What is eth1 for ?

You are saying that from time to time the packets loop between node1 and no=
de2=20
using adhoc & ethernet to fly forth and back ?


> Is this a known issue or should this not happen in a setup where both
> interfaces are added to batman?

You should not have loops either way but it is easy to build loops in=20
complicated setups. At first we should understand your setup and=20
configuration. Drawing a little picture that shows what interface is connec=
ted=20
to what other interface also can help.

Regards,
Marek
