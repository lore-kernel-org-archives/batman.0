Return-Path: <gtolon@inti.gob.ar>
Message-ID: <4F07148C.5070709@inti.gob.ar>
Date: Fri, 06 Jan 2012 12:34:36 -0300
From: gtolon@inti.gob.ar
MIME-Version: 1.0
References: <mailman.3.1325847602.24549.b.a.t.m.a.n@lists.open-mesh.org>
In-Reply-To: <mailman.3.1325847602.24549.b.a.t.m.a.n@lists.open-mesh.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] problem with mesh network
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

Hi
We are using batman-adv 2011.2.0 with Openwrt Backfire-rc6 on D-Link 
Dir-615 routers (2 Antennas, 1 single radio), each router with an adhoc 
interface managed by batman-adv for the mesh network and an Acces Point 
interface bridged with bat0 and ethernet to allow non batman-adv clients 
to connect. The problem is that sometimes all works fine, but sometimes 
we get very poor bitrates between routers, even using just two routers, 
testing with iperf. We don't know where the problem is, specially 
because it's a very erratic behavior. If any of you have used this 
configuration with openwrt and ath9k driver we'd really appreciate some 
help.

By the way, the D-Link Dir-615 is an n router, but for some reason 
related with hostapd the ap vif gets configured in g mode, and the adhoc 
in n mode, no matter what we set in the uci files. So in case the 
problem were related with the adhoc and ap virtual interface, we were 
thinking about the possibility of setting the mesh network without using 
adhoc mode. In that case each router should have one ap for non 
batman-adv clients, and two additional interfaces, one in ap and the 
other managed, these two used to connect with other routers via 
batman-adv, would that be correct? In that case, you think this 
configuration could be more or less stable than the other using adhoc 
mode? Thanks in advance!

Gabriel
