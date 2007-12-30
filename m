From: Marek Lindner <lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Disposition: inline
Date: Sun, 30 Dec 2007 18:06:12 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200712301806.13081.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] policy routing improved
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

after several talks with different batman users / freifunk communities it 
became clear that we need more flexibility for the policy routing. Therefore 
I implemented a new option which takes a path to a executable / shell script 
as argument (--policy-routing-script). If this option is given batmand will 
send all routing table changes to this executable instead of manipulating the 
routing table itself. The messages contain all neccessary information to 
manipulate the routing table correctly. The executable can modify the 
parameters before changing the routing table (routing tables, interfaces, 
priorities, etc) or just ignore messages.

I wrote a sample shell script which you can use as basis for your hacking:
http://downloads.open-mesh.net/batman/useful-scripts-and-tools/policy_routing_script.sh

This makes the --no-policy-routing option obsolete which was removed.
Feedback is welcome.  ;-)

Greetings,
Marek
