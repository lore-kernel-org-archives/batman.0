Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 12 Feb 2010 19:06:46 +0800
References: <20100208193848.GA8545@Sellars>
	<20100211022543.GA6493@Linus-Debian>
	<201002111720.16266.lindner_marek@yahoo.de>
In-Reply-To: <201002111720.16266.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GZTdL6DTPlDyTEH"
Message-Id: <201002121906.46804.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] race condition with activate_module?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

--Boundary-00=_GZTdL6DTPlDyTEH
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit

On Thursday 11 February 2010 17:20:16 Marek Lindner wrote:
> Better than introducing some locking code which would need to halt the
>  whole  module we should make sure that batman-adv does not process packets
>  before its initialization is complete.

I made a proof-of-concept patch (no testing yet) but it should illustrate what 
I was talking about. Please try it.

Cheers,
Marek

--Boundary-00=_GZTdL6DTPlDyTEH
Content-Type: text/x-patch;
  charset="UTF-8";
  name="if_num_crash.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="if_num_crash.patch"

diff --git a/batman-adv-kernelland/proc.c b/batman-adv-kernelland/proc.c
index 3f5744d..76dd4d2 100644
--- a/batman-adv-kernelland/proc.c
+++ b/batman-adv-kernelland/proc.c
@@ -115,10 +115,6 @@ static ssize_t proc_interfaces_write(struct file *instance,
 
 	hardif_add_interface(if_string, if_num);
 
-	if ((atomic_read(&module_state) == MODULE_INACTIVE) &&
-	    (hardif_get_active_if_num() > 0))
-		activate_module();
-
 	rcu_read_lock();
 	if (list_empty(&if_list)) {
 		rcu_read_unlock();
@@ -127,6 +123,11 @@ static ssize_t proc_interfaces_write(struct file *instance,
 	rcu_read_unlock();
 
 	num_ifs = if_num + 1;
+
+	if ((atomic_read(&module_state) == MODULE_INACTIVE) &&
+	    (hardif_get_active_if_num() > 0))
+		activate_module();
+
 	return count;
 
 end:
@@ -453,7 +454,7 @@ static ssize_t proc_aggr_write(struct file *file, const char __user *buffer,
 		       atomic_read(&aggregation_enabled),
 		       (aggregation_enabled_tmp == 1 ? "enabled" : "disabled"),
 		       aggregation_enabled_tmp);
-		atomic_set(&aggregation_enabled, 
+		atomic_set(&aggregation_enabled,
 						(unsigned)aggregation_enabled_tmp);
 	}
 

--Boundary-00=_GZTdL6DTPlDyTEH--
