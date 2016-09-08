Return-Path: <APape@phoenixcontact.com>
MIME-Version: 1.0
In-Reply-To: <3625422.ci9gxr4ehr@bentobox>
References: <3625422.ci9gxr4ehr@bentobox>,
 <20160905112029.32533-1-sven@narfation.org>
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF2D4839D3.5A20962C-ONC1258028.001BC953-C1258028.001C8D98@phoenixcontact.com>
Date: Thu, 8 Sep 2016 07:11:52 +0200
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Antwort: [PATCH v7 0/5] batman-adv: prevent multiple
	ARP	replies sent by gateways if dat enabled
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

Hello Sven,

thanks for updating the patchset. I am currently a little bit "cut off",
as the current batman-adv version does not compile anymore without a lot
of effort under the old kernel version I use. Therefore I started the work
of updating the kernel version on my devices. I think I will be able to
run the current batman version on my devices soon.

Am I expected to do anything else concerning the patchset? Sorry for my
lack of experience about how such an open source project works but as you
might have noticed this is the first time that I tried to contribute some
stuff.

Best regards,
Andreas


-----"B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org> schrieb: -----
An: b.a.t.m.a.n@lists.open-mesh.org
Von: Sven Eckelmann
Gesendet von: "B.A.T.M.A.N"
Datum: 05.09.2016 13:24
Betreff: [B.A.T.M.A.N.] [PATCH v7 0/5] batman-adv: prevent multiple ARP=09r=
eplies sent by gateways if dat enabled

Hi,

this should actually should have ended in the cover letter:

The v7 version is just a rebased version of v6 [1] because Marek noticed th=
at
these patches don't apply anymore.

Kind regards,
=09Sven

[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-July/015858.html


[Anhang 'signature.asc' entfernt von Andreas Pape/Phoenix Contact]


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
