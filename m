Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 7 Feb 2012 17:19:21 +0800
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <201202071719.22804.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] B.A.T.M.A.N. V - the next steps
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org


Hi folks,

after having the B.A.T.M.A.N. IV routing code moved into one single file, a 
preliminary routing protocol API and an easy to use routing protocol switch it 
is time to move forward with B.A.T.M.A.N. V.

B.A.T.M.A.N. V is going to split the various tasks handled by the B.A.T.M.A.N. 
IV OGM protocol into subprotocols which will allow us to optimize each 
protocol much better. The ELP protocol is the first of these subprotocols to 
come. The initial ideas surrounding this protocol type are more than 2-3 years 
old. At some point Linus was the driving force behind the protocol 
development. Thanks to him we have proper documentation[1] as well as some 
code in his repository[2] (still called ndp). I began rebasing and integrating 
his code [3]. It will take a couple of patch series to get the API and the old 
ELP code base into shape.

Cheers,
Marek

[1] http://www.open-mesh.org/wiki/batman-adv/ELP
[2] http://git.open-mesh.org/?p=t_x/batman-adv.git;a=summary
[3] http://git.open-mesh.org/?p=marek/batman-adv.git;a=summary
