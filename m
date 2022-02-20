Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH v3] alfred: introduce 'server status' IPC call
Date: Sun, 20 Feb 2022 10:20:12 +0100
Message-ID: <1889892.ZFYyhI4GPy@sven-l14>
In-Reply-To: <20220209164354.652077-1-mareklindner@neomailbox.ch>
References: <20220209164354.652077-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2787033.lrMdBXi4Pi";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

 
--nextPart2787033.lrMdBXi4Pi
Content-Type: multipart/mixed; boundary="nextPart2044400.i0DohVNyHK"; protected-headers="v1"
Content-Transfer-Encoding: 7Bit
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: [PATCH v3] alfred: introduce 'server status' IPC call
Date: Sun, 20 Feb 2022 10:20:12 +0100
Message-ID: <1889892.ZFYyhI4GPy@sven-l14>
In-Reply-To: <20220209164354.652077-1-mareklindner@neomailbox.ch>
References: <20220209164354.652077-1-mareklindner@neomailbox.ch>

This is a multi-part message in MIME format.

--nextPart2044400.i0DohVNyHK
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 9 February 2022 17:43:54 CET Marek Lindner wrote:
> The 'server status' call exports the 'mode' as well as interface
> status via IPC. Both parameters can be modified at runtime via the
> IPC and as such, the current configuration is dynamic and not
> necessarily obvious.
> 
> The server status 'request' and 'reply' packet types are added
> to allow the IPC client to initiate the status retrieval. The
> server will respond with the 'reply' message.
> 
> The information is encapsulated in TLV data chunks allowing for
> future backward compatible extension of the server status call.
> 
> Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
> ---
> v3:
>  - close client socket at the end of unix_sock_server_status()

Things I've noticed are:

* there are no safety checks for the buffer size in the server code
* the packet/tlv type definitions don't include the header (unlike the rest of 
  the code)
* version checks for the "sub tlv" types is missing

Attached is a rough sketch of potential changes.

Kind regards,
	Sven

--nextPart2044400.i0DohVNyHK
Content-Disposition: attachment; filename="include-tlv-in-packet.patch"
Content-Transfer-Encoding: 7Bit
Content-Type: text/x-patch; charset="UTF-8"; name="include-tlv-in-packet.patch"

