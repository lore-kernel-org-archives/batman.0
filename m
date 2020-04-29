Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH] batctl: fix endianness when reading radiotap header
Date: Wed, 29 Apr 2020 12:09:44 +0200
Message-Id: <20200429100944.1163472-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: b.a.t.m.a.n@lists.open-mesh.org
Cc: Marek Lindner <mareklindner@neomailbox.ch>

All radiotap header fields are specified in little endian byte-order.
Header length conversion is necessary on some platforms.

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 tcpdump.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcpdump.c b/tcpdump.c
index 4b9e4f6..1beace1 100644
--- a/tcpdump.c
+++ b/tcpdump.c
@@ -1144,10 +1144,10 @@ static int monitor_header_length(unsigned char *p=
acket_buff, ssize_t buff_len, i
 			return -1;
=20
 		radiotap_hdr =3D (struct radiotap_header*)packet_buff;
-		if (buff_len <=3D radiotap_hdr->it_len)
+		if (buff_len <=3D le16toh(radiotap_hdr->it_len))
 			return -1;
 		else
-			return radiotap_hdr->it_len;
+			return le16toh(radiotap_hdr->it_len);
 	}
=20
 	return -1;
--=20
2.25.1
