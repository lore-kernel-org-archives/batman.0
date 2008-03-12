Message-ID: <1205334058.47d7f02ae5c39@mail.bluebottle.com>
Date: Wed, 12 Mar 2008 15:00:58 +0000
From: Bastian Bittorf <bittorf@bluebottle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Subject: [B.A.T.M.A.N.] batman-adv / mac-addresses without leading zeros
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
To: b.a.t.m.a.n@open-mesh.net

during batch/debug-mode the output of all
mac-adresses is without leading zeros, e.g.

01:02:03:04:05:06 = 1:2:3:4:5:6

we would like to replace mac-addresses with
hostnames [1] for better understanding of
the debug-output. Would it be a great problem
to strictly output full mac-addresses?

bye, Bastian Bittorf

[1]
each router 8-) has a list with
mac = ip = hostname
