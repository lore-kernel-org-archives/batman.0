Return-Path: <daniele.furlan@gmail.com>
MIME-Version: 1.0
Date: Thu, 17 Nov 2011 16:15:42 +0100
Message-ID: <CAG7VhQTrx1nvuH2ZXRbenSuwAqE7RyW=r9WoWrH+ubs6+aP56g@mail.gmail.com>
From: Daniele Furlan <daniele.furlan@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] [PATCH 0/5] Loop-freness for B.A.T.M.A.N.
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

This series of patches introduce a correction in tq metric and forwarding
 rules of ogm packets.

 In the current configuration routing loops scenario can emerge due to some
 conceptual errors such the global tq window and the forwarding of ogm comi=
ng
 from sub-optimal paths substituting ogm tq with the average of current
 router. An example scenario has been realized also in simulation using qem=
u.

 Can be demonstrated as already done for DSDV[1], that is a protocol very
 similar to batman, that a proper forwarding policy together with a strict
 control on metric monotonicity (as suggested in [2]) are sufficient to
 guarantee loop-freeness for the protocol.

 I apologize in advance if the source style is not the best possible,
 but I hope that the ideas will applied after a phase of code revision.

 Cheers,
 Daniele Furlan

 [1] C. Perkins, P. Bhagwat, =94Highly-dynamic destination-sequenced
distance-vector
     routing (DSDV) for mobile computers=94, Proc. SIGCOMM =9294, pp. 234-2=
44
 [2] Y. Yang, J. Wang, R. Kravets, =94Designing routing metrics for mesh
networks=94, In
     WiMesh, 2005.
