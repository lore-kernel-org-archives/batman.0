From: Axel Neumann <axel@open-mesh.net>
Date: Thu, 31 Jan 2008 18:04:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200801311804.55291.axel@open-mesh.net>
Subject: [B.A.T.M.A.N.] IMPORTANT: batman-exp <rv972 goes crazy after 49
	days uptime
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

Hey,

I found out that the batman-exp daemon goes crazy when its internal life-time 
variable overflows. This will happen after 49 days, 17 hours, 2 minutes, and 
48 seconds (which corresponds to 2^32 milliseconds). Unfortunately, its 
behavior afterwards can be anything between hanging around and doing nothing 
and an endless loop of sending packets. The problem is fixed with revision 
972.

If you are running batman-exp I strongly suggest to update.

ciao,
axel
