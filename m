Return-Path: <jch@pps.jussieu.fr>
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
References: <87ipr2mjdv.fsf@trurl.pps.jussieu.fr>
	<4E270F72.10900@virtadpt.net> <7izkk8zsr4.fsf@lanthane.pps.jussieu.fr>
	<4E28392B.9020209@virtadpt.net>
Date: Thu, 21 Jul 2011 18:20:04 +0200
In-Reply-To: <4E28392B.9020209@virtadpt.net> (The Doctor's message of "Thu, 21
	Jul 2011 10:35:23 -0400")
Message-ID: <7ibown8v2j.fsf@lanthane.pps.jussieu.fr>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [B.A.T.M.A.N.] Battlemesh-like experiment in Washington, DC
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
To: drwho@virtadpt.net
Cc: b.a.t.m.a.n@open-mesh.net, Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>, babel-users@lists.alioth.debian.org

>> So are you running a DHCP forwarder on every node?  (Or are you working
>> with a layer-2 mesh, which is what Marek was alluding to?)

> Not on every node.  [...] We were working with a layer-2 mesh at the
> time.

Oh yeah, there should be no problem in a layer 2 mesh, if the mesh
implements broadcast (or hacks in some ad hoc smarts related to DHCP).
AHCP is only needed in a layer 3 mesh.

> By the way, should this particular thread really be going to the
> babel-users list?  If we're talking layer-2 we're talking BATMAN-adv,
> which is out of scope for that discussion list.

I don't think it is too outrageously off-topic.  If the respectable
recipients of this list object, we'll move to a more suitable forum.
(There's unfortunately no suitable forum for protocol-agnostic
discussions about mesh routing.)

-- Juliusz
