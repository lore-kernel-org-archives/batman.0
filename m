From: Axel Neumann <axel@open-mesh.net>
Subject: Re: [B.A.T.M.A.N.] batman gw nodes and routing (rv792)
Date: Mon, 12 Nov 2007 15:31:28 +0100
References: <200711111816.18242.axel@open-mesh.net>
	<840E3F681DF3D043B353C0FDD4A6C353ABFC97@ex9.hostedexchange.local>
	<000301c824b2$6f055c20$4d101460$@com>
In-Reply-To: <000301c824b2$6f055c20$4d101460$@com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711121531.28533.axel@open-mesh.net>
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
To: pele@balorda.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hi,

On Sonntag 11 November 2007, Predrag Balorda wrote:
> This is my setup - I sincerely hope ascii-art holds up as it took some time
> to create! :-)

           gateway
Inet -- 123.456.789.100     router1
             10.0.0.1 --- 10.0.0.10             router2              router3
                 (ath0)   105.0.0.1 --batman-- 105.0.0.2 --batman-- 105.0.0.3
                 (eth0)    10.0.1.0             10.0.2.0             10.0.3.0
                 (bat0) 169.254.0.0 --PtP-- 169.254.2.79
                 (bat0) 169.254.0.0 --------------PtP-----------  169.254.2.80

>
> I have read the bmx pdf and it is excellent. Everything works as it should
> on batman-exp  rv792. But I have a problem. The guide assumes that your
> gateway to the public internet is my 'router1' and it also assumes that you
> have a firewall running on all those routers.

just an idea...

The document does not yet mention the option for the old, stateless, 
batmand-0.2-based one-way-tunnel. The one-way-tunnel only entunnel uplink 
internet data (from the client node to the gw node). No tunnels are used for 
downlink internet data (from the GW node to the client). For downlink 
traffic, the GW node just forwards the data. Therefore the inner IP address 
must be a valid and known IP address in your mesh - usually the batman 
address of the client node. 
With rv 795, the source address of the entunneled packets at the client side 
can also be an addresses from a non-batman interface (like eth0 in your 
setup) if this address ranges have been HNA announced by the client node.


You can enable them at the gw side with --one-way-tunnel 1
At the client side, you can enable --one-way-tunnel <value> with a value 
larger than 0. The value defines a preference for the tunnel types offerred 
by the selected GW (higher value = more preferred). You can disable the 
0.3-default-two-way-tunnel with --two-way-tunnel 0 
(see also --dangerous for very short help)

This way it should be possible to:

- do SNAT only on your gateway. No (S)NAT on any batman node

- configure a default route at router 1 to your gateway 

- configure a 10.0.0.0/16 route at the gateway to router 1 

- for the uplink traffic packets from client-node-dhcp-clients are entunnelled 
at the client-node but with the original client-node-dhcp-clients ip address 
as the inner tunnel src address.

- the client-node-dhcp-clients ip address ranges are announced by the 
corresponding clients

- for the downlink traffic let the batman daemon on router 1 choose the 
correct next hop towards the client node which announced the correspoding 
network destination address.

- maybe other (dis)advantages, depending on your personal preferences like: no 
blackhole-GW-detection, no means for a GW node to control the maximum number 
of connected client nodes, less tunnel-protocol-overhead,...

happy routing,
/axel


>
> It also ends up with double-nat (well, actually triple-nat in my case). I
> have gotten rid of one level of nat (on router1). But I'm still left with a
> double nat.
>
> Nat happens when default route traffic from batman nodes is sent down bat0
> tunnel and then once again when my gateway passes it onto the public ip
> space.
>
> I have succeeded in creating a setup where no nat is done when client nodes
> connect to 10.0.0.0/24 network (10.0.0.0/24 hna on router1) but if I want
> to go out onto the internet I simply have to do
>
> iptables -t nat -A POSTROUTING -o bat0 -j MASQUERADE
>
> on each batman node, otherwise nodes themselves can get out but their eth0
> clients cannot (i.e. from 10.0.2.0/24 or 10.0.3.0/24 - 10.0.1.0/24 doesn't
> have this problem as it has a default route entry in the output of 'route'
> - other batman nodes don't)
>
> Can someone with a bit more experience in these matters give me a hand. I
> will probably end up having to use batman on gateway node as well but I'd
> rather have this possibility of a gw node not runnig batman.
>
> Thanks again!
>
> Pele
>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n


