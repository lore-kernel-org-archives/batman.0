Content-Type: text/plain; charset="iso-8859-1"
Date: Tue, 15 Jul 2008 09:17:39 +0200
From: =?iso-8859-1?Q?=22Daniel_Ro=DFbach=22?= <daniel.rossi@gmx.de>
Message-ID: <20080715071739.175210@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] Multipath-Routing BATMAN-ADV
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
To: b.a.t.m.a.n@open-mesh.net

Hello,

I try to research some possibilities to implement multipath-routing (MPR) t=
o BATMAN Advanced. There are two different ways:=20
1. one-channel-MPR and 2. multi-channel-MPR.
To the first:=20
The idea is to use two paths through the mesh and to avoid crossed. I have =
build a simple model to show that it make sense. The model shows that it ca=
n take 67% of the time that needs BATMAN with a single path. I still implem=
ented it into userspace of revision 1060. The next step is to proof, that i=
t works...or that it doesn't work...!

To the second:
The idea is the use of multi paths with multi interfaces. Packets can be tr=
ansmitted over two different ways without any interference problems. At the=
 moment I'm analyzing the problems and the requirements for this.=20

The better way is of course the second one. The advantage of using one chan=
nel is that there is just one wireless interface needed.

Daniel
--=20
Psssst! Schon vom neuen GMX MultiMessenger geh=F6rt?
Der kann`s mit allen: http://www.gmx.net/de/go/multimessenger
