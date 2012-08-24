Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 24 Aug 2012 17:00:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201208241700.04486.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] batman-adv 2012.3.0 released
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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


The B.A.T.M.A.N. team is delighted to announce its latest release, batman-a=
dv=20
2012.3.0, focused on cleanups, stability and bugfixes bundled with a few=20
smaller features. As the kernel module always depends on the Linux kernel i=
t=20
was compiled against, it does not make sense to provide binaries on our=20
website. As usual, you will find the signed tarballs in our download sectio=
n:

http://downloads.open-mesh.org/batman/releases/batman-adv-2012.3.0/

as well as prepackaged binaries in your distribution.


Thanks
=2D-----

Thanks to all people sending in patches:

 * Al Viro <viro@ZenIV.linux.org.uk>
 * Antonio Quartulli <ordex@autistici.org>
 * Ben Hutchings <bhutchings@solarflare.com>
 * Jesper Juhl <jj@chaosbits.net>
 * Marek Lindner <lindner_marek@yahoo.de>
 * Martin Hundeb=F8ll <martin@hundeboll.net>
 * Matthias Schiffer <mschiffer@universe-factory.net>
 * Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
 * Sven Eckelmann <sven@narfation.org>

and to all those that supported us with good advice, code review and/or=20
rigorous testing:

 * Andrew Lunn <andrew@lunn.ch>
 * David S. Miller <davem@davemloft.net>
 * Guido Iribarren <guidoiribarren@buenosaireslibre.org>
 * Nicol=E1s Ech=E1niz <nicoechaniz@codigosur.org>

Special thanks to Sven Eckelmann who took on the nearly-impossible task of=
=20
restyling / renaming of all existing variable declarations and function nam=
es=20
throughout the code. With 68 patches he submitted about 5000 changes to=20
achieve the goal of making the code more coherent.


batman-adv
=2D---------

David Miller, the Linux kernel network maintainer, wanted batman-adv to bec=
ome=20
a better Linux-citizen by conforming to the Linux namespace convention. Sin=
ce=20
this topic was neglected for quite some time a fair amount of code changes=
=20
were required to comply with the convention. This renaming / restyling work=
=20
represents the bulk of the changes coming with this release. The newly=20
introduced extended traffic statistics support also is worth mentioning: Up=
=20
until now batman-adv only collected statistics about the payload traffic. T=
his=20
release adds counters about mesh internal traffic like forwarded traffic, O=
GM=20
and TT management traffic that can be accessed through the ethtool API.

Numerous components received bugfixes: The translation table handling code=
=20
fixed a race condition in the full-table replacement logic and correctly=20
handles endianness when forwarding TT Request packets. Furthermore, the=20
cooperation between the routing protocol and the translation table has been=
=20
abstracted to allow a smooth integration with the routing protocol API. The=
=20
gateway code dealt with a regression which made it impossible to select a=20
gateway on a client if a selection class smaller than 3 was chosen. The=20
recently renovated bridge loop avoidance falsely dropped DHCP packets comin=
g=20
through the gateway code as it believed to prevent a loop. This has been=20
addressed. The AP isolation was a little too aggressively dropping all=20
broadcast traffic from WiFi clients which made it impossible, for example, =
to=20
exchange mac address entries via ARP. The visualization output of the vis=20
component does not fail on primary interfaces without neighbors anymore.=20
Batman-adv was modified to initialize all reserved protocol fields with zer=
o=20
to ensure later compatibility when the packet format may be changed. A race=
=20
condition in the hash implementation was found and fixed as well.


batctl
=2D-----

New in this release is the packet statistics retrieval component which=20
displays the data gathered by batman-adv through a new command line switch.=
=20
The mini-tcpdump allows to filter parsed packets by compatibility number on=
ly=20
showing packets that match its own compat number. In addition, it learned t=
he=20
new bridge loop avoidance (BLA II) packet format to also display those=20
packets. The ping and traceroute components properly initialize all ICMP=20
fields to avoid unexpected behavior.


Happy routing,
The B.A.T.M.A.N. team
