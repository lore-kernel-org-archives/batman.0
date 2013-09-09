Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@open-mesh.com>
Date: Mon,  9 Sep 2013 17:46:07 +0200
Message-Id: <1378741567-25152-7-git-send-email-sven@open-mesh.com>
In-Reply-To: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
References: <1378741567-25152-1-git-send-email-sven@open-mesh.com>
Subject: [B.A.T.M.A.N.] [PATCH 7/7] alfred: Allow to switch daemon between
	slave and master
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
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
Cc: Sven Eckelmann <sven@open-mesh.com>

The running daemon may need to be switched between from master to slave mode or
from slave to master mode to increase the efficiency of the data distribution
network. This must be possible during runtime to avoid the data loss during the
switch time.

Signed-off-by: Sven Eckelmann <sven@open-mesh.com>
---
 alfred.h    |  2 ++
 client.c    | 38 ++++++++++++++++++++++++++++++++++++++
 main.c      | 19 ++++++++++++++++++-
 packet.h    | 24 ++++++++++++++++++++++++
 unix_sock.c | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/alfred.h b/alfred.h
index e44919c..e931b1b 100644
--- a/alfred.h
+++ b/alfred.h
@@ -84,6 +84,7 @@ enum clientmode {
 	CLIENT_NONE,
 	CLIENT_REQUEST_DATA,
 	CLIENT_SET_DATA,
+	CLIENT_MODESWITCH,
 };
 
 struct globals {
@@ -119,6 +120,7 @@ int set_best_server(struct globals *globals);
 /* client.c */
 int alfred_client_request_data(struct globals *globals);
 int alfred_client_set_data(struct globals *globals);
+int alfred_client_modeswitch(struct globals *globals);
 /* recv.c */
 int recv_alfred_packet(struct globals *globals);
 struct transaction_head *
diff --git a/client.c b/client.c
index 2187ff2..4bc7b5c 100644
--- a/client.c
+++ b/client.c
@@ -179,3 +179,41 @@ int alfred_client_set_data(struct globals *globals)
 	unix_sock_close(globals);
 	return 0;
 }
+
+int alfred_client_modeswitch(struct globals *globals)
+{
+	unsigned char buf[MAX_PAYLOAD];
+	struct alfred_modeswitch_v0 *modeswitch;
+	int ret, len;
+
+	if (unix_sock_open_client(globals, ALFRED_SOCK_PATH))
+		return -1;
+
+	modeswitch = (struct alfred_modeswitch_v0 *)buf;
+	len = sizeof(*modeswitch);
+
+	modeswitch->header.type = ALFRED_MODESWITCH;
+	modeswitch->header.version = ALFRED_VERSION;
+	modeswitch->header.length = htons(len - sizeof(modeswitch->header));
+
+	switch (globals->opmode) {
+	case OPMODE_SLAVE:
+		modeswitch->mode = ALFRED_MODESWITCH_SLAVE;
+		break;
+	case OPMODE_MASTER:
+		modeswitch->mode = ALFRED_MODESWITCH_MASTER;
+		break;
+	default:
+		fprintf(stderr, "%s: unknown opmode %u in modeswitch\n",
+			__func__, globals->opmode);
+		return -1;
+	}
+
+	ret = write(globals->unix_sock, buf, len);
+	if (ret != len)
+		fprintf(stderr, "%s: only wrote %d of %d bytes: %s\n",
+			__func__, ret, len, strerror(errno));
+
+	unix_sock_close(globals);
+	return 0;
+}
diff --git a/main.c b/main.c
index 4f39948..4cc8aa4 100644
--- a/main.c
+++ b/main.c
@@ -37,6 +37,8 @@ static void alfred_usage(void)
 	printf("  -r, --request [data type]   collect data from the network and prints\n");
 	printf("                              it on the network\n");
 	printf("  -V, --req-version           specify the data version set for -s\n");
+	printf("  -M, --modeswitch master     switch daemon to mode master");
+	printf("                   slave      switch daemon to mode slave");
 	printf("\n");
 	printf("server mode options:\n");
 	printf("  -i, --interface             specify the interface to listen on\n");
@@ -62,6 +64,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 		{"master",	no_argument,		NULL,	'm'},
 		{"help",	no_argument,		NULL,	'h'},
 		{"req-version", required_argument,	NULL,	'V'},
+		{"modeswitch",  required_argument,	NULL,	'M'},
 		{"version",	no_argument,		NULL,	'v'},
 		{NULL,		0,			NULL,	0},
 	};
@@ -81,7 +84,7 @@ static struct globals *alfred_init(int argc, char *argv[])
 
 	time_random_seed();
 
