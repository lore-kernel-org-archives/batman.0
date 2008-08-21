From: Axel Neumann <axel@open-mesh.net>
Date: Thu, 21 Aug 2008 07:42:53 +0200
References: <7ifxp3v86m.fsf@lanthane.pps.jussieu.fr>
In-Reply-To: <7ifxp3v86m.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808210742.53261.axel@open-mesh.net>
Subject: [B.A.T.M.A.N.] Re: A few more comments on the BATMAN routing
	protocol
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

Juliusz,
now after being the first white-listed person on the batman-mailing list you 
are also the first person who receives an authorative reply from the 
batman-developer team (sorry for the coordination delay). However, we would 
like to mention that batman is a community project which can not afford a 
president in charge for authorative replies. Therefore, you have received a 
number of profound replies authored by a number of individuals but core 
batman developer. These mails have addressed all your points and either 
corrected false assumptions or indicated how newer batman versions handle the 
addressed problems. For example see:

https://list.open-mesh.net/pipermail/b.a.t.m.a.n/2008-August/000877.html
for disprove of point 2

https://list.open-mesh.net/pipermail/b.a.t.m.a.n/2008-August/000878.html
for clarifications on point 1, disprove of point 2, links to solutions for 
point 3, 4 and real to life experience 

https://list.open-mesh.net/pipermail/b.a.t.m.a.n/2008-August/000880.html
for link to performance studies of protocol-traffic overhead, etc (point 4)


By the way, the mythical protocols can be downloaded, tried and further 
examined here (batman-0.3):
http://downloads.open-mesh.net/batman/stable/sources/batman-0.3.tar.gz
and (BMX) here:
http://downloads.open-mesh.net/batman/development/sources/batmand-exp_0.3-alpha-current_sources.tgz


Nevertheless we are still eager to continue the discussion:
> 1. Exponential convergence
> **************************
>
> My claim that there exist topologies in which average-case convergence
> of BATMAN is exponential in the number of hops has been confirmed by
> two of the BATMAN developers.  I still believe this to be a very
> significant flaw of BATMAN.
>  
Packet loss increases also the count of OGMs that trigger a route switch 
decreases.

The convergence time depends to a great degree on the difference between 
the OGM count between the best and the second best route, if the routes 
are absolutely non-overlapping and the best route expires. Of course, if 
we have lots of broadcast packet loss from our destination we don't get 
updates often, but every protocol using broadcasts for messages suffers 
(or benefits in terms of overhead!) from this.

Assume a node has two almost equally good paths towards a destination 
that are non-overlapping. One has 90% broadcast packet loss, and the 
other one 91%. Now the route with 90% packet loss breaks. Given a 
sliding window size of 100 OGMs the route will likely switch as soon as 
1-2 OGMs arrive via the 91% loss path. So it mostly takes a single 
received OGM to switch, in the worst case two. Given the lossy route, 
this will take about 11 OGM intervals in total, on average.

Now let's come to the worst case. Again two paths that are 
non-overlapping. One is terrible, 99% loss. The other is perfect, no 
loss. If the perfect route breaks, it will take one or two full sliding 
window sizes on average to switch. We can now wonder how important it is 
to switch quickly from a route with no packet loss to a route with 99% 
packet loss - more so because we can't know that it is not just a burst 
of interference preventing new OGMs coming in via the best path. Even in 
this case the convergence time is likely to be as good or as bad as any 
other protocol, simply because other protocols would have to update 
local topology information (link metrics) as well and deal with the fact 
that their topology updates are communicated very infrequently as well.

All versions of Batman benefit from the fact that they don't produce 
much protocol overhead (small amount of data that needs to be 
communicated, OGM flooding is only flooded exclusively via the best 
routing path to a destination). Compared to other proactive protocols, 
protocol messages can be send more frequently to improve convergence 
speed. Batman-Exp is running in a 150 node mesh in Leipzig with an OGM 
interval of 1 second.

