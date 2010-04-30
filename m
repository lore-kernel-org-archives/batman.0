Return-Path: <andrew@lunn.ch>
Date: Fri, 30 Apr 2010 19:52:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100430175235.GH3734@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] maint tree mixup...
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: "B.A.T.M.A.N" <b.a.t.m.a.n@lists.open-mesh.net>
Cc: Marek Lindner <lindner_marek@yahoo.de>

Hi Folks

It could be i'm doing something stupid here. If so, please tell me...

I'm preparing a patchset for linux. I've run into some problems.
You can see the patches to be included here:

http://git.open-mesh.org/?p=batman-adv;a=shortlog;h=refs/heads/maint

The one which is causing me problems is:

2010-03-20 Marek Lindner batman-adv: fix aggregation timing bug

When i add this patch and then try to compile i get:

drivers/staging/batman-adv/aggregation.c:207:35: error: undefined identifier 'bat_priv'

the code being:

                    (atomic_read(&bat_priv->aggregation_enabled)))

However, if you look at the patch:

2010-04-06 Marek Lindner batman-adv: convert multiple /proc files to use sysfs

which comes about 16 days later you see:

--- a/types.h
+++ b/types.h
@@ -82,6 +82,8 @@ struct neigh_node {
 

 struct bat_priv {
        struct net_device_stats stats;
+       atomic_t aggregation_enabled;
+       struct kobject *mesh_obj;
 };

So it looks to me these patches have got out of order.....

Any ideas what happened?

    Thanks
	Andrew
