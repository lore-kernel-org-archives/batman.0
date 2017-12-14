Return-Path: <carlitonueno@gmail.com>
MIME-Version: 1.0
From: Carlito Nueno <carlitonueno@gmail.com>
Date: Thu, 14 Dec 2017 12:20:48 -0800
Message-ID: <CAEUausrvG17xyN6EfAvw2PgUXz3+QPmzVTCt--eM3yi-zbvPoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [B.A.T.M.A.N.] Switch backhaul based on connection
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

Hi all,

I have nodes A, B, C.
On all nodes, wifi and lan are bridged. Also, they are all connected via mesh.

                                        |---> node B
ethernet <--> Node A <-- |
                                        | ---> node C

Node A is the exit node - connected via ethernet cable and node B and
node C are connected to A via mesh.

So, when I connect node C via ethernet, does it start using ethernet
as backhaul or still keeping mesh.

that is, when a client connects via wifi to node C, does the traffic
go via option 1 or option 2?

option 1:
client wifi <--> node C <--> mesh iface <--> node A <--> router

option 2:
client wifi <--> node C <--> ethernet eth0 <--> router

Thanks
