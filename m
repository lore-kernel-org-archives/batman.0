Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABj6hTG8JDRFZxM77B_9mLsK-YOvYkJyFpXQzEt7q65LUVYq3A@mail.gmail.com>
References: <CAL4ejvQpfAQUUupvDpAx3xek3QggQc_Gi81ucm=EERo+aBwFdQ@mail.gmail.com>
 <CAF0yFe4xwGomt=gud+7YZ4jfd_qSX9U=B7QYUhaBUjeJjh_D5Q@mail.gmail.com>
 <CAPmmg8swQNQQuEZw3Hhpvv2aj6nXdfhobnpyb8U9RnFR-ZX+Ag@mail.gmail.com>
 <87zj229nfa.wl-jch@pps.univ-paris-diderot.fr>
 <CAKLmikN6hrDwyC6u4Za94x0FRiyYuqKakO8-Q7zsFc6Gq=zOMw@mail.gmail.com>
 <87fv3twccq.wl-jch@pps.univ-paris-diderot.fr>
 <CABj6hTG8JDRFZxM77B_9mLsK-YOvYkJyFpXQzEt7q65LUVYq3A@mail.gmail.com>
Date: Mon, 10 Aug 2015 08:39:26 +0200
Message-ID: <CAKLmikOxi5mc1ZeLK9YN_WvdR92QHNaTvpvY5c47f+M=OHTEVw@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [B.A.T.M.A.N.] Fwd: [Babel-users] Fwd: Why we switched to Babel
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi!

One more precise explanation of issues. Is this really a limitation of Batman?


Mitar

---------- Forwarded message ----------
From: max b <maxb.personal@gmail.com>
Date: Mon, Aug 10, 2015 at 5:01 AM
Subject: Re: [Babel-users] Fwd: Why we switched to Babel

Marc will probably chime in here as we had plenty of sit downs trying
to figure out how to incorporate BATMAN into our topology, but I
(hope) I can help articulate the issue:

Our topology was the following (very simplified). It mirrored (and was
inspired by) the wlan slovenijia project.

Cloud (or colocation) hosted exit server running batman
 l2tp interface
  |
 V
l2tp interface
OpenWRT wifi router running batman
open0 interface
 |
V
heterogenous set of hosts connected wirelessly over an open network.

The routers create l2tp tunnels to the exit server when they have an
direct internet connection (ie. someone is sharing their bandwidth).
The open0 and l2tp interfaces were added to batman, along with an
adhoc interface which would connect to other routers over wifi. The
l2tp interfaces had to have a non-standard MTU, they were an l2tp
interface carrying batman-adv "frames".

The problem is that the hosts connecting to the open network would
generally not respect dhcp options setting an MTU. A significant
number of hosts - including I believe all windows machines and at
least IOS devices - would just set the MTU of their wireless interface
to 1500. Under normal circumstances, this wouldn't be an issue because
"When a packet arrives at a node from a client with too large an mtu,
what SHOULD happen in a normal forwarding situation (per RFC 1191) is
that the node issue a ICMP 'Destination Unreachable' packet with a
"Fragmentation required" code. The client then uses this information
to reset its mtu." (I'm quoting an email exchange from our mailing
list: https://sudoroom.org/pipermail/mesh-dev/2014-October/000019.html)

However, in our situation, we were essentially stuck bridging two
interfaces that had different MTUs because they were both added to
this batman-adv layer 2 forwarding daemon. Because there was no layer
3 routing going on, the ICMP message would never be sent. We were just
seeing dropped frames in wireshark analyses - client devices wouldn't
adjust their mtu and they wouldn't fragment because they wouldn't know
to.

We tried a couple workarounds, including an iptables MSS clamping
rule, but that only works for TCP traffic. We were eventually stuck
with what we came to realize was an unworkable stack+topology.

The email exchange
https://sudoroom.org/pipermail/mesh-dev/2014-October/000019.html could
help out with any additional confusion.

I still think that a heterogenous mesh with babel on top of batman-adv
could be an excellent combination of dynamic routing with layer 2 mesh
roaming, something like this diagram:
https://libre-mesh.org/projects/libre-mesh/wiki/Network_Architecture?version=13

The libre-mesh folks mentioned that they've been experimenting with
that sort of architecture, but I don't think we're really going to
need it any time soon (and we weren't exactly in love with bmx6, but
that's probably outside of the scope here).

Hope that was reasonably helpful.


Max

-- 
http://mitar.tnode.com/
https://twitter.com/mitar_m
