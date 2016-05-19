Return-Path: <linus.luessing@c0d3.blue>
Date: Fri, 20 May 2016 00:48:09 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20160519224809.GG12565@otheros>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
 <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
 <20160519194553.GD12565@otheros> <20160519203049.GE12565@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160519203049.GE12565@otheros>
Subject: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: speed up dat by
 snooping received ip traffic
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On Thu, May 19, 2016 at 10:30:49PM +0200, Linus Lüssing wrote:
> > Not sure whether it is necessary, or whether there is a check
> > somewhere later within DAT. But should we exclude some
> > iphdr->saddr or ethhdr->h_source addresses? For instance a
> > DHCPDISCOVER usually has a zero-ip address.
> 
> And speaking of DHCP, do you (or anyone else) know, whether a
> dhcp-server (or its kernel) sends an ARP request before sending
> a unicast DHCPOFFER? Or do dhcp-servers usually craft DHCPOFFERs
> in userspace within their daemon including the ethernet header?
> 
> If the latter is the case, maybe we could/should dat-snoop the
> ethernet+IP destination of such DHCPOFFERs in interface_rx(),
> too?

Did a quick try in VMs with two standard Debian unstable machines
using isc-dhcp-client and -server. Also enabled "ping-check false"
on the dhcp-server.

Then I do not see any ARP messages, I just see four DHCP packets (see
below). And "ip neigh" stays empty.

So it seems that at least the isc-dhcp-server can assemble raw
packets, including the ethernet frame (*).


So the DHCPOFFER's ethernet and IP destinations on a
batadv_interface_tx() (sorry, wrongly wrote _rx() above) would
give us an even earlier opportunity to feed DAT from.

Would that make sense to do so?



(*): Though looking at the code of isc-dhcpd, there seem to be
compile-time options for two more, different send_packet() functions
which do not always do that.


-----

tcpdump: listening on eth1, link-type EN10MB (Ethernet), capture size 65535 bytes
22:32:03.379281 02:04:64:a4:39:e2 (oui Unknown) > Broadcast, ethertype IPv4 (0x0800), length 342: (tos 0x10, ttl 128, id 0, offset 0, flags [none], proto UDP (17), length 328)
    0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, Request from 02:04:64:a4:39:e2 (oui Unknown), length 300, xid 0x17feeb29, Flags [none]
          Client-Ethernet-Address 02:04:64:a4:39:e2 (oui Unknown)
          Vendor-rfc1048 Extensions
            Magic Cookie 0x63825363
            DHCP-Message Option 53, length 1: Discover
            Hostname Option 12, length 12: "Linus-Debian"
            Parameter-Request Option 55, length 13:
              Subnet-Mask, BR, Time-Zone, Default-Gateway
              Domain-Name, Domain-Name-Server, Option 119, Hostname
              Netbios-Name-Server, Netbios-Scope, MTU, Classless-Static-Route
              NTP
22:32:03.385454 02:04:64:a4:39:c3 (oui Unknown) > 02:04:64:a4:39:e2 (oui Unknown), ethertype IPv4 (0x0800), length 342: (tos 0x10, ttl 128, id 0, offset 0, flags [none], proto UDP (17), length 328)
    192.168.123.1.bootps > 192.168.123.50.bootpc: BOOTP/DHCP, Reply, length 300, xid 0x17feeb29, Flags [none]
          Your-IP 192.168.123.50
          Client-Ethernet-Address 02:04:64:a4:39:e2 (oui Unknown)
          Vendor-rfc1048 Extensions
            Magic Cookie 0x63825363
            DHCP-Message Option 53, length 1: Offer
            Server-ID Option 54, length 4: 192.168.123.1
            Lease-Time Option 51, length 4: 600
            Subnet-Mask Option 1, length 4: 255.255.255.0
            Default-Gateway Option 3, length 4: 192.168.123.1
            Domain-Name-Server Option 6, length 4: 192.168.123.1
22:32:03.386571 02:04:64:a4:39:e2 (oui Unknown) > Broadcast, ethertype IPv4 (0x0800), length 342: (tos 0x10, ttl 128, id 0, offset 0, flags [none], proto UDP (17), length 328)
    0.0.0.0.bootpc > 255.255.255.255.bootps: BOOTP/DHCP, Request from 02:04:64:a4:39:e2 (oui Unknown), length 300, xid 0x17feeb29, Flags [none]
          Client-Ethernet-Address 02:04:64:a4:39:e2 (oui Unknown)
          Vendor-rfc1048 Extensions
            Magic Cookie 0x63825363
            DHCP-Message Option 53, length 1: Request
            Server-ID Option 54, length 4: 192.168.123.1
            Requested-IP Option 50, length 4: 192.168.123.50
            Hostname Option 12, length 12: "Linus-Debian"
            Parameter-Request Option 55, length 13:
              Subnet-Mask, BR, Time-Zone, Default-Gateway
              Domain-Name, Domain-Name-Server, Option 119, Hostname
              Netbios-Name-Server, Netbios-Scope, MTU, Classless-Static-Route
              NTP
22:32:03.398683 02:04:64:a4:39:c3 (oui Unknown) > 02:04:64:a4:39:e2 (oui Unknown), ethertype IPv4 (0x0800), length 342: (tos 0x10, ttl 128, id 0, offset 0, flags [none], proto UDP (17), length 328)
    192.168.123.1.bootps > 192.168.123.50.bootpc: BOOTP/DHCP, Reply, length 300, xid 0x17feeb29, Flags [none]
          Your-IP 192.168.123.50
          Client-Ethernet-Address 02:04:64:a4:39:e2 (oui Unknown)
          Vendor-rfc1048 Extensions
            Magic Cookie 0x63825363
            DHCP-Message Option 53, length 1: ACK
            Server-ID Option 54, length 4: 192.168.123.1
            Lease-Time Option 51, length 4: 600
            Subnet-Mask Option 1, length 4: 255.255.255.0
            Default-Gateway Option 3, length 4: 192.168.123.1
            Domain-Name-Server Option 6, length 4: 192.168.123.1
-----
