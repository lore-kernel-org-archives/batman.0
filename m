Return-Path: <andrew@lunn.ch>
From: Andrew Lunn <andrew@lunn.ch>
Date: Wed,  2 Oct 2013 18:25:51 +0200
Message-Id: <1380731152-17874-1-git-send-email-andrew@lunn.ch>
Subject: [B.A.T.M.A.N.] [PATCHv1] GPS distribution via Alfred
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
To: siwu@hrz.tu-chmnitz.de, sven@open-mesh.com
Cc: Janne.Paatero@ruag.com, b.a.t.m.a.n@lists.open-mesh.org

Hi Folks

I'm working on a mesh project with some nodes which are nomadic.  I
need to know the location of each node, so i can do map overlays. So
these nomadic nodes have GPS and i'm distributing the location
information over Alfred, with a new server/client binary. I also have
stationary nodes, and a simulation system, without GPS, so i have
support for passing location via the command line.

The code needs some more testing, a man page, but release early,
release often, so here it is. 

Comment welcome.

	Andrew

Andrew Lunn (1):
  alfred: Add support for passing location information over alfred.

 CHANGELOG          |   3 +
 Makefile           |  24 ++-
 README             |  52 +++++-
 gpsd/Makefile      |  81 ++++++++
 gpsd/alfred-gpsd.c | 529 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 gpsd/alfred-gpsd.h | 102 +++++++++++
 6 files changed, 784 insertions(+), 7 deletions(-)
 create mode 100644 gpsd/Makefile
 create mode 100644 gpsd/alfred-gpsd.c
 create mode 100644 gpsd/alfred-gpsd.h

-- 
1.8.4.rc3

