From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] Tunnel problems...
Date: Thu, 18 Oct 2007 13:13:01 +0200
References: <000001c81164$7ec1c8d0$4100a8c0@meritechbrett>
In-Reply-To: <000001c81164$7ec1c8d0$4100a8c0@meritechbrett>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200710181313.02144.axel@open-mesh.net>
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hello,

On Donnerstag 18 Oktober 2007, Brett Maurer wrote:
> I'm having a problem with bat0. It seems to be disconnecting and I cannot
> find the cause. My configuration is as follows:
> Version:
> 0.3 beta rv731

Are you sure the tunnel interface is called bat0. Because in 0.3-beta-rv731 it 
should be called gate0. - but in batmand-exp  it is called bat0. 
> Scenario:
> A-----B-----GW-----PC
> A - is on 104.0.0.3 ath0 with -s 10.0.0.10
> B - is on 104.0.0.2 ath0 with -s 10.0.0.10
> GW - is on 104.0.0.1 ath0 and 10.0.0.1 eth0
>
> PC - is on 10.0.0.10
> I can see A routing through B to GW fine. The tunnel bat0 on A and B seems
> unstable though. I'm looking at VIS packets arriving at PC. It arrives for
> about 30 sec then stops for a while. It is not clear why the tunnel keeps
> disconnecting.

The current client-GW-tunnel implementation is observing the traffic from the 
client point of view.
The client suspects a GW as unresponsive (black-hole) if data is send through 
the tunnel from the client to the GW but no data is send the other way around 
(tunnelled from the GW to the client).

Then the client waits for a while and if still no data arrives through the 
tunnel, a timeout hits and automatically disconnects the client from the GW - 
hoping that other available GW are more responsive.
This can be observed using debug-leve-3 on the client side.

The problem is that the mechanism assumes a bidirectional communication 
between the mesh client node and a distant node behind the GW. Unfortunately, 
this is not the case with your scenario when sending vis packets to a 
visualization server.
In batmand-exp there is a --no-unresp-gw-check directive which disables this 
feature. For node A  try:
 batmand --no-unresp-gw-check -r 3 -s 10.0.0.10 ath0

ciao
/axel

>
>
>
> If anyone can offer some advice, I'd much appreciate it.


