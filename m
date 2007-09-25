Message-ID: <20070925091716.ummlm5rfkgs8000o@webmail.ddmesh.de>
Date: Tue, 25 Sep 2007 09:17:16 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] batmand terminates silently
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
To: "Open-Mesh, Mailinglist" <b.a.t.m.a.n@open-mesh.net>

Hello Axel,


few weeks agoe I had sometimes the problem that batmand (experimental) exits
silently. Today I found maybe one reason for this.
When you have batman running and insert the iptable rule

iptables -I OUTPUT -o eth1 -j DROP


batmand exits. This also happen for additional interfaces controlled
by batmand.

Maybe it helps you a little.

Regards, Stephan
