From: Marek Lindner <lindner_marek@yahoo.de>
Date: Wed, 21 Feb 2007 13:35:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200702211335.40405.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] Announcement: batman 0.1.2 released
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


Hi,

today we release a bugfix and stability release for the 0.1.x branch.
We fixed the following problems:

- routing table manipulation bug fixed (some routes towards HNA were not 
properly set)
- crash while using "-p" fixed
- several race conditions removed (regarding UDP tunnel setup) 

As the *BSD and MacOS X is stopped for now the Big Endian / Little Endian 
support was backported from the 0.2 branch. 

Special thanks to Lui for providing access to his hostile testing environment 
and endless patience with us.  ;-)


You can get the sources and precompiled mips / arm binaries from 
open-mesh.net.

Regards,
Marek
