Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 29 Sep 2010 12:28:54 +0200
References: <4CA23D45.60306@magwas.rulez.org>
In-Reply-To: <4CA23D45.60306@magwas.rulez.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201009291228.55003.lindner_marek@yahoo.de>
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

On Tuesday 28 September 2010 21:08:53 Magos=C3=A1nyi =C3=81rp=C3=A1d wrote:
> But with three nodes in a linear topology user-A-B-C, the reject=20
> firewall chain (basically the FORWARD chain) eats up the packets user->A
> This is the same rule which rejects batman packets A->C which go through=
=20
> B, and there are the gate interface which I do not understand, so while=20
> the following rules seem to solve the problem at least for three nodes,=20
> I have a feeling that I am not on the right path, and maybe on a way to=20
> cause packet storms.
> iptables -A forwarding_rule -d 10.42.0.0/24 ! -s 10.42.0.0/24 -i ath0 -o=
=20
> ath0 -j ACCEPT
> iptables -A forwarding_rule -s 10.42.0.0/24 ! -d 10.42.0.0/24 -o ath0 -i=
=20
> ath0 -j ACCEPT

Could you explain what kind of traffic you actually want to block ? I also =
don't=20
understand what packet storm you are afraid of.

Regards,
Marek
