Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <4917381.eeOl7B1qNb-2016-02-09-07-20-04@prime>
References: <OF64B7E443.53DA160A-ONC1257F53.003E4656-C1257F53.003FAF34@phoenixcontact.com>
 <4917381.eeOl7B1qNb-2016-02-09-07-20-04@prime>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFCA66B6A0.8D0726B0-ONC1257F54.00240C7B-C1257F54.0026962A@phoenixcontact.com>
Date: Tue, 9 Feb 2016 08:01:27 +0100
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
Subject: [B.A.T.M.A.N.] Antwort: Re: Looping unicast packets when using BLA
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hi Simon,

thanks for the quick reply.

Simon Wunderlich <sw@simonwunderlich.de> schrieb am 08.02.2016 13:29:55:

> Von: Simon Wunderlich <sw@simonwunderlich.de>
> An: b.a.t.m.a.n@lists.open-mesh.org
> Kopie: Andreas Pape <APape@phoenixcontact.com>
> Datum: 09.02.2016 07:20
> Betreff: Re: [B.A.T.M.A.N.] Looping unicast packets when using BLA
>
> Hi Andreas,
>
> On Monday 08 February 2016 12:35:35 Andreas Pape wrote:
> > Hello
> >
> > I have a problem in my mesh setup which is quite similiar to Bug#216
of
> > the bug tracker.
> > I'm using batman-adv 2014.4.0 in a BLA setup consisting of 3 Mesh
Nodes
> > (A, B, C) connected to the same backone network via a common switch
and a
> > mesh node D connected to an end device E. I ping that single mesh node
D
> > and the connected end device E from a PC which is connected to the
same
> > switch as the three Nodes A to C. BLA is compiled and enabled.
>
> First of all, did you test v2016.0? v2014.4.0 is pretty old, the bug was

> created and closed in 2015 after all ...

I just restarted my last year's work to test batman-adv and was a little
bit lazy to update to the latests version as my devices use a fairly old
kernel version 2.6.32. And the update to 2014.4.0 early last year only
worked with Marek's help (issue in the compat code).

But before making further assumptions, I'll start with the update first.
In the meantime I am pretty sure, that the problem does not come from the
bla code as such. I changed the code in batadv_bla_rx in the repsective
part as follows:

        ether_addr_copy(search_claim.addr, ethhdr->h_source);
        search_claim.vid =3D vid;
        claim =3D batadv_claim_hash_find(bat_priv, &search_claim);

        if (!claim) {
                /* possible optimization: race for a claim */
                /* No claim exists yet, claim it for us!
                 */

                if (!batadv_is_my_client(bat_priv, ethhdr->h_source, vid))
{
                        batadv_handle_claim(bat_priv, primary_if,
                                        primary_if->net_dev->dev_addr,
                                        ethhdr->h_source, vid);
                        goto allow;
                } else {
                        printk("not claimed: %pM \n", ethhdr->h_source);
                        goto handled;
                }
        }

I did this yesterday in a "quick-and-dirty" way and restarted my pingtest,
which ran until this morning without looping packets. But I did not notice
until now that I did not only prevent the claiming of MAC addresses from
the own backbone but I also dropped the packets causing the claim to be
triggered! That tells me that the original code in batadv_bla_rx is most
likely OK and that my problem comes from somewhere else (e.g. ping request
from=20PC to device E enters gateway A and is forwarded to gateway B via the
mesh. But gateway B does not forward it to mesh node D but sends the
packet via the linux bridge and my eth0 interface to the backbone
network).

But before digging deeper into this, I'll make a try with 2016.0 and see
if the problem is solved there.

>
> >
> > From time to time I see looping unicast packets in my backbone
network.
> > This unicast looping starts directly after one of the nodes A to C
claimed
> > the mac address of my PC. The looping telegram is then the ping
request
> > sent by the PC. I have a wireshark recording made in my backbone via
port
> > mirroring of one of the switch ports where a mesh node is connected to
> > which shows this behaviour.
>
> Is it really the ping packet looping? If yes, which nodes are part of
the
> loop? Normally we only see broadcast packets looping. In #216 it was
also
> broadcast packets where we have seen duplicates, and this was more a
locking
> problem leading to creation of the same packets again and again.
>
> >
> > I am not sure if I understood bla correctly but isn't it nonsense that
a
> > bla backbone gateway claims MAC addresses from its own backbone (i.e.
the
> > one it is directly connected to via its ethernet port)?
>
> Yes, that appears to be nonsense indeed. Do you happen to have DAT
enabled?
> There were also some problems with that which are fixed by now.

DAT is enabled. But my problem starts with a gratuitous arp containing a
claim and not a multiplication of normal arp requests or repsonses.

>
> >
> > A simple change in batadv_bla_rx seems to solve this problem: add an
> > additional check before claiming a new mac address: if this address is
> > already known from the tt local table (via command
batadv_is_my_client)
> > don't claim it.
> >
> > This seems to solve my problem as far as I have tested so far. Any
> > thoughts about that?
>
> This will prevent roaming from on of your nodes connected to the
backbone (A-
> C) to the mesh-only node D.
>
> I would like to suggest to upgrade and test again, and try disabling DAT
if
> the problem is still present (you should still report it if DAT makes a
> difference in that case). If you still see a problem then, we probably
have
> something unsolved, and then I'd like to understand which nodes are part
of
> the loop.
>
> Thank you!
>      Simon[Anhang "signature.asc" gel=F6scht von Andreas Pape/Phoenix
Contact]

Thanks and regards,
Andreas



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
