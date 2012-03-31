Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <CAA_JP8UxNW18xWZe62ySY=H27HDnZY1YBQV-7ZGUHYnSS-ZSHw@mail.gmail.com>
References: <CAA_JP8X+vPn39-QK-zPjdd1Mtn4PCTjigpV4fFM6sTVUmBiLTg@mail.gmail.com>
	<CAHD-aqKN_+5fwg65Udpr6jxt5tFsu5XXsMWkk75ujPK3bJcqJw@mail.gmail.com>
	<CAA_JP8UxNW18xWZe62ySY=H27HDnZY1YBQV-7ZGUHYnSS-ZSHw@mail.gmail.com>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Sat, 31 Mar 2012 00:48:22 -0300
Message-ID: <CAHD-aqK_CGbc8u5GuEBJyFzrk2rTHHTw=bAiWjFafAW9xOqWiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [B.A.T.M.A.N.] link alternation when radios are not on
	batman-adv router?
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

On Fri, Mar 30, 2012 at 2:18 PM, dan <dandenson@gmail.com> wrote:

> ok, this is an option I had considered, but I'm worried that link
> alternation wont be an option as the radios only have a single radio
> and the alternate path is through a completely different radio/device
> connected via ethernet.
batman-adv makes no difference between ethernet or radio interfaces,
they are all simply just interfaces that somehow link to other
batman-adv nodes (with some -or zero- packet loss)
so link alternation would work the same: if packet comes in through
radio, and batman-adv can reach the destination through the ethernet
port (it doesn't matter if that implies hopping through more
batman-adv nodes) it will prefer sending it through this "alternate"
path (alternate in the sense it doesn't use the same interface the
packet came in)

>
> As far as vlans are concerned, are you saying to have a vlan on the
> router for each attached picostation and then set the picostations
> ethernet interface to match that vlan? =C2=A0Then I can add all the vlans
> to bat0?

exactly.

> maybe if you could clarify this for me. =C2=A0for link alternating, do th=
e
> two nodes need to be one hop neighbors?
Nope, not needed. And in fact it is "interface alternation" (subtle differe=
nce).
if packet comes in through interface A, and the final destination is
reachable through 2 different paths that start at interface A and
interface B respectively, it will send the packet through interface B
to avoid reusing interface A.
It doesn't matter if between interface B and final destination there are N =
hops.

A long thread earlier this month was particularly clarifying on the subject=
.
https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-March/006351.html

>
> according to docs, link alternating works in this scenario, where both
> links are good:
> node1_Link1------------node2_Link1
> node1_Link2------------node2_Link2
>
> but what about this:
> node1_Link1------node3_Link1------node2_Link1
> node1_Link2------node4_Link2------node2_Link2
>
> will node1 and node2 still have link alternation?
Yes. in addition you might also be interested in interface bonding,
which is not enabled by default but can be activated after
understanding a few caveats. it's documented on batctl manpage online.

>=C2=A0This is basically
> what the central router + picostations with the picostations running
> batman-adv would look like
>
>
> supernode1-------picostation1---------picostation1--------supernode2
> supernode1-------picostation2---------picostation2--------supernode2
>
> so supernode2 is then a 3 hop neighbor to supernode1. =C2=A0So will link
> alternation work here? =C2=A0Lets just say that supernode1 has the backha=
ul
> and supernode2 has nothing except it's link to supernode1. =C2=A0Ideally,
> SN2 gets the faster, dual link connection to SN1.

If picostations are only connected point-to-point to each other, and
there are no other clients sending traffic to them (except the
supernodes), then interface alternating won't take advantage of the
"faster dual link connection"
You must use interface bonding to achieve that.

Interface alternating would be useful, for example, if picostation2
from supernode2 was receiving a radio transmission from a distant
supernode3 (not pictured) destined at supernode1. Then, instead of
trying to relay the packets through that same picostation2, it would
use picostation1 to send them and avoid reusing the same interface.

Cheers!

Guido
