Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <1725789.MhpV6G9eb2@sven-edge>
References: <20170428202610.27022-1-sw@simonwunderlich.de>
 <38318850.GE51cWUxAf@prime>
 <OFB68BD388.DE1C34EE-ONC125811C.001DD4CD-C125811C.001FA9C9@phoenixcontact.com>
 <1725789.MhpV6G9eb2@sven-edge>
MIME-Version: 1.0
Subject: Antwort: Re: [B.A.T.M.A.N.] Antwort: Re: [PATCH] batman-adv: handle
 race condition for claims also in batadv_bla_rx
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFB8426900.4E038D61-ONC125842B.002EFBE3-C125842B.002F85CC@phoenixcontact.com>
Date: Tue, 2 Jul 2019 10:39:04 +0200
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, simon wunderlich <sw@simonwunderlich.de>

Hi Sven,

sorry for my late reply, but I finally found some time for testing. I used=
=20
batman-adv version 2017.2
without this patch and I do not see any negative effects on the way bla=20
works in my testsetup.
Therefore this patch doesn't seem to make sense anymore.

Sven Eckelmann <sven@narfation.org> schrieb am 09.06.2019 13:28:24:

> Von: Sven Eckelmann <sven@narfation.org>
> An: b.a.t.m.a.n@lists.open-mesh.org
> Kopie: andreas pape <apape@phoenixcontact.com>, simon wunderlich=20
> <sw@simonwunderlich.de>
> Datum: 09.06.2019 13:28
> Betreff: Re: [B.A.T.M.A.N.] Antwort: Re: [PATCH] batman-adv: handle=20
> race condition for claims also in batadv_bla_rx
>=20
> On Wednesday, 10 May 2017 07:45:50 CEST Andreas Pape wrote:
> [...]
> > I have to admit that I did not retest this with the current master or
> > version 2017.0.1. I simply
> > integrated the patch and I can at least confirm that bla works as=20
reliable
> > as in the 2014.4 case with
> > this patch. I agree that this is no proof that this patch is still=20
really
> > needed. I think I'll remove it
> > from my test setup and come back with my results.
>=20
> What is the state of the tests?
>=20
> Kind regards,
>    Sven[Anhang "signature.asc" gel=F6scht von Andreas Pape/Pyr/DE/
> Phoenix Contact]=20

Kind regards,
Andreas



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
