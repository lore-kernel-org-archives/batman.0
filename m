Return-Path: <gofb-b.a.t.m.a.n@m.gmane.org>
From: MK <mailing.m1@kkk-web.de>
Date: Wed, 04 Feb 2015 21:06:33 +0100
Message-ID: <matu4b$lak$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
Subject: [B.A.T.M.A.N.] running alfred as unprivileged user
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

Hi list!

Alfred daemon runs as user root in our current setup on the gateway. 

Regarding the faulty buffer size checks and improper use of strcpy in recent 
history of this software this seems to be a very bad idea.

What are the requirements for the user running alfred? Which elevated 
privileges does alfred really need? Is it possible to drop the privileges 
after setting up the interface bindings?

Thanks,
Martin

