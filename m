MIME-Version: 1.0
In-Reply-To: <200905060006.19114.lindner_marek@yahoo.de>
References: <bad82a80905050708x1f0a75f0j27e78d72c81201bc@mail.gmail.com>
	<200905060006.19114.lindner_marek@yahoo.de>
Date: Tue, 5 May 2009 14:11:57 -0400
Message-ID: <bad82a80905051111t8acb76aoedb7d57c3d42141e@mail.gmail.com>
From: Arc Riley <arcriley@gmail.com>
Content-Type: multipart/alternative; boundary=00163628513ce3b2fc04692e3623
Subject: Re: [B.A.T.M.A.N.] batman-adv use in Manchester NH
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

--00163628513ce3b2fc04692e3623
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

> Cool ! May I ask who "we" is and how you would describe the current status
> ?


We're a new cooperative, the status is primarily planning with a few nodes
on the mesh and test builds.  We're hopefully going to merge the previous
effort from DynDNS to build a layer 3 mesh using Meraki Minis into one
network.

Our goal is just layer 2, allowing any member to provide layer 3 services
(free or commercial) over the mesh.


If you want to assemble a view of the whole topology the built-in vis server
> might be what you are looking for. I think the 24C3 video that you can find
> on
> our website describes how it works.


I haven't found any such video on the website.  Is the vis server setup for
batman-adv or just the layer 3 batman?  Is the protocol used for nodes to
announce their status documented?

