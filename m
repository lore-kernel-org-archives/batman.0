Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon,  5 Dec 2011 17:56:22 +0800
Message-Id: <1323078985-1116-1-git-send-email-lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] switch routing algorithm at runtime
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

I massaged the RFC patches a little longer to integrate all the feedback
received so far. They are ready to be considered 'real' patches now.

The 'dynamically load routing kernel module' feature has not found its
way into my patchset. At this point I still see no benefit and only
complications. The mentioned reasons (kernel folks might not like it /
helps to better abstract) can be addressed in a different way (for
example asking David if he is going to accept it or not). The only 
reason seems to be "because we can". That's not enough for me.
This does not mean we can't add this feature at a later point in time
when we have the feeling it actually brings some benefits.

Here the changelog:

 * sysfs documentation added
 * changed batman iv function prefix to bat_iv
 * renamed struct bat_algo to struct bat_algo_ops
 * all bat_algo_ops callbacks are mandatory for now
 * added struct bat_algo_ops documentation
 * introduced bat_algo.h for the routing algo init calls
 * bat_algo_ops->name became a pointer
 * removed all (unnecessary) locking from bat_algo_*

Cheers,
Marek


