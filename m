Return-Path: <bjo@nord-west.org>
Message-ID: <1434025163.1056.73.camel@nord-west.org>
From: Bjoern Franke <bjo@nord-west.org>
Date: Thu, 11 Jun 2015 14:19:23 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Mesh hickups with 2014.3
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
Cc: freifunk-ol-dev <freifunk-ol-dev@lists.nord-west.net>

Hi,

in the last days we upgraded nearly all (~500) routers of our Freifunk
-mesh from 2013.4 to 2014.3.
The most things run fine again, but with some routers we have
connectivity issues as follows:

- gateway gets alfreddata from router
- router pingable via batctl
- ping via linklocal, ULA and public-IPv6 from gateway to router not
possible
- other routers in the same mesh can ping it via ULA etc (connected via
the same fastd-VPN)

Public-IPv6 is announced from a gateway via radvd into the mesh.

Unfortunately we are out of ideas where we can search for the reason.

Regards
bjo
 
-- 
xmpp bjo@schafweide.org 



