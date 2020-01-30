Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Internet connection problem with Batman
Date: Thu, 30 Jan 2020 16:49:40 +0100
Message-ID: <14371342.ShFETse3VS@bentobox>
In-Reply-To: <1e9ca23deab35c772fdfc80feb96437f@eisox.com>
References: <1e9ca23deab35c772fdfc80feb96437f@eisox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3255925.PlAbV6GDRu";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
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
Cc: faycel.benhajkhalifa@eisox.com

--nextPart3255925.PlAbV6GDRu
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday, 30 January 2020 16:24:55 CET faycel.benhajkhalifa@eisox.com 
wrote:
> Hello,
> I saw that you are contributing to BATMAN, may I ask you a few questions 
> about my installation?

Not all here are contributing to batman-adv. But at least some of the guys on 
the mailing list use batman-adv.

> I have several boards with OpenWRT firmware:
> I have 8 connected mesh boards.
> Internet connection on the boards is not always available.
> When a board no longer has an internet connection, I connect to another 
> board and try the following commands:
[...]

What do you ping from where? Please try to reduce the complexity of your tests 
step by step. The simpler they are, the better to pinpoint the problem. So 
don't try to ping from one node to the internet but to the actual gateway. Or 
just to the next hop.

What is the topology? Are the nodes in the mesh direct neighbors or are you 
using multiple hops?

Did you check each hop with tcpdump? Are the packets arriving at each hop and 
(for intermediate) nodes are forwarded correctly? The forwarding can only be 
seen on the lower interfaces (interfaces in the batadv interface bat0). The 
arrival can be seen on the upper layer (bat0) and on the lower layers. The 
interesting part would be now where the packet or the answer is lost. Or maybe 
the peer is not even answering on the ICMP echo request for some reason.

What protocol are you using above bat0? IPv6/IPv4? When it is IPv4, did you 
check that the MAC addresses in the ARP table are correct? Did you try to 
disable DAT in batman-adv? The disabling of DAT might be required when you 
cannot guarantee that IPv4 addresses stay the same until the DAT cache 
expires.

Did you check whether you have IPv4/IPv6 conflicts?

Did you check whether you have MAC address conflicts (either on the lower 
interfaces or on the bat0/br0 interfaces)?

Is only the internet connection not working or is something already failing in 
the path to your gateway?

Are the gateway and the node trying to get internet access using the correct 
IPv6/IPv4 routes?

Do you have multiple DHCP(v6)/RADV servers in the network which have 
conflicting configurations?

Do you manually set the gateway mode to client and have at least one node in 
the network which have gateway mode set to server but is not actually 
providing a valid DHCP answer.

Did you check whether you have some loops in your network (over the bat0 
interfaces - which seems to be bridged to other interfaces).

Did you check whether the bridge is blocking the access to correct outgoing 
port? Or whether a device behind your gateway device is blocking the 
connection?

Did you check whether your ip(6)tables is blocking some relevant traffic? Did 
you check whether something is going wrong in the some offloading HW?

Did you make sure that network-coding is disabled for the bat0 interface.

What makes you think that batman-adv is the reason for the problem for 
internet outage? batman-adv is by default not interested in layer 3/4/... 
stuff. And thus it is not handling your internet access. There are some 
optimizations like gw_mode and distributed_arp_table (DAT) that can try to 
optimize the routing of some (usually broadcasted) packets. The broadcasted 
packets will then reach the desired destination faster (or in DAT's case get 
an answer faster) - but that is not the main task batman-adv does.

It seems like you provided some config. But this seems to be a config for a 
device which directly has internet access and not internet over batman-adv. So 
not a node which has the internet outage problem.

Kind regards,
	Sven
--nextPart3255925.PlAbV6GDRu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl4y+xQACgkQXYcKB8Em
e0ZbYw//bfoJW/qIyx+JAQVh5qtcOwsgIVmXxhCmTGe5c+V8zV5voeMXk3Skss2r
4CovlL0KWVF68q5n2PTZQy7Dk84a5513lBnaLHl4fb7fOM2fdHo0v4Jg3FTcLOBV
lJRHxb+NVpzS7vi3P9pO3G+tVxUy9S4sgVIBAtsIrCm+UiNoLwaweM+xv4o82oHX
wR2NuA3RqJJneeGCtGB2vuMAtRZmxtzrEgBeG1PBT4LyZNIua2vWbURni4sjCNet
JBgCsYf9fPtkDQXQdVXYGh0wCRQmWNDusFk4JcVMWvGSYfEfqQRo1yXwsyZ1dv+W
EIpNiYK89HSIHWAXEB49BQuqvVs/1SKWvB2MabOu/zfy/xKCTP4pzffdRmNVpKfR
9bQwGctNKys1hiOy/Mx2ndkvr6X2PDGArj/FQFXWdghKWCMCK+W/4m4APHW2hBCe
V1i0su3l7A1JplwnK7joN+T9BRyoO95VjBTk2v2J/JN8J5ly9UC5hvqYV1JsKTpJ
PeuX/HIvAI1P2fZkKIKD+Z8MFucGPNpRzIywMYwjNuzDngf3a484kHMd1GOGJT4l
Z3Qng99W0+/FY2THE/xFnPQdOwtZ5dn0hlo/nGiJXll+IQB3eFBzCiyikjq6vknG
dgJ1ONXjGdgpPX0eNUKYybjtwn+H7D4Qc0i/Zyj47+2oiqlSjVU=
=kleI
-----END PGP SIGNATURE-----

--nextPart3255925.PlAbV6GDRu--



