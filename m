Return-Path: <nicoechaniz@codigosur.org>
Message-ID: <507798EE.80305@codigosur.org>
Date: Fri, 12 Oct 2012 01:13:34 -0300
From: =?windows-1252?Q?Nicol=E1s_Ech=E1niz?= <nicoechaniz@codigosur.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: [B.A.T.M.A.N.] batman-adv: ap mode with isolation enabled
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

Hi folks,

I don't know if this is common knowledge, but we have been experimenting
with isolation in our mixed mode batman-adv network and got some
interesting results we'd like to share.

Here's a blog post on this matter with related graphics:
http://blog.altermundi.net/article/batman-adv-ap-mode-with-isolation-enable=
d/

Summary:
Infrastrucutre nodes tend to "confuse" batman-adv. Every client
connected to an ap will =93think=94 that it is directly connected to every
other client, which creates a mess in potential hops selection.

Turing isolation on in the AP solves the problem. Client nodes will no
longer see OGMs from other clients and will correctly show their AP as
next hop.



Would you say there are any bad side-effects to this approach?



Cheers,
NicoEch=E1niz
