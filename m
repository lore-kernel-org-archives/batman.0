Return-Path: <emunicio@gmail.com>
MIME-Version: 1.0
From: Esteban Municio <emunicio@gmail.com>
Date: Mon, 13 Aug 2012 18:18:43 -0500
Message-ID: <CAMVTf1gPjH6GiNy1fnoFCE3-qx42NBTZSgFafgTGBsaOW3tEcA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] Change metric and priorize links with the best
	Bandwidth
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Hi all

I'm asking myself if should be possible change the actual metric(TQ)
in batman-adv or if there is a tool to configurte it.

We are deploying a rural mesh network where the nodes generally will
be static in the same place, but maybe the links beetwen the nodes
will have a unnestable bandwidth.

So we are looking for what protocol (with any plugin) is more
efficient for our network.

Batman-adv have TQ like metric, but we would like that the nodes route
the traffic priorizing the links with best bandwith available instead
the links with best QoS. That is because finally, all the links tend
to have ETX=1 at the expense of reduce de bandwidth(reducing the
modulation and codification scheme in order to reduce looses), so the
nodes route always for the shortest path...

Is there any solution for this?Do you recommend us change to another
mesh protocol(OLSR+plugin) or another "static" protocol(ej: OSPF)? It
is possible configurate batman-adv to get the fastest route instead
the safer?
Or maybe I am not understanding something...Am I proposing a fool thing?

Thanks you

Regards

-- 
Esteban
