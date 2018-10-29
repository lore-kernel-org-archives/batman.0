Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 29 Oct 2018 18:05:42 +0100
Message-Id: <20181029170542.5406-1-sven@narfation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCH maint] alfred: Fix detection of own packets
 for IPv4 mode
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
Cc: Sven Eckelmann <sven@narfation.org>, Jonathan Haws <jhaws@sdl.usu.edu>

The incoming packet address is checked for a match against the local
interface addresses to avoid processing its own packets. The IPv4
implementation used the same code but only initialized 4 of the 16 bytes of
the address in the recv function. The interface initialization code in
netsock_set_interfaces set all unused bytes to zero but recv_alfred_packet
was modified to use 12 random bytes from the stack.

Both functions must work the same way and first set the address bytes to
zero and overwrite the actual used bytes with the address bytes. Otherwise,
the result of netsock_set_interfaces for own packets is random in the IPv4
implementation.

Fixes: c7da798113a2 ("alfred: IPv4 multicast distribution support.")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
Cc: Jonathan Haws <jhaws@sdl.usu.edu>
---
 recv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/recv.c b/recv.c
index 59d759c..5ff4bb5 100644
--- a/recv.c
+++ b/recv.c
@@ -416,6 +416,7 @@ int recv_alfred_packet(struct globals *globals, struct interface *interface,
 
 	packet = (struct alfred_tlv *)buf;
 
+	memset(&alfred_source, 0, sizeof(alfred_source));
 	if (globals->ipv4mode) {
 		memcpy(&alfred_source, &source4.sin_addr, sizeof(source4.sin_addr));
 	} else {
-- 
2.19.1

