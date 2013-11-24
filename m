Return-Path: <tjhowse@gmail.com>
MIME-Version: 1.0
From: tjhowse <tjhowse@gmail.com>
Date: Mon, 25 Nov 2013 09:36:42 +1000
Message-ID: <CAAxzKbSBjtJ2HGr0AUqQsysDjrrvuCtS6jb1tKbUmpk-B1CeMw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Loss of connection to remote nodes,
	from clients only.
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

In my test system I have 11 dual-channel nodes. The 5GHz link is used
for interconnect between the nodes and the 2.4GHz link is for clients.
One of the nodes is distant. My laptop is connected to a common-SSID
AP link from one of the local nodes. I can always ping the distant
node from one of the local nodes, but the link from my laptop is less
reliable. I can have an SSH session open to the distant node and a
local node, pinging the distant node from both the local node and my
laptop. At no particular point the distant node will stop pinging from
my laptop and its SSH session will drop, while the ping continues just
fine from the local node.

The connection can restore equally mysteriously.

Can anyone explain this behavior? No manual network configuration
changes are being made at the point at which the connection drops or
is restored, though I suppose my laptop could be hopping between one
of the local APs. I am pinging an IP attached to the bridge joining
bat0, the copper node LAN and the 2.4GHz client LAN.
