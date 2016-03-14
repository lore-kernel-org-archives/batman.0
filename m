Return-Path: <APape@phoenixcontact.com>
In-Reply-To: <9978680.AHfZt94x15@voltaire>
References: <1456652670-18226-1-git-send-email-sven@narfation.org>
 <9978680.AHfZt94x15@voltaire>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OFE8016C97.82D26F0A-ONC1257F76.003FBD12-C1257F76.00416CB9@phoenixcontact.com>
Date: Mon, 14 Mar 2016 12:54:36 +0100
content-transfer-encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: ELP - use new
 ethtool_link_get_ksettings API
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

Hi everybody,

"B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org> schrieb am
29.02.2016 03:23:42:

> Von: Marek Lindner <mareklindner@neomailbox.ch>
> An: b.a.t.m.a.n@lists.open-mesh.org
> Kopie: Antonio Quartulli <a@unstable.cc>
> Datum: 29.02.2016 03:24
> Betreff: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: ELP - use new
> ethtool_link_get_ksettings API
> Gesendet von: "B.A.T.M.A.N" <b.a.t.m.a.n-bounces@lists.open-mesh.org>
>
> On Sunday, February 28, 2016 10:44:30 Sven Eckelmann wrote:
> > From: Antonio Quartulli <a@unstable.cc>
> >
> > The ethtool API is changing in linux-4.6 and the B.A.T.M.A.N. V
> > code has to be changed accordingly.
> >
> > Fixes: 5c3245172c01 ("batman-adv: ELP - compute the metric based on
the
> > estimated throughput") Signed-off-by: Antonio Quartulli
<a@unstable.cc>
> > [sven@narfation.org: Added compat code for
__ethtool_get_link_ksettings]
> > Signed-off-by: Sven Eckelmann <sven@narfation.org>
> > ---
> > resend of "RFC v2" as patch with my Signed-off-by added
> >
> >  compat-include/linux/ethtool.h | 62
> > ++++++++++++++++++++++++++++++++++++++++++ net/batman-adv/bat_v_elp.c
  |
> > 12 ++++----
> >  2 files changed, 68 insertions(+), 6 deletions(-)
> >  create mode 100644 compat-include/linux/ethtool.h
>
> Applied in revision 3515604.
>
> Thanks,
> Marek

This patch breaks compatibility with older kernels (2.6.32 in my case ;-).

Is this intended? If I try to compile this I get

..../compat-include/linux/ethtool.h:49: error: implicit declaration of
function '__ethtool_get_settings'

I stumbled across this when I tried to update and test my patches for dat
and bla due to the feedback I received after I updated the master branch.

Kind regards,
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
