Return-Path: <bjo@nord-west.org>
Message-ID: <1439848023.1458.15.camel@nord-west.org>
From: Bjoern Franke <bjo@nord-west.org>
Date: Mon, 17 Aug 2015 23:47:03 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [B.A.T.M.A.N.] Kernel crashes when using more than one interface in
	bat0
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

Hi,

we are using batman-adv in our Freifunk network for meshing over
several interfaces. The nodes are connected to vpn-servers via fastd,
the vpn-servers are connected via tincd or gretap.

When we put the fastd-interface and the tinc (or gretap)-inteface into
bat0, the kernel crashes after some time.  With 2013.4, no crashes
occured, but since the update to 2014.3 the issue happens sometimes
after 5 minutes, sometimes after 3 days. Upgrading to 2015.1 did not
solve the problem, it seems the crashes occur more often then.

Unfornately we have no logs now, because after the crashes no ssh
-access to the servers are possible.

nc / mm / bl are set disabled and seem to have no effect on this issue.

Regards
Bjoern
-- 
xmpp bjo@schafweide.org 




