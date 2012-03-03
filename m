Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 3 Mar 2012 15:53:53 +0800
References: <4F51CA9D.2090404@codigosur.org>
In-Reply-To: <4F51CA9D.2090404@codigosur.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201203031553.53565.lindner_marek@yahoo.de>
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

On Saturday, March 03, 2012 15:39:09 Nicol=E1s Ech=E1niz wrote:
> this happens with the nodes configured according to:
> http://www.open-mesh.org/wiki/batman-adv/Bridge-loop-avoidance
>=20
> or so we understand!

If the ethernet is used for mesh purposes uniquely why do you bother runnin=
g=20
the bridge loop avoidance at all instead of adding the ethernet interface a=
s a=20
regular batman interface ? The only reason why you would want the bridge lo=
op=20
avoidance is when you have ethernet clients that are bridged into the mesh.=
=20
This does not seem to be the case. As far as I understand the ethernet cabl=
e=20
is used as reliable "wireless cable".

Cheers,
Marek
=20
