Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <4170150.MY2kasJMNI-2016-02-25-13-51-36@bentobox>
References: <1456381687-29637-1-git-send-email-apape@phoenixcontact.com>
 <4170150.MY2kasJMNI-2016-02-25-13-51-36@bentobox>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFF77AFE43.E83B8DC0-ONC1257F64.0046B45F-C1257F64.00480579@phoenixcontact.com>
Date: Thu, 25 Feb 2016 14:06:39 +0100
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
Subject: [B.A.T.M.A.N.] Antwort: Re: [PATCH 1/7] batman-adv: prevent
 multiple ARP replies sent by gateways if dat enabled
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
Cc: b.a.t.m.a.n@lists.open-mesh.org

Hello Sven,

Sven Eckelmann <sven@narfation.org> schrieb am 25.02.2016 11:30:01:


> I will answer to the first patch only because this patchset doesn't have
a
> cover letter. But it is about the whole patchset.
>
> First thing: Good that you could convince the IT department that you
have to
> use git-send-email as alternative mailer.
>
> I have not checked the actual content of the patchset ("This patch
makes" in
> the commit messages looks odd) but just started the build_test [1] on
your
> patchset. It looks like your patchset doesn't build in some
configurations.
> See the attached mail for more details.
>

I wasn't aware that there is something like the build_test to be used
before
sending patches.... But I'm willing to learn.

Is there a documentation available how I can use this myself for testing
before
making another attempt to send the patches (including a cover letter)?

In my buildenvironment using an older kernel I have no issues. But of
course
I did not test every possible configuration....

> And the test run without your patches looked good [2].
>
> Kind regards,
>    Sven
>
> [1] https://git.open-mesh.org/build_test.git
> [2] https://lists.open-mesh.org/pipermail/linux-merge/2016-February/
> 002983.html
> [Anhang "build-test_andreas-pape_bla-fixes.mbox" gel=F6scht von
> Andreas Pape/Phoenix Contact] [Anhang "signature.asc" gel=F6scht von
> Andreas Pape/Phoenix Contact]


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
