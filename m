Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 3 Aug 2011 09:52:35 +0200
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201108030952.35467.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] routing code re-organization / the road ahead
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

as some of you already know we are actively working towards the new routing 
algorithm. Since it is our fifth incarnation we named it "B.A.T.M.A.N. V". The 
major improvements focus on areas like mobility support, less overhead and 
faster network convergence. We still are in the early stages of developing the 
code and finalizing the concept. Interested parties / early birds may contact 
us to get involved. All others should wait until we issue the call for public 
testing & feedback.

In order to ensure a smooth transition and efficient testing later, we decided 
to offer a choice of routing algorithm at compile time. Those who wish to test 
the new code (once available) can choose it whereas the others can stick with 
the mature routing code base while enjoying new features / bug fixes outside 
of the routing algorithm.

As a first step into that direction I worked on a set of patches to assemble 
all B.A.T.M.A.N. IV related routing code in a single file, accessible via a 
routing algo API which will also be used by the new code.

Note: Although we have a new file (bat_iv_ogm.c) I kept the previous copyright 
information because all I did was shuffling the code around. During the 
process I renamed a few functions here and there but no code was changed.

Regards,
Marek
