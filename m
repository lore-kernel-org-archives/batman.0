Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <38318850.GE51cWUxAf@prime>
References: <20170428202610.27022-1-sw@simonwunderlich.de>
 <38318850.GE51cWUxAf@prime>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFB68BD388.DE1C34EE-ONC125811C.001DD4CD-C125811C.001FA9C9@phoenixcontact.com>
Date: Wed, 10 May 2017 07:45:50 +0200
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] Antwort: Re: [PATCH] batman-adv: handle race
 condition for claims also in batadv_bla_rx
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

> Von: Simon Wunderlich <sw@simonwunderlich.de>
> An: Andreas Pape <apape@phoenixcontact.com>
> Kopie: b.a.t.m.a.n@lists.open-mesh.org
> Datum: 09.05.2017 17:50
> Betreff: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: handle race
> condition for claims also in batadv_bla_rx
>
> On Friday, April 28, 2017 10:26:10 PM CEST Simon Wunderlich wrote:
> > From: Andreas Pape <apape@phoenixcontact.com>
> >
> > Like in the case of the patch for batadv_bla_tx to handle a race
> > condition when claiming a mac address for bla, a similar situation
> > can occur when claiming is triggered via batadv_bla_rx. This patch
> > solves this with a similar approach as for batadv_bla_tx.
> >
> > Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
>
> Hi Andreas,
>
> thanks again for the patch - in general, I think this looks good,
although I
> don't follow completely where you saw that. Can you describe the
scenario a
> little more?
>
> We usually don't process packets from the mesh sent by nodes on the same
LAN
> segment - we look at the originator and check the BLA group using
> batadv_check_claim_group().
>
> There are two things which we could improve documentation-wise:
>
> 1.) Have some kernel doc  batadv_tt_local_has_timed_out - we want to
have
> kerneldoc for every new function we add.
>

Sorry, I will add that if this patch really turns out to be useful (see
2.).

> 2.) Describe the scenario in a comment in batadv_bla_rx(). I find the
comment
> not too convincing, see above.
>

As in my earlier patches I use a setup which needs bla. Up to recently I
experimented with
batman-adv-2014.4 and I struggled a lot with looping packets. At least for
version 2014.4
I found out that the patches I mailed last year where not sufficient to
prevent looping
packets between the mesh and the common Ethernet backbone completely under
all conditions. By enabling the debugging
I found that the looping packets always correlated with the claiming of
devices. I got rid of the
looping packets (error message from the kernel "received packet with own
mac address as source address")almost
completely after adding this additional patch. I now only get the kernel
error message about
receiving packets with own mac address sometimes when a mesh node is added
to the network for very few packets
which is ok for my application. But without this patch in 2014.4 I got
these messages randomly during notmal operation of the network.

I have to admit that I did not retest this with the current master or
version 2017.0.1. I simply
integrated the patch and I can at least confirm that bla works as reliable
as in the 2014.4 case with
this patch. I agree that this is no proof that this patch is still really
needed. I think I'll remove it
from=20my test setup and come back with my results.

Thanks for the feedback and best regards,
        Andreas



..................................................................
PHOENIX CONTACT ELECTRONICS GmbH

Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmont
USt-Id-Nr.: DE811742156
Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
Gesch=C3=A4ftsf=C3=BChrer / Executive Board: Ulrich Leidecker, Christoph Le=
ifer
__________________________________________________________________
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
