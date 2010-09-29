Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 29 Sep 2010 22:20:14 +0200
References: <4CA23D45.60306@magwas.rulez.org>
	<201009291228.55003.lindner_marek@yahoo.de>
	<4CA39669.50402@magwas.rulez.org>
In-Reply-To: <4CA39669.50402@magwas.rulez.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201009292220.14857.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Mesh with access from wifi and lan. Which is the
	Only True Way?
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

On Wednesday 29 September 2010 21:41:29 Magos=C3=A1nyi =C3=81rp=C3=A1d wrot=
e:
> I actually want to enable traffic. Any traffic from any node in the mesh.
> Regarding packet storm: I thought that the reject in the default=20
> iptables config might be there to stop propagation of some packets which=
=20
> would otherwise propagate and thus multiply in multiple routes. I am=20
> seeing batman packets rejected there.
> As you can see, working of batmand is somewhat a black magic for me,=20
> esp. wrt. the role of the gate interface.
>  From the fact that I had to touch the default firewall config to make=20
> it work has suggested that I either do some nonstandard thing, or I am=20
> doing it in the wrong way.

Normally, you don't any specific rules to make it work - it works as-is out=
 of=20
the box unless your system configures a firewall. If you tell your system t=
o=20
disable the firewall entirely everything will work.
What distribution are you using ? OpenWRT ?

The gateway handling (i.e. gate0) is documented:
http://www.open-mesh.org/wiki/InternetTuning
=46eel free to ask questions that the documentation does not answer. :-)


> This is why I try to figure out whether my config is sound enough before=
=20
> I give it to my village (some 8 thousand people).

Wow, sounds interesting. Where will that be ?

Regards,
Marek
