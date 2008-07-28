Message-ID: <488E2502.4090907@reglue.org>
Date: Mon, 28 Jul 2008 14:58:58 -0500
From: Don Davis <dondavis@reglue.org>
MIME-Version: 1.0
Subject: Re: [B.A.T.M.A.N.] Batman 0.3 + Freifunk setup questions
References: <487F60E5.5000003@reglue.org>
	<487F77DF.8050305@reglue.org>	<487F9142.9000704@reglue.org>
	<487FA7DD.7080607@reglue.org>	<20080717220707.GA9314@hrz.tu-chemnitz.de>	<487FC8BB.6010707@reglue.org>
	<20080717233621.GA10978@hrz.tu-chemnitz.de>
In-Reply-To: <20080717233621.GA10978@hrz.tu-chemnitz.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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


> Debug Level 2 will list the available gateways. There is no need to
> restart BATMAN, it will notice the new gateway available gateways 
> automatically (the gateways are announced with the BATMAN-packets). One
> of the gateways will be selected depending on the configuration at -r. 

I'm a little curious about setting up an init script for batmand 0.3
Using freifunk + batmand 0.3:

S97startnode.sh
#! /bin/sh
batmand eth1

Works fine for the nodes.  However,
S97startnode.sh
#! /bin/sh
batmand -r 3 eth1

does not find the gateway.  I thought the default routing class was 3 or 
would respond fastest but apparently not.

More of a concern though is writing an init script for a gateway.
S97gateway.sh
#! /bin/sh
batmand -g 5mbit eth1 vlan1


at best has to be killed and restarted for batmand to work; worst case 
scenario it freezes the router.  I need to find a way to get it to wait 
for the dhcp lease before starting (I guess).  Though doesn't the dhcp 
lease come after S99?

What about a script (much like watchout4batman which I haven't seen for 
batman 0.3) that can be run as a cronjob that does two things 1) makes 
sure batmand is up and running 2) if an interface is available on vlan1 
(or whatever the wan port is on) then restart batmand and announce the 
node as a gateway?

For a gateway is there any advantage to
batmand -g 5mbit eth1 vlan1
over
batmand -g 5mbit eth1?


