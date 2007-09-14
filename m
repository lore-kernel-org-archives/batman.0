Message-ID: <46EA5834.6030703@ddmesh.de>
Date: Fri, 14 Sep 2007 11:45:24 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] running batman as non-root
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

Hi,

I'm running batman (experimental) on a debian linux as root but want to
access the debug levels (batmand -c -b -d 1) from within a apache that
is not running as root.

batman actually checks the user id and does not allow to run as non-root
users. also when I disable the check, batman can not access the
/var/run/batman.socket except when I change the access modes from
command line.
but after each start of batman, the access rights are restricted to root.

Is it possible to also support non root access for batmand -c -b -d 1?

Regards
 Stephan


