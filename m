Return-Path: <lmy19901031@gmail.com>
MIME-Version: 1.0
Date: Wed, 21 Nov 2012 14:43:33 -0500
Message-ID: <CALDpWg4kZSisvbA4DFdZSDgt0OzYgH8-dNDJE3HUm8xxeCPMeg@mail.gmail.com>
From: liu muye <lmy19901031@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.]  batman-adv: node socket communication
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
To: b.a.t.m.a.n@lists.open-mesh.org

This is Muye, I am a university student. Currently, we have a mesh
network project using B.A.T.M.A.N.

We are trying to establish wireless communication between each
B.A.T.M.A.N client so that they can share information through the mesh
network.
Specifically, we want to write an application on top of the
B.A.T.M.A.N using socket in order to transmit the data packet from one
B.A.T.M.A.N client to other B.A.T.M.A.N client. For example, unicast
or multicast.

Would you please give us some advices on how to write such
application. I have looked at the batctl ping and tcpdump source code,
but I was not able to send data packet using the similar mechanism.

We greatly appreciate any of your suggestions.
