Return-Path: <paukoning@gmail.com>
MIME-Version: 1.0
Date: Wed, 23 Jan 2013 10:03:49 +0100
Message-ID: <CANiGF98yHPxywfG99ChEF_Oa6sTJJ+sVmKmOfbV719O-06-aww@mail.gmail.com>
From: Pau Koning <paukoning@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: Re: [B.A.T.M.A.N.] Advice for dense meshes
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
To: steve@villagetelco.org
Cc: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

> I am seeking some general advice on how to optimise batman-adv in the
> context of a dense mesh.

Update to newest compat wireless
Change multicast rate to something higher like 18M/54M
Change radio distance setting to something < 300m
Increase beacon_int of all VIf to something like 5000 (5 sec) or higher
Enable sst in Adhoc (modifying source for 2.4GHz required
http://article.gmane.org/gmane.linux.kernel.wireless.general/100844 )
Increase batman-adv ogm interval to 5000 or 10000
Increase batman-adv hop penalty to to 50 or 70
