Return-Path: <j.zimmer@telegrid.com>
From: "Joseph Zimmer" <j.zimmer@telegrid.com>
Date: Thu, 7 May 2015 13:00:52 -0400
Message-ID: <841E254B092F4FC1839DD066D90CE802@telegridtech.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] FW: using Batman-adv
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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



Hello,
=A0
I am working with BATMAN-ADV and have successfully setup a mesh. In my
implementation of the mesh, the network requires BATMAN to operate in a
linear topology and ideally have node 1 hop to node 2 then through node =
3
and finally node 4.
=A0
=A0=A0=A0=A0=A0=A0=A0 =
Node1=85=85=85=85=85=85=85=85.Node2=85=85=85=85=85=85=85=85=85=85=85..Nod=
e3=85=85=85=85=85=85=85=85=85=85Node4
=A0
In this network hops are preferred rather than distant links with low =
RSSI
values(-70).=A0 The problem that I=92m seeing is that the protocol =
chooses
routes that have the least hops but have RSSI values at about -78 to -90
rather than routing through the closest node with RSSI values in the -50
range.
=A0
We adjusted the hop penalty to a low value (we used 1 and 0) and we did =
see
improvement with the hop selection but the throughput is very low due to =
an
RSSI of -64 or less.
=A0
Questions:
=A0
1)=A0=A0=A0=A0=A0=A0 Is there a way to adjust BATMAN using batctl to =
select routes based
on the RSSI value?
a.=A0=A0=A0=A0=A0=A0 That is, choose to hop through a node with an RSSI =
of -50 and never
select a node that has a lower RSSI
2)=A0=A0=A0=A0=A0=A0 Does the algorithm for route selection use RSSI in =
the calculation
and if so can we modify the algorithm to increase the importance of RSSI =
in
the selection?
3)=A0=A0=A0=A0=A0=A0 How do we gain access to the code to make these =
modifications?
a.=A0=A0=A0=A0=A0=A0 Can you give me a little guidance on how to modify =
BATMAN-adv to
suite my situation?
=A0
Your help is greatly appreciated.
=A0
Regards, =A0=A0=A0=A0
=A0
=A0
Joseph Zimmer
Telegrid Technology Inc.
19 Microlab Road
Livingston, NJ 07039
Email:=A0 j.zimmer@telegrid.com
Phone: 973.994.4440 X319
=A0

