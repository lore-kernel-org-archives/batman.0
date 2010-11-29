Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 29 Nov 2010 18:00:02 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201011291800.02971.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] performance patches (v2)
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
To: b.a.t.m.a.n@lists.open-mesh.org


Hi,

I continued improving the the performance patches which results in the first 
usable version. I tested it in a VM environment as well as on real hardware 
and did not encounter problematic behavior anymore. 

Changes since v1:
* code rebased on top of the trunk
* orig_node NULL pointer dereference fixed (thanks Linus)
* bcast_own / bcast_own_sum are now protected by a spinlock
* orig_node reference count had to be increased in transtable_search()

Known issues:
* bonding / alternating candidates are not secured by refcounting [see  
find_router()] - ideas welcome

Give this code a try and let me know what you find.

Regards,
Marek