> 2. Lack of loop avoidance
> *************************
>   
The idea behind the design of Batman was primarily to invent something 
which doesn't loop. Elektra didn't see the protocol looping when testing 
it in the Meraka grid. (Sending ICMP requests every 0.05 seconds for 
hours on the weakest and longest route possible, while multiple traffic 
streams were colliding in the center of the grid.)  So we don't see a 
lack of a loop avoidance mechanism. If you can think of situations where 
B.A.T.M.A.N. loops let us know.


> 4. Lack of aggregation
> **********************
>
> This is apparently fixed in the next version of the protocol.  I am
> eagerly looking forward to a complete description of the ``mark 4''
> version of the BATMAN protocol.
>   
It is implemented in 0.3 and Exp.
>
> 5. Jitter is not compulsory
> ***************************
>
> This was confirmed.  It is still unclear to me whether the BATMAN
> implementation does apply jitter.
>
>   
The implementation of batmand-0.2, 0.3 and EXP do. But if the CTS/RTS 
mechanism of 802.11 would actually work, it wouldn't be necessary to 
have it in the protocol. 

The B.A.T.M.A.N. team



On Sonntag 17 August 2008, Juliusz Chroboczek wrote:
> Hello to all,
>
> As some of you may remember, I made a few comments about the BATMAN
> routing protocol, as described in the draft of 7 April 2008 (the
> so-called ``mark 3'' version).  These comments can be found on
>
>   http://mid.gmane.org/7itzdzzero.fsf@lanthane.pps.jussieu.fr
>
> I have received a few replies, some of which were public but many of
> which were private.  Unfortunately, no one of these replies appears to
> be an authoritative reply of the BATMAN developers, so there is no
> easy-to-quote document I can reply to.
>
> Before I engage in a point-by-point reply, I'd like to mention that
> there appears to be a ``mark 4'' protocol and a ``BMX'' protocol in
> development, which apparently solve some of the issues I mentioned.
> This is good to hear, and I'd like to see a specification of these
> mythical protocols.
>
>
> 1. Exponential convergence
> **************************
>
> My claim that there exist topologies in which average-case convergence
> of BATMAN is exponential in the number of hops has been confirmed by
> two of the BATMAN developers.  I still believe this to be a very
> significant flaw of BATMAN.
>
> Elektra claimed that this is the desired ``fish-eye'' behaviour.
> I disagree with that -- exponential convergence is exponential
> convergence, whatever name you give to it.
>
> Axel Neumann spoke about TCP inefficiencies in the presence of packet
> loss.  I do not understand how that relates to the issue at hand.
>
> I'd like to remind everyone that all of OLSR, AODV and Babel exhibit
> linear-time convergence in all cases.
>
>
> 2. Lack of loop avoidance
> *************************
>
> A few of my correspondents have pointed out that BATMAN does in fact
> have a loop avoidance mechanism.  I therefore retract my claim that
> BATMAN causes persistent routing loops.
>
> Unfortunately, none of the mails I received described the loop
> avoidance mechanism, and the few hints that were given do not appear
> to correspond to anything that's described in the draft.  Hence, I am
> unable to evaluate BATMAN's loop avoidance mechanism, and in
> particular I cannot determine whether it causes starvation or leads to
> sub-optimal routing.
>
> I am looking forward to a detailed description of BATMAN's loop
> avoidance mechanism.
>
>
> 3. Unrealistic metric
> *********************
>
> This was confirmed by a few people, and is apparently worked around in
> the next version of the protocol.  I am eagerly looking forward to
> a complete description of the ``mark 4'' version of the BATMAN
> protocol.
>
>
> 4. Lack of aggregation
> **********************
>
> This is apparently fixed in the next version of the protocol.  I am
> eagerly looking forward to a complete description of the ``mark 4''
> version of the BATMAN protocol.
>
>
> 5. Jitter is not compulsory
> ***************************
>
> This was confirmed.  It is still unclear to me whether the BATMAN
> implementation does apply jitter.
>
>
>                                         Juliusz


