Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <20160520135138.GV12056@prodigo.lan>
References: <1462525107-19750-1-git-send-email-apape@phoenixcontact.com>
 <1462525107-19750-3-git-send-email-apape@phoenixcontact.com>
 <20160520135138.GV12056@prodigo.lan>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFD588994D.768F1C91-ONC1257FD1.00475329-C1257FD1.004B9309@phoenixcontact.com>
Date: Mon, 13 Jun 2016 15:45:27 +0200
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
Cc: a@unstable.cc

"B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org> schrieb am
20.05.2016 15:51:38:

> Von: Antonio Quartulli <a@unstable.cc>
> An: The list for a Better Approach To Mobile Ad-hoc Networking
> <b.a.t.m.a.n@lists.open-mesh.org>
> Datum: 20.05.2016 15:52
> Betreff: Re: [B.A.T.M.A.N.] [PATCHv3 2/6] batman-adv: speed up dat
> by snooping received ip traffic
> Gesendet von: "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>
>
> On Fri, May 06, 2016 at 10:58:23AM +0200, Andreas Pape wrote:
> > Speeding up dat address lookup is achieved by snooping all incoming ip
> > traffic. This especially increases the propability in bla setups that
> > a gateway into a common backbone network already has a fitting dat
entry
> > to answer incoming ARP requests directly coming from the backbone
> > network thus further reducing ARP traffic in the mesh.
>
> Any IP packet can't be sent if an ARP "handshake" has not been
performed. This
> means that when you are snooping an IP packet you have already snooped
an ARP
> packet slightly before. In which case do we really win something ?
>
In case of a static mesh ("static" in terms of non-moving mesh nodes and
when the mesh nodes almost always use the same backbone gateways for a
common
wired backbone) we gain nothing by snooping every packet.
The idea came up when I started experimenting with more dynamic setups
where the mesh nodes move around with several gateways into a common
wired backbone. In this case routing becomes more dynamically and it is
not assured that the traffic from/for a mesh node is always routed via
the same gateway which has already snooped the arp traffic.

> On top of that, don't you think that snooping *every* packet will badly
affect
> the performance ? Have you tried measuring the difference ?
>
I'm aware that this has an impact. I can try to measure the difference
using
my devices but these results of course are related to the hardware I use.
I'm lacking experience if such results can be used to generalize a
conclusion.

On the other hand this "feature" was not the root cause to post this
patchset. More important for me is the prevention of the "arp reply
storms" and the temporary loops between backbone network and the mesh
because this generates trouble in my application.
If it increases the propability for acceptance I don't care to remove
the ip source address snooping from the patchset.

Best regards,
Andreas




..................................................................
PHOENIX CONTACT ELECTRONICS GmbH

Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmont
USt-Id-Nr.: DE811742156
Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
Gesch=C3=A4ftsf=C3=BChrer / Executive Board: Roland Bent, Dr. Martin Heubeck
___________________________________________________________________
Diese E-Mail enth=C3=A4lt vertrauliche und/oder rechtlich gesch=C3=BCtzte I=
nformationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail i=
rrt=C3=BCmlich erhalten haben, informieren Sie bitte sofort den Absender un=
d vernichten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige=
 Verwendung sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
---------------------------------------------------------------------------=
-------------------------
This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and destroy this e-mail. Any unauthorized =
copying, disclosure, distribution or other use of the material or parts the=
reof is strictly forbidden.
___________________________________________________________________
