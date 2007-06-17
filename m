Message-ID: <46754155.5050506@poelzi.org>
Date: Sun, 17 Jun 2007 16:12:37 +0200
From: Daniel Poelzleithner <poelzi@poelzi.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Small feature request
References: <4672937F.3040208@poelzi.org>
	<200706171400.01329.lindner_marek@yahoo.de>
In-Reply-To: <200706171400.01329.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marek Lindner wrote:

> interesting idea but I don't get your big picture. Could you further explain 
> what you have in mind while considering the following:
> 
> Even with your algorithm, detecting route changes is quite difficult for 
> batman, simply because batman does not know the concept of routes through the 
> network. Batman just counts packets which arrived via one or the other 
> neighbor and does not care about how the packets arrived at its neighbors. 
> Which "route change" should be considered ? A route change after one / two / 
> three / ... hops ? A one hop routing change could be detected without your 
> algorithm. That is why I think you want to detect more.

every node xors the detect stamp before relaying. this way, if the route
is the same, the stamp is the same all the time. if anywhere on the
route, you can't detect where, changes, the stamp also changes. maybe
there will be routes that change very often, so batman will get a
constant flipping stamp. i don't want to change batman to know the
topology of the network, i love this simple yet genius approach much
better, because this is what network actually is, talking to your direct
neighbors :)
for the case of vegas tuning, this is another story, see below...

> If we make a 2 hop example: We have a batman running and (for the sake of 
> simplicity) one neighbor A. This neighbor has 3 neighbors of its own which 
> equally supply originator packets of our target, lets say 3 and we receive 9 
> packets via our neighbor A. What is our new route ?

i don't understand.
lets assume a topology like that:

   [A]
  /   \
[B]  [C]
   \ /
   [D]
    |
   [E]

lets say all links a equally good (very unlikly but anyway), so D is
receiving originator packets from A through B and C, but always relaying
only the first received. yes, this could break my idea. does batman
switch the route every time it receives a packet or only when it detects
that B sends less then C ?
to fix this problem, we could:
 - save the stamp received from the last originator packet from the
neighbor which is the neighbor we actually choose to route through.
 - every packet received from a different neighbor then the one we
actually use to route to, will get the stamp we saved XOR the own stamp

this would make the stamp not switch when the route is not switching, as
soon as batman decides to switch the route, the stamp will change on all
nodes behind D.

> On the other hand we begin to leave the new approach of a one hop horizon 
> towards OLSR based routing which makes routing assumptions based on outdated 
> data.

to make it clear, this stamp is not for routing decisions, it only
detects if a route has changed, nothing more, it won't change how batman
routes, it is just used to notify transport of changes.

> TCP Vegas algorithm to detect congestion is based on the round trip times of 
> the packets. It simply observes if the RTTs get bigger or smaller and derives 
> its window size from it. No information about a routing change is needed.

thats not right. it uses the so called BaseRTT as one parameter, which
is the smallest RTT received ever. The problem ist, that if the route
changes, the BaseRTT is most likly not valid anymore because the route
changed and the new one might have a higher or lower BaseRTT which
decreases performance.

i don't think vegas will perform very good in meshes, because we have
jitter like hell, and i think thats the reason tcp performes very bad in
generall, because all tcp implementations hate large jitter and a lot of
packet reordering.

> If you really plan to deploy TCP Vegas in your network you should make sure 
> that *all* your clients do the same. Otherwise the users of TCP Vegas will 
> experience a massive throughput loss because the commonly used TCP stack is 
> much less fair. More information on that matter can be found here: 
> http://www.isoc.org/inet2000/cdproceedings/2d/2d_2.htm

no, i don't plan to, because tcp is always senderside. the only thing
there could be done is installing proxys on the edges, but thats not
very good either. I'm currently trying another, very experimental
approach by writing a TCP-proxy (meshferry [1]). Currently it listens on
a tcp port to which you can connect, opens a UDP connection to another
proxy and this one translates this mesh optimized udp stream back to
TCP. If i can optimize the UDP protocol to perform better then TCP, the
next step would be to implement this as a tap device, so this could be
done totally transparent on the border of the mesh.

I'm thinking about something like that:

b.a.t.m.a.n notifies meshferry one specific events:
(b is batman, m is meshferry)
b- new host detected
 m- tests if the new host is speaking meshferry protocol
 m- if yes, notifies batman to route though the tap device
b- route has changed
 m- can optimize parameters again
m- detects to less memory for new connections, meshferry on the
otherside died,...
 b- notifies batman to not use tap device
 b- or sets firewall that new connections should be routed directly

...
this however would be long term and should be thought through very
carefully.

Because i think that detecting that a route has changed could help a lot
making long living or even short living connections to perform better. I
also think that BaseRTT is a useful parameter in general, just that it
shouldn't relay on it to much.



[1] https://dev.leipzig.freifunk.net/svn/meshferry/trunk

its currently broken due massive rewrite from the original source its
based on.


kindly regards
 daniel
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: GnuPT 2.7.2
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGdUFUy/mkIQp7AD0RAhdfAJ9iPbDX3pBvHVgycCrHr96Lufuf1QCdEyln
OEIzc2mMDfc7BipG2KllNeo=
=9i6L
-----END PGP SIGNATURE-----
