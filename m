From: Axel Neumann <axel@open-mesh.net>
Date: Thu, 3 May 2007 02:26:17 +0200
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200705030226.17511.axel@open-mesh.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Release 0.2 rc1
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hello!

Despite our optimistic presentation of the almost-stable b.a.t.m.a.n.-III-0.2b 
release,  we could not refrain from applying a number of further changes.
Besides some more bugfixes in the outputsystem, resolved crashes due to the 
hash code and lost unix-sockets, more comments in the code, 
vis-port-adaption, enhanced BDNB (bidirectional neighbor) check and finally 
the full implementation of the BNTOG (rebroadcast only packets from best 
neighbor) check, the most obvious enhancement comes with the new beautifull 
debug output.

Unfortunately the reduction of the frame size in the bidirectional link check 
from three to two did not cause the improovement (in finding better routes in 
the mesh) as we expected. Still we want to give it another try with the 
changes we implemented (for the BDNB check) in this new release.

batman-III-0.2.0rc1 is waiting on http://open-mesh.net/batman/downloads for 
your download. We appreciate your administration ;-)

happy testing,
the B.A.T.M.A.N. development team
