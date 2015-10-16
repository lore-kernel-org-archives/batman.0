Return-Path: <salvarez@itelsis.com>
From: =?iso-8859-1?Q?Santiago_=C1lvarez_=C1lvarez?= <salvarez@itelsis.com>
Date: Fri, 16 Oct 2015 12:26:48 +0200
Message-ID: <001f01d107fd$2a0f9680$7e2ec380$@itelsis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Language: es
Subject: [B.A.T.M.A.N.] video streaming over batman-adv
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

Hi everybody,
I=92m an engineer working in a R&D Project using batman-adv protocol. =
We=92re
trying to develop a mesh network using linux devices with the objective =
of
transmitting video in streaming. Video is being generated with gstreamer
using UDP.
The application works relatively fine with 2 devices, but efficiency =
heavily
decreases when introducing a new node in the mesh network (information =
need
two jumps to arrive to destination). Introducing more jumps in the =
network
is exponentially worst. We have been expecting a better behavior of this
protocol, since level 2 routing should be transparent  (just increasing
delay when increasing the number of nodes).
We are using batman version 2015.0,  over wifi interfaces, and our =
streaming
applications is working only point-to-point (not multicast or =
broadcast).
The nodes in between server and client are working just as wireless
repeaters using batman-adv.
We also discovered that worst case happens when changes in batman =
routing
tables are happening (sometimes, client is able to reach server in just =
one
jump, but with low quality, and chooses that option instead of jumping
through the repeater node, with better quality). When that happens, =
we're
droping lots of packets.
Any of you haver tried batman-adv for video streaming? Which was the =
maximum
number of jumps between batman nodes that you can manage maintaining a =
good
video quality?=20
Can you recommend any specific configuration for improving batman =
behavior?

