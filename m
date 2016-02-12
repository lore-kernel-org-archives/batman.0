Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <3200137.NDelIOaaur@prime>
References: <OF64B7E443.53DA160A-ONC1257F53.003E4656-C1257F53.003FAF34@phoenixcontact.com>
 <OFCA66B6A0.8D0726B0-ONC1257F54.00240C7B-C1257F54.0026962A@phoenixcontact.com>
 <OF08AE6344.F52C14B1-ONC1257F56.002E1241-C1257F56.0033308C@phoenixcontact.com>
 <3200137.NDelIOaaur@prime>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFE4164813.C8B92EEC-ONC1257F57.0038C5A8-C1257F57.003AA049@phoenixcontact.com>
Date: Fri, 12 Feb 2016 11:40:21 +0100
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
Subject: [B.A.T.M.A.N.] Antwort: Re: Re: Antwort: Re: Looping unicast
 packets when using BLA
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>, "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>

Hi Simon,


Simon Wunderlich <sw@simonwunderlich.de> schrieb am 11.02.2016 12:08:25:

> Von: Simon Wunderlich <sw@simonwunderlich.de>
> An: Andreas Pape <APape@phoenixcontact.com>
> Kopie: The list for a Better Approach To Mobile Ad-hoc Networking
> <b.a.t.m.a.n@lists.open-mesh.org>, "B.A.T.M.A.N" <b.a.t.m.a.n-
> bounces@lists.open-mesh.org>
> Datum: 11.02.2016 12:08
> Betreff: Re: Re: [B.A.T.M.A.N.] Antwort: Re: Looping unicast packets
> when using BLA
>
> Hi Andreas,
>
> On Thursday 11 February 2016 10:19:07 Andreas Pape wrote:
> > Hi,
> >
> > I want to give a short feedback concerning my attempt to use
> > batman-adv-2016.0 instead of to older version I used first.
> >
> > Unfortunately, using batman-adv-2016.0 does not solve my problem. I
can
> > still see claim frames sent by the mesh gateways into the common
backbone
> > network for MAC addresses out of the common backbone network itself. I
> > enabled again both bla and dat support. Furthermore I have also still
> > problems with DAT, because there are multiple ARP replies visible in
the
> > backbone network coming out of the mesh.
> >
> > That reminds me that I have forgotten to mention in my earlier mail,
that
> > I did not test with the original batman-adv-2014.4.0 first but with a
> > version having the patch applied I sent to the mailing list in March
last
> > year concerning possible fixes for dat in bla setups. If I remember it
> > correctly I think there were two main issues in batman-adv-2014.4.0
when
> > using dat in combination with bla:
> > 1.Broadcast ARP requests from the backbone network are handled by each
> > gateway, leading to multiple dat adress resoultions in parallel.
>
> That shouldn't be a problem on its own.

I think I wasn't precise enough concerning this point. I meant the effect,
that
a broadcast ARP coming from a common backbone reaches all gateways. If now
accidentally
several gateways can already answer that request due to dat, then the
current code sends
an arp reply from each gateway being able to answer. This broadcast does
not even reach
the mesh if all gateways can answer the request (as far as I have
understood the code).
Therefore broadcast handling in the mesh layer does not solve this
problem.
>
> > 2. As dat uses tunneling of broadcasts in special batman-adv unicast
> > frames, the current bla code does not seem to prevent these broadcasts
> > from reaching the backone network as it is done for normal broadcast
> > coming from the mesh and heading for the backbone.
> > Both effects together lead to a multiplication of arp requests and
> > replies. My patch of last year tried to address this.
>
> Hm, I see. I just checked the code and it seems we fixed this issue
> for speedy
> join in the mean time (affecting TT), but for bla the problem is still
> present.
>
> Wouldn't it be sufficient to add something like a check for backbones (
> batadv_bla_is_backbone_gw) into batadv_recv_unicast_packet() and drop
packets
> if they came from the same backbone?
>
That's a good question. This is something I did not dare to do last year
because
I cannot foresee possible negative implications. Perhaps someone more
experienced with
batman-adv routing should answer this. Therefore I focussed on fixing this
for the DAT ARP handling only.
But doing so as you propose would most likely have the positive side
effect that I will get rid
of the looping unicast packets in my backbone network, too. But as
mentioned in my prior mail
I think this looping unicast packets might have another cause. The
question is: why does
a gateway forward a unicast packet received via the mesh with a
destination mac behind
an originator somewhere else in the mesh (that originator is not connected
to the same backbone) to
its own backbone? If this only can happen if the entry in the global tt
expires (like a mac adress
table expires in a switch and the switch starts broadcasting incoming
packets to all ports), then
I would think blocking all unicast traffic coming from another backbone gw
of the same backbone network
is the smartest and easiest solution.

> I have found your patch from last year. Would you like to rebase/split
your
> patch to address the remaining issues? That would help us a lot. Please
also
> put a proper patch message. I promise to be more responsive this time.
:)
>

I'm trying to split my last year's patch into logical seperate pieces,
update them
to be compliant to the latest master branch of the batman-adv.git
repositor and will
mail them for further discussion.

> >
> > Good news is that disabling dat in batman-adv-2016.0 seems to solve my
> > observed issues (in strange ways even the observed erroneous claim
frames
> > in the backbone network....). But I think dat is a clever feature to
> > reduce broadcast load in the mesh network. Wouldn't it be useful to
dig a
> > little bit deeper into the combined use of dat and bla? I would
volunteer
> > for testing and providing ideas for improving the behaviour.
>
> If you could help, that would be great! Your patch from last year
> already is a
> good start, so I'm sure you are capable of working on that. I would be
happy
> to help with that, too.
>
> >
> > Or do you think that I have an issue with my old 2.6.32 kernel?
>
> I don't think so. To me it looks like the issue could still be present
in
> current versions ...
>
> Cheers,
>      Simon[Anhang "signature.asc" gel=F6scht von Andreas Pape/Phoenix
Contact]


..................................................................
PHOENIX CONTACT ELECTRONICS GmbH

Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmont
USt-Id-Nr.: DE811742156
Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
Gesch=E4ftsf=FChrer / Executive Board: Roland Bent, Dr. Martin Heubeck
___________________________________________________________________
Diese E-Mail enth=E4lt vertrauliche und/oder rechtlich gesch=FCtzte Informa=
tionen. Wenn Sie nicht der richtige Adressat sind oder diese E-Mail irrt=FC=
mlich erhalten haben, informieren Sie bitte sofort den Absender und vernich=
ten Sie diese Mail. Das unerlaubte Kopieren, jegliche anderweitige Verwendu=
ng sowie die unbefugte Weitergabe dieser Mail ist nicht gestattet.
---------------------------------------------------------------------------=
-------------------------
This e-mail may contain confidential and/or privileged information. If you =
are not the intended recipient (or have received this e-mail in error) plea=
se notify the sender immediately and destroy this e-mail. Any unauthorized =
copying, disclosure, distribution or other use of the material or parts the=
reof is strictly forbidden.
___________________________________________________________________
