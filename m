Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <2546838.CaOxSCmaqC@prime>
References: <20170601085804.4756-1-apape@phoenixcontact.com>
 <2546838.CaOxSCmaqC@prime>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF4B9C9CC2.5612B965-ONC1258132.0050B1C0-C1258132.00514F1D@phoenixcontact.com>
Date: Thu, 1 Jun 2017 16:48:06 +0200
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] Antwort: Re: [PATCH] batman-adv: prevent adding of
 loop detection mac addresses to global tt
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

>
> I was thinking, if we implement it like this we may still have problems
if an
> older batman-adv version is adding the ba:be mac addresses locally.
> This could
> create a problem, because the transmitted tt table is not added
completely,
> thus the CRC will not match and will lead to a "TT request/response
loop".
>
> What do you think? Maybe we should only add it for the speedy join case,
but
> accept it if a node really added these mac addresses locally?

I'm afraid I haven't understood the speedy join mechanism / use case good
enough
to make a good proposal here, but I'm volunteering for testing if someone
else
has a better solution then my rough approach ;-)

Kind regards,
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
