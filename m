Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 16 Jul 2009 01:37:39 +0800
References: <dd8d36130907150659v74773aw1fd1060c43ab337b@mail.gmail.com>
In-Reply-To: <dd8d36130907150659v74773aw1fd1060c43ab337b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200907160137.39536.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [vis] Remove duplicate routes from vis output
	(revised)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.net>


Revision 1271 introduced a bug on the call to hash->compare() that
caused duplicate routes to appear in the vis output.  Adapting the 
hash->compare() callback fixes the problem.

Signed-off-by: Edwe Cowley <edwecowley@gmail.com>
Signed-off-by: Marek Lindner <lindner_marek@yahoo.de>

Index: vis/vis.c
===================================================================
--- vis/vis.c	(revision 1343)
+++ vis/vis.c	(working copy)
@@ -119,8 +119,9 @@
 	return stop != 0;
 }
 
-int32_t orig_comp(void *data1, void *data2) {
-	return(memcmp(data1, data2, 4));
+int32_t orig_comp(void *data1, void *data2)
+{
+	return (memcmp(data1, data2, 4) == 0 ? 1 : 0);
 }
 
 /* hashfunction to choose an entry in a hash table of given size */

