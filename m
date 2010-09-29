Return-Path: <mag@magwas.rulez.org>
Message-ID: <4CA3A534.30102@magwas.rulez.org>
Date: Wed, 29 Sep 2010 22:44:36 +0200
From: =?UTF-8?B?TWFnb3PDoW55aSDDgXJww6Fk?= <mag@magwas.rulez.org>
MIME-Version: 1.0
References: <4CA23D45.60306@magwas.rulez.org>	<201009291228.55003.lindner_marek@yahoo.de>	<4CA39669.50402@magwas.rulez.org>
	<201009292220.14857.lindner_marek@yahoo.de>
In-Reply-To: <201009292220.14857.lindner_marek@yahoo.de>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

  On 2010-09-29 22:20, Marek Lindner wrote:
>
> Normally, you don't any specific rules to make it work - it works as-is=
 out of
> the box unless your system configures a firewall. If you tell your syst=
em to
> disable the firewall entirely everything will work.
> What distribution are you using ? OpenWRT ?
>

I am using OpenWrt Backfire.
One sign that I am using nonstandard setting is that a non-batman node=20
will end up in a throw route of the batman nodes.
But if it should work without firewall, then I will be happy with my=20
current setup.

> The gateway handling (i.e. gate0) is documented:
> http://www.open-mesh.org/wiki/InternetTuning
> Feel free to ask questions that the documentation does not answer. :-)
>
Thank you for the link. What I am seeing is that traffic from local wifi =

net does not "go down" to the tunnels, but goes through the batman nodes =

untunneled. Maybe I have to set up some routes from the local wifi net?
For your reference here is the network setup again (N is the node=20
number, ip of the node/netmask len):
backbone batman network: 10.42.0.N/24 (for batman nodes)
local wifi net: 10.42.N.1/24 (for non-batman users, dhcp served from the =

node in force mode)
local lan: 10.43.N.1/24 (for wired users, DHCP served from the node)
>> This is why I try to figure out whether my config is sound enough befo=
re
>> I give it to my village (some 8 thousand people).
> Wow, sounds interesting. Where will that be ?

P=C3=A1ty, Hungary. We are experimenting with participatory democracy, an=
d=20
this is one of the side effects:)


