Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Rossier Daniel <Daniel.Rossier@heig-vd.ch>
Subject: SOO and wireless datalink protocol
Date: Tue, 21 Jun 2022 12:15:09 +0000
Message-ID: <b3f964417303409691705d54b274a30a@heig-vd.ch>
Content-Language: fr-FR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: 
 <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Dear b.a.t.m.a.n. experts,

I'm reaching batman experts because I would like to know if batman could be=
 used (or alternatives)
in the scope of our SOO framework (https://smartobject.gitlab.io/soo/).

SOO technology is usig a fully de-centralized approach where each local dev=
ice (called smart object)=20
may run one or several entities. These entities (that you can consider as p=
articular VMs) are (constantly) broadcast to their neighbours meaning that
a memory snapshot is performed, compressed and sent out (~700 KB - 2 MB). T=
he entities are self-managed in term of lifecycle.
They cannot decide where to go in the network, but they are simply broadcas=
t, and may decide to kill themselves or kill other entities
and stay resideng for further propagation (broadcast).

Smart objects are linked via WiFi and we consider any mesh tolpology of cou=
rse.

Based on such a model, we do not need any routing, we just need that each l=
ocal device broadcast their running entities to their neighbours,
which in turn do the same thing to their own neighbours, etc. Of course, we=
 need to taken into aocount "hidden nodes" and
figure out each node does not interfer with other nodes.

In this context, we develop Winenet datalink protocol which relies on unica=
st and manage a list of neighbour where each=20
neighbour becomes speaker each at his turn. We observed that using a pure b=
roadcast decreases the bandwidth and is harder to manage.

The protocol also manages hidden nodes.

We guess it is not optimal, it is working but there is still too much laten=
cy.

Do you think batman could help us to achieve this kind of broadcast in such=
 a wireless configuration?

Or would you have any suggestion to improve the system?

Many thanks for your help

Kind regards
Daniel
