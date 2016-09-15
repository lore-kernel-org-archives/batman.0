Return-Path: <apape@phoenixcontact.com>
From: Andreas Pape <apape@phoenixcontact.com>
Message-ID: <1473928860-30519-1-git-send-email-apape@phoenixcontact.com>
Date: Thu, 15 Sep 2016 10:41:00 +0200
content-transfer-encoding: quoted-printable
content-type: text/plain; charset="utf-8"
Subject: [B.A.T.M.A.N.] [PATCH] batctl: optchar variable uses wrong type
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

The variable "optchar" used char instead of int leading to a non
working batctl tp command as the while loop parsing the tp
arguments with the getopt command is only left via the "default"
case leaving the tp subcommand unusable. Using type char also
lead to a compiler warning.

Signed-off-by: Andreas Pape <apape@phoenixcontact.com>
---
 tp_meter.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tp_meter.c b/tp_meter.c
index 7fe0d56..10dc2b9 100644
--- a/tp_meter.c
+++ b/tp_meter.c
@@ -395,7 +395,7 @@ int tp_meter(char *mesh_iface, int argc, char **argv)
 =09int ret =3D EXIT_FAILURE;
 =09int found_args =3D 1, read_opt =3D USE_BAT_HOSTS;
 =09uint32_t time =3D 0;
-=09char optchar;
+=09int optchar;
 =09struct nl_sock *listen_sock =3D NULL;
 =09struct tp_result result =3D {
 =09=09.error =3D 0,
--
1.7.0.4



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
