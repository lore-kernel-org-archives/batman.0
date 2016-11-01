Return-Path: <jj.sarton@web.de>
From: Jean-Jacques Sarton <jj.sarton@web.de>
Message-ID: <14097889-e13c-70ae-3408-67fcf0271a96@web.de>
Date: Tue, 1 Nov 2016 15:17:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] PATCH alfred
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

I had problem with alfre which don't start. I'am using netfs.

Swen has proposed a patch which remove the batadv_interface_check()
function.
May way is an other regarding the transitional period where the
old an new feature are to be supported.

Signed-off-by: jj.sarton@t-online.de


diff --git a/batadv_query.c b/batadv_query.c
index a671b79..c8732ef 100644
--- a/batadv_query.c
+++ b/batadv_query.c
@@ -136,7 +136,7 @@ int ipv6_to_mac(const struct in6_addr *addr, struct
ether_addr *mac)
        return 0;
 }

-int batadv_interface_check(const char *mesh_iface)
+int batadv_interface_check_debugfs(const char *mesh_iface)
 {
        char full_path[MAX_PATH + 1];
        FILE *f;
@@ -166,6 +166,18 @@ int batadv_interface_check(const char *mesh_iface)
        return 0;
 }

+int batadv_interface_check(const char *mesh_iface)
+{
+       int ret = 0;
+       enable_net_admin_capability(1);
+       ret = batadv_interface_check_netlink(mesh_iface);
+       enable_net_admin_capability(0);
+
+       if ( ret < 0 )
+               return batadv_interface_check_debugfs(mesh_iface);
+       return 0;
+}
+
 static int translate_mac_debugfs(const char *mesh_iface,
                                 const struct ether_addr *mac,
                                 struct ether_addr *mac_out)
diff --git a/netlink.c b/netlink.c
index 1b5695c..ca311e7 100644
--- a/netlink.c
+++ b/netlink.c
@@ -365,3 +365,30 @@ int get_tq_netlink(const char *mesh_iface, const
struct ether_addr *mac,

        return 0;
 }
+
+int batadv_interface_check_netlink(const char *mesh_iface)
+{
+       struct get_tq_netlink_opts opts = {
+               .tq = 0,
+               .found = false,
+               .query_opts = {
+                       .err = 0,
+               },
+       };
+       int ret = 0;
+
+       memset(&opts.mac, 0, ETH_ALEN);
+
+       ret = netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
+                                  get_tq_netlink_cb, &opts.query_opts);
+       if (ret < 0)
+               return ret;
+
+       memset(&opts.mac, 0, ETH_ALEN);
+       ret = netlink_query_common(mesh_iface,  BATADV_CMD_GET_ORIGINATORS,
+                                  get_tq_netlink_cb, &opts.query_opts);
+
+       if (ret < 0)
+               return ret;
+       return 0;
+}
diff --git a/netlink.h b/netlink.h
index b08e872..9bc75a1 100644
--- a/netlink.h
+++ b/netlink.h
@@ -49,6 +49,7 @@ int translate_mac_netlink(const char *mesh_iface,
const struct ether_addr *mac,
                          struct ether_addr *mac_out);
 int get_tq_netlink(const char *mesh_iface, const struct ether_addr *mac,
                   uint8_t *tq);
+int batadv_interface_check_netlink(const char *mesh_iface);

 extern struct nla_policy batadv_netlink_policy[];

