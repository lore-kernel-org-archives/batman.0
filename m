Return-Path: <salvarez@itelsis.com>
From: =?UTF-8?Q?Santiago_=C3=81lvarez_=C3=81lvarez?= <salvarez@itelsis.com>
References: <001f01d107fd$2a0f9680$7e2ec380$@itelsis.com>
 <20151016132134.GF25714@odroid>
In-Reply-To: <20151016132134.GF25714@odroid>
Date: Mon, 19 Oct 2015 11:36:40 +0200
Message-ID: <001a01d10a51$a8c5a950$fa50fbf0$@itelsis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: es
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@lists.open-mesh.org>

Thank you Simon and Linus for your answer,
I'll try right now your suggestions and see if I get an improvement.
In the meantime, for your information, I can tell you that I'm using =
2.4GHz wifi Edimax 7811UN and TP-Link TL-WN722N.  They are 802.11n =
capable, but I'm not using them like that. I'll also share the gstreamer =
instructions that I'm using for video streaming:

gst-launch-1.0 v4l2src device=3D"/dev/video0" ! =
'video/x-raw,width=3D1280,height=3D720' !  x264enc bitrate=3D1024 =
key-int-max=3D15 tune=3Dzerolatency speed-preset=3Dsuperfast ! mpegtsmux =
! queue ! udpsink host=3D"192.168.2.99" port=3D8500

gst-launch-1.0 udpsrc port=3D8500 ! tsdemux ! decodebin ! queue ! =
autovideosink



-----Mensaje original-----
De: B.A.T.M.A.N [mailto:b.a.t.m.a.n-bounces@lists.open-mesh.org] En =
nombre de Linus L=C3=BCssing
Enviado el: viernes, 16 de octubre de 2015 15:22
Para: The list for a Better Approach To Mobile Ad-hoc Networking =
<b.a.t.m.a.n@lists.open-mesh.org>
Asunto: Re: [B.A.T.M.A.N.] video streaming over batman-adv

Hi Santiago,

Simon already mentioned a few good points, for instance increasing the =
multicast rate to improve the route selection and that you'd need to =
take the half-duplex nature into account.

Another thing to consider is, that most video codecs are very =
susceptible to packet loss. Unfortunately, especially the 2.4GHz "crap =
band" with various devices with no CSMA-CA ("listen-before-talk") can =
have quite a lot of that, depending on your environment. Even with the =
retry-mechanism for unicast, I wouldn't be surprised if you had 1-3% =
packet loss. That of course multiplies per hop.

Even if the retry-mechanism could cope with your medium, then retries =
will introduce a good deal of jitter. Unfortunately, RTP doesn't like =
jitter and your receiver might consider packets too late and might drop =
them on the application layer.


You should probably have a look what is creating your "decrease in =
efficency". Whether your medium is saturated (I can recommend H.O.R.S.T. =
(1) for that) or something else causing packet loss. Or whether actually =
all packets arrive and it's just jitter (check with Wireshark for =
instance).

If it isn't saturation but just general packet loss or jitter then you =
can easily send UDP packets redundantly with gstreamer (e.g. with the =
"tee" element). You should be able to tweak the buffering time and =
jitter resistance with gstreamer, too.

Also, try simply configuring static routes over your adhoc interfaces =
and compare. If you have the same issues there then you know it isn't =
batman-adv's fault :).

Regards, Linus

(1): http://br1.einfach.org/tech/horst/


PS: Would you mind sharing your gstreamer pipeline? Just to check some =
basic things like having an "gstrtpjitterbuffer" element for instance. =
Also, are you using 2.4 or 5GHz wifi? Are these 802.11n devices?

PPS: "We have been expecting a better behavior of this protocol, since =
level 2 routing should be transparent (just increasing delay when =
increasing the number of nodes)."
=3D> I fail to see why for this three node setup it should matter =
whether it's a layer 2 or 3 routing protocol - a layer 3 routing =
protocol should be transparent for the application layer, too ;).
It's probably actually a layer 1 problem you are observing, which your =
application currently can't cope with :).


On Fri, Oct 16, 2015 at 12:26:48PM +0200, Santiago =C3=81lvarez =
=C3=81lvarez wrote:
> Hi everybody,
> I=E2=80=99m an engineer working in a R&D Project using batman-adv =
protocol.=20
> We=E2=80=99re trying to develop a mesh network using linux devices =
with the=20
> objective of transmitting video in streaming. Video is being generated =

> with gstreamer using UDP.
> The application works relatively fine with 2 devices, but efficiency=20
> heavily decreases when introducing a new node in the mesh network=20
> (information need two jumps to arrive to destination). Introducing=20
> more jumps in the network is exponentially worst. We have been=20
> expecting a better behavior of this protocol, since level 2 routing=20
> should be transparent  (just increasing delay when increasing the =
number of nodes).
> We are using batman version 2015.0,  over wifi interfaces, and our=20
> streaming applications is working only point-to-point (not multicast =
or broadcast).
> The nodes in between server and client are working just as wireless=20
> repeaters using batman-adv.
> We also discovered that worst case happens when changes in batman=20
> routing tables are happening (sometimes, client is able to reach=20
> server in just one jump, but with low quality, and chooses that option =

> instead of jumping through the repeater node, with better quality).=20
> When that happens, we're droping lots of packets.
> Any of you haver tried batman-adv for video streaming? Which was the=20
> maximum number of jumps between batman nodes that you can manage=20
> maintaining a good video quality?
> Can you recommend any specific configuration for improving batman =
behavior?
>=20

