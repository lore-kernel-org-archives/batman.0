Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH] batctl: Change/fix a throughput override function name
Date: Mon,  1 Jun 2020 22:42:03 +0200
Message-Id: <20200601204203.5505-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>

Fixes a copy and paste error in one of the function names of the
throughput override comand.

Fixes: e5e6560df828 ("batctl: Add throughput_override setting command")
Signed-off-by: Linus L=C3=BCssing <linus.luessing@c0d3.blue>
---
 throughput_override.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/throughput_override.c b/throughput_override.c
index e9f0346..13b5dce 100644
--- a/throughput_override.c
+++ b/throughput_override.c
@@ -66,7 +66,7 @@ static int print_throughput_override(struct nl_msg *msg=
, void *arg)
 	return NL_STOP;
 }
=20
-static int get_attrs_elp_isolation(struct nl_msg *msg, void *arg)
+static int get_attrs_throughput_override(struct nl_msg *msg, void *arg)
 {
 	struct state *state =3D arg;
=20
@@ -78,7 +78,8 @@ static int get_attrs_elp_isolation(struct nl_msg *msg, =
void *arg)
 static int get_throughput_override(struct state *state)
 {
 	return sys_simple_nlquery(state, BATADV_CMD_GET_HARDIF,
-				  get_attrs_elp_isolation, print_throughput_override);
+				  get_attrs_throughput_override,
+				  print_throughput_override);
 }
=20
 static int set_attrs_throughput_override(struct nl_msg *msg, void *arg)
--=20
2.27.0.rc2
