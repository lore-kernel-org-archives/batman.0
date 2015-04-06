Return-Path: <alex.suykov@gmail.com>
Date: Mon, 6 Apr 2015 17:28:25 +0300
From: Alex Suykov <alex.suykov@gmail.com>
Message-ID: <cover.1428329893.git.alex.suykov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [B.A.T.M.A.N.] [PATCH v2 0/2] batctl: musl build fixes
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

batctl fails to build with musl, mostly because of somewhat weird
netinet/*.h headers musl provides, but the problem turns out to be
easy to fix.

The changes follow this series:
https://lists.open-mesh.org:443/pipermail/b.a.t.m.a.n/2015-April/012960.html
https://lists.open-mesh.org:443/pipermail/b.a.t.m.a.n/2015-April/012961.html
https://lists.open-mesh.org:443/pipermail/b.a.t.m.a.n/2015-April/012962.html
https://lists.open-mesh.org:443/pipermail/b.a.t.m.a.n/2015-April/012963.html

-- 
2.0.3

