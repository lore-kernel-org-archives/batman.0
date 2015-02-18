Return-Path: <APape@phoenixcontact.com>
MIME-Version: 1.0
From: Andreas Pape <APape@phoenixcontact.com>
Message-ID: <OF6F534CD3.B9570448-ONC1257DF0.00289AC2-C1257DF0.0029BB69@phoenixcontact.com>
Date: Wed, 18 Feb 2015 08:35:49 +0100
Content-Type: text/plain; charset="US-ASCII"
Subject: [B.A.T.M.A.N.] Question concerning batman-adv bug #173 "Mesh
 packets on bat0"
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

Hello everybody, 

I'm interested if there is any progress concerning the bug entry #173 (
http://www.open-mesh.org/issues/173). 

I'm currently observing something similiar on an embedded system running 
an older kernel 2.6.32.26. Batman-adv versions up to 2013.1.0 work 
flawlessly out of the box. All newer versions show the phenomenon 
described in bug #173. 
In my case I found out, that the batadv_batman_skb_recv function is never 
called again as soon as I add bat0 to the bridge interface I use. 
If I use the bat0 interface outside a bridge, everything works fine up to 
the latest version I tested (which was 2014.4.0) even with the old kernel 
version. 

Regards, 
Andreas Pape 


