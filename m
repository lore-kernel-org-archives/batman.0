Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <2279019.udanyR4lfT@bentobox>
References: <20160226141638.169e15ae@ubuntu> <2279019.udanyR4lfT@bentobox>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF34C428B5.B1B9DB61-ONC1257F66.00389705-C1257F66.003D570A@phoenixcontact.com>
Date: Sat, 27 Feb 2016 12:10:00 +0100
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
Subject: [B.A.T.M.A.N.] Antwort: Re: [Patchv2 0/7] batman-adv: Optimizations
 for setups running dat and bla
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

Sven Eckelmann <sven@narfation.org> schrieb am 26.02.2016 17:20:54:

> See my other comments directly to the patches. Please try to set the
> in-reply-to of the patches to the message-id of the cover letter.
Otherwise
> the messages aren't correctly threaded on the mailinglist [1].
>

Is there a way to generate the cover letter also with git send-email? As I
did
not know how to generate it, I used claws as a separate e-mail client.

> And you can set the version number of the patch directly using
> git-format-patch:
>
>     git format-patch -v 2 origin/master
>
> I haven't done the complete build_test run but at least a quick test
against
> 4.4 only. The result is attached.
>
> Kind regards,
>    Sven
>

I used checkpatch.pl of linux 4.5 rc5 and checked each patch seperately
without open
issues. These things with bracket alignment etc. start driving me crazy.
Looks as if I don't
use a proper editor. Can you recommend one to use before sending patches?

>
> [1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2016-February/
> thread.html
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
