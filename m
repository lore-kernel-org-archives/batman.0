Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Sun, 3 Jun 2012 10:24:51 -0300
Message-ID: <CAHD-aqKpKB=rpHyf0_KDeu0Jbhd2ah+wcXfccCRJyTLKWzxbTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] MAC discovery protocol for filling /etc/bat-hosts
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Martin said:
> On 05/08/2012 10:52 PM, Guido Iribarren wrote:
> > mDNS solutions like avahi translate between hostnames and ips, while
> > batman visualization deals with MACs, and those cannot necessarily be
> > obtained from IPs (in some cases, ARP will help, but won't work in
> > interfaces without IPs)
> >
> > maybe i'm ignoring some MAC discovery protocol?
>
> While reading about TLV's on wikipedia[1], I came across a MAC discovery =
protocol[2], LLDP, which
> eventually lead me to OpenLLDP[3]. If this also works on 802.11, I think =
we have a winner :)
>
> Happy hacking!
>
> [1] http://en.wikipedia.org/wiki/Type-length-value
> [2] http://en.wikipedia.org/wiki/Link_Layer_Discovery_Protocol
> [3] http://openlldp.sourceforge.net/
>
> --
> Kind Regards
> Martin Hundeb=C3=B8ll
> >

It looks promising:

did on two different routers connected by batman 2012.1.0 with adhoc interf=
aces
# opkg list lldpd
lldpd - 0.3-3 - LLDP (Link Layer Discovery Protocol)
# opkg install lldpd
# /etc/init.d/lldpd
### wait a couple of minutes
#  lldpctl |head
---------------------------------------------------------------------------=
----
    LLDP neighbors
---------------------------------------------------------------------------=
----
Interface: wlan0-2
 ChassisID: 54:e6:fc:be:29:d1 (MAC)
 SysName:   colmena
 SysDescr:  Linux 3.3.2 #1 Thu May 24 17:06:23 UTC 2012 mips
 MgmtIP:    10.6.2.170
 Caps:      Bridge(E) Wlan(E)

# lldpctl |egrep "(SysName|PortID|PortDescr)"|sed -rn "s/[^:]*:
*([[:graph:]]*)( \(MAC\))?$/\1/;p;" | sed -nr "N;N;s/\n/|/g;s/(.*)\
|(.*)\|(.*)/\2 \1_\3/;p" >/etc/bat-hosts
# cat /etc/bat-hosts
56:e6:fc:be:29:d4 colmena_wlan0-2
3a:3c:98:fe:55:2f colmena_bat0

### Yes, that's a repulsive 5 min sed hack. I feel sorry for your eyes.

Unfortunately, lldpd 0.3 is designed to work with just 1 neighbour on
each interface.
So when i started lldpd on a third node in the mesh network, didn't
work as expected.
Version 0.4alpha has an option to disable this behaviour and
apparently show many neighbours per interface. Haven't had the time to
compile and try it.

Thanks Martin!

Guido
