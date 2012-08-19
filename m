Return-Path: <dominicfollett@gmail.com>
MIME-Version: 1.0
Date: Sun, 19 Aug 2012 17:13:28 +0200
Message-ID: <CA+h5Vgrcu=R7odK4av7cVs9Ov7+ZSXf0SgPM7riJ2HRpyYUvHA@mail.gmail.com>
From: Dominic Follett-Smith <dominicfollett@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [B.A.T.M.A.N.] editing the routing information
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
To: "b.a.t.m.a.n@lists.open-mesh.org" <b.a.t.m.a.n@lists.open-mesh.org>

Hi all,

I am using the batmand release and I trying to edit where batman keeps
a statistic of next best hops to a destination node. I want to change
the metric in some way to alter the choices that batman makes when
routing a packet to its destination. However I am rather stuck, and
would appreciate some direction on where the updating of this
statistic of next best hops for a destination is done in the batman
code.

Many Thanks
Dominic
