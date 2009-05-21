From: Christoph Pilka <christoph.pilka@googlemail.com>
Content-Type: text/plain
Date: Thu, 21 May 2009 22:19:40 +0200
Message-Id: <1242937180.14711.14.camel@turing.asconix.lan>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] VIS server for batman-adv-kernelland
Reply-To: christoph.pilka@googlemail.com,
	The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

Hi folks,

my goal is to visualize batman-adv-kernelland network topology. 'echo
"server" > /proc/net/batman-adv/vis' activates vis server on the mesh
node directly, right? Do the other nodes find the vis server
autmagically? What happens, if I wanna use more than one vis server? And
the last and most important question: is it possible to run a vis server
outside the mesh running layer 2 batman-adv? The layer 3 vis runs fine
but I have no clue how to get the visualization running on batman-adv
nodes. How to tell the vis server on the mesh nodes to output their data
to a dot-draw server (s3d) ? Lot of questions ;-)

For the German readers: I am documenting all the stuff on
http://debian.asconix.com/batman-advanced-openwrt-howto but I think, the
way I'm describing in the vis chapter is the way to get vis running in
layer3 batman, isn't it?

Greets,
Chris

-- 
"Privacy in residential applications is a desirable marketing
option." (ETSI EN 300 175-7 Ch. A6)

