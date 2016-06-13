Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <7048408.piSH5dZvnO@bentobox>
References: <1465557064-24406-1-git-send-email-apape@phoenixcontact.com>
 <7048408.piSH5dZvnO@bentobox>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF0242108B.FF91E42D-ONC1257FD1.00289079-C1257FD1.002C94B2@phoenixcontact.com>
Date: Mon, 13 Jun 2016 10:06:55 +0200
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: Re: [B.A.T.M.A.N.] [PATCH v5 0/6] Optimizations for setups running
 dat and bla
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

Hi Sven,

thanks for the feedback. I just realized that I forgot to rebase the
patchset before sending it. Could this be the cause?
When I try to apply the patches locally to a fresh cloned batman-adv
repository, the patches succeeded but some hunks succeed with some
offset or fuzz only due to the missing rebase.
> Doesn't seem to apply:
>
>     $ git describe
>     v2016.2-50-g3ce003c
>     $ git am ~/bundle-11-datbla.mbox
>     Applying: batman-adv: prevent multiple ARP replies sent by
> gateways if dat enbled
>     error: patch failed: net/batman-adv/distributed-arp-table.c:43
>     error: net/batman-adv/distributed-arp-table.c: patch does not apply
>     Patch failed at 0001 batman-adv: prevent multiple ARP replies
> sent by gateways if dat enbled
>     The copy of the patch that failed is found in:
.git/rebase-apply/patch
>     When you have resolved this problem, run "git am --continue".
>     If you prefer to skip this patch, run "git am --skip" instead.
>     To restore the original branch and stop patching, run "git am
--abort".
>
> Btw. there seems to be an "a" missing in "enabled" of the Subject
> of the first patch :)
>
Will be corrected as there's another version obviously necessary ...;-)

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
