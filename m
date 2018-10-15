Return-Path: <Jake.Harris@zf.com>
From: <Jake.Harris@zf.com>
Date: Mon, 15 Oct 2018 14:20:32 +0000
Message-ID: <B99A1AB9A294834C8DF94185A5E9D1810163770B9A@NRTV96002.america.zf-world.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Blacklisting specific nodes for traffic routing
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

I'm working with a group of about 50 nodes, 40 of which are physically stat=
ionary and 10 are mobile. The area is about three football fields with all =
the nodes evenly distributed while the 10 move around throughout the whole =
area (specifically there is one on each machine in the factory and one on e=
ach fork truck) with all of the fork truck nodes powered off the network is=
 rock solid, but when they are powered up the network becomes flaky with di=
fferent machine nodes loosing connection.

My assumption is the machines notice a fork truck nearby and route their tr=
affic through it as would make sense from their algorithm, but when the hil=
o goes out of range they seem to not notice and packets sent to the out of =
range nodes are lost.

I looked all over the documentation and haven't found a way to specify whic=
h nodes to not allow routes to be built through.

The obvious solution is to have the fork trucks connect to the network as c=
lients, but as I'm using raspberry pis (3 b+ specifically) they only have o=
ne wireless adapter, and adding a second adapter to each machine is financi=
ally infeasible. I was unable to simply connect to the network and send mes=
sages, understandably since the batman system uses specific packets to comm=
unicate.

The two solutions I can think of is to find a way to blacklist the mobile n=
odes to prevent them becoming hops in the network, or manually create the c=
ommunication packets on the mobile nodes to send and receive messages while=
 ignoring any route creation messages to likewise prevent them becoming hop=
s.

Is there an official way of doing either of these?

Thanks, Jake
