Return-Path: <andrew.lunn@ascom.ch>
Date: Tue, 23 Jun 2009 17:06:02 +0200
From: Andrew Lunn <andrew.lunn@ascom.ch>
Message-ID: <20090623150602.GM19149@ma.tech.ascom.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] originator tq_avg oscilations
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: B.A.T.M.A.N@lists.open-mesh.net

Hi Folks

I've been playing with B.A.T.M.A.N advanced for a few weeks now. 

One of the scenarios where we might want to use it is nomadic
vehicles. Each vehicle has a wifi radio which is used to build a mesh
between the vehicles when the vehicles are parked together at a
location. I said the vehicles are nomadic. By that i mean they tend to
stay in one place for a while, and then move on. They can move
individually, or in groups. For the moment we are not interested in
meshing while on the move. 

I've run into a "problem" when one vehicle/node moves away from the
rest of the vehicles/nodes. It is taking a long time for the mesh to
realize the node has gone and rebuild the mesh. With a 500ms
orig_interval in our little test network, pings get lost for an
average of 26 seconds. The variation is great, sometimes it reroutes
in 10 seconds, sometimes in 50 seconds. 

So i want to improve this. The first thing i did was make some plots
of the tq_avg value, as shown in /proc/net/batman-adv/originators. I
look at one particular originator and plot the different tq_avg values
for the list of neighbors. Attaches is a png image showing this.

I was surprised to see that its unstable and oscillating. The
different tq_avg values mostly oscillate together, as shown in the
figure, but i've also seen cases when they oscillate 180 degrees out
of phase. In that case, the routing flips on the cross overs.

Is this normal? Is it expected behavior?

Has anybody worked on making re-routing around disappears nodes
faster?

        Thanks
                Andrew
