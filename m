From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Date: Sun, 17 Aug 2008 19:54:25 +0200
Message-ID: <7ifxp3v86m.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [B.A.T.M.A.N.] A few more comments on the BATMAN routing protocol
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
To: axel@open-mesh.net, elektra@open-mesh.net, lindner_marek@yahoo.de, siwu@hrz.tu-chemnitz.de
Cc: olsr-users@lists.olsr.org, Roman Steiner <roman@steinerweb.at>, b.a.t.m.a.n@open-mesh.net, babel-users@lists.alioth.debian.org

Hello to all,

As some of you may remember, I made a few comments about the BATMAN
routing protocol, as described in the draft of 7 April 2008 (the
so-called ``mark 3'' version).  These comments can be found on

  http://mid.gmane.org/7itzdzzero.fsf@lanthane.pps.jussieu.fr

I have received a few replies, some of which were public but many of
which were private.  Unfortunately, no one of these replies appears to
be an authoritative reply of the BATMAN developers, so there is no
easy-to-quote document I can reply to.

Before I engage in a point-by-point reply, I'd like to mention that
there appears to be a ``mark 4'' protocol and a ``BMX'' protocol in
development, which apparently solve some of the issues I mentioned.
This is good to hear, and I'd like to see a specification of these
mythical protocols.


1. Exponential convergence
**************************

My claim that there exist topologies in which average-case convergence
of BATMAN is exponential in the number of hops has been confirmed by
two of the BATMAN developers.  I still believe this to be a very
significant flaw of BATMAN.

Elektra claimed that this is the desired ``fish-eye'' behaviour.
I disagree with that -- exponential convergence is exponential
convergence, whatever name you give to it.

Axel Neumann spoke about TCP inefficiencies in the presence of packet
loss.  I do not understand how that relates to the issue at hand.

I'd like to remind everyone that all of OLSR, AODV and Babel exhibit
linear-time convergence in all cases.


2. Lack of loop avoidance
*************************

A few of my correspondents have pointed out that BATMAN does in fact
have a loop avoidance mechanism.  I therefore retract my claim that
BATMAN causes persistent routing loops.

Unfortunately, none of the mails I received described the loop
avoidance mechanism, and the few hints that were given do not appear
to correspond to anything that's described in the draft.  Hence, I am
unable to evaluate BATMAN's loop avoidance mechanism, and in
particular I cannot determine whether it causes starvation or leads to
sub-optimal routing.

I am looking forward to a detailed description of BATMAN's loop
avoidance mechanism.


3. Unrealistic metric
*********************

This was confirmed by a few people, and is apparently worked around in
the next version of the protocol.  I am eagerly looking forward to
a complete description of the ``mark 4'' version of the BATMAN
protocol.


4. Lack of aggregation
**********************

This is apparently fixed in the next version of the protocol.  I am
eagerly looking forward to a complete description of the ``mark 4''
version of the BATMAN protocol.


5. Jitter is not compulsory
***************************

This was confirmed.  It is still unclear to me whether the BATMAN
implementation does apply jitter.


                                        Juliusz
