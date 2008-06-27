Message-ID: <4864DD02.20209@csp.it>
Date: Fri, 27 Jun 2008 14:28:50 +0200
From: cipollone <cipollone@csp.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] BATMAN ADVANCED KERNEL LAND LOOP
Reply-To: cipollone@csp.it,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: b.a.t.m.a.n@open-mesh.net, simon.wunderlich@s2003.tu-chemnitz.de

Hi,

I'm testing BATMAN Advanced Kernel Land and I've found a problem.
I'm using BATMAN-adv over OpenWRT.

My test is:

3 virtual machine
2 Ethernet card for each virtual machine
3 Vlan

So we have a loop and I hoped that BATMAN solve this but...

What's happen is that each virtual machine can send message to itself 
using the 2 interface.
It passes because  the BATMAN  message are re-broadcasted and at a 
certain point 1 of machine start to communicate only with itself, 
disappearing from the network.

I need helppp!!!

Paolo Cipollone

