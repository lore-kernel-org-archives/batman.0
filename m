Return-Path: <Jonathan.Haws@sdl.usu.edu>
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
Date: Fri, 27 May 2016 22:25:46 +0000
Message-ID: <31c117a7ea164528a8d01a730c7dd9e8@Ek.usurf.usu.edu>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [B.A.T.M.A.N.] Non-batman Clients
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

I've followed the quick start guide, but apparently I'm missing =0A=
something when it comes to non-batman clients.=0A=
=0A=
I've set all this up using vagrant and VirtualBox.  The mesh seems to =0A=
work perfectly, however when I put in non-batman clients they cannot =0A=
communicate one with another.  I would expect that they would be able to =
=0A=
ping one another.=0A=
=0A=
I've given IP addresses to the bridge adapters on the 192.168.1.0/24 =0A=
subnet.  The clients I've given IP addresses on that same subnet =0A=
(192.168.1.121 and 192.168.1.142).  When I tried pinging, I don't get =0A=
anything back.  Sniffing packets in tcpdump shows that it is never =0A=
getting anything back, though I did get an ARP back once with the =0A=
correct MAC address, but still couldn't ping.  Never got an ARP back =0A=
again...=0A=
=0A=
I can ping from each client to the IP address of the bridge they are =0A=
connecting to, but cannot ping anything else on the network.=0A=
=0A=
Any thoughts?  Hopefully someone has seen this before and can point me =0A=
in the right direction!=0A=
=0A=
Also, is there a separate list for alfred, or should I use this list for =
=0A=
alfred questions?=0A=
=0A=
Thanks!=0A=
Jon=0A=
=0A=
=0A=
Here are the commands I used to setup:=0A=
=0A=
batctl if add eth0 (eth0 already up)=0A=
ip link add name br0 type bridge=0A=
ip link set dev eth1 master br0=0A=
ip link set dev bat0 master br0=0A=
ip link set up dev eth1=0A=
ip link set up dev bat0=0A=
ip addr replace dev br0 192.168.1.102/24 (and 104 on the other node)=0A=
=0A=
=0A=
Here is what batadv-vis shows for my setup (I changed the labels "TT" =0A=
for the two clients to "CLI<IP>").=0A=
=0A=
digraph {=0A=
	subgraph "cluster_08:00:27:2c:10:05" {=0A=
		"08:00:27:2c:10:05"=0A=
	}=0A=
	"08:00:27:2c:10:05" -> "08:00:27:6b:86:2e" [label=3D"1.016"]=0A=
	"08:00:27:2c:10:05" -> "0a:00:27:00:00:06" [label=3D"TT"]=0A=
	"08:00:27:2c:10:05" -> "1e:8d:d3:23:ab:d4" [label=3D"TT"]=0A=
	"08:00:27:2c:10:05" -> "08:00:27:b1:38:03" [label=3D"CLI142"]=0A=
	"08:00:27:2c:10:05" -> "1e:8d:d3:23:ab:d4" [label=3D"TT"]=0A=
	"08:00:27:2c:10:05" -> "08:00:27:1c:9b:14" [label=3D"TT"]=0A=
	subgraph "cluster_08:00:27:a2:8c:62" {=0A=
		"08:00:27:a2:8c:62"=0A=
	}=0A=
	"08:00:27:a2:8c:62" -> "08:00:27:83:dd:41" [label=3D"1.000"]=0A=
	"08:00:27:a2:8c:62" -> "08:00:27:38:31:55" [label=3D"1.000"]=0A=
	"08:00:27:a2:8c:62" -> "08:00:27:f6:78:1a" [label=3D"TT"]=0A=
	"08:00:27:a2:8c:62" -> "d6:f4:e6:bd:22:fb" [label=3D"TT"]=0A=
	"08:00:27:a2:8c:62" -> "d6:f4:e6:bd:22:fb" [label=3D"TT"]=0A=
	"08:00:27:a2:8c:62" -> "0a:00:27:00:00:05" [label=3D"TT"]=0A=
	subgraph "cluster_08:00:27:38:31:55" {=0A=
		"08:00:27:38:31:55"=0A=
	}=0A=
	"08:00:27:38:31:55" -> "08:00:27:83:dd:41" [label=3D"1.000"]=0A=
	"08:00:27:38:31:55" -> "08:00:27:a2:8c:62" [label=3D"1.000"]=0A=
	"08:00:27:38:31:55" -> "52:98:12:67:6b:06" [label=3D"TT"]=0A=
	"08:00:27:38:31:55" -> "0a:00:27:00:00:04" [label=3D"TT"]=0A=
	"08:00:27:38:31:55" -> "08:00:27:08:ee:90" [label=3D"CLI121"]=0A=
	"08:00:27:38:31:55" -> "52:98:12:67:6b:06" [label=3D"TT"]=0A=
	"08:00:27:38:31:55" -> "08:00:27:17:21:9d" [label=3D"TT"]=0A=
	subgraph "cluster_08:00:27:6b:86:2e" {=0A=
		"08:00:27:6b:86:2e"=0A=
		"08:00:27:83:dd:41" [peripheries=3D2]=0A=
	}=0A=
	"08:00:27:6b:86:2e" -> "08:00:27:2c:10:05" [label=3D"1.000"]=0A=
	"08:00:27:83:dd:41" -> "08:00:27:38:31:55" [label=3D"1.000"]=0A=
	"08:00:27:83:dd:41" -> "08:00:27:a2:8c:62" [label=3D"1.016"]=0A=
	"08:00:27:6b:86:2e" -> "a6:f4:5c:fa:06:cd" [label=3D"TT"]=0A=
	"08:00:27:6b:86:2e" -> "0a:00:27:00:00:03" [label=3D"TT"]=0A=
	"08:00:27:6b:86:2e" -> "08:00:27:9c:bb:a3" [label=3D"TT"]=0A=
	"08:00:27:6b:86:2e" -> "a6:f4:5c:fa:06:cd" [label=3D"TT"]=0A=
}=0A=
=0A=
