Return-Path: <ordex@autistici.org>
From: Antonio Quartulli <ordex@autistici.org>
Date: Thu, 15 Aug 2013 23:05:55 +0200
Message-Id: <1376600755-544-1-git-send-email-ordex@autistici.org>
In-Reply-To: <1376595170-506-1-git-send-email-ordex@autistici.org>
References: <1376595170-506-1-git-send-email-ordex@autistici.org>
Subject: [B.A.T.M.A.N.] [PATCHv2] batman-adv: check if a softif_vlan already
	exists
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
Cc: Antonio Quartulli <antonio@open-mesh.com>

From: Antonio Quartulli <antonio@open-mesh.com>

Before creating a new softif_vlan it is better to check if
that does already exist.
If so batman-adv should refuse to create a new structure
otherwise this would lead to an inconsistent state.

Normally this is not a problem because the operating system
will prevent from creating the same vlan twice, but some
ancient kernels exhibited an improper behaviour that led to
a bug.

Introduced by 952cebb57518ec18dfdebfcb2b85539f58f20779
("batman-adv: add per VLAN interface attribute framework")

Reported-by: Simon Wunderlich <simon.wunderlich@s2003.tu-chemnitz.de>
Signed-off-by: Antonio Quartulli <antonio@open-mesh.com>
---

however I don't know if returning -EEXIST will make ifconfig happy..it may be
that we simply have to return 0 and silently ignore the problem..
let's see :)

cheers,

changes from v1:
- fixed refcounting

 soft-interface.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/soft-interface.c b/soft-interface.c
index d018c49..bafc811 100644
--- a/soft-interface.c
+++ b/soft-interface.c
@@ -450,6 +450,12 @@ int batadv_softif_create_vlan(struct batadv_priv *bat_priv, unsigned short vid)
 	struct batadv_softif_vlan *vlan;
 	int err;
 
+	vlan = batadv_softif_vlan_get(bat_priv, vid);
+	if (vlan) {
+		batadv_softif_vlan_free_ref(vlan);
+		return -EEXIST;
+	}
+
 	vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
 	if (!vlan)
 		return -ENOMEM;
-- 
1.8.1.5