diff --git a/client.c b/client.c
index 41ee640..6a58196 100644
--- a/client.c
+++ b/client.c
@@ -328,9 +328,9 @@ int alfred_client_change_bat_iface(struct globals *globals)
 
 int alfred_client_server_status(struct globals *globals)
 {
-	struct alfred_server_status_net_iface *status_net_iface;
-	struct alfred_server_status_bat_iface *status_bat_iface;
-	struct alfred_server_status_op_mode *status_op_mode;
+	struct alfred_server_status_net_iface_v0 *status_net_iface;
+	struct alfred_server_status_bat_iface_v0 *status_bat_iface;
+	struct alfred_server_status_op_mode_v0 *status_op_mode;
 	struct alfred_server_status_req_v0 status_req;
 	struct alfred_server_status_rep_v0 *status_rep;
 	int ret, tlvsize, headsize, len, consumed;
@@ -390,9 +390,11 @@ int alfred_client_server_status(struct globals *globals)
 			break;
 
 		status_tlv = (struct alfred_tlv *)(buf + consumed);
-		consumed += sizeof(*status_tlv);
+		if (status_tlv->version != ALFRED_VERSION)
+			break;
 
 		tlvsize = ntohs(status_tlv->length);
+		tlvsize += sizeof(*status_tlv);
 		if (len - consumed < tlvsize)
 			break;
 
@@ -401,7 +403,7 @@ int alfred_client_server_status(struct globals *globals)
 			if (tlvsize != sizeof(*status_op_mode))
 				break;
 
-			status_op_mode = (struct alfred_server_status_op_mode *)(buf + consumed);
+			status_op_mode = (struct alfred_server_status_op_mode_v0 *)(buf + consumed);
 
 			switch (status_op_mode->mode) {
 			case ALFRED_MODESWITCH_SECONDARY:
@@ -417,19 +419,19 @@ int alfred_client_server_status(struct globals *globals)
 
 			break;
 		case ALFRED_SERVER_NET_IFACE:
-			if (tlvsize != sizeof(struct alfred_server_status_net_iface))
+			if (tlvsize != sizeof(*status_net_iface))
 				break;
 
-			status_net_iface = (struct alfred_server_status_net_iface *)(buf + consumed);
+			status_net_iface = (struct alfred_server_status_net_iface_v0 *)(buf + consumed);
 			fprintf(stderr, "- interface: %s\n", status_net_iface->net_iface);
 			fprintf(stderr, "\t- status: %s\n",
 				status_net_iface->active == 1 ? "active" : "inactive");
 			break;
 		case ALFRED_SERVER_BAT_IFACE:
-			if (tlvsize != sizeof(struct alfred_server_status_bat_iface))
+			if (tlvsize != sizeof(*status_bat_iface))
 				break;
 
-			status_bat_iface = (struct alfred_server_status_bat_iface *)(buf + consumed);
+			status_bat_iface = (struct alfred_server_status_bat_iface_v0 *)(buf + consumed);
 			fprintf(stdout, "- batman-adv interface: %s\n", status_bat_iface->bat_iface);
 			break;
 		}
diff --git a/packet.h b/packet.h
index 4b6bde5..0c1a2eb 100644
--- a/packet.h
+++ b/packet.h
@@ -185,34 +185,37 @@ struct alfred_server_status_req_v0 {
 } __packed;
 
 /**
- * struct alfred_server_status_op_mode - server op mode status information
+ * struct alfred_server_status_op_mode_v0 - server op mode status information
  * @op_mode: active op mode
  *
  * Sent to the client by daemon in response to status request
  */
-struct alfred_server_status_op_mode {
+struct alfred_server_status_op_mode_v0 {
+	struct alfred_tlv header;
 	uint8_t mode;
 } __packed;
 
 /**
- * struct alfred_server_status_net_iface - server net iface status information
+ * struct alfred_server_status_net_iface_v0 - server net iface status information
  * @net_iface: configured network interface
  * @active: network interface active/inactive status info
  *
  * Sent to the client by daemon in response to status request
  */
-struct alfred_server_status_net_iface {
+struct alfred_server_status_net_iface_v0 {
+	struct alfred_tlv header;
 	char net_iface[IFNAMSIZ];
 	uint8_t active;
 } __packed;
 
 /**
- * struct alfred_server_status_bat_iface - server bat iface status information
+ * struct alfred_server_status_bat_iface_v0 - server bat iface status information
  * @op_mode: configured batman interface
  *
  * Sent to the client by daemon in response to status request
  */
-struct alfred_server_status_bat_iface {
+struct alfred_server_status_bat_iface_v0 {
+	struct alfred_tlv header;
 	char bat_iface[IFNAMSIZ];
 } __packed;
 
diff --git a/unix_sock.c b/unix_sock.c
index af5206b..b2727ad 100644
--- a/unix_sock.c
+++ b/unix_sock.c
@@ -370,29 +370,38 @@ err:
 
 static int unix_sock_server_status(struct globals *globals, int client_sock)
 {
-	struct alfred_server_status_net_iface *status_net_iface;
-	struct alfred_server_status_bat_iface *status_bat_iface;
-	struct alfred_server_status_op_mode *status_op_mode;
+	struct alfred_server_status_net_iface_v0 *status_net_iface;
+	struct alfred_server_status_bat_iface_v0 *status_bat_iface;
+	struct alfred_server_status_op_mode_v0 *status_op_mode;
 	struct alfred_server_status_rep_v0 *status_rep;
-	struct alfred_tlv *status_tlv;
 	struct interface *interface;
 	uint8_t buf[MAX_PAYLOAD];
-	int ret, len;
+	int ret = -1;
+	int len;
+
+	len = 0;
 
-	len = sizeof(*status_rep);
+	/* too large? - should never happen */
+	if (sizeof(*status_rep) + len > sizeof(buf)) {
+		fprintf(stderr, "ERROR: send buffer too small for server_status\n");
+		goto err;
+	}
 
 	status_rep = (struct alfred_server_status_rep_v0 *)buf;
 	status_rep->header.type = ALFRED_SERVER_STATUS;
 	status_rep->header.version = ALFRED_VERSION;
-	status_rep->header.length = len;
+	len += sizeof(*status_rep);
 
-	status_tlv = (struct alfred_tlv *)(buf + len);
-	status_tlv->type = ALFRED_SERVER_OP_MODE;
-	status_tlv->version = ALFRED_VERSION;
-	status_tlv->length = htons(sizeof(*status_op_mode));
-	len += sizeof(*status_tlv);
+	/* too large? - should never happen */
+	if (sizeof(*status_op_mode) + len > sizeof(buf)) {
+		fprintf(stderr, "ERROR: send buffer too small for server_status op_mode\n");
+		goto err;
+	}
 
 	status_op_mode = (struct alfred_server_status_op_mode *)(buf + len);
+	status_op_mode->header.type = ALFRED_SERVER_OP_MODE;
+	status_op_mode->header.version = ALFRED_VERSION;
+	status_op_mode->header.length = FIXED_TLV_LEN(*status_op_mode);
 
 	switch (globals->opmode) {
 	case OPMODE_SECONDARY:
@@ -408,13 +417,17 @@ static int unix_sock_server_status(struct globals *globals, int client_sock)
 	len += sizeof(*status_op_mode);
 
 	list_for_each_entry(interface, &globals->interfaces, list) {
-		status_tlv = (struct alfred_tlv *)(buf + len);
-		status_tlv->type = ALFRED_SERVER_NET_IFACE;
-		status_tlv->version = ALFRED_VERSION;
-		status_tlv->length = htons(sizeof(*status_net_iface));
-		len += sizeof(*status_tlv);
+		/* too large? - should never happen */
+		if (sizeof(*status_net_iface) + len > sizeof(buf)) {
+			fprintf(stderr, "ERROR: send buffer too small for server_status iface\n");
+			goto err;
+		}
 
 		status_net_iface = (struct alfred_server_status_net_iface *)(buf + len);
+		status_net_iface->header.type = ALFRED_SERVER_NET_IFACE;
+		status_net_iface->header.version = ALFRED_VERSION;
+		status_net_iface->header.length = FIXED_TLV_LEN(*status_net_iface);
+
 		strncpy(status_net_iface->net_iface, interface->interface,
 			sizeof(status_net_iface->net_iface));
 		status_net_iface->net_iface[sizeof(status_net_iface->net_iface) - 1] = '\0';
@@ -422,16 +435,21 @@ static int unix_sock_server_status(struct globals *globals, int client_sock)
 			status_net_iface->active = 1;
 		else
 			status_net_iface->active = 0;
+
 		len += sizeof(*status_net_iface);
 	}
 
-	status_tlv = (struct alfred_tlv *)(buf + len);
-	status_tlv->type = ALFRED_SERVER_BAT_IFACE;
-	status_tlv->version = ALFRED_VERSION;
-	status_tlv->length = htons(sizeof(*status_bat_iface));
-	len += sizeof(*status_tlv);
+	/* too large? - should never happen */
+	if (sizeof(*status_bat_iface) + len > sizeof(buf)) {
+		fprintf(stderr, "ERROR: send buffer too small for server_status op_mode\n");
+		goto err;
+	}
 
 	status_bat_iface = (struct alfred_server_status_bat_iface *)(buf + len);
+	status_bat_iface->header.type = ALFRED_SERVER_BAT_IFACE;
+	status_bat_iface->header.version = ALFRED_VERSION;
+	status_bat_iface->header.length = FIXED_TLV_LEN(*status_bat_iface);
+
 	strncpy(status_bat_iface->bat_iface, globals->mesh_iface,
 		sizeof(status_bat_iface->bat_iface));
 	status_bat_iface->bat_iface[sizeof(status_bat_iface->bat_iface) - 1] = '\0';

--nextPart2044400.i0DohVNyHK--

--nextPart2787033.lrMdBXi4Pi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmISB8wACgkQXYcKB8Em
e0YElRAA1i9u+f+8sgBKb+sAWueXVaPQeSOT2PEKZIgKZlteCa9DIWGiaK8WsfWa
yxrLtsxRx0D6spbk+j5k/wt9A3JoOzW64RqDkRhG3O5v5SHZ+bTcPyinUX8DKpeM
3v/oFpAv7HYhvS0nGoyCLvd/WVAJOEgqUgsy1g9/CUVpEwFbv6IJwFc4n6ziCwEC
8aJANy+abU79OJmsmqqnv2lXHpoGchatldCpcC/ReJ+fJuvoAtChbCqiayu42Q4A
FgKephSWal4W6u7vJfwiWyO50v+9tZf3WariB9e059HGZgRD82I+pY8tzZdxiqKN
nvWUAxrhe/kQDT0SZBtYtRjDYTtKdOZZo0dI6Dx79Zp4HGuDS8GdDKUYIRDClvIg
nXg8R1DBeDARaFAkXuGU1MsE7sJF65Skz6Me1RJqrD3EtbRTHzD7ng8Q24BnI9IS
ZXtWf0Zl+/xP/iUn96Do8Js7YIqImgYnyG2MJG3TFqdzZRqu/W+U4Ld4atNryr/1
cBIf/RZtiXhizYgC9mEYubxP8AaIHBhFrJq5FrietkvT/NDvq9kbZ2fJBhRDQzDP
5C6yavLMoJH1SYwv3QbhvTD9GgqwDoN8979FevKoR0646BtVpIsiq+Wt/op0qFt4
VCEUmGxykoQ4ufLKzZEFEDtcIoC6kT1Ka/ppUQTdR27uw+j6PCk=
=g8Br
-----END PGP SIGNATURE-----

--nextPart2787033.lrMdBXi4Pi--


