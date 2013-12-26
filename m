Return-Path: <karticbhargavinline@gmail.com>
MIME-Version: 1.0
From: Kartic Bhargav <karticbhargavinline@gmail.com>
Date: Thu, 26 Dec 2013 16:46:59 +0530
Message-ID: <CAFkF_bJP+Ri1Q7ELxRkVkudvMUZMfC10WFmrCHceeHV0Rtd8TA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Using bat-adv for Wireless Video Streaming
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
To: "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>

Hello,

I am currently working on Wireless Video streaming over a mesh network
of Raspberry Pi nodes.

I have set up the bat-adv mesh network and am able to ping each node.
I am working on the Video forwarding from one node to another now and
am facing problems here as I am unsure as to how to proceed. I have a
Microsoft LifeCam Camera attached to one of my Nodes and have to hop
the captured video packets to the next series of nodes.

I'm relatively new to bat-adv and some of its advanced functions.
Since we are dealing with ipv6 connectivity here, the eth0 is down and
as expected am unable to connect to the existing ipv4 LAN Network at
my Lab. So I'm not able to use the conventional Video streaming / Port
listening & forwarding tools. (like Netcat etc.)

Is there any specific tool/way by which I can achieve my 'Video
Forwarding' objective via bat-adv commands like batctl etc.? How
exactly do you make use of the connectivity between nodes? Any such
applications that are supported to forward Video Packets?

Any leads/insights would be very much helpful.

Thanks a lot.
Kartic Bhargav
