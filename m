Return-Path: <gtolon@inti.gob.ar>
Message-ID: <4F985E17.8030309@inti.gob.ar>
Date: Wed, 25 Apr 2012 17:27:03 -0300
From: gtolon@inti.gob.ar
MIME-Version: 1.0
References: <AE90C24D6B3A694183C094C60CF0A2F6026B6EF3@saturn3.aculab.com>	<AE90C24D6B3A694183C094C60CF0A2F6026B6EF4@saturn3.aculab.com>
	<20120425.140904.935584797119761625.davem@davemloft.net>
In-Reply-To: <20120425.140904.935584797119761625.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Traffic Control in batman-adv
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

Hi,

We are doing some tests with Traffic Control (tc) in routers with 
Openwrt running batman-adv, want to be able to share the bandwidth with 
some degree of fairness between users, so we think that SFQ could help, 
differentiating the flows depending on ip addresses and ports.

The problem is that when adding the SFQ qdisc to the wireless interface 
managed by batman it doesn't work as expected. We tested the SFQ in 
other configurations and it worked fine, in full queues, the dropped 
packets affected the big flows, allowing the others to pass, but in the 
interface managed by batman-adv when packets are dropped, the result 
affects all flows almost equally. We thought this could be related with 
the bridge we use to connect the batman with the non-batman interfaces, 
but in a wireless Acces Point bridged to bat0 it also worked fine. Maybe 
it's related with the way bat0 works with it's managed interface? We'd 
appreciate any advices. Thanks in advance!

Gabriel
