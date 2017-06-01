Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <20170531142013.GD29826@otheros>
References: <OF367AF97D.9569B75C-ONC1258131.00480417-C1258131.00491EA2@phoenixcontact.com>
 <13855542.45yYzsjnKj@prime> <20170531142013.GD29826@otheros>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF89FEE322.19461B05-ONC1258132.0021BED4-C1258132.002222CC@phoenixcontact.com>
Date: Thu, 1 Jun 2017 08:12:51 +0200
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
Subject: [B.A.T.M.A.N.] Antwort: Re: MAC addresses of loop detect frames in
 global translation-table
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

> Von: Linus L=FCssing <linus.luessing@c0d3.blue>
> An: The list for a Better Approach To Mobile Ad-hoc Networking
> <b.a.t.m.a.n@lists.open-mesh.org>
> Datum: 31.05.2017 16:20
> Betreff: Re: [B.A.T.M.A.N.] MAC addresses of loop detect frames in
> global translation-table
> Gesendet von: "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>
>
> On Wed, May 31, 2017 at 03:39:23PM +0200, Simon Wunderlich wrote:
> > Hi Andreas,
> >
> > yes, those are loop detection packets. Preventing these entries
> from the local
> > translation table has been implemented only recently. We can
potentially do
> > the same for global addresses as well, it just hasn't been done so
> far ... at
> > least I don't see a reason prevening us from that. It is probably
added by
> > "speedy join" in the first place.
>
> This was the case at least for me. Andreas, do yours have the
> temporary flag set, too?
>
If I remember it correctly they are shown as "regular" MAC addresses
without any
special flags set (like any real mac address of existing devices). In the
meantime
I kick these entries in batadv_tt_global_add. But if you are interested I
could
revert my firmware and give a more precise answer.

> I'm wondering why these packets end up in the mesh in the first
> place. (Preventing things as late as in tt_gobal_add() / on
> mesh receiving nodes seems like a workaround?)
>
> Regards, Linus

Best regards, Andreas



..................................................................
PHOENIX CONTACT ELECTRONICS GmbH

Sitz der Gesellschaft / registered office of the company: 31812 Bad Pyrmont
USt-Id-Nr.: DE811742156
Amtsgericht Hannover HRB 100528 / district court Hannover HRB 100528
Gesch=E4ftsf=FChrer / Executive Board: Ulrich Leidecker, Christoph Leifer
__________________________________________________________________
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
