Return-Path: <onelektra@gmx.net>
From: elektra <onelektra@gmx.net>
Date: Tue, 26 Apr 2011 01:42:24 +0200
References: <201104251055.17370.onelektra@gmx.net>
	<4DB5DB65.6070706@interia.pl>
In-Reply-To: <4DB5DB65.6070706@interia.pl>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201104260142.24934.onelektra@gmx.net>
Subject: Re: [B.A.T.M.A.N.] Batmand - ping 169.254.0.0 from client is not
	working.
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

Hi Krzysiek -

as promised you can now use the Internet from the batmand gateway client and you can access the gateway machine 
behind the batmand gateway. 

If you have more machines in the 192.168.2.0/24 subnet, you will be able to access them as well. However they are 
now behind a NAT instance.

You can not ping the 192.168.2.2 interface address since you didn't announce the 192.168.2.0/24 subnet via HNA. You 
can ping everything that is behind 192.168.2.2, because of the NAT postrouting rule. I don't think talking to the 
192.168.2.2 IP is necessary since you can access the device with the 10.130.1.X IP. If you insist on it, you can 
add a HNA network announcement ( -a ). 

The package you are missing is iproute2.

With regards to the PC connected to the batman gateway client - did you set up a default route in the PC? Without a 
route you can only ping those IPs that are link local. Don't forget to add a DNS server, too.

Don't bother about pinging the tunnel endpoint IP. The tunnel is merely required as a means of transport which 
allows batman gateway-clients to select a batmand gateway when sending traffic *to* the gateway. And it is a half-way 
(one-way!) tunnel.  

Cheers,
Elektra


-- 
Viral meme of radical freedom

The fact that you talk in your head doesn't mean that you think.

The best way to lose control over yourself is trying to control yourself.

Most people experience themselves as a voice in their head, telling them
who they are, what they think and what they have to do.

http://en.wikipedia.org/wiki/Meme
