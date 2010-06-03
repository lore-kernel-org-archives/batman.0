Return-Path: <vernondcole@gmail.com>
MIME-Version: 1.0
From: Vernon Cole <vernondcole@gmail.com>
Date: Thu, 3 Jun 2010 12:17:32 -0600
Message-ID: <AANLkTinAPbbwB4CYulAsvIUkueDK18-TkdgfD5uHwAcP@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] How to connect to the 102.x.x.x net from eth0?
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

I am new here and can't find this in the documentation...

=A0I have a Linux box connected to the ethernet port of a mesh router.
If I let it use dhcp, it connects to the internet just fine via
wireless link to one of=A0 my other two open-mesh routers, both of which
are connected to Internet gateways.
=A0=A0 I want to enable a splash screen on the 101.x.x.x network, so that
I can share it openly. If I do that, I must also "log in" my hardwired
box, which makes it not work for my needs.
=A0=A0 The 102.x.x.x network works just fine via wireless (I am using it
to type this message) but I cannot figure how how to connect to 102.x
using the hard line to eth0.
=A0I notice on the dashboard that there is a *future* switch to turn on
a "bridge" mode.=A0 That sounds like what I am trying to do.=A0 I want to
inter-tie two hardwire networks on 102.x while letting outsiders use
101.x as an isolated v-lan on the same mesh.
=A0=A0 How do I convince an open-mesh router to enable access to 102.x
from the ethernet port? I am not good enough at command line Linux
interface configuration and routing and iptables to figure this out on
my own. (Hard addressing and static routes would be fine.)
=A0--
Vernon Cole
