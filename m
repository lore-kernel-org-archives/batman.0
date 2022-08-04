Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: [PATCH 3/3] alfred: mismaching declarations of is_valid_ether_addr()
Date: Thu,  4 Aug 2022 20:52:12 +0200
Message-Id: <20220804185212.3074514-3-mareklindner@neomailbox.ch>
In-Reply-To: <20220804185212.3074514-1-mareklindner@neomailbox.ch>
References: <20220804185212.3074514-1-mareklindner@neomailbox.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

util.c:57:34: warning: argument 1 of type =E2=80=98uint8_t[6]=E2=80=99
   {aka =E2=80=98unsigned char[6]=E2=80=99} with mismatched bound [-Warra=
y-parameter=3D]
   57 | bool is_valid_ether_addr(uint8_t addr[ETH_ALEN])
      |                          ~~~~~~~~^~~~~~~~~~~~~~
In file included from util.c:20:
alfred.h:231:35: note: previously declared as =E2=80=98uint8_t *=E2=80=99
  {aka =E2=80=98unsigned char *=E2=80=99}
  231 | bool is_valid_ether_addr(uint8_t *addr);
      |                          ~~~~~~~~~^~~~

Signed-off-by: Marek Lindner <mareklindner@neomailbox.ch>
---
 alfred.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/alfred.h b/alfred.h
index 6fb57ce..97f0093 100644
--- a/alfred.h
+++ b/alfred.h
@@ -228,7 +228,7 @@ int time_diff(struct timespec *tv1, struct timespec *=
tv2,
 	      struct timespec *tvdiff);
 void time_random_seed(void);
 uint16_t get_random_id(void);
-bool is_valid_ether_addr(uint8_t *addr);
+bool is_valid_ether_addr(uint8_t addr[ETH_ALEN]);
 bool is_iface_disabled(char *iface);
 int ipv4_arp_request(struct interface *interface, const alfred_addr *add=
r,
 		     struct ether_addr *mac);
--=20
2.36.1
