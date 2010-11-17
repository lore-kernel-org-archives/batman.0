Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 17 Nov 2010 02:26:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201011170226.09739.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] performance patches
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

after running a series of tests I noticed that batman-adv introduces a 10-20% 
performance overhead (depending on various factors) compared standard routing. 
I could identify the orig_hash locking as the main bottleneck as code all over 
the module requires to hold the lock causing a serious slowdown. During the 
last days I worked on a set of patches meant to increase the performance by 
replacing the orig_hash lock with rcu-locking and reference counting. 

At the moment these patches are highly experimental because they fundamentally 
alter main data structures batman-adv possesses since it was first released. It 
is very likely that they will crash your system and/or introduce other funny 
behavior. However, feedback is highly appreciated due to the complex nature of 
the changes. 

Known issues:
* bonding / alternating candidates are not secured by refcounting (see  
find_router()
* bcast_own / bcast_own_sum need protection, especially in orig_hash_add_if() 
/ orig_hash_del_if()
* NULL pointer dereference when an orig_node gets purged

Cheers,
Marek
