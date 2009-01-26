From: Marek Lindner <lindner_marek@yahoo.de>
Date: Mon, 26 Jan 2009 21:01:01 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200901270401.02271.lindner_marek@yahoo.de>
Subject: [B.A.T.M.A.N.] nat & aggregation
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


Hi,

today I submitted the first patches into the 0.3.2 branch. Some of these 
patches change the behaviour of batman:

- Aggregation is now enabled per default. We tested since a while now and 
believe it is ready for a broader test. If you experience problems with your 
routing you can disable the aggregation using the "--disable-aggregation" 
option and verify whether it is related to the aggregation or not. Please 
inform us about your experience.

- We noticed that quite some newly interested people have difficulties dealing 
with batman since it requires NAT on the internet tunnel. Therefore the NAT on 
the gate0 device will be configured by batman automatically. The iptables 
binary is called to modify the outgoing NAT rules. This should make it easier 
to get started with batman.

Regards,
Marek



