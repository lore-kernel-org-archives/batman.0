Return-Path: <ordex@autistici.org>
Date: Sun, 20 Nov 2011 22:16:08 +0100
From: Antonio Quartulli <ordex@autistici.org>
Message-ID: <20111120211558.GA11262@autistici.org>
References: <4EC967CC.1040804@gmail.com> <20111120210326.GA3080@ritirata.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20111120210326.GA3080@ritirata.org>
Subject: Re: [B.A.T.M.A.N.] Connecting non-batman nodes to a mesh network
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

On dom, nov 20, 2011 at 10:49:16 +0200, Panayot Daskalov wrote:
> > Hi All,
> > 
> > I want to ask for your advice about a batman problem I am facing. I have 
> > a mesh network of custom build embedded Linux devices. The devices have 
> > only network one interface and this is the Wi-Fi that is used by batman. 
> > So far the mesh is running OK, but at some point I need to be able to 
> > connect with a laptop (non-Linux) to the network and access some of the 
> > devices via its IP address. I tried simply connecting to the adhoc 
> > network and setting a static IP to my laptop. I have managed to do that, 
> > but I can't access the nodes from the mesh.
> > 
> > I read the instruction for mixing with non-batman devices by bridging 
> > the bat0 interface with the "non-batman" interface, but as far as I 
> > understand that applies to systems with at least 2 network interfaces 
> > e.g one for batman nodes and one for the non-batman. So my question is - 
> > can I mix non-batman and batman nodes when I have only one network 
> > interface on the batman nodes? If yes, then how?
> 
 Hi Panayot,
 
 you are right: you need two "interfaces" in order to let clients connect
 to the mesh. However (if you want to use wifi interfaces only) you can
 also create "virtual interaces" using the same "real interface". This
 feature is available depending on the wifi driver you are using. If you are
 using madwifi or one of the new mac80211 drivers (not all support it),
 this technique should be feasiable without introducing many problems :)
 
 For instance, what driver are you using?
 
 Cheers,
 
-- 
Antonio Quartulli

..each of us alone is worth nothing..
Ernesto "Che" Guevara ☭
