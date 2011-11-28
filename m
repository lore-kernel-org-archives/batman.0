Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 29 Nov 2011 00:27:59 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201111290028.01655.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] [RFC] batman-adv: switch routing algorithm at runtime
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


Hi folks,

after the previous discussions how to proceed with BATMAN V we came to the 
conclusion that a runtime switch for changing the routing algorithms would be 
the best solution. Hence, I drafted a couple of patches that I'd like to get 
some feedback on. Note, that these patches are not ready to be included. For 
instance, the rcu locking isn't clean.

I'd like to focus your attention towards the following items:

 * How do we design the algorithm registration. At the moment batman_init() 
calls bat_iv_init() and possibly other algorithms in the future but this is 
less than ideal. I had hoped to find a mechanism which allows an init function 
to be declared and called inside of the respective routing algorithm files. 
These files can be compiled into the module or not.

* The API and its implementation. It is highly likely that this API won't 
survive for very long as it has been designed to satisfy one routing algorithm 
only. However, changing it in the future should be easy.

* Other ideas / comments ? 

Cheers,
Marek
