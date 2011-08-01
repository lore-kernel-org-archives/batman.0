Return-Path: <ctroncoso@redvoiss.net>
From: Camila Troncoso <ctroncoso@redvoiss.net>
MIME-Version: 1.0
Date: Mon, 1 Aug 2011 16:10:41 -0400
Message-ID: <9bf008cbb049b3d76dcb7899e48f949c@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] DNS Batmand
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hi,

I=B4m working for some time with a wireless mesh.  I have several devices
with a basic linux inside (Openwrt) and they are running Batmand protocol.
One of the mesh nodes acts as a gateway to internet, obtaining IP and DNS
trough pppoe. The other nodes act as clients and connect to internet
trough this gateway.

The only problem that I=92m facing , is that even when the gateway creates
the tunnel ( gate0) with the client node and gave it internet connectivity
, it doesn=92t modify the /etc/resolv.conf file, and the client node isn=92=
t
capable of resolving names (DNS).



I don=92t understand why the gateway node is not giving the client node all
the necessary information of the internet connection.  I suppose by
protocol , if the gateway makes a tunnel , gives IP and route to the
clients nodes, It also has to give them a way to resolve names (DNS).

Hope someone can help me in this matter, I spend a lot of time in this.

Regards,


Camila Troncoso |=A0Ingeniero de Desarrollo
VoissNet S.A. |ctroncoso@redvoiss.net
Santiago - Chile | +56 2 2408535
www.redvoiss.net
