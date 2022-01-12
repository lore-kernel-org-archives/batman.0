Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH 3/3] alfred: properly initialize stack buffer before sending
 over unix socket
Date: Wed, 12 Jan 2022 22:05:06 +0100
Message-Id: <20220112210506.3488775-3-mareklindner@neomailbox.ch>
In-Reply-To: <20220112210506.3488775-1-mareklindner@neomailbox.ch>
References: <10410848.OOsao9LFFs@rousseau>
 <20220112210506.3488775-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
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

Without explicitely initializing the buffer with null bytes, the stack
variables may contain process information which may be leaked when
transmitted via unix socket.
Also, the size of the variables sitting on the stack can be reduced.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/client.c b/client.c
index b5d8943..cf15ff4 100644
--- a/client.c
+++ b/client.c
@@ -35,6 +35,7 @@ int alfred_client_request_data(struct globals *globals)
 		return -1;
=20
 	len =3D sizeof(request);
+	memset(&request, 0, len);
=20
 	request.header.type =3D ALFRED_REQUEST;
 	request.header.version =3D ALFRED_VERSION;
@@ -184,6 +185,7 @@ int alfred_client_modeswitch(struct globals *globals)
 		return -1;
=20
 	len =3D sizeof(modeswitch);
+	memset(&modeswitch, 0, len);
=20
 	modeswitch.header.type =3D ALFRED_MODESWITCH;
 	modeswitch.header.version =3D ALFRED_VERSION;
@@ -260,6 +262,7 @@ int alfred_client_change_interface(struct globals *gl=
obals)
 	}
=20
 	len =3D sizeof(change_interface);
+	memset(&change_interface, 0, len);
=20
 	change_interface.header.type =3D ALFRED_CHANGE_INTERFACE;
 	change_interface.header.version =3D ALFRED_VERSION;
@@ -308,6 +311,7 @@ int alfred_client_change_bat_iface(struct globals *gl=
obals)
 	}
=20
 	len =3D sizeof(change_bat_iface);
+	memset(&change_bat_iface, 0, len);
=20
 	change_bat_iface.header.type =3D ALFRED_CHANGE_BAT_IFACE;
 	change_bat_iface.header.version =3D ALFRED_VERSION;
--=20
2.32.0.rc0
