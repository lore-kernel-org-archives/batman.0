From: Axel Neumann <axel@open-mesh.net>
Date: Mon, 1 Sep 2008 14:02:42 +0200
References: <7ifxp3v86m.fsf@lanthane.pps.jussieu.fr>
	<200808210742.53261.axel@open-mesh.net>
	<7id4juo258.fsf@lanthane.pps.jussieu.fr>
In-Reply-To: <7id4juo258.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200809011402.43114.axel@open-mesh.net>
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Re: [Babel-users] A few more comments on the BATMAN
	routing protocol
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>, olsr-users@lists.olsr.org, babel-users@lists.alioth.debian.org

Hi,

On Mittwoch 27 August 2008, you wrote:
> >> My claim that there exist topologies in which average-case convergence
> >> of BATMAN is exponential in the number of hops has been confirmed by
> >> two of the BATMAN developers.  I still believe this to be a very
> >> significant flaw of BATMAN.
> >
> > Packet loss increases also the count of OGMs that trigger a route switch
> > decreases.
>
> I realise that.  The trouble is that the time needed to reconverge is
> proportional to the product of the link qualities, and not to the sum
> of the link qualities, as is the case in Babel and in OLSR.
>
> > Now let's come to the worst case. Again two paths that are
> > non-overlapping. One is terrible, 99% loss. The other is perfect, no
> > loss.
>
> As I mentioned in my point 3, the packet loss, as measured by BATMAN,
> is not realistic in the presence of link-layer AQM.  As you know,
> IEEE 802.11 does perform link-layer AQM for unicast packets.
AQM =3D=3D Active Queueing Management ? Sorry, I did not know this. I know =
that=20
802.11 retransmits (usually up to 7 times) in case of absent ACKs and most =

implementation performs some non-standardized Ack-based rate control.=20

All mesh protocols I am aware of use broadcast-based link probing for=20
estimating the link quality. I agree that this is not very precise and also=
=20
does not indicate much about the achievable bandwidth. But the alternatives=
=20
are also difficult. Performing unicast measurements introduces lots of=20
overhead especially in areas of high node density and relying on estimated =

802.11 transmit rates requires interaction with the MAC layer and still doe=
s=20
not relieve from the need for casual unicast traffic between all neighborin=
g=20
nodes.=20
I am currently experiencing with unicast probes, hoping to find an acceptab=
le=20
mixture of selective unicast probing and reusing probetraffic for flooding =
of=20
topology information.=20

>
> A 10-hop route with each link having 20% loss will be measured by
> BATMAN as a route with 90% loss.  However, with 7-persistent per-hop
> AQM (the IEEE 802.11 default), such a route has an effective loss rate
> of roughly 10^-4, and is therefore quite usable by standard transport-lay=
er
> protocols such as TCP.  (In case this is not clear to you -- this is
> brilliantly exposed in the original ETX paper.)
>
> Hence, my claim that BATMAN converges in exponential time stands, even
> if you restrict yourself to routes usable by TCP.

And we have not denied your claim. But the evolution of BATMAN has continue=
d=20
after batmand-0.2 and what is described in the draft - so did the OLSR whic=
h=20
is used in todays Freifunk networks. For example, the BMX version by defaul=
t=20
sends each OGM twice (or more often if wanted, my first observations was th=
at=20
twice seems sufficient and more than twice does not pay off). Taken your=20
example of 10 hops with a packet loss of 20% and a resulting Path Error Rat=
e=20
of 90 %=20
transferred to the scenario of sending OGMs twice:=20
(Link-OGM-Error-Rate) LOER=3D(LPER)=B2=3D0.04	=3D>=20
(Path-OGM-Error-Rate) POER =3D 1-( (1-LOER)^hops ) =3D 0.34 =3D 34%

So statistically even after 10 hops 66 of 100 OGMs will be received.=20
Even after 20 hops more than 55 of 100 OGMs could be received.=20

But the generally cool thing is: The more weak hops exist between two nodes=
=20
(and therefore the less important a good estimation of the path quality=20
becomes) the less OGMs are eating up the available bandwidth and processing=
=20
resources.

To sum up: Yes, it is exponential. Its not a bug, its a feature. This is=20
wanted as long as sufficient OGMs remain to maintain usable routes.

>
> > All versions of Batman benefit from the fact that they don't produce
> > much protocol overhead (small amount of data that needs to be
> > communicated, OGM flooding is only flooded exclusively via the best
> > routing path to a destination).
>
> Given a network with n nodes and e edges, BATMAN sends O(n^2) packets
> per unit of time, Babel sends O(n^2) messages, and OLSR sends between
> O(e) and O(e.n) depending on the MPR redundancy.
>

I think the packets BATMAN sends per node (without packet loss) should be=20
O(n).
Even though, this calculation ignores the packet loss which has been=20
emphasized so much above. Without being an expert. If you want to express t=
he=20
theoretical effort of large BATMAN networks WITH PACKETLOSS with the=20
O-notation, I guess that it rather ends up in something like O(log n) per=20
node. Simply because the larger a network becomes, the greater the average =

distance between nodes in terms of hops becomes and therefore the greater t=
he=20
average end-to-end OGM loss. ( I think Roman Steiner also mentioned this=20
effect in his simulations which he has described here=20
http://open-mesh.net/Members/roman/report.pdf )

With kind of provoking example: Adding 500 nodes in the distance of 500 hop=
s=20
(with a Link OGM Error Rate of 4% and an originator interval of 1 second)=20
causes the nodes at the other side to send 21 OGMs more  per year.

ciao,
axel

