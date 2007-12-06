References: <20071206023407.GA4041@apoderado.ometepe.net>
In-Reply-To: <20071206023407.GA4041@apoderado.ometepe.net>
Subject: RE: [B.A.T.M.A.N.] strange batman aborting
Date: Thu, 6 Dec 2007 12:08:43 +0100
Message-ID: <000c01c837f8$5ed76290$1c8627b0$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
From: Predrag Balorda <predrag.balorda@gmail.com>
Reply-To: pele@balorda.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
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
To: 'The list for a Better Approach To Mobile Ad-hoc Networking' <b.a.t.m.a.n@open-mesh.net>

This table full thingy could be that you are reaching your upper limit on
connections. Perhaps someone playing with bittorrent (or similar) on your
network? You either increase the maximum number of connections or you
decrease the timeout values.
Just an idea...

Pele

-----Original Message-----
From: b.a.t.m.a.n-bounces@open-mesh.net
[mailto:b.a.t.m.a.n-bounces@open-mesh.net] On Behalf Of Jan Hetges
Sent: Thursday, December 06, 2007 3:34 AM
To: b.a.t.m.a.n@open-mesh.net
Subject: [B.A.T.M.A.N.] strange batman aborting

Hi All
after two weeks uptime bmxd_rv804 just died! and not only that one, but on a
neighbouring node (~5 days uptime) as well.
So i restarted them, and about 26hrs later, they are both dead again.
So i enabled Lui's watchout4batman, maybe i see at least, which one dies
first. Only unnormal in the log:
 user.warn kernel: nf_conntrack: table full, dropping packet.
any ideas?

cheers

  --Jan

p.s. both boxes run kamikaze 7.07 i386  

