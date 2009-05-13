MIME-Version: 1.0
In-Reply-To: <90C733EE-D757-431F-85EA-765257488668@mac.com>
References: <1240609318-18133-1-git-send-email-sven.eckelmann@gmx.de>
	<200905131825.39007.lindner_marek@yahoo.de>
	<90C733EE-D757-431F-85EA-765257488668@mac.com>
Date: Wed, 13 May 2009 15:42:03 -0400
Message-ID: <bad82a80905131242u43bdb184g9b5fa6441900f040@mail.gmail.com>
From: Arc Riley <arcriley@gmail.com>
Content-Type: multipart/alternative; boundary=0016e64ec4aed7879d0469d06716
Subject: Re: [B.A.T.M.A.N.] Has anyone considered the addition of GPS in
	BATMAN?
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

--0016e64ec4aed7879d0469d06716
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Better yet - use the standard for doing this:

http://en.wikipedia.org/wiki/LLDP-MED

On Wed, May 13, 2009 at 3:33 PM, Andrew de Andrade <
andrew.de.andrade@mac.com> wrote:

> Hello all, I'm new to the BATMAN project and have only been following it a
> short while, but I was curious if any thought had been given to having
> B.A.T.M.A.N. use GPS data to aid in calculating best routes through a
> network.
>
> i.e. once a node joins the mesh network, it not only broadcasts its
> presence and who it is connected to, but also it's physical location,
> assuming it has a GPS dongle connected to it.
>
> The way I see it, only a few nodes in the network would need to be GPS
> capable to greatly increase the ability to calculate a route through the
> network.
>
> Using response time to its closest neighbors, a node theoretically would
> only need to be connected to three other nodes the are GPS capable to
> triangulate its location. Once this node has triangulated its location it
> could then broadcast it to the rest of the network, thereby aiding other
> nodes figure out where they are located.
>
> So long as each location-aware node is connected to at least 3 other nodes
> on average and assuming they are fairly evenly distributed, every node in
> the network with at least three links should be able to calculate it's
> location.
>
> This location awareness plus congestion (node health) data would increase
> the efficiency of calculating the network topology at each node, and
> calculating the most efficient route to route the data.
>
> Anyways, just an idea. As I said, I'm new here and will try to contribute
> where I can.
>
> Andrew
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n
>

--0016e64ec4aed7879d0469d06716
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Better yet - use the standard for doing this:<br><br><a href=3D"http://en.w=
ikipedia.org/wiki/LLDP-MED">http://en.wikipedia.org/wiki/LLDP-MED</a><br><b=
r><div class=3D"gmail_quote">On Wed, May 13, 2009 at 3:33 PM, Andrew de And=
rade <span dir=3D"ltr">&lt;<a href=3D"mailto:andrew.de.andrade@mac.com">and=
rew.de.andrade@mac.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hello all, I&#39;=
m new to the BATMAN project and have only been following it a short while, =
but I was curious if any thought had been given to having B.A.T.M.A.N. use =
GPS data to aid in calculating best routes through a network.<br>

<br>
i.e. once a node joins the mesh network, it not only broadcasts its presenc=
e and who it is connected to, but also it&#39;s physical location, assuming=
 it has a GPS dongle connected to it.<br>
<br>
The way I see it, only a few nodes in the network would need to be GPS capa=
ble to greatly increase the ability to calculate a route through the networ=
k.<br>
<br>
Using response time to its closest neighbors, a node theoretically would on=
ly need to be connected to three other nodes the are GPS capable to triangu=
late its location. Once this node has triangulated its location it could th=
en broadcast it to the rest of the network, thereby aiding other nodes figu=
re out where they are located.<br>

<br>
So long as each location-aware node is connected to at least 3 other nodes =
on average and assuming they are fairly evenly distributed, every node in t=
he network with at least three links should be able to calculate it&#39;s l=
ocation.<br>

<br>
This location awareness plus congestion (node health) data would increase t=
he efficiency of calculating the network topology at each node, and calcula=
ting the most efficient route to route the data.<br>
<br>
Anyways, just an idea. As I said, I&#39;m new here and will try to contribu=
te where I can.<br>
<br>
Andrew<br>
<br>
_______________________________________________<br>
B.A.T.M.A.N mailing list<br>
<a href=3D"mailto:B.A.T.M.A.N@open-mesh.net" target=3D"_blank">B.A.T.M.A.N@=
open-mesh.net</a><br>
<a href=3D"https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n" target=3D"_=
blank">https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n</a><br>
</blockquote></div><br>

--0016e64ec4aed7879d0469d06716--
