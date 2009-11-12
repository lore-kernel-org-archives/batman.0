Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 12 Nov 2009 11:28:37 +0800
References: <20091109190206.GA2642@Linus-Debian>
	<200911101834.41970.lindner_marek@yahoo.de>
	<20091112005149.GA2879@Linus-Debian>
In-Reply-To: <20091112005149.GA2879@Linus-Debian>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Message-Id: <200911121128.38384.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] BATMAN-Adv and MTU handling
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

On Thursday 12 November 2009 08:51:49 Linus L=FCssing wrote:
> Ah, wait, I forgot one thing: It worked for our hotspots because
> the coovachili internet gateway had an MTU equal to the PMTU all
> the way through the mesh. But you are right, we are probably
> having some trouble when having too mesh clients which are bridged
> to each other and have an MTU set to 1500...

Ok, then we are on the same page.  :)


> I'm wondering what you think of how tinc is handling this at the
> moment in switch mode: It just "fakes" an ICMPv4/6 message with
> the address of the destination if such a hop is getting an
> IP-packet bigger than the link MTU. This might sound like a good
> idea at first sight, but the disadvantage is, that you're getting
> trouble in IPSec-only networks (which are quite rare at the
> moment, yes :) ).

This sounds rather hacky - I can think of more scenarios in which that=20
approach will fail (encryption being one of them). The compression idea And=
rew=20
was talking about sounds much more promissing.


> Nope, tinc is able to create a TUN (router mode) and TAP (switch
> mode) network adapter, so it is able to actually transport the
> original ethernet frame as well:
> [ETHER][IP][UDP/TCP][ETHER][BATMAN-HDR][PAYLOAD]

That is besides the point.
Tinc is able to let the kernel handle the fragmentation because it forwards=
=20
packets on layer 3 and not on layer 2 (even if it can encapsulate layer 2=20
packets). Batman-adv forwards on layer 2 ...

Regards,
Marek
