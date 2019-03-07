Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Thu, 07 Mar 2019 16:55:32 +0100
Message-ID: <2087721.Ft2tnNZQ0y@prime>
In-Reply-To: <20190224165113.15726-1-sven@narfation.org>
References: <20190224165113.15726-1-sven@narfation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2407896.Dye3hh5ekt";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC openwrt-routing] batman-adv: Split batadv
 proto in meshif and hardif part
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Sven Eckelmann <sven@narfation.org>, openwrt-devel@lists.openwrt.org

--nextPart2407896.Dye3hh5ekt
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, February 24, 2019 5:51:13 PM CET Sven Eckelmann wrote:
> batman-adv allows to configure three different objects:
> 
> * batadv hardif
> 
>   - network interface used by batadv meshif to transport the batman-adv
>     packets
>   - its master interface is set to the batadv meshif
> 
> * batadv (meshif/softif)
> 
>   - virtual interface that emulates a normal 802.3 interface on top
>   - encapsulates traffic and forwards it via the batadv hardifs
> 
> * batadv vlan
> 
>   - potential VLAN ID on top of batadv meshif
>   - allows filtering of traffic from specific VIDs
> 
> While batadv vlan objects were already represented as an own proto
> "batadv_vlan", the batadv meshif could never be fully configured using
> /etc/config/network. Instead, parts of its configuration were stored in
> /etc/config/batman_adv and some in the interfaces with the "batadv" proto.
> 
> To increase the confusion, the "batadv" proto wasn't used to define the
> batadv meshif but to identify batadv (slave) hardifs. The batman-adv
> meshifs were also never created directly but only when a hardif was
> configured. The actual modification of the configuration settings was then
> applied using a hotplug script hack. The batadv meshif network interface
> could therefore only be created when an hardif was available and not
> manipulated with ifup/ifdown. Also `/etc/init.d/network reload` didn't
> modify the batadv meshif interface configuration correctly.
> 
> The "batadv" is now renamed to "batadv_hardif" and a new "batadv" proto is
> used to configure the main (meshif) network interface with all its
> configuration.
> 
> A simple network configuration with WiFi & ethernet interfaces and static
> IP on top of bat0 would look like:
> 
>   # batadv meshif bat0
>   config interface 'bat0'
>         option proto 'batadv'
>         option routing_algo 'BATMAN_IV'
>         option aggregated_ogms 1
>         option ap_isolation 0
>         option bonding 0
>         option fragmentation 1
>         #option gw_bandwidth '10000/2000'
>         option gw_mode 'off'
>         #option gw_sel_class 20
>         option log_level 0
>         option orig_interval 1000
>         option bridge_loop_avoidance 1
>         option distributed_arp_table 1
>         option multicast_mode 1
>         option network_coding 0
>         option hop_penalty 30
>         option isolation_mark '0x00000000/0x00000000'
> 
>   # add *single* wifi-iface with network bat0_hardif_wlan as hardif to bat0
>   config interface 'bat0_hardif_wlan'
>         option mtu '1536'
>         option proto 'batadv_hardif'
>         option master 'bat0'
>         # option ifname is filled out by the wifi-iface
> 
>   # add eth0 as hardif to bat0
>   config interface 'bat0_hardif_eth0'
>         option proto 'batadv_hardif'
>         option master 'bat0'
>         option ifname 'eth0'
>         option mtu '1536'
> 
>   # configure IP on bat0
>   config interface 'bat0_lan'
>         option ifname 'bat0'
>         option proto 'static'
>         option ipaddr '192.168.1.1'
>         option netmask '255.255.255.0'
>         option ip6assign '60'

Hey,

thank you very much for proposing that. It looks very good to me. We just 
discussed personally if it were possible to get rid of the bat0_hardif 
sections, but we will need them to configure other things in the future (e.g. 
ELP intervals, throughput override). And doing the "ifname" list in bat0 would 
result in a bad hack as we currently have for bridges, this is not favorable.

So +1 from me for this.

Cheers,
      Simon


--nextPart2407896.Dye3hh5ekt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlyBPvQACgkQoSvjmEKS
nqGKfBAAwqS5f5Z14YuIw+uYrAEWlxze5aQoVnn7nYJO0qITHYSrilhTsY1oqT32
04blFiNSPV5TdTHak16HdpxC3Ug6KvMzH8ULBfVn86blRxwi1+SO8DkDOZLlka/D
ylv6Gh5XOkTrCjnNLO4ueFuKzNaf5JlaKiFn6Ozkq+Z3jAp0vC8060edup8UKByp
qbLDZ8CGaArBYNmHXRoxPSx5g+S6D9iu7S/suIoA1vG1xfa/np8m4Z6hnrUWn+kM
zJsSDoypNElFh1fWxmpjYrDfZ9QQTUg/+l4GiqtUA3pom6Lt0j+krXXxAd8FQc8w
ecDG61ZSiGGWbs/Dh69wyel8FXhZz6N4otez+TMWjtyMmvhNZe0FdWFwDtxZ8N9z
V/rSyBJodWHQk+Fpo8cDpPDs4yk6az1IC2941uWLJqQ5pzvhQz+qldNI9GE6CbUz
4ty60OWcW025TXsDOcsANftmrWRnGyAYf7XdD+Gw5HYwrOnB4zj9Xf71N/cnYkrw
ihW/MU7bU+3xCgyRXTo6+UEvy8zay5kJ5prgk6Mz/7/s37z51ehx4Qt8i5lTNYmE
xGeFC8XnY6VFShcHq+4TIAsGvLS9Y2hBcS38bXa4+evIAaiG3uTkti3t320saYz6
OwukfeTfNntE/TQW1xLQoKqC4sAc5XmxQ8Fao1E3W36xoe3dTBg=
=7K7X
-----END PGP SIGNATURE-----

--nextPart2407896.Dye3hh5ekt--