We're building a desktop/mobile app using OpenStreetMap data and Mapnik, we
don't want to require Internet access to view available nodes from any
user's connection to the mesh so that it can be used to view and diagnose
the network in any situation.  If that software could listen to the node
status announcements ("I have X quality link with node A, Y quality link
with node B, Z quality link with node C"), along with nodes announcing other
properties including long/lat, wifi protocol and signal, etc, this should be
very easy to show colored links indicating their quality.

Since we need local link status from nodes, and not the compiled quality to
route to any node, listening to OGM frames is not enough.


Actually, this gateway question puzzles us as well. We did not find a very
> good
> solution for this problem yet. Batman-adv knows the best route towards the
> gateway - no problem here. But how can we propate that upwards ? Setting a
> route (which would be layer 3) ? We could even create an API that allows
> other
> processes to retrieve the best gateway but we "just" have a mac address no
> IP
> address.


How about running this as a custom DHCP server which uses the above
mentioned data to determine the "best" gateway on that network and return
the relevant information (IP, netmask, gateway IP) to each client with a
timeout sufficient for dealing with mobile users in a reasonable amount of
time.

This would be a fun project to work on.


On the other hand Simon is working on "short distance" bonding (which
> simplifies the task a lot). So far we have no working code.


Bonding as in when two nodes have multiple direct connections to each other,
dividing frames accordingly rather than continually switching all traffic to
the highest quality link.

This would be very useful for multi-radio routers operating multiple links
on different channels (or even 802.11G vs 802.11A) between the same set of
nodes.  Standard ethernet bonding is not preferable since you'd want the
mesh protocol to use lower TQ links (ie, channel 6 gets periodic high
interferance) less than higher TQ links (ie, 802.11A often has little
interferance).

Also, it would be interesting to see frame duplication for redundancy (and
thus lower packet loss) over multiple links, removing duplicates on the
other side of each link, though that's obviously more challenging for
duplicate removal.  Could have a floating window on each side for frame CRCs
or even full frame headers to detect dups.



On Tue, May 5, 2009 at 1:26 PM, Dennis Bartsch
<dennis_bartsch@hotmail.com>wrote:

> What for does one want an 8-port gigabit mesh-switch?
> meshing with batman-adv is a totally decentral thing.
>

An 8-port gigabit switch is an extreme case, a 3-port gigabit fiber + 5 port
100m copper switch would be more reasonable.

I'm refering to fiber switch connecting a small group of open-mesh routers
with redundant fiber and wifi connections on either side, a small piece of a
mesh spanning potentially thousands of nodes.  Obviously at this size we'd
have to start making changes to the batman-adv settings to avoid having the
network flooded with OGMs.

--00163628513ce3b2fc04692e3623
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"b=
order-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; paddin=
g-left: 1ex;">Cool ! May I ask who &quot;we&quot; is and how you would desc=
ribe the current status ?</blockquote>
<div><br>We&#39;re a new cooperative, the status is primarily planning with=
 a few nodes on the mesh and test builds.=C2=A0 We&#39;re hopefully going t=
o merge the previous effort from DynDNS to build a layer 3 mesh using Merak=
i Minis into one network.<br>
<br>Our goal is just layer 2, allowing any member to provide layer 3 servic=
es (free or commercial) over the mesh.<br><br><br></div><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
If you want to assemble a view of the whole topology the built-in vis serve=
r<br>
might be what you are looking for. I think the 24C3 video that you can find=
 on<br>
our website describes how it works.</blockquote><div><br>I haven&#39;t foun=
d any such video on the website.=C2=A0 Is the vis server setup for batman-a=
dv or just the layer 3 batman?=C2=A0 Is the protocol used for nodes to anno=
unce their status documented?<br>
<br>We&#39;re building a desktop/mobile app using OpenStreetMap data and Ma=
pnik, we don&#39;t want to require Internet access to view available nodes =
from any user&#39;s connection to the mesh so that it can be used to view a=
nd diagnose the network in any situation.=C2=A0 If that software could list=
en to the node status announcements (&quot;I have X quality link with node =
A, Y quality link with node B, Z quality link with node C&quot;), along wit=
h nodes announcing other properties including long/lat, wifi protocol and s=
ignal, etc, this should be very easy to show colored links indicating their=
 quality.<br>
<br>Since we need local link status from nodes, and not the compiled qualit=
y to route to any node, listening to OGM frames is not enough.<br><br><br><=
/div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(=
204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Actually, this gateway question puzzles us as well. We did not find a very =
good<br>
solution for this problem yet. Batman-adv knows the best route towards the<=
br>
gateway - no problem here. But how can we propate that upwards ? Setting a<=
br>
route (which would be layer 3) ? We could even create an API that allows ot=
her<br>
processes to retrieve the best gateway but we &quot;just&quot; have a mac a=
ddress no IP<br>
address.</blockquote><div><br>How about running this as a custom DHCP serve=
r which uses the above mentioned data to determine the &quot;best&quot; gat=
eway on that network and return the relevant information (IP, netmask, gate=
way IP) to each client with a timeout sufficient for dealing with mobile us=
ers in a reasonable amount of time.<br>
<br>This would be a fun project to work on.<br><br><br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); mar=
gin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">On the other hand Simon is work=
ing on &quot;short distance&quot; bonding (which<br>

simplifies the task a lot). So far we have no working code.</blockquote><di=
v><br>Bonding as in when two nodes have multiple direct connections to each=
 other, dividing frames accordingly rather than continually switching all t=
raffic to the highest quality link.<br>
<br>This would be very useful for multi-radio routers operating multiple li=
nks on different channels (or even 802.11G vs 802.11A) between the same set=
 of nodes.=C2=A0 Standard ethernet bonding is not preferable since you&#39;=
d want the mesh protocol to use lower TQ links (ie, channel 6 gets periodic=
 high interferance) less than higher TQ links (ie, 802.11A often has little=
 interferance).<br>
<br>Also, it would be interesting to see frame duplication for redundancy (=
and thus lower packet loss) over multiple links, removing duplicates on the=
 other side of each link, though that&#39;s obviously more challenging for =
duplicate removal.=C2=A0 Could have a floating window on each side for fram=
e CRCs or even full frame headers to detect dups.<br>
<br><br><br>On Tue, May 5, 2009 at 1:26 PM, Dennis Bartsch <span dir=3D"ltr=
">&lt;<a href=3D"mailto:dennis_bartsch@hotmail.com">dennis_bartsch@hotmail.=
com</a>&gt;</span> wrote:<br>




<blockquote style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt=
 0pt 0pt 0.8ex; padding-left: 1ex;" class=3D"gmail_quote">What for does one=
 want an 8-port gigabit mesh-switch? <br>meshing with batman-adv is a total=
ly decentral thing.<br>
</blockquote></div></div><br>An 8-port gigabit switch is an extreme case, a=
 3-port gigabit fiber + 5 port 100m copper switch would be more reasonable.=
<br><br>I&#39;m refering to fiber switch connecting a small group of open-m=
esh routers with redundant fiber and wifi connections on either side, a sma=
ll piece of a mesh spanning potentially thousands of nodes.=C2=A0 Obviously=
 at this size we&#39;d have to start making changes to the batman-adv setti=
ngs to avoid having the network flooded with OGMs.<br>
<br><br>

--00163628513ce3b2fc04692e3623--
