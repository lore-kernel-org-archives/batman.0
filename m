Return-Path: <mag@magwas.rulez.org>
Message-ID: <4CA39669.50402@magwas.rulez.org>
Date: Wed, 29 Sep 2010 21:41:29 +0200
From: =?UTF-8?B?TWFnb3PDoW55aSDDgXJww6Fk?= <mag@magwas.rulez.org>
MIME-Version: 1.0
References: <4CA23D45.60306@magwas.rulez.org>
	<201009291228.55003.lindner_marek@yahoo.de>
In-Reply-To: <201009291228.55003.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: b.a.t.m.a.n@lists.open-mesh.org

  On 2010-09-29 12:28, Marek Lindner wrote:
> On Tuesday 28 September 2010 21:08:53 Magos=C3=A1nyi =C3=81rp=C3=A1d wr=
ote:
>> But with three nodes in a linear topology user-A-B-C, the reject
>> firewall chain (basically the FORWARD chain) eats up the packets user-=
>A
>> This is the same rule which rejects batman packets A->C which go throu=
gh
>> B, and there are the gate interface which I do not understand, so whil=
e
>> the following rules seem to solve the problem at least for three nodes=
,
>> I have a feeling that I am not on the right path, and maybe on a way t=
o
>> cause packet storms.
>> iptables -A forwarding_rule -d 10.42.0.0/24 ! -s 10.42.0.0/24 -i ath0 =
-o
>> ath0 -j ACCEPT
>> iptables -A forwarding_rule -s 10.42.0.0/24 ! -d 10.42.0.0/24 -o ath0 =
-i
>> ath0 -j ACCEPT
> Could you explain what kind of traffic you actually want to block ? I a=
lso don't
> understand what packet storm you are afraid of.
>
I actually want to _enable_ traffic. Any traffic from any node in the mes=
h.
Regarding packet storm: I thought that the reject in the default=20
iptables config might be there to stop propagation of some packets which =

would otherwise propagate and thus multiply in multiple routes. I am=20
seeing batman packets rejected there.
As you can see, working of batmand is somewhat a black magic for me,=20
esp. wrt. the role of the gate interface.
 From the fact that I had to touch the default firewall config to make=20
it work has suggested that I either do some nonstandard thing, or I am=20
doing it in the wrong way.
This is why I try to figure out whether my config is sound enough before =

I give it to my village (some 8 thousand people).


