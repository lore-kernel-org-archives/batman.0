Message-ID: <20070723140744.ozvor890jy5cockg@webmail.ddmesh.de>
Date: Mon, 23 Jul 2007 14:07:44 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Multiple connections / prioritiy
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
To: open-mesh <b.a.t.m.a.n@open-mesh.net>

Hi Axel,

this is great and I will try it, but I can not promise to give you  
results soon because
the lack of time.
If I have multiple connections between two nodes, is there a way to  
setup the quality or
priority of those connection?
Assume I have tree or more nodes connected in a line (A,B,C,D) and  
node A and Node D are
connected via backbone tunnel over Internet, the wireless connection  
should be used until
the quality falls below a certain level or the number of nodes
exceeded a maximum value. setting up a hysteresis should be possible  
to avoid to much
switching of the route.


eth1:   A ------- B ------- C ------- D
bbs:    A ============================D

Regards
  Stephan