-	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:", long_options,
+	while ((opt = getopt_long(argc, argv, "ms:r:hi:b:vV:M:", long_options,
 				  &opt_ind)) != -1) {
 		switch (opt) {
 		case 'r':
@@ -120,6 +123,17 @@ static struct globals *alfred_init(int argc, char *argv[])
 			}
 			globals->clientmode_version = atoi(optarg);
 			break;
+		case 'M':
+			if (strcmp(optarg, "master") == 0) {
+				globals->opmode = OPMODE_MASTER;
+			} else if (strcmp(optarg, "slave") == 0) {
+				globals->opmode = OPMODE_SLAVE;
+			} else {
+				fprintf(stderr, "bad modeswitch argument\n");
+				return NULL;
+			}
+			globals->clientmode = CLIENT_MODESWITCH;
+			break;
 		case 'v':
 			printf("%s %s\n", argv[0], SOURCE_VERSION);
 			printf("A.L.F.R.E.D. - Almighty Lightweight Remote Fact Exchange Daemon\n");
@@ -155,6 +169,9 @@ int main(int argc, char *argv[])
 	case CLIENT_SET_DATA:
 		return alfred_client_set_data(globals);
 		break;
+	case CLIENT_MODESWITCH:
+		return alfred_client_modeswitch(globals);
+		break;
 	}
 
 	return 0;
diff --git a/packet.h b/packet.h
index 57fa471..8250c9c 100644
--- a/packet.h
+++ b/packet.h
@@ -66,6 +66,7 @@ struct alfred_transaction_mgmt {
  * @ALFRED_REQUEST: Packet is an alfred_request_v*
  * @ALFRED_STATUS_TXEND: Transaction was finished by sender
  * @ALFRED_STATUS_ERROR: Error was detected during the transaction
+ * @ALFRED_MODESWITCH: Switch between different operation modes
  */
 enum alfred_packet_type {
 	ALFRED_PUSH_DATA = 0,
@@ -73,6 +74,7 @@ enum alfred_packet_type {
 	ALFRED_REQUEST = 2,
 	ALFRED_STATUS_TXEND = 3,
 	ALFRED_STATUS_ERROR = 4,
+	ALFRED_MODESWITCH = 5,
 };
 
 /* packets */
@@ -119,6 +121,28 @@ struct alfred_request_v0 {
 } __packed;
 
 /**
+ * enum alfred_modeswitch_type - Mode of the daemon
+ * @ALFRED_MODESWITCH_SLAVE: see OPMODE_SLAVE
+ * @ALFRED_MODESWITCH_MASTER: see OPMODE_MASTER
+ */
+enum alfred_modeswitch_type {
+	ALFRED_MODESWITCH_SLAVE = 0,
+	ALFRED_MODESWITCH_MASTER = 1,
+};
+
+/**
+ * struct alfred_modeswitch_v0 - Request for a specific type
+ * @header: TLV header describing the complete packet
+ * @mode: data type which is requested
+ *
+ * Sent to the daemon by client
+ */
+struct alfred_modeswitch_v0 {
+	struct alfred_tlv header;
+	uint8_t mode;
+} __packed;
+
+/**
  * struct alfred_status_v0 - Status info of a transaction
  * @header: TLV header describing the complete packet
  * @tx: Transaction identificator and sequence number of packet
diff --git a/unix_sock.c b/unix_sock.c
index e6b22e8..3738d6d 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -272,6 +272,34 @@ int unix_sock_req_data_finish(struct globals *globals,
 	return ret;
 }
 
+static int unix_sock_modesw(struct globals *globals,
+			    struct alfred_modeswitch_v0 *modeswitch,
+			    int client_sock)
+{
+	int len, ret = -1;
+
+	len = ntohs(modeswitch->header.length);
+
+	if (len < (int)(sizeof(*modeswitch) - sizeof(modeswitch->header)))
+		goto err;
+
+	switch (modeswitch->mode) {
+	case ALFRED_MODESWITCH_SLAVE:
+		globals->opmode = OPMODE_SLAVE;
+		break;
+	case ALFRED_MODESWITCH_MASTER:
+		globals->opmode = OPMODE_MASTER;
+		break;
+	default:
+		goto err;
+	}
+
+	ret = 0;
+err:
+	close(client_sock);
+	return ret;
+}
+
 int unix_sock_read(struct globals *globals)
 {
 	int client_sock;
@@ -321,6 +349,11 @@ int unix_sock_read(struct globals *globals)
 					 (struct alfred_request_v0 *)packet,
 					 client_sock);
 		break;
+	case ALFRED_MODESWITCH:
+		ret = unix_sock_modesw(globals,
+				       (struct alfred_modeswitch_v0 *)packet,
+					client_sock);
+		break;
 	default:
 		/* unknown packet type */
 		ret = -1;
-- 
1.8.4.rc3

