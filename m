Return-Path: <asarmanow@gmail.com>
From: Alexander Sarmanow <asarmanow@gmail.com>
Subject: [PATCH v3 1/2] batctl: main: Prepare DEBUGJSON command type
Date: Thu, 13 May 2021 16:10:33 +0200
Message-Id: <20210513141034.1649576-2-asarmanow@gmail.com>
In-Reply-To: <20210513141034.1649576-1-asarmanow@gmail.com>
References: <20210513141034.1649576-1-asarmanow@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: sven@narfation.org
Cc: b.a.t.m.a.n@lists.open-mesh.org, sw@simonwunderlich.de, Alexander Sarmanow <asarmanow@gmail.com>

The introduction of JSON debug commands requires a new command type.

Signed-off-by: Alexander Sarmanow <asarmanow@gmail.com>
---
 main.c       | 14 ++++++++++----
 main.h       |  1 +
 man/batctl.8 | 15 +++++++++++++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/main.c b/main.c
index d9b63f3..1371bc0 100644
--- a/main.c
+++ b/main.c
@@ -43,6 +43,10 @@ static void print_usage(void)
 			.label = "debug tables:                                   \tdisplay the corresponding debug table\n",
 			.types = BIT(DEBUGTABLE),
 		},
+		{
+			.label = "debug JSONs:                                   \tdisplay the corresponding debug JSON\n",
+			.types = BIT(DEBUGJSON),
+		},
 	};
 	const char *default_prefixes[] = {
 		"",
@@ -67,9 +71,9 @@ static void print_usage(void)
 	char buf[64];
 	size_t i;
 
-	fprintf(stderr, "Usage: batctl [options] command|debug table [parameters]\n");
+	fprintf(stderr, "Usage: batctl [options] command|debug table|debug json [parameters]\n");
 	fprintf(stderr, "options:\n");
-	fprintf(stderr, " \t-h print this help (or 'batctl <command|debug table> -h' for the parameter help)\n");
+	fprintf(stderr, " \t-h print this help (or 'batctl <command|debug table|debug json> -h' for the parameter help)\n");
 	fprintf(stderr, " \t-v print version\n");
 
 	for (i = 0; i < sizeof(type) / sizeof(*type); i++) {
@@ -87,6 +91,7 @@ static void print_usage(void)
 				continue;
 
 			switch (cmd->type) {
+			case DEBUGJSON:
 			case DEBUGTABLE:
 			case SUBCOMMAND_MIF:
 				prefixes = meshif_prefixes;
@@ -167,7 +172,8 @@ static const struct command *find_command(struct state *state, const char *name)
 		/* fall through */
 	case SP_MESHIF:
 		types |= BIT(SUBCOMMAND_MIF) |
-			 BIT(DEBUGTABLE);
+			 BIT(DEBUGTABLE)     |
+			 BIT(DEBUGJSON);
 		break;
 	case SP_VLAN:
 		types = BIT(SUBCOMMAND_VID);
@@ -380,7 +386,7 @@ int main(int argc, char **argv)
 	cmd = find_command(&state, argv[0]);
 	if (!cmd) {
 		fprintf(stderr,
-			"Error - no valid command or debug table specified: %s\n",
+			"Error - no valid command or debug table/JSON specified: %s\n",
 			argv[0]);
 		goto err;
 	}
diff --git a/main.h b/main.h
index 81b7a27..f5f00d2 100644
--- a/main.h
+++ b/main.h
@@ -69,6 +69,7 @@ enum command_type {
 	SUBCOMMAND_VID,
 	SUBCOMMAND_HIF,
 	DEBUGTABLE,
+	DEBUGJSON,
 };
 
 struct state {
diff --git a/man/batctl.8 b/man/batctl.8
index d490100..b2abedc 100644
--- a/man/batctl.8
+++ b/man/batctl.8
@@ -27,11 +27,11 @@
 .SH NAME
 batctl \- B.A.T.M.A.N. advanced control and management tool
 .SH SYNOPSIS
-.B batctl [\fIoptions\fP]\ \fIcommand\fP|\fIdebug\ table\fP\ [\fIparameters\fP]
+.B batctl [\fIoptions\fP]\ \fIcommand\fP|\fIdebug\ table\fP|\fIdebug\ JSON\fP\ [\fIparameters\fP]
 .br
 .SH DESCRIPTION
 batctl offers a convenient way to configure the batman\-adv kernel module as well as displaying debug information
-such as originator tables, translation tables and the debug log. In combination with a bat\-hosts file batctl allows
+such as originator tables/JSON, translation tables/JSON and the debug log. In combination with a bat\-hosts file batctl allows
 the use of host names instead of MAC addresses.
 .PP
 B.A.T.M.A.N. advanced operates on layer 2. Thus all hosts participating in the virtual switched network are transparently
@@ -294,6 +294,17 @@ List of debug tables:
 .RE
 .RE
 .br
+.br
+.PP
+.I \fBdebug JSONs:
+.IP
+The batman-adv kernel module comes with a variety of debug JSONs containing various information about the state of the mesh
+seen by each individual node.
+
+.RS 7
+List of debug JSONs:
+.RE
+.br
 .IP "[\fBmeshif <netdev>\fP] \fBtranslate\fP|\fBt\fP \fBMAC_address\fP|\fBbat\-host_name\fP|\fBhost_name\fP|\fBIP_address\fP"
 
 Translates a destination (hostname, IP, MAC, bat_host-name) to the originator
-- 
2.25.1

