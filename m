Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 16 Oct 2015 15:21:34 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20151016132134.GF25714@odroid>
References: <001f01d107fd$2a0f9680$7e2ec380$@itelsis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <001f01d107fd$2a0f9680$7e2ec380$@itelsis.com>
Subject: Re: [B.A.T.M.A.N.] video streaming over batman-adv
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

Hi Santiago,

Simon already mentioned a few good points, for instance increasing
the multicast rate to improve the route selection and that you'd
need to take the half-duplex nature into account.

Another thing to consider is, that most video codecs are
very susceptible to packet loss. Unfortunately, especially the
2.4GHz "crap band" with various devices with no
CSMA-CA ("listen-before-talk") can have quite a lot of that, depending
on your environment. Even with the retry-mechanism for unicast, I
wouldn't be surprised if you had 1-3% packet loss. That of course
multiplies per hop.

Even if the retry-mechanism could cope with your medium, then
retries will introduce a good deal of jitter. Unfortunately, RTP
doesn't like jitter and your receiver might consider packets too
late and might drop them on the application layer.


You should probably have a look what is creating your "decrease in
efficency". Whether your medium is saturated (I can recommend
H.O.R.S.T. (1) for that) or something else causing packet loss. Or
whether actually all packets arrive and it's just jitter (check
with Wireshark for instance).

If it isn't saturation but just general packet loss or jitter
then you can easily send UDP packets redundantly with gstreamer
(e.g. with the "tee" element). You should be able to tweak the
buffering time and jitter resistance with gstreamer, too.

Also, try simply configuring static routes over your adhoc
interfaces and compare. If you have the same issues there then you
know it isn't batman-adv's fault :).

Regards, Linus

(1): http://br1.einfach.org/tech/horst/


PS: Would you mind sharing your gstreamer pipeline? Just to check
some basic things like having an "gstrtpjitterbuffer" element for
instance. Also, are you using 2.4 or 5GHz wifi? Are these 802.11n
devices?

PPS: "We have been expecting a better behavior of this protocol,
since level 2 routing should be transparent (just increasing delay
when increasing the number of nodes)."
=> I fail to see why for this three node setup it should matter
whether it's a layer 2 or 3 routing protocol - a layer 3 routing
protocol should be transparent for the application layer, too ;).
It's probably actually a layer 1 problem you are observing, which
your application currently can't cope with :).


On Fri, Oct 16, 2015 at 12:26:48PM +0200, Santiago Álvarez Álvarez wrote:
> Hi everybody,
> Im an engineer working in a R&D Project using batman-adv protocol. Were
> trying to develop a mesh network using linux devices with the objective of
> transmitting video in streaming. Video is being generated with gstreamer
> using UDP.
> The application works relatively fine with 2 devices, but efficiency heavily
> decreases when introducing a new node in the mesh network (information need
> two jumps to arrive to destination). Introducing more jumps in the network
> is exponentially worst. We have been expecting a better behavior of this
> protocol, since level 2 routing should be transparent  (just increasing
> delay when increasing the number of nodes).
> We are using batman version 2015.0,  over wifi interfaces, and our streaming
> applications is working only point-to-point (not multicast or broadcast).
> The nodes in between server and client are working just as wireless
> repeaters using batman-adv.
> We also discovered that worst case happens when changes in batman routing
> tables are happening (sometimes, client is able to reach server in just one
> jump, but with low quality, and chooses that option instead of jumping
> through the repeater node, with better quality). When that happens, we're
> droping lots of packets.
> Any of you haver tried batman-adv for video streaming? Which was the maximum
> number of jumps between batman nodes that you can manage maintaining a good
> video quality? 
> Can you recommend any specific configuration for improving batman behavior?
> 
