Message-ID: <20080428220906.zpzwi7piosoogo88@webmail.ddmesh.de>
Date: Mon, 28 Apr 2008 22:09:06 +0200
From: Freifunk Dresden <freifunk@ddmesh.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] batmand-ex: inactive interfaces
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

HI,

I'm running batman-experimental rev1023. If I have an working  
interface which is  deactivated (vpn restart) and activated later,  
then batmand first detects and
ignores this interface but does not try to use the inteface again.
I have to restart batmand with same interfaces and parameter. Within  
seconds the
other nodes are recognized.

Is there a way that the inactive interfaces are reactivated and used  
automatically?
/Stephan


