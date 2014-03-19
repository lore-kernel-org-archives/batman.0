Return-Path: <antonio@meshcoding.com>
From: Antonio Quartulli <antonio@meshcoding.com>
Date: Wed, 19 Mar 2014 09:08:49 +0100
Message-Id: <1395216532-31099-8-git-send-email-antonio@meshcoding.com>
In-Reply-To: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
References: <1395216532-31099-1-git-send-email-antonio@meshcoding.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] [PATCHv2 next 08/11] batman-adv: adjust copyright
	disclaimer in multicast files
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
Cc: Antonio Quartulli <antonio@meshcoding.com>

The URL to the FSF address has to be always reported in the
copyright disclaimer.
This is the accepted style in the networking branch.

Introduced by e368857f66620b8483166e8e6556d9c87f9b3e71
("batman-adv: Multicast Listener Announcements via Translation Table")

Cc: Linus Lüssing <linus.luessing@web.de>
Signed-off-by: Antonio Quartulli <antonio@meshcoding.com>
---
 multicast.c | 3 +++
 multicast.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/multicast.c b/multicast.c
index b74bd18..94ba522 100644
--- a/multicast.c
+++ b/multicast.c
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include "main.h"
diff --git a/multicast.h b/multicast.h
index a76bc3a..2861899 100644
--- a/multicast.h
+++ b/multicast.h
@@ -10,6 +10,9 @@
  * WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
  * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef _NET_BATMAN_ADV_MULTICAST_H_
-- 
1.8.3.2

